Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVGFHRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVGFHRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 03:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVGFHR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 03:17:26 -0400
Received: from nproxy.gmail.com ([64.233.182.196]:61770 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261692AbVGFF6s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 01:58:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HdG8KlzpKNLDL4BW+70kc1JrrIpGm4f513rG8WoWKs1LQl9hMwiBaKtY1qad0/0JJ9sDkrnCFobEIvBsx2S4SPpA77GmwOVS8UzV4xW5rdvpujFJLtZQSE7RLuG0pJyAuqzQwCkbOdlQvuXBgFIo2sZDfFReS60ugv4nJnGJ3VY=
Message-ID: <84144f02050705225819907f6f@mail.gmail.com>
Date: Wed, 6 Jul 2005 08:58:39 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [19/48] Suspend2 2.1.9.8 for 2.6.12: 510-version-specific-mac.patch
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <11206164411926@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <11206164411926@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> diff -ruNp 520-version-specific-x86_64.patch-old/include/asm-x86_64/suspend2.h 520-version-specific-x86_64.patch-new/include/asm-x86_64/suspend2.h
> --- 520-version-specific-x86_64.patch-old/include/asm-x86_64/suspend2.h 1970-01-01 10:00:00.000000000 +1000
> +++ 520-version-specific-x86_64.patch-new/include/asm-x86_64/suspend2.h 2005-07-05 23:56:15.000000000 +1000
> @@ -0,0 +1,432 @@
> +#undef inline
> +#define inline __inline__ __attribute__((always_inline))

Please drop this macro. <linux/compiler.h> takes care of it already.

> +
> +/* image of the saved processor states */
> +struct suspend2_saved_context {
> +       unsigned long eax, ebx, ecx, edx;
> +       unsigned long esp, ebp, esi, edi;
> +       unsigned long r8, r9, r10, r11;
> +       unsigned long r12, r13, r14, r15;
> +
> +#if 0
> +       u16 es, fs, gs, ss;
> +       u32 cr0, cr2, cr3, cr4;
> +       u16 gdt_pad;
> +       u16 gdt_limit;
> +       u32 gdt_base;
> +       u16 idt_pad;
> +       u16 idt_limit;
> +       u32 idt_base;
> +       u16 ldt;
> +       u16 tss;
> +       u32 tr;
> +       u32 safety;
> +       u32 return_address;
> +#endif

Please drop the #ifdef

> +       unsigned long eflags;
> +} __attribute__((packed));
> +
> +extern struct suspend2_saved_context suspend2_saved_context;   /* temporary storage */

Please move the comment above the declaration (looks as if you're
breaking 80 columns).

> +
> +#ifdef CONFIG_MTRR
> +/* MTRR functions */
> +extern int mtrr_save(void);
> +extern int mtrr_restore_one_cpu(void);
> +extern void mtrr_restore_finish(void);
> +#else
> +#define mtrr_save() do { } while(0)
> +#define mtrr_restore_one_cpu() do { } while(0)
> +#define mtrr_restore_finish() do { } while(0)

Empty static inline functions are preferred.

> +#endif
> +
> +#ifndef CONFIG_SMP
> +#undef cpu_clear
> +#define cpu_clear(a, b) do { } while(0)

Same here.

> +#endif
> +
> +extern struct suspend2_saved_context suspend2_saved_context;   /* temporary storage */

Move comment up.

> +static void fix_processor_context(void)
> +{
> +       int nr = _smp_processor_id();
> +       struct tss_struct * t = &per_cpu(init_tss,nr);
> +
> +       set_tss_desc(nr,t);     /* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */

Please move comment before function call and indent it properly.

> +/*
> + * END of IRQ affinity code, based on LKCD code.
> + * -----------------------------------------------------------------
> + */
> +#else
> +#define save_and_set_irq_affinity() do { } while(0)
> +#define reset_irq_affinity() do { } while(0)

Empty static inlines please.

> diff -ruNp 520-version-specific-x86_64.patch-old/include/asm-x86_64/suspend.h 520-version-specific-x86_64.patch-new/include/asm-x86_64/suspend.h
> --- 520-version-specific-x86_64.patch-old/include/asm-x86_64/suspend.h  2005-06-20 11:47:28.000000000 +1000
> +++ 520-version-specific-x86_64.patch-new/include/asm-x86_64/suspend.h  2005-07-04 23:14:19.000000000 +1000
> @@ -43,7 +43,7 @@ extern unsigned long saved_context_eflag
>                         : /* no output */ \
>                         :"r" ((thread)->debugreg##register))
> 
> -extern void fix_processor_context(void);
> +/* extern void fix_processor_context(void); */

Please drop commented out code.

> 
>  #ifdef CONFIG_ACPI_SLEEP
>  extern unsigned long saved_eip;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
