Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbSJMUpu>; Sun, 13 Oct 2002 16:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbSJMUlh>; Sun, 13 Oct 2002 16:41:37 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:31741 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261749AbSJMUkn>;
	Sun, 13 Oct 2002 16:40:43 -0400
Date: Sun, 13 Oct 2002 13:42:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Summit support for 2.5 [2/4]
Message-ID: <39890000.1034541722@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch originally by James Cleverdon

This patch adds APIC support for the Summit chipset, all hidden
under CLUSTERED_APIC_XAPIC. These chips have a different
addressing mode, and a larger broadcast ID. This will change
nothing for normal boxes ....

-------

diff -purN -X /home/mbligh/.diff.exclude summit-1/arch/i386/kernel/apic.c summit-2/arch/i386/kernel/apic.c
--- summit-1/arch/i386/kernel/apic.c	Sun Oct 13 11:10:36 2002
+++ summit-2/arch/i386/kernel/apic.c	Sun Oct 13 11:11:03 2002
@@ -290,6 +290,17 @@ void __init init_bsp_APIC(void)
 	apic_write_around(APIC_LVT1, value);
 }
 
+static inline unsigned long calculate_ldr(unsigned long old)
+{
+	unsigned long id;
+
+	if (clustered_apic_mode == CLUSTERED_APIC_XAPIC)
+		id = xapic_phys_to_log_apicid(hard_smp_processor_id());
+	else 
+		id = 1UL << smp_processor_id();
+	return ((old & ~APIC_LDR_MASK) | SET_APIC_LOGICAL_ID(id));
+}
+
 void __init setup_local_APIC (void)
 {
 	unsigned long value, ver, maxlvt;
@@ -322,21 +333,18 @@ void __init setup_local_APIC (void)
 	 * document number 292116).  So here it goes...
 	 */
 
+	/* For NUMA-Q, the firmware does this for us. */
 	if (clustered_apic_mode != CLUSTERED_APIC_NUMAQ) {
-		/*
-		 * In clustered apic mode, the firmware does this for us 
-		 * Put the APIC into flat delivery mode.
-		 * Must be "all ones" explicitly for 82489DX.
-		 */
-		apic_write_around(APIC_DFR, 0xffffffff);
-
-		/*
-		 * Set up the logical destination ID.
-		 */
+		if (clustered_apic_mode == CLUSTERED_APIC_XAPIC)
+			/* Put the APIC into clustered delivery mode */
+			apic_write_around(APIC_DFR, APIC_DFR_CLUSTER);
+		else
+			/* Put the APIC into flat delivery mode */
+			apic_write_around(APIC_DFR, APIC_DFR_FLAT);
+
+		/* Set up the logical destination ID */
 		value = apic_read(APIC_LDR);
-		value &= ~APIC_LDR_MASK;
-		value |= (1<<(smp_processor_id()+24));
-		apic_write_around(APIC_LDR, value);
+		apic_write_around(APIC_LDR, calculate_ldr(value));
 	}
 
 	/*
diff -purN -X /home/mbligh/.diff.exclude summit-1/arch/i386/kernel/io_apic.c summit-2/arch/i386/kernel/io_apic.c
--- summit-1/arch/i386/kernel/io_apic.c	Sun Oct 13 11:10:36 2002
+++ summit-2/arch/i386/kernel/io_apic.c	Sun Oct 13 11:11:03 2002
@@ -1130,7 +1130,7 @@ static void __init setup_ioapic_ids_from
 	int apic;
 	int i;
 	unsigned char old_id;
-	unsigned long flags;
+	unsigned long flags, apic_broadcast_id;
 
 	if (acpi_ioapic)
 		/* This gets done during IOAPIC enumeration for ACPI. */
@@ -1139,6 +1139,12 @@ static void __init setup_ioapic_ids_from
 	if (clustered_apic_mode)
 		/* We don't have a good way to do this yet - hack */
 		phys_id_present_map = (u_long) 0xf;
+
+	if (clustered_apic_mode == CLUSTERED_APIC_XAPIC)
+		apic_broadcast_id = XAPIC_BROADCAST_ID;
+	else
+		apic_broadcast_id = APIC_BROADCAST_ID;
+		
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
 	 */
@@ -1151,7 +1157,7 @@ static void __init setup_ioapic_ids_from
 		
 		old_id = mp_ioapics[apic].mpc_apicid;
 
-		if (mp_ioapics[apic].mpc_apicid >= 0xf) {
+		if (mp_ioapics[apic].mpc_apicid >= apic_broadcast_id) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
@@ -1163,14 +1169,16 @@ static void __init setup_ioapic_ids_from
 		 * Sanity check, is the ID really free? Every APIC in a
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
+		 * I/O APIC IDs no longer have any meaning for xAPICs.
 		 */
-		if (phys_id_present_map & (1 << mp_ioapics[apic].mpc_apicid)) {
+		if ((clustered_apic_mode != CLUSTERED_APIC_XAPIC) &&
+		    (phys_id_present_map & (1<<mp_ioapics[apic].mpc_apicid))) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			for (i = 0; i < 0xf; i++)
 				if (!(phys_id_present_map & (1 << i)))
 					break;
-			if (i >= 0xf)
+			if (i >= apic_broadcast_id)
 				panic("Max APIC ID exceeded!\n");
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
 				i);
diff -purN -X /home/mbligh/.diff.exclude summit-1/include/asm-i386/apicdef.h summit-2/include/asm-i386/apicdef.h
--- summit-1/include/asm-i386/apicdef.h	Fri Oct 11 21:22:09 2002
+++ summit-2/include/asm-i386/apicdef.h	Sun Oct 13 11:11:03 2002
@@ -32,6 +32,8 @@
 #define			SET_APIC_LOGICAL_ID(x)	(((x)<<24))
 #define			APIC_ALL_CPUS		0xFF
 #define		APIC_DFR	0xE0
+#define			APIC_DFR_CLUSTER		0x0FFFFFFFul
+#define			APIC_DFR_FLAT			0xFFFFFFFFul
 #define		APIC_SPIV	0xF0
 #define			APIC_SPIV_FOCUS_DISABLED	(1<<9)
 #define			APIC_SPIV_APIC_ENABLED		(1<<8)
@@ -108,7 +110,14 @@
 
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
 
-#define MAX_IO_APICS 8
+#ifdef CONFIG_X86_SUMMIT
+ #define MAX_IO_APICS 32	/* Summit boxes can have 4*(2+3*2) I/O APICs */
+#else
+ #define MAX_IO_APICS 8
+#endif
+
+#define APIC_BROADCAST_ID	0x0F
+#define XAPIC_BROADCAST_ID	0xFF
 
 /*
  * the local APIC register structure, memory mapped. Not terribly well
diff -purN -X /home/mbligh/.diff.exclude summit-1/include/asm-i386/smp.h summit-2/include/asm-i386/smp.h
--- summit-1/include/asm-i386/smp.h	Sun Oct 13 11:10:36 2002
+++ summit-2/include/asm-i386/smp.h	Sun Oct 13 11:19:40 2002
@@ -38,6 +38,12 @@
 #define CLUSTERED_APIC_NUMAQ	0x01
 #define CLUSTERED_APIC_XAPIC	0x02
 
+#define XAPIC_DEST_CPUS_MASK    0x0Fu
+#define XAPIC_DEST_CLUSTER_MASK 0xF0u
+
+#define xapic_phys_to_log_apicid(phys_apic) ( (1ul << ((phys_apic) & 0x3)) |\
+		((phys_apic) & XAPIC_DEST_CLUSTER_MASK) )
+
 /* 
  * The following makes all the clustered apic mode switches optimise out at 
  * compile time for all systems except summit
@@ -52,11 +58,12 @@
  #define clustered_apic_mode (0)
 #endif /* CONFIG_CLUSTERED_APIC */
 
+#ifndef __ASSEMBLY__
+
 extern int clustered_apic;
 extern int esr_disable;
 
 #ifdef CONFIG_SMP
-#ifndef __ASSEMBLY__
 
 /*
  * Private routines/data

