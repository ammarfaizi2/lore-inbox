Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318747AbSIFPlT>; Fri, 6 Sep 2002 11:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318764AbSIFPlT>; Fri, 6 Sep 2002 11:41:19 -0400
Received: from crack.them.org ([65.125.64.184]:46087 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S318747AbSIFPkf>;
	Fri, 6 Sep 2002 11:40:35 -0400
Date: Fri, 6 Sep 2002 11:45:08 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] ptrace-fix-2.5.33-A1
Message-ID: <20020906154508.GA20709@nevyn.them.org>
Mail-Followup-To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209060058040.20904-100000@localhost.localdomain> <87vg5j2l5g.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87vg5j2l5g.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments.

On Sat, Sep 07, 2002 at 12:27:39AM +0900, OGAWA Hirofumi wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> > i've attached a combined patch of your two patches, against BK-curr. Looks
> > good to me, and since it passed your more complex ptrace tests ...
> > 
> > 	Ingo
> > 
> > --- linux/kernel/exit.c.orig	Fri Sep  6 00:55:02 2002
> > +++ linux/kernel/exit.c	Fri Sep  6 00:57:58 2002
> > @@ -66,6 +66,11 @@
> >  	atomic_dec(&p->user->processes);
> >  	security_ops->task_free_security(p);
> >  	free_uid(p->user);
> > +	if (unlikely(p->ptrace)) {
> > +		write_lock_irq(&tasklist_lock);
> > +		__ptrace_unlink(p);
> > +		write_unlock_irq(&tasklist_lock);
> > +	}
> >  	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
> 
> Looks like it's need the only CLONE_DETACH process. Why it's here?

Because it's also needed for non-CLONE_DETACH processes.  I added it
earlier down by the release_task, remember?  I deleted it in this patch
originally, and the change got lost somewhere; my intent is to check
for this only in release_task and nowhere else.  When I have a clear
point to resync with Linus again then I'll make sure this is right.

> 	 * Search them and reparent children.
> 	 */
> 	list_for_each(_p, &father->children) {
> 		p = list_entry(_p,struct task_struct,sibling);
> 		reparent_thread(p, reaper, child_reaper);
> 	}
> 
> Looks like that tracer deprive a process from real parent.

Oh - when the tracer exits the original parent may be corrupted, you
mean?  I guess you're right.  But I've made so many changes to this bit
of code that I'd like to wait until it settles before we fix this -
it's not a new problem.

> 	list_for_each(_p, &father->ptrace_children) {
> 		p = list_entry(_p,struct task_struct,ptrace_list);
> 		reparent_thread(p, reaper, child_reaper);
> 	}
> 
> Thread group makes the child which links both ->children and
> ->ptrace_children.

I don't understand what you mean.

> >  {
> > -	ptrace_unlink(p);
> > -	list_del_init(&p->sibling);
> > -	p->ptrace = 0;
> > +	/* If we were tracing the thread, release it; otherwise preserve the
> > +	   ptrace links.  */
> > +	if (unlikely(traced)) {
> > +		task_t *trace_task = p->parent;
> > +		__ptrace_unlink(p);
> > +		p->ptrace = 1;
> 
> Unexpected change of ptrace flag.

I should've caught that, I actually use the ptrace flags here.  But the
code that uses them is suffering some other BUG() right now.

> > +		__ptrace_link(p, trace_task);
> > +	} else {
> > +		p->ptrace = 0;
> > +		list_del_init(&p->sibling);
> > +		p->parent = p->real_parent;
> > +		list_add_tail(&p->sibling, &p->parent->children);
> 
> Looks like that tracing child still link ->ptrace_list.

Right on both counts; how's this look (on top of the last patch):

===== exit.c 1.49 vs edited =====
--- 1.49/kernel/exit.c	Fri Sep  6 11:26:02 2002
+++ edited/exit.c	Fri Sep  6 11:37:50 2002
@@ -449,15 +449,19 @@
 
 static inline void zap_thread(task_t *p, task_t *father, int traced)
 {
-	/* If we were tracing the thread, release it; otherwise preserve the
-	   ptrace links.  */
+	/* If someone else is tracing this thread, preserve the ptrace links.  */
 	if (unlikely(traced)) {
 		task_t *trace_task = p->parent;
+		int ptrace_flag = p->ptrace;
+		BUG_ON (ptrace_flag == 0);
+
 		__ptrace_unlink(p);
-		p->ptrace = 1;
+		p->ptrace = ptrace_flag;
 		__ptrace_link(p, trace_task);
 	} else {
-		p->ptrace = 0;
+		/* Otherwise, if we were tracing this thread, untrace it.  */
+		ptrace_unlink (p);
+
 		list_del_init(&p->sibling);
 		p->parent = p->real_parent;
 		list_add_tail(&p->sibling, &p->parent->children);

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
