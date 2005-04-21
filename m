Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVDUBN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVDUBN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 21:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVDUBN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 21:13:59 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:15557 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261457AbVDUBLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 21:11:30 -0400
Date: Thu, 21 Apr 2005 03:11:26 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] squashfs: (void*)ify squashfs_read_data
Message-ID: <20050421011126.GD29755@wohnheim.fh-wedel.de>
References: <20050420065500.GA24213@wohnheim.fh-wedel.de> <20050421010817.GB29755@wohnheim.fh-wedel.de> <20050421011045.GC29755@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050421011045.GC29755@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jörn

-- 
Anything that can go wrong, will.
-- Finagle's Law


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 fs/squashfs/inode.c    |   11 +++++------
 fs/squashfs/squashfs.h |    2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

--- linux-2.6.12-rc2cow/fs/squashfs/inode.c~squashfs_cu4	2005-04-20 16:40:47.498638704 +0200
+++ linux-2.6.12-rc2cow/fs/squashfs/inode.c	2005-04-20 22:44:04.723347592 +0200
@@ -172,7 +172,7 @@ static struct buffer_head *get_block_len
 }
 
 
-unsigned int squashfs_read_data(struct super_block *s, char *buffer,
+unsigned int squashfs_read_data(struct super_block *s, void *buffer,
 			unsigned int index, unsigned int length,
 			unsigned int *next_index)
 {
@@ -324,7 +324,6 @@ int squashfs_get_cached_block(struct sup
 			if (msBlk->block_cache[i].block ==
 							SQUASHFS_INVALID_BLK) {
 				if (!(msBlk->block_cache[i].data =
-						(unsigned char *)
 						kmalloc(SQUASHFS_METADATA_SIZE,
 						GFP_KERNEL))) {
 					ERROR("Failed to allocate cache"
@@ -854,7 +853,7 @@ static int squashfs_fill_super(struct su
 	init_waitqueue_head(&msBlk->waitq);
 	init_waitqueue_head(&msBlk->fragment_wait_queue);
 
-	if (!squashfs_read_data(s, (char *) sBlk, SQUASHFS_START,
+	if (!squashfs_read_data(s, sBlk, SQUASHFS_START,
 					sizeof(squashfs_super_block) |
 					SQUASHFS_COMPRESSED_BIT_BLOCK, NULL)) {
 		SERROR("unable to read superblock\n");
@@ -955,7 +954,7 @@ static int squashfs_fill_super(struct su
 	if (msBlk->swap) {
 		squashfs_uid suid[sBlk->no_uids + sBlk->no_guids];
 
-		if (!squashfs_read_data(s, (char *) &suid, sBlk->uid_start,
+		if (!squashfs_read_data(s, &suid, sBlk->uid_start,
 					((sBlk->no_uids + sBlk->no_guids) *
 					 sizeof(squashfs_uid)) |
 					SQUASHFS_COMPRESSED_BIT_BLOCK, NULL)) {
@@ -966,7 +965,7 @@ static int squashfs_fill_super(struct su
 		SQUASHFS_SWAP_DATA(msBlk->uid, suid, (sBlk->no_uids +
 			sBlk->no_guids), (sizeof(squashfs_uid) * 8));
 	} else
-		if (!squashfs_read_data(s, (char *) msBlk->uid, sBlk->uid_start,
+		if (!squashfs_read_data(s, msBlk->uid, sBlk->uid_start,
 					((sBlk->no_uids + sBlk->no_guids) *
 					 sizeof(squashfs_uid)) |
 					SQUASHFS_COMPRESSED_BIT_BLOCK, NULL)) {
@@ -1001,7 +1000,7 @@ static int squashfs_fill_super(struct su
 	}
    
 	if (SQUASHFS_FRAGMENT_INDEX_BYTES(sBlk->fragments) &&
-					!squashfs_read_data(s, (char *)
+					!squashfs_read_data(s,
 					msBlk->fragment_index,
 					sBlk->fragment_table_start,
 					SQUASHFS_FRAGMENT_INDEX_BYTES
--- linux-2.6.12-rc2cow/fs/squashfs/squashfs.h~squashfs_cu4	2005-04-20 16:37:15.900806464 +0200
+++ linux-2.6.12-rc2cow/fs/squashfs/squashfs.h	2005-04-20 22:42:45.917327928 +0200
@@ -37,7 +37,7 @@
 
 #define WARNING(s, args...)	printk(KERN_WARNING "SQUASHFS: "s, ## args)
 
-extern unsigned int squashfs_read_data(struct super_block *s, char *buffer,
+extern unsigned int squashfs_read_data(struct super_block *s, void *buffer,
 				unsigned int index, unsigned int length,
 				unsigned int *next_index);
 extern int squashfs_get_cached_block(struct super_block *s, void *buffer,
