Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311424AbSCSQh1>; Tue, 19 Mar 2002 11:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311430AbSCSQhS>; Tue, 19 Mar 2002 11:37:18 -0500
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:33690 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S311424AbSCSQhE>; Tue, 19 Mar 2002 11:37:04 -0500
Date: Tue, 19 Mar 2002 17:39:36 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.GSO.3.96.1020319145208.12399I-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0203191711070.9609-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

thanks a lot for caring about this problem!

> > operation is a read on port 0x21 that reveals the junk value 0x07! The
>
>  The value is correct as after issuing the poll i8259 command the next
> read cycle to the PIC returns an IRQ level (0x07 = no IRQ active; it
> shouldn't happen here -- 0x80 is expected for active IRQ 0).

We found this out in the meantime as well. Actually sometimes the read
obtains 0x80, though very seldom. If that happens, we may still get 0x07
later.

Our analysis so far turned out that:

- A system management interrupt (SMI) is generated *right after* the
  outb (0x0c, 0x20); statement, i.e. before the inb (0x20).
  The reason for that SMI is the aic7xxx driver probing for some
  non-existing EISA device and causing a PCI bus abort. It could be
  anything else, though.

- The SMI handler in the BIOS masks the PIC interrupts. It reads the
  current mask (this is where the wrong value is obtained).
  At exit from SMI, it restores this wrong value to register 0x21.
  The SMI handler simply does not account for the fact that
  the PIC may be in polling mode when it reads register 0x21.
  We are right now trying a patched BIOS that does a dummy read
  on the PIC, before trying to obtain the mask from 0x21.
  This is an (almost) standard Phoenix BIOS, the IRQ masking code
  was definitely not changed by anyone at our company.

Thus yes, the timer_ack code is actually (partly) responsible for
our hang. I propose a patch for this below.

>  Any chance your system uses the ExtINTA mode for the timer IRQ?

No, different problem - see above.

We use normal ExtInt operation:

Mar 12 16:51:30 pdb0374c kernel: ENABLING IO-APIC IRQs
Mar 12 16:51:30 pdb0374c kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Mar 12 16:51:30 pdb0374c kernel: ...changing IO-APIC physical APIC ID to 3 ... ok.
Mar 12 16:51:30 pdb0374c kernel: ..TIMER: vector=0x31 pin1=-1 pin2=0
Mar 12 16:51:30 pdb0374c kernel: ...trying to set up timer (IRQ0) through the 8259A ...
Mar 12 16:51:30 pdb0374c kernel: ..... (found pin 0) ...works.

For the timer_ack stuff, I observe that it is only needed for
do_slow_gettimeoffset, i.e. only for CPUs which do not have a TSC.
Thus I propose the folloing patch:

--- ./arch/i386/kernel/time.c.ORIG	Fri Mar 15 14:57:00 2002
+++ ./arch/i386/kernel/time.c	Tue Mar 19 17:27:12 2002
@@ -384,7 +384,9 @@
 /* last time the cmos clock got updated */
 static long last_rtc_update;

+#ifndef CONFIG_X86_TSC
 int timer_ack;
+#endif

 /*
  * timer_interrupt() needs to keep up the real-time clock,
@@ -392,7 +394,7 @@
  */
 static inline void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-#ifdef CONFIG_X86_IO_APIC
+#if defined (CONFIG_X86_IO_APIC) && ! defined (CONFIG_X86_TSC)
 	if (timer_ack) {
 		/*
 		 * Subtle, when I/O APICs are used we have to ack timer IRQ
--- ./arch/i386/kernel/io_apic.c.ORIG	Tue Mar 19 17:31:25 2002
+++ ./arch/i386/kernel/io_apic.c	Tue Mar 19 17:30:02 2002
@@ -1478,7 +1478,9 @@
  */
 static inline void check_timer(void)
 {
+#ifndef CONFIG_X86_TSC
 	extern int timer_ack;
+#endif
 	int pin1, pin2;
 	int vector;

@@ -1498,7 +1500,7 @@
 	 */
 	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_EXTINT);
 	init_8259A(1);
-	timer_ack = 1;
+	timer_ack = !(cpu_has_tsc);
 	enable_8259A_irq(0);

 	pin1 = find_isa_irq_pin(0, mp_INT);


This would get us rid of our problem (although the BIOS hack may
suffice). However, more than that, it also spares ~2 us on each timer
interrupt for CPUs which do not need do_slow_gettimeoffset.

What do you think?

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy






