Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbTILWY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbTILWY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:24:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:16019 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261766AbTILWYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:24:22 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [2.6 PATCH] i386 Summit sub-arch: Make logical IDs independent of BIOS numbering scheme
Date: Fri, 12 Sep 2003 15:23:57 -0700
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BekY/A/GzZoGS4U"
Message-Id: <200309121524.01391.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_BekY/A/GzZoGS4U
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In forthcoming IBM x445 systems, the physical APIC ID will not follow the 
simple rule laid out by Intel and encoded into xapic_phys_to_log_apicid.  
(The BIOS code that sets IDs doesn't work right above 16 CPUs if HT is turned 
on, so for > 16-way the BIOS will disable HT and repack the physical CPUs 
into APIC clusters.)

Anyway, it's a good idea to make the APIC code more independent of any 
particular BIOS numbering scheme.  This patch allocates logical IDs based on 
how many CPUs have already been onlined in a particular APIC cluster.

----

diff -pru 2.6.0-test5/include/asm-i386/mach-summit/mach_apic.h 
t5/include/asm-i386/mach-summit/mach_apic.h
--- 2.6.0-test5/include/asm-i386/mach-summit/mach_apic.h	2003-09-08 
12:50:08.000000000 -0700
+++ t5/include/asm-i386/mach-summit/mach_apic.h	2003-09-11 16:48:00.000000000 
-0700
@@ -7,14 +7,11 @@
 #define esr_disable (1)
 #define NO_BALANCE_IRQ (0)
 
-#define XAPIC_DEST_CPUS_MASK    0x0Fu
-#define XAPIC_DEST_CLUSTER_MASK 0xF0u
-
-static inline unsigned long xapic_phys_to_log_apicid(int phys_apic) 
-{
-	return ( (1ul << ((phys_apic) & 0x3)) |
-		 ((phys_apic) & XAPIC_DEST_CLUSTER_MASK) );
-}
+/* In clustered mode, the high nibble of APIC ID is a cluster number.
+ * The low nibble is a 4-bit bitmap. */
+#define XAPIC_DEST_CPUS_SHIFT	4
+#define XAPIC_DEST_CPUS_MASK	((1u << XAPIC_DEST_CPUS_SHIFT) - 1)
+#define XAPIC_DEST_CLUSTER_MASK	(XAPIC_DEST_CPUS_MASK << 
XAPIC_DEST_CPUS_SHIFT)
 
 #define APIC_DFR_VALUE	(APIC_DFR_CLUSTER)
 
@@ -40,15 +37,29 @@ static inline unsigned long check_apicid
 	return 1;
 }
 
-#define apicid_cluster(apicid) (apicid & 0xF0)
+#define apicid_cluster(apicid) ((apicid) & XAPIC_DEST_CLUSTER_MASK)
 
 extern u8 bios_cpu_apicid[];
+extern u8 cpu_2_logical_apicid[];
 
 static inline void init_apic_ldr(void)
 {
 	unsigned long val, id;
-
-	id = xapic_phys_to_log_apicid(hard_smp_processor_id());
+	int i, count;
+	u8 lid;
+	u8 my_id = (u8)hard_smp_processor_id();
+	u8 my_cluster = (u8)apicid_cluster(my_id);
+
+	/* Create logical APIC IDs by counting CPUs already in cluster. */
+	for (count = 0, i = NR_CPUS; --i >= 0; ) {
+		lid = cpu_2_logical_apicid[i];
+		if (lid != BAD_APICID && apicid_cluster(lid) == my_cluster)
+			++count;
+	}
+	/* We only have a 4 wide bitmap in cluster mode.  If a deranged
+	 * BIOS puts 5 CPUs in one APIC cluster, we're hosed. */
+	BUG_ON(count >= XAPIC_DEST_CPUS_SHIFT);
+	id = my_cluster | (1UL << count);
 	apic_write_around(APIC_DFR, APIC_DFR_VALUE);
 	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
 	val |= SET_APIC_LOGICAL_ID(id);
@@ -77,7 +88,6 @@ static inline int apicid_to_node(int log
 }
 
 /* Mapping from cpu number to logical apicid */
-extern u8 cpu_2_logical_apicid[];
 static inline int cpu_to_logical_apicid(int cpu)
 {
        if (cpu >= NR_CPUS)


--Boundary-00=_BekY/A/GzZoGS4U
Content-Type: text/x-diff;
  charset="us-ascii";
  name="x445_log_apic_id_fix_2003-09-11_2.6.0-test5"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="x445_log_apic_id_fix_2003-09-11_2.6.0-test5"

diff -pru 2.6.0-test5/include/asm-i386/mach-summit/mach_apic.h t5/include/asm-i386/mach-summit/mach_apic.h
--- 2.6.0-test5/include/asm-i386/mach-summit/mach_apic.h	2003-09-08 12:50:08.000000000 -0700
+++ t5/include/asm-i386/mach-summit/mach_apic.h	2003-09-11 16:48:00.000000000 -0700
@@ -7,14 +7,11 @@
 #define esr_disable (1)
 #define NO_BALANCE_IRQ (0)
 
-#define XAPIC_DEST_CPUS_MASK    0x0Fu
-#define XAPIC_DEST_CLUSTER_MASK 0xF0u
-
-static inline unsigned long xapic_phys_to_log_apicid(int phys_apic) 
-{
-	return ( (1ul << ((phys_apic) & 0x3)) |
-		 ((phys_apic) & XAPIC_DEST_CLUSTER_MASK) );
-}
+/* In clustered mode, the high nibble of APIC ID is a cluster number.
+ * The low nibble is a 4-bit bitmap. */
+#define XAPIC_DEST_CPUS_SHIFT	4
+#define XAPIC_DEST_CPUS_MASK	((1u << XAPIC_DEST_CPUS_SHIFT) - 1)
+#define XAPIC_DEST_CLUSTER_MASK	(XAPIC_DEST_CPUS_MASK << XAPIC_DEST_CPUS_SHIFT)
 
 #define APIC_DFR_VALUE	(APIC_DFR_CLUSTER)
 
@@ -40,15 +37,29 @@ static inline unsigned long check_apicid
 	return 1;
 }
 
-#define apicid_cluster(apicid) (apicid & 0xF0)
+#define apicid_cluster(apicid) ((apicid) & XAPIC_DEST_CLUSTER_MASK)
 
 extern u8 bios_cpu_apicid[];
+extern u8 cpu_2_logical_apicid[];
 
 static inline void init_apic_ldr(void)
 {
 	unsigned long val, id;
-
-	id = xapic_phys_to_log_apicid(hard_smp_processor_id());
+	int i, count;
+	u8 lid;
+	u8 my_id = (u8)hard_smp_processor_id();
+	u8 my_cluster = (u8)apicid_cluster(my_id);
+
+	/* Create logical APIC IDs by counting CPUs already in cluster. */
+	for (count = 0, i = NR_CPUS; --i >= 0; ) {
+		lid = cpu_2_logical_apicid[i];
+		if (lid != BAD_APICID && apicid_cluster(lid) == my_cluster)
+			++count;
+	}
+	/* We only have a 4 wide bitmap in cluster mode.  If a deranged
+	 * BIOS puts 5 CPUs in one APIC cluster, we're hosed. */
+	BUG_ON(count >= XAPIC_DEST_CPUS_SHIFT);
+	id = my_cluster | (1UL << count);
 	apic_write_around(APIC_DFR, APIC_DFR_VALUE);
 	val = apic_read(APIC_LDR) & ~APIC_LDR_MASK;
 	val |= SET_APIC_LOGICAL_ID(id);
@@ -77,7 +88,6 @@ static inline int apicid_to_node(int log
 }
 
 /* Mapping from cpu number to logical apicid */
-extern u8 cpu_2_logical_apicid[];
 static inline int cpu_to_logical_apicid(int cpu)
 {
        if (cpu >= NR_CPUS)

--Boundary-00=_BekY/A/GzZoGS4U--

