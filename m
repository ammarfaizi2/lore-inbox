Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274882AbTHKXdb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 19:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274888AbTHKXdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 19:33:31 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:33758 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S274882AbTHKXdZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 19:33:25 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16184.10173.412201.802953@gargle.gargle.HOWL>
Date: Tue, 12 Aug 2003 01:33:17 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: marcelo@conectiva.com.br, fxkuehl@gmx.de, linux-kernel@vger.kernel.org,
       willy@w.ods.org
Subject: [PATCH][2.4.22-rc2] Disable APIC on reboot.
In-Reply-To: <16183.51974.508883.472043@gargle.gargle.HOWL>
References: <E19mCuO-0003dI-00@tetrachloride>
	<16183.50273.723650.136532@gargle.gargle.HOWL>
	<20030811163834.GA21568@redhat.com>
	<16183.51974.508883.472043@gargle.gargle.HOWL>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch for 2.4.22-rc2 to disable the local APIC before
reboot. This fixes BIOS reboot problems reported by a few people.

disable_local_APIC() now checks if detect_init_APIC() enabled the
local APIC via the APIC_BASE MSR, and if so it now disables APIC_BASE.
Previously we would leave APIC_BASE enabled, and that made some
BIOSen unhappy.

The SMP reboot code calls disable_local_APIC(). On SMP HW there is
no change since detect_init_APIC() isn't called and APIC_BASE isn't
enabled by us. An SMP kernel on UP HW behaves just like an UP_APIC
kernel, so it disables APIC_BASE if we enabled it at boot.

The UP_APIC disable-before-suspend code is simplified since the existing
code to disable APIC_BASE is moved into disable_local_APIC().

(Felix Kühling originally reported the BIOS reboot problem. This is a
fixed-up version of his preliminary patch.)

/Mikael

--- linux-2.4.22-rc2/arch/i386/kernel/apic.c.~1~	2003-06-14 13:30:19.000000000 +0200
+++ linux-2.4.22-rc2/arch/i386/kernel/apic.c	2003-08-11 23:42:39.000000000 +0200
@@ -38,6 +38,8 @@
 int prof_old_multiplier[NR_CPUS] = { 1, };
 int prof_counter[NR_CPUS] = { 1, };
 
+static int enabled_via_apicbase;
+
 int get_maxlvt(void)
 {
 	unsigned int v, ver, maxlvt;
@@ -142,6 +144,13 @@
 	value = apic_read(APIC_SPIV);
 	value &= ~APIC_SPIV_APIC_ENABLED;
 	apic_write_around(APIC_SPIV, value);
+
+	if (enabled_via_apicbase) {
+		unsigned int l, h;
+		rdmsr(MSR_IA32_APICBASE, l, h);
+		l &= ~MSR_IA32_APICBASE_ENABLE;
+		wrmsr(MSR_IA32_APICBASE, l, h);
+	}
 }
 
 /*
@@ -464,7 +473,6 @@
 
 static void apic_pm_suspend(void *data)
 {
-	unsigned int l, h;
 	unsigned long flags;
 
 	if (apic_pm_state.perfctr_pmdev)
@@ -484,9 +492,6 @@
 	__save_flags(flags);
 	__cli();
 	disable_local_APIC();
-	rdmsr(MSR_IA32_APICBASE, l, h);
-	l &= ~MSR_IA32_APICBASE_ENABLE;
-	wrmsr(MSR_IA32_APICBASE, l, h);
 	__restore_flags(flags);
 }
 
@@ -636,6 +641,7 @@
 			l &= ~MSR_IA32_APICBASE_BASE;
 			l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
 			wrmsr(MSR_IA32_APICBASE, l, h);
+			enabled_via_apicbase = 1;
 		}
 	}
 	/*
--- linux-2.4.22-rc2/arch/i386/kernel/process.c.~1~	2003-08-11 21:27:40.000000000 +0200
+++ linux-2.4.22-rc2/arch/i386/kernel/process.c	2003-08-11 23:11:44.000000000 +0200
@@ -47,6 +47,7 @@
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
+#include <asm/apic.h>
 
 #include <linux/irq.h>
 
@@ -399,6 +400,14 @@
 	 * other OSs see a clean IRQ state.
 	 */
 	smp_send_stop();
+#elif CONFIG_X86_LOCAL_APIC
+	if (cpu_has_apic) {
+		__cli();
+		disable_local_APIC();
+		__sti();
+	}
+#endif
+#ifdef CONFIG_X86_IO_APIC
 	disable_IO_APIC();
 #endif
 
