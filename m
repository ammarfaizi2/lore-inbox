Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVF2GHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVF2GHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 02:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVF2GHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 02:07:20 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:59797 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262439AbVF2GHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 02:07:12 -0400
Date: Wed, 29 Jun 2005 09:06:53 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] fat: fix slab cache leak
Message-ID: <Pine.LNX.4.58.0506290906010.9107@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch plugs a slab cache leak in fat module initialization.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 inode.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

Index: 2.6/fs/fat/inode.c
===================================================================
--- 2.6.orig/fs/fat/inode.c	2005-06-17 22:48:29.000000000 +0300
+++ 2.6/fs/fat/inode.c	2005-06-29 08:16:12.000000000 +0300
@@ -1331,12 +1331,21 @@
 
 static int __init init_fat_fs(void)
 {
-	int ret;
+	int err;
+	
+	err = fat_cache_init();
+	if (err)
+		return err;
 
-	ret = fat_cache_init();
-	if (ret < 0)
-		return ret;
-	return fat_init_inodecache();
+	err = fat_init_inodecache();
+	if (err)
+		goto failed;
+
+	return 0;
+
+failed:
+	fat_cache_destroy();
+	return err;
 }
 
 static void __exit exit_fat_fs(void)
