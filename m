Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130012AbRAJIWS>; Wed, 10 Jan 2001 03:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbRAJIWJ>; Wed, 10 Jan 2001 03:22:09 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:39044 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130012AbRAJIV4>; Wed, 10 Jan 2001 03:21:56 -0500
Message-ID: <3A5C1CF2.170E0A04@uow.edu.au>
Date: Wed, 10 Jan 2001 19:27:30 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Brian O'Keefe" <okeefe@spinnakernet.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: NFS client deadlock on SMP machines
In-Reply-To: <3A5B42BF.EC16F7EE@spinnakernet.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian O'Keefe wrote:
> 
> I'm not sure yet if this is a true bug, but it sure seems like one...
> 
> I've got a 2-processor machine that I'm using as an NFS client. I've
> written some code that is doing a boatload of NFS reads from this
> client, locking whole files as read-only as I do each read. I've got
> multiple processes running the same code. Pretty regularly, I can get
> this client machine to lock up. I've scoured the web looking for hints
> about what might be wrong, and I'm using a kgdb to debug this from a
> remote machine.

Kernel 2.4.0.

Brian,

linux-smp@vger is rather dead.  You certainly won't get the
attention of the NFS developers there.

>From your excellent description it seems that the kernel
is calling schedule() with nfs_flushd_lock held.  The same
CPU comes back into the NFS code on behalf of a different task,
hits the lock and it's lights out.

This is pretty hard to track down.  One approach is
to put

	show_stack(p->thread.esp);

right at the end of kernel/sched.c:show_task().  When the deadlock
happens, type ALT-SYSRQ-T, pray like hell that the debug output
makes it to disk.  Reboot, feed the logs into ksymoops, see which
task is sleeping within the NFS code.

The alternative is to read the code :)

There appear to be two places where the NFS client code can
deadlock:

nfs_reqlist_init()
{
  spin_lock(&nfs_flushd_lock);
  rpc_new_task->
    rpc_allocate->
      ->kmalloc(GFP_RPC)   (__GFP_WAIT is true)


inode_remove_flushd()
{
  spin_lock(&nfs_flushd_lock);
  iput(inode)->
    nfs_delete_inode->
      delete_inode->
        wait_on_inode
    truncate_inode_pages->
      truncate_list_pages->
        wait_on_page

The latter is most likely the problem.  Here's a patch - please
test.  The inode_remove_flush() change is correct.  Not so
sure about the nfs_reqlist_init() change.


--- linux-2.4.0/fs/nfs/flushd.c	Sat Jun 24 15:39:46 2000
+++ linux-akpm/fs/nfs/flushd.c	Wed Jan 10 19:25:44 2001
@@ -55,7 +55,7 @@
 /*
  * Spinlock
  */
-spinlock_t nfs_flushd_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t nfs_flushd_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  * Local function declarations.
@@ -71,6 +71,7 @@
 	int			status = 0;
 
 	dprintk("NFS: writecache_init\n");
+	task = rpc_new_task(server->client, NULL, RPC_TASK_ASYNC);
 	spin_lock(&nfs_flushd_lock);
 	cache = server->rw_requests;
 
@@ -79,7 +80,6 @@
 
 	/* Create the RPC task */
 	status = -ENOMEM;
-	task = rpc_new_task(server->client, NULL, RPC_TASK_ASYNC);
 	if (!task)
 		goto out_unlock;
 
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
