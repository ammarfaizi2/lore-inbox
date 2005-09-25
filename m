Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbVIYNzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbVIYNzS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 09:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbVIYNy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 09:54:58 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:42421 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751456AbVIYNy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 09:54:56 -0400
Message-ID: <4336AF0D.14CFA6D8@tv-sign.ru>
Date: Sun, 25 Sep 2005 18:07:09 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, George Anzinger <george@mvista.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] kill sigqueue->lock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This lock used in sigqueue_free(), but it is always equal to
current->sighand->siglock, so we don't need to keep it in the
struct sigqueue.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc2/include/linux/signal.h~5_SILOCK	2005-06-18 17:42:16.000000000 +0400
+++ 2.6.14-rc2/include/linux/signal.h	2005-09-25 21:36:10.000000000 +0400
@@ -25,7 +25,6 @@
 
 struct sigqueue {
 	struct list_head list;
-	spinlock_t *lock;
 	int flags;
 	siginfo_t info;
 	struct user_struct *user;
--- 2.6.14-rc2/kernel/signal.c~5_SILOCK	2005-09-24 21:25:48.000000000 +0400
+++ 2.6.14-rc2/kernel/signal.c	2005-09-25 21:37:01.000000000 +0400
@@ -277,7 +277,6 @@ static struct sigqueue *__sigqueue_alloc
 	} else {
 		INIT_LIST_HEAD(&q->list);
 		q->flags = 0;
-		q->lock = NULL;
 		q->user = get_uid(t->user);
 	}
 	return(q);
@@ -1332,11 +1331,12 @@ void sigqueue_free(struct sigqueue *q)
 	 * pending queue.
 	 */
 	if (unlikely(!list_empty(&q->list))) {
-		read_lock(&tasklist_lock);  
-		spin_lock_irqsave(q->lock, flags);
+		spinlock_t *lock = &current->sighand->siglock;
+		read_lock(&tasklist_lock);
+		spin_lock_irqsave(lock, flags);
 		if (!list_empty(&q->list))
 			list_del_init(&q->list);
-		spin_unlock_irqrestore(q->lock, flags);
+		spin_unlock_irqrestore(lock, flags);
 		read_unlock(&tasklist_lock);
 	}
 	q->flags &= ~SIGQUEUE_PREALLOC;
@@ -1367,7 +1367,6 @@ send_sigqueue(int sig, struct sigqueue *
 		goto out;
 	}
 
-	q->lock = &p->sighand->siglock;
 	list_add_tail(&q->list, &p->pending.list);
 	sigaddset(&p->pending.signal, sig);
 	if (!sigismember(&p->blocked, sig))
@@ -1410,7 +1409,6 @@ send_group_sigqueue(int sig, struct sigq
 	 * We always use the shared queue for process-wide signals,
 	 * to avoid several races.
 	 */
-	q->lock = &p->sighand->siglock;
 	list_add_tail(&q->list, &p->signal->shared_pending.list);
 	sigaddset(&p->signal->shared_pending.signal, sig);
