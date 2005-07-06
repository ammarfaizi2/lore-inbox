Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVGFHm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVGFHm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 03:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVGFHm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 03:42:57 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:55499 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262125AbVGFGUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 02:20:24 -0400
Subject: Re: [PATCH] [19/48] Suspend2 2.1.9.8 for 2.6.12:
	510-version-specific-mac.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pekka Enberg <penberg@gmail.com>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <84144f02050705225819907f6f@mail.gmail.com>
References: <11206164393426@foobar.com> <11206164411926@foobar.com>
	 <84144f02050705225819907f6f@mail.gmail.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120630908.4860.30.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 16:21:49 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Thanks for pointing those things out. The ifdef is there because x86_64
is still work in progress. I'll try Qemu to get this patch up to
scratch.

Regards,

Nigel

On Wed, 2005-07-06 at 15:58, Pekka Enberg wrote:
> On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> > diff -ruNp 520-version-specific-x86_64.patch-old/include/asm-x86_64/suspend2.h 520-version-specific-x86_64.patch-new/include/asm-x86_64/suspend2.h
> > --- 520-version-specific-x86_64.patch-old/include/asm-x86_64/suspend2.h 1970-01-01 10:00:00.000000000 +1000
> > +++ 520-version-specific-x86_64.patch-new/include/asm-x86_64/suspend2.h 2005-07-05 23:56:15.000000000 +1000
> > @@ -0,0 +1,432 @@
> > +#undef inline
> > +#define inline __inline__ __attribute__((always_inline))
> 
> Please drop this macro. <linux/compiler.h> takes care of it already.
> 
> > +
> > +/* image of the saved processor states */
> > +struct suspend2_saved_context {
> > +       unsigned long eax, ebx, ecx, edx;
> > +       unsigned long esp, ebp, esi, edi;
> > +       unsigned long r8, r9, r10, r11;
> > +       unsigned long r12, r13, r14, r15;
> > +
> > +#if 0
> > +       u16 es, fs, gs, ss;
> > +       u32 cr0, cr2, cr3, cr4;
> > +       u16 gdt_pad;
> > +       u16 gdt_limit;
> > +       u32 gdt_base;
> > +       u16 idt_pad;
> > +       u16 idt_limit;
> > +       u32 idt_base;
> > +       u16 ldt;
> > +       u16 tss;
> > +       u32 tr;
> > +       u32 safety;
> > +       u32 return_address;
> > +#endif
> 
> Please drop the #ifdef
> 
> > +       unsigned long eflags;
> > +} __attribute__((packed));
> > +
> > +extern struct suspend2_saved_context suspend2_saved_context;   /* temporary storage */
> 
> Please move the comment above the declaration (looks as if you're
> breaking 80 columns).
> 
> > +
> > +#ifdef CONFIG_MTRR
> > +/* MTRR functions */
> > +extern int mtrr_save(void);
> > +extern int mtrr_restore_one_cpu(void);
> > +extern void mtrr_restore_finish(void);
> > +#else
> > +#define mtrr_save() do { } while(0)
> > +#define mtrr_restore_one_cpu() do { } while(0)
> > +#define mtrr_restore_finish() do { } while(0)
> 
> Empty static inline functions are preferred.
> 
> > +#endif
> > +
> > +#ifndef CONFIG_SMP
> > +#undef cpu_clear
> > +#define cpu_clear(a, b) do { } while(0)
> 
> Same here.
> 
> > +#endif
> > +
> > +extern struct suspend2_saved_context suspend2_saved_context;   /* temporary storage */
> 
> Move comment up.
> 
> > +static void fix_processor_context(void)
> > +{
> > +       int nr = _smp_processor_id();
> > +       struct tss_struct * t = &per_cpu(init_tss,nr);
> > +
> > +       set_tss_desc(nr,t);     /* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
> 
> Please move comment before function call and indent it properly.
> 
> > +/*
> > + * END of IRQ affinity code, based on LKCD code.
> > + * -----------------------------------------------------------------
> > + */
> > +#else
> > +#define save_and_set_irq_affinity() do { } while(0)
> > +#define reset_irq_affinity() do { } while(0)
> 
> Empty static inlines please.
> 
> > diff -ruNp 520-version-specific-x86_64.patch-old/include/asm-x86_64/suspend.h 520-version-specific-x86_64.patch-new/include/asm-x86_64/suspend.h
> > --- 520-version-specific-x86_64.patch-old/include/asm-x86_64/suspend.h  2005-06-20 11:47:28.000000000 +1000
> > +++ 520-version-specific-x86_64.patch-new/include/asm-x86_64/suspend.h  2005-07-04 23:14:19.000000000 +1000
> > @@ -43,7 +43,7 @@ extern unsigned long saved_context_eflag
> >                         : /* no output */ \
> >                         :"r" ((thread)->debugreg##register))
> > 
> > -extern void fix_processor_context(void);
> > +/* extern void fix_processor_context(void); */
> 
> Please drop commented out code.
> 
> > 
> >  #ifdef CONFIG_ACPI_SLEEP
> >  extern unsigned long saved_eip;
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

