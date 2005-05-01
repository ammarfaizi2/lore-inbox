Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbVEAVUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVEAVUw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVEAVTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:19:31 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:23059 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262682AbVEAVS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:28 -0400
Message-Id: <200505012112.j41LCupS016461@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/22] UML - Hostfs failed mount handling
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:12:56 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up the error handling and fixes a crash if a hostfs mount fails.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/fs/hostfs/hostfs_kern.c
===================================================================
--- linux-2.6.11.orig/fs/hostfs/hostfs_kern.c	2005-04-21 10:46:18.000000000 -0400
+++ linux-2.6.11/fs/hostfs/hostfs_kern.c	2005-04-21 12:35:24.000000000 -0400
@@ -991,13 +991,17 @@
 		goto out_put;
 
 	err = read_inode(root_inode);
-	if(err)
-		goto out_put;
+	if(err){
+                /* No iput in this case because the dput does that for us */
+                dput(sb->s_root);
+                sb->s_root = NULL;
+		goto out_free;
+        }
 
 	return(0);
 
  out_put:
-	iput(root_inode);
+        iput(root_inode);
  out_free:
 	kfree(name);
  out:

