Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbUEKIxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUEKIxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUEKIxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:53:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:28549 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262434AbUEKIw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:52:29 -0400
Date: Tue, 11 May 2004 01:52:20 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, marcelo.tosatti@cyclades.com
Subject: [PATCH 5/11] enforce rlimits on queued signals
Message-ID: <20040511015219.D21045@build.pdx.osdl.net>
References: <20040511014232.Y21045@build.pdx.osdl.net> <20040511014524.Z21045@build.pdx.osdl.net> <20040511014639.A21045@build.pdx.osdl.net> <20040511014833.B21045@build.pdx.osdl.net> <20040511015015.C21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511015015.C21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 11, 2004 at 01:50:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a user_struct to the sigqueue structure.  Charge sigqueue allocation
and destruction to the user_struct rather than a global pool.  This per
user rlimit accounting obsoletes the global queued_signals accouting.

===== include/linux/signal.h 1.15 vs edited =====
--- 1.15/include/linux/signal.h	Thu Jan 15 12:40:33 2004
+++ edited/include/linux/signal.h	Mon May 10 16:16:13 2004
@@ -19,6 +19,7 @@
 	spinlock_t *lock;
 	int flags;
 	siginfo_t info;
+	struct user_struct *user;
 };
 
 /* flags values. */
===== kernel/signal.c 1.115 vs edited =====
--- 1.115/kernel/signal.c	Mon May 10 03:04:00 2004
+++ edited/kernel/signal.c	Mon May 10 16:16:13 2004
@@ -264,17 +264,19 @@
 	return sig;
 }
 
-struct sigqueue *__sigqueue_alloc(void)
+static struct sigqueue *__sigqueue_alloc(void)
 {
 	struct sigqueue *q = 0;
 
-	if (atomic_read(&nr_queued_signals) < max_queued_signals)
+	if (atomic_read(&current->user->sigpending) < 
+			current->rlim[RLIMIT_SIGPENDING].rlim_cur)
 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
 	if (q) {
-		atomic_inc(&nr_queued_signals);
 		INIT_LIST_HEAD(&q->list);
 		q->flags = 0;
 		q->lock = 0;
+		q->user = get_uid(current->user);
+		atomic_inc(&q->user->sigpending);
 	}
 	return(q);
 }
@@ -283,8 +285,9 @@
 {
 	if (q->flags & SIGQUEUE_PREALLOC)
 		return;
+	atomic_dec(&q->user->sigpending);
+	free_uid(q->user);
 	kmem_cache_free(sigqueue_cachep, q);
-	atomic_dec(&nr_queued_signals);
 }
 
 static void flush_sigqueue(struct sigpending *queue)
@@ -719,12 +722,14 @@
 	   make sure at least one signal gets delivered and don't
 	   pass on the info struct.  */
 
-	if (atomic_read(&nr_queued_signals) < max_queued_signals)
+	if (atomic_read(&t->user->sigpending) <
+			t->rlim[RLIMIT_SIGPENDING].rlim_cur)
 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
 
 	if (q) {
-		atomic_inc(&nr_queued_signals);
 		q->flags = 0;
+		q->user = get_uid(t->user);
+		atomic_inc(&q->user->sigpending);
 		list_add_tail(&q->list, &signals->list);
 		switch ((unsigned long) info) {
 		case 0:

