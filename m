Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTLJJex (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 04:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTLJJex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 04:34:53 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:1290 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S262110AbTLJJer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 04:34:47 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Wed, 10 Dec 2003 15:43:39 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, AMartin@nvidia.com, kernel@kolivas.org,
       Ian Kumlien <pomac@vapor.com>
References: <200312072312.01013.ross@datscreative.com.au> <Pine.LNX.4.55.0312091610320.20948@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0312091610320.20948@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312101543.39597.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 01:20, Maciej W. Rozycki wrote:
> On Sun, 7 Dec 2003, Ross Dickson wrote:
> 
> > b) I was also disappointed to see I could not have irq0 timer IO-APIC-edge. 
> > So I have fixed it too (tested on both my epox and albatron MOBOs).
> > Firstly I found 8254 connected directly to pin 0 not pin 2 of io-apic.
> > I have modified check_timer() in io_apic.c to trial connect pin and test for it
> > after the existing test for connection to io-apic.
> 
>  I'm pretty sure this part is bogus.  Have you actually verified it either
> by using a hardware probe or at least by investigating documentation you
> really have IRQ 0 routed to the I/O APIC interrupt #0 (INTIN 0)?  If no,
> then you can almost surely see interrupts travelling across the pair of
> 8259A PICS which are connected to the INTIN 0 input of the first I/O APIC
> in every IA32-based PC system providing an I/O APIC seen so far.
> 
> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 
> 
> 

Thanks Maciej for your response.

If everyone followed published recommendations then I would agree with
your comments however nvidia? et al?.

I have no appropriate docs so I cannot confirm via a real hardware probe 
so I can only offer a software confirmation.

Background musings:

I was forced to approach the problems using somewhat educated guesses and
with the tools I had at hand. As with most discoveries about black boxes the answer 
comes about by a combination of educated guess, luck and checking the unlikely.
The apic delay (a) came about because the lockup problem went away when I put 
a debugging outb_p() statement flipping bits at the lpt port while I was trying 
to catch the frozen IRQ state info on my CRO. I was pleasantly surprised when 
the lockups ceased so I replaced the outb_p with a delay and trimmed it as 
best I could without docs. I did not change it within the Ack call as I realised 
that all the other normal apic ack paths had considerably more code delay time - 
although could this be a gotcha depending on what code path is in the driver.
What if we had a really fast cpu or is it restricted solely to the timer irq??

Back to your query:

I approached the io-apic edge with the same what if?
I think I got it right but please check my following code to confirm.  I have
since hacked the kernel as follows.

WARNING Following Mods For Debugging Only!

In File i8259.c I needed to get to "cached_irq_mask" 

/*
 * This contains the irq mask for both 8259A irq controllers,
 */
//static unsigned int cached_irq_mask = 0xffff; debug ross
unsigned int cached_irq_mask = 0xffff;


In File io_apic.c I have tried to fully mask the 8259.

/*
 * This code may look a bit paranoid, but it's supposed to cooperate with
 * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ
 * is so screwy.  Thanks to Brian Perkins for testing/hacking this beast
 * fanatically on his truly buggy board.
 */
// debug ross
extern spinlock_t i8259A_lock;
extern unsigned int cached_irq_mask;

static inline void check_timer(void)
{
....
<snip>
....
#ifdef CONFIG_ACPI_BOOT && CONFIG_X86_UP_IOAPIC
	/* for nforce2 try vector 0 on pin0
	 * Note the io_apic_set_pci_routing call disables the 8259 irq 0
	 * so we must be connected directly to the 8254 timer if this works
	 * Note2: this violates the above comment re Subtle but works!
	 */
	printk(KERN_INFO "..TIMER: Is timer irq0 connected to IOAPIC Pin0? ...\n");
	if ( pin1 != -1 && nr_ioapics ) {
		int result, tok;
		unsigned long flags;
		unsigned int saved_cached_irq_mask;
		unsigned char imr1, imr2;

		int saved_timer_ack = timer_ack;

		// disable all of 8259 irq's
		spin_lock_irqsave(&i8259A_lock, flags);
		saved_cached_irq_mask = cached_irq_mask;
		cached_irq_mask = 0xffff;; // ensure nothing restores 8259 ints
		outb(0xff, 0x21);	/* mask all of 8259A-1 */
		outb(0xff, 0xA1);	/* mask all of 8259A-2 */
		spin_unlock_irqrestore(&i8259A_lock, flags);

		/*
		 * Ok, does IRQ0 through the IOAPIC work?
		 */
		/* next call also disables 8259 irq0 */
		result = io_apic_set_pci_routing ( 0, 0, 0, 0, 0);
		unmask_IO_APIC_irq(0);
		timer_ack = 0 ;

		spin_lock_irqsave(&i8259A_lock, flags);
		imr1 = inb(0x21);
		imr2 = inb(0xA1);
		printk("..TIMER check 8259 ints disabled, imr1:%02x, imr2:%02x\n", imr1, imr2);
		tok = timer_irq_works();
		spin_unlock_irqrestore(&i8259A_lock, flags);

		// restore 8259 mask
		spin_lock_irqsave(&i8259A_lock, flags);
		cached_irq_mask = saved_cached_irq_mask;
		outb( cached_irq_mask & 0xff, 0x21 ); /* restore all of 8259A-1 */
		outb( cached_irq_mask >> 8, 0xA1 ); /* restore all of 8259A-2 */
		spin_unlock_irqrestore(&i8259A_lock, flags);

		/*
		 * Ok, does IRQ0 through the IOAPIC work?
		 */
//		unmask_IO_APIC_irq(0);
//		timer_ack = 0 ;
//		if (timer_irq_works()) {
		if (tok) {
			if (nmi_watchdog == NMI_IO_APIC) {
				disable_8259A_irq(0);
				setup_nmi();
				enable_8259A_irq(0);
				check_nmi_watchdog();
			}
			printk(KERN_INFO "..TIMER: works OK on apic pin0 irq0\n" );
			return;
		}
		/* failed */
		timer_ack = saved_timer_ack;
		clear_IO_APIC_pin(0, 0);
		result = io_apic_set_pci_routing ( 0, pin1, 0, 0, 0);
		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC Pin 0\n");
	}
#endif
/* end new stuff for nforce2 */

The inner spinlock around timer_irq_works() I think is redundant but I put it there 
for good measure.
Relevant dmesg output from Albatron KM18G Pro ( this is different MOBO (same type) but 
this time has a barton core 2500 XP cpu).

enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC pin2
..TIMER: Is timer irq0 connected to IOAPIC Pin0? ...
IOAPIC[0]: Set PCI routing entry (2-0 -> 0x31 -> IRQ 0 Mode:0 Active:0)
..TIMER check 8259 ints disabled, imr1:ff, imr2:ff
..TIMER: works OK on apic pin0 irq0
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1829.0708 MHz.
..... host bus clock speed is 332.0674 MHz.
cpu: 0, clocks: 332674, slice: 166337
CPU0<T0:332672,T1:166320,D:15,S:166337,C:332674>


Please advise if anyone knows of extra registers which may have been added to the
nforce2 8259 core which could allow the interrupts through the masked chip core?
I note that they may exist after reading your email March 21 2002 (irq FosterP4) 
http://www.ussg.iu.edu/hypermail/linux/kernel/0203.2/1213.html

Note that I think it is safe to leave the 8259 irq(0) implicitly disabled on 
failure exit as the code paths following my code patch do it anyway.


Regards
Ross.
