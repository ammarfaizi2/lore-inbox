Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274877AbTHKXd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 19:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274888AbTHKXdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 19:33:25 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:32478 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S274877AbTHKXdT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 19:33:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16184.10167.743824.668791@gargle.gargle.HOWL>
Date: Tue, 12 Aug 2003 01:33:11 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: torvalds@transmeta.com, fxkuehl@gmx.de, linux-kernel@vger.kernel.org,
       willy@w.ods.org
Subject: [PATCH][2.6.0-test3] Disable APIC on reboot.
In-Reply-To: <16183.51974.508883.472043@gargle.gargle.HOWL>
References: <E19mCuO-0003dI-00@tetrachloride>
	<16183.50273.723650.136532@gargle.gargle.HOWL>
	<20030811163834.GA21568@redhat.com>
	<16183.51974.508883.472043@gargle.gargle.HOWL>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch for 2.6.0-test3 to disable the local APIC before
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

--- linux-2.6.0-test3/arch/i386/kernel/apic.c.~1~	2003-07-03 12:32:41.000000000 +0200
+++ linux-2.6.0-test3/arch/i386/kernel/apic.c	2003-08-11 23:49:06.000000000 +0200
@@ -61,6 +61,8 @@
 static DEFINE_PER_CPU(int, prof_old_multiplier) = 1;
 static DEFINE_PER_CPU(int, prof_counter) = 1;
 
+static int enabled_via_apicbase;
+
 void enable_NMI_through_LVT0 (void * dummy)
 {
 	unsigned int v, ver;
@@ -190,6 +192,13 @@
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
@@ -485,7 +494,6 @@
 
 static int lapic_suspend(struct sys_device *dev, u32 state)
 {
-	unsigned int l, h;
 	unsigned long flags;
 
 	if (!apic_pm_state.active)
@@ -507,9 +515,6 @@
 	
 	local_irq_save(flags);
 	disable_local_APIC();
-	rdmsr(MSR_IA32_APICBASE, l, h);
-	l &= ~MSR_IA32_APICBASE_ENABLE;
-	wrmsr(MSR_IA32_APICBASE, l, h);
 	local_irq_restore(flags);
 	return 0;
 }
@@ -636,6 +641,7 @@
 			l &= ~MSR_IA32_APICBASE_BASE;
 			l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
 			wrmsr(MSR_IA32_APICBASE, l, h);
+			enabled_via_apicbase = 1;
 		}
 	}
 	/*
--- linux-2.6.0-test3/arch/i386/kernel/reboot.c.~1~	2003-05-28 22:15:58.000000000 +0200
+++ linux-2.6.0-test3/arch/i386/kernel/reboot.c	2003-08-11 23:55:58.000000000 +0200
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <asm/uaccess.h>
+#include <asm/apic.h>
 #include "mach_reboot.h"
 
 /*
@@ -249,6 +250,14 @@
 	 * other OSs see a clean IRQ state.
 	 */
 	smp_send_stop();
+#elif CONFIG_X86_LOCAL_APIC
+	if (cpu_has_apic) {
+		local_irq_disable();
+		disable_local_APIC();
+		local_irq_enable();
+	}
+#endif
+#ifdef CONFIG_X86_IO_APIC
 	disable_IO_APIC();
 #endif
 
