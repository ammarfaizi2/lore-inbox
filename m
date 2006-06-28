Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422936AbWF1Cpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422936AbWF1Cpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 22:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422937AbWF1Cpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 22:45:53 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:2024 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1422936AbWF1Cpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 22:45:52 -0400
Subject: Re: the creation of boot_cpu_init() is wrong and accessing
	uninitialised data
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: stsp@aknet.ru, linux-kernel@vger.kernel.org
In-Reply-To: <20060627170446.30392b00.akpm@osdl.org>
References: <1151376313.3443.12.camel@mulgrave.il.steeleye.com>
	 <20060626200433.bf0292af.akpm@osdl.org>
	 <1151379392.3443.20.camel@mulgrave.il.steeleye.com>
	 <20060626220337.06014184.akpm@osdl.org>
	 <1151419746.3340.13.camel@mulgrave.il.steeleye.com>
	 <20060627170446.30392b00.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 22:45:34 -0400
Message-Id: <1151462735.5793.2.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 17:04 -0700, Andrew Morton wrote:
> +static void __init __attribute__((weak)) smp_setup_processor_id(void)

If you're really sure this works .. then it looks OK.  However, I
thought weak was a linker attribute, not a compiler one.  How does the
compiler know if the static inline needs to be incorporated or if a
strong symbol is going to override it when the whole thing is linked
together at the time it just compiles main.c?

> +{
> +}
> +
>  asmlinkage void __init start_kernel(void)
>  {
>  	char * command_line;
>  	extern struct kernel_param __start___param[], __stop___param[];
> +
> +	smp_setup_processor_id();
> +
>  /*
>   * Interrupts are still disabled. Do necessary setups, then
>   * enable them
> diff -puN arch/i386/mach-voyager/voyager_smp.c~add-smp_setup_processor_id arch/i386/mach-voyager/voyager_smp.c
> --- a/arch/i386/mach-voyager/voyager_smp.c~add-smp_setup_processor_id
> +++ a/arch/i386/mach-voyager/voyager_smp.c
> @@ -1938,3 +1938,9 @@ smp_cpus_done(unsigned int max_cpus)
>  {
>  	zap_low_mappings();
>  }
> +
> +void __init
> +smp_setup_processor_id(void)
> +{
> +	current_thread_info()->cpu = hard_smp_processor_id();
> +}
> diff -puN include/linux/smp.h~add-smp_setup_processor_id include/linux/smp.h
> --- a/include/linux/smp.h~add-smp_setup_processor_id
> +++ a/include/linux/smp.h
> @@ -125,4 +125,6 @@ static inline void smp_send_reschedule(i
>  #define put_cpu()		preempt_enable()
>  #define put_cpu_no_resched()	preempt_enable_no_resched()
>  
> +void smp_setup_processor_id(void);
> +
>  #endif /* __LINUX_SMP_H */
> _
> 
> 
> Note that I moved the call to smp_setup_processor_id() to be super-early. 
> Before the lock_kernel(), before everything.  It seems better that way. 
> And there's lockdep init stuff in -mm which is called immediately on entry
> to start_kernel() which might want to use smp_processor_id().
> 
> Is that all OK?

I'll give it a whirl tomorrow when I get access to one of the voyager
systems in Columbia.

James


