Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbUBHPet (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 10:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbUBHPdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 10:33:05 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:30980 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263726AbUBHPca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 10:32:30 -0500
Date: Sun, 8 Feb 2004 23:32:08 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] nfs or autofs related hangs
In-Reply-To: <E1AoQvL-0002NP-00.ia6432-inbox-ru@f21.mail.ru>
Message-ID: <Pine.LNX.4.58.0402082326270.5926@raven.themaw.net>
References: <E1AoQvL-0002NP-00.ia6432-inbox-ru@f21.mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, PATCH_UNIFIED_DIFF, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004, [koi8-r] "Peter Lojkin[koi8-r] "  wrote:

> Hello,
> 
> i'm not sure which list is correct to post about
> our problem so i'm cc'ing both autofs and nfs lists...
> 
> some of our server keep hanging (well just any nfs
> access hangs) and there're always stuck
> "umount //auto/dir" or "umount //home/dir"
> processes (btw i thought that double "/" problem
> was fixed?). 
> 
> i've done sysrq-t traces (attached) when this
> happened with stock 2.4.22 + NFS_ALL (by trond) and
> with 2.4.23aa1 + autofs4-2.4.22.patch
> in both cases autofs-4.1.0 were used but there're
> the same hangs with debian autofs-3.9.99-4.0.0pre10-1
> and autofs-3.9.99-4.0.0pre10-16
> there're no oopses or any error messages prior to
> hang. we have no such problem with 2.4.20aa kernels
> but on newer servers we can't go below 2.4.22 because
> of hardware compatibility.

Looking at the trace I can't tell if autofs v4 is causing this but I 
believe there is a potential race in the wait queue code of the autofs4 
module.

Could you try this patch please.

diff -Nur linux-2.4.22.orig/fs/autofs4/autofs_i.h linux-2.4.22.waitq/fs/autofs4/autofs_i.h
--- linux-2.4.22.orig/fs/autofs4/autofs_i.h	2004-02-08 09:24:12.000000000 +0800
+++ linux-2.4.22.waitq/fs/autofs4/autofs_i.h	2004-02-08 23:12:12.000000000 +0800
@@ -73,7 +73,6 @@
 struct autofs_wait_queue {
 	wait_queue_head_t queue;
 	struct autofs_wait_queue *next;
-	struct task_struct *owner;
 	autofs_wqt_t wait_queue_token;
 	/* We use the following to see what we are waiting for */
 	int hash;
@@ -81,7 +80,7 @@
 	char *name;
 	/* This is for status reporting upon return */
 	int status;
-	int wait_ctr;
+	atomic_t wait_ctr;
 };
 
 #define AUTOFS_SBI_MAGIC 0x6d4a556d
diff -Nur linux-2.4.22.orig/fs/autofs4/waitq.c linux-2.4.22.waitq/fs/autofs4/waitq.c
--- linux-2.4.22.orig/fs/autofs4/waitq.c	2004-02-08 09:24:12.000000000 +0800
+++ linux-2.4.22.waitq/fs/autofs4/waitq.c	2004-02-08 23:19:07.000000000 +0800
@@ -17,6 +17,8 @@
 #include <linux/file.h>
 #include "autofs_i.h"
 
+static spinlock_t waitq_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+
 /* We make this a static variable rather than a part of the superblock; it
    is better if we don't reassign numbers easily even across filesystems */
 static autofs_wqt_t autofs4_next_wait_queue = 1;
@@ -181,12 +183,14 @@
 		return -ENOENT;
 	}
 
+	spin_lock(&waitq_lock);
 	for ( wq = sbi->queues ; wq ; wq = wq->next ) {
 		if ( wq->hash == dentry->d_name.hash &&
 		     wq->len == len &&
 		     wq->name && !memcmp(wq->name, name, len) )
 			break;
 	}
+	spin_unlock(&waitq_lock);
 	
 	if ( !wq ) {
 		/* Create a new wait queue */
@@ -196,22 +200,23 @@
 			return -ENOMEM;
 		}
 
+		spin_lock(&waitq_lock);
 		wq->wait_queue_token = autofs4_next_wait_queue;
 		if (++autofs4_next_wait_queue == 0)
 			autofs4_next_wait_queue = 1;
+		wq->next = sbi->queues;
+		sbi->queues = wq;
+		spin_unlock(&waitq_lock);
 		init_waitqueue_head(&wq->queue);
-		wq->owner = current;
 		wq->hash = dentry->d_name.hash;
 		wq->name = name;
 		wq->len = len;
 		wq->status = -EINTR; /* Status return if interrupted */
-		wq->next = sbi->queues;
-		sbi->queues = wq;
 
 		DPRINTK(("autofs4_wait: new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
 			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify));
 		/* autofs4_notify_daemon() may block */
-		wq->wait_ctr = 2;
+		atomic_set(&wq->wait_ctr, 2);
 		if (notify != NFY_NONE) {
 			autofs4_notify_daemon(sbi,wq, 
 				notify == NFY_MOUNT ? 
@@ -219,7 +224,7 @@
 				       	autofs_ptype_expire_multi);
 		}
 	} else {
-		wq->wait_ctr++;
+		atomic_inc(&wq->wait_ctr);
 		DPRINTK(("autofs4_wait: existing wait id = 0x%08lx, name = %.*s, nfy=%d\n",
 			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify));
 	}
@@ -248,11 +253,6 @@
 
 		wait_event_interruptible(wq->queue, wq->name == NULL);
 
-		if (waitqueue_active(&wq->queue) && current != wq->owner) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ/10);
-		}
-
 		spin_lock_irqsave(&current->sigmask_lock, irqflags);
 		current->blocked = oldset;
 		recalc_sigpending(current);
@@ -263,7 +263,7 @@
 
 	status = wq->status;
 
-	if (--wq->wait_ctr == 0)	/* Are we the last process to need status? */
+	if (atomic_dec_and_test(&wq->wait_ctr))	/* Are we the last process to need status? */
 		kfree(wq);
 
 	return status;
@@ -274,20 +274,25 @@
 {
 	struct autofs_wait_queue *wq, **wql;
 
+	spin_lock(&waitq_lock);
 	for ( wql = &sbi->queues ; (wq = *wql) ; wql = &wq->next ) {
 		if ( wq->wait_queue_token == wait_queue_token )
 			break;
 	}
-	if ( !wq )
+
+	if ( !wq ) {
+		spin_unlock(&waitq_lock);
 		return -EINVAL;
+	}
 
 	*wql = wq->next;	/* Unlink from chain */
+	spin_unlock(&waitq_lock);
 	kfree(wq->name);
 	wq->name = NULL;	/* Do not wait on this queue */
 
 	wq->status = status;
 
-	if (--wq->wait_ctr == 0)	/* Is anyone still waiting for this guy? */
+	if (atomic_dec_and_test(&wq->wait_ctr))	/* Is anyone still waiting for this guy? */
 		kfree(wq);
 	else
 		wake_up_interruptible(&wq->queue);

