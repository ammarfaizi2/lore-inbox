Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263728AbUECOzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbUECOzK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 10:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUECOzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 10:55:10 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:58630 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263728AbUECOyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 10:54:55 -0400
Date: Mon, 3 May 2004 22:56:29 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm1
In-Reply-To: <20040430014658.112a6181.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405032250060.4454@donald.themaw.net>
References: <20040430014658.112a6181.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.7, required 8,
	IN_REP_TO, NO_REAL_NAME, PATCH_UNIFIED_DIFF, REFERENCES,
	USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The case where two process similtaneously trigger a mount in autofs4 can 
cause multiple requests to the daemon for the same mount. The daemon 
handles this OK but it's possible an incorrect error to be returned. For 
this reason I believe it is better to change the spin lock to a semaphore 
in waitq.c. This makes the second and subsequent request wait on the q as 
ther supposed to.

Comments and questions welcome.

--- linux-2.6.6-rc3-mm1/fs/autofs4/autofs_i.h.orig	2004-05-03 18:47:46.000000000 +0800
+++ linux-2.6.6-rc3-mm1/fs/autofs4/autofs_i.h	2004-05-03 18:49:53.000000000 +0800
@@ -100,6 +100,7 @@
 	int reghost_enabled;
 	int needs_reghost;
 	struct super_block *sb;
+	struct semaphore wq_sem;
 	struct autofs_wait_queue *queues; /* Wait queue pointer */
 };
 
--- linux-2.6.6-rc3-mm1/fs/autofs4/inode.c.orig	2004-05-03 18:50:02.000000000 +0800
+++ linux-2.6.6-rc3-mm1/fs/autofs4/inode.c	2004-05-03 18:52:42.000000000 +0800
@@ -205,6 +205,7 @@
 	sbi->sb = s;
 	sbi->version = 0;
 	sbi->sub_version = 0;
+	init_MUTEX(&sbi->wq_sem);
 	sbi->queues = NULL;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
--- linux-2.6.6-rc3-mm1/fs/autofs4/waitq.c.orig	2004-05-03 18:45:05.000000000 +0800
+++ linux-2.6.6-rc3-mm1/fs/autofs4/waitq.c	2004-05-03 19:12:35.000000000 +0800
@@ -17,8 +17,6 @@
 #include <linux/file.h>
 #include "autofs_i.h"
 
-static spinlock_t waitq_lock = SPIN_LOCK_UNLOCKED;
-
 /* We make this a static variable rather than a part of the superblock; it
    is better if we don't reassign numbers easily even across filesystems */
 static autofs_wqt_t autofs4_next_wait_queue = 1;
@@ -180,40 +178,43 @@
 		return -ENOENT;
 	}
 
-	spin_lock(&waitq_lock);
+	if (down_interruptible(&sbi->wq_sem)) {
+		kfree(name);
+		return -EINTR;
+	}
+
 	for (wq = sbi->queues ; wq ; wq = wq->next) {
 		if (wq->hash == dentry->d_name.hash &&
 		    wq->len == len &&
 		    wq->name && !memcmp(wq->name, name, len))
 			break;
 	}
-	spin_unlock(&waitq_lock);
-	
+
 	if ( !wq ) {
 		/* Create a new wait queue */
 		wq = kmalloc(sizeof(struct autofs_wait_queue),GFP_KERNEL);
 		if ( !wq ) {
 			kfree(name);
+			up(&sbi->wq_sem);
 			return -ENOMEM;
 		}
 
-		spin_lock(&waitq_lock);
 		wq->wait_queue_token = autofs4_next_wait_queue;
 		if (++autofs4_next_wait_queue == 0)
 			autofs4_next_wait_queue = 1;
 		wq->next = sbi->queues;
 		sbi->queues = wq;
-		spin_unlock(&waitq_lock);
 		init_waitqueue_head(&wq->queue);
 		wq->hash = dentry->d_name.hash;
 		wq->name = name;
 		wq->len = len;
 		wq->status = -EINTR; /* Status return if interrupted */
+		atomic_set(&wq->wait_ctr, 2);
+		up(&sbi->wq_sem);
 
 		DPRINTK(("autofs4_wait: new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
 			 (unsigned long) wq->wait_queue_token, wq->len, wq->name, notify));
 		/* autofs4_notify_daemon() may block */
-		atomic_set(&wq->wait_ctr, 2);
 		if (notify != NFY_NONE) {
 			autofs4_notify_daemon(sbi,wq, 
 					notify == NFY_MOUNT ?
@@ -222,6 +223,7 @@
 		}
 	} else {
 		atomic_inc(&wq->wait_ctr);
+		up(&sbi->wq_sem);
 		DPRINTK(("autofs4_wait: existing wait id = 0x%08lx, name = %.*s, nfy=%d\n",
 			 (unsigned long) wq->wait_queue_token, wq->len, wq->name, notify));
 	}
@@ -260,7 +262,8 @@
 
 	status = wq->status;
 
-	if (atomic_dec_and_test(&wq->wait_ctr))	/* Are we the last process to need status? */
+	/* Are we the last process to need status? */
+	if (atomic_dec_and_test(&wq->wait_ctr))
 		kfree(wq);
 
 	return status;
@@ -271,19 +274,19 @@
 {
 	struct autofs_wait_queue *wq, **wql;
 
-	spin_lock(&waitq_lock);
+	down(&sbi->wq_sem);
 	for ( wql = &sbi->queues ; (wq = *wql) ; wql = &wq->next ) {
 		if ( wq->wait_queue_token == wait_queue_token )
 			break;
 	}
 
 	if ( !wq ) {
-		spin_unlock(&waitq_lock);
+		up(&sbi->wq_sem);
 		return -EINVAL;
 	}
 
 	*wql = wq->next;	/* Unlink from chain */
-	spin_unlock(&waitq_lock);
+	up(&sbi->wq_sem);
 	kfree(wq->name);
 	wq->name = NULL;	/* Do not wait on this queue */
 

