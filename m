Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVBWGmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVBWGmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 01:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVBWGmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 01:42:42 -0500
Received: from gw.goop.org ([64.81.55.164]:55231 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S261319AbVBWGmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 01:42:31 -0500
Message-ID: <421C25BE.1090700@goop.org>
Date: Tue, 22 Feb 2005 22:42:06 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Always send siginfo for synchronous signals
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000808010300030005080603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000808010300030005080603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Valgrind is critically dependent on getting siginfo with its synchronous
(caused by an instruction fault) signals; if it gets, say, a SIGSEGV
which doesn't have siginfo, it must terminate ASAP because it really
can't make any more progress without knowing what caused the SIGSEGV.

The trouble is that if some other completely unrelated program the user
is running at the time builds up a large queue of pending signals for
some reason (as KDE seems to on SuSE 9.2), it will cause Valgrind to
fail for that user, apparently inexplicably.

It seems to me that the kernel should always deliver siginfo with
synchronous fault signals (SIGSEGV, SIGBUS, SIGFPE, SIGTRAP, SIGILL).
They can't ever be blocked (because they're unconditionally fatal if you
do block them), and therefore never queued.  By definition, the task
which causes the signal is running at the time, and so can be
immediately delivered a siginfo without having to allocate one (except
temporarily).

Proposed patch against 2.6.11-rc4 attached.

    J


--------------000808010300030005080603
Content-Type: text/x-patch;
 name="always-send-siginfo-for-faults.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="always-send-siginfo-for-faults.patch"

If we're sending a signal relating to a faulting instruction, then
always generate siginfo for that signal.  

If the user has some unrelated process which has managed to consume
the user's entire allocation of siginfo, then signals will start being
delivered without siginfo.  Some programs absolutely depend on getting
siginfo for signals like SIGSEGV, and get very confused if they see a
SEGV without siginfo.

Such signals cannot be blocked (they're immediately fatal if they
are), and therefore cannot be queued.  There's therefore no risk of
resource starvation.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

Index: local-2.6/kernel/signal.c
===================================================================
--- local-2.6.orig/kernel/signal.c	2005-02-22 20:35:30.000000000 -0800
+++ local-2.6/kernel/signal.c	2005-02-22 20:43:16.000000000 -0800
@@ -136,6 +136,10 @@ static kmem_cache_t *sigqueue_cachep;
 #define SIG_KERNEL_IGNORE_MASK (\
         M(SIGCONT)   |  M(SIGCHLD)   |  M(SIGWINCH)  |  M(SIGURG)    )
 
+#define SIG_KERNEL_SYNC_MASK (\
+	M(SIGSEGV)   |  M(SIGBUS)    | M(SIGILL)     |  M(SIGFPE)    | \
+	M(SIGTRAP) )
+
 #define sig_kernel_only(sig) \
 		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_ONLY_MASK))
 #define sig_kernel_coredump(sig) \
@@ -144,6 +148,8 @@ static kmem_cache_t *sigqueue_cachep;
 		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_IGNORE_MASK))
 #define sig_kernel_stop(sig) \
 		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_STOP_MASK))
+#define sig_kernel_sync(sig) \
+		(((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_SYNC_MASK))
 
 #define sig_user_defined(t, signr) \
 	(((t)->sighand->action[(signr)-1].sa.sa_handler != SIG_DFL) &&	\
@@ -260,11 +266,12 @@ next_signal(struct sigpending *pending, 
 	return sig;
 }
 
-static struct sigqueue *__sigqueue_alloc(struct task_struct *t, int flags)
+static struct sigqueue *__sigqueue_alloc(struct task_struct *t, int flags, int always)
 {
 	struct sigqueue *q = NULL;
 
-	if (atomic_read(&t->user->sigpending) <
+	if (always || 
+	    atomic_read(&t->user->sigpending) <
 			t->signal->rlim[RLIMIT_SIGPENDING].rlim_cur)
 		q = kmem_cache_alloc(sigqueue_cachep, flags);
 	if (q) {
@@ -777,6 +784,7 @@ static int send_signal(int sig, struct s
 {
 	struct sigqueue * q = NULL;
 	int ret = 0;
+	int always;
 
 	/*
 	 * fast-pathed signals for kernel-internal things like SIGSTOP
@@ -785,6 +793,13 @@ static int send_signal(int sig, struct s
 	if ((unsigned long)info == 2)
 		goto out_set;
 
+	/* Always attempt to send siginfo with an unblocked
+	   fault-generated signal. */
+	always = sig_kernel_sync(sig) &&
+		!sigismember(&t->blocked, sig) &&
+		(unsigned long)info > 2 &&
+		info->si_code > SI_USER;
+
 	/* Real-time signals must be queued if sent by sigqueue, or
 	   some other real-time mechanism.  It is implementation
 	   defined whether kill() does so.  We attempt to do so, on
@@ -793,7 +808,7 @@ static int send_signal(int sig, struct s
 	   make sure at least one signal gets delivered and don't
 	   pass on the info struct.  */
 
-	q = __sigqueue_alloc(t, GFP_ATOMIC);
+	q = __sigqueue_alloc(t, GFP_ATOMIC, always);
 	if (q) {
 		list_add_tail(&q->list, &signals->list);
 		switch ((unsigned long) info) {
@@ -1316,7 +1331,7 @@ struct sigqueue *sigqueue_alloc(void)
 {
 	struct sigqueue *q;
 
-	if ((q = __sigqueue_alloc(current, GFP_KERNEL)))
+	if ((q = __sigqueue_alloc(current, GFP_KERNEL, 0)))
 		q->flags |= SIGQUEUE_PREALLOC;
 	return(q);
 }

--------------000808010300030005080603--

