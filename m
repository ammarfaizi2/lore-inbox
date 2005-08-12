Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVHLBzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVHLBzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 21:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVHLBzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 21:55:38 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:61899 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932511AbVHLBzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 21:55:37 -0400
Date: Thu, 11 Aug 2005 18:56:07 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050812015607.GR1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42FB41B5.98314BA5@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FB41B5.98314BA5@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 04:16:53PM +0400, Oleg Nesterov wrote:
> Paul E. McKenney wrote:
> >
> > --- linux-2.6.13-rc6/kernel/signal.c	2005-08-08 19:59:24.000000000 -0700
> > +++ linux-2.6.13-rc6-tasklistRCU/kernel/signal.c	2005-08-10 08:20:25.000000000 -0700
> > @@ -1151,9 +1151,13 @@ int group_send_sig_info(int sig, struct 
> >
> >  	ret = check_kill_permission(sig, info, p);
> >  	if (!ret && sig && p->sighand) {
> > +		if (!get_task_struct_rcu(p)) {
> > +			return -ESRCH;
> > +		}
> >  		spin_lock_irqsave(&p->sighand->siglock, flags);
>                                       ^^^^^^^
> Is it correct?

Most definitely not!  Thank you again for catching this one, would have
taken some serious test-and-debug time to root it out the hard way.

Fix provided as a patch against V0.7.53-01, probably still has some
bugs, as it has not yet been thoroughly tested.  General approach is
to RCU-protect the sighand pointer from task_struct to sighand_struct.

Will be testing more thoroughly, in the meantime, thoughts?

							Thanx, Paul

 fs/exec.c             |    6 +++++-
 include/linux/sched.h |   10 ++++++++++
 kernel/fork.c         |   11 +++++++++++
 kernel/signal.c       |   16 +++++++++++++---
 4 files changed, 39 insertions(+), 4 deletions(-)

diff -urpNa -X dontdiff linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/fs/exec.c linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/fs/exec.c
--- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/fs/exec.c	2005-08-11 11:44:55.000000000 -0700
+++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/fs/exec.c	2005-08-11 12:26:45.000000000 -0700
@@ -773,6 +773,8 @@ no_thread_group:
 		 */
 		spin_lock_init(&newsighand->siglock);
 		atomic_set(&newsighand->count, 1);
+		newsighand->deleted = 0;
+		newsighand->successor = NULL;
 		memcpy(newsighand->action, oldsighand->action,
 		       sizeof(newsighand->action));
 
@@ -785,12 +787,14 @@ no_thread_group:
 		recalc_sigpending();
 
 		task_unlock(current);
+		oldsighand->deleted = 1;
+		oldsighand->successor = newsighand;
 		spin_unlock(&newsighand->siglock);
 		spin_unlock(&oldsighand->siglock);
 		write_unlock_irq(&tasklist_lock);
 
 		if (atomic_dec_and_test(&oldsighand->count))
-			kmem_cache_free(sighand_cachep, oldsighand);
+			sighand_free(oldsighand);
 	}
 
 	BUG_ON(!thread_group_empty(current));
diff -urpNa -X dontdiff linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/include/linux/sched.h linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/include/linux/sched.h
--- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/include/linux/sched.h	2005-08-11 11:44:57.000000000 -0700
+++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/include/linux/sched.h	2005-08-11 12:17:01.000000000 -0700
@@ -450,8 +450,18 @@ struct sighand_struct {
 	atomic_t		count;
 	struct k_sigaction	action[_NSIG];
 	spinlock_t		siglock;
+	int			deleted;
+	struct sighand_struct	*successor;
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
+++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/fork.c	2005-08-11 13:05:17.000000000 -0700
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
@@ -783,6 +792,8 @@ static inline int copy_sighand(unsigned 
 		return -ENOMEM;
 	spin_lock_init(&sig->siglock);
 	atomic_set(&sig->count, 1);
+	sig->deleted = 0;
+	sig->successor = 0;
 	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
 	return 0;
 }
diff -urpNa -X dontdiff linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/kernel/signal.c linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/signal.c
--- linux-2.6.13-rc4-realtime-preempt-V0.7.53-01/kernel/signal.c	2005-08-11 11:44:57.000000000 -0700
+++ linux-2.6.13-rc4-realtime-preempt-V0.7.53-01-tasklistRCU/kernel/signal.c	2005-08-11 17:37:55.000000000 -0700
@@ -1150,16 +1150,26 @@ void zap_other_threads(struct task_struc
 int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
 	unsigned long flags;
+	struct sighand_struct *sp;
 	int ret;
 
 	ret = check_kill_permission(sig, info, p);
-	if (!ret && sig && p->sighand) {
+	if (!ret && sig && (sp = p->sighand)) {
 		if (!get_task_struct_rcu(p)) {
 			return -ESRCH;
 		}
-		spin_lock_irqsave(&p->sighand->siglock, flags);
+		spin_lock_irqsave(&sp->siglock, flags);
+		while (sp->deleted) {
+			spin_unlock_irqrestore(&sp->siglock, flags);
+			sp = sp->successor;
+			if (sp == NULL) {
+				put_task_struct(p);
+				return -ESRCH;
+			}
+			spin_lock_irqsave(&sp->siglock, flags);
+		}
 		ret = __group_send_sig_info(sig, info, p);
-		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+		spin_unlock_irqrestore(&sp->siglock, flags);
 		put_task_struct(p);
 	}
 
