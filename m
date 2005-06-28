Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVF1Lgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVF1Lgb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVF1Lgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:36:31 -0400
Received: from verein.lst.de ([213.95.11.210]:14486 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261323AbVF1Lg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:36:29 -0400
Date: Tue, 28 Jun 2005 13:36:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] avoid lookup_hash usage in configfs
Message-ID: <20050628113601.GA1306@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-mm specific addon to the same kind of patches I sent a few weeks ago


Index: linux-2.6.12/fs/configfs/dir.c
===================================================================
--- linux-2.6.12.orig/fs/configfs/dir.c	2005-06-27 21:12:19.000000000 +0200
+++ linux-2.6.12/fs/configfs/dir.c	2005-06-28 13:22:36.000000000 +0200
@@ -858,7 +858,7 @@
 
 	down(&parent->d_inode->i_sem);
 
-	new_dentry = configfs_get_dentry(parent, new_name);
+	new_dentry = lookup_one_len(new_name, parent, strlen(new_name));
 	if (!IS_ERR(new_dentry)) {
   		if (!new_dentry->d_inode) {
 			error = config_item_set_name(item, "%s", new_name);
Index: linux-2.6.12/fs/configfs/inode.c
===================================================================
--- linux-2.6.12.orig/fs/configfs/inode.c	2005-06-27 21:12:19.000000000 +0200
+++ linux-2.6.12/fs/configfs/inode.c	2005-06-28 13:22:43.000000000 +0200
@@ -98,16 +98,6 @@
 	return error;
 }
 
-struct dentry * configfs_get_dentry(struct dentry * parent, const char * name)
-{
-	struct qstr qstr;
-
-	qstr.name = name;
-	qstr.len = strlen(name);
-	qstr.hash = full_name_hash(name,qstr.len);
-	return lookup_hash(&qstr,parent);
-}
-
 /*
  * Get the name for corresponding element represented by the given configfs_dirent
  */
