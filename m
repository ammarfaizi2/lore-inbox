Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270790AbTGNUN1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270810AbTGNUL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:11:56 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:63148 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S270801AbTGNUJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:09:41 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: <linux-kernel@vger.kernel.org>
Subject: Interrupt doesn't make it to the 8259 on a ASUS P4PE mobo
Date: Mon, 14 Jul 2003 16:35:03 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGOEKFCCAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

We have a proprietary PCI board installed in a (UP) system with an ASUS P4PE
motherboard (uses Intel 845PE chipset). This system is running Red Hat 9.0
(kernel version 2.4.20-8).  I've combed the ASUS website, the linux-kernel
mailing lists and the internet in general for answers, but have turned up
nothing.

Here's what I've found:  I've discovered that our software will run for a
short time and then appear to be hung (keyboard and mouse not responding,
can't remote log in).  We have found that when it hangs, our software is
still
running and there are no reports of Linux Oops, system panics or processor
faults.  At that time, our driver is expecting an interrupt indicating a DMA
completion, but times out because it never receives it.  It then disables
the interrupt at the board and issues a reset of the board's interrupt.
Then it tries sending it's data again.
At the point of failure, the logic analyzer shows that our board is
asserting the interrupt.  It also shows that on all _previous_ interrupts
(and in the case of our timeout), I clear the interrupt appropriatly on our
board.  In an effort to find out why the driver never receives the
interrupt, I added a small amount of debug to the Linux kernel source code
(in do_IRQ of irq.c) to see if the O/S is even seeing the interrupt.  I
determined, without fail, that every time the kernel received our IRQ, it
issued an EOI and called our driver's interrupt service routine.  I did this
by adding counters in the do_IRQ routine to count the # of my IRQs received,
# of times it was acknowledged and # of times a handler was called.  If
everything has gone smoothly, all 3 of these should be the same - and they
are.  Code snip:

asmlinkage unsigned int do_IRQ(struct pt_regs regs)
{
. . .

int irq_hit = 0;     /* new, for debugging */
if (irq==kdbug_irq)  /* kdbug_irq set by a user utility to turn this
debugging on */
   {
   irq_hit = 1;
   atomic_inc(&kdbug_irq_cnt);    /* new, for debugging */
   }
#ifdef CONFIG_DEBUG_STACKOVERFLOW

. . .

spin_lock(&desc->lock);
desc->handler->ack(irq);
if (irq_hit) atomic_inc(&kdbug_irq_ack);   /* new, for debugging */

/* REPLAY stuff . . . */

for (;;) {
   spin_unlock(&desc->lock);
   handle_IRQ_event(irq,&regs, action);
   spin_lock(&desc->lock);
   if (irq_hit)     /* new, for debugging */
      atomic_inc(&kdbug_call_isr);

. . .

I then have a user application which periodically calls another driver that
calls another kernel debug routine which simply reports back the value of
these 3 counters and then re-inits them to zero.  As I said, these counters
are always equal.  Once the system "hangs"  these counters are always zero,
so I concluded that Linux was never notified of the interrupt.  I then added
code to peek at the 8259 registers to determine if it is receiving
notification of the pending interrupt.  I discovered that the IMR register
did not have my IRQ, the keyboard, PS/2 mouse or ethernet interrupts masked
off.  In addition, the IRR register shows that there is no interrupt pending
for our IRQ.  The ISR register does not show evidence of our IRQ being
serviced either.  However, the ISR shows that it is servicing the PS/2 mouse
interrupt.  It appears to be "stuck" somewhere between the time of the
interrupt acknowledge cycle and it's driver issuing the EOI (since issuing
an EOI is what clears the bit in 8259's ISR register).  Subsequent reads of
the 8259's ISR shows that the mouse is still being serviced.  We also tried
a USB mouse to eliminate a mouse driver problem.  We still experienced a
system "hang".  It's almost as if something in the motherboard is is some
strange state because no other IRQs can get through.  We have tried BIOS
updates and still have the problem.  We have also used our software and
hardware successfully on other PC platforms using Linux (it was a Pentium
III system) and SUN platforms running Solaris.  (Note that for this
debugging, we have configured the system so that our board uses IRQ 9
exclusively to eliminate any problems with interrupt sharing.)  We also
tried a second system using an P4PE motherboard to insure that it wasn't a
single faulty motherboard.  We received the same results.

While it appears to be hardware related, I wanted to see if anyone else has
experienced anything like this.  My concern was that I might be experiencing
a race condition with the driver and board.  I believe I have taken the
appropriate precautions that I have read about on this mailing list, but I
invite a second opinion (or third, forth, . . ) on the implementation.
Here's how it goes:

<code snip> from the driver's write routine:

. . .

/* The Reg element previously set using ioremap on the resource returned by
pci_resource_start */
writel(cpu_tole32(num_bytes), &pslState->Reg->DMA_Length);
wmb();
writel(cpu_to_le32(data), &pslState->Reg->DMA_Address);

/* start timer */
dmatimer.expires = jiffies + 0.5*HZ;
dmatimer.function = (void *) &dma_timeout;
dmatimer.data = (int) pslState;
add_timer(&dmatimer);

pslState->DMAIntr = INTR_PEND;
writel(BITS_TO_ENABLE_DMA, &pslState->Reg->ControlOrStatus);
wmb();
wait_event_interruptible(pslState->DMAIntrcvQ,
((pslState->DMAIntr==INTR_RECVD) || (pslState->DMAIntr==INTR_TO)));
del_timer(&dmatimer);

/* If our timer expired, then disable the DMA interrupt (since we never
entered our ISR to do this) */
if (pslState->DMAIntr == INTR_TO)
   {
   writel(BITS_TO_DISABLE_DMA, &pslState->Reg->ControlOrStatus);
   wmb();
   }

/* Error checking with boards's DMA reset and re-try logic goes here */

. . . < end code snip of write routine>

/* timeout routine called for the DMA timer */
void dma_timeout(STATE *pslState);
{
pslState->DMAIntr=INTR_TO;
wake_up_interruptible(&pslState->DMAIntrcvQ);
}

/* Our ISR code snip */

. . .

rval = (readl(&pslState(&pslState->Reg->ControlOrStatus) & DMA_INTERRUPT);
rmb();
if (rval)
   {
   writel(BITS_TO_DISABLE_DMA, &pslState->Reg->ControlOrStatus);
   wmb();
   pslState->DMAIntr=INTR_RECVD;
   wake_up_interruptible(&pslState->DMAIntrcvQ);
   }


I appreciate your feedback on whether you suspect any race conditions or why
the 8259 does not receive the interrupt.  If you need any additional
information, please let me know!  Thanks in advance for your help!

Kathy Frazier
Senior Software Engineer
Max Daetwyler Corporation-Dayton Division
2133 Lyons Road
Miamisburg, OH 45342
Tel #: 937.439-1582 ext 6158
Fax #: 937.439-1592
Email: kfrazier@daetwyler.com
http://www.daetwyler.com



