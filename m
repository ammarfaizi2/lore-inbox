Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWFHKyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWFHKyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWFHKyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:54:10 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:34517 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964805AbWFHKyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:54:09 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock
	detected!
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060608095522.GA30946@elte.hu>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com>
	 <1149751953.10056.10.camel@imp.csi.cam.ac.uk>
	 <20060608095522.GA30946@elte.hu>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Thu, 08 Jun 2006 11:53:52 +0100
Message-Id: <1149764032.10056.82.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Thu, 2006-06-08 at 11:55 +0200, Ingo Molnar wrote:
> * Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > [...] It perhaps is getting confused by the special case for the table 
> > of inodes ($MFT) which has the lock dependency reverse to all other 
> > inodes but it is special because it can never take the lock 
> > recursively (and hence deadlock) because we always keep the whole 
> > runlist for $MFT in memory and should a bug or memory corruption cause 
> > this not to be the case then ntfs will detect this and go BUG() so it 
> > still will not deadlock...
> 
> Please help me understand NTFS locking a bit better. As far as i can see 

Sure.

> at the moment, the NTFS locking scenario that the lock validator flagged 
> does not involve two inodes - it only involves the MFT inode itself, and 
> two of its locks.
> 
> Firstly, here is a list of the NTFS terms, locks in question:
> 
>   ni              - NTFS inode structure
> 
>   mft_ni          - special "Master File Table" inode - one per fs. 
>                     Consists of "MFT records", which describe an inode 
>                     each. (mft_ni is also called the "big inode")

Correct except big inode is just any ntfs inode that has a vfs inode
(struct inode) to go with it, i.e. a real inode visible to the vfs.
There is nothing special with the MFT inode and big inodes.  All files
have big inodes.  

The non-big inodes, are not real inodes.  They are inode extents.
Basically one inode is typically 1024 bytes so if it fills up (e.g. lots
of hard links and/or a long run list due to fragmentation and/or a huge
file) then ntfs allocates more mft records and attaches them logically
to the real inode thus you can have effectively infinite amounts of
fragmentation/lots of hard links even though an inode is just 1024 bytes
in size you just end up having lots of "extent inodes" as I call them
and in the driver this means you end up with "ntfs_inode" structures
that do not have a VFS struct inode attached to them.

>   &ni->mrec_lock  - a spinlock protecting a particular inode's MFT data. 
>                     (finegrained lock for the MFT record) It is 
>                     typically taken by map_mft_record() and released by 
>                     unmap_mft_record().

Correct, except s/spinlock/semaphore/ (that really should become a mutex
one day).

>   ni->runlist     - maps logical addresses to on-disk addresses. (There 
>                     are (two) runlists, one for normal inode data, 
>                     another for attribute space data.)

Correct.

>   &rl->lock       - ni->runlist.lock, a rw semaphore that protects the 
>                     mapping data. Read-locked on access, write-locked on 
>                     modification (extension of an inode, etc.).

Correct, except also write locked when the runlist is modified in memory
not necessarily due to write to the inode.  This occurs on first
read/write to the inode because at iget() time we do not read the
runlist into memory thus the first read/write will cause &rl->lock to be
taken for writing and the runlist will be read in.

This also happens when the file is fragmented.  Then there are multiple
runlist "fragments", each describing a portion of the data, thus you
have fragment 0 describing file offsets 0 to X, then fragment 1
describing offsets X+1 to Y, etc...  We only load into memory each
fragment as it is used, thus on a read from a file we do:

down_read(&rl->lock);
look up in the runlist the physical location
if (physical location is unknown because this runlist fragment was never
needed before) {
	up_read(&rl->lock);
	down_write(&rl->lock);
	redo the lookup to ensure no-one else mapped this fragment under our
feet and if not read it in and merge it with the existing runlist and
goto above looking up the physical location in the runlist which now
will succeed
up_read/up_write(&rl->lock);

Basically we are on-demand loading the runlist fragments.

> The MFT is loaded in-memory permanently at mount time, and its runlist 
> gives us access to NTFS inodes. Is its runlist loaded into memory 
> permanently too? An NTFS inode's runlist gives access to the actual file 
> data.

Clarification: The MFT inode is loaded at mount time and ALL its runlist
fragments are loaded and merged into one big runlist available at
mft_ni->runlist.  The mft data, i.e. the inodes themselves are not
loaded all the time.  That is what map_mft_record() does and it needs to
lookup in mft_ni->runlist where the inode to be loaded is on disk.

This last lookup of physical location in map_mft_record() [actually in
readpage as map_mft_record() reads the page cache page containing the
record] cannot require us to load an extent mft record because the
runlist is complete so we cannot deadlock here.

Your last statement is correct.  The runlist is a mapping of "file
offset" to "physical device offset".

> What the validator flagged is the following locking construct:
> 
> we first acquired the MFT's &ni->mrec_lock in map_mft_record(), at:

No, this shows acquisition of the MFTMirr &ni->mrec_lock (the mirror of
the MFT, it only contains the first few MFT records stored in the the
middle of the disk for recovery purposes).  If you look at
"fs/ntfs/super.c::load_system_files()" you will see it calls
load_and_init_mft_mirror() as the first thing which as the first thing
does: ntfs_iget(vol->sb, FILE_MFTMirr); thus it is locking the mft
record for FILE_MFTMirr which is inode 1 (whilst the MFT itself is
FILE_MFT which is inode 0).

>        [<c0340508>] mutex_lock+0x8/0x10
>        [<c01d4d61>] map_mft_record+0x51/0x2c0
>        [<c01c51e8>] ntfs_map_runlist_nolock+0x3d8/0x530
>        [<c01c58b1>] ntfs_map_runlist+0x41/0x70
>        [<c01c1621>] ntfs_readpage+0x8c1/0x9a0
>        [<c0142e1c>] read_cache_page+0xac/0x150
>        [<c01e23f2>] load_system_files+0x472/0x2250
>        [<c01e4e26>] ntfs_fill_super+0xc56/0x1a50
>        [<c016bdee>] get_sb_bdev+0xde/0x120
>        [<c01e028b>] ntfs_get_sb+0x1b/0x30
>        [<c016b413>] vfs_kern_mount+0x33/0xa0
>        [<c016b4d6>] do_kern_mount+0x36/0x50
>        [<c01818de>] do_mount+0x28e/0x640
>        [<c0181cff>] sys_mount+0x6f/0xb0
> 
> then we read-locked &rl->lock [the MFT's runlist semaphore] later in 
> map_mft_record() -> ntfs_readpage(),

But the below trace preceeds the above trace in time!  Below we see
ntfs_read_inode_mount() being called which is called _before_
load_system_files() is called... (See ntfs_fill_super() which is the
only place that calls both of those functions.)

Apart from that you are correct that we are taking the &tl->lock of the
MFT's runlist semaphore here.

> while still holding &ni->mrec_lock:

Wrong as explained above this is MFTMirr's ni->mrec_lock being held in
the above trace and it only happens later on, not earlier.

>        [<c0134c4e>] down_read+0x2e/0x40
>        [<c01c159c>] ntfs_readpage+0x83c/0x9a0
>        [<c0142e1c>] read_cache_page+0xac/0x150
>        [<c01d4e22>] map_mft_record+0x112/0x2c0
>        [<c01d229d>] ntfs_read_locked_inode+0x8d/0x15d0
>        [<c01d3c6b>] ntfs_read_inode_mount+0x48b/0xba0
>        [<c01e4dcb>] ntfs_fill_super+0xbfb/0x1a50
>        [<c016bdee>] get_sb_bdev+0xde/0x120
>        [<c01e028b>] ntfs_get_sb+0x1b/0x30
>        [<c016b413>] vfs_kern_mount+0x33/0xa0
>        [<c016b4d6>] do_kern_mount+0x36/0x50
>        [<c01818de>] do_mount+0x28e/0x640
>        [<c0181cff>] sys_mount+0x6f/0xb0
> 
> so this is a "&ni->mrec_lock => &rl->lock" dependency for the MFT, which 
> the validator recorded.

No it is not as explained above.  Something has gotten confused
somewhere because the order of events is the wrong way round...

> Then the validator also observed the reverse order. We first 
> write-locked &rl->lock (of the MFT inode):
> 
>  [<c0134c8e>] down_write+0x2e/0x50
>  [<c01c5910>] ntfs_map_runlist+0x20/0x70
>  [<c01c16a1>] ntfs_readpage+0x8c1/0x9a0
>  [<c0142e9c>] read_cache_page+0xac/0x150
>  [<c01e2472>] load_system_files+0x472/0x2250
>  [<c01e4ea6>] ntfs_fill_super+0xc56/0x1a50
>  [<c016be6e>] get_sb_bdev+0xde/0x120
>  [<c01e030b>] ntfs_get_sb+0x1b/0x30
>  [<c016b493>] vfs_kern_mount+0x33/0xa0
>  [<c016b556>] do_kern_mount+0x36/0x50
>  [<c018195e>] do_mount+0x28e/0x640
>  [<c0181d7f>] sys_mount+0x6f/0xb0

No this will be something else's inode. The first time you see the above
trace should be when MFTMirr is being read in in load_system_files()
when it calls check_mft_mirror().  The runlist of MFTMirr is at that
stage not read in yet thus it will take the runlist lock of MFTMirr's
inode for writing and read the runlist into memory.

> then we took &ni->mrec_lock [this is still the MFT inode's mrec_lock, 
> and we have the &rl->lock still held]:
> 
>  [<c0340588>] mutex_lock+0x8/0x10
>  [<c01d4de1>] map_mft_record+0x51/0x2c0
>  [<c01c5268>] ntfs_map_runlist_nolock+0x3d8/0x530
>  [<c01c5931>] ntfs_map_runlist+0x41/0x70
>  [<c01c16a1>] ntfs_readpage+0x8c1/0x9a0
>  [<c0142e9c>] read_cache_page+0xac/0x150
>  [<c01e2472>] load_system_files+0x472/0x2250
>  [<c01e4ea6>] ntfs_fill_super+0xc56/0x1a50
>  [<c016be6e>] get_sb_bdev+0xde/0x120
>  [<c01e030b>] ntfs_get_sb+0x1b/0x30
>  [<c016b493>] vfs_kern_mount+0x33/0xa0
>  [<c016b556>] do_kern_mount+0x36/0x50
>  [<c018195e>] do_mount+0x28e/0x640
>  [<c0181d7f>] sys_mount+0x6f/0xb0

Again this is the mrec_lock of the MFTMirr ntfs_inode not the MFT
ntfs_inode (mft_ni).

> this means a "&rl->lock => &ni->mrec_lock" dependency, which stands in 
> contrast with the already observed "&ni->mrec_lock => &rl->lock" 
> dependency.

Could you re-evaluate that conclusion given the above feedback?  I think
it is wrong given the inversion in time and the difference in inodes as
explained above.

> The dependencies were observed for the same locks (the MFT's runlist 
> lock and mrec_lock), i.e. this is not a confusion of normal inodes vs. 
> the MFT inode.
> 
> First and foremost, are my observations and interpretations correct? 
> Assuming that i made no mistake that invalidates my analysis, why are 
> the two MFT inode locks apparently taken in opposite order?

I think you got it wrong I am afraid.  Does what I explained above make
more sense?  In particular I am worried about the fact that you showed
two events to happen in reverse chronological order which is impossible.
(unless time flows backwards when you run your tests... (-;)

Please keep the questions coming...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

