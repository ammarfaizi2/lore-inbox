Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318608AbSH1CsR>; Tue, 27 Aug 2002 22:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318622AbSH1CsR>; Tue, 27 Aug 2002 22:48:17 -0400
Received: from crack.them.org ([65.125.64.184]:26895 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S318608AbSH1CsQ>;
	Tue, 27 Aug 2002 22:48:16 -0400
Date: Tue, 27 Aug 2002 22:53:37 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Dave McCracken <dmccr@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
Message-ID: <20020828025337.GA23860@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Dave McCracken <dmccr@us.ibm.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0208191427220.1484-100000@penguin.transmeta.com> <Pine.LNX.4.44.0208201634410.22388-100000@localhost.localdomain> <20020827153957.GA9953@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020827153957.GA9953@nevyn.them.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 11:39:57AM -0400, Daniel Jacobowitz wrote:
> On Tue, Aug 20, 2002 at 04:36:19PM +0200, Ingo Molnar wrote:
> > 
> > the attached patch ontop of BK-curr fixes the ptrace wait4() anomaly that
> > can be observed in any previous Linux kernel i could get my hands at. So
> > in fact ->ptrace_children, besides being a speedup, also fixed a bug that
> > couldnt be fixed in any satisfactory way before.
> > 
> > 	Ingo
> > 
> > --- linux/kernel/exit.c.orig	Tue Aug 20 16:28:57 2002
> > +++ linux/kernel/exit.c	Tue Aug 20 16:30:13 2002
> > @@ -731,7 +731,7 @@
> >  		tsk = next_thread(tsk);
> >  	} while (tsk != current);
> >  	read_unlock(&tasklist_lock);
> > -	if (flag) {
> > +	if (flag || !list_empty(&current->ptrace_children)) {
> >  		retval = 0;
> >  		if (options & WNOHANG)
> >  			goto end_wait4;
> 
> Ingo,
> 
> At this point your ptrace changes have completely broken both
> _TRACEME/exec and _ATTACH debugging.  If an attached process finishes
> while a debugger is attached, its parent no longer gets the proper wait
> result for it:
> 
> wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG|WUNTRACED, NULL) = 478
> wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG|WUNTRACED, NULL) = 478
> wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG|WUNTRACED, NULL) = 478
> wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG|WUNTRACED, NULL) = 478
> wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG|WUNTRACED, NULL) = 478
> wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG|WUNTRACED, NULL) = 478
> 
> etc.  It is never removed from the list.  _TRACEME/exec debugging
> appears to have the same problem but it's harder to tell, since one can
> not strace GDB in 2.5 without the patch I posted here two weeks ago. 
> If you don't have a chance to look at this I'll investigate later
> today.

The problem is the line:
                                retval = p->pid;
!!!                             if (p->real_parent != p->parent || p->ptrace) {
                                        write_lock_irq(&tasklist_lock);
                                        remove_parent(p);
                                        p->parent = p->real_parent;
                                        add_parent(p, p->parent);
                                        do_notify_parent(p, SIGCHLD);
					write_unlock_irq(&tasklist_lock);
                                } else  
                                        release_task(p);

p->ptrace continues to be true, even if the real parent is waiting for
it.  So we go through this code time after time once p->real_parent ==
p->parent, sending it extra SIGCHLDs and not releasing the task.  I
don't think that change is correct but I'm not clear what you're doing
with the reparenting right now, so I don't know the right fix.

You might want to add:
gdb /bin/ls
run
run

to your stress testing in the future.


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
