Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUEHKNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUEHKNh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 06:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUEHKNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 06:13:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:62421 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264231AbUEHKNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 06:13:25 -0400
Date: Sat, 8 May 2004 03:12:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: manfred@colorfullife.com, davej@redhat.com, torvalds@osdl.org,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-Id: <20040508031254.1d7dbc8a.akpm@osdl.org>
In-Reply-To: <20040508031159.782d6a46.akpm@osdl.org>
References: <20040506200027.GC26679@redhat.com>
	<20040506150944.126bb409.akpm@osdl.org>
	<409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> - NFS and AFS are modifying d_flags without dcache_lock.
> 


 25-akpm/fs/afs/dir.c    |    2 ++
 25-akpm/fs/nfs/unlink.c |    4 ++++
 2 files changed, 6 insertions(+)

diff -puN fs/nfs/unlink.c~d_flags-locking-fix fs/nfs/unlink.c
--- 25/fs/nfs/unlink.c~d_flags-locking-fix	2004-05-08 03:03:14.075568032 -0700
+++ 25-akpm/fs/nfs/unlink.c	2004-05-08 03:04:02.561197096 -0700
@@ -180,7 +180,9 @@ nfs_async_unlink(struct dentry *dentry)
 	task->tk_action = nfs_async_unlink_init;
 	task->tk_release = nfs_async_unlink_release;
 
+	spin_lock(&dcache_lock);
 	dentry->d_flags |= DCACHE_NFSFS_RENAMED;
+	spin_unlock(&dcache_lock);
 	data->cred = rpcauth_lookupcred(clnt->cl_auth, 0);
 
 	rpc_sleep_on(&nfs_delete_queue, task, NULL, NULL);
@@ -210,7 +212,9 @@ nfs_complete_unlink(struct dentry *dentr
 		return;
 	data->count++;
 	nfs_copy_dname(dentry, data);
+	spin_lock(&dcache_lock);
 	dentry->d_flags &= ~DCACHE_NFSFS_RENAMED;
+	spin_unlock(&dcache_lock);
 	if (data->task.tk_rpcwait == &nfs_delete_queue)
 		rpc_wake_up_task(&data->task);
 	nfs_put_unlinkdata(data);
diff -puN fs/afs/dir.c~d_flags-locking-fix fs/afs/dir.c
--- 25/fs/afs/dir.c~d_flags-locking-fix	2004-05-08 03:03:14.404518024 -0700
+++ 25-akpm/fs/afs/dir.c	2004-05-08 03:04:20.190517032 -0700
@@ -615,7 +615,9 @@ static int afs_d_revalidate(struct dentr
 
 	/* the dirent, if it exists, now points to a different vnode */
  not_found:
+	spin_lock(&dcache_lock);
 	dentry->d_flags |= DCACHE_NFSFS_RENAMED;
+	spin_unlock(&dcache_lock);
 
  out_bad:
 	if (inode) {

_

