Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318058AbSIESbu>; Thu, 5 Sep 2002 14:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318059AbSIESbu>; Thu, 5 Sep 2002 14:31:50 -0400
Received: from crack.them.org ([65.125.64.184]:3588 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S318058AbSIESbr>;
	Thu, 5 Sep 2002 14:31:47 -0400
Date: Thu, 5 Sep 2002 14:36:09 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ptrace-fix-2.5.33-A1
Message-ID: <20020905183609.GA26898@nevyn.them.org>
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

I'll reply to the rest of this in a moment, but one thing at a time...

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

You're right, we just need to clear p->ptrace.  And there was a problem
with debugged detached tasks.  Ingo, does this look right to you?  It
passes my testing.  Handle unlinking in release_task instead of at both
call sites, since they both need it.

===== exit.c 1.45 vs edited =====
*** /tmp/exit.c-1.45-26998	Mon Sep  2 01:15:09 2002
--- exit.c	Thu Sep  5 14:23:32 2002
*************** static void release_task(struct task_str
*** 66,71 ****
--- 66,76 ----
  	atomic_dec(&p->user->processes);
  	security_ops->task_free_security(p);
  	free_uid(p->user);
+ 	if (unlikely(p->ptrace)) {
+ 		write_lock_irq(&tasklist_lock);
+ 		ptrace_unlink(p);
+ 		write_unlock_irq(&tasklist_lock);
+ 	}
  	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
  	unhash_process(p);
  
===== ptrace.c 1.16 vs edited =====
*** /tmp/ptrace.c-1.16-26998	Mon Aug 19 14:12:27 2002
--- ptrace.c	Thu Sep  5 14:18:05 2002
*************** void __ptrace_link(task_t *child, task_t
*** 29,35 ****
  	if (!list_empty(&child->ptrace_list))
  		BUG();
  	if (child->parent == new_parent)
! 		BUG();
  	list_add(&child->ptrace_list, &child->parent->ptrace_children);
  	REMOVE_LINKS(child);
  	child->parent = new_parent;
--- 29,35 ----
  	if (!list_empty(&child->ptrace_list))
  		BUG();
  	if (child->parent == new_parent)
! 		return;
  	list_add(&child->ptrace_list, &child->parent->ptrace_children);
  	REMOVE_LINKS(child);
  	child->parent = new_parent;


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
