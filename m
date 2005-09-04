Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbVIDU0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVIDU0b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 16:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVIDU0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 16:26:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46864 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751085AbVIDU0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 16:26:31 -0400
Date: Sun, 4 Sep 2005 21:26:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050904212616.B11265@flint.arm.linux.org.uk>
Mail-Followup-To: Nishanth Aravamudan <nacc@us.ibm.com>,
	Con Kolivas <kernel@kolivas.org>, vatsa@in.ibm.com,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050904201054.GA4495@us.ibm.com>; from nacc@us.ibm.com on Sun, Sep 04, 2005 at 01:10:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> I've got a few ideas that I think might help push Con's patch coalescing
> efforts in an arch-independent fashion.

Note that ARM contains cleanups on top of Tony's original work, on
which the x86 version is based.

Basically, Tony submitted his ARM version, we discussed it, fixed up
some locking problems and simplified it (it contained multiple
structures which weren't necessary, even in multiple timer-based systems).

I'd be really surprised if any architecture couldn't use what ARM has
today - in other words, this is the only kernel-side interface:

#ifdef CONFIG_NO_IDLE_HZ

#define DYN_TICK_SKIPPING       (1 << 2)
#define DYN_TICK_ENABLED        (1 << 1)
#define DYN_TICK_SUITABLE       (1 << 0)

struct dyn_tick_timer {
        unsigned int    state;                  /* Current state */
        int             (*enable)(void);        /* Enables dynamic tick */
        int             (*disable)(void);       /* Disables dynamic tick */
        void            (*reprogram)(unsigned long); /* Reprograms the timer */
        int             (*handler)(int, void *, struct pt_regs *);
};

void timer_dyn_reprogram(void);
#else
#define timer_dyn_reprogram()   do { } while (0)
#endif

> First of all, and maybe this is just me, I think it would be good to
> make the dyn_tick_timer per-interrupt source, as opposed to each arch?
> Thus, for x86, we would have a dyn_tick_timer structure for the PIT,
> APIC, ACPI PM-timer and the HPET. These structures could be put in
> arch-specific timer.c files (there currently is not one for x86, I
> believe).

Each timer source should have its own struct dyn_tick_timer.  On x86,
maybe it makes sense having a pointer in the init_timer_opts or timer_opts
structures?

> I think ARM and s390 could perhaps use this infrastructure as well?

ARM already has a well thought-out encapsulation which is 100% suited to
its needs - which are essentially the same as x86 - the ability to select
one of several timer sources at boot time.

I would suggest having a good look at the ARM implementation.  See:
 include/asm-arm/mach/time.h (bit quoted above)
 arch/arm/kernel/irq.c (to update system time before calling any irq handler)
 arch/arm/kernel/time.c (initialisation and sysfs interface, etc)
 arch/arm/mach-sa1100/time.c, arch/arm/mach-pxa/time.c, and
 arch/arm/mach-omap1/time.c (dyntick machine class implementations).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
