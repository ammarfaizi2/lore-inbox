Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311277AbSCSOdZ>; Tue, 19 Mar 2002 09:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311278AbSCSOdP>; Tue, 19 Mar 2002 09:33:15 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:37542 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S311277AbSCSOdG>; Tue, 19 Mar 2002 09:33:06 -0500
Date: Tue, 19 Mar 2002 15:32:22 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
cc: Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.LNX.4.33.0203131912140.1477-100000@biker.pdb.fsc.net>
Message-ID: <Pine.GSO.3.96.1020319145208.12399I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Martin Wilck wrote:

> Where the <== arrow is, the analyzer clearly shows the outb (0x0c, 0x20)
> operation. After that, we see strange cycles for ~70us (probably special
> cycles for arbitration, definitely no valid data transfers). The very next bus
> operation is a read on port 0x21 that reveals the junk value 0x07! The

 The value is correct as after issuing the poll i8259 command the next
read cycle to the PIC returns an IRQ level (0x07 = no IRQ active; it
shouldn't happen here -- 0x80 is expected for active IRQ 0). 

> inb(0x20) call is not captured in our protocol, it must occur long after
> the error. (We saw normal execution of the above code fragment where
> there is ~1us between the outb and inb, where it is >120us here).

 Any chance your system uses the ExtINTA mode for the timer IRQ?  This
would be very weird -- it's the fourth, last attempt to set up the timer
IRQ, meant not to happen really anytime (and it also means the i8259A
implementation is buggy, incomplete or is wired incorrectly).  What does
your bootstrap log contain?

 If that's really the case then the following patch should help -- there
is a subtle bug in the code indeed, sigh. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.18-timer_ack-0
diff -up --recursive --new-file linux-2.4.18.macro/arch/i386/kernel/io_apic.c linux-2.4.18/arch/i386/kernel/io_apic.c
--- linux-2.4.18.macro/arch/i386/kernel/io_apic.c	Fri Nov 23 15:32:04 2001
+++ linux-2.4.18/arch/i386/kernel/io_apic.c	Tue Mar 19 14:21:35 2002
@@ -1567,6 +1567,7 @@ static inline void check_timer(void)
 
 	printk(KERN_INFO "...trying to set up timer as ExtINT IRQ...");
 
+	timer_ack = 0;
 	init_8259A(0);
 	make_8259A_irq(0);
 	apic_write_around(APIC_LVT0, APIC_DM_EXTINT);

