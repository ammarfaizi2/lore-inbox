Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131324AbRCWVhP>; Fri, 23 Mar 2001 16:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131466AbRCWVhF>; Fri, 23 Mar 2001 16:37:05 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:56072 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S131324AbRCWVhA>; Fri, 23 Mar 2001 16:37:00 -0500
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.2-ac20 patch for process time double-counting (was: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.)
In-Reply-To: <Pine.LNX.4.33.0103230844090.2031-100000@mikeg.weiden.de>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Mike Galbraith's message of "Fri, 23 Mar 2001 08:44:59 +0100 (CET)"
Date: 23 Mar 2001 15:36:03 -0600
Message-ID: <vbalmpwxj5o.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <mikeg@wen-online.de> writes:
> 
> > Mike, would you like to try out the following (untested) patch against
> > vanilla ac20 to see if it does the trick?
> 
> Yes, that fixed it.

Great!  Can you test one more configuration, please?  I can't test it
properly with my SMP motherboard.  Under "ac20", if you disable:

        Symmetric multi-processing support (CONFIG_SMP)

you'll get to say yes to:

        APIC support on uniprocessors (CONFIG_X86_UP_APIC)

If you say yes to that, you'll also get to say yes to:

        IO-APIC support on uniprocessors (CONFIG_X86_UP_IOAPIC)

Can you check that the following patch against vanilla "ac20" works
correctly with SMP disabled and X86_UP_APIC enabled?  (The original
patch I gave you won't compile with this configuration, since I put
the declaration in the wrong include file.)  It shouldn't matter
whether X86_UP_IOAPIC is enabled or disabled.

In addition to checking that the sys/user times look right, please
check for the message:

        Using local APIC timer interrupts.

in your boot messages (I *don't* think it'll be there, but I'm not
sure, and I'd really like to know one way or the other).  In fact, if
you could send me your kernel messages up to the PCI probe, that would
be ideal.

Thanks muchly!

Kevin <buhr@stat.wisc.edu>

                        *       *       *

diff -ru linux-2.4.2-ac20-vanilla/arch/i386/kernel/apic.c linux-2.4.2-ac20/arch/i386/kernel/apic.c
--- linux-2.4.2-ac20-vanilla/arch/i386/kernel/apic.c	Fri Mar 23 14:21:47 2001
+++ linux-2.4.2-ac20/arch/i386/kernel/apic.c	Fri Mar 23 15:12:15 2001
@@ -30,6 +30,9 @@
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
 
+/* Using APIC to generate smp_local_timer_interrupt? */
+int using_apic_timer = 0;
+
 int prof_multiplier[NR_CPUS] = { 1, };
 int prof_old_multiplier[NR_CPUS] = { 1, };
 int prof_counter[NR_CPUS] = { 1, };
@@ -872,6 +875,9 @@
 
 void __init setup_APIC_clocks (void)
 {
+	printk("Using local APIC timer interrupts.\n");
+	using_apic_timer = 1;
+
 	__cli();
 
 	calibration_result = calibrate_APIC_clock();
diff -ru linux-2.4.2-ac20-vanilla/arch/i386/kernel/time.c linux-2.4.2-ac20/arch/i386/kernel/time.c
--- linux-2.4.2-ac20-vanilla/arch/i386/kernel/time.c	Fri Mar 23 14:21:47 2001
+++ linux-2.4.2-ac20/arch/i386/kernel/time.c	Fri Mar 23 14:04:43 2001
@@ -422,7 +422,7 @@
 	if (!user_mode(regs))
 		x86_do_profile(regs->eip);
 #else
-	if (!smp_found_config)
+	if (!using_apic_timer)
 		smp_local_timer_interrupt(regs);
 #endif
 
diff -ru linux-2.4.2-ac20-vanilla/include/asm-i386/mpspec.h linux-2.4.2-ac20/include/asm-i386/mpspec.h
--- linux-2.4.2-ac20-vanilla/include/asm-i386/mpspec.h	Mon Jan  8 13:35:28 2001
+++ linux-2.4.2-ac20/include/asm-i386/mpspec.h	Fri Mar 23 14:20:19 2001
@@ -182,6 +182,7 @@
 extern int mp_current_pci_id;
 extern unsigned long mp_lapic_addr;
 extern int pic_mode;
+extern int using_apic_timer;
 
 #endif
 
