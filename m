Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWGZGeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWGZGeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 02:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWGZGeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 02:34:23 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:43964 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030412AbWGZGeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 02:34:22 -0400
Subject: [patch] lockdep: annotate vfs_rmdir for filesystems that take
	i_mutex in delete_inode
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, reiserfs-list@namesys.com,
       reiserfs-dev@namesys.com, viro@ftp.linux.org.uk,
       viro@zeniv.linux.org.uk, reiser@namesys.com,
       linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
In-Reply-To: <20060725223327.b6d039b2.akpm@osdl.org>
References: <9a8748490607251516j1433306ek9c64cc84c0838f7b@mail.gmail.com>
	 <20060725223327.b6d039b2.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 08:32:04 +0200
Message-Id: <1153895524.2896.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The VFS takes the directory i_mutex and reiserfs_delete_inode() takes the
> to-be-deleted file's i_mutex.
> 
> That's notabug and lockdep will need to be taught about it.

Actually the annotation is in vfs_rmdir() since that is where the parent
is taken (this may sound odd but the I_MUTEX_* ordering rules require
the parent taking to be annotated rather than the child)

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6.18-rc2-git5/fs/namei.c
===================================================================
--- linux-2.6.18-rc2-git5.orig/fs/namei.c
+++ linux-2.6.18-rc2-git5/fs/namei.c
@@ -1967,7 +1967,7 @@ int vfs_rmdir(struct inode *dir, struct 
 
 	DQUOT_INIT(dir);
 
-	mutex_lock(&dentry->d_inode->i_mutex);
+	mutex_lock_nested(&dentry->d_inode->i_mutex, I_MUTEX_PARENT);
 	dentry_unhash(dentry);
 	if (d_mountpoint(dentry))
 		error = -EBUSY;

