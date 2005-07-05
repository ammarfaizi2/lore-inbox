Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVGEUoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVGEUoH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 16:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVGEUoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 16:44:06 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:18630 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261787AbVGEUnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 16:43:43 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 5 Jul 2005 21:43:40 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Robert Love <rml@novell.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] Fix inotify umount hangs.
In-Reply-To: <Pine.LNX.4.60.0507051807530.1458@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0507052137210.30788@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0507042009170.7572@hermes-1.csi.cam.ac.uk>
 <1120576805.6745.197.camel@betsy> <Pine.LNX.4.60.0507051734420.1458@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0507051807530.1458@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005, Anton Altaparmakov wrote:
> On Tue, 5 Jul 2005, Anton Altaparmakov wrote:
> > On Tue, 5 Jul 2005, Robert Love wrote:
> > > On Mon, 2005-07-04 at 20:28 +0100, Anton Altaparmakov wrote:
> > > > The below patch against 2.6.13-rc1-mm1 fixes the umount hangs caused by 
> > > > inotify.
> > > 
> > > Thank you, very much, Anton, for hacking on this over the weekend.
> > 
> > You are welcome.  (-:
> > 
> > > It's definitely not the prettiest thing, but there may be no easier
> > > approach.  One thing, the messy code is working around the list
> > > changing, doesn't invalidate_inodes() have the same problem?  If so, it
> > > solves it differently.
> > 
> > It does.  It first goes over the i_sb_list and anything it finds that it 
> > is interested in (i.e. all inodes with zero i_count), it moves the inode 
> > (i_list) over to a private list (this is done in invalidate_list()).  
> > Then, when it is finished accessing the i_sb_list, and all inodes of 
> > interest (zero i_count) are on the private list, dispose_list() is called, 
> > and all inodes on the private list are exterminated.  This obviously no 
> > longer uses i_sb_list so it does not matter that that is changing now.
> > 
> > > I'm also curious if the I_WILL_FREE or i_count check fixed the bug.  I
> > > suspect the other fix did, but we probably still want this.  Or at least
> > > the I_WILL_FREE check.
> > 
> > The i_count check is at least sensible if not required (not sure) 
> > otherwise you do iget() on inode with zero i_count then waste your time 
> > looking for watches (which can't be there or i_count would not be zero), 
> > and then iput() kills off the inode and throws it out of the icache.  This 
> > would be done in invalidate_inodes() anyway, no need for you to do it 
> > first.  Even if this is not a required check it saves some cpu cycles.
> > 
> > The I_WILL_FREE is definitely required otherwise you will catch inodes 
> > that will suddenly become I_FREEING and then I_CLEAR under your feet once 
> > you drop the inode_lock and we know that is a Bad Thing (TM) as it causes 
> > the BUG_ON(i_state == I_CLEAR) in iput() to trigger that was reported 
> > before (when I got drawn into inotify in the first place).
> > 
> > Note that if you want to be really thorough you could wait on the inode 
> > to be destroyed for good:
> > 
> > if (inode->i_state & (I_FREEING|I_CLEAR|I_WILL_FREE))
> > 	__wait_on_freeing_inode(inode);
> > 
> > And then re-check in the i_sb_list if the inode is still there (e.g. via 
> > prev member of next_i->i_sb_list which will no longer be "inode" if the 
> > inode has been evicted).  If the inode is still there someone 
> > "reactivated" it while you were waiting and you need to redo the 
> > i_count and i_state checks and deal with the inode as appropriate.
> > 
> > However given this is umount we are talking about there doesn't seem to be 
> > much point in being that thorough.
> > 
> > I am not familiar enough with i_notify but _if_ it is possible for a user 
> > to get a watch on an inode which is I_FREEING|I_CLEAR|I_WILLFREE then you 
> > have to do the waiting otherwise you will miss that watch with I don't 
> > know what results but probably not good ones...
> 
> Actually given that watches increment i_count, the results would be quite 
> obvious if it were possible for this to happen.  The user would see my 
> favourite printk (see fs/super.c::generic_shutdown_super()) in dmesg! (-;
> 
> printk("VFS: Busy inodes after unmount. "
>    "Self-destruct in 5 seconds.  Have a nice day...\n");

I had a look at this and it is safe, i.e. to register a watch you need to 
open(2) a file first and you cannot do an open(2) at the point in time 
when invalidate_inodes() is called in the umount(2) code path.  And you 
cannot get that far into the umount(2) code path if a file is still open 
(you would get -EBUSY much earlier on and the umount would fail).  Thus it 
is not possible for a watch to be created when inotify_umount_inodes() is 
running.  Thus it is not necessary to wait_on_inode() wen an inodes is in 
i_state I_CLEAR|I_FREEING|I_WILL_FREE.  So my patch stands as being 
complete and sufficient for safety (AFAICS).  (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
