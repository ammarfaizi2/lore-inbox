Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131846AbRAJJsX>; Wed, 10 Jan 2001 04:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135202AbRAJJsO>; Wed, 10 Jan 2001 04:48:14 -0500
Received: from mons.uio.no ([129.240.130.14]:1214 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S131846AbRAJJsI>;
	Wed, 10 Jan 2001 04:48:08 -0500
Message-ID: <14940.12224.406961.510615@charged.uio.no>
Date: Wed, 10 Jan 2001 10:47:44 +0100 (CET)
To: Andrew Morton <andrewm@uow.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: "Brian O'Keefe" <okeefe@spinnakernet.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: NFS client deadlock on SMP machines
In-Reply-To: <3A5C1CF2.170E0A04@uow.edu.au>
In-Reply-To: <3A5B42BF.EC16F7EE@spinnakernet.com>
	<3A5C1CF2.170E0A04@uow.edu.au>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <andrewm@uow.edu.au> writes:

     > There appear to be two places where the NFS client code can
     > deadlock:

     > nfs_reqlist_init() {
     >   spin_lock(&nfs_flushd_lock);
     >   rpc_new_task->
     >     rpc_allocate->
     >       -> kmalloc(GFP_RPC) (__GFP_WAIT is true)


     > inode_remove_flushd() {
     >   spin_lock(&nfs_flushd_lock);
     >   iput(inode)->
     >     nfs_delete_inode->
     >       delete_inode->
     >         wait_on_inode
     >   truncate_inode_pages->
     >     truncate_list_pages->
     >         wait_on_page

     > The latter is most likely the problem.  Here's a patch - please
     > test.  The inode_remove_flush() change is correct.  Not so sure
     > about the nfs_reqlist_init() change.


Doh. You're quite right on both accounts. I made a small modification
to your patch for the rpc_new_task() problem (you forgot to release
the RPC task if it's not used).

Linus, please apply for 2.4.1...

Cheers,
  Trond

--- linux-2.4.0/fs/nfs/flushd.c.orig	Wed Jun 21 16:25:17 2000
+++ linux-2.4.0/fs/nfs/flushd.c	Wed Jan 10 10:44:08 2001
@@ -71,18 +71,17 @@
 	int			status = 0;
 
 	dprintk("NFS: writecache_init\n");
+
+	/* Create the RPC task */
+	if (!(task = rpc_new_task(server->client, NULL, RPC_TASK_ASYNC)))
+		return -ENOMEM;
+
 	spin_lock(&nfs_flushd_lock);
 	cache = server->rw_requests;
 
 	if (cache->task)
 		goto out_unlock;
 
-	/* Create the RPC task */
-	status = -ENOMEM;
-	task = rpc_new_task(server->client, NULL, RPC_TASK_ASYNC);
-	if (!task)
-		goto out_unlock;
-
 	task->tk_calldata = server;
 
 	cache->task = task;
@@ -99,6 +98,7 @@
 	return 0;
  out_unlock:
 	spin_unlock(&nfs_flushd_lock);
+	rpc_release_task(task);
 	return status;
 }
 
@@ -195,7 +195,9 @@
 	if (*q) {
 		*q = inode->u.nfs_i.hash_next;
 		NFS_FLAGS(inode) &= ~NFS_INO_FLUSH;
+		spin_unlock(&nfs_flushd_lock);
 		iput(inode);
+		return;
 	}
  out:
 	spin_unlock(&nfs_flushd_lock);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
