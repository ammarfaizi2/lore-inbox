Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbVHORnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbVHORnd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbVHORnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:43:33 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51928 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964852AbVHORnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:43:32 -0400
Date: Mon, 15 Aug 2005 10:44:03 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050815174403.GE1562@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com> <42FC6305.E7A00C0A@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FC6305.E7A00C0A@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 12:51:17PM +0400, Oleg Nesterov wrote:
> Paul E. McKenney wrote:
> >
> > --- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/fs/exec.c	2005-08-11 11:44:55.000000000 -0700
> > +++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/fs/exec.c	2005-08-11 12:26:45.000000000 -0700
> > [ ... snip ... ]
> > @@ -785,11 +787,13 @@ no_thread_group:
> >  		recalc_sigpending();
> > 
> > +		oldsighand->deleted = 1;
> > +		oldsighand->successor = newsighand;
> 
> I don't think this is correct.
> 
> This ->oldsighand can be shared with another CLONE_SIGHAND
> process and will not be deleted, just unshared.
> 
> When the signal is sent to that process we must use ->oldsighand
> for locking, not the oldsighand->successor == newsighand.

OK, the attached instead revalidates that the task struct still references
the sighand_struct after obtaining the lock (and passes kernbench and
LTP, which tells me I need to get better tests!).  However, your quick
responses motivated me to read more of the code (yes, I know, I should
have done -that- beforehand!!!), and there are some remaining problems
that I need to sort out, including:

o	Fatal signals affect all threads in a process, and the
	existing code looks like it assumes that tasklist_lock
	is held during delivery of such signals.  In this patch,
	that assumption does not hold.

o	Some of the functions invoked by __group_send_sig_info(),
	including handle_stop_signal(), momentarily drop ->siglock.

I will be looking at a few approaches to handle these situations, but,
in the meantime, any other combinations that I missed?

							Thanx, Paul


diff -urpNa -X dontdiff linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/fs/exec.c linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/fs/exec.c
--- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/fs/exec.c	2005-08-11 11:44:55.000000000 -0700
+++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/fs/exec.c	2005-08-12 21:18:33.000000000 -0700
@@ -790,7 +790,7 @@ no_thread_group:
 		write_unlock_irq(&tasklist_lock);
 
 		if (atomic_dec_and_test(&oldsighand->count))
-			kmem_cache_free(sighand_cachep, oldsighand);
+			sighand_free(oldsighand);
 	}
 
 	BUG_ON(!thread_group_empty(current));
diff -urpNa -X dontdiff linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/include/linux/sched.h linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/include/linux/sched.h
--- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/include/linux/sched.h	2005-08-11 11:44:57.000000000 -0700
+++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/include/linux/sched.h	2005-08-12 21:19:34.000000000 -0700
@@ -450,8 +450,16 @@ struct sighand_struct {
 	atomic_t		count;
 	struct k_sigaction	action[_NSIG];
 	spinlock_t		siglock;
+	struct rcu_head		rcu;
 };
 
+static inline void sighand_free(struct sighand_struct *sp)
+{
+	extern void sighand_free_cb(struct rcu_head *rhp);
+
+	call_rcu(&sp->rcu, sighand_free_cb);
+}
+
 /*
  * NOTE! "signal_struct" does not have it's own
  * locking, because a shared signal_struct always
diff -urpNa -X dontdiff linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/kernel/fork.c linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/fork.c
--- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/kernel/fork.c	2005-08-11 11:44:57.000000000 -0700
+++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/fork.c	2005-08-12 21:24:00.000000000 -0700
@@ -43,6 +43,7 @@
 #include <linux/acct.h>
 #include <linux/kthread.h>
 #include <linux/notifier.h>
+#include <linux/rcupdate.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -769,6 +770,14 @@ int unshare_files(void)
 
 EXPORT_SYMBOL(unshare_files);
 
+void sighand_free_cb(struct rcu_head *rhp)
+{
+	struct sighand_struct *sp =
+		container_of(rhp, struct sighand_struct, rcu);
+
+	kmem_cache_free(sighand_cachep, sp);
+}
+
 static inline int copy_sighand(unsigned long clone_flags, struct task_struct * tsk)
 {
 	struct sighand_struct *sig;
diff -urpNa -X dontdiff linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/kernel/signal.c linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/signal.c
--- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/kernel/signal.c	2005-08-11 11:44:57.000000000 -0700
+++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/signal.c	2005-08-14 19:53:28.000000000 -0700
@@ -328,9 +328,11 @@ void __exit_sighand(struct task_struct *
 	struct sighand_struct * sighand = tsk->sighand;
 
 	/* Ok, we're done with the signal handlers */
+	spin_lock(&sighand->siglock);
 	tsk->sighand = NULL;
 	if (atomic_dec_and_test(&sighand->count))
-		kmem_cache_free(sighand_cachep, sighand);
+		sighand_free(sighand);
+	spin_unlock(&sighand->siglock);
 }
 
 void exit_sighand(struct task_struct *tsk)
@@ -1150,16 +1152,23 @@ void zap_other_threads(struct task_struc
 int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
 	unsigned long flags;
+	struct sighand_struct *sp;
 	int ret;
 
+retry:
 	ret = check_kill_permission(sig, info, p);
-	if (!ret && sig && p->sighand) {
+	if (!ret && sig && (sp = p->sighand)) {
 		if (!get_task_struct_rcu(p)) {
 			return -ESRCH;
 		}
-		spin_lock_irqsave(&p->sighand->siglock, flags);
+		spin_lock_irqsave(&sp->siglock, flags);
+		if (p->sighand != sp) {
+			spin_unlock_irqrestore(&sp->siglock, flags);
+			put_task_struct(p);
+			goto retry;
+		}
 		ret = __group_send_sig_info(sig, info, p);
-		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		spin_unlock_irqrestore(&sp->siglock, flags);
 		put_task_struct(p);
 	}
 
