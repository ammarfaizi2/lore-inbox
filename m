Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266494AbUG0RxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266494AbUG0RxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266496AbUG0RxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:53:19 -0400
Received: from aun.it.uu.se ([130.238.12.36]:9623 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266494AbUG0RxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:53:09 -0400
Date: Tue, 27 Jul 2004 19:53:01 +0200 (MEST)
Message-Id: <200407271753.i6RHr13I013000@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc1-mm1] decode local APIC errors
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got tired of having to manually decode local APIC
error codes in problem reports sent to LKML, so I
rewrote arch/i386/kernel/apic:smp_error_interrupt()
to do the decoding for us. Instead of:

APIC error on CPU0: 04(00)

this patch makes the kernel print:

APIC error on CPU0: Send Accept Error (0x00)

The code handles multiple set error flags, and will
also report if any unknown or reserved bits are set.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -ruN linux-2.6.8-rc1-mm1/arch/i386/kernel/apic.c linux-2.6.8-rc1-mm1.apic-esr-decode/arch/i386/kernel/apic.c
--- linux-2.6.8-rc1-mm1/arch/i386/kernel/apic.c	2004-07-27 12:55:04.000000000 +0200
+++ linux-2.6.8-rc1-mm1.apic-esr-decode/arch/i386/kernel/apic.c	2004-07-27 15:44:43.000000000 +0200
@@ -1137,6 +1137,35 @@
  * This interrupt should never happen with our APIC/SMP architecture
  */
 
+static void print_esr_value(unsigned long esr_value)
+{
+	static const char *esr_strings[] = {
+		[0] "Send Checksum Error",
+		[1] "Receive Checksum Error",
+		[2] "Send Accept Error",
+		[3] "Receive Accept Error",
+		[4] NULL,
+		[5] "Send Illegal Vector",
+		[6] "Received Illegal Vector",
+		[7] "Illegal Register Address",
+	};
+	unsigned int i;
+	char *sep;
+
+	if (!esr_value) {
+		printk("0x00");
+		return;
+	}
+	for(sep = "", i = 0; i < ARRAY_SIZE(esr_strings); ++i)
+		if ((esr_value & (1<<i)) && esr_strings[i]) {
+			esr_value &= ~(1<<i);
+			printk("%s%s", sep, esr_strings[i]);
+			sep = " + ";
+		}
+	if (esr_value)
+		printk("%s0x%02lx", sep, esr_value);
+}
+
 asmlinkage void smp_error_interrupt(void)
 {
 	unsigned long v, v1;
@@ -1149,18 +1178,11 @@
 	ack_APIC_irq();
 	atomic_inc(&irq_err_count);
 
-	/* Here is what the APIC error bits mean:
-	   0: Send CS error
-	   1: Receive CS error
-	   2: Send accept error
-	   3: Receive accept error
-	   4: Reserved
-	   5: Send illegal vector
-	   6: Received illegal vector
-	   7: Illegal register address
-	*/
-	printk (KERN_INFO "APIC error on CPU%d: %02lx(%02lx)\n",
-	        smp_processor_id(), v , v1);
+	printk(KERN_INFO "APIC error on CPU%d: ", smp_processor_id());
+	print_esr_value(v);
+	printk(" (");
+	print_esr_value(v1);
+	printk(")\n");
 	irq_exit();
 }
 
