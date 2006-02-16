Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWBPTe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWBPTe3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWBPTe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:34:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53143 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932532AbWBPTe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:34:28 -0500
Date: Thu, 16 Feb 2006 11:34:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paulo Marques <pmarques@grupopie.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [SOLVED] Trap flag handling change in 2.6.10-bk5 broke Kylix
 debugger
In-Reply-To: <43F46B1C.3070208@grupopie.com>
Message-ID: <Pine.LNX.4.64.0602161127040.916@g5.osdl.org>
References: <43F23BB4.8070703@grupopie.com> <Pine.LNX.4.64.0602141243020.3691@g5.osdl.org>
 <43F36833.9060100@grupopie.com> <43F46B1C.3070208@grupopie.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Feb 2006, Paulo Marques wrote:
> 
> I changed the unconditional set of the flag to:
> 
> +		if (test_tsk_thread_flag(child, TIF_SINGLESTEP))
> +			regs->eflags |= TRAP_FLAG;
> 
> and the debugger got a little further, but still had problems. I straced it
> again and saw that it was also using PTRACE_SETREGS, probably sending the same
> flag values it received, and that was causing problems.
> 
> We then filtered the trap flag in PTRACE_SETREGS, too. The result is the
> attached patch. The debugger worked fine with this patch applied on top of a
> vanilla 2.6.16-rc3 kernel.
> 
> This is an extremelly ugly hack, specially because it basically shows the trap
> flag again, which is exactly what we wanted to avoid when the 2.6.10-bk5
> kernel code was written.
> 
> Anyway, since it only affected the ptrace call, I tried to solve this using a
> LD_PRELOAD stub on the ptrace function in user-space. The debugger is actually
> a dynamic executable and indeed had the ptrace undefined symbol, so my chances
> were good.
> 
> The result was the attached program that interposes the ptrace call and sets /
> clears the trap flag to fool the kylix debugger.
> 
> The problem with this approach is that it is not easy to see from user space
> if the child process is being single stepped or not.
> 
> I tried to replace the kernel code:
> 
> + if (test_tsk_thread_flag(child, TIF_SINGLESTEP))
> 
> with:
> 
> + ret = func(PTRACE_PEEKUSER, pid, &(((struct user *) 0)->u_debugreg[6]),
> NULL);
> + if (ret & DR_STEP)
> 
> because in arch/i386/kernel/traps.c there is this code:
> 
> 	/* Save debug status register where ptrace can see it */
> 	tsk->thread.debugreg[6] = condition;
> 
> 	/*
> 	 * Single-stepping through TF: make sure we ignore any events in
> 	 * kernel space (but re-enable TF when returning to user mode).
> 	 */
> 	if (condition & DR_STEP) {
> 
> that made it look like there was some single stepping information stored in
> debugreg[6]. However, the debugger didn't work, so I suppose that debugreg
> isn't updated as often as I wanted to, or something like that.
> 
> I did a workaround in the interposer (remembering that a single step was
> requested so that it sets the trap flag on the next call to ptrace) and the
> debugger actually works, but I would prefer to do it better.

Ok. It does seem like the debugger is using the TF bit in the debuggee to 
"remember" whether it was single-stepping or not.

Which is pretty insane.

> BTW, is there a good way to do the "test_tsk_thread_flag(child,
> TIF_SINGLESTEP)" from user space?

Not really. Except you should just remember that you asked for 
single-stepping. That, together with the status return on the wait (which 
tells you why the process stopped - the single-step could have been 
aborted because of a real fault), should be plenty good enough, and sounds 
like the natural way to do this.

Relying on the TF bit, which is under the control of the debugged 
application itself, is kind of hokey.

So your patch isn't too intrusive, which is nice. The thing that _isn't_ 
nice about it is that it means that the debugger cannot actually set the 
TF bit "for real" on the process it is debugging, and it cannot really ask 
for what the state of the TF bit is (because it will be overshadowed by 
the debugger single-stepping).

So I like your patch because it re-instates old (admittedly broken) 
behaviour without breaking the _internal_ kernel logic (just the "external 
interface"). And while the old behaviour _was_ broken, being backwards 
compatible is damn important.

That said, I'd be a lot happier if we could just fix Kylix instead ;(

		Linus
