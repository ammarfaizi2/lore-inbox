Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUH0QHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUH0QHJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266347AbUH0QHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:07:08 -0400
Received: from hera.cwi.nl ([192.16.191.8]:47554 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S266345AbUH0QHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:07:00 -0400
Date: Fri, 27 Aug 2004 18:06:55 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <UTC200408271606.i7RG6tV27596.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] reiserfs/xattr fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday or so I wrote:

[Ha, now that I write about the same md5sum: is it well-known
that reiserfs was/is broken? This is what I noticed yesterday
on 2.6.7, have not yet investigated it closely, except for
verifying that coinciding r5 hash is involved.
   # mount /dev/xxx /mnt -t reiserfs
   # cd /mnt
   # echo hoi > ml
   # cat na
   hoi
   # ls -li ml na
   9 -rw-r--r--  1 root root 4 2004-08-25 17:53 ml
   9 -rw-r--r--  1 root root 4 2004-08-25 17:53 na
   # rm na
   # cat ml
   cat: ml: No such file or directory
]

This same bug exists on 2.6.8.1. It is fixed by the patch below.

Andries


diff -uprN -X /linux/dontdiff a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
--- a/fs/reiserfs/xattr.c	2004-06-24 17:11:20.000000000 +0200
+++ b/fs/reiserfs/xattr.c	2004-08-27 17:54:39.000000000 +0200
@@ -1235,7 +1235,13 @@ reiserfs_xattr_unregister_handlers (void
 static int
 xattr_lookup_poison (struct dentry *dentry, struct qstr *q1, struct qstr *name)
 {
-    struct dentry *priv_root = REISERFS_SB(dentry->d_sb)->priv_root;
+    struct dentry *priv_root;
+
+    /* first the ordinary comparison */
+    if (q1->len != name->len || memcmp(q1->name, name->name, name->len))
+	return -ENOENT;
+    /* when found, reject if private */
+    priv_root = REISERFS_SB(dentry->d_sb)->priv_root;
     if (name->len == priv_root->d_name.len &&
         name->hash == priv_root->d_name.hash &&
         !memcmp (name->name, priv_root->d_name.name, name->len)) {
