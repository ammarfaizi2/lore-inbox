Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263331AbVHFRrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263331AbVHFRrt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 13:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263332AbVHFRrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 13:47:49 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39693 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263331AbVHFRrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 13:47:45 -0400
Date: Sat, 6 Aug 2005 19:47:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, vatsa@in.ibm.com, ck@vds.kolivas.org,
       tony@atomide.com, tuukka.tikkanen@elektrobit.com, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 4
Message-ID: <20050806174739.GU4029@stusta.de>
References: <200508031559.24704.kernel@kolivas.org> <20050805123754.GA1262@in.ibm.com> <200508052308.44313.kernel@kolivas.org> <200508060239.41646.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508060239.41646.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2005 at 02:39:40AM +1000, Con Kolivas wrote:

> Here's my most current version of the dynamic ticks patch for i386 with some 
> more minor cleanups already discussed and cosmetic changes ( also available 
> at http://ck.kolivas.org/patches/dyn-ticks/ ).
> 
> Cheers,
> Con
>...
> --- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/dyn-tick.c	2005-01-12 16:19:45.000000000 +1100
> +++ linux-2.6.13-rc5-ck2/arch/i386/kernel/dyn-tick.c	2005-08-05 20:48:57.000000000 +1000
>...
> +void arch_reprogram_timer(void)
> +{

static?

>...
> +int __init dyn_tick_init(void)
> +{

static?

>...
> +irqreturn_t dyn_tick_timer_interrupt(int irq, void *dev_id,
> +				     struct pt_regs *regs)
> +{

static?

>...
> +int __init dyn_tick_arch_init(void)
> +{

static?

>...
> +/* Functions that need blank prototypes for !CONFIG_NO_IDLE_HZ below here */
> +inline void set_dyn_tick_max_skip(u32 apic_timer_val)
> +{
> +	dyn_tick->max_skip = 0xffffff / apic_timer_val;
> +}
> +
> +inline void setup_dyn_tick_use_apic(unsigned int calibration_result)
> +{
> +	if (calibration_result)
> +		dyn_tick->state |= DYN_TICK_USE_APIC;
> +	else
> +		printk(KERN_INFO "dyn-tick: Cannot use local APIC\n");
> +}

You can drop the "inline" on both functions (it doesn't make any 
practical difference since they are only called from other files).

>...
> --- linux-2.6.13-rc5-ck2.orig/include/asm-i386/dyn-tick.h	2005-01-12 16:19:45.000000000 +1100
> +++ linux-2.6.13-rc5-ck2/include/asm-i386/dyn-tick.h	2005-08-05 20:57:02.000000000 +1000
>...
> +#if defined(CONFIG_DYN_TICK_USE_APIC) && \
> +	(defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC))
> +#define cpu_has_local_apic()	(dyn_tick->state & DYN_TICK_USE_APIC)
> +#else
> +#define cpu_has_local_apic()	0
> +#endif
> +
> +#if defined(CONFIG_DYN_TICK_USE_APIC)
> +#define dyntick_apicable()	1
> +#else
> +#define dyntick_apicable()	0
> +#endif

Constants that mimic functions aren't good coding style.

Please make them either uppercase #define's without function braces or 
"static inline" functions.

>...
> --- linux-2.6.13-rc5-ck2.orig/kernel/dyn-tick.c	2005-01-12 16:19:45.000000000 +1100
> +++ linux-2.6.13-rc5-ck2/kernel/dyn-tick.c	2005-08-05 21:02:44.000000000 +1000
>...
> +struct dyn_tick_state dyn_tick_state;

static?

>...
> +struct dyn_tick_timer *dyn_tick_cfg;
>...

static?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

