Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVC1Ru7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVC1Ru7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVC1Rtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:49:35 -0500
Received: from fep16.inet.fi ([194.251.242.241]:64130 "EHLO fep16.inet.fi")
	by vger.kernel.org with ESMTP id S261978AbVC1Rm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:42:29 -0500
Subject: [PATCH 9/9] isofs: clean up rock.c
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ie2p5n.les0lo.3ojhk4sypgk2fgvmcg539g4tz.refire@cs.helsinki.fi>
In-Reply-To: <ie2p5f.t67m3i.aid9ej9zr5l2bzvc37myo8bgc.refire@cs.helsinki.fi>
Date: Mon, 28 Mar 2005 20:42:28 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some redundant variables from fs/isofs/rock.c.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 rock.c |   41 +++++++++++++----------------------------
 1 files changed, 13 insertions(+), 28 deletions(-)

Index: 2.6/fs/isofs/rock.c
===================================================================
--- 2.6.orig/fs/isofs/rock.c	2005-03-28 18:26:34.000000000 +0300
+++ 2.6/fs/isofs/rock.c	2005-03-28 18:27:35.000000000 +0300
@@ -140,21 +140,17 @@
 	kfree(buffer);
 	buffer = NULL;
 	if (cont_extent) {
-		int block, offset, offset1;
 		struct buffer_head * pbh;
 		buffer = kmalloc(cont_size,GFP_KERNEL);
 		if (!buffer)
 			goto out;
-		block = cont_extent;
-		offset = cont_offset;
-		offset1 = 0;
-		pbh = sb_bread(inode->i_sb, block);
+		pbh = sb_bread(inode->i_sb, cont_extent);
 		if(pbh) {
-			if (offset > pbh->b_size || offset + cont_size > pbh->b_size) {
+			if (cont_offset > pbh->b_size || cont_offset + cont_size > pbh->b_size) {
 				brelse(pbh);
 				goto out;
      			}
-			memcpy(buffer + offset1, pbh->b_data + offset, cont_size - offset1);
+			memcpy(buffer, pbh->b_data + cont_offset, cont_size);
 			brelse(pbh);
 			chr = (unsigned char *) buffer;
 			len = cont_size;
@@ -424,21 +420,17 @@
 	kfree(buffer);
 	buffer = NULL;
 	if (cont_extent) {
-		int block, offset, offset1;
 		struct buffer_head * pbh;
 		buffer = kmalloc(cont_size,GFP_KERNEL);
 		if (!buffer)
 			goto out;
-		block = cont_extent;
-		offset = cont_offset;
-		offset1 = 0;
-		pbh = sb_bread(inode->i_sb, block);
+		pbh = sb_bread(inode->i_sb, cont_extent);
 		if(pbh) {
-			if (offset > pbh->b_size || offset + cont_size > pbh->b_size) {
+			if (cont_offset > pbh->b_size || cont_offset + cont_size > pbh->b_size) {
 				brelse(pbh);
 				goto out;
      			}
-			memcpy(buffer + offset1, pbh->b_data + offset, cont_size - offset1);
+			memcpy(buffer, pbh->b_data + cont_offset, cont_size);
 			brelse(pbh);
 			chr = (unsigned char *) buffer;
 			len = cont_size;
@@ -549,8 +541,6 @@
 	struct iso_directory_record *raw_inode;
 	int cont_extent = 0, cont_offset = 0, cont_size = 0;
 	void *buffer = NULL;
-	unsigned long block, offset;
-	int sig;
 	int len;
 	unsigned char *chr;
 	struct rock_ridge *rr;
@@ -558,21 +548,19 @@
 	if (!ISOFS_SB(inode->i_sb)->s_rock)
 		goto error;
 
-	block = ei->i_iget5_block;
 	lock_kernel();
-	bh = sb_bread(inode->i_sb, block);
+	bh = sb_bread(inode->i_sb, ei->i_iget5_block);
 	if (!bh)
 		goto out_noread;
 
-	offset = ei->i_iget5_offset;
-	pnt = (unsigned char *)bh->b_data + offset;
+	pnt = (unsigned char *)bh->b_data + ei->i_iget5_offset;
 
 	raw_inode = (struct iso_directory_record *)pnt;
 
 	/*
 	 * If we go past the end of the buffer, there is some sort of error.
 	 */
-	if (offset + *pnt > bufsize)
+	if (ei->i_iget5_offset + *pnt > bufsize)
 		goto out_bad_span;
 
 	/* Now test for possible Rock Ridge extensions which will override
@@ -582,6 +570,7 @@
 
       repeat:
 	while (len > 2) {	/* There may be one byte for padding somewhere */
+		int sig;
 		rr = (struct rock_ridge *)chr;
 		if (rr->len < 3)
 			goto out;	/* Something got screwed up here */
@@ -620,21 +609,17 @@
 	kfree(buffer);
 	buffer = NULL;
 	if (cont_extent) {
-		int block, offset, offset1;
 		struct buffer_head * pbh;
 		buffer = kmalloc(cont_size,GFP_KERNEL);
 		if (!buffer)
 			goto out;
-		block = cont_extent;
-		offset = cont_offset;
-		offset1 = 0;
-		pbh = sb_bread(inode->i_sb, block);
+		pbh = sb_bread(inode->i_sb, cont_extent);
 		if(pbh) {
-			if (offset > pbh->b_size || offset + cont_size > pbh->b_size) {
+			if (cont_offset > pbh->b_size || cont_offset + cont_size > pbh->b_size) {
 				brelse(pbh);
 				goto out;
      			}
-			memcpy(buffer + offset1, pbh->b_data + offset, cont_size - offset1);
+			memcpy(buffer, pbh->b_data + cont_offset, cont_size);
 			brelse(pbh);
 			chr = (unsigned char *) buffer;
 			len = cont_size;
