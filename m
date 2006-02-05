Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946154AbWBEAJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946154AbWBEAJG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 19:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946153AbWBEAJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 19:09:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19103 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030218AbWBEAJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 19:09:05 -0500
Date: Sat, 4 Feb 2006 16:08:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: One more unlock missing in error case
Message-Id: <20060204160830.1a9810a2.akpm@osdl.org>
In-Reply-To: <43E4E318.1030304@redhat.com>
References: <43E4E318.1030304@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> wrote:
>
> This patch is needed to in addition to the other unlocking fix which is
>  already applied.  It should be obvious that the system will deadlock in
>  case this isn't done.

hmm.  How's about we undo that goto tangle while we're there?


--- devel/fs/namei.c~nameic-unlock-missing-in-error-case	2006-02-04 15:57:22.000000000 -0800
+++ devel-akpm/fs/namei.c	2006-02-04 16:07:56.000000000 -0800
@@ -1070,6 +1070,8 @@ static int fastcall do_path_lookup(int d
 				unsigned int flags, struct nameidata *nd)
 {
 	int retval = 0;
+	int fput_needed;
+	struct file *file;
 
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags;
@@ -1091,29 +1093,22 @@ static int fastcall do_path_lookup(int d
 		nd->mnt = mntget(current->fs->pwdmnt);
 		nd->dentry = dget(current->fs->pwd);
 	} else {
-		struct file *file;
-		int fput_needed;
 		struct dentry *dentry;
 
 		file = fget_light(dfd, &fput_needed);
-		if (!file) {
-			retval = -EBADF;
-			goto out_fail;
-		}
+		retval = -EBADF;
+		if (!file)
+			goto unlock_fail;
 
 		dentry = file->f_dentry;
 
-		if (!S_ISDIR(dentry->d_inode->i_mode)) {
-			retval = -ENOTDIR;
-			fput_light(file, fput_needed);
-			goto out_fail;
-		}
+		retval = -ENOTDIR;
+		if (!S_ISDIR(dentry->d_inode->i_mode))
+			goto fput_unlock_fail;
 
 		retval = file_permission(file, MAY_EXEC);
-		if (retval) {
-			fput_light(file, fput_needed);
-			goto out_fail;
-		}
+		if (retval)
+			goto fput_unlock_fail;
 
 		nd->mnt = mntget(file->f_vfsmnt);
 		nd->dentry = dget(dentry);
@@ -1127,7 +1122,12 @@ out:
 	if (unlikely(current->audit_context
 		     && nd && nd->dentry && nd->dentry->d_inode))
 		audit_inode(name, nd->dentry->d_inode, flags);
-out_fail:
+	return retval;
+
+fput_unlock_fail:
+	fput_light(file, fput_needed);
+unlock_fail:
+	read_unlock(&current->fs->lock);
 	return retval;
 }
 
_

