Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUGZKVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUGZKVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 06:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265138AbUGZKU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 06:20:58 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:40368 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S265134AbUGZKUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 06:20:50 -0400
Message-ID: <4104DAF1.2090608@tu-harburg.de>
Date: Mon, 26 Jul 2004 12:20:33 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org, ext2-devel@lists.sourceforge.net
Subject: [PATCH] Fix ext2_readdir()
Content-Type: multipart/mixed;
 boundary="------------040506050802060406090503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040506050802060406090503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I noticed that ext2_readdir() is ignoring the set error return values 
and always returns 0.

Signed-off-by: Jan Blunck <j.blunck@tu-harburg.de>

--------------040506050802060406090503
Content-Type: text/x-patch;
 name="ext2_readdir.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ext2_readdir.diff"

Index: testing-2.5/fs/ext2/dir.c
===================================================================
--- testing-2.5.orig/fs/ext2/dir.c	2004-07-24 09:54:50.174994960 +0200
+++ testing-2.5/fs/ext2/dir.c	2004-07-24 10:58:52.430883280 +0200
@@ -257,10 +257,10 @@
 	unsigned chunk_mask = ~(ext2_chunk_size(inode)-1);
 	unsigned char *types = NULL;
 	int need_revalidate = (filp->f_version != inode->i_version);
-	int ret = 0;
+	int ret;
 
 	if (pos > inode->i_size - EXT2_DIR_REC_LEN(1))
-		goto done;
+		goto success;
 
 	if (EXT2_HAS_INCOMPAT_FEATURE(sb, EXT2_FEATURE_INCOMPAT_FILETYPE))
 		types = ext2_filetype_table;
@@ -300,17 +300,19 @@
 						le32_to_cpu(de->inode), d_type);
 				if (over) {
 					ext2_put_page(page);
-					goto done;
+					goto success;
 				}
 			}
 		}
 		ext2_put_page(page);
 	}
 
+success:
+	ret = 0;
 done:
 	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
 	filp->f_version = inode->i_version;
-	return 0;
+	return ret;
 }
 
 /*

--------------040506050802060406090503--
