Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbSLCA72>; Mon, 2 Dec 2002 19:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbSLCA72>; Mon, 2 Dec 2002 19:59:28 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:30929 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265854AbSLCA7X>;
	Mon, 2 Dec 2002 19:59:23 -0500
Subject: [PATCH] linux-2.4.20_summit_A0 (2/4)
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, James <jamesclv@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <1038877322.6884.24.camel@w-jstultz2.beaverton.ibm.com>
References: <1038877250.6884.21.camel@w-jstultz2.beaverton.ibm.com>
	 <1038877322.6884.24.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1038877399.6878.27.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 17:03:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
	2/4: Logical/Physical apicid additions

Please apply.

Thanks
-john

diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Mon Dec  2 11:45:12 2002
+++ b/arch/i386/kernel/mpparse.c	Mon Dec  2 11:45:12 2002
@@ -65,9 +65,12 @@
 
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
+unsigned long logical_cpu_present_map;
 
 unsigned char esr_disable = 0;
 
+unsigned char raw_phys_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+
 /*
  * Intel MP BIOS table parsing routines:
  */
@@ -231,11 +234,9 @@
 	}
 	ver = m->mpc_apicver;
 
-	if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ) {
-		phys_cpu_present_map |= (logical_apicid&0xf) << (4*quad);
-	} else {
-		phys_cpu_present_map |= 1 << m->mpc_apicid;
-	}
+	logical_cpu_present_map |= 1 << (num_processors-1);
+ 	phys_cpu_present_map |= apicid_to_phys_cpu_present(m->mpc_apicid);
+ 
 	/*
 	 * Validate version
 	 */
@@ -244,6 +245,7 @@
 		ver = 0x10;
 	}
 	apic_version[m->mpc_apicid] = ver;
+	raw_phys_apicid[num_processors - 1] = m->mpc_apicid;
 }
 
 static void __init MP_bus_info (struct mpc_config_bus *m)
@@ -511,6 +513,7 @@
 
 	if (clustered_apic_mode){
 		esr_disable = 1;
+		phys_cpu_present_map = logical_cpu_present_map;
 	}
 
 	if (!num_processors)
diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Mon Dec  2 11:45:12 2002
+++ b/arch/i386/kernel/smpboot.c	Mon Dec  2 11:45:12 2002
@@ -525,12 +525,12 @@
 	int apicid, cpu;
 
 	for (apicid = 0; apicid < MAX_APICID; apicid++) {
-		physical_apicid_2_cpu[apicid] = -1;
-		logical_apicid_2_cpu[apicid] = -1;
+		physical_apicid_2_cpu[apicid] = BAD_APICID;
+		logical_apicid_2_cpu[apicid] = BAD_APICID;
 	}
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		cpu_2_physical_apicid[cpu] = -1;
-		cpu_2_logical_apicid[cpu] = -1;
+		cpu_2_physical_apicid[cpu] = BAD_APICID;
+		cpu_2_logical_apicid[cpu] = BAD_APICID;
 	}
 }
 
@@ -540,7 +540,7 @@
  * else physical apic ids
  */
 {
-	if (clustered_apic_mode) {
+	if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ) {
 		logical_apicid_2_cpu[apicid] = cpu;	
 		cpu_2_logical_apicid[cpu] = apicid;
 	} else {
@@ -555,12 +555,12 @@
  * else physical apic ids
  */
 {
-	if (clustered_apic_mode) {
-		logical_apicid_2_cpu[apicid] = -1;	
-		cpu_2_logical_apicid[cpu] = -1;
+	if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ) {
+		logical_apicid_2_cpu[apicid] = BAD_APICID;
+		cpu_2_logical_apicid[cpu] = BAD_APICID;
 	} else {
-		physical_apicid_2_cpu[apicid] = -1;	
-		cpu_2_physical_apicid[cpu] = -1;
+		physical_apicid_2_cpu[apicid] = BAD_APICID;
+		cpu_2_physical_apicid[cpu] = BAD_APICID;
 	}
 }
 
@@ -785,7 +785,7 @@
 	unsigned long boot_error = 0;
 	int timeout, cpu;
 	unsigned long start_eip;
-	unsigned short nmi_high, nmi_low;
+	unsigned short nmi_high = 0, nmi_low = 0;
 
 	cpu = ++cpucount;
 	/*
@@ -1111,7 +1111,7 @@
 		if (apicid == boot_cpu_apicid)
 			continue;
 
-		if (!(phys_cpu_present_map & (1 << bit)))
+		if (!(phys_cpu_present_map & (1ul << bit)))
 			continue;
 		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
 			continue;
@@ -1122,9 +1122,9 @@
 		 * Make sure we unmap all failed CPUs
 		 */
 		if ((boot_apicid_to_cpu(apicid) == -1) &&
-				(phys_cpu_present_map & (1 << bit)))
-			printk("CPU #%d not responding - cannot use it.\n",
-								apicid);
+				(phys_cpu_present_map & (1ul << bit)))
+			printk("CPU #%d/0x%02x not responding - cannot use it.\n",
+								bit, apicid);
 	}
 
 	/*
diff -Nru a/include/asm-i386/smpboot.h b/include/asm-i386/smpboot.h
--- a/include/asm-i386/smpboot.h	Mon Dec  2 11:45:12 2002
+++ b/include/asm-i386/smpboot.h	Mon Dec  2 11:45:12 2002
@@ -42,13 +42,15 @@
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #define apic_broadcast_id (APIC_BROADCAST_ID_APIC)
-
+#define BAD_APICID 0xFFu
 
 #define TRAMPOLINE_LOW phys_to_virt((clustered_apic_mode == CLUSTERED_APIC_NUMAQ)?0x8:0x467)
 #define TRAMPOLINE_HIGH phys_to_virt((clustered_apic_mode == CLUSTERED_APIC_NUMAQ)?0xa:0x469)
 
 #define boot_cpu_apicid ((clustered_apic_mode == CLUSTERED_APIC_NUMAQ)?boot_cpu_logical_apicid:boot_cpu_physical_apicid)
 
+extern unsigned char raw_phys_apicid[NR_CPUS];
+
 /*
  * How to map from the cpu_present_map
  */
@@ -57,6 +59,13 @@
 	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
 		return (mps_cpu/4)*16 + (1<<(mps_cpu%4));
 	return mps_cpu;
+}
+
+static inline unsigned long apicid_to_phys_cpu_present(int apicid)
+{
+	if(clustered_apic_mode)
+		return 1UL << (((apicid >> 4) << 2) + (apicid & 0x3));
+	return 1UL << apicid;
 }
 
 #define physical_to_logical_apicid(phys_apic) ( (1ul << (phys_apic & 0x3)) | (phys_apic & 0xF0u) )



