Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWIWQ3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWIWQ3A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 12:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWIWQ3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 12:29:00 -0400
Received: from nwd2mail11.analog.com ([137.71.25.57]:27811 "EHLO
	nwd2mail11.analog.com") by vger.kernel.org with ESMTP
	id S1751232AbWIWQ27 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 12:28:59 -0400
X-IronPort-AV: i="4.09,207,1157342400"; 
   d="scan'208"; a="10109950:sNHT26822201"
Message-Id: <6.1.1.1.0.20060923115012.01ecd0d0@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Sat, 23 Sep 2006 12:29:08 -0400
To: Arnd Bergmann <arnd@arndb.de>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: Mike Frysinger <vapier.adi@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Luke Yang <luke.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd provide some feedback:
>On Saturday 23 September 2006 13:15, Mike Frysinger wrote:
> > On 9/23/06, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Saturday 23 September 2006 08:50, Mike Frysinger wrote:
> > > > On 9/22/06, Arnd Bergmann <arnd@arndb.de> wrote:
>
> > > > > What's the point, are you getting paid by lines of code? Just use
> > > > > the registers directly!
> > > >
> > > > in our last submission we were doing exactly that ... and we were told
> > > > to switch to a function style method of reading/writing memory mapped
> > > > registers
> > >
> > > It's hard to imagine that what you have here was intended by the comment
> > > then. Do you have an archive link about that discussion?
> >
> > no as i was not around for said discussion.  but it should be in the
> > threads covering the submission of blackfin for 2.6.13 ...
>
>Ok, I found http://marc.theaimsgroup.com/?l=linux-kernel&m=114298753207549&w=2
>from akpm, and I fear you heavily misunderstood him.
>
>Your original patch had code like
>
>/* System Reset and Interrupt Controller registers for core A (0xFFC0 
>0100-0xFFC0 01FF) */
>#define SICA_SWRST              0xFFC00100·····/* Software Reset register */
>[snip]
>...
>
>#define pSICA_SWRST (volatile unsigned short *)SICA_SWRST
>[snip]
>
>static void bf561_internal_mask_irq(unsigned int irq)
>{
>         unsigned long irq_mask;
>         if ((irq - (IRQ_CORETMR + 1)) < 32) {
>                 irq_mask = (1 << (irq - (IRQ_CORETMR + 1)));
>                 pSICA_IMASK0 &= ~irq_mask;
>         } else {
>                 irq_mask = (1 << (irq - (IRQ_CORETMR + 1) - 32));
>                 pSICA_IMASK1 &= ~irq_mask;
>         }
>}
>
>which Andrew objected to, on multiple grounds. You now converted this to
>
>/* System Reset and Interrupt Controller registers for core A (0xFFC0 
>0100-0xFFC0 01FF) */
>#define SICA_SWRST              0xFFC00100·····/* Software Reset register */
>[snip]
>/* System Reset and Interrupt Controller registers for core A (0xFFC0 
>0100-0xFFC0 01FF) */
>#define bfin_read_SICA_SWRST()               bfin_read16(SICA_SWRST)
>[snip]
>
>...
>static void bf561_internal_mask_irq(unsigned int irq)
>{
>         unsigned long irq_mask;
>         if ((irq - (IRQ_CORETMR + 1)) < 32) {
>                 irq_mask = (1 << (irq - (IRQ_CORETMR + 1)));
>                 bfin_write_SICA_IMASK0(bfin_read_SICA_IMASK0() & ~irq_mask);
>         } else {
>                 irq_mask = (1 << (irq - (IRQ_CORETMR + 1) - 32));
>                 bfin_write_SICA_IMASK1(bfin_read_SICA_IMASK1() & ~irq_mask);
>         }
>}
>
>which is about just as bad, but for different reasons.

I would be interested in the reasons why this is bad. We thought is solved 
the problem, and our driver developers are Ok using it, and it is catching 
more problems at compile time than we use to (which is the main reason I 
thought to remove all the volatile casting.

>Now, there are
>at least two common methods for how to do this better, both involving
>the readl/writel low-level accessors (or something similar).

The thing to understand about the Blackfin architecture - is not all system 
register, or peripheral registers are 32 bits. Some are 16 bits, and some 
are 32. The Hardware will error if you access a 32 bit instruction, with a 
16 bit access, or a 16 bit access on a 32 bit instruction.

This is why we added:
bfin_write16();  bfin_read16(); bfin_write32();  bfin_read32();

We can't use a common function, like:

bfin_sica_read(int reg)

or use the read16/read32 directly - it would be to hard for the driver 
developers to keep the manual with them all the time to find out if a 
register was 16 or 32 bits. It would move what we have today (compiler 
errors), to run time errors if someone used the wrong function.

>The first one uses enumerated register numers:
>
>/* System Reset and Interrupt Controller registers for core A (0xFFC0 
>0100-0xFFC0 01FF) */
>
>enum bfin_sica_regs {
>         SICA_SWRST   = 100,·····/* Software Reset register */
>         SICA_SYSCR   = 104,·····/* System Reset Configuration register */
>         SICA_RVECT   = 108,·····/* SIC Reset Vector Address Register */
>         SICA_IMASK   = 10C,·····/* SIC Interrupt Mask register 0 - hack 
> to fix old tests */
>         SICA_IMASK0  = 10C,·····/* SIC Interrupt Mask register 0 */
>         SICA_IMASK1  = 110,·····/* SIC Interrupt Mask register 1 */
>         SICA_IAR0    = 124,·····/* SIC Interrupt Assignment Register 0 */
>         SICA_IAR1    = 128,·····/* SIC Interrupt Assignment Register 1 */
>         SICA_IAR2    = 12C,·····/* SIC Interrupt Assignment Register 2 */
>         SICA_IAR3    = 130,·····/* SIC Interrupt Assignment Register 3 */
>         SICA_IAR4    = 134,·····/* SIC Interrupt Assignment Register 4 */
>         SICA_IAR5    = 138,·····/* SIC Interrupt Assignment Register 5 */
>         SICA_IAR6    = 13C,·····/* SIC Interrupt Assignment Register 6 */
>         SICA_IAR7    = 140,·····/* SIC Interrupt Assignment Register 7 */
>         SICA_ISR0    = 114,·····/* SIC Interrupt Status register 0 */
>         SICA_ISR1    = 118,·····/* SIC Interrupt Status register 1 */
>         SICA_IWR0    = 11C,·····/* SIC Interrupt Wakeup-Enable register 0 */
>         SICA_IWR1    = 120,·····/* SIC Interrupt Wakeup-Enable register 1 */
>};
>
>...
>
>static void __iomem *bfin_sica = (void __iomem *)0xffc00100ul;
>static inline __le32 bfin_sica_read(int reg)
>{
>         return (__le32)readl(bfin_sica + reg);
>}
>
>static inline void bfin_sica_write(int reg, __le32 val)
>{
>         writel((uint32_t)val, bfin_sica + reg);
>}
>
>static void bf561_internal_mask_irq(unsigned int irq)
>{
>         unsigned long irq_mask;
>         if ((irq - (IRQ_CORETMR + 1)) < 32) {
>                 irq_mask = (1 << (irq - (IRQ_CORETMR + 1)));
>                 bfin_sica_write(SICA_IMASK0,
>                         bfin_sica_read(SICA_IMASK0) & ~irq_mask);
>         } else {
>                 irq_mask = (1 << (irq - (IRQ_CORETMR + 1) - 32));
>                 bfin_sica_write(SICA_IMASK0,
>                         bfin_sica_read(SICA_IMASK0) & ~irq_mask);
>         }
>}
>
>The alternative approach uses a structure:

We could use this approach, filling it up with 16 bit padding all over the 
place (which is easy to do), but it is also difficult for the same reason. 
(Although I really like this, and can see lots of value from it - I am not 
sure we can use it).

You are still using writel(reg, value) and readl(reg) - which is hard to 
do, without a hardware reference beside you all the time - to determine 
which time you should use a readl or reads.

Unless I am completely missing something (which might be true).


>/* System Reset and Interrupt Controller registers for core A (0xFFC0 
>0100-0xFFC0 01FF) */
>
>struct bfin_sica_regs {
>         __le32 swrst;   /* Software Reset register */
>         __le32 syscr;   /* System Reset Configuration register */
>         __le32 rvect;   /* SIC Reset Vector Address Register */
>         __le32 imask[2]; /* SIC Interrupt Mask register 0-1 */
>         __le32 iar[8];  /* SIC Interrupt Assignment Register 0-7 */
>         __le32 isr[2];  /* SIC Interrupt Status register 0-1 */
>         __le32 iwr[2];  /* SIC Interrupt Wakeup-Enable register 0-2 */
>};
>
>...
>
>static struct bfin_sica_regs __iomem *bfin_sica = (void __iomem 
>*)0xffc00100ul;
>
>static void bf561_internal_mask_irq(unsigned int irq)
>{
>         int irqnr = irq - (IRQ_CORETMR + 1);
>         __le32 __iomem *reg = &bfin_sica->imask[irqnr >> 5];
>         unsigned long irq_mask = 1 << (irqnr & 0x1f);
>
>         writel(reg, readl(reg) & ~irq_mask);
>}
>
>I'd personally prefer the last approach because of its compactness.
>
>         Arnd <><

Although I think the code is smaller, and nicer - it involves more run time 
complexity, and will consume more processor cycles - the old example:

static void bf561_internal_mask_irq(unsigned int irq)
{
         unsigned long irq_mask;
         if ((irq - (IRQ_CORETMR + 1)) < 32) {
                 irq_mask = (1 << (irq - (IRQ_CORETMR + 1)));
                 bfin_write_SICA_IMASK0(bfin_read_SICA_IMASK0() & ~irq_mask);
         } else {
                 irq_mask = (1 << (irq - (IRQ_CORETMR + 1) - 32));
                 bfin_write_SICA_IMASK1(bfin_read_SICA_IMASK1() & ~irq_mask);
         }
}

resolves all addresses at compile time, not run time. So, wouldn't your 
example slow things down?

-Robin 
