Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWIWSKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWIWSKV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 14:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWIWSKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 14:10:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:10465 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751388AbWIWSKT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 14:10:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Sat, 23 Sep 2006 20:10:00 +0200
User-Agent: KMail/1.9.4
Cc: Mike Frysinger <vapier.adi@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Luke Yang <luke.adi@gmail.com>
References: <6.1.1.1.0.20060923115012.01ecd0d0@ptg1.spd.analog.com>
In-Reply-To: <6.1.1.1.0.20060923115012.01ecd0d0@ptg1.spd.analog.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609232010.01428.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 September 2006 18:29, Robin Getz wrote:
> I would be interested in the reasons why this is bad. We thought is solved 
> the problem, and our driver developers are Ok using it, and it is catching 
> more problems at compile time than we use to (which is the main reason I 
> thought to remove all the volatile casting.

It adds a lot of unnecessary defines. The problem is mostly that
for each register you add three macros.

The simplest way to avoid this would be using your bfin_write16()
and related functions directly instead of wrapping each register
in a separate macro.

> >Now, there are
> >at least two common methods for how to do this better, both involving
> >the readl/writel low-level accessors (or something similar).
> 
> The thing to understand about the Blackfin architecture - is not all system 
> register, or peripheral registers are 32 bits. Some are 16 bits, and some 
> are 32. The Hardware will error if you access a 32 bit instruction, with a 
> 16 bit access, or a 16 bit access on a 32 bit instruction.
> 
> This is why we added:
> bfin_write16();  bfin_read16(); bfin_write32();  bfin_read32();

Sure, that's not unusual at all. Instead of readl(), you can use
readw() for 16 bit accesses. Your bfin_{read,write}{16,32} functions
are fine as well, but you should make the implementation more robust
and change


#define bfin_read16(addr) ({
	unsigned __v; \
	__asm__ __volatile__ ("NOP;\n\t %0 = w[%1] (z);\n\t" \
	: "=d"(__v) : "a"(addr)); \
	(unsigned short)__v; \
})

to

static inline __le16 bfin_read16(const __be16 __iomem *addr)
{
	__be16 val;
	asm volatile("nop; \n\t %0 = w[%1] (z)" : "=d" (val) : "a"(addr);
	return val;
}

This adds strict type checking (size, endianess, io address space).
You may prefer to use u16 instead of __be16 here, depending on your needs.

> We can't use a common function, like:
> 
> bfin_sica_read(int reg)
> 
> or use the read16/read32 directly - it would be to hard for the driver 
> developers to keep the manual with them all the time to find out if a 
> register was 16 or 32 bits. It would move what we have today (compiler 
> errors), to run time errors if someone used the wrong function.

Ok, in the example I picked they were all the same size, so I assumed
that would be the case for most of your register areas.

> >The first one uses enumerated register numers:
> >
> >/* System Reset and Interrupt Controller registers for core A (0xFFC0 
> >0100-0xFFC0 01FF) */
> >
> >enum bfin_sica_regs {
> >         SICA_SWRST   = 100,·····/* Software Reset register */
> >         SICA_SYSCR   = 104,·····/* System Reset Configuration register */
> >         SICA_RVECT   = 108,·····/* SIC Reset Vector Address Register */
> >         SICA_IMASK   = 10C,·····/* SIC Interrupt Mask register 0 - hack 
> > to fix old tests */
> >         SICA_IMASK0  = 10C,·····/* SIC Interrupt Mask register 0 */
> >         SICA_IMASK1  = 110,·····/* SIC Interrupt Mask register 1 */
> >         SICA_IAR0    = 124,·····/* SIC Interrupt Assignment Register 0 */
> >         SICA_IAR1    = 128,·····/* SIC Interrupt Assignment Register 1 */
> >         SICA_IAR2    = 12C,·····/* SIC Interrupt Assignment Register 2 */
> >         SICA_IAR3    = 130,·····/* SIC Interrupt Assignment Register 3 */
> >         SICA_IAR4    = 134,·····/* SIC Interrupt Assignment Register 4 */
> >         SICA_IAR5    = 138,·····/* SIC Interrupt Assignment Register 5 */
> >         SICA_IAR6    = 13C,·····/* SIC Interrupt Assignment Register 6 */
> >         SICA_IAR7    = 140,·····/* SIC Interrupt Assignment Register 7 */
> >         SICA_ISR0    = 114,·····/* SIC Interrupt Status register 0 */
> >         SICA_ISR1    = 118,·····/* SIC Interrupt Status register 1 */
> >         SICA_IWR0    = 11C,·····/* SIC Interrupt Wakeup-Enable register 0 */
> >         SICA_IWR1    = 120,·····/* SIC Interrupt Wakeup-Enable register 1 */
> >};
> >
> >...
> >
> >static void __iomem *bfin_sica = (void __iomem *)0xffc00100ul;
> >static inline __le32 bfin_sica_read(int reg)
> >{
> >         return (__le32)readl(bfin_sica + reg);
> >}
> >
> >static inline void bfin_sica_write(int reg, __le32 val)
> >{
> >         writel((uint32_t)val, bfin_sica + reg);
> >}
> >
> >static void bf561_internal_mask_irq(unsigned int irq)
> >{
> >         unsigned long irq_mask;
> >         if ((irq - (IRQ_CORETMR + 1)) < 32) {
> >                 irq_mask = (1 << (irq - (IRQ_CORETMR + 1)));
> >                 bfin_sica_write(SICA_IMASK0,
> >                         bfin_sica_read(SICA_IMASK0) & ~irq_mask);
> >         } else {
> >                 irq_mask = (1 << (irq - (IRQ_CORETMR + 1) - 32));
> >                 bfin_sica_write(SICA_IMASK0,
> >                         bfin_sica_read(SICA_IMASK0) & ~irq_mask);
> >         }
> >}
> >
> >The alternative approach uses a structure:
> 
> We could use this approach, filling it up with 16 bit padding all over the 
> place (which is easy to do), but it is also difficult for the same reason. 
> (Although I really like this, and can see lots of value from it - I am not 
> sure we can use it).
> 
> You are still using writel(reg, value) and readl(reg) - which is hard to 
> do, without a hardware reference beside you all the time - to determine 
> which time you should use a readl or reads.
> 
> Unless I am completely missing something (which might be true).

Ok, I see your point. If you have different size registers in
the area for a single device, then it is better to use a structure
as I showed below.

> >static struct bfin_sica_regs __iomem *bfin_sica = (void __iomem 
> >*)0xffc00100ul;
> >

> Although I think the code is smaller, and nicer - it involves more run time 
> complexity, and will consume more processor cycles - the old example:
> 
> static void bf561_internal_mask_irq(unsigned int irq)
> {
>          unsigned long irq_mask;
>          if ((irq - (IRQ_CORETMR + 1)) < 32) {
>                  irq_mask = (1 << (irq - (IRQ_CORETMR + 1)));
>                  bfin_write_SICA_IMASK0(bfin_read_SICA_IMASK0() & ~irq_mask);
>          } else {
>                  irq_mask = (1 << (irq - (IRQ_CORETMR + 1) - 32));
>                  bfin_write_SICA_IMASK1(bfin_read_SICA_IMASK1() & ~irq_mask);
>          }
> }
> 
> resolves all addresses at compile time, not run time. So, wouldn't your 
> example slow things down?

The run time overhead of this is very small compared to an actual mmio
register access, so you should not notice this at all.

You can still do the same with a compile time constant by replacing

static struct bfin_sica_regs __iomem *bfin_sica = (void __iomem *)0xffc00100ul;

from my example with 

#define bfin_sica_regs ((struct bfin_sica_regs __iomem*)0xffc00100ul)

That should result in the same object code you had before.

However, I'm used to having a single kernel binary that can run on
multiple hardware versions. Normally this means that you have the same
register layout on every CPU, but on different physical addresses that
are detected at boot time, so I like to avoid hardcoding absolute
addresses in the object code.

Moreover, if you ever want to run with an MMU, the virtual address of
that device is computed by the ioremap function, like

static struct bfin_sica_regs __iomem *bfin_sica;

void __init bfin_init_sica(void)
{
	bfin_sica = ioremap(0xffc00100ul);
}

	Arnd <><
