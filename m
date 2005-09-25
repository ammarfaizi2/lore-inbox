Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVIYGnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVIYGnv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 02:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVIYGnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 02:43:41 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:12813 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751198AbVIYGn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 02:43:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=WF5vRlfnba0j+XVCTfFNt6v0RIgG6XwbXRSkmfODDB1BUEd+6QyAd9TBDbhAcEW8i4Ax/79FHX42idcKYkJg88zLHDyeD2cBUNacAJy5ZTWeWWNp5+tC99HnmaHTDKzTpFUdbxCUXnXgbUE5YOZI3NAkm3BN+O181eTMyITF1e0=
From: Tejun Heo <htejun@gmail.com>
To: zwane@linuxpower.ca, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050925064218.E7558977@htj.dyndns.org>
In-Reply-To: <20050925064218.E7558977@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6 03/04] brsem: fix ro-remount <-> open race condition
Message-ID: <20050925064218.367B8B6E@htj.dyndns.org>
Date: Sun, 25 Sep 2005 15:43:22 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03_brsem_fix-remount-open-race.patch

	A file can be opened rw while ro-remounting is in progress
	resulting in open rw file on ro mounted filesystem.  This
	patch kills the race by making permission check and the rest
	of open atomic w.r.t. remounting.  Other file operations also
	have this race condition and should be fixed in similar
	manner.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 namei.c |   11 ++++++++++-
 open.c  |   12 ++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

Index: linux-work/fs/namei.c
===================================================================
--- linux-work.orig/fs/namei.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/fs/namei.c	2005-09-25 15:42:04.000000000 +0900
@@ -1412,6 +1412,12 @@ int may_open(struct nameidata *nd, int a
  *			  11 - read/write permissions needed
  * which is a lot more logical, and also allows the "no perm" needed
  * for symlinks (where the permissions are checked later).
+ *
+ * nd->mnt->mnt_sb->s_umount brsem is read-locked on successful return
+ * from this function.  This is to make permission checking and the
+ * actual open operation atomic w.r.t. remounting.  The caller must
+ * release s_umount after open is complete.
+ *
  * SMP-safe
  */
 int open_namei(const char * pathname, int flag, int mode, struct nameidata *nd)
@@ -1512,9 +1518,12 @@ do_last:
 	if (path.dentry->d_inode && S_ISDIR(path.dentry->d_inode->i_mode))
 		goto exit;
 ok:
+	brsem_down_read(nd->mnt->mnt_sb->s_umount);
 	error = may_open(nd, acc_mode, flag);
-	if (error)
+	if (error) {
+		brsem_up_read(nd->mnt->mnt_sb->s_umount);
 		goto exit;
+	}
 	return 0;
 
 exit_dput:
Index: linux-work/fs/open.c
===================================================================
--- linux-work.orig/fs/open.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/fs/open.c	2005-09-25 15:42:04.000000000 +0900
@@ -828,8 +828,16 @@ struct file *filp_open(const char * file
 		return ERR_PTR(error);
 
 	error = open_namei(filename, namei_flags, mode, &nd);
-	if (!error)
-		return __dentry_open(nd.dentry, nd.mnt, flags, f);
+	if (!error) {
+		f = __dentry_open(nd.dentry, nd.mnt, flags, f);
+		/*
+		 * On successful return from open_namei(), s_umount is
+		 * read-locked, see comment above open_namei() for
+		 * more information.
+		 */
+		brsem_up_read(nd.mnt->mnt_sb->s_umount);
+		return f;
+	}
 
 	put_filp(f);
 	return ERR_PTR(error);

