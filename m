Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261577AbRE2Tj7>; Tue, 29 May 2001 15:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbRE2Tju>; Tue, 29 May 2001 15:39:50 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:24059 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261577AbRE2Tjb>; Tue, 29 May 2001 15:39:31 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105291938.f4TJc2iw019290@webber.adilger.int>
Subject: [PATCH][REPOST] Re: EXT2-fs error (device ide0(3,1)): read_inode_bitmap
In-Reply-To: <001901c0e84e$1948d2f0$1901a8c0@node0.idium.eu.org>
 "from David Flynn at May 29, 2001 03:46:04 pm"
To: David Flynn <Dave@keston.u-net.com>
Date: Tue, 29 May 2001 13:38:02 -0600 (MDT)
CC: linux kernel mailinglist <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
>                     Ok, this is probabally old news and has been fixed, but
> the following happened in kernel 2.4.3 (ironically when i was deleting
> /usr/src/linux in order to extract the latest 2.4.5 :-)

Old news for me, fixed this bug in January, see:

http://marc.theaimsgroup.com/?l=linux-kernel&m=98339241223296&w=4

but the whole patch did not make it into the Linus kernel (not sure
if it is in -ac or not).

> However, it has a very slight sound of a more serious problem, to do with my
> disk (however, since i know nothing about this error message, i will take no
> sides)

However, there is still a problem in the ext2 code because it does not
clear the in-memory inode on the error paths.  Patch below will fix.
Linus (and Alan, if needed), please apply.

> May 29 01:36:35 toweringmeep kernel: hda: read_intr: status=0x59 {
> DriveReady SeekComplete DataRequest Error }
> May 29 01:36:35 toweringmeep kernel: hda: read_intr: error=0x40 {
> UncorrectableError }, LBAsect=2113616, sector=2113553
> May 29 01:36:35 toweringmeep kernel: end_request: I/O error, dev 03:01
> (hda), sector 2113553
> May 29 01:36:35 toweringmeep kernel: EXT2-fs error (device ide0(3,1)):
> read_inode_bitmap: Cannot read inode bitmap - block_group = 129,
> inode_bitmap = 1056776
> May 29 01:36:35 toweringmeep kernel: kernel BUG at inode.c:886!

> is this a nice catch 22 ? or is there a nasty problem with one of my disks
> ... im about to reboot and check the disk....

You have a disk problem, which caused I/O failure (the hda: read_intr
messages are first).  Time for a backup (if you don't have one) and a
new disk.

Cheers, Andreas
===========================================================================
--- linux-2.4.5.orig/fs/ext2/ialloc.c	Tue Apr 10 16:44:49 2001
+++ linux-2.4.5-aed/fs/ext2/ialloc.c	Tue May 29 13:32:04 2001
@@ -199,10 +199,15 @@
 
 	lock_super (sb);
 	es = sb->u.ext2_sb.s_es;
-	if (ino < EXT2_FIRST_INO(sb) || 
+	is_directory = S_ISDIR(inode->i_mode);
+
+	/* Do this BEFORE marking the inode not in use or returning an error */
+	clear_inode (inode);
+
+	if (ino < EXT2_FIRST_INO(sb) ||
 	    ino > le32_to_cpu(es->s_inodes_count)) {
-		ext2_error (sb, "free_inode",
-			    "reserved inode or nonexistent inode");
+		ext2_error (sb, "ext2_free_inode",
+			    "reserved or nonexistent inode %lu", ino);
 		goto error_return;
 	}
 	block_group = (ino - 1) / EXT2_INODES_PER_GROUP(sb);
@@ -210,13 +215,8 @@
 	bitmap_nr = load_inode_bitmap (sb, block_group);
 	if (bitmap_nr < 0)
 		goto error_return;
-	
+
 	bh = sb->u.ext2_sb.s_inode_bitmap[bitmap_nr];
-
-	is_directory = S_ISDIR(inode->i_mode);
-
-	/* Do this BEFORE marking the inode not in use */
-	clear_inode (inode);
 
 	/* Ok, now we can actually update the inode bitmaps.. */
 	if (!ext2_clear_bit (bit, bh->b_data))
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
