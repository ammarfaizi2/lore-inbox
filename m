Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbTDVL01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 07:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbTDVL00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 07:26:26 -0400
Received: from linux3.contactor.se ([193.15.23.23]:39658 "EHLO
	linux3.contactor.se") by vger.kernel.org with ESMTP id S263078AbTDVL0Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 07:26:24 -0400
Date: Tue, 22 Apr 2003 13:38:19 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Stenberg <bjorn@haxx.se>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br, torvalds@transmeta.com
Subject: [PATCH] fat cluster search speedup (2.4.20, 2.5.68)
Message-ID: <20030422113819.GD14737@linux3.contactor.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This simple patch makes the linux fat filesystem driver use the next_cluster field in the fat_boot_fsinfo structure. This field is a hint where to start looking for free clusters.

Using this field makes a big difference for disks connected over slow links such as USB 1.1. Finding the first free cluster on a 40gig fat-formatted usb disk can today take several minutes. This patch cuts it down to a fraction of a second.

Please Cc me on any discussion about this patch, as I am not subscribed to the list.

The patch is cooked in two flavors, for 2.4.20 and 2.5.68:

For 2.4.20:

diff -Nru include/linux.orig/msdos_fs.h include/linux/msdos_fs.h
--- include/linux.orig/msdos_fs.h	Tue Apr 22 10:55:09 2003
+++ include/linux/msdos_fs.h	Tue Apr 22 10:58:33 2003
@@ -145,8 +145,7 @@
 	__u32   reserved1[120];	/* Nothing as far as I can tell */
 	__u32   signature2;	/* 0x61417272L */
 	__u32   free_clusters;	/* Free cluster count.  -1 if unknown */
-	__u32   next_cluster;	/* Most recently allocated cluster.
-				 * Unused under Linux. */
+	__u32   next_cluster;	/* Most recently allocated cluster */
 	__u32   reserved2[4];
 };
 
diff -Nru fs/fat.orig/inode.c fs/fat/inode.c
--- fs/fat.orig/inode.c	Sat Aug  3 02:39:45 2002
+++ fs/fat/inode.c	Tue Apr 22 11:47:50 2003
@@ -637,6 +637,7 @@
 	sbi->cluster_bits = ffs(logical_sector_size * sbi->cluster_size) - 1;
 	sbi->fats = b->fats;
 	sbi->fat_start = CF_LE_W(b->reserved);
+	sbi->prev_free = 0;
 	if (!b->fat_length && b->fat32_length) {
 		struct fat_boot_fsinfo *fsinfo;
 		struct buffer_head *fsinfo_bh;
@@ -675,6 +676,7 @@
 			       sbi->fsinfo_sector);
 		} else {
 			sbi->free_clusters = CF_LE_L(fsinfo->free_clusters);
+			sbi->prev_free = CF_LE_L(fsinfo->next_cluster);
 		}
 
 		if (fsinfo_block != 0)
@@ -754,7 +756,6 @@
 	sb->s_magic = MSDOS_SUPER_MAGIC;
 	/* set up enough so that it can read an inode */
 	init_MUTEX(&sbi->fat_lock);
-	sbi->prev_free = 0;
 
 	cp = opts.codepage ? opts.codepage : 437;
 	sprintf(buf, "cp%d", cp);
diff -Nru fs/fat.orig/misc.c fs/fat/misc.c
--- fs/fat.orig/misc.c	Fri Oct 12 22:48:42 2001
+++ fs/fat/misc.c	Tue Apr 22 10:59:52 2003
@@ -108,6 +108,7 @@
 		return;
 	}
 	fsinfo->free_clusters = CF_LE_L(MSDOS_SB(sb)->free_clusters);
+	fsinfo->next_cluster = CF_LE_L(MSDOS_SB(sb)->prev_free);
 	fat_mark_buffer_dirty(sb, bh);
 	fat_brelse(sb, bh);
 }



For 2.5.68:

--- include/linux/msdos_fs.h.orig	Tue Apr 22 12:05:35 2003
+++ include/linux/msdos_fs.h	Tue Apr 22 12:06:02 2003
@@ -146,8 +146,7 @@
 	__u32   reserved1[120];	/* Nothing as far as I can tell */
 	__u32   signature2;	/* 0x61417272L */
 	__u32   free_clusters;	/* Free cluster count.  -1 if unknown */
-	__u32   next_cluster;	/* Most recently allocated cluster.
-				 * Unused under Linux. */
+	__u32   next_cluster;	/* Most recently allocated cluster */
 	__u32   reserved2[4];
 };
 
--- fs/fat/inode.c.orig	Tue Apr 22 12:06:12 2003
+++ fs/fat/inode.c	Tue Apr 22 12:08:12 2003
@@ -898,6 +898,7 @@
 			       sbi->fsinfo_sector);
 		} else {
 			sbi->free_clusters = CF_LE_L(fsinfo->free_clusters);
+			sbi->prev_free = CF_LE_L(fsinfo->next_cluster);
 		}
 
 		brelse(fsinfo_bh);
--- fs/fat/misc.c.orig	Tue Apr 22 12:06:16 2003
+++ fs/fat/misc.c	Tue Apr 22 12:06:49 2003
@@ -74,6 +74,7 @@
 		       MSDOS_SB(sb)->fsinfo_sector);
 	} else {
 		fsinfo->free_clusters = CF_LE_L(MSDOS_SB(sb)->free_clusters);
+		fsinfo->next_cluster = CF_LE_L(MSDOS_SB(sb)->prev_free);
 		mark_buffer_dirty(bh);
 	}
 	brelse(bh);


-- 
Björn
