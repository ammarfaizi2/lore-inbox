Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbWJFUmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWJFUmm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWJFUmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:42:42 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:51409 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932626AbWJFUml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:42:41 -0400
Date: Fri, 6 Oct 2006 22:42:37 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
Message-ID: <20061006204237.GL14186@rhun.haifa.ibm.com>
References: <20061005212216.GA10912@rhun.haifa.ibm.com> <m11wpl328i.fsf@ebiederm.dsl.xmission.com> <20061006155021.GE14186@rhun.haifa.ibm.com> <20061006162054.GF14186@rhun.haifa.ibm.com> <20061006190039.GN2365@n6014avq19270.qlogic.org> <20061006124213.28afb767.akpm@osdl.org> <20061006200223.GT2365@n6014avq19270.qlogic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006200223.GT2365@n6014avq19270.qlogic.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 01:02:23PM -0700, Andrew Vasquez wrote:

> > diff -puN arch/x86_64/kernel/apic.c~x86_64-irq_regs-fix arch/x86_64/kernel/apic.c
> > --- a/arch/x86_64/kernel/apic.c~x86_64-irq_regs-fix
> > +++ a/arch/x86_64/kernel/apic.c
> > @@ -913,8 +913,10 @@ void smp_local_timer_interrupt(void)
> >   * [ if a single-CPU system runs an SMP kernel then we call the local
> >   *   interrupt as well. Thus we cannot inline the local irq ... ]
> >   */
> > -void smp_apic_timer_interrupt(void)
> > +void smp_apic_timer_interrupt(struct pt_regs *regs)
> >  {
> > +	struct pt_regs *old_regs = set_irq_regs(regs);
> > +
> >  	/*
> >  	 * the NMI deadlock-detector uses this.
> >  	 */
> > @@ -934,6 +936,7 @@ void smp_apic_timer_interrupt(void)
> >  	irq_enter();
> >  	smp_local_timer_interrupt();
> >  	irq_exit();
> > +	set_irq_regs(old_regs);
> >  }
> >  
> >  /*
> 
> Patch appears to work.
> 
> At least I can now boot my x86_64 box.

Patch fixes the profile_tick() problem for me too. I can boot the tip
of the tree now provided I use maxcpus=1 to work around the genirq
bug.

Cheers,
Muli
