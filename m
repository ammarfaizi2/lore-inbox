Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTKJOzp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 09:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTKJOzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 09:55:45 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:32955 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263777AbTKJOzn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 09:55:43 -0500
Date: Mon, 10 Nov 2003 22:59:35 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH] small memory leak in autofs4 inode.c
Message-ID: <Pine.LNX.4.44.0311102250400.6484-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch corrects a memory leak in autofs4 inode.c. It applies 
to both kernel versions 2.4 and 2.6 (with a little fuzz).

An autofs_info struct is allocated in autofs4_read_super 
(autofs4_fill_super in 2.6) for use during superblock initialisation, its 
reference is not stored anywhere and it is not freed.

I thought it better to leave the allocation and then free it rather that 
allocate it n the stack. If this is not the best way to solve this problem 
please offer comments.

Regards
Ian Kent

--- inode.c.orig	2003-11-09 15:47:25.000000000 +0800
+++ inode.c	2003-11-09 15:49:09.000000000 +0800
@@ -183,6 +183,7 @@
 	struct file * pipe;
 	int pipefd;
 	struct autofs_sb_info *sbi;
+	struct autofs_info *ino;
 	int minproto, maxproto;
 
 	sbi = (struct autofs_sb_info *) kmalloc(sizeof(*sbi), GFP_KERNEL);
@@ -211,7 +212,9 @@
 	/*
 	 * Get the root inode and dentry, but defer checking for errors.
 	 */
-	root_inode = autofs4_get_inode(s, autofs4_mkroot(sbi));
+	ino = autofs4_mkroot(sbi);
+	root_inode = autofs4_get_inode(s, ino);
+	kfree(ino);
 	root_inode->i_op = &autofs4_root_inode_operations;
 	root_inode->i_fop = &autofs4_root_operations;
 	root = d_alloc_root(root_inode);

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

