Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVBWX4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVBWX4x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVBWX4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:56:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:65247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261712AbVBWXqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:46:40 -0500
Date: Wed, 23 Feb 2005 15:46:26 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@osdl.org>, Roland McGrath <roland@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Always send siginfo for synchronous signals
Message-ID: <20050223234626.GZ15867@shell0.pdx.osdl.net>
References: <421C25BE.1090700@goop.org> <20050223201903.GF21662@shell0.pdx.osdl.net> <421D0D3F.40902@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421D0D3F.40902@goop.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Chris Wright wrote:
> 
> >It's not quite inexplicable.  It means that task has hit its limit for
> >pending signals ;-)  But I agree, this should be fixed.  I think I had
> >tested this with broken test cases, thanks for catching.
> >
> It's particularly confusing for users, because it's a per-user limit
> rather than a per-process one, and its not at all apparent which program
> is causing the problem (/proc/N/status will tell you that a process has
> a signal pending, but it won't tell you how many are pending).

Suggestion for good place to display that info?

> In fact, bugs with these symptoms have been reported against Valgrind
> from time to time for years, and its only recently I worked out what's
> going on (mostly because I introduced a bug which caused Valgrind to do
> it to itself).

This code is pretty new (since 2.6.8-rc1, last June), so I expect some
other issue in the years past.

> >>+static struct sigqueue *__sigqueue_alloc(struct task_struct *t, int flags, int always)
> >>    
> >>
> >maybe force_info instead of always?
> >  
> >
> I suppose, but it doesn't "force" it really.  The allocation could still
> fail (it is GFP_ATOMIC after all), and you'd still get no siginfo.  I
> don't care much either way.
> 
> >> 	/*
> >> 	 * fast-pathed signals for kernel-internal things like SIGSTOP
> >>@@ -785,6 +793,13 @@ static int send_signal(int sig, struct s
> >> 	if ((unsigned long)info == 2)
> >> 		goto out_set;
> >> 
> >>+	/* Always attempt to send siginfo with an unblocked
> >>+	   fault-generated signal. */
> >>+	always = sig_kernel_sync(sig) &&
> >>+		!sigismember(&t->blocked, sig) &&
> >>    
> >>
> >Aren't these already unblocked?
> >  
> >
> I can't think of a case where they wouldn't be, but I wanted to make
> sure this couldn't be used to create a new DoS.

I suppose it could be blocked and the source could be send_sig_info()
instead of force_sig_info.  It seems quite reasonable to let sync kernel
generated signals through, but I'm inclined to keep hole small to avoid
DoS vector.  So I agree, leave it in for now.

> >>+		(unsigned long)info > 2 &&
> >>+		info->si_code > SI_USER;
> >>    
> >>
> >In what case is != SI_KERNEL OK?
> >  
> >
> Fault signals rarely have an si_code of SI_KERNEL (0x80); they generally
> have a small integer to describe what the fault was really about
> (SEGV_MAPERR, etc).  All si_codes > SI_USER (0) are defined to have come
> from the kernel.  Hm, I see there's a macro, SI_FROMKERNEL, for doing
> this test.

Yeah you're right, was just crafting an email recanting that bit ;-)
Here's what I had tested here:

	force_info = (sig_kernel_sync(sig) && !sigismember(&t->blocked, sig)
		      && (unsigned long)info > 2 && SI_FROMKERNEL(info));


> Updcted patch attached.

Oops, missed the patch.  Anyway, here's my tweak to your patch.  I
preserved your Signed-off-by.  Thanks again for report plus patch.

thanks,
-chris
--

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
Signed-off-by: Chris Wright <chrisw@osdl.org>

===== kernel/signal.c 1.153 vs edited =====
--- 1.153/kernel/signal.c	2005-01-30 22:33:46 -08:00
+++ edited/kernel/signal.c	2005-02-23 15:39:37 -08:00
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
@@ -260,12 +266,12 @@ next_signal(struct sigpending *pending, 
 	return sig;
 }
 
-static struct sigqueue *__sigqueue_alloc(struct task_struct *t, int flags)
+static struct sigqueue *__sigqueue_alloc(struct task_struct *t, int flags, int force_info)
 {
 	struct sigqueue *q = NULL;
 
-	if (atomic_read(&t->user->sigpending) <
-			t->signal->rlim[RLIMIT_SIGPENDING].rlim_cur)
+	if (force_info || atomic_read(&t->user->sigpending) <
+			  t->signal->rlim[RLIMIT_SIGPENDING].rlim_cur)
 		q = kmem_cache_alloc(sigqueue_cachep, flags);
 	if (q) {
 		INIT_LIST_HEAD(&q->list);
@@ -776,7 +782,7 @@ static int send_signal(int sig, struct s
 			struct sigpending *signals)
 {
 	struct sigqueue * q = NULL;
-	int ret = 0;
+	int force_info, ret = 0;
 
 	/*
 	 * fast-pathed signals for kernel-internal things like SIGSTOP
@@ -785,6 +791,11 @@ static int send_signal(int sig, struct s
 	if ((unsigned long)info == 2)
 		goto out_set;
 
+	/* Always attempt to send siginfo with an unblocked
+	   fault-generated signal. */
+	force_info = (sig_kernel_sync(sig) && !sigismember(&t->blocked, sig)
+		      && (unsigned long)info > 2 && SI_FROMKERNEL(info));
+
 	/* Real-time signals must be queued if sent by sigqueue, or
 	   some other real-time mechanism.  It is implementation
 	   defined whether kill() does so.  We attempt to do so, on
@@ -793,7 +804,7 @@ static int send_signal(int sig, struct s
 	   make sure at least one signal gets delivered and don't
 	   pass on the info struct.  */
 
-	q = __sigqueue_alloc(t, GFP_ATOMIC);
+	q = __sigqueue_alloc(t, GFP_ATOMIC, force_info);
 	if (q) {
 		list_add_tail(&q->list, &signals->list);
 		switch ((unsigned long) info) {
@@ -1316,7 +1327,7 @@ struct sigqueue *sigqueue_alloc(void)
 {
 	struct sigqueue *q;
 
-	if ((q = __sigqueue_alloc(current, GFP_KERNEL)))
+	if ((q = __sigqueue_alloc(current, GFP_KERNEL, 0)))
 		q->flags |= SIGQUEUE_PREALLOC;
 	return(q);
 }
