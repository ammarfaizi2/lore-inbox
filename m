Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVBXBqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVBXBqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 20:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVBXBqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 20:46:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36552 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261731AbVBXBpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 20:45:55 -0500
Date: Wed, 23 Feb 2005 17:45:47 -0800
Message-Id: <200502240145.j1O1jlab010606@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
X-Fcc: ~/Mail/linus
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] override RLIMIT_SIGPENDING for non-RT signals
In-Reply-To: Jeremy Fitzhardinge's message of  Wednesday, 23 February 2005 15:44:08 -0800 <421D1548.2080504@goop.org>
X-Windows: sometimes you fill a vacuum and it still sucks.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed, I think your patch does not go far enough.  I can read POSIX to say
that the siginfo_t data must be available when `kill' was used, as well.
This patch makes it allocate the siginfo_t, even when that exceeds
{RLIMIT_SIGPENDING}, for any non-RT signal (< SIGRTMIN) not sent by
sigqueue (actually, any signal that couldn't have been faked by a sigqueue
call).  Of course, in an extreme memory shortage situation, you are SOL and
violate POSIX a little before you die horribly from being out of memory anyway.

The LEGACY_QUEUE logic already ensures that, for non-RT signals, at most
one is ever on the queue.  So there really is no risk at all of unbounded
resource consumption; the usage can reach {RLIMIT_SIGPENDING} + 31, is all.

It's already the case that the limit can be exceeded by (in theory) up to
{RLIMIT_NPROC}-1 in race conditions because the bump and the limit check
are not atomic.  (Obviously you can only get anywhere near that many with
assloads of preemption, but exceeding it by a few is not too unlikely.)
This patch also fixes that accounting so that it should not be possible to
exceed {RLIMIT_SIGPENDING} + SIGRTMIN-1 queue items per user in races.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/signal.c
+++ linux-2.6/kernel/signal.c
@@ -260,19 +260,23 @@ next_signal(struct sigpending *pending, 
 	return sig;
 }
 
-static struct sigqueue *__sigqueue_alloc(struct task_struct *t, int flags)
+static struct sigqueue *__sigqueue_alloc(struct task_struct *t, int flags,
+					 int override_rlimit)
 {
 	struct sigqueue *q = NULL;
 
-	if (atomic_read(&t->user->sigpending) <
+	atomic_inc(&t->user->sigpending);
+	if (override_rlimit ||
+	    atomic_read(&t->user->sigpending) <=
 			t->signal->rlim[RLIMIT_SIGPENDING].rlim_cur)
 		q = kmem_cache_alloc(sigqueue_cachep, flags);
-	if (q) {
+	if (unlikely(q == NULL)) {
+		atomic_dec(&t->user->sigpending);
+	} else {
 		INIT_LIST_HEAD(&q->list);
 		q->flags = 0;
 		q->lock = NULL;
 		q->user = get_uid(t->user);
-		atomic_inc(&q->user->sigpending);
 	}
 	return(q);
 }
@@ -793,7 +797,9 @@ static int send_signal(int sig, struct s
 	   make sure at least one signal gets delivered and don't
 	   pass on the info struct.  */
 
-	q = __sigqueue_alloc(t, GFP_ATOMIC);
+	q = __sigqueue_alloc(t, GFP_ATOMIC, (sig < SIGRTMIN &&
+					     ((unsigned long) info < 2 ||
+					      info->si_code >= 0)));
 	if (q) {
 		list_add_tail(&q->list, &signals->list);
 		switch ((unsigned long) info) {
@@ -1316,7 +1322,7 @@ struct sigqueue *sigqueue_alloc(void)
 {
 	struct sigqueue *q;
 
-	if ((q = __sigqueue_alloc(current, GFP_KERNEL)))
+	if ((q = __sigqueue_alloc(current, GFP_KERNEL, 0)))
 		q->flags |= SIGQUEUE_PREALLOC;
 	return(q);
 }
