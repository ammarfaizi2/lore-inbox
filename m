Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTJDBHs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 21:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbTJDBHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 21:07:48 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:61666 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261692AbTJDBHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 21:07:44 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Dynamic irq_vector allocation for 2.6.0-test6-mm
Date: Fri, 3 Oct 2003 18:07:20 -0700
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_I1hf/fGsXuQBYK3"
Message-Id: <200310031807.20650.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_I1hf/fGsXuQBYK3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

irq_vector is indexed by a value that can be as large as the sum of all the 
RTEs in all the I/O APICs.  On a 32-way x445 or a 16-way x440 with PCI 
expansion boxes, the static array will overflow.

Type changed to u8 because that's how big a vector number is.  That should 
please the embedded folks.

Because the fixmaps for I/O APICs aren't ready, I had to map them myself.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
--Boundary-00=_I1hf/fGsXuQBYK3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="dyn_irq_vector_2003-10-01_2.6.0-test6-mm1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dyn_irq_vector_2003-10-01_2.6.0-test6-mm1"

diff -pru 2.6.0-test6-mm1/arch/i386/kernel/io_apic.c k6/arch/i386/kernel/io_apic.c
--- 2.6.0-test6-mm1/arch/i386/kernel/io_apic.c	2003-09-27 17:50:15.000000000 -0700
+++ k6/arch/i386/kernel/io_apic.c	2003-10-01 19:11:13.000000000 -0700
@@ -1138,12 +1138,13 @@ static inline int IO_APIC_irq_trigger(in
 	return 0;
 }
 
-int irq_vector[NR_IRQS] = { FIRST_DEVICE_VECTOR , 0 };
+u8 *irq_vector;
+int nr_irqs;
 
 static int __init assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
-	BUG_ON(irq >= NR_IRQS);
+	BUG_ON(irq >= nr_irqs);
 	if (IO_APIC_VECTOR(irq) > 0)
 		return IO_APIC_VECTOR(irq);
 next:
diff -pru 2.6.0-test6-mm1/arch/i386/kernel/mpparse.c k6/arch/i386/kernel/mpparse.c
--- 2.6.0-test6-mm1/arch/i386/kernel/mpparse.c	2003-09-29 16:42:03.000000000 -0700
+++ k6/arch/i386/kernel/mpparse.c	2003-10-01 19:11:42.000000000 -0700
@@ -616,6 +616,31 @@ static inline void __init construct_defa
 	}
 }
 
+#ifdef CONFIG_X86_IO_APIC
+/* irq_vector must be have an entry for all RTEs of all I/O APICs. */
+void __init alloc_irq_vector_array(void)
+{
+	int	total = 0;
+	int	idx;
+	union IO_APIC_reg_01	reg_01;
+
+	/* The I/O APIC fixmaps aren't inited yet, so use the first one. */
+	for (idx = 0; idx < nr_ioapics; idx++) {
+		set_fixmap_nocache(FIX_IO_APIC_BASE_0, mp_ioapics[idx].mpc_apicaddr);
+		reg_01.raw = io_apic_read(0, 1);
+		total += reg_01.bits.entries + 1;
+	}
+
+	/* Always alloc at least NR_IRQS vectors. */
+	nr_irqs = max(total, NR_IRQS);
+	irq_vector = (u8 *) alloc_bootmem(nr_irqs);
+	memset(irq_vector, 0, nr_irqs);
+	irq_vector[0] = FIRST_DEVICE_VECTOR;
+}
+#else
+void __init alloc_irq_vector_array(void) { }
+#endif /* CONFIG_X86_IO_APIC */
+
 static struct intel_mp_floating *mpf_found;
 
 /*
@@ -633,6 +658,7 @@ void __init get_smp_config (void)
 	 */
 	if (acpi_lapic && acpi_ioapic) {
 		printk(KERN_INFO "Using ACPI (MADT) for SMP configuration information\n");
+		alloc_irq_vector_array();
 		return;
 	}
 	else if (acpi_lapic)
@@ -665,6 +691,7 @@ void __init get_smp_config (void)
 			smp_found_config = 0;
 			printk(KERN_ERR "BIOS bug, MP table errors detected!...\n");
 			printk(KERN_ERR "... disabling SMP support. (tell your hw vendor)\n");
+			alloc_irq_vector_array();
 			return;
 		}
 		/*
@@ -688,6 +715,7 @@ void __init get_smp_config (void)
 	} else
 		BUG();
 
+	alloc_irq_vector_array();
 	printk(KERN_INFO "Processors: %d\n", num_processors);
 	/*
 	 * Only use the first configuration found.
diff -pru 2.6.0-test6-mm1/include/asm-i386/hw_irq.h k6/include/asm-i386/hw_irq.h
--- 2.6.0-test6-mm1/include/asm-i386/hw_irq.h	2003-09-27 17:51:15.000000000 -0700
+++ k6/include/asm-i386/hw_irq.h	2003-09-30 17:06:12.000000000 -0700
@@ -25,8 +25,9 @@
  * Interrupt entry/exit code at both C and assembly level
  */
 
-extern int irq_vector[NR_IRQS];
-#define IO_APIC_VECTOR(irq)	irq_vector[irq]
+extern u8 *irq_vector;
+#define IO_APIC_VECTOR(irq)	((int)irq_vector[(irq)])
+extern int nr_irqs;
 
 extern void (*interrupt[NR_IRQS])(void);
 

--Boundary-00=_I1hf/fGsXuQBYK3--

