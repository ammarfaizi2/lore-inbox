Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318203AbSIEVlS>; Thu, 5 Sep 2002 17:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318205AbSIEVlS>; Thu, 5 Sep 2002 17:41:18 -0400
Received: from crack.them.org ([65.125.64.184]:55044 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S318203AbSIEVlN>;
	Thu, 5 Sep 2002 17:41:13 -0400
Date: Thu, 5 Sep 2002 17:44:59 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] ptrace-fix-2.5.33-A1
Message-ID: <20020905214459.GA13813@nevyn.them.org>
Mail-Followup-To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209051728490.18985-100000@localhost.localdomain> <874rd4cqki.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874rd4cqki.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply this patch.  It fixes debugging a process when the
process's original parent exits; we shouldn't detach the debugger.

On Fri, Sep 06, 2002 at 02:08:13AM +0900, OGAWA Hirofumi wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> > Linus,
> > 
> > the attached patch (against BK-curr) collects two ptrace related fixes:  
> > first it undoes Ogawa's change (so various uses of ptrace works again),
> > plus it adds Daniel's suggested fix that allows a parent to PTRACE_ATTACH
> > to a child it forked. (this also fixes the incorrect BUG_ON() assert
> > Ogawa's patch was intended to fix in the first place.)
> > 
> > i've tested various ptrace uses and they appear to work just fine.
> > 
> > (Daniel, let us know if you can still see anything questionable in this
> > area - or if the ptrace list could be managed in a cleaner way.)
> 
> I think I found some bugs.

There's definitely still something wrong... let me just run through my
understanding of these lists, to make sure we're on the same page.

tsk->children: tsk's children, which are either untraced or traced by
	tsk.  They have p->parent == p->real_parent == tsk.
	Chained in p->sibling.
tsk->ptrace_children: tsk's children, which are traced by some other
	process.  They have p->real_parent == tsk and p->parent != tsk.
	Chained in p->ptrace_list.

When a parent dies, its traced children should continue to be traced
even though they are reparented.  That's broken right now - you can
test that easily enough.  When a tracer dies, all processes it is
tracing should be marked untraced; that's also broken right now, I
think but have not tested.

> in sys_wait4()
> 
> +				} else {
> +					if (p->ptrace) {
> +						write_lock_irq(&tasklist_lock);
> +						ptrace_unlink(p);
> +						write_unlock_irq(&tasklist_lock);
> +					}
>  					release_task(p);
> +				}
> 
> Umm, why needed this? If ->real_parent == ->parent, it's real
> child. So this child don't use ->ptrace_list.

You're right.  I was just using ptrace_unlink to clear p->ptrace. 
Fixed in my earlier patch.

>  	list_for_each(_p, &father->children) {
>  		p = list_entry(_p,struct task_struct,sibling);
> -		reparent_thread(p, reaper, child_reaper);
> +		if (p->real_parent == father)
> +			reparent_thread(p, reaper, child_reaper);
>  	}

This should never be necessary.  If something is on the ->children
list, p->parent == father.  There should be no exceptions until after
reparent_thread; do you see one?

> -	list_for_each(_p, &father->ptrace_children) {
> +	list_for_each_safe(_p, _n, &father->ptrace_children) {
>  		p = list_entry(_p,struct task_struct,ptrace_list);
> +		list_del_init(&p->ptrace_list);
>  		reparent_thread(p, reaper, child_reaper);
> +
> +		/* This is needed for thread group reparent */
> +		if (p->real_parent != child_reaper &&
> +		    p->real_parent != p->parent)
> +			list_add(&p->ptrace_list, &p->real_parent->ptrace_children);
>  	}
>  	read_unlock(&tasklist_lock);
>  }

Something is wrong here but I don't think this is the right place to
fix it - it isn't safe.  If we have traced children, and their parent
dies... well, currently they become untraced, and that certainly is not
right.  I like this patch a little more; cleaner and saves some cycles
(probably).  Passed my stress testing with flying colors.

===== kernel/exit.c 1.46 vs edited =====
*** /tmp/exit.c-1.46-10686	Thu Sep  5 14:41:56 2002
--- kernel/exit.c	Thu Sep  5 16:58:30 2002
*************** static void release_task(struct task_str
*** 68,74 ****
  	free_uid(p->user);
  	if (unlikely(p->ptrace)) {
  		write_lock_irq(&tasklist_lock);
! 		ptrace_unlink(p);
  		write_unlock_irq(&tasklist_lock);
  	}
  	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
--- 68,74 ----
  	free_uid(p->user);
  	if (unlikely(p->ptrace)) {
  		write_lock_irq(&tasklist_lock);
! 		__ptrace_unlink(p);
  		write_unlock_irq(&tasklist_lock);
  	}
  	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
*************** static inline void forget_original_paren
*** 432,438 ****
  	 * There are only two places where our children can be:
  	 *
  	 * - in our child list
! 	 * - in the global ptrace list
  	 *
  	 * Search them and reparent children.
  	 */
--- 432,438 ----
  	 * There are only two places where our children can be:
  	 *
  	 * - in our child list
! 	 * - in our ptraced child list
  	 *
  	 * Search them and reparent children.
  	 */
*************** static inline void forget_original_paren
*** 447,460 ****
  	read_unlock(&tasklist_lock);
  }
  
! static inline void zap_thread(task_t *p, task_t *father)
  {
! 	ptrace_unlink(p);
! 	list_del_init(&p->sibling);
! 	p->ptrace = 0;
  
- 	p->parent = p->real_parent;
- 	list_add_tail(&p->sibling, &p->parent->children);
  	if (p->state == TASK_ZOMBIE && p->exit_signal != -1)
  		do_notify_parent(p, p->exit_signal);
  	/*
--- 447,468 ----
  	read_unlock(&tasklist_lock);
  }
  
! static inline void zap_thread(task_t *p, task_t *father, int traced)
  {
! 	/* If we were tracing the thread, release it; otherwise preserve the
! 	   ptrace links.  */
! 	if (unlikely(traced)) {
! 		task_t *trace_task = p->parent;
! 		__ptrace_unlink(p);
! 		p->ptrace = 1;
! 		__ptrace_link(p, trace_task);
! 	} else {
! 		p->ptrace = 0;
! 		list_del_init(&p->sibling);
! 		p->parent = p->real_parent;
! 		list_add_tail(&p->sibling, &p->parent->children);
! 	}
  
  	if (p->state == TASK_ZOMBIE && p->exit_signal != -1)
  		do_notify_parent(p, p->exit_signal);
  	/*
*************** static void exit_notify(void)
*** 545,555 ****
  
  zap_again:
  	list_for_each_safe(_p, _n, &current->children)
! 		zap_thread(list_entry(_p,struct task_struct,sibling), current);
  	list_for_each_safe(_p, _n, &current->ptrace_children)
! 		zap_thread(list_entry(_p,struct task_struct,ptrace_list), current);
  	/*
! 	 * reparent_thread might drop the tasklist lock, thus we could
  	 * have new children queued back from the ptrace list into the
  	 * child list:
  	 */
--- 553,563 ----
  
  zap_again:
  	list_for_each_safe(_p, _n, &current->children)
! 		zap_thread(list_entry(_p,struct task_struct,sibling), current, 0);
  	list_for_each_safe(_p, _n, &current->ptrace_children)
! 		zap_thread(list_entry(_p,struct task_struct,ptrace_list), current, 1);
  	/*
! 	 * zap_thread might drop the tasklist lock, thus we could
  	 * have new children queued back from the ptrace list into the
  	 * child list:
  	 */
*************** repeat:
*** 720,726 ****
  				retval = p->pid;
  				if (p->real_parent != p->parent) {
  					write_lock_irq(&tasklist_lock);
! 					ptrace_unlink(p);
  					do_notify_parent(p, SIGCHLD);
  					write_unlock_irq(&tasklist_lock);
  				} else
--- 728,734 ----
  				retval = p->pid;
  				if (p->real_parent != p->parent) {
  					write_lock_irq(&tasklist_lock);
! 					__ptrace_unlink(p);
  					do_notify_parent(p, SIGCHLD);
  					write_unlock_irq(&tasklist_lock);
  				} else


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
