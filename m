Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261570AbSJQAmH>; Wed, 16 Oct 2002 20:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSJQAmH>; Wed, 16 Oct 2002 20:42:07 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:50357 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261570AbSJQAmB>;
	Wed, 16 Oct 2002 20:42:01 -0400
Subject: [PATCH] linux-2.4.20-pre11_summit_A0 (2/3 - XAPIC code)
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, James <jamesclv@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <1034813105.19094.244.camel@cog>
References: <1034809328.19981.219.camel@cog> 
	<1034813105.19094.244.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Oct 2002 17:39:52 -0700
Message-Id: <1034815192.19093.252.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, all, 
	Part 2 of James Cleverdon's clustered apic changes for summit. This is
the core addition of code to make summit work. Since nothing sets
clustered_apic_mode to CLUSTERED_APIC_XAPIC yet, this patch shouldn't
affect anything. 

please consider for inclusion.

thanks
-john

diff -Nru a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	Wed Oct 16 17:38:49 2002
+++ b/arch/i386/kernel/apic.c	Wed Oct 16 17:38:49 2002
@@ -264,8 +264,10 @@
 static unsigned long calculate_ldr(unsigned long old)
 {
 	unsigned long id;
-	
-	id = 1UL << smp_processor_id();
+	if(clustered_apic_mode == CLUSTERED_APIC_XAPIC)
+		id = physical_to_logical_apicid(hard_smp_processor_id());
+	else
+		id = 1UL << smp_processor_id();
 	return (old & ~APIC_LDR_MASK)|SET_APIC_LOGICAL_ID(id);
 }
 
@@ -306,7 +308,10 @@
 		 * for us. Otherwise put the APIC into clustered or flat
 		 * delivery mode. Must be "all ones" explicitly for 82489DX.
 		 */
-		apic_write_around(APIC_DFR, APIC_DFR_FLAT);
+		if(clustered_apic_mode == CLUSTERED_APIC_XAPIC)
+			apic_write_around(APIC_DFR, APIC_DFR_CLUSTER);
+		else
+			apic_write_around(APIC_DFR, APIC_DFR_FLAT);
 
 		/*
 		 * Set up the logical destination ID.
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Wed Oct 16 17:38:49 2002
+++ b/arch/i386/kernel/io_apic.c	Wed Oct 16 17:38:49 2002
@@ -1079,8 +1079,10 @@
 		 * Sanity check, is the ID really free? Every APIC in a
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
+		 * I/O APIC IDs no longer have any meaning for xAPICs and SAPICs.
 		 */
-		if (phys_id_present_map & (1 << mp_ioapics[apic].mpc_apicid)) {
+		if ((clustered_apic_mode != CLUSTERED_APIC_XAPIC) &&
+		    (phys_id_present_map & (1 << mp_ioapics[apic].mpc_apicid))) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			for (i = 0; i < 0xf; i++)
diff -Nru a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
--- a/arch/i386/kernel/smp.c	Wed Oct 16 17:38:49 2002
+++ b/arch/i386/kernel/smp.c	Wed Oct 16 17:38:49 2002
@@ -214,7 +214,10 @@
 			/*
 			 * prepare target chip field
 			 */
-			cfg = __prepare_ICR2(cpu_to_logical_apicid(query_cpu));
+			if(clustered_apic_mode == CLUSTERED_APIC_XAPIC)
+				cfg = __prepare_ICR2(cpu_to_physical_apicid(query_cpu));
+			else
+				cfg = __prepare_ICR2(cpu_to_logical_apicid(query_cpu));
 			apic_write_around(APIC_ICR2, cfg);
 		
 			/*
diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Wed Oct 16 17:38:49 2002
+++ b/arch/i386/kernel/smpboot.c	Wed Oct 16 17:38:49 2002
@@ -1019,7 +1019,10 @@
 	 * We have the boot CPU online for sure.
 	 */
 	set_bit(0, &cpu_online_map);
-	boot_cpu_logical_apicid = logical_smp_processor_id();
+	if (clustered_apic_mode == CLUSTERED_APIC_XAPIC)
+		boot_cpu_logical_apicid = physical_to_logical_apicid(boot_cpu_physical_apicid);
+	else
+		boot_cpu_logical_apicid = logical_smp_processor_id();
 	map_cpu_to_boot_apicid(0, boot_cpu_apicid);
 
 	global_irq_holder = 0;
diff -Nru a/include/asm-i386/apicdef.h b/include/asm-i386/apicdef.h
--- a/include/asm-i386/apicdef.h	Wed Oct 16 17:38:49 2002
+++ b/include/asm-i386/apicdef.h	Wed Oct 16 17:38:49 2002
@@ -32,6 +32,7 @@
 #define			SET_APIC_LOGICAL_ID(x)	(((x)<<24))
 #define			APIC_ALL_CPUS		0xFF
 #define		APIC_DFR	0xE0
+#define			APIC_DFR_CLUSTER	0x0FFFFFFFul	/* Clustered */
 #define			APIC_DFR_FLAT		0xFFFFFFFFul	/* Flat mode */
 #define		APIC_SPIV	0xF0
 #define			APIC_SPIV_FOCUS_DISABLED	(1<<9)
@@ -58,6 +59,7 @@
 #define			APIC_INT_LEVELTRIG	0x08000
 #define			APIC_INT_ASSERT		0x04000
 #define			APIC_ICR_BUSY		0x01000
+#define			APIC_DEST_PHYSICAL	0x00000
 #define			APIC_DEST_LOGICAL	0x00800
 #define			APIC_DM_FIXED		0x00000
 #define			APIC_DM_LOWEST		0x00100
@@ -111,8 +113,10 @@
 #define MAX_IO_APICS 8
 
 /*
- * The broadcast ID is 0xF for old APICs.
+ * The broadcast ID is 0xF for old APICs and 0xFF for xAPICs.  SAPICs
+ * don't broadcast (yet?), but if they did, they might use 0xFFFF.
  */
+#define APIC_BROADCAST_ID_XAPIC (0xFF)
 #define APIC_BROADCAST_ID_APIC  (0x0F)
 
 /*
diff -Nru a/include/asm-i386/smpboot.h b/include/asm-i386/smpboot.h
--- a/include/asm-i386/smpboot.h	Wed Oct 16 17:38:49 2002
+++ b/include/asm-i386/smpboot.h	Wed Oct 16 17:38:49 2002
@@ -56,6 +56,8 @@
  */
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
+	if (clustered_apic_mode == CLUSTERED_APIC_XAPIC)
+		return raw_phys_apicid[mps_cpu];
 	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
 		return (mps_cpu/4)*16 + (1<<(mps_cpu%4));
 	return mps_cpu;


