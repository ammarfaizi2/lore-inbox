Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbVJDRur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVJDRur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVJDRuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:50:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:7114 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932536AbVJDRuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:50:46 -0400
Date: Tue, 4 Oct 2005 23:28:42 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
Message-ID: <20051004175842.GA5072@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com> <20051004130009.GB31466@elte.hu> <Pine.LNX.4.58.0510040943540.13294@localhost.localdomain> <20051004142718.GA3195@elte.hu> <20051004151635.GA8866@in.ibm.com> <1128442180.4252.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128442180.4252.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 09:09:40AM -0700, Daniel Walker wrote:
> On Tue, 2005-10-04 at 20:46 +0530, Dinakar Guniguntala wrote:
> > 
> > BUG: auditd:3596, possible softlockup detected on CPU#3!
> >  [<c0144c48>] softlockup_detected+0x39/0x46 (8)
> >  [<c0144d26>] softlockup_tick+0xd1/0xd3 (20)
> >  [<c0111252>] smp_apic_timer_ipi_interrupt+0x4d/0x56 (24)
> >  [<c010396c>] apic_timer_ipi_interrupt+0x1c/0x24 (12)
> >  [<c0102e7f>] sysenter_past_esp+0x24/0x75 (44)
> 
> 
> Woops, forgot to CC LKML .. 
> 
> Index: linux-2.6.13/arch/i386/kernel/apic.c
> ===================================================================
> --- linux-2.6.13.orig/arch/i386/kernel/apic.c
> +++ linux-2.6.13/arch/i386/kernel/apic.c
> @@ -1153,6 +1153,16 @@ fastcall notrace void smp_apic_timer_ipi
>  #if 0
>  	profile_tick(CPU_PROFILING, regs);
>  #endif
> +
> +        /*
> +         * If the task is currently running in user mode, don't
> +         * detect soft lockups.  If CONFIG_DETECT_SOFTLOCKUP is not
> +         * configured, this should be optimized out.
> +         */
> +        if (user_mode(regs))
> +                touch_light_softlockup_watchdog();
> +
> +
>  	update_process_times(user_mode_vm(regs));
>  	irq_exit();
>  

Nope doesnt help. I booted with this code change and I get the
same message. 

I saw that the code change is in #ifdef CONFIG_HIGH_RES_TIMERS.
I have already disabled CONFIG_HIGH_RES_TIMERS as Thomas Gleixner 
suggested

	-Dinakar

