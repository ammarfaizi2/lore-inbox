Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268100AbUIJFKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268100AbUIJFKo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 01:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUIJFKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 01:10:43 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:17368 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S268100AbUIJFKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 01:10:34 -0400
Date: Thu, 9 Sep 2004 22:10:31 -0700
Message-Id: <200409100510.i8A5AVD7025919@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix sigqueue accounting for posix-timers broken by new RLIMIT_SIGPENDING tracking code
X-Fcc: ~/Mail/linus
X-Zippy-Says: I want EARS!  I want two ROUND BLACK EARS to make me feel warm 'n secure!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The introduction of RLIMIT_SIGPENDING and the associated tracking code was
broken for the case of preallocated sigqueue elements, i.e. posix-timers.
It wrongly includes the timer's preallocated sigqueue structs in the count
towards the per-user when allocating them, but (rightly) does not decrement
the count when they are freed.  

This patch fixes it by keeping preallocated sigqueue structs out of the
per-user accounting altogether.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- vanilla-linux-2.6/kernel/signal.c.orig	2004-09-09 22:07:56.492060454 -0700
+++ vanilla-linux-2.6/kernel/signal.c	2004-09-09 21:55:45.604292751 -0700
@@ -264,7 +264,7 @@ next_signal(struct sigpending *pending, 
 	return sig;
 }
 
-static struct sigqueue *__sigqueue_alloc(void)
+static struct sigqueue *__sigqueue_alloc(int flags)
 {
 	struct sigqueue *q = NULL;
 
@@ -273,10 +273,13 @@ static struct sigqueue *__sigqueue_alloc
 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
 	if (q) {
 		INIT_LIST_HEAD(&q->list);
-		q->flags = 0;
 		q->lock = NULL;
-		q->user = get_uid(current->user);
-		atomic_inc(&q->user->sigpending);
+		q->user = NULL;
+		q->flags = flags;
+		if (!(flags & SIGQUEUE_PREALLOC)) {
+			q->user = get_uid(current->user);
+			atomic_inc(&q->user->sigpending);
+		}
 	}
 	return(q);
 }
@@ -1331,11 +1334,7 @@ kill_proc(pid_t pid, int sig, int priv)
  
 struct sigqueue *sigqueue_alloc(void)
 {
-	struct sigqueue *q;
-
-	if ((q = __sigqueue_alloc()))
-		q->flags |= SIGQUEUE_PREALLOC;
-	return(q);
+	return __sigqueue_alloc(SIGQUEUE_PREALLOC);
 }
 
 void sigqueue_free(struct sigqueue *q)
