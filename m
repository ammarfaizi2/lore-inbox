Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbVLBVUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVLBVUk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbVLBVUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:20:40 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:44200 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750823AbVLBVUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:20:39 -0500
Subject: [PATCH] fs: remove s_old_blocksize from struct super_block
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Date: Fri, 02 Dec 2005 23:20:37 +0200
Message-Id: <1133558437.31065.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The s_old_blocksize field of struct super_block is only used as a temporary
variable in get_sb_bdev(). This patch changes the function to use a local
variable instead so we can kill the field from struct super_block.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 fs/super.c         |    5 +++--
 include/linux/fs.h |    1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: 2.6/fs/super.c
===================================================================
--- 2.6.orig/fs/super.c
+++ 2.6/fs/super.c
@@ -707,11 +707,12 @@ struct super_block *get_sb_bdev(struct f
 		goto out;
 	} else {
 		char b[BDEVNAME_SIZE];
+		unsigned long old_blocksize;
 
 		s->s_flags = flags;
 		strlcpy(s->s_id, bdevname(bdev, b), sizeof(s->s_id));
-		s->s_old_blocksize = block_size(bdev);
-		sb_set_blocksize(s, s->s_old_blocksize);
+		old_blocksize = block_size(bdev);
+		sb_set_blocksize(s, old_blocksize);
 		error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 		if (error) {
 			up_write(&s->s_umount);
Index: 2.6/include/linux/fs.h
===================================================================
--- 2.6.orig/include/linux/fs.h
+++ 2.6/include/linux/fs.h
@@ -777,7 +777,6 @@ struct super_block {
 	struct list_head	s_list;		/* Keep this first */
 	dev_t			s_dev;		/* search index; _not_ kdev_t */
 	unsigned long		s_blocksize;
-	unsigned long		s_old_blocksize;
 	unsigned char		s_blocksize_bits;
 	unsigned char		s_dirt;
 	unsigned long long	s_maxbytes;	/* Max file size */


