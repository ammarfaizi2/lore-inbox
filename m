Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUGAHCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUGAHCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 03:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUGAHCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 03:02:37 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:10381 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S264113AbUGAHCb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 03:02:31 -0400
Date: Thu, 1 Jul 2004 00:02:24 -0700
Message-Id: <200407010702.i6172O38019744@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Andreas Schwab <schwab@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: zombie with CLONE_THREAD
In-Reply-To: Linus Torvalds's message of  Wednesday, 30 June 2004 21:57:35 -0700 <Pine.LNX.4.58.0406302147350.11212@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
X-Zippy-Says: ..  So, if we convert SUPPLY-SIDE SOYBEAN FUTURES into HIGH-YIELD
   T-BILL INDICATORS, the PRE-INFLATIONARY risks will DWINDLE to a
   rate of 2 SHOPPING SPREES per EGGPLANT!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I do think the locking is broken in your patch.

I was afraid of that.

> Since you release the tasklist lock, the children on our list of children 
> might go away while you released the lock, making the
> 
> 	list_for_each_safe(..)

You know, I never really looked at the macros, but seeing "_safe" here made
me think that exactly this is what it's safe from.  That was obviously a
silly thing to think, since it's clearly just safe from removing the list
element during the iteration.

> HOWEVER, I think you can fix it with something like
> 
> 	_n = father->children.next;
> 
> after you've re-aquired the lock (that will re-start the loop, but since 
> we should have gotten rid of all the previous entries, the "restart" is 
> actually going to just continue at the point where we were going to 
> continue anyway, so it shouldn't cause any extra iterations).
> 
> Does that still work for you, or have I totally messed up?

That does still work.

> I do agree with Andrea that it's ugly, and my patch just makes it uglier 
> still. I wonder if there is some cleaner way to do the same thing.

Well, which thing?  

As to this locking issue, something I was considering to reduce that dance
was changing release_task to take a flag saying the caller already holds
some lock.  That would be to make things hold the tasklist_lock for longer
stretches than it does now, which might not be what we wnat.

I can think of two approaches to simply avoid calling release_task inside
that loop in forget_original_parent, and so have the locking issue to
contend with, if that is what you mean.  First, queue them on a list for
calling release_task later when life is calmer.  The following patch works:

--- linux-2.6.7-mm4/kernel/exit.c.~1~	2004-06-30 16:29:06.000000000 -0700
+++ linux-2.6.7-mm4/kernel/exit.c	2004-06-30 23:03:57.000000000 -0700
@@ -594,7 +594,8 @@ static inline void reparent_thread(task_
  * group, and if no such member exists, give it to
  * the global child reaper process (ie "init")
  */
-static inline void forget_original_parent(struct task_struct * father)
+static inline void forget_original_parent(struct task_struct * father,
+					  struct list_head *to_release)
 {
 	struct task_struct *p, *reaper = father;
 	struct list_head *_p, *_n;
@@ -618,9 +619,19 @@ static inline void forget_original_paren
 			reparent_thread(p, father, 0);
 		} else {
 			ptrace_unlink (p);
-			if (p->state == TASK_ZOMBIE && p->exit_signal != -1 &&
-			    thread_group_empty(p))
-				do_notify_parent(p, p->exit_signal);
+			if (p->state == TASK_ZOMBIE) {
+				if (p->exit_signal == -1) {
+					/*
+					 * This was only a zombie because
+					 * we were tracing it.  Now it should
+					 * disappear as it would have done
+					 * if we hadn't been tracing it.
+					 */
+					list_add(&p->ptrace_list, to_release);
+				}
+				else if (thread_group_empty(p))
+					do_notify_parent(p, p->exit_signal);
+			}
 		}
 	}
 	list_for_each_safe(_p, _n, &father->ptrace_children) {
@@ -638,6 +649,7 @@ static void exit_notify(struct task_stru
 {
 	int state;
 	struct task_struct *t;
+	struct list_head ptrace_dead, *_p, *_n;
 
 	if (signal_pending(tsk) && !tsk->signal->group_exit
 	    && !thread_group_empty(tsk)) {
@@ -673,7 +685,8 @@ static void exit_notify(struct task_stru
 	 *	jobs, send them a SIGHUP and then a SIGCONT.  (POSIX 3.2.2.2)
 	 */
 
-	forget_original_parent(tsk);
+	INIT_LIST_HEAD(&ptrace_dead);
+	forget_original_parent(tsk, &ptrace_dead);
 	BUG_ON(!list_empty(&tsk->children));
 
 	/*
@@ -759,6 +772,12 @@ static void exit_notify(struct task_stru
 	_raw_write_unlock(&tasklist_lock);
 	local_irq_enable();
 
+	list_for_each_safe(_p, _n, &ptrace_dead) {
+		list_del_init(_p);
+		t = list_entry(_p,struct task_struct,ptrace_list);
+		release_task(t);
+	}
+
 	/* If the process is dead, release it - nobody will wait for it */
 	if (state == TASK_DEAD)
 		release_task(tsk);


The second approach to that is to have some other thread call release_task
for you.  The benefit there would be no change whatsoever in the main
exit_notify code path, the only new code in the exit path being in just
this one unusual case.  To make init do that reaping in the normal course
of things might be a pain.  The thread would have to be fully divorced from
its thread group and made a normal zombie (i.e. only one in its own thread
group) in its own right.  Tweaking the pid hashes to do that entails its
own locking nightmare.  If not init, it could be some random kernel service
thread, but I don't see what existing thread would want to do such a thing.

Both of those are probably worse in real costs than the ugliness of
dropping and reacquiring the lock around calling release_task in the loop.

If you are talking about reorganizing exit handling in a larger sense not
to have this kind of trouble, then that would take more thought than I am
going to give it tonight.


Thanks,
Roland
