Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVGXCUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVGXCUN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 22:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVGXCUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 22:20:13 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:9229 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261839AbVGXCUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 22:20:10 -0400
Date: Sun, 24 Jul 2005 10:12:15 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Jeff Moyer <jmoyer@redhat.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] autofs4 - fix infamous "Busy inodes after umount ..." message.
Message-ID: <Pine.LNX.4.63.0507241000120.2330@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-99.4, required 8,
	PATCH_UNIFIED_DIFF, RCVD_IN_ORBS, RCVD_IN_OSIRUSOFT_COM,
	USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If the automount daemon receives a signal which causes it to sumarily 
terminate the autofs4 module leaks dentries. The same problem exists with 
detached mount requests without the warning.

This patch cleans these dentries at umount.

Signed-off-by: Ian Kent <raven@themaw.net>

diff -Nurp linux-2.6.11.orig/fs/autofs4/autofs_i.h linux-2.6.11/fs/autofs4/autofs_i.h
--- linux-2.6.11.orig/fs/autofs4/autofs_i.h	2005-07-02 19:23:37.000000000 +0800
+++ linux-2.6.11/fs/autofs4/autofs_i.h	2005-07-02 19:15:11.000000000 +0800
@@ -92,6 +92,7 @@
 
 struct autofs_sb_info {
 	u32 magic;
+	struct dentry *root;
 	struct file *pipe;
 	pid_t oz_pgrp;
 	int catatonic;
--- linux-2.6.11.orig/fs/autofs4/inode.c	2005-07-02 19:19:37.000000000 +0800
+++ linux-2.6.11/fs/autofs4/inode.c	2005-07-09 13:16:13.000000000 +0800
@@ -16,6 +16,7 @@
 #include <linux/pagemap.h>
 #include <linux/parser.h>
 #include <linux/bitops.h>
+#include <linux/smp_lock.h>
 #include "autofs_i.h"
 #include <linux/module.h>
 
@@ -76,6 +77,66 @@
 	kfree(ino);
 }
 
+/*
+ * Deal with the infamous "Busy inodes after umount ..." message.
+ *
+ * Clean up the dentry tree. This happens with autofs if the user
+ * space program goes away due to a SIGKILL, SIGSEGV etc.
+ */
+static void autofs4_force_release(struct autofs_sb_info *sbi)
+{
+	struct dentry *this_parent = sbi->root;
+	struct list_head *next;
+
+	spin_lock(&dcache_lock);
+repeat:
+	next = this_parent->d_subdirs.next;
+resume:
+	while (next != &this_parent->d_subdirs) {
+		struct dentry *dentry = list_entry(next, struct dentry, d_child);
+
+		/* Negative dentry - don`t care */
+		if (!simple_positive(dentry)) {
+			next = next->next;
+			continue;
+		}
+
+		if (!list_empty(&dentry->d_subdirs)) {
+			this_parent = dentry;
+			goto repeat;
+		}
+
+		next = next->next;
+		spin_unlock(&dcache_lock);
+
+		DPRINTK("dentry %p %.*s",
+			dentry, (int)dentry->d_name.len, dentry->d_name.name);
+
+		dput(dentry);
+		spin_lock(&dcache_lock);
+	}
+
+	if (this_parent != sbi->root) {
+		struct dentry *dentry = this_parent;
+
+		next = this_parent->d_child.next;
+		this_parent = this_parent->d_parent;
+		spin_unlock(&dcache_lock);
+		DPRINTK("parent dentry %p %.*s",
+			dentry, (int)dentry->d_name.len, dentry->d_name.name);
+		dput(dentry);
+		spin_lock(&dcache_lock);
+		goto resume;
+	}
+	spin_unlock(&dcache_lock);
+
+	dput(sbi->root);
+	sbi->root = NULL;
+	shrink_dcache_sb(sbi->sb);
+
+	return;
+}
+
 static void autofs4_put_super(struct super_block *sb)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(sb);
@@ -85,6 +146,10 @@
 	if ( !sbi->catatonic )
 		autofs4_catatonic_mode(sbi); /* Free wait queues, close pipe */
 
+	/* Clean up and release dangling references */
+	if (sbi)
+		autofs4_force_release(sbi);
+
 	kfree(sbi);
 
 	DPRINTK("shutting down");
@@ -199,6 +264,7 @@
 
 	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
+	sbi->root = NULL;
 	sbi->catatonic = 0;
 	sbi->exp_timeout = 0;
 	sbi->oz_pgrp = process_group(current);
@@ -267,6 +333,13 @@
 	sbi->pipe = pipe;
 
 	/*
+	 * Take a reference to the root dentry so we get a chance to
+	 * clean up the dentry tree on umount.
+	 * See autofs4_force_release.
+	 */
+	sbi->root = dget(root);
+
+	/*
 	 * Success! Install the root dentry now to indicate completion.
 	 */
 	s->s_root = root;

