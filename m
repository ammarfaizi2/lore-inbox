Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161522AbWJLGGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161522AbWJLGGL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161531AbWJLGGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:06:11 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:59872 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S1161522AbWJLGGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:06:09 -0400
Subject: Re: [PATCH] lockdep: annotate i386 apm
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061011141813.79fb278f.akpm@osdl.org>
References: <1160574022.2006.82.camel@taijtu>
	 <20061011141813.79fb278f.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 08:06:20 +0200
Message-Id: <1160633180.2006.94.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 14:18 -0700, Andrew Morton wrote:
> On Wed, 11 Oct 2006 15:40:22 +0200
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > 
> > Lockdep doesn't like to enable interrupts when they are enabled already.
> > 
> > ...
> >
> > --- linux-2.6.18.noarch.orig/arch/i386/kernel/apm.c
> > +++ linux-2.6.18.noarch/arch/i386/kernel/apm.c
> > @@ -539,11 +539,22 @@ static inline void apm_restore_cpus(cpum
> >   * Also, we KNOW that for the non error case of apm_bios_call, there
> >   * is no useful data returned in the low order 8 bits of eax.
> >   */
> > -#define APM_DO_CLI	\
> > -	if (apm_info.allow_ints) \
> > -		local_irq_enable(); \
> > -	else \
> > -		local_irq_disable();
> > +#define APM_DO_CLI \
> > +	do { \
> > +		if (apm_info.allow_ints) { \
> > +			if (irqs_disabled_flags(flags)) \
> > +				local_irq_enable(); \
> > +		} else \
> > +			local_irq_disable(); \
> > +	} while (0)
> > +
> > +#define APM_DO_STI \
> > +	do { \
> > +		if (irqs_disabled_flags(flags)) \
> > +			local_irq_disable(); \
> > +		else if (irqs_disabled()) \
> > +			local_irq_enable(); \
> > +	} while (0)
> >  
> >  #ifdef APM_ZERO_SEGS
> >  #	define APM_DECL_SEGS \
> > @@ -600,7 +611,7 @@ static u8 apm_bios_call(u32 func, u32 eb
> >  	APM_DO_SAVE_SEGS;
> >  	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
> >  	APM_DO_RESTORE_SEGS;
> > -	local_irq_restore(flags);
> > +	APM_DO_STI;
> >  	gdt[0x40 / 8] = save_desc_40;
> >  	put_cpu();
> >  	apm_restore_cpus(cpus);
> > @@ -644,7 +655,7 @@ static u8 apm_bios_call_simple(u32 func,
> >  	APM_DO_SAVE_SEGS;
> >  	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
> >  	APM_DO_RESTORE_SEGS;
> > -	local_irq_restore(flags);
> > +	APM_DO_STI;
> >  	gdt[0x40 / 8] = save_desc_40;
> >  	put_cpu();
> >  	apm_restore_cpus(cpus);
> 
> ick.
> 
> Does this work?
> 
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
> @@ -596,8 +590,9 @@ static u8 apm_bios_call(u32 func, u32 eb
>  	save_desc_40 = gdt[0x40 / 8];
>  	gdt[0x40 / 8] = bad_bios_desc;
>  
> -	local_save_flags(flags);
> -	APM_DO_CLI;
> +	local_irq_save(flags);
> +	if (apm_info.allow_ints)
> +		local_irq_enable();
>  	APM_DO_SAVE_SEGS;
>  	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
>  	APM_DO_RESTORE_SEGS;
> @@ -640,8 +635,9 @@ static u8 apm_bios_call_simple(u32 func,
>  	save_desc_40 = gdt[0x40 / 8];
>  	gdt[0x40 / 8] = bad_bios_desc;
>  
> -	local_save_flags(flags);
> -	APM_DO_CLI;
> +	local_irq_save(flags);
> +	if (apm_info.allow_ints)
> +		local_irq_enable();
>  	APM_DO_SAVE_SEGS;
>  	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
>  	APM_DO_RESTORE_SEGS;
> _

#define local_irq_restore(flags)                                \
        do {                                                    \
                if (raw_irqs_disabled_flags(flags)) {           \
                        raw_local_irq_restore(flags);           \
                        trace_hardirqs_off();                   \
                } else {                                        \
                        trace_hardirqs_on();                    \
                        raw_local_irq_restore(flags);           \
                }                                               \
        } while (0)

So, say interrupts were enabled when entering apm_bios_call*(); you now
save that in flags, disable interrupts, and enable them again.
Upon reaching local_irq_restore(), we'll hit the else branch with irq's
enabled and call trace_hardirqs_on(), which goes EEEK!




