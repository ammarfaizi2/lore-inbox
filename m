Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbUDOSpw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUDOSnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:43:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:22717 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263117AbUDOSjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:39:54 -0400
Date: Thu, 15 Apr 2004 11:39:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jakub@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] mq_open() honor leading slash
Message-ID: <20040415113951.G21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SUSv3 requires the following on mq_open() with name containing leading
slash:

	If name begins with the slash character, then processes
	calling mq_open() with the same value of name shall refer to
	the same message queue object, as long as that name has not
	been removed. If name does not begin with the slash character,
	the effect is implementation-defined.  The interpretation of
	slash characters other than the leading slash character in name
	is implementation-defined.

The use of lookup_one_len() to force all lookups relative to the
mqueue_mnt root guarantees absolute rather than relative lookup without
leading slash, and generates an error on a name that contains any slashes
at all.  This is inconsitent with the part of the spec that requires
leading slash to be effectively an absolute path (unless you consider
-EACCES being "the same message queue object" ;-)

Patch below simply eats all leading slashes before passing name to
lookup_one_len() in mq_open() and mq_unlink().

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== ipc/mqueue.c 1.8 vs edited =====
--- 1.8/ipc/mqueue.c	Wed Apr 14 18:37:51 2004
+++ edited/ipc/mqueue.c	Thu Apr 15 10:31:59 2004
@@ -609,7 +609,7 @@
 {
 	struct dentry *dentry;
 	struct file *filp;
-	char *name;
+	char *name, *qname;
 	int fd, error;
 
 	if (IS_ERR(name = getname(u_name)))
@@ -619,8 +619,11 @@
 	if (fd < 0)
 		goto out_putname;
 
+	qname = name;
+	while (*qname == '/')
+		qname++;
 	down(&mqueue_mnt->mnt_root->d_inode->i_sem);
-	dentry = lookup_one_len(name, mqueue_mnt->mnt_root, strlen(name));
+	dentry = lookup_one_len(qname, mqueue_mnt->mnt_root, strlen(qname));
 	if (IS_ERR(dentry)) {
 		error = PTR_ERR(dentry);
 		goto out_err;
@@ -665,7 +668,7 @@
 asmlinkage long sys_mq_unlink(const char __user *u_name)
 {
 	int err;
-	char *name;
+	char *name, *qname;
 	struct dentry *dentry;
 	struct inode *inode = NULL;
 
@@ -673,8 +676,11 @@
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
+	qname = name;
+	while (*qname == '/')
+		qname++;
 	down(&mqueue_mnt->mnt_root->d_inode->i_sem);
-	dentry = lookup_one_len(name, mqueue_mnt->mnt_root, strlen(name));
+	dentry = lookup_one_len(qname, mqueue_mnt->mnt_root, strlen(qname));
 	if (IS_ERR(dentry)) {
 		err = PTR_ERR(dentry);
 		goto out_unlock;
