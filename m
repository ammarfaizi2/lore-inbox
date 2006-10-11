Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161368AbWJKVTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161368AbWJKVTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWJKVTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:19:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36809 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161492AbWJKVSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:18:34 -0400
Date: Wed, 11 Oct 2006 14:18:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] lockdep: annotate i386 apm
Message-Id: <20061011141813.79fb278f.akpm@osdl.org>
In-Reply-To: <1160574022.2006.82.camel@taijtu>
References: <1160574022.2006.82.camel@taijtu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 15:40:22 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> 
> Lockdep doesn't like to enable interrupts when they are enabled already.
> 
> ...
>
> --- linux-2.6.18.noarch.orig/arch/i386/kernel/apm.c
> +++ linux-2.6.18.noarch/arch/i386/kernel/apm.c
> @@ -539,11 +539,22 @@ static inline void apm_restore_cpus(cpum
>   * Also, we KNOW that for the non error case of apm_bios_call, there
>   * is no useful data returned in the low order 8 bits of eax.
>   */
> -#define APM_DO_CLI	\
> -	if (apm_info.allow_ints) \
> -		local_irq_enable(); \
> -	else \
> -		local_irq_disable();
> +#define APM_DO_CLI \
> +	do { \
> +		if (apm_info.allow_ints) { \
> +			if (irqs_disabled_flags(flags)) \
> +				local_irq_enable(); \
> +		} else \
> +			local_irq_disable(); \
> +	} while (0)
> +
> +#define APM_DO_STI \
> +	do { \
> +		if (irqs_disabled_flags(flags)) \
> +			local_irq_disable(); \
> +		else if (irqs_disabled()) \
> +			local_irq_enable(); \
> +	} while (0)
>  
>  #ifdef APM_ZERO_SEGS
>  #	define APM_DECL_SEGS \
> @@ -600,7 +611,7 @@ static u8 apm_bios_call(u32 func, u32 eb
>  	APM_DO_SAVE_SEGS;
>  	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
>  	APM_DO_RESTORE_SEGS;
> -	local_irq_restore(flags);
> +	APM_DO_STI;
>  	gdt[0x40 / 8] = save_desc_40;
>  	put_cpu();
>  	apm_restore_cpus(cpus);
> @@ -644,7 +655,7 @@ static u8 apm_bios_call_simple(u32 func,
>  	APM_DO_SAVE_SEGS;
>  	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
>  	APM_DO_RESTORE_SEGS;
> -	local_irq_restore(flags);
> +	APM_DO_STI;
>  	gdt[0x40 / 8] = save_desc_40;
>  	put_cpu();
>  	apm_restore_cpus(cpus);

ick.

Does this work?

--- a/arch/i386/kernel/apm.c~lockdep-annotate-i386-apm
+++ a/arch/i386/kernel/apm.c
@@ -540,12 +540,6 @@ static inline void apm_restore_cpus(cpum
  * Also, we KNOW that for the non error case of apm_bios_call, there
  * is no useful data returned in the low order 8 bits of eax.
  */
-#define APM_DO_CLI	\
-	if (apm_info.allow_ints) \
-		local_irq_enable(); \
-	else \
-		local_irq_disable();
-
 #ifdef APM_ZERO_SEGS
 #	define APM_DECL_SEGS \
 		unsigned int saved_fs; unsigned int saved_gs;
@@ -596,8 +590,9 @@ static u8 apm_bios_call(u32 func, u32 eb
 	save_desc_40 = gdt[0x40 / 8];
 	gdt[0x40 / 8] = bad_bios_desc;
 
-	local_save_flags(flags);
-	APM_DO_CLI;
+	local_irq_save(flags);
+	if (apm_info.allow_ints)
+		local_irq_enable();
 	APM_DO_SAVE_SEGS;
 	apm_bios_call_asm(func, ebx_in, ecx_in, eax, ebx, ecx, edx, esi);
 	APM_DO_RESTORE_SEGS;
@@ -640,8 +635,9 @@ static u8 apm_bios_call_simple(u32 func,
 	save_desc_40 = gdt[0x40 / 8];
 	gdt[0x40 / 8] = bad_bios_desc;
 
-	local_save_flags(flags);
-	APM_DO_CLI;
+	local_irq_save(flags);
+	if (apm_info.allow_ints)
+		local_irq_enable();
 	APM_DO_SAVE_SEGS;
 	error = apm_bios_call_simple_asm(func, ebx_in, ecx_in, eax);
 	APM_DO_RESTORE_SEGS;
_

