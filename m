Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVAaNX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVAaNX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 08:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVAaNXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 08:23:55 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:54940
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261194AbVAaNXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 08:23:52 -0500
Subject: Re: [PATCH] rc2-mm2: unneeded cli/sti in fix-preemption-race patch
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <41FE319E.E265C599@tv-sign.ru>
References: <41FE319E.E265C599@tv-sign.ru>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 14:22:25 +0100
Message-Id: <1107177745.21196.333.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 16:24 +0300, Oleg Nesterov wrote:
> Hello.
> 
> Thomas Gleixner wrote:
> >
> > The patch prevents this by leaving interrupts disabled and calling
> > a seperate function preempt_schedule_irq().
> 
> sched-fix-preemption-race-core-i386.patch:
> >
> >	+++ 25-akpm/arch/i386/kernel/entry.S
> >	@@ -189,6 +189,7 @@ ENTRY(resume_userspace)
> >	 
> >	 #ifdef CONFIG_PREEMPT
> >	 ENTRY(resume_kernel)
> >	+	cli
> 
> I think this 'cli' is unneeded. resume_kernel: is used on
> return path from do_IRQ() which leaves interrupts disabled.
> irq_desc->handler->end() should not enable interrupts, yes?
> 
> And we have preempt_stop==cli in ret_from_exception: case,
> before ret_from_intr.

Right. I missed the preempt_stop == cli.

> >	+++ 25-akpm/kernel/sched.c
> >	@@ -2872,6 +2872,48 @@ need_resched:
> >	...
> >	+asmlinkage void __sched preempt_schedule_irq(void)
> >	+{
> >	...
> >	+	local_irq_enable();
> >	+	schedule();
> 
> It is ok to enter schedule() with interrupts disabled, so this
> 'sti' seems to be unneeded too.

Makes sense.

tglx

> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.11-rc2-mm2/arch/i386/kernel/entry.S~	Mon Jan 31 14:09:37 2005
> +++ 2.6.11-rc2-mm2/arch/i386/kernel/entry.S	Mon Jan 31 14:55:25 2005
> @@ -189,7 +189,6 @@ ENTRY(resume_userspace)
>  
>  #ifdef CONFIG_PREEMPT
>  ENTRY(resume_kernel)
> -	cli
>  	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
>  	jnz restore_all
>  need_resched:
> --- 2.6.11-rc2-mm2/kernel/sched.c~	Mon Jan 31 14:09:54 2005
> +++ 2.6.11-rc2-mm2/kernel/sched.c	Mon Jan 31 14:57:44 2005
> @@ -2971,7 +2971,6 @@ need_resched:
>  	saved_lock_depth = task->lock_depth;
>  	task->lock_depth = -1;
>  #endif
> -	local_irq_enable();
>  	schedule();
>  	local_irq_disable();
>  #ifdef CONFIG_PREEMPT_BKL

