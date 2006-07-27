Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWG0UkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWG0UkG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWG0UkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:40:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:39386 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750768AbWG0UkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:40:04 -0400
Subject: [PATCH] ext3 -nobh option causes oops (2.6.17.7)
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, stable@kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Date: Thu, 27 Jul 2006 13:42:41 -0700
Message-Id: <1154032961.29920.17.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

ext3 -nobh option causes kernel oops on files other than IFREG -
since the modification to them are journalled anyway and the
code expects to have buffer_head attached to it.

We need this patch for stable series also.

Thanks,
Badari

For files other than IFREG, nobh option doesn't make sense.
Modifications to them are journalled and needs buffer heads
to do that. Without this patch, we get kernel oops in page_buffers().

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

Index: linux-2.6.17.7/fs/ext3/inode.c
===================================================================
--- linux-2.6.17.7.orig/fs/ext3/inode.c	2006-07-24 20:36:01.000000000 -0700
+++ linux-2.6.17.7/fs/ext3/inode.c	2006-07-27 13:26:13.000000000 -0700
@@ -1159,7 +1159,7 @@ retry:
 		ret = PTR_ERR(handle);
 		goto out;
 	}
-	if (test_opt(inode->i_sb, NOBH))
+	if (test_opt(inode->i_sb, NOBH) && ext3_should_writeback_data(inode))
 		ret = nobh_prepare_write(page, from, to, ext3_get_block);
 	else
 		ret = block_prepare_write(page, from, to, ext3_get_block);
@@ -1245,7 +1245,7 @@ static int ext3_writeback_commit_write(s
 	if (new_i_size > EXT3_I(inode)->i_disksize)
 		EXT3_I(inode)->i_disksize = new_i_size;
 
-	if (test_opt(inode->i_sb, NOBH))
+	if (test_opt(inode->i_sb, NOBH) && ext3_should_writeback_data(inode))
 		ret = nobh_commit_write(file, page, from, to);
 	else
 		ret = generic_commit_write(file, page, from, to);
@@ -1495,7 +1495,7 @@ static int ext3_writeback_writepage(stru
 		goto out_fail;
 	}
 
-	if (test_opt(inode->i_sb, NOBH))
+	if (test_opt(inode->i_sb, NOBH) && ext3_should_writeback_data(inode))
 		ret = nobh_writepage(page, ext3_get_block, wbc);
 	else
 		ret = block_write_full_page(page, ext3_get_block, wbc);


