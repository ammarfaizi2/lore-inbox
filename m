Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTEUWrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 18:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTEUWrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 18:47:20 -0400
Received: from smtp01.web.de ([217.72.192.180]:40726 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262328AbTEUWrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 18:47:14 -0400
Date: Thu, 22 May 2003 01:15:55 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Convert fs/nfsd to seq_path()
Message-Id: <20030522011555.4be2c349.l.s.r@web.de>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this patch makes the Kernel NFS server code use seq_path() which Al
wrote recently.

René



diff -ur linux-2.5.69-bk/fs/nfsd/export.c~ linux-2.5.69-bk/fs/nfsd/export.c
--- linux-2.5.69-bk/fs/nfsd/export.c~	2003-05-22 00:43:16.000000000 +0200
+++ linux-2.5.69-bk/fs/nfsd/export.c	2003-05-22 00:14:46.000000000 +0200
@@ -972,17 +972,11 @@
 		seq_printf(m, "%sanongid=%d", first++?",":"", anong);
 }
 
-static inline void mangle(struct seq_file *m, const char *s)
-{
-	seq_escape(m, s, " \t\n\\");
-}
-
 static int e_show(struct seq_file *m, void *p)
 {
 	struct cache_head *cp = p;
 	struct svc_export *exp = container_of(cp, struct svc_export, h);
 	svc_client *clp;
-	char *pbuf;
 
 	if (p == (void *)1) {
 		seq_puts(m, "# Version 1.1\n");
@@ -995,12 +989,10 @@
 	if (cache_check(&svc_export_cache, &exp->h, NULL))
 		return 0;
 	if (cache_put(&exp->h, &svc_export_cache)) BUG();
-	pbuf = m->private;
-	mangle(m, d_path(exp->ex_dentry, exp->ex_mnt,
-			 pbuf, PAGE_SIZE));
+	seq_path(m, exp->ex_mnt, exp->ex_dentry, " \t\n\\");
 
 	seq_putc(m, '\t');
-	mangle(m, clp->name);
+	seq_escape(m, clp->name, " \t\n\\");
 	seq_putc(m, '(');
 	exp_flags(m, exp->ex_flags, exp->ex_fsid, 
 		  exp->ex_anon_uid, exp->ex_anon_gid);
diff -ur linux-2.5.69-bk/fs/nfsd/nfsctl.c~ linux-2.5.69-bk/fs/nfsd/nfsctl.c
--- linux-2.5.69-bk/fs/nfsd/nfsctl.c~	2003-05-22 00:43:16.000000000 +0200
+++ linux-2.5.69-bk/fs/nfsd/nfsctl.c	2003-05-22 00:39:17.000000000 +0200
@@ -175,32 +175,13 @@
 extern struct seq_operations nfs_exports_op;
 static int exports_open(struct inode *inode, struct file *file)
 {
-	int res;
-	char *namebuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (namebuf == NULL)
-		return -ENOMEM;
-
-	res = seq_open(file, &nfs_exports_op);
-	if (res)
-		kfree(namebuf);
-	else
-		((struct seq_file *)file->private_data)->private = namebuf;
-
-	return res;
-}
-static int exports_release(struct inode *inode, struct file *file)
-{
-	struct seq_file *m = (struct seq_file *)file->private_data;
-	kfree(m->private);
-	m->private = NULL;
-	return seq_release(inode, file);
+	return seq_open(file, &nfs_exports_op);
 }
-
 static struct file_operations exports_operations = {
 	.open		= exports_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= exports_release,
+	.release	= seq_release,
 };
 
 /*----------------------------------------------------------------------------*/
