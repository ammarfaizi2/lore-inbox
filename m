Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267825AbUHEUep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267825AbUHEUep (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUHEUdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:33:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:21412 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267825AbUHEUcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:32:55 -0400
Date: Thu, 5 Aug 2004 21:32:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] simple fs stop -ve dentries
Message-ID: <Pine.LNX.4.44.0408052129570.2563-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A tmpfs user reported increasingly slow directory reads when repeatedly
creating and unlinking in a mkstemp-like way.  The negative dentries
accumulate alarmingly (until memory pressure finally frees them), and
are just a hindrance to any in-memory filesystem.  simple_lookup set
d_op to arrange for negative dentries to be deleted immediately.

(But I failed to discover how it is that on-disk filesystems seem to
keep their negative dentries within manageable bounds: this effect was
gross with tmpfs or ramfs, but no problem at all with extN or reiser.)

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.8-rc3-mm1/fs/libfs.c	2004-04-04 03:38:40.000000000 +0100
+++ linux/fs/libfs.c	2004-08-05 20:25:50.054872096 +0100
@@ -26,14 +26,27 @@ int simple_statfs(struct super_block *sb
 }
 
 /*
- * Lookup the data. This is trivial - if the dentry didn't already
- * exist, we know it is negative.
+ * Retaining negative dentries for an in-memory filesystem just wastes
+ * memory and lookup time: arrange for them to be deleted immediately.
  */
+static int simple_delete_dentry(struct dentry *dentry)
+{
+	return 1;
+}
 
+/*
+ * Lookup the data. This is trivial - if the dentry didn't already
+ * exist, we know it is negative.  Set d_op to delete negative dentries.
+ */
 struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
+	static struct dentry_operations simple_dentry_operations = {
+		.d_delete = simple_delete_dentry,
+	};
+
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
+	dentry->d_op = &simple_dentry_operations;
 	d_add(dentry, NULL);
 	return NULL;
 }

