Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSCTN2c>; Wed, 20 Mar 2002 08:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311600AbSCTN2U>; Wed, 20 Mar 2002 08:28:20 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:60599 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S287134AbSCTN1X>; Wed, 20 Mar 2002 08:27:23 -0500
Date: Wed, 20 Mar 2002 14:27:15 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
cc: Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.LNX.4.33.0203200844000.9609-100000@biker.pdb.fsc.net>
Message-ID: <Pine.GSO.3.96.1020320121631.13532A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Martin Wilck wrote:

> Whatever's wrong with our BIOS is not the focus of the patch.

 Sure, but working around hopeless cases is not the Linux's job either. 
We cannot guarantee operation on an out-of-spec system that carelessly
fiddles with registers beneath the kernel.  The system needs to be fixed. 

> There are two sides to this, and the Linux side is that the
> IO-operations to port 20 are completely superfluous on modern CPUs.

 Depending on the configuration -- a user may specify "notsc" for whatever
reason (although admittedly, that's mostly a debugging option).

> There is no point in keeping the timer_ack variable in the kernel's
> symbol table if it's compiled for CPUS with TSC only, and no need

 There is a point, actually.  There are i82489DX-based Pentium systems. 
They work fine with a CONFIG_X86_TSC kernel but still they require the
code in do_timer_interrupt() for NMI watchdog deassertion -- watch the
comment. 

> to test it in every timer interrupt if we know it's going to be 0
> anyway.

 The current code actually supports discrete i82489DX local APICs for any
CPU, so you don't really know unless you define an additional
configuration option to force integrated APIC support only.  Do you really
think it's worth the hassle to save an order of two-three CPU cycles per
10ms? 

> Please note that do_slow_timeoffset is completely #ifdef'ed out in
> time.c for CPUs with TSC.

 In short some code like: 

timer_ack = !(cpu_has_tsc &&
	      APIC_INTEGRATED(GET_APIC_VERSION(apic_read(APIC_LVR))));

should suffice as the condition to disable the code in
do_timer_interrupt() for systems using the through-8259A mode.  There is
no need to keep it enabled unconditionally and I/O cycles are quite
expensive.  The following patch implements it.  Please test it.  It should
cure your problems as a side effect, but that does not mean the BIOS isn't
to be fixed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.18-timer_ack-1
diff -up --recursive --new-file linux-2.4.18.macro/arch/i386/kernel/io_apic.c linux-2.4.18/arch/i386/kernel/io_apic.c
--- linux-2.4.18.macro/arch/i386/kernel/io_apic.c	Fri Nov 23 15:32:04 2001
+++ linux-2.4.18/arch/i386/kernel/io_apic.c	Wed Mar 20 12:36:11 2002
@@ -1481,6 +1481,10 @@ static inline void check_timer(void)
 	extern int timer_ack;
 	int pin1, pin2;
 	int vector;
+	unsigned int ver;
+
+	ver = apic_read(APIC_LVR);
+	ver = GET_APIC_VERSION(ver);
 
 	/*
 	 * get/set the timer IRQ vector:
@@ -1494,11 +1498,15 @@ static inline void check_timer(void)
 	 * mode for the 8259A whenever interrupts are routed
 	 * through I/O APICs.  Also IRQ0 has to be enabled in
 	 * the 8259A which implies the virtual wire has to be
-	 * disabled in the local APIC.
+	 * disabled in the local APIC.  Finally timer interrupts
+	 * need to be acknowledged manually in the 8259A for
+	 * do_slow_timeoffset() and for the i82489DX when using
+	 * the NMI watchdog.
 	 */
 	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_EXTINT);
 	init_8259A(1);
-	timer_ack = 1;
+	timer_ack = !cpu_has_tsc;
+	timer_ack |= nmi_watchdog == NMI_IO_APIC && !APIC_INTEGRATED(ver);
 	enable_8259A_irq(0);
 
 	pin1 = find_isa_irq_pin(0, mp_INT);
@@ -1516,7 +1524,8 @@ static inline void check_timer(void)
 				disable_8259A_irq(0);
 				setup_nmi();
 				enable_8259A_irq(0);
-				check_nmi_watchdog();
+				if (check_nmi_watchdog() < 0);
+					timer_ack = !cpu_has_tsc;
 			}
 			return;
 		}
@@ -1535,7 +1544,8 @@ static inline void check_timer(void)
 			printk("works.\n");
 			if (nmi_watchdog == NMI_IO_APIC) {
 				setup_nmi();
-				check_nmi_watchdog();
+				if (check_nmi_watchdog() < 0);
+					timer_ack = !cpu_has_tsc;
 			}
 			return;
 		}
@@ -1567,6 +1577,7 @@ static inline void check_timer(void)
 
 	printk(KERN_INFO "...trying to set up timer as ExtINT IRQ...");
 
+	timer_ack = 0;
 	init_8259A(0);
 	make_8259A_irq(0);
 	apic_write_around(APIC_LVT0, APIC_DM_EXTINT);

