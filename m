Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTKZGOZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 01:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbTKZGOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 01:14:25 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:10883
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263980AbTKZGOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 01:14:23 -0500
Date: Wed, 26 Nov 2003 01:13:00 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6-mm] i386 IOAPIC/MSI compile fixes for NR_CPUS > 32
Message-ID: <Pine.LNX.4.58.0311260104220.16692@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/io_apic.c: In function `set_ioapic_affinity_vector':
arch/i386/kernel/io_apic.c:1959: incompatible type for argument 2 of `set_ioapic_affinity_irq'
arch/i386/kernel/io_apic.c: At top level:
arch/i386/kernel/io_apic.c:1979: warning: initialization from incompatible pointer type
arch/i386/kernel/io_apic.c:1990: warning: initialization from incompatible pointer type
  CC      drivers/acpi/acpi_ksyms.o
make[1]: *** [arch/i386/kernel/io_apic.o] Error 1

rivers/pci/msi.c: In function `set_msi_affinity':
drivers/pci/msi.c:115: incompatible type for argument 1 of `cpu_mask_to_apicid'
drivers/pci/msi.c:117: incompatible type for argument 1 of `cpu_mask_to_apicid'
drivers/pci/msi.c:131: incompatible type for argument 1 of `cpu_mask_to_apicid'
drivers/pci/msi.c:133: incompatible type for argument 1 of `cpu_mask_to_apicid'
drivers/pci/msi.c: In function `move_msi':
drivers/pci/msi.c:144: wrong type argument to unary exclamation mark
drivers/pci/msi.c:145: incompatible type for argument 2 of `set_msi_affinity'
drivers/pci/msi.c:146: incompatible types in assignment
drivers/pci/msi.c: At top level:
drivers/pci/msi.c:213: warning: initialization from incompatible pointer type
drivers/pci/msi.c:229: warning: initialization from incompatible pointer type
drivers/pci/msi.c:245: warning: initialization from incompatible pointer type

Index: linux-2.6.0-test10-mm1/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test10-mm1/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.6.0-test10-mm1/arch/i386/kernel/io_apic.c	26 Nov 2003 05:28:50 -0000	1.1.1.1
+++ linux-2.6.0-test10-mm1/arch/i386/kernel/io_apic.c	26 Nov 2003 05:43:43 -0000
@@ -1952,7 +1952,7 @@ static void unmask_IO_APIC_vector (unsig
 }

 static void set_ioapic_affinity_vector (unsigned int vector,
-					unsigned long cpu_mask)
+					cpumask_t cpu_mask)
 {
 	int irq = vector_to_irq(vector);

Index: linux-2.6.0-test10-mm1/drivers/pci/msi.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test10-mm1/drivers/pci/msi.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 msi.c
--- linux-2.6.0-test10-mm1/drivers/pci/msi.c	26 Nov 2003 05:29:13 -0000	1.1.1.1
+++ linux-2.6.0-test10-mm1/drivers/pci/msi.c	26 Nov 2003 06:02:40 -0000
@@ -89,7 +89,7 @@ static void msi_set_mask_bit(unsigned in
 }

 #ifdef CONFIG_SMP
-static void set_msi_affinity(unsigned int vector, unsigned long cpu_mask)
+static void set_msi_affinity(unsigned int vector, cpumask_t cpu_mask)
 {
 	struct msi_desc *entry;
 	struct msg_address address;
@@ -141,9 +141,9 @@ static void set_msi_affinity(unsigned in

 static inline void move_msi(int vector)
 {
-	if (unlikely(pending_irq_balance_cpumask[vector])) {
+	if (!cpus_empty(pending_irq_balance_cpumask[vector])) {
 		set_msi_affinity(vector, pending_irq_balance_cpumask[vector]);
-		pending_irq_balance_cpumask[vector] = 0;
+		cpus_clear(pending_irq_balance_cpumask[vector]);
 	}
 }
 #endif
