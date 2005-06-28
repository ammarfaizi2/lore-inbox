Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVF1Lhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVF1Lhm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVF1Lhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:37:41 -0400
Received: from verein.lst.de ([213.95.11.210]:16022 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261333AbVF1LhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:37:19 -0400
Date: Tue, 28 Jun 2005 13:36:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] avoid lookup_hash usage in relayfs
Message-ID: <20050628113641.GB1306@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-mm specific addon to the same kind of patches I sent a few weeks


Index: linux-2.6.12/fs/relayfs/inode.c
===================================================================
--- linux-2.6.12.orig/fs/relayfs/inode.c	2005-06-27 21:12:33.000000000 +0200
+++ linux-2.6.12/fs/relayfs/inode.c	2005-06-28 13:24:05.000000000 +0200
@@ -94,7 +94,6 @@
 					   int mode,
 					   struct rchan *chan)
 {
-	struct qstr qname;
 	struct dentry *d;
 	struct inode *inode;
 	int error = 0;
@@ -107,10 +106,6 @@
 		return NULL;
 	}
 
-	qname.name = name;
-	qname.len = strlen(name);
-	qname.hash = full_name_hash(name, qname.len);
-
 	if (!parent && relayfs_mount && relayfs_mount->mnt_sb)
 		parent = relayfs_mount->mnt_sb->s_root;
 
@@ -121,7 +116,7 @@
 
 	parent = dget(parent);
 	down(&parent->d_inode->i_sem);
-	d = lookup_hash(&qname, parent);
+	d = lookup_one_len(name, parent, strlen(name));
 	if (IS_ERR(d)) {
 		d = NULL;
 		goto release_mount;
