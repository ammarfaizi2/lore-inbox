Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWFIIJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWFIIJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWFIIJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:09:34 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:42660 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751430AbWFIIJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:09:32 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock
	detected!
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060608112306.GA4234@elte.hu>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com>
	 <1149751953.10056.10.camel@imp.csi.cam.ac.uk>
	 <20060608095522.GA30946@elte.hu>
	 <1149764032.10056.82.camel@imp.csi.cam.ac.uk>
	 <20060608112306.GA4234@elte.hu>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 09 Jun 2006 09:09:22 +0100
Message-Id: <1149840563.3619.46.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 13:23 +0200, Ingo Molnar wrote:
> * Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> 
> > No it is not as explained above.  Something has gotten confused 
> > somewhere because the order of events is the wrong way round...
> 
> ok, next try. Find below a chronological trace of the lock acquire and 
> new dependency events leading up the the circular dependency message.
> 
> The first (mrec_lock -> runlist.lock) dependency is:
> 
>  new dependency:  (&ni->mrec_lock){--..} =>  (&rl->lock){..--}
>  [<c0104bf2>] show_trace+0x12/0x20
>  [<c0104c19>] dump_stack+0x19/0x20
>  [<c0138bc9>] __lock_acquire+0x9a9/0xde0
>  [<c013946b>] lock_acquire+0x7b/0xa0
>  [<c0134c4c>] down_read+0x2c/0x40

This locks the runlist of the MFT (i.e. mft_ni->runlist.lock).

>  [<c01c170c>] ntfs_readpage+0x83c/0x9a0
>  [<c0142f8c>] read_cache_page+0xac/0x150
>  [<c01d4f92>] map_mft_record+0x112/0x2c0

This locks the mft record of MFT (i.e. mft_ni->mrec_lock).

>  [<c01d240d>] ntfs_read_locked_inode+0x8d/0x15d0
>  [<c01d3ddb>] ntfs_read_inode_mount+0x48b/0xba0
>  [<c01e4f3b>] ntfs_fill_super+0xbfb/0x1a50
>  [<c016bf5e>] get_sb_bdev+0xde/0x120
>  [<c01e03fb>] ntfs_get_sb+0x1b/0x30
>  [<c016b583>] vfs_kern_mount+0x33/0xa0
>  [<c016b646>] do_kern_mount+0x36/0x50
>  [<c0181a4e>] do_mount+0x28e/0x640
>  [<c0181e6f>] sys_mount+0x6f/0xb0
>  [<c034233d>] sysenter_past_esp+0x56/0x8d

Let us call the above case A, and the description of case A is: mapping
the mft record of the MFT itself.  This is a special case because it is
circular, i.e. we are mapping into memory a part of a file using the
contents of the file itself.  Sound weird?  It is.  It is a catch-22
situation.  How can you read a file if you need to have read the file
already to be able read it?  (-:

The solution is ntfs_read_inode_mount().  It loads by hand using
sb_bread() the first mft record in the MFT file, i.e. mft record 0,
which is the mft record for the MFT itself.  The on-disk location is
written down in the ntfs boot sector which is already read and parsed.

Armed with that information the volume is boot strapped so that the
needed information to read the mft record for the MFT itself can be done
via reading a page into memory which is what we see above with the above
map_mft_record()->read_cache_page()->ntfs_readpage().  The bootstrapping
consists of setting up the struct inode and ntfs_inode mft_ni
appropriately and loading the runlist for the first fragment of the mft
into memory (mft_ni->runlist).  Doing this means that ntfs_readpage()
locks the runlist (mft_ni->runlist) for reading, looks up the physical
location for the first mft record, unlocks the runlist and then reads
the data from disk.  This always succeeds as we just initialized the
runlist by hand before calling map_mft_record().

ntfs_read_inode_mount() then proceeds to map all extent mft records for
the MFT in sequence (if there are any extent mft records) and to load
their runlist data into memory into mft_ni->runlist.

Thus by the time ntfs_read_inode_mount() is finished mft_ni->runlist is
completely mapped into memory and it is guaranteed to stay there until
umount time.  There are various places in the ntfs driver where we go
BUG() if we ever find an unmapped region in mft_ni->runlist.

Make sense so far?  I hope so.  (-:

> and the opposite (runlist.lock -> mrec_lock) dependency wants to get 
> created at:
> 
>  [<c0340678>] mutex_lock+0x8/0x10
>  [<c01d4ed1>] map_mft_record+0x51/0x2c0
>  [<c01c5358>] ntfs_map_runlist_nolock+0x3d8/0x530
>  [<c01c5a21>] ntfs_map_runlist+0x41/0x70
>  [<c01c1791>] ntfs_readpage+0x8c1/0x9a0
>  [<c0142f8c>] read_cache_page+0xac/0x150
>  [<c01e2562>] load_system_files+0x472/0x2250
>  [<c01e4f96>] ntfs_fill_super+0xc56/0x1a50
>  [<c016bf5e>] get_sb_bdev+0xde/0x120
>  [<c01e03fb>] ntfs_get_sb+0x1b/0x30
>  [<c016b583>] vfs_kern_mount+0x33/0xa0
>  [<c016b646>] do_kern_mount+0x36/0x50
>  [<c0181a4e>] do_mount+0x28e/0x640
>  [<c0181e6f>] sys_mount+0x6f/0xb0
>  [<c034233d>] sysenter_past_esp+0x56/0x8d

Ok, by now we are in the "normal" code paths with mft_ni->runlist fully
loaded in.  The above trace I think must be coming from
check_mft_mirror()->ntfs_map_page() which tries to read the MFT and then
the MFT mirror to compare their contents.

The driver loads the mft first but we already have the page index 0 of
the MFT thus read_cache_page() finds the page in the page cache (you can
see it happen in the long trace you sent me) so I am assuming the above
trace comes from the next ntfs_map_page() of the mft mirror page index
0.

Let me describe that one:

ntfs_map_page(mft mirror, page index 0);
-> read_cache_page();
  -> ntfs_readpage();

ntfs_readpage() take the runlist lock of the mft mirror inode whose data
is being read into the page (NTFS_I(vol->mftmirr_ino)->runlist.lock) for
reading.

It then looks up the physical location for the blocks in the first page
in the runlist.  But given we have never accessed the data in the mft
mirror inode, the runlist is not mapped into memory.  Thus
ntfs_readpage() drops the runlist lock and calls ntfs_map_runlist() to
map the runlist into memory.

ntfs_map_runlist() retakes the runlist lock for writing as it is about
to modify the in-memory runlist.  It then checks that someone else did
not map the runlist into memory whilst we waited on the lock and
assuming we still need to map it, it goes and maps the mft record for
the mft mirror inode which is the map_mft_record() we see above.

This takes the mft record lock for the mft mirror
(NTFS_I(vol->mftmirr_ino)->mrec_lock), which the lock validator
complains about.  Let us call this "normal" code path B and the
description is read data from a file that is not MFT itself.

For this we need to read the file data to do which we need to know where
it is on disk to do which we need the runlist thus we need to lock it so
a file modification (or concurrent file read causing another fragment of
the runlist to be read into memory) cannot change it under our feet.  we
then look up the physical location in the runlist and can read the data
in the common case.  In the uncommon case (first access) the in-memory
runlist does not contain the physical mapping data thus we need to map
the mft record (i.e. the on disk inode) into memory and read the runlist
from it into memory so that we can then look up the physical location of
the data in the runlist as in the common case.

Thus to summarise, there are two cases:

1)

The normal access pattern (B) where the runlist lock is always taken
first.  And the mft record lock is taken second and only if the runlist
is incomplete in-memory.

Of course on file modification, this is also the case, the runlist lock
is taken first, then the mft record lock is taken and thus both the
runlist and the inode can be updated with the new data (e.g. on a file
extend).

2)

The special access pattern (A) where the MFT record 0 itself is read for
the first time which is where the mft record lock is taken first and
then the runlist lock is taken to determine its on-disk location.

If this were a normal file, we would then need to take the mft record
lock _again_ (thus deadlock!) to load the runlist data into memory.  In
thus far the lock validator is correct.  There is a 100% certain
deadlock.

BUT we bootstrapped the runlist of the mft inode mft_ni in
ntfs_inode_read_mount() so that it always finds the physical mapping in
the runlist thus it _never_ has to lock the mft record that second time
thus the deadlock _never_ happens.

> does this trace make more sense?

Yes, makes perfect sense to me.  I hope with my descriptions above it
makes sense to you, too.  Please let me know if not.  (-:

It is not the simplest of things because of the catch-22 situation which
is why such an elaborate boot strapping is required.  But once boot
strapped IMHO it is very elegant because it means that the exact same
code is used for accessing both metadata and normal file data.

And we get to confuse the lock validator which has got to be a bonus.
(-;

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

