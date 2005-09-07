Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVIGPAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVIGPAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 11:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVIGPAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 11:00:47 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:24478 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932155AbVIGPAq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 11:00:46 -0400
Date: Wed, 7 Sep 2005 08:00:35 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050907150035.GB4590@us.ibm.com>
References: <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com> <20050905054813.GC25856@us.ibm.com> <20050905063229.GB4294@in.ibm.com> <20050905064416.GD25856@us.ibm.com> <20050906205112.GA3038@us.ibm.com> <20050907081303.GC5804@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907081303.GC5804@atomide.com>
X-Operating-System: Linux 2.6.13 (i686)
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.2005 [11:13:04 +0300], Tony Lindgren wrote:
> * Nishanth Aravamudan <nacc@us.ibm.com> [050906 23:55]:
> 
> ...
> 
> > Sigh, later than I had hoped, but here is what I have hashed out so far.
> > Does it seem like a step in the right direction? Rather hand-wavy, but I
> > think it's mostly correct ;)
> 
> Some comments below.

Thanks, Tony!

> > - include/linux/intsource.h
> > 	with definitions in kernel/intsource.c
> > 
> > #define DYN_TICK_ENABLED	(1 << 1)
> > #define DYN_TICK_SUITABLE	(1 << 0)
> > 
> > #define DYN_TICK_MIN_SKIP	2
> > 
> > /* Abstraction of an interrupt source
> >  * @state: current state
> >  * @max_skip: current maximum number of ticks to skip
> >  * @arch_init: initialization routine
> >  * @arch_enable_dyn_tick: called via sysfs to enable interrupt skipping
> >  * @arch_disable_dyn_tick: called via sysfs to disable interrupt
> >  * 				skipping
> >  * @arch_set_all_cpus_idle: last cpu to go idle calls this, which should
> >  * 				disable any timesource (e.g. PIT on x86)
> >  * @arch_recover_time: handler for returning from skipped ticks and keeping
> >  * 				time consistent
> >  */
> > struct interrupt_source {
> > 	unsigned int state;
> > 	unsigned long max_skip;
> > 	int (*arch_init) (void);
> > 	void (*arch_enable_dyn_tick) (void);
> > 	void (*arch_disable_dyn_tick) (void);
> > 	unsigned long (*arch_reprogram) (unsigned long); /* return number of ticks skipped */
> > 	unsigned long (*arch_recover_time) (int, void *, struct pt_regs *); /* handler in arm */
> > 	/* following empty in UP */
> > 	void (*arch_set_all_cpus_idle) (int);
> > 	spinlock_t lock;
> > };
> 
> I would still call the struct dyntick, have CONFIG_DYNTICK, and then have
> CONFIG_NO_IDLE_HZ and possibly CONFIG_SUBJIFFIE_TIMER register to use it
> like I said in my earlier mail. Would that solve the issues you have
> with the naming?

I'll respond more fully there, but I think it might. If that's the case,
though, I think I'll just push all of the code down into timer.c and
timer.h, no need for a separate file, really. I'll mull it over, see
what the others think as well...

> > /* return number of ticks skipped, potentially for accounting purposes? */
> > extern unsigned long reprogram_interrupt(void);
> 
> The number of ticks skipped can be potentially used in idle loops to
> select which ACPI C state to go to depending on the estimated length of
> sleep.

Ah true!

Thanks,
Nish
