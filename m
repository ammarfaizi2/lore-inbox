Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWEOUnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWEOUnH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWEOUnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:43:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18101 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751244AbWEOUnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:43:05 -0400
Date: Mon, 15 May 2006 13:45:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [FIXED] Re: Total machine lockup w/ current kernels while
 installing from CD
Message-Id: <20060515134537.78e117dc.akpm@osdl.org>
In-Reply-To: <200605152232.04304.bero@arklinux.org>
References: <200605110322.14774.bero@arklinux.org>
	<200605152232.04304.bero@arklinux.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
>
> On Thursday, 11. May 2006 03:22, Bernhard Rosenkraenzer wrote:
> > Hi,
> > I've built a CD that installs a customized system
> > [... crash at a random point ...]
> > BUG: soft lockup detected on CPU#0!
> >
> > Pid: 421, comm: kjournald
> > EIP: 0060:[<b01a2f52>] CPU: 0
> > EIP is at journal_commit_transaction+0x92e/0xfcc
> > EFLAGS: 00000297 Not tainted (2.6.16-rc6 #1)
> > EAX: 00000001 EBX: c2d34788 ECX: 00000001 EDX: c785e000
> > ESI: b3ff8d04 EDI: 000000f0 EBP: b683b840 DS: 007b ES: 007b
> > CR0: 8005003b CR2: 0841f7fc CR3: 17217000 CR4: 000006d0
> >  [<b02bd52e>] schedule+0x2ee/0x5b6
> >  [<b01a6a88>] kjournald+0x201/0x213
> >  [<b0111089>] smp_apic_timer_interrupt+0x32/0x49
> >  [<b01a6937>] kjournald+0xb0/0x213
> >  [<b01a5ffa>] commit_timeout+0x0/0x9
> >  [<b012a789>] autoremove_wake_function+0x0/0x4b
> >  [<b01a6887>] kjournald+0x0/0x213
> >  [<b0101005>] kernel_thread_helper+0x5/0xb
> 
> After backing out lots of changes, I've figured out the problem is caused by 
> this bit of 2.6.16-rc6:
> 
> diff -urN linux-2.6.16-rc5/kernel/sched.c linux-2.6.16-rc6/kernel/sched.c
> --- linux-2.6.16-rc5/kernel/sched.c	2006-05-11 20:04:18.000000000 +0200
> +++ linux-2.6.16-rc6/kernel/sched.c	2006-05-11 20:00:00.000000000 +0200
> @@ -4028,6 +4021,8 @@
>  	 */
>  	if (unlikely(preempt_count()))
>  		return;
> +	if (unlikely(system_state != SYSTEM_RUNNING))
> +		return;
>  	do {
>  		add_preempt_count(PREEMPT_ACTIVE);
>  		schedule();

(That's cond_resched())

> 
> The problem is that (to save a couple of bits of space), my simple installer 
> was running inside an initrd -- and system_state isn't set to SYSTEM_RUNNING 
> before linuxrc is executed --> scheduler breakage causes the oops.

ah-hah.

It's odd that we'll run initrds in a !SYSTEM_RUNNING state.

It's not an oops - it's sort-of a warning.  Did the system actually
continue to run and boot up OK?

If so, I'd assume that the ext3 filesystem was mounted on a very slow
device - perhaps an IDE disk in PIO mode?

Perhaps we should poke the softlockup detector if someone called
cond_resched() when in a reschedulable state.

