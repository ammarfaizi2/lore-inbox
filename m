Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318798AbSIITgQ>; Mon, 9 Sep 2002 15:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318153AbSIITgQ>; Mon, 9 Sep 2002 15:36:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42906 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318798AbSIITgP>;
	Mon, 9 Sep 2002 15:36:15 -0400
Date: Mon, 9 Sep 2002 21:45:20 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch] fix NMI watchdog, 2.5.34
Message-ID: <Pine.LNX.4.44.0209092144140.10544-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch fixes the NMI watchdog to trigger on all CPUs - the
cpu_up() code broke it long time ago. With this patch NMI interrupts get
generated on all CPUs, not just the boot CPU.

	Ingo

--- linux/arch/i386/kernel/io_apic.c.orig	Mon Sep  9 21:34:53 2002
+++ linux/arch/i386/kernel/io_apic.c	Mon Sep  9 21:37:27 2002
@@ -1490,7 +1490,7 @@
 	end_lapic_irq
 };
 
-static void enable_NMI_through_LVT0 (void * dummy)
+void enable_NMI_through_LVT0 (void * dummy)
 {
 	unsigned int v, ver;
 
--- linux/arch/i386/kernel/smpboot.c.orig	Mon Sep  9 21:35:48 2002
+++ linux/arch/i386/kernel/smpboot.c	Mon Sep  9 21:43:00 2002
@@ -452,6 +452,11 @@
 	while (!test_bit(smp_processor_id(), &smp_commenced_mask))
 		rep_nop();
 	setup_secondary_APIC_clock();
+	if (nmi_watchdog == NMI_IO_APIC) {
+		disable_8259A_irq(0);
+		enable_NMI_through_LVT0(NULL);
+		enable_8259A_irq(0);
+	}
 	enable_APIC_timer();
 	/*
 	 * low-memory mappings have been cleared, flush them from
--- linux/include/asm-i386/apic.h.orig	Mon Sep  9 21:37:43 2002
+++ linux/include/asm-i386/apic.h	Mon Sep  9 21:37:51 2002
@@ -89,6 +89,7 @@
 
 extern unsigned int apic_timer_irqs [NR_CPUS];
 extern int check_nmi_watchdog (void);
+extern void enable_NMI_through_LVT0 (void * dummy);
 
 extern unsigned int nmi_watchdog;
 #define NMI_NONE	0

