Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161231AbWJLGuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161231AbWJLGuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161247AbWJLGuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:50:39 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:10789 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161231AbWJLGuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:50:39 -0400
Subject: Re: [PATCH] lockdep: annotate i386 apm
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061011233925.c9ba117a.akpm@osdl.org>
References: <1160574022.2006.82.camel@taijtu>
	 <20061011141813.79fb278f.akpm@osdl.org> <1160633180.2006.94.camel@taijtu>
	 <20061011233925.c9ba117a.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 08:50:50 +0200
Message-Id: <1160635850.2006.98.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 23:39 -0700, Andrew Morton wrote:
> On Thu, 12 Oct 2006 08:06:20 +0200
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > #define local_irq_restore(flags)                                \
> >         do {                                                    \
> >                 if (raw_irqs_disabled_flags(flags)) {           \
> >                         raw_local_irq_restore(flags);           \
> >                         trace_hardirqs_off();                   \
> >                 } else {                                        \
> >                         trace_hardirqs_on();                    \
> >                         raw_local_irq_restore(flags);           \
> >                 }                                               \
> >         } while (0)
> > 
> > So, say interrupts were enabled when entering apm_bios_call*(); you now
> > save that in flags, disable interrupts, and enable them again.
> > Upon reaching local_irq_restore(), we'll hit the else branch with irq's
> > enabled and call trace_hardirqs_on(), which goes EEEK!
> 
> I'd assumed lockdep was less stupid than that ;) This?  Seems a bit
> overdone..

Seems simple enough, bit on the verbose side, _however_ it depends on
the BIOS call not changing the irq state. I don't know about BIOSs but I
thought the general consensus was to distrust them.

Was my original _that_ hard to read?

> --- a/arch/i386/kernel/apm.c~lockdep-annotate-i386-apm
> +++ a/arch/i386/kernel/apm.c
> @@ -540,12 +540,6 @@ static inline void apm_restore_cpus(cpum
>   * Also, we KNOW that for the non error case of apm_bios_call, there
>   * is no useful data returned in the low order 8 bits of eax.
>   */
> -#define APM_DO_CLI	\
> -	if (apm_info.allow_ints) \
> -		local_irq_enable(); \
> -	else \
> -		local_irq_disable();
> -
>  #ifdef APM_ZERO_SEGS
>  #	define APM_DECL_SEGS \
>  		unsigned int saved_fs; unsigned int saved_gs;
> @@ -583,11 +577,12 @@ static u8 apm_bios_call(u32 func, u32 eb
>  	u32 *eax, u32 *ebx, u32 *ecx, u32 *edx, u32 *esi)
>  {
>  	APM_DECL_SEGS
> -	unsigned long		flags;
>  	cpumask_t		cpus;
>  	int			cpu;
>  	struct desc_struct	save_desc_40;
>  	struct desc_struct	*gdt;
> +	int			enable_irqs = 0;
> +	int			disable_irqs = 0;
>  
>  	cpus = apm_save_cpus();
>  	
> @@ -596,12 +591,26 @@ static u8 apm_bios_call(u32 func, u32 eb
>  	save_desc_40 = gdt[0x40 / 8];
>  	gdt[0x40 / 8] = bad_bios_desc;
>  
> -	local_save_flags(flags);
> -	APM_DO_CLI;
> +	if (apm_info.allow_ints) {
> +		if (irqs_disabled()) {
> +			local_irq_enable();
> +			disable_irqs = 1;
> +		}
> +	} else {
> +		if (!irqs_disabled()) {
> +			local_irq_disable();
> +			enable_irqs = 1;
> +		}
> +	}
> +
> +
>  	APM_DO_SAVE_SEGS;
>  	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
>  	APM_DO_RESTORE_SEGS;
> -	local_irq_restore(flags);
> +	if (disable_irqs)
> +		local_irq_disable();
> +	if (enable_irqs)
> +		local_irq_enable();
>  	gdt[0x40 / 8] = save_desc_40;
>  	put_cpu();
>  	apm_restore_cpus(cpus);
> @@ -627,11 +636,12 @@ static u8 apm_bios_call_simple(u32 func,
>  {
>  	u8			error;
>  	APM_DECL_SEGS
> -	unsigned long		flags;
>  	cpumask_t		cpus;
>  	int			cpu;
>  	struct desc_struct	save_desc_40;
>  	struct desc_struct	*gdt;
> +	int			enable_irqs = 0;
> +	int			disable_irqs = 0;
>  
>  	cpus = apm_save_cpus();
>  	
> @@ -640,12 +650,25 @@ static u8 apm_bios_call_simple(u32 func,
>  	save_desc_40 = gdt[0x40 / 8];
>  	gdt[0x40 / 8] = bad_bios_desc;
>  
> -	local_save_flags(flags);
> -	APM_DO_CLI;
> +	if (apm_info.allow_ints) {
> +		if (irqs_disabled()) {
> +			local_irq_enable();
> +			disable_irqs = 1;
> +		}
> +	} else {
> +		if (!irqs_disabled()) {
> +			local_irq_disable();
> +			enable_irqs = 1;
> +		}
> +	}
> +
>  	APM_DO_SAVE_SEGS;
>  	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
>  	APM_DO_RESTORE_SEGS;
> -	local_irq_restore(flags);
> +	if (disable_irqs)
> +		local_irq_disable();
> +	if (enable_irqs)
> +		local_irq_enable();
>  	gdt[0x40 / 8] = save_desc_40;
>  	put_cpu();
>  	apm_restore_cpus(cpus);
> _
> 

