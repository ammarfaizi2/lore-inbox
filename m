Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131512AbRAJMlF>; Wed, 10 Jan 2001 07:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131556AbRAJMk4>; Wed, 10 Jan 2001 07:40:56 -0500
Received: from mail.spinnakernet.com ([141.151.129.90]:21774 "EHLO 
	mail.spinnakernet.com") by vger.kernel.org with ESMTP
	id <S131512AbRAJMkm>; Wed, 10 Jan 2001 07:40:42 -0500
Message-ID: <3A5C589D.DC8A90AA@spinnakernet.com>
Date: Wed, 10 Jan 2001 07:42:05 -0500
From: "Brian O'Keefe" <okeefe@spinnakernet.com>
Organization: Spinnaker Networks, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Andrew Morton <andrewm@uow.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: NFS client deadlock on SMP machines
In-Reply-To: <3A5B42BF.EC16F7EE@spinnakernet.com>
		<3A5C1CF2.170E0A04@uow.edu.au> <14940.12224.406961.510615@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> Doh. You're quite right on both accounts. I made a small modification
> to your patch for the rpc_new_task() problem (you forgot to release
> the RPC task if it's not used).
> 
> Linus, please apply for 2.4.1...

Thanks guys! I'm testing it now, and so far, so good. I've merged
Andrew's and Trond's patches into one:

*******************************************
--- linux-2.4.0/fs/nfs/flushd.c.orig       Wed Jan 10 07:18:32 2001
+++ linux-2.4.0/fs/nfs/flushd.c    Wed Jan 10 07:18:38 2001
@@ -55,7 +55,7 @@
 /*
  * Spinlock
  */
-spinlock_t nfs_flushd_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t nfs_flushd_lock = SPIN_LOCK_UNLOCKED;

 /*
  * Local function declarations.
@@ -71,18 +71,17 @@
        int                     status = 0;

        dprintk("NFS: writecache_init\n");
+
+       /* Create the RPC task */
+       if (!(task = rpc_new_task(server->client, NULL,
RPC_TASK_ASYNC)))
+               return -ENOMEM;
+
        spin_lock(&nfs_flushd_lock);
        cache = server->rw_requests;

        if (cache->task)
                goto out_unlock;

-       /* Create the RPC task */
-       status = -ENOMEM;
-       task = rpc_new_task(server->client, NULL, RPC_TASK_ASYNC);
-       if (!task)
-               goto out_unlock;
-
        task->tk_calldata = server;

        cache->task = task;
@@ -99,6 +98,7 @@
        return 0;
  out_unlock:
        spin_unlock(&nfs_flushd_lock);
+       rpc_release_task(task);
        return status;
 }

@@ -195,7 +195,9 @@
        if (*q) {
                *q = inode->u.nfs_i.hash_next;
                NFS_FLAGS(inode) &= ~NFS_INO_FLUSH;
+               spin_unlock(&nfs_flushd_lock);
                iput(inode);
+               return;
        }
  out:
        spin_unlock(&nfs_flushd_lock);
*******************************************


Brian O'Keefe
Spinnaker Networks, Inc.
okeefe@spinnakernet.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
