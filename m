Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWFTJpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWFTJpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWFTJpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:45:04 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36483 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S932457AbWFTJpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:45:02 -0400
Date: Tue, 20 Jun 2006 02:43:48 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org
Subject: Re: Linux 2.6.16.21
Message-ID: <20060620094348.GD23467@sequoia.sous-sol.org>
References: <20060620094239.GC23467@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620094239.GC23467@sequoia.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 600c769..7ae2744 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .20
+EXTRAVERSION = .21
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index d7a4e81..7fb9ff6 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -802,10 +802,13 @@ #ifdef CONFIG_PPC64
 		if (__get_user(cmcp, &ucp->uc_regs))
 			return -EFAULT;
 		mcp = (struct mcontext __user *)(u64)cmcp;
+		/* no need to check access_ok(mcp), since mcp < 4GB */
 	}
 #else
 	if (__get_user(mcp, &ucp->uc_regs))
 		return -EFAULT;
+	if (!access_ok(VERIFY_READ, mcp, sizeof(*mcp)))
+		return -EFAULT;
 #endif
 	restore_sigmask(&set);
 	if (restore_user_regs(regs, mcp, sig))
@@ -907,13 +910,14 @@ int sys_debug_setcontext(struct ucontext
 {
 	struct sig_dbg_op op;
 	int i;
+	unsigned char tmp;
 	unsigned long new_msr = regs->msr;
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
 	unsigned long new_dbcr0 = current->thread.dbcr0;
 #endif
 
 	for (i=0; i<ndbg; i++) {
-		if (__copy_from_user(&op, dbg, sizeof(op)))
+		if (copy_from_user(&op, dbg + i, sizeof(op)))
 			return -EFAULT;
 		switch (op.dbg_type) {
 		case SIG_DBG_SINGLE_STEPPING:
@@ -958,6 +962,11 @@ #if defined(CONFIG_4xx) || defined(CONFI
 	current->thread.dbcr0 = new_dbcr0;
 #endif
 
+	if (!access_ok(VERIFY_READ, ctx, sizeof(*ctx))
+	    || __get_user(tmp, (u8 __user *) ctx)
+	    || __get_user(tmp, (u8 __user *) (ctx + 1) - 1))
+		return -EFAULT;
+
 	/*
 	 * If we get a fault copying the context into the kernel's
 	 * image of the user's registers, we can't just return -EFAULT
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 096dfdc..f1715f3 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -183,6 +183,8 @@ #ifdef CONFIG_ALTIVEC
 	err |= __get_user(msr, &sc->gp_regs[PT_MSR]);
 	if (err)
 		return err;
+	if (v_regs && !access_ok(VERIFY_READ, v_regs, 34 * sizeof(vector128)))
+		return -EFAULT;
 	/* Copy 33 vec registers (vr0..31 and vscr) from the stack */
 	if (v_regs != 0 && (msr & MSR_VEC) != 0)
 		err |= __copy_from_user(current->thread.vr, v_regs,
diff --git a/kernel/exit.c b/kernel/exit.c
index 531aadc..fc46c9a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -828,14 +828,6 @@ fastcall NORET_TYPE void do_exit(long co
 
 	tsk->flags |= PF_EXITING;
 
-	/*
-	 * Make sure we don't try to process any timer firings
-	 * while we are already exiting.
-	 */
- 	tsk->it_virt_expires = cputime_zero;
- 	tsk->it_prof_expires = cputime_zero;
-	tsk->it_sched_expires = 0;
-
 	if (unlikely(in_atomic()))
 		printk(KERN_INFO "note: %s[%d] exited with preempt_count %d\n",
 				current->comm, current->pid,
diff --git a/kernel/posix-cpu-timers.c b/kernel/posix-cpu-timers.c
index 520f6c5..4882bf1 100644
--- a/kernel/posix-cpu-timers.c
+++ b/kernel/posix-cpu-timers.c
@@ -1173,6 +1173,9 @@ static void check_process_timers(struct 
 		}
 		t = tsk;
 		do {
+			if (unlikely(t->flags & PF_EXITING))
+				continue;
+
 			ticks = cputime_add(cputime_add(t->utime, t->stime),
 					    prof_left);
 			if (!cputime_eq(prof_expires, cputime_zero) &&
@@ -1193,11 +1196,7 @@ static void check_process_timers(struct 
 					      t->it_sched_expires > sched)) {
 				t->it_sched_expires = sched;
 			}
-
-			do {
-				t = next_thread(t);
-			} while (unlikely(t->flags & PF_EXITING));
-		} while (t != tsk);
+		} while ((t = next_thread(t)) != tsk);
 	}
 }
 
@@ -1289,30 +1288,30 @@ #define UNEXPIRED(clock) \
 
 #undef	UNEXPIRED
 
-	BUG_ON(tsk->exit_state);
-
 	/*
 	 * Double-check with locks held.
 	 */
 	read_lock(&tasklist_lock);
-	spin_lock(&tsk->sighand->siglock);
+	if (likely(tsk->signal != NULL)) {
+		spin_lock(&tsk->sighand->siglock);
 
-	/*
-	 * Here we take off tsk->cpu_timers[N] and tsk->signal->cpu_timers[N]
-	 * all the timers that are firing, and put them on the firing list.
-	 */
-	check_thread_timers(tsk, &firing);
-	check_process_timers(tsk, &firing);
+		/*
+		 * Here we take off tsk->cpu_timers[N] and tsk->signal->cpu_timers[N]
+		 * all the timers that are firing, and put them on the firing list.
+		 */
+		check_thread_timers(tsk, &firing);
+		check_process_timers(tsk, &firing);
 
-	/*
-	 * We must release these locks before taking any timer's lock.
-	 * There is a potential race with timer deletion here, as the
-	 * siglock now protects our private firing list.  We have set
-	 * the firing flag in each timer, so that a deletion attempt
-	 * that gets the timer lock before we do will give it up and
-	 * spin until we've taken care of that timer below.
-	 */
-	spin_unlock(&tsk->sighand->siglock);
+		/*
+		 * We must release these locks before taking any timer's lock.
+		 * There is a potential race with timer deletion here, as the
+		 * siglock now protects our private firing list.  We have set
+		 * the firing flag in each timer, so that a deletion attempt
+		 * that gets the timer lock before we do will give it up and
+		 * spin until we've taken care of that timer below.
+		 */
+		spin_unlock(&tsk->sighand->siglock);
+	}
 	read_unlock(&tasklist_lock);
 
 	/*
diff --git a/net/netfilter/xt_sctp.c b/net/netfilter/xt_sctp.c
index 10fbfc5..2390182 100644
--- a/net/netfilter/xt_sctp.c
+++ b/net/netfilter/xt_sctp.c
@@ -62,7 +62,7 @@ #endif
 
 	do {
 		sch = skb_header_pointer(skb, offset, sizeof(_sch), &_sch);
-		if (sch == NULL) {
+		if (sch == NULL || sch->length == 0) {
 			duprintf("Dropping invalid SCTP packet.\n");
 			*hotdrop = 1;
 			return 0;
