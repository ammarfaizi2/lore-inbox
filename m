Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263456AbVCEAhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263456AbVCEAhG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263437AbVCEAGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:06:31 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:46280 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S263396AbVCDXDm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:03:42 -0500
Date: Fri, 4 Mar 2005 15:03:26 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Andrew Morton <akpm@osdl.org>
cc: Lars Marowsky-Bree <lmb@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <mc@cs.stanford.edu>
Subject: Re: [MC] [CHECKER] Do ext2, jfs and reiserfs respect mount -o
 sync/dirsync option?
In-Reply-To: <20050304032025.119ce69e.akpm@osdl.org>
Message-ID: <Pine.GSO.4.44.0503041440030.17155-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >From a quick parse, ext2 seems to be full of MS_SYNCHRONOUS holes, and
> there might be some O_SYNC ones there as well.

I should be able to easily add O_SYNC check to FiSC.  Several questions:
1. Does O_SYNC apply to directory as well?
2. For the same file, if I open twice, once with O_SYNC and another time
without, only writes through the O_SYNC fd will be sychonous, right?
3. I open a file w/o O_SYNC, issue a bunch of writes, then call
ioctl(FIOASYNC) to set the fd sync, then issure a second set of writes.
Only the second set of writes are synchronous?

btw, man page show that O_DSYNC and O_RSYNC are just O_SYNC.  Is this true
for current linux kernel (2.6)?

> So this wild scattergun patch probably does extra work and possibly extra
> I/O all over the place, but I'd be interested if Junfeng could give it a
> quick test.   It's against 2.6.11.

I checked 2.6.11 with your patch just now.  Looks like the problem is
still there.  If you need more information, let me know.  Image is at
http://fisc.stanford.edu/bug2/crash-1.img.bz2.  Below is the output from
e2fsck.

e2fsck 1.36 (05-Feb-2005)
/dev/ide/host0/bus0/target0/lun0/part9 was not cleanly unmounted, check
forced.
Pass 1: Checking inodes, blocks, and sizes
Inode 13, i_blocks is 16, should be 2.  Fix? yes

Inode 15 is a zero-length directory.  Clear? yes

Pass 2: Checking directory structure
Entry '0005' in / (2) has deleted/unused inode 15.  Clear? yes

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Inode 2 ref count is 4, should be 3.  Fix? yes

Pass 5: Checking group summary information
Block bitmap differences:  -21
Fix? yes

Free blocks count wrong for group #0 (38, counted=39).
Fix? yes

Free blocks count wrong (38, counted=39).
Fix? yes

Inode bitmap differences:  -15
Fix? yes

Free inodes count wrong for group #0 (1, counted=2).
Fix? yes

Directories count wrong for group #0 (3, counted=2).
Fix? yes

Free inodes count wrong (1, counted=2).
Fix? yes


/dev/ide/host0/bus0/target0/lun0/part9: ***** FILE SYSTEM WAS MODIFIED
*****
/dev/ide/host0/bus0/target0/lun0/part9: 14/16 files (0.0% non-contiguous),
21/60 blocks


