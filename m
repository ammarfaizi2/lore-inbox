Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWJFUC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWJFUC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWJFUC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:02:27 -0400
Received: from pat.qlogic.com ([198.70.193.2]:61261 "EHLO avexch1.qlogic.com")
	by vger.kernel.org with ESMTP id S932482AbWJFUC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:02:26 -0400
Date: Fri, 6 Oct 2006 13:02:23 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
Message-ID: <20061006200223.GT2365@n6014avq19270.qlogic.org>
References: <20061005212216.GA10912@rhun.haifa.ibm.com> <m11wpl328i.fsf@ebiederm.dsl.xmission.com> <20061006155021.GE14186@rhun.haifa.ibm.com> <20061006162054.GF14186@rhun.haifa.ibm.com> <20061006190039.GN2365@n6014avq19270.qlogic.org> <20061006124213.28afb767.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006124213.28afb767.akpm@osdl.org>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 06 Oct 2006 20:02:26.0185 (UTC) FILETIME=[5839EF90:01C6E982]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2006, Andrew Morton wrote:

> On Fri, 6 Oct 2006 12:00:39 -0700
> Andrew Vasquez <andrew.vasquez@qlogic.com> wrote:
> 
> > [   27.510539] Booting processor 1/2 APIC 0x1
> > [   27.514684] Unable to handle kernel NULL pointer dereference at 0000000000000088 RIP: 
> > [   27.520204]  [<ffffffff80225fb0>] profile_tick+0x40/0x90
> > [   27.528118] PGD 0 
> > [   27.530222] Oops: 0000 [1] SMP 
> > [   27.533505] CPU 0 
> > [   27.535610] Modules linked in:
> > [   27.538755] Pid: 1, comm: swapper Not tainted 2.6.19-rc1 #5
> > [   27.544367] RIP: 0010:[<ffffffff80225fb0>]  [<ffffffff80225fb0>] profile_tick+0x40/0x90
> > [   27.552483] RSP: 0000:ffffffff8059ff78  EFLAGS: 00010046
> > [   27.557842] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> > [   27.565024] RDX: ffff810081a77f40 RSI: 0000000000000046 RDI: 0000000000000001
> > [   27.572203] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000007
> 
> 
> hm, we seem to have broken x86_64 completely.
> 
> smp_apic_timer_interrupt() needs to do
> 
> 	struct pt_regs *old_regs = set_irq_regs(regs);
> 
> on entry and
> 
> 	set_irq_regs(old_regs);
> 
> on exit.
> 
> But it doesn't get passed the pt_regs*
> 
> >From my reading of `macro apicinterrupt' in arch/x86_64/kernel/entry.S,
> smp_apic_timer_interrupt() actually _does_ get passed the pt_reg*, only it
> doesn't declare it.  I think - Andi would need to confirm.
> 
> If I'm right...
> 
> 
> diff -puN arch/x86_64/kernel/apic.c~x86_64-irq_regs-fix arch/x86_64/kernel/apic.c
> --- a/arch/x86_64/kernel/apic.c~x86_64-irq_regs-fix
> +++ a/arch/x86_64/kernel/apic.c
> @@ -913,8 +913,10 @@ void smp_local_timer_interrupt(void)
>   * [ if a single-CPU system runs an SMP kernel then we call the local
>   *   interrupt as well. Thus we cannot inline the local irq ... ]
>   */
> -void smp_apic_timer_interrupt(void)
> +void smp_apic_timer_interrupt(struct pt_regs *regs)
>  {
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
>  	/*
>  	 * the NMI deadlock-detector uses this.
>  	 */
> @@ -934,6 +936,7 @@ void smp_apic_timer_interrupt(void)
>  	irq_enter();
>  	smp_local_timer_interrupt();
>  	irq_exit();
> +	set_irq_regs(old_regs);
>  }
>  
>  /*

Patch appears to work.

At least I can now boot my x86_64 box.
