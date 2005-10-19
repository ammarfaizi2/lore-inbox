Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbVJSMi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVJSMi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbVJSMi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:38:59 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:12426 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750881AbVJSMi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:38:58 -0400
Date: Wed, 19 Oct 2005 10:42:24 -0200
To: Andrew Morton <akpm@osdl.org>
Cc: jesper.juhl@gmail.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       adilger@clusterfs.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] Test for sb_getblk return value
Message-ID: <20051019124224.GB25893@br.ibm.com>
References: <20051017132306.GA30328@br.ibm.com> <9a8748490510170710s3971e0c6u2a95fa2cb6ad2c5a@mail.gmail.com> <200510171356.11639.glommer@br.ibm.com> <20051018163201.79730947.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20051018163201.79730947.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: glommer@br.ibm.com (Glauber de Oliveira Costa)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds tests for the return value of sb_getblk() in the ext2/3
filesystems. In fs/buffer.c it is stated that the getblk() function
never fails. However, it does can return NULL in some situations due to
I/O errors, which may lead us to NULL pointer dereferences 

Signed-off-by: Glauber de Oliveira Costa <glommer@br.ibm.com>

-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
glommer@br.ibm.com
=====================================

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch_getblk_ext3.v4"

diff -Naurp linux-2.6.14-rc2-orig/fs/ext2/inode.c linux-2.6.14-rc2-cleanp/fs/ext2/inode.c
--- linux-2.6.14-rc2-orig/fs/ext2/inode.c	2005-10-19 02:04:12.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext2/inode.c	2005-10-19 12:07:12.000000000 +0000
@@ -440,6 +440,10 @@ static int ext2_alloc_branch(struct inod
 		 * the pointer to new one, then send parent to disk.
 		 */
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh) {
+			err = -EIO;
+			break;
+		}
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;
diff -Naurp linux-2.6.14-rc2-orig/fs/ext3/inode.c linux-2.6.14-rc2-cleanp/fs/ext3/inode.c
--- linux-2.6.14-rc2-orig/fs/ext3/inode.c	2005-10-19 02:04:12.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext3/inode.c	2005-10-19 02:03:22.000000000 +0000
@@ -523,7 +523,6 @@ static int ext3_alloc_branch(handle_t *h
 			if (!nr)
 				break;
 			branch[n].key = cpu_to_le32(nr);
-			keys = n+1;
 
 			/*
 			 * Get buffer_head for parent block, zero it out
@@ -531,6 +530,9 @@ static int ext3_alloc_branch(handle_t *h
 			 * parent to disk.  
 			 */
 			bh = sb_getblk(inode->i_sb, parent);
+			if (!bh)
+				break;	
+			keys = n+1;
 			branch[n].bh = bh;
 			lock_buffer(bh);
 			BUFFER_TRACE(bh, "call get_create_access");
@@ -864,6 +866,10 @@ struct buffer_head *ext3_getblk(handle_t
 	if (!*errp && buffer_mapped(&dummy)) {
 		struct buffer_head *bh;
 		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
+		if (!bh) {
+			*errp = -EIO;
+			return NULL;
+		}
 		if (buffer_new(&dummy)) {
 			J_ASSERT(create != 0);
 			J_ASSERT(handle != 0);
diff -Naurp linux-2.6.14-rc2-orig/fs/ext3/resize.c linux-2.6.14-rc2-cleanp/fs/ext3/resize.c
--- linux-2.6.14-rc2-orig/fs/ext3/resize.c	2005-10-19 02:04:12.000000000 +0000
+++ linux-2.6.14-rc2-cleanp/fs/ext3/resize.c	2005-10-19 01:54:47.000000000 +0000
@@ -118,6 +118,8 @@ static struct buffer_head *bclean(handle
 	int err;
 
 	bh = sb_getblk(sb, blk);
+	if (!bh)
+		return ERR_PTR(-EIO);
 	if ((err = ext3_journal_get_write_access(handle, bh))) {
 		brelse(bh);
 		bh = ERR_PTR(err);
@@ -202,6 +204,10 @@ static int setup_new_group_blocks(struct
 		ext3_debug("update backup group %#04lx (+%d)\n", block, bit);
 
 		gdb = sb_getblk(sb, block);
+		if (!bh) {
+			err = -EIO;
+			goto exit_bh;
+		}
 		if ((err = ext3_journal_get_write_access(handle, gdb))) {
 			brelse(gdb);
 			goto exit_bh;
@@ -643,6 +649,10 @@ static void update_backups(struct super_
 			break;
 
 		bh = sb_getblk(sb, group * bpg + blk_off);
+		if (!bh) {
+			err = -EIO;
+			break;
+		}
 		ext3_debug("update metadata backup %#04lx\n",
 			  (unsigned long)bh->b_blocknr);
 		if ((err = ext3_journal_get_write_access(handle, bh)))

--tKW2IUtsqtDRztdT--
