Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVITAsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVITAsF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 20:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbVITAsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 20:48:05 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:42348 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964807AbVITAsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 20:48:04 -0400
Subject: [patch] stop inotify from sending random DELETE_SELF event under
	load
From: John McCutchan <ttb@tentacle.dhs.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@novell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Sep 2005 20:48:56 -0400
Message-Id: <1127177337.15262.6.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yo,

Below is a patch that fixes the random DELETE_SELF events when the
system is under load. The problem is that the DELETE_SELF event is sent
from dentry_iput, which is called in two code paths,

1) When a dentry is being deleted
2) When the dcache is being pruned.

We only want to send the event in case 1.

This has been spotted in the wild, and should be put into 2.6.14. It
fixes http://bugzilla.kernel.org/show_bug.cgi?id=5279

Yes, the patch makes me cringe to, but we need fsnotify_inodremove where
it is to avoid locking problems and a race.


Signed-off-by: John McCutchan <ttb@tentacle.dhs.org>

Index: linux-2.6.13/fs/dcache.c
===================================================================
--- linux-2.6.13.orig/fs/dcache.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/fs/dcache.c	2005-09-19 15:30:03.000000000 -0400
@@ -94,7 +94,7 @@
  * d_iput() operation if defined.
  * Called with dcache_lock and per dentry lock held, drops both.
  */
-static inline void dentry_iput(struct dentry * dentry)
+static inline void dentry_iput(struct dentry * dentry, int call_inoderemove)
 {
 	struct inode *inode = dentry->d_inode;
 	if (inode) {
@@ -102,7 +102,8 @@
 		list_del_init(&dentry->d_alias);
 		spin_unlock(&dentry->d_lock);
 		spin_unlock(&dcache_lock);
-		fsnotify_inoderemove(inode);
+		if (call_inoderemove)
+			fsnotify_inoderemove(inode);
 		if (dentry->d_op && dentry->d_op->d_iput)
 			dentry->d_op->d_iput(dentry, inode);
 		else
@@ -195,7 +196,7 @@
   		list_del(&dentry->d_child);
 		dentry_stat.nr_dentry--;	/* For d_free, below */
 		/*drops the locks, at that point nobody can reach this dentry */
-		dentry_iput(dentry);
+		dentry_iput(dentry, 0);
 		parent = dentry->d_parent;
 		d_free(dentry);
 		if (dentry == parent)
@@ -370,7 +371,7 @@
 	__d_drop(dentry);
 	list_del(&dentry->d_child);
 	dentry_stat.nr_dentry--;	/* For d_free, below */
-	dentry_iput(dentry);
+	dentry_iput(dentry, 0);
 	parent = dentry->d_parent;
 	d_free(dentry);
 	if (parent != dentry)
@@ -1175,7 +1176,7 @@
 	spin_lock(&dentry->d_lock);
 	isdir = S_ISDIR(dentry->d_inode->i_mode);
 	if (atomic_read(&dentry->d_count) == 1) {
-		dentry_iput(dentry);
+		dentry_iput(dentry, 1);
 		fsnotify_nameremove(dentry, isdir);
 		return;
 	}

