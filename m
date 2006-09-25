Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbWIYXUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbWIYXUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 19:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWIYXUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 19:20:47 -0400
Received: from nwd2mail11.analog.com ([137.71.25.57]:26902 "EHLO
	nwd2mail11.analog.com") by vger.kernel.org with ESMTP
	id S1751645AbWIYXUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 19:20:46 -0400
X-IronPort-AV: i="4.09,216,1157342400"; 
   d="scan'208"; a="10256102:sNHT28414344"
Message-Id: <6.1.1.1.0.20060925185450.01ed0210@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Mon, 25 Sep 2006 19:21:03 -0400
To: Arnd Bergmann <arnd@arndb.de>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: Mike Frysinger <vapier.adi@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, luke Yang <luke.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
>On Saturday 23 September 2006 18:29, Robin Getz wrote:
> > I would be interested in the reasons why this is bad. We thought is
> > solved the problem, and our driver developers are Ok using it, and it
> > is catching more problems at compile time than we use to (which is the
> > main reason I thought to remove all the volatile casting.
>
>It adds a lot of unnecessary defines. The problem is mostly that for each 
>register you add three macros.

That is what host machines are good for - isn't it - keeping track of 
redirection? :)

>The simplest way to avoid this would be using your bfin_write16() and 
>related functions directly instead of wrapping each register in a separate 
>macro.

Right - but I am lazy, and I don't want to remember which is a 16 and which 
is a 32 when I am maintaining the software.

Having the extra define is good in that it allows hardware nastiness to be 
hidden. For example, we just fixed an issue about how to write to a 
register that effects the PLL stability.

/* Writing to VR_CTL initiates a PLL relock sequence. */
static __inline__ void bfin_write_VR_CTL(unsigned int val) {
         unsigned long flags, iwr ;

         bfin_write16(VR_CTL,val);
         __builtin_bfin_ssync();
         /* Enable the PLL Wakeup bit in SIC IWR */
         iwr = bfin_read32(SIC_IWR);
         /* Only allow PPL Wakeup) */
         bfin_write32(SIC_IWR, IWR_ENABLE(0));
         local_irq_save(flags);
         asm("IDLE;");
         local_irq_restore(flags);
         bfin_write32(SIC_IWR, iwr);
}

There are a few bits in the register that controls the on-chip MAC - in the 
ethernet driver, the person was just writing to the register, without 
understanding that it unlocked/re-locked the PLL.

This saves every person who writes to this register from duplicating the 
code, and we ensures that it is actually done it properly.

> > >Now, there are
> > >at least two common methods for how to do this better, both involving
> > >the readl/writel low-level accessors (or something similar).
> >
> > The thing to understand about the Blackfin architecture - is not all
> > system register, or peripheral registers are 32 bits. Some are 16
> > bits, and some are 32. The Hardware will error if you access a 32 bit
> > instruction, with a
> > 16 bit access, or a 16 bit access on a 32 bit instruction.
> >
> > This is why we added:
> > bfin_write16(); bfin_read16(); bfin_write32(); bfin_read32();
>
>Sure, that's not unusual at all. Instead of readl(), you can use
>readw() for 16 bit accesses. Your bfin_{read,write}{16,32} functions are 
>fine as well, but you should make the implementation more robust and change
>
>
>#define bfin_read16(addr) ({
>         unsigned __v; \
>         __asm__ __volatile__ ("NOP;\n\t %0 = w[%1] (z);\n\t" \
>         : "=d"(__v) : "a"(addr)); \
>         unsigned short)__v; \
>})
>
>to
>
>static inline __le16 bfin_read16(const __be16 __iomem *addr) {
>         __be16 val;
>         asm volatile("nop; \n\t %0 = w[%1] (z)" : "=d" (val) : "a"(addr);
>         return val;
>}
>
>This adds strict type checking (size, endianess, io address space).
>You may prefer to use u16 instead of __be16 here, depending on your needs.

No problem - I can change/update that.

> > We can't use a common function, like:
> >
> > bfin_sica_read(int reg)
> >
> > or use the read16/read32 directly - it would be to hard for the driver
> > developers to keep the manual with them all the time to find out if a
> > register was 16 or 32 bits. It would move what we have today (compiler
> > errors), to run time errors if someone used the wrong function.
>
>Ok, in the example I picked they were all the same size, so I assumed that 
>would be the case for most of your register areas.

[snip]

> > >
> > >The alternative approach uses a structure:
> >
> > We could use this approach, filling it up with 16 bit padding all over
> > the place (which is easy to do), but it is also difficult for the same 
> reason.
> > (Although I really like this, and can see lots of value from it - I am
> > not sure we can use it).
> >
> > You are still using writel(reg, value) and readl(reg) - which is hard
> > to do, without a hardware reference beside you all the time - to
> > determine which time you should use a readl or reads.
> >
> > Unless I am completely missing something (which might be true).
>
>Ok, I see your point. If you have different size registers in the area for 
>a single device, then it is better to use a structure as I showed below.
>
> > >static struct bfin_sica_regs __iomem *bfin_sica = (void __iomem
> > >*)0xffc00100ul;
> > >
>
> > Although I think the code is smaller, and nicer - it involves more run
> > time complexity, and will consume more processor cycles - the old example:
> >
> > static void bf561_internal_mask_irq(unsigned int irq) {
> >     unsigned long irq_mask;
> >     if ((irq - (IRQ_CORETMR + 1)) < 32) {
> >         irq_mask = (1 << (irq - (IRQ_CORETMR + 1)));
> >         bfin_write_SICA_IMASK0(bfin_read_SICA_IMASK0() &
> > ~irq_mask);
> >     } else {
> >         irq_mask = (1 << (irq - (IRQ_CORETMR + 1) - 32));
> >         bfin_write_SICA_IMASK1(bfin_read_SICA_IMASK1() &
> > ~irq_mask);
> >     }
> > }
> >
> > resolves all addresses at compile time, not run time. So, wouldn't
> > your example slow things down?
>
>The run time overhead of this is very small compared to an actual mmio 
>register access, so you should not notice this at all.

I'm not sure I agree - on machines with tiny cache (only 16k), and high 
Core Clocks (600+ MHz), and slow SDRAM clocks (133MHz), extra reads to 
SDRAM will kill performance & pollute cache. It is not just the single 
cycle read - if the core is writing something into SDRAM, it takes 12 SDRAM 
cycles for the SDRAM to turn the bus from a write to a read.

run time overhead is critical to us. People are complaining already that 
the overhead of our drivers is too high, and I don't want to add extra 
reads to SDRAM if I don't have to.

>You can still do the same with a compile time constant by replacing
>
>static struct bfin_sica_regs __iomem *bfin_sica = (void __iomem 
>*)0xffc00100ul;
>
>from my example with
>
>#define bfin_sica_regs ((struct bfin_sica_regs __iomem*)0xffc00100ul)
>
>That should result in the same object code you had before.
>
>However, I'm used to having a single kernel binary that can run on 
>multiple hardware versions. Normally this means that you have the same 
>register layout on every CPU, but on different physical addresses that are 
>detected at boot time, so I like to avoid hardcoding absolute addresses in 
>the object code.

People who use our architecture are OK with compiling for a specific platform.

>Moreover, if you ever want to run with an MMU, the virtual address of that 
>device is computed by the ioremap function, like
>
>static struct bfin_sica_regs __iomem *bfin_sica;
>
>void __init bfin_init_sica(void)
>{
>         bfin_sica = ioremap(0xffc00100ul);
>}

There are no plans to add a MMU to the Blackfin as is - it would require an 
extensive change to the architecture.

But still - I can see the value of it for large scale systems, where people 
are not willing to compile a kernel targeted at one specific implementation 
- but the people who use this kernel are worse - they compile a kernel for 
a specific board, not a just a specific processor. Anything extra - they 
don't want it. Anything they need - they normally put it in the kernel, as 
to reduce boot time/size.

The processor sells for less than a good cup of coffee. People are selling 
complete systems (processor, SDRAM, Flash, etc) for less than $50 (US).

People want to do, and expect to do, all kinds of optimizations when they 
are working at this level.

This is the hesitation of adding levels of indirection - any additional 
overhead - and people will stop using Linux - but I will try out the 
structure, and see how that works.

-Robin 
