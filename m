Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRCIAsF>; Thu, 8 Mar 2001 19:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbRCIAr4>; Thu, 8 Mar 2001 19:47:56 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:15094 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S130388AbRCIArg>; Thu, 8 Mar 2001 19:47:36 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103090046.f290kV607666@webber.adilger.net>
Subject: Re: lvm - lvm_map access beyond end of device
In-Reply-To: <3AA805DC.D7412B1E@mnsu.edu> from Jeffrey Hundstad at "Mar 8, 2001
 04:21:17 pm"
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Date: Thu, 8 Mar 2001 17:46:31 -0700 (MST)
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-lvm@sistina.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Hundstad writes:
> After about 27 days of uptime one of our Linux machines that is being
> used as a Samba, Netatalk, and FTP server; the main data mount went into
> a read-only state.
 [snip]
> We are mounting that 656GB disk as an EXT2 mount on /data.

As an aside, other than this problem, how do you find ext2 on such a large
filesystem?  So far this is the largest ext2 filesystem I've seen.  Are
you looking into ext3 at all to avoid fsck on crash?  Granted, in this
case you still needed to do the whole fsck but in other cases ext3 would
help.

> ...during normal use we got events in our syslog (attached), also note
> the RAID controller showed no events.  After a umount of the mounted
> filesystem, a reboot then a fsck the system worked fine.  There
> were no bad reports from the fsck.  Yes, I said no bad reports from
> fsck, it did take 3.5 hours though.  What's causing this?
> 
> Mar  8 01:15:47 files kernel: lvm - lvm_map access beyond end of device;
> *rsector: 2451636592 or size: 8 wrong for minor:  0
> Mar  8 01:15:47 files kernel: Bad lvm_map in ll_rw_block
> Mar  8 01:15:47 files kernel: EXT2-fs error (device lvm(58,0)):
> ext2_readdir: bad entry in directory #43122713: rec_len is smaller than
> minimal - offset=0, inode=0, rec_len=0, name_len=0
> Mar  8 01:15:47 files kernel: Remounting filesystem read-only
> Mar  8 01:15:48 files kernel: lvm - lvm_map access beyond end of device;
> *rsector: 2596938272 or size: 8 wrong for minor:  0
> Mar  8 01:15:48 files kernel: Bad lvm_map in ll_rw_block
> Mar  8 01:15:48 files kernel: EXT2-fs error (device lvm(58,0)):
> ext2_readdir: bad entry in directory #43122714: rec_len is smaller than
> minimal - offset=0, inode=0, rec_len=0, name_len=0
> Mar  8 01:15:48 files kernel: Remounting filesystem read-only

Is this the only output in your syslog, a representative sample, a
small part of a huge number of messages?  How often do you have this
problem, or is it the first time?

Can you verify that inodes 43122713 and 43122714 are actually valid
directories or at least valid inode numbers?  dumpe2fs -h should be
enough to tell you the number of inodes in the filesystem.

According to my calculations for your 656 GB 4kB block filesystem:

sector 2451636592 / 8 sectors/block = 306454574
sector 2596938272 / 8 sectors/block = 324617284

656 GB * 1024 MB/GB * 256 blocks/MB = 171966464 blocks

So LVM is correct in refusing to map these blocks.  The real question is
where do the block numbers come from?  The "bad entry" messages are
simply a result of LVM not filling in the buffer for ext2, and it is
all zeros.

The first point where we could have a bogus block number would be
in inode_getblk(), where we access inode->u.ext2_i.i_data[0] (the
block number here is not checked), but you say that e2fsck reported
all was well.

The below patch for 2.2.18 verifies the block numbers read from disk
before reading them.  It would at least help narrow down the problem here.

Cheers, Andreas
========================================================================
--- fs/ext2/inode.c.orig	Wed Jan 17 03:22:51 2001
+++ fs/ext2/inode.c	Thu Mar  8 17:35:33 2001
@@ -228,13 +228,20 @@
 					  int create, int new_block, int * err)
 {
 	u32 * p;
-	int tmp, goal = 0;
+	u32 tmp, goal = 0;
 	struct buffer_head * result;
 	int blocks = inode->i_sb->s_blocksize / 512;
 
 	p = inode->u.ext2_i.i_data + nr;
 repeat:
 	tmp = *p;
+	if (tmp > le32_to_cpu(EXT2_SB(inode->i_sb)->s_es->s_blocks_count)) {
+		ext2_warning(inode->i_sb, __FUNCTION__,
+			     "inode #%u has bad direct block[%d] = %u\n",
+			     inode->i_ino, nr, tmp);
+		*err = -EIO;
+		return NULL;
+	}
 	if (tmp) {
 		struct buffer_head * result;
 		result = getblk (inode->i_dev, le32_to_cpu(tmp), inode->i_sb->s_blocksize);
@@ -293,7 +301,7 @@
 					  int create, int blocksize, 
 					  int new_block, int * err)
 {
-	int tmp, goal = 0;
+	u32 tmp, goal = 0;
 	u32 * p;
 	struct buffer_head * result;
 	int blocks = inode->i_sb->s_blocksize / 512;
@@ -311,6 +319,13 @@
 	p = (u32 *) bh->b_data + nr;
 repeat:
 	tmp = le32_to_cpu(*p);
+	if (tmp > le32_to_cpu(EXT2_SB(inode->i_sb)->s_es->s_blocks_count)) {
+		ext2_warning(inode->i_sb, __FUNCTION__,
+			     "inode #%u has bad indirect block[%u][%d] = %u\n",
+			     inode->i_ino, bh->b_blocknr, nr, tmp);
+		*err = -EIO;
+		return NULL;
+	}
 	if (tmp) {
 		result = getblk (bh->b_dev, tmp, blocksize);
 		if (tmp == le32_to_cpu(*p)) {
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
