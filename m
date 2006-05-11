Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWEKJhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWEKJhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 05:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWEKJhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 05:37:33 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:52125 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030209AbWEKJhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 05:37:32 -0400
Date: Thu, 11 May 2006 11:37:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC][PATCH] Cascaded interrupts: a simple solution
Message-ID: <20060511093712.GA26316@elte.hu>
References: <1147325215.30380.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147325215.30380.45.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> I figured out that it would be very simple to make that much cleaner 
> and generic by simply defining a new interrupt flag SA_CASCADEIRQ to 
> attach to the cascade irq, and have the handler fetch the interrupts 
> from the slave controller and return them to the core.

> Note the fact that it's looping on the handler until IRQ_NONE is 
> returned, since a cascaded controller might issue only one irq 
> upstream for any combination of downstream interrupts, it must be 
> "polled" until it has no more interrupt to return.

We have solved this problem in the genirq patchset, but in a different 
way. No matter how much i'd like to see a simple solution for a hard 
problem, we believe the SA_CASCADEIRQ method is insufficient, for a 
number of reasons.

The main goal of genirq: to merge the ARM architecture to the generic 
IRQ layer and thus make the generic IRQ layer truly generic. Secondary 
goal: to not disturb any of the current genirq architectures (i.e. stay 
fully compatible). The ARM IRQ layer is exotic in some respects, but it 
is certainly the most advanced IRQ layer in terms of PIC-topology 
handling, given the rich variety of ARM hardware in existence.

Just some stats to back this up: arch/arm*/ has 118 separate PIC 
implementations, and amongst them there are more than 40 that need 
demultiplex handlers. As a comparison, arch/[ppc/powerpc] sports 27 PIC 
implementations, amongst which there are 5 that need demultiplex 
handlers. arch/i386 has 10 PIC implementations and none of them need 
demultiplex handlers [there are minor forms of cascading in x86 
hardware, but none need true irq-vector demultiplexing].

Most architectures modeled their IRQ layer after i386 IRQ layer, and 
this resulted in the first phase of generic IRQ layer being quite 
similar to the i386 layer. But the largest and most versatile Linux IRQ 
subsystem was left out of the original genirq design (done by yours 
truly), and many good bits (amongst them the right way to handle 
cascading/chaining) i missed.

Current status of genirq: it has been part of the -rt tree for more than 
a year, and an earlier version has been sent to lkml once already - 
Thomas has submitted an improved version of it to the ARM lists roughly 
a week ago and it is currently being tested on many ARM boards, with 
good results.

(I suspect you are aware of our genirq efforts, hence did you Cc: Thomas 
and me? If you are aware of it, please address the differences between 
the two approaches and outline why you chose a different solution - 
thanks!)

Most PIC implementations do not need to worry about PIC cascading, and 
neither the SA_CASCADEIRQ nor the genirq approach impacts them. So my 
analysis of your patch only involves true cascaded PICs and the ways to 
support them cleanly.

For cascaded PICs, the main problem with the SA_CASCADEIRQ approach is 
that it assumes that cascading/demultiplexing can be handled via a 
"return irq" method, in an iterative way.

But this does not match the demultiplexing model that happens on the 
majority of ARM boards for example: there a bitmask is read from the 
secondary interrupt controller, and that bitmask might have multiple 
bits set. By returning only one bit [which iteration model your 
interface forces], the other bits can be lost. On some hardware those 
missed bits might be regenerated, but there is PIC hardware where that 
information is permanently lost and we end up losing interrupts.

Such mask-based demultiplexing PICs are not limited to ARM, they occur 
in the PPC world too, for example in arch/ppc/syslib/m82xx_pci.c, 
pq2pci_irq_demux():

 static irqreturn_t
 pq2pci_irq_demux(int irq, void *dev_id, struct pt_regs *regs)
 {
         unsigned long stat, mask, pend;
         int bit;

         for(;;) {
                 stat = *(volatile unsigned long *) PCI_INT_STAT_REG;
                 mask = *(volatile unsigned long *) PCI_INT_MASK_REG;
                 pend = stat & ~mask & 0xf0000000;
                 if (!pend)
                         break;
                 for (bit = 0; pend != 0; ++bit, pend <<= 1) {
                         if (pend & 0x80000000)
                                 __do_IRQ(NR_CPM_INTS + bit, regs);
                 }
         }

         return IRQ_HANDLED;
 }

If PCI_INT_MASK_REG is a read-once register, then the SA_CASCADEIRQ 
method could result in lost interrupts. (i'm not totally sure, but i 
think in this specific case that register is read-once and it also 
involves an auto-ack. In any case, there definitely is ARM hardware 
where this equivalent register is read-once.)

Even if PCI_INT_MASK_REG could be read in a non-destructive way, 
multiple bits would need multiple iterations and multiple (unnecessary) 
passes over the whole bitmask - and they would thus also need 
unnecessary IO cycles to re-fetch the mask itself.

(Depending on how many different interrupt sources a secondary PIC 
connects, and how frequently those are risen, this might or might not be 
a real performance problem. But in any case, the "return irq" method is 
certainly an ugly and unnatural model for such PICs and there is no 
clean way to handle this type of cascading via the 'return irq' method.)

So the solution we took in genirq was to delegate the act of 
demultiplexing into the _demultiplexing handler_, by adopting the ARM
IRQ layer's approach of calling desc_handle_irq(irq, desc, regs). For
example:

 static void locomo_gpio_handler(unsigned int irq, struct irqdesc *desc,
                                 struct pt_regs *regs)
 {
 [...]
                irq = LOCOMO_IRQ_GPIO_START;
                d = irq_desc + LOCOMO_IRQ_GPIO_START;
                for (i = 0; i <= 15; i++, irq++, d++) {
                        if (req & (0x0001 << i)) {
                                desc_handle_irq(irq, d, regs);
                        }
                }
 [...]
 }

desc_handle_irq() does the locking and the calling of the highlevel irq 
handler of the secondary PIC. [which then processes the device IRQ 
handler actions and does any pre/post ACKing logic] There is no impact 
to non-cascading PIC designs in this model either.

Another, conceptual level problem is that (ab-)using the irq handler 
methods to return an actual interrupt number is a layering violation. 
There is not much in common between an IRQ demultiplexer function and an 
interrupt handler function. The act of cascading two PICs _inevitably_ 
means that there is a 1:N relationship between the two PICs, while an 
IRQ handler is normally a 1:1 relationship between a hardware device and 
a PIC. (there are exceptions like shared interrupts, but the norm we are 
designing for is a 1:1 relationship) There are many other fundamental 
differences too. Thus in our genirq work we have separated these two 
concepts.

In terms of patch merging (unless there are some arguments i've 
overlooked), due to the reasons above i'm against merging SA_CASCADEIRQ, 
even if it's relatively simple. It does not solve the demultiplexing 
problem for most of the ARM handlers (nor for the PPC example i cited), 
hence a separate variant has to be implemented anyway which results in 
unnecessary code and concept duplication.

The current PPC/powerpc approach of calling __do_IRQ() might be hacky, 
but it's functional, so neither is there any instant urgency AFAICS. If 
our more complete genirq approach is rejected for whatever reason then 
the SA_CASCADEIRQ patch can still be revisited as a secondary choice.

Nor can i see any big cleanup effect in terms of per-arch PIC code, the 
patch actually adds a bit of code:

 arch/powerpc/platforms/powermac/pic.c |   39 ++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 11 deletions(-)

	Ingo
