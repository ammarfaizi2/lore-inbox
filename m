Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUDELxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 07:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUDELxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 07:53:03 -0400
Received: from proxy.helios.de ([193.141.98.37]:65180 "EHLO proxy.helios.de")
	by vger.kernel.org with ESMTP id S262101AbUDELw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 07:52:56 -0400
From: Peter Waechtler <peter@helios.de>
Organization: Helios Software GmbH
To: Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] core not owned by euid, mm->dumpable
Date: Mon, 5 Apr 2004 13:51:57 +0200
User-Agent: KMail/1.5.4
References: <16293307.1081153633839.JavaMail.pwaechtler@mac.com>
In-Reply-To: <16293307.1081153633839.JavaMail.pwaechtler@mac.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dhUcAmsVTLd2a3F"
Message-Id: <200404051351.57667.peter@helios.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_dhUcAmsVTLd2a3F
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Montag, 5. April 2004 10:27 schrieb Peter Waechtler:
> With the current behavior typical server programs that switch euid
> don't dump core. This is done "for security".
> If the core file pattern exists the dump is written to but readable
> for the file owner (not necessarily root - don't argue: only chdir into
> dirs that only root can write to: think of file servers like samba)
>
> The patch below addresses this (but still not perfect).
> What I would like to see: instead of mm->dumpable=0 when calling seteuid()
> something like mm->dumpAs=root and making sure that the core is owned by
> root mode 600
>
> I could install a sighandler that calls prctl(PR_SET_DUMPABLE,1,0,0,0),
> switch euid to root, but still the formerly placed core is owned by evil
> user :(
> Then I could read the core pattern and unlink such a file - and all this
> just for the Linux platform...
>

Unlink a previously existing core.
I tried on solaris - I find the behavior (tunable with coreadm) perfect:
Switched uid? -> create as root (unlink a previously and potentially opened
core first: yes it got a new inode) then creat(O_EXCL,0600)


--Boundary-00=_dhUcAmsVTLd2a3F
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="linux-core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="linux-core.patch"

--- fs/namei.c.orig	2004-04-05 13:44:30.317084264 +0200
+++ fs/namei.c	2004-04-05 13:45:40.668389240 +0200
@@ -1694,24 +1694,13 @@
 	return error;
 }
 
-/*
- * Make sure that the actual truncation of the file will occur outside its
- * directory's i_sem.  Truncate can take a long time if there is a lot of
- * writeout happening, and we don't want to prevent access to the directory
- * while waiting on the I/O.
- */
-asmlinkage long sys_unlink(const char __user * pathname)
+int do_unlink(char *name)
 {
 	int error = 0;
-	char * name;
 	struct dentry *dentry;
 	struct nameidata nd;
 	struct inode *inode = NULL;
 
-	name = getname(pathname);
-	if(IS_ERR(name))
-		return PTR_ERR(name);
-
 	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
@@ -1736,8 +1725,6 @@
 exit1:
 	path_release(&nd);
 exit:
-	putname(name);
-
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	return error;
@@ -1748,6 +1735,25 @@
 	goto exit2;
 }
 
+/*
+ * Make sure that the actual truncation of the file will occur outside its
+ * directory's i_sem.  Truncate can take a long time if there is a lot of
+ * writeout happening, and we don't want to prevent access to the directory
+ * while waiting on the I/O.
+ */
+asmlinkage long sys_unlink(const char __user * pathname)
+{
+	char * name;
+
+	name = getname(pathname);
+	if(IS_ERR(name))
+		return PTR_ERR(name);
+
+	error = do_unlink(name);
+	putname(name);
+	return error;
+}
+
 int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
 {
 	int error = may_create(dir, dentry, NULL);
--- fs/exec.c.orig	2004-04-05 09:41:31.134456912 +0200
+++ fs/exec.c	2004-04-05 13:50:17.093366256 +0200
@@ -1387,9 +1387,14 @@
 		goto fail_unlock;
 
  	format_corename(corename, core_pattern, signr);
-	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
-	if (IS_ERR(file))
-		goto fail_unlock;
+	file = filp_open(corename, O_CREAT | O_EXCL | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
+	if (IS_ERR(file)){
+		if (do_unlink(corename))
+			goto fail_unlock;
+		file = filp_open(corename, O_CREAT | O_EXCL | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
+		if (IS_ERR(file))
+			goto fail_unlock;
+	}
 	inode = file->f_dentry->d_inode;
 	if (inode->i_nlink > 1)
 		goto close_fail;	/* multiple links - don't dump */
--- include/linux/fs.h.orig	2004-04-05 09:42:52.205132296 +0200
+++ include/linux/fs.h	2004-04-05 13:50:46.119953544 +0200
@@ -1253,6 +1253,7 @@
 
 extern int open_namei(const char *, int, int, struct nameidata *);
 extern int may_open(struct nameidata *, int, int);
+extern int do_unlink(char *);
 
 extern int kernel_read(struct file *, unsigned long, char *, unsigned long);
 extern struct file * open_exec(const char *);

--Boundary-00=_dhUcAmsVTLd2a3F--

