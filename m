Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbTIRCdL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 22:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbTIRCdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 22:33:11 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:28650 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262938AbTIRCc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 22:32:57 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [2.6 PATCH]
Date: Wed, 17 Sep 2003 19:32:39 -0700
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MlRa/ldciSYgtaj"
Message-Id: <200309171932.44779.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_MlRa/ldciSYgtaj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

32-way IBM x445s will have I/O xAPICs with IDs greater than 0xF (0x8 to 0xE 
isn't enough).  This breaks the code in setup_ioapic_ids_from_mpc.  However, 
the entire unique ID check is unnecessary.  Only I/O APICs using the serial 
APIC bus need the unique numbers.  Those sending messages through the system 
bus simply don't use them.



diff -pru linux-2.6.0-test5/arch/i386/kernel/io_apic.c 
u5/arch/i386/kernel/io_apic.c
--- linux-2.6.0-test5/arch/i386/kernel/io_apic.c	2003-09-11 12:08:14.000000000 
-0700
+++ u5/arch/i386/kernel/io_apic.c	2003-09-15 18:43:02.000000000 -0700
@@ -1653,6 +1653,10 @@ static void __init setup_ioapic_ids_from
 			mp_ioapics[apic].mpc_apicid = reg_00.bits.ID;
 		}
 
+		/* Don't check I/O APIC IDs for some xAPIC systems.  They have
+		 * no meaning without the serial APIC bus. */
+		if (NO_IOAPIC_CHECK)
+			continue;
 		/*
 		 * Sanity check, is the ID really free? Every APIC in a
 		 * system must have a unique ID or we get lots of nice
diff -pru linux-2.6.0-test5/include/asm-i386/genapic.h 
u5/include/asm-i386/genapic.h
--- linux-2.6.0-test5/include/asm-i386/genapic.h	2003-09-08 12:50:07.000000000 
-0700
+++ u5/include/asm-i386/genapic.h	2003-09-15 18:39:09.000000000 -0700
@@ -30,6 +30,7 @@ struct genapic { 
 	unsigned long (*check_apicid_used)(physid_mask_t bitmap, int apicid);
 	unsigned long (*check_apicid_present)(int apicid); 
 	int no_balance_irq;
+	int no_ioapic_check;
 	void (*init_apic_ldr)(void);
 	physid_mask_t (*ioapic_phys_id_map)(physid_mask_t map);
 
@@ -77,6 +78,7 @@ struct genapic { 
 	.int_dest_mode = INT_DEST_MODE, \
 	.apic_broadcast_id = APIC_BROADCAST_ID, \
 	.no_balance_irq = NO_BALANCE_IRQ, \
+	.no_ioapic_check = NO_IOAPIC_CHECK, \
 	APICFUNC(apic_id_registered), \
 	APICFUNC(target_cpus), \
 	APICFUNC(check_apicid_used), \
diff -pru linux-2.6.0-test5/include/asm-i386/mach-bigsmp/mach_apic.h 
u5/include/asm-i386/mach-bigsmp/mach_apic.h
--- linux-2.6.0-test5/include/asm-i386/mach-bigsmp/mach_apic.h	2003-09-08 
12:50:29.000000000 -0700
+++ u5/include/asm-i386/mach-bigsmp/mach_apic.h	2003-09-15 18:39:09.000000000 
-0700
@@ -14,6 +14,8 @@
 #define NO_BALANCE_IRQ (1)
 #define esr_disable (1)
 
+#define NO_IOAPIC_CHECK (0)
+
 static inline int apic_id_registered(void)
 {
 	return (1);
diff -pru linux-2.6.0-test5/include/asm-i386/mach-default/mach_apic.h 
u5/include/asm-i386/mach-default/mach_apic.h
--- linux-2.6.0-test5/include/asm-i386/mach-default/mach_apic.h	2003-09-08 
12:50:48.000000000 -0700
+++ u5/include/asm-i386/mach-default/mach_apic.h	2003-09-15 18:39:09.000000000 
-0700
@@ -18,6 +18,8 @@ static inline cpumask_t target_cpus(void
 #define NO_BALANCE_IRQ (0)
 #define esr_disable (0)
 
+#define NO_IOAPIC_CHECK (0)
+
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
diff -pru linux-2.6.0-test5/include/asm-i386/mach-generic/mach_apic.h 
u5/include/asm-i386/mach-generic/mach_apic.h
--- linux-2.6.0-test5/include/asm-i386/mach-generic/mach_apic.h	2003-09-08 
12:50:01.000000000 -0700
+++ u5/include/asm-i386/mach-generic/mach_apic.h	2003-09-15 18:39:09.000000000 
-0700
@@ -5,6 +5,7 @@
 
 #define esr_disable (genapic->esr_disable)
 #define NO_BALANCE_IRQ (genapic->no_balance_irq)
+#define NO_IOAPIC_CHECK	(genapic->no_ioapic_check)
 #define APIC_BROADCAST_ID (genapic->apic_broadcast_id)
 #define INT_DELIVERY_MODE (genapic->int_delivery_mode)
 #define INT_DEST_MODE (genapic->int_dest_mode)
diff -pru linux-2.6.0-test5/include/asm-i386/mach-numaq/mach_apic.h 
u5/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.6.0-test5/include/asm-i386/mach-numaq/mach_apic.h	2003-09-08 
12:50:02.000000000 -0700
+++ u5/include/asm-i386/mach-numaq/mach_apic.h	2003-09-15 18:39:09.000000000 
-0700
@@ -17,6 +17,8 @@ static inline cpumask_t target_cpus(void
 #define NO_BALANCE_IRQ (1)
 #define esr_disable (1)
 
+#define NO_IOAPIC_CHECK (0)
+
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 0     /* physical delivery on LOCAL quad */
  
diff -pru linux-2.6.0-test5/include/asm-i386/mach-summit/mach_apic.h 
u5/include/asm-i386/mach-summit/mach_apic.h
--- linux-2.6.0-test5/include/asm-i386/mach-summit/mach_apic.h	2003-09-11 
16:48:00.000000000 -0700
+++ u5/include/asm-i386/mach-summit/mach_apic.h	2003-09-15 18:40:53.000000000 
-0700
@@ -7,6 +7,8 @@
 #define esr_disable (1)
 #define NO_BALANCE_IRQ (0)
 
+#define NO_IOAPIC_CHECK (1)	/* Don't check I/O APIC ID for xAPIC */
+
 /* In clustered mode, the high nibble of APIC ID is a cluster number.
  * The low nibble is a 4-bit bitmap. */
 #define XAPIC_DEST_CPUS_SHIFT	4
diff -pru linux-2.6.0-test5/include/asm-i386/mach-visws/mach_apic.h 
u5/include/asm-i386/mach-visws/mach_apic.h
--- linux-2.6.0-test5/include/asm-i386/mach-visws/mach_apic.h	2003-09-08 
12:49:51.000000000 -0700
+++ u5/include/asm-i386/mach-visws/mach_apic.h	2003-09-15 18:39:09.000000000 
-0700
@@ -8,6 +8,8 @@
 #define no_balance_irq (0)
 #define esr_disable (0)
 
+#define NO_IOAPIC_CHECK (0)
+
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 

--Boundary-00=_MlRa/ldciSYgtaj
Content-Type: text/x-diff;
  charset="us-ascii";
  name="x445_no_io_xapic_check_2003-09-17_2.6.0-test5"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="x445_no_io_xapic_check_2003-09-17_2.6.0-test5"

diff -pru linux-2.6.0-test5/arch/i386/kernel/io_apic.c u5/arch/i386/kernel/io_apic.c
--- linux-2.6.0-test5/arch/i386/kernel/io_apic.c	2003-09-11 12:08:14.000000000 -0700
+++ u5/arch/i386/kernel/io_apic.c	2003-09-15 18:43:02.000000000 -0700
@@ -1653,6 +1653,10 @@ static void __init setup_ioapic_ids_from
 			mp_ioapics[apic].mpc_apicid = reg_00.bits.ID;
 		}
 
+		/* Don't check I/O APIC IDs for some xAPIC systems.  They have
+		 * no meaning without the serial APIC bus. */
+		if (NO_IOAPIC_CHECK)
+			continue;
 		/*
 		 * Sanity check, is the ID really free? Every APIC in a
 		 * system must have a unique ID or we get lots of nice
diff -pru linux-2.6.0-test5/include/asm-i386/genapic.h u5/include/asm-i386/genapic.h
--- linux-2.6.0-test5/include/asm-i386/genapic.h	2003-09-08 12:50:07.000000000 -0700
+++ u5/include/asm-i386/genapic.h	2003-09-15 18:39:09.000000000 -0700
@@ -30,6 +30,7 @@ struct genapic { 
 	unsigned long (*check_apicid_used)(physid_mask_t bitmap, int apicid);
 	unsigned long (*check_apicid_present)(int apicid); 
 	int no_balance_irq;
+	int no_ioapic_check;
 	void (*init_apic_ldr)(void);
 	physid_mask_t (*ioapic_phys_id_map)(physid_mask_t map);
 
@@ -77,6 +78,7 @@ struct genapic { 
 	.int_dest_mode = INT_DEST_MODE, \
 	.apic_broadcast_id = APIC_BROADCAST_ID, \
 	.no_balance_irq = NO_BALANCE_IRQ, \
+	.no_ioapic_check = NO_IOAPIC_CHECK, \
 	APICFUNC(apic_id_registered), \
 	APICFUNC(target_cpus), \
 	APICFUNC(check_apicid_used), \
diff -pru linux-2.6.0-test5/include/asm-i386/mach-bigsmp/mach_apic.h u5/include/asm-i386/mach-bigsmp/mach_apic.h
--- linux-2.6.0-test5/include/asm-i386/mach-bigsmp/mach_apic.h	2003-09-08 12:50:29.000000000 -0700
+++ u5/include/asm-i386/mach-bigsmp/mach_apic.h	2003-09-15 18:39:09.000000000 -0700
@@ -14,6 +14,8 @@
 #define NO_BALANCE_IRQ (1)
 #define esr_disable (1)
 
+#define NO_IOAPIC_CHECK (0)
+
 static inline int apic_id_registered(void)
 {
 	return (1);
diff -pru linux-2.6.0-test5/include/asm-i386/mach-default/mach_apic.h u5/include/asm-i386/mach-default/mach_apic.h
--- linux-2.6.0-test5/include/asm-i386/mach-default/mach_apic.h	2003-09-08 12:50:48.000000000 -0700
+++ u5/include/asm-i386/mach-default/mach_apic.h	2003-09-15 18:39:09.000000000 -0700
@@ -18,6 +18,8 @@ static inline cpumask_t target_cpus(void
 #define NO_BALANCE_IRQ (0)
 #define esr_disable (0)
 
+#define NO_IOAPIC_CHECK (0)
+
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
diff -pru linux-2.6.0-test5/include/asm-i386/mach-generic/mach_apic.h u5/include/asm-i386/mach-generic/mach_apic.h
--- linux-2.6.0-test5/include/asm-i386/mach-generic/mach_apic.h	2003-09-08 12:50:01.000000000 -0700
+++ u5/include/asm-i386/mach-generic/mach_apic.h	2003-09-15 18:39:09.000000000 -0700
@@ -5,6 +5,7 @@
 
 #define esr_disable (genapic->esr_disable)
 #define NO_BALANCE_IRQ (genapic->no_balance_irq)
+#define NO_IOAPIC_CHECK	(genapic->no_ioapic_check)
 #define APIC_BROADCAST_ID (genapic->apic_broadcast_id)
 #define INT_DELIVERY_MODE (genapic->int_delivery_mode)
 #define INT_DEST_MODE (genapic->int_dest_mode)
diff -pru linux-2.6.0-test5/include/asm-i386/mach-numaq/mach_apic.h u5/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.6.0-test5/include/asm-i386/mach-numaq/mach_apic.h	2003-09-08 12:50:02.000000000 -0700
+++ u5/include/asm-i386/mach-numaq/mach_apic.h	2003-09-15 18:39:09.000000000 -0700
@@ -17,6 +17,8 @@ static inline cpumask_t target_cpus(void
 #define NO_BALANCE_IRQ (1)
 #define esr_disable (1)
 
+#define NO_IOAPIC_CHECK (0)
+
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 0     /* physical delivery on LOCAL quad */
  
diff -pru linux-2.6.0-test5/include/asm-i386/mach-summit/mach_apic.h u5/include/asm-i386/mach-summit/mach_apic.h
--- linux-2.6.0-test5/include/asm-i386/mach-summit/mach_apic.h	2003-09-11 16:48:00.000000000 -0700
+++ u5/include/asm-i386/mach-summit/mach_apic.h	2003-09-15 18:40:53.000000000 -0700
@@ -7,6 +7,8 @@
 #define esr_disable (1)
 #define NO_BALANCE_IRQ (0)
 
+#define NO_IOAPIC_CHECK (1)	/* Don't check I/O APIC ID for xAPIC */
+
 /* In clustered mode, the high nibble of APIC ID is a cluster number.
  * The low nibble is a 4-bit bitmap. */
 #define XAPIC_DEST_CPUS_SHIFT	4
diff -pru linux-2.6.0-test5/include/asm-i386/mach-visws/mach_apic.h u5/include/asm-i386/mach-visws/mach_apic.h
--- linux-2.6.0-test5/include/asm-i386/mach-visws/mach_apic.h	2003-09-08 12:49:51.000000000 -0700
+++ u5/include/asm-i386/mach-visws/mach_apic.h	2003-09-15 18:39:09.000000000 -0700
@@ -8,6 +8,8 @@
 #define no_balance_irq (0)
 #define esr_disable (0)
 
+#define NO_IOAPIC_CHECK (0)
+
 #define INT_DELIVERY_MODE dest_LowestPrio
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 

--Boundary-00=_MlRa/ldciSYgtaj--

