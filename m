Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266055AbUA1Pk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266053AbUA1PkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:40:19 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:2571 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266052AbUA1Pjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:39:51 -0500
Date: Wed, 28 Jan 2004 23:38:56 +0800 (WST)
From: raven@themaw.net
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Jeremy Fitzhardinge <jeremy@goop.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH 2/8] autofs4-2.6 - to support autofs 4.1.x
Message-ID: <Pine.LNX.4.58.0401282314050.17471@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.3, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch:

2-autofs4-2.6.0-test9-fill_super.patch

Fix memory leak in autofs4_fill_super function.

diff -Nur linux-2.6.0-0.test9.expire/fs/autofs4/inode.c linux-2.6.0-0.test9.fill_super/fs/autofs4/inode.c
--- linux-2.6.0-0.test9.expire/fs/autofs4/inode.c	2003-10-26 02:44:12.000000000 +0800
+++ linux-2.6.0-0.test9.fill_super/fs/autofs4/inode.c	2003-11-15 09:26:41.000000000 +0800
@@ -187,6 +187,7 @@
 	struct file * pipe;
 	int pipefd;
 	struct autofs_sb_info *sbi;
+	struct autofs_info *ino;
 	int minproto, maxproto;
 
 	sbi = (struct autofs_sb_info *) kmalloc(sizeof(*sbi), GFP_KERNEL);
@@ -212,7 +213,9 @@
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

