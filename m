Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVCETML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVCETML (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 14:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVCETKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 14:10:22 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:39940 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261167AbVCESrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:47:25 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/29] FAT: Use "unsigned int" for ->free_clusters and
 ->prev_free
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
	<87d5uerl2j.fsf_-_@devron.myhome.or.jp>
	<878y52rl17.fsf_-_@devron.myhome.or.jp>
	<87zmxiq6ef.fsf_-_@devron.myhome.or.jp>
	<87vf86q6d2.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 03:47:04 +0900
In-Reply-To: <87vf86q6d2.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Sun, 06 Mar 2005 03:45:29 +0900")
Message-ID: <87r7iuq6af.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This changes ->free_clusters and ->prev_free from "int" to "unsigned int".
These value should be never negative value (but it's using 0xffffffff(-1)
as undefined state).

With this changes, fatfs would handle the corruption of free_clusters
more proper.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/fatent.c          |    3 +--
 fs/fat/inode.c           |    6 +++++-
 include/linux/msdos_fs.h |    4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff -puN fs/fat/fatent.c~sync05-fat_free-unsigned fs/fat/fatent.c
--- linux-2.6.11/fs/fat/fatent.c~sync05-fat_free-unsigned	2005-03-06 02:36:19.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/fatent.c	2005-03-06 02:36:19.000000000 +0900
@@ -453,8 +453,7 @@ int fat_alloc_clusters(struct inode *ino
 	fatent_init(&fatent);
 	fatent_set_entry(&fatent, sbi->prev_free + 1);
 	while (count < sbi->max_cluster) {
-		fatent.entry %= sbi->max_cluster;
-		if (fatent.entry < FAT_START_ENT)
+		if (fatent.entry >= sbi->max_cluster)
 			fatent.entry = FAT_START_ENT;
 		fatent_set_entry(&fatent, fatent.entry);
 		err = fat_ent_read_block(sb, &fatent);
diff -puN fs/fat/inode.c~sync05-fat_free-unsigned fs/fat/inode.c
--- linux-2.6.11/fs/fat/inode.c~sync05-fat_free-unsigned	2005-03-06 02:36:19.000000000 +0900
+++ linux-2.6.11-hirofumi/fs/fat/inode.c	2005-03-06 02:36:19.000000000 +0900
@@ -1163,7 +1163,7 @@ int fat_fill_super(struct super_block *s
 	sbi->fat_length = le16_to_cpu(b->fat_length);
 	sbi->root_cluster = 0;
 	sbi->free_clusters = -1;	/* Don't know yet */
-	sbi->prev_free = -1;
+	sbi->prev_free = FAT_START_ENT;
 
 	if (!sbi->fat_length && b->fat32_length) {
 		struct fat_boot_fsinfo *fsinfo;
@@ -1247,6 +1247,10 @@ int fat_fill_super(struct super_block *s
 	/* check the free_clusters, it's not necessarily correct */
 	if (sbi->free_clusters != -1 && sbi->free_clusters > total_clusters)
 		sbi->free_clusters = -1;
+	/* check the prev_free, it's not necessarily correct */
+	sbi->prev_free %= sbi->max_cluster;
+	if (sbi->prev_free < FAT_START_ENT)
+		sbi->prev_free = FAT_START_ENT;
 
 	brelse(bh);
 
diff -puN include/linux/msdos_fs.h~sync05-fat_free-unsigned include/linux/msdos_fs.h
--- linux-2.6.11/include/linux/msdos_fs.h~sync05-fat_free-unsigned	2005-03-06 02:36:19.000000000 +0900
+++ linux-2.6.11-hirofumi/include/linux/msdos_fs.h	2005-03-06 02:36:19.000000000 +0900
@@ -225,8 +225,8 @@ struct msdos_sb_info {
 	unsigned long root_cluster;  /* first cluster of the root directory */
 	unsigned long fsinfo_sector; /* sector number of FAT32 fsinfo */
 	struct semaphore fat_lock;
-	int prev_free;               /* previously allocated cluster number */
-	int free_clusters;           /* -1 if undefined */
+	unsigned int prev_free;      /* previously allocated cluster number */
+	unsigned int free_clusters;  /* -1 if undefined */
 	struct fat_mount_options options;
 	struct nls_table *nls_disk;  /* Codepage used on disk */
 	struct nls_table *nls_io;    /* Charset used for input and display */
_
