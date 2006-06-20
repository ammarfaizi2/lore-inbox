Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWFTLvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWFTLvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWFTLvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:51:00 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45953 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030227AbWFTLuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:50:52 -0400
Message-Id: <20060620114747.340658000@sous-sol.org>
References: <20060620114527.934114000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 20 Jun 2006 00:00:08 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Joe Korty <joe.korty@ccur.com>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       Al Viro <viro@ftp.linux.org.uk>, Sergey Vlasov <vsu@altlinux.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 08/13] fs/namei.c: Call to file_permission() under a spinlock in do_lookup_path()
Content-Disposition: inline; filename=fs-namei.c-call-to-file_permission-under-a-spinlock-in-do_lookup_path.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Trond Myklebust <Trond.Myklebust@netapp.com>

We're presently running lock_kernel() under fs_lock via nfs's ->permission
handler.  That's a ranking bug and sometimes a sleep-in-spinlock bug.  This
problem was introduced in the openat() patchset.

We should not need to hold the current->fs->lock for a codepath that doesn't
use current->fs.

[vsu@altlinux.ru: fix error path]
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Al Viro <viro@ftp.linux.org.uk>
Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/namei.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- linux-2.6.16.21.orig/fs/namei.c
+++ linux-2.6.16.21/fs/namei.c
@@ -1077,8 +1077,8 @@ static int fastcall do_path_lookup(int d
 	nd->flags = flags;
 	nd->depth = 0;
 
-	read_lock(&current->fs->lock);
 	if (*name=='/') {
+		read_lock(&current->fs->lock);
 		if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
 			nd->mnt = mntget(current->fs->altrootmnt);
 			nd->dentry = dget(current->fs->altroot);
@@ -1089,33 +1089,35 @@ static int fastcall do_path_lookup(int d
 		}
 		nd->mnt = mntget(current->fs->rootmnt);
 		nd->dentry = dget(current->fs->root);
+		read_unlock(&current->fs->lock);
 	} else if (dfd == AT_FDCWD) {
+		read_lock(&current->fs->lock);
 		nd->mnt = mntget(current->fs->pwdmnt);
 		nd->dentry = dget(current->fs->pwd);
+		read_unlock(&current->fs->lock);
 	} else {
 		struct dentry *dentry;
 
 		file = fget_light(dfd, &fput_needed);
 		retval = -EBADF;
 		if (!file)
-			goto unlock_fail;
+			goto out_fail;
 
 		dentry = file->f_dentry;
 
 		retval = -ENOTDIR;
 		if (!S_ISDIR(dentry->d_inode->i_mode))
-			goto fput_unlock_fail;
+			goto fput_fail;
 
 		retval = file_permission(file, MAY_EXEC);
 		if (retval)
-			goto fput_unlock_fail;
+			goto fput_fail;
 
 		nd->mnt = mntget(file->f_vfsmnt);
 		nd->dentry = dget(dentry);
 
 		fput_light(file, fput_needed);
 	}
-	read_unlock(&current->fs->lock);
 	current->total_link_count = 0;
 	retval = link_path_walk(name, nd);
 out:
@@ -1124,13 +1126,12 @@ out:
 				nd->dentry->d_inode))
 		audit_inode(name, nd->dentry->d_inode, flags);
 	}
+out_fail:
 	return retval;
 
-fput_unlock_fail:
+fput_fail:
 	fput_light(file, fput_needed);
-unlock_fail:
-	read_unlock(&current->fs->lock);
-	return retval;
+	goto out_fail;
 }
 
 int fastcall path_lookup(const char *name, unsigned int flags,

--
