Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbSLWGpj>; Mon, 23 Dec 2002 01:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266638AbSLWGpj>; Mon, 23 Dec 2002 01:45:39 -0500
Received: from franka.aracnet.com ([216.99.193.44]:54431 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266637AbSLWGpf>; Mon, 23 Dec 2002 01:45:35 -0500
Date: Sun, 22 Dec 2002 22:53:36 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 5/8 Move NUMA-Q support into subarch
Message-ID: <57350000.1040626416@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of code originally by James Cleverdon.
More stuff reformed in the mpparse sections - this time not apic stuff,
so we create mach_mpparse.h and stick it in there.

Abstracts out:
mpc_oem_bus_info() - stores mappings between buses and nodes/quads.
mpc_oem_pci_bus()  - stores mappings between global and local pci bus numbers

Changes summit_check() into mps_oem_check() to generalise it.


diff -urpN -X /home/fletch/.diff.exclude 13-numaq3/arch/i386/kernel/mpparse.c 14-numaq4/arch/i386/kernel/mpparse.c
--- 13-numaq3/arch/i386/kernel/mpparse.c	Sun Dec 22 12:10:10 2002
+++ 14-numaq4/arch/i386/kernel/mpparse.c	Sun Dec 22 12:10:33 2002
@@ -32,6 +32,7 @@
 #include <asm/io_apic.h>
 
 #include <mach_apic.h>
+#include <mach_mpparse.h>
 
 /* Have we found an MP table */
 int smp_found_config;
@@ -191,28 +192,18 @@ void __init MP_processor_info (struct mp
 static void __init MP_bus_info (struct mpc_config_bus *m)
 {
 	char str[7];
-	int quad;
 
 	memcpy(str, m->mpc_bustype, 6);
 	str[6] = 0;
-	
-	if (clustered_apic_mode) {
-		quad = translation_table[mpc_record]->trans_quad;
-		mp_bus_id_to_node[m->mpc_busid] = quad;
-		mp_bus_id_to_local[m->mpc_busid] = translation_table[mpc_record]->trans_local;
-		printk("Bus #%d is %s (node %d)\n", m->mpc_busid, str, quad);
-	} else {
-		Dprintk("Bus #%d is %s\n", m->mpc_busid, str);
-	}
+
+	mpc_oem_bus_info(m, str, translation_table[mpc_record]);
 
 	if (strncmp(str, BUSTYPE_ISA, sizeof(BUSTYPE_ISA)-1) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_ISA;
 	} else if (strncmp(str, BUSTYPE_EISA, sizeof(BUSTYPE_EISA)-1) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_EISA;
 	} else if (strncmp(str, BUSTYPE_PCI, sizeof(BUSTYPE_PCI)-1) == 0) {
-		if (clustered_apic_mode){
-			quad_local_to_mp_bus_id[quad][translation_table[mpc_record]->trans_local] = m->mpc_busid;
-		}
+		mpc_oem_pci_bus(m, translation_table[mpc_record]);
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_PCI;
 		mp_bus_id_to_pci_bus[m->mpc_busid] = mp_current_pci_id;
 		mp_current_pci_id++;
@@ -300,6 +291,7 @@ static void __init smp_read_mpc_oem(stru
 	int count = sizeof (*oemtable); /* the header size */
 	unsigned char *oemptr = ((unsigned char *)oemtable)+count;
 	
+	mpc_record = 0;
 	printk("Found an OEM MPC table at %8p - parsing it ... \n", oemtable);
 	if (memcmp(oemtable->oem_signature,MPC_OEM_SIGNATURE,4))
 	{
@@ -376,7 +368,7 @@ static int __init smp_read_mpc(struct mp
 	str[12]=0;
 	printk("Product ID: %s ",str);
 
-	summit_check(oem, str);
+	mps_oem_check(mpc, oem, str);
 
 	printk("APIC at: 0x%lX\n",mpc->mpc_lapic);
 
@@ -387,16 +379,10 @@ static int __init smp_read_mpc(struct mp
 	if (!acpi_lapic)
 		mp_lapic_addr = mpc->mpc_lapic;
 
-	if (clustered_apic_mode && mpc->mpc_oemptr) {
-		/* We need to process the oem mpc tables to tell us which quad things are in ... */
-		mpc_record = 0;
-		smp_read_mpc_oem((struct mp_config_oemtable *) mpc->mpc_oemptr, mpc->mpc_oemsize);
-		mpc_record = 0;
-	}
-
 	/*
 	 *	Now process the configuration blocks.
 	 */
+	mpc_record = 0;
 	while (count < mpc->mpc_length) {
 		switch(*mpt) {
 			case MP_PROCESSOR:
diff -urpN -X /home/fletch/.diff.exclude 13-numaq3/include/asm-i386/mach-default/mach_apic.h 14-numaq4/include/asm-i386/mach-default/mach_apic.h
--- 13-numaq3/include/asm-i386/mach-default/mach_apic.h	Sun Dec 22 12:10:10 2002
+++ 14-numaq4/include/asm-i386/mach-default/mach_apic.h	Sun Dec 22 12:10:33 2002
@@ -14,10 +14,6 @@
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
 
-static inline void summit_check(char *oem, char *productid) 
-{
-}
-
 static inline int apic_id_registered(void)
 {
 	return (test_bit(GET_APIC_ID(apic_read(APIC_ID)), 
diff -urpN -X /home/fletch/.diff.exclude 13-numaq3/include/asm-i386/mach-default/mach_mpparse.h 14-numaq4/include/asm-i386/mach-default/mach_mpparse.h
--- 13-numaq3/include/asm-i386/mach-default/mach_mpparse.h	Wed Dec 31 16:00:00 1969
+++ 14-numaq4/include/asm-i386/mach-default/mach_mpparse.h	Sun Dec 22 12:10:33 2002
@@ -0,0 +1,20 @@
+#ifndef __ASM_MACH_MPPARSE_H
+#define __ASM_MACH_MPPARSE_H
+
+static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
+				struct mpc_config_translation *translation)
+{
+	Dprintk("Bus #%d is %s\n", m->mpc_busid, name);
+}
+
+static inline void mpc_oem_pci_bus(struct mpc_config_bus *m, 
+				struct mpc_config_translation *translation)
+{
+}
+
+static inline void mps_oem_check(struct mp_config_table *mpc, char *oem, 
+		char *productid)
+{
+}
+
+#endif /* __ASM_MACH_MPPARSE_H */
diff -urpN -X /home/fletch/.diff.exclude 13-numaq3/include/asm-i386/mach-numaq/mach_apic.h 14-numaq4/include/asm-i386/mach-numaq/mach_apic.h
--- 13-numaq3/include/asm-i386/mach-numaq/mach_apic.h	Sun Dec 22 12:10:10 2002
+++ 14-numaq4/include/asm-i386/mach-numaq/mach_apic.h	Sun Dec 22 12:10:33 2002
@@ -10,10 +10,6 @@
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
 
-static inline void summit_check(char *oem, char *productid) 
-{
-}
-
 static inline int apic_id_registered(void)
 {
 	return (1);
diff -urpN -X /home/fletch/.diff.exclude 13-numaq3/include/asm-i386/mach-numaq/mach_mpparse.h 14-numaq4/include/asm-i386/mach-numaq/mach_mpparse.h
--- 13-numaq3/include/asm-i386/mach-numaq/mach_mpparse.h	Wed Dec 31 16:00:00 1969
+++ 14-numaq4/include/asm-i386/mach-numaq/mach_mpparse.h	Sun Dec 22 12:10:33 2002
@@ -0,0 +1,37 @@
+#ifndef __ASM_MACH_MPPARSE_H
+#define __ASM_MACH_MPPARSE_H
+
+static void __init smp_read_mpc_oem(struct mp_config_oemtable *oemtable,
+		        unsigned short oemsize);
+
+static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
+				struct mpc_config_translation *translation)
+{
+	int quad = translation->trans_quad;
+	int local = translation->trans_local;
+
+	mp_bus_id_to_node[m->mpc_busid] = quad;
+	mp_bus_id_to_local[m->mpc_busid] = local;
+	printk("Bus #%d is %s (node %d)\n", m->mpc_busid, name, quad);
+}
+
+static inline void mpc_oem_pci_bus(struct mpc_config_bus *m, 
+				struct mpc_config_translation *translation)
+{
+	int quad = translation->trans_quad;
+	int local = translation->trans_local;
+
+	quad_local_to_mp_bus_id[quad][local] = m->mpc_busid;
+}
+
+static inline void mps_oem_check(struct mp_config_table *mpc, char *oem, 
+		char *productid)
+{
+	if (strncmp(oem, "IBM NUMA", 8))
+		printk("Warning!  May not be a NUMA-Q system!\n");
+	if (mpc->mpc_oemptr)
+		smp_read_mpc_oem((struct mp_config_oemtable *) mpc->mpc_oemptr, 
+				mpc->mpc_oemsize);
+}
+
+#endif /* __ASM_MACH_MPPARSE_H */
diff -urpN -X /home/fletch/.diff.exclude 13-numaq3/include/asm-i386/mach-summit/mach_apic.h 14-numaq4/include/asm-i386/mach-summit/mach_apic.h
--- 13-numaq3/include/asm-i386/mach-summit/mach_apic.h	Sun Dec 22 12:08:42 2002
+++ 14-numaq4/include/asm-i386/mach-summit/mach_apic.h	Sun Dec 22 12:10:33 2002
@@ -26,12 +26,6 @@ static inline unsigned long calculate_ld
 #define APIC_BROADCAST_ID     (x86_summit ? 0xFF : 0x0F)
 #define check_apicid_used(bitmap, apicid) (0)
 
-static inline void summit_check(char *oem, char *productid)
-{
-	if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(str, "VIGIL SMP", 9))
-		x86_summit = 1;
-}
-
 static inline void clustered_apic_check(void)
 {
 	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
diff -urpN -X /home/fletch/.diff.exclude 13-numaq3/include/asm-i386/mach-summit/mach_mpparse.h 14-numaq4/include/asm-i386/mach-summit/mach_mpparse.h
--- 13-numaq3/include/asm-i386/mach-summit/mach_mpparse.h	Wed Dec 31 16:00:00 1969
+++ 14-numaq4/include/asm-i386/mach-summit/mach_mpparse.h	Sun Dec 22 12:10:33 2002
@@ -0,0 +1,22 @@
+#ifndef __ASM_MACH_MPPARSE_H
+#define __ASM_MACH_MPPARSE_H
+
+static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
+				struct mpc_config_translation *translation)
+{
+	Dprintk("Bus #%d is %s\n", m->mpc_busid, name);
+}
+
+static inline void mpc_oem_pci_bus(struct mpc_config_bus *m, 
+				struct mpc_config_translation *translation)
+{
+}
+
+static inline void mps_oem_check(struct mp_config_table *mpc, char *oem, 
+		char *productid)
+{
+	if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(str, "VIGIL SMP", 9))
+		x86_summit = 1;
+}
+
+#endif /* __ASM_MACH_MPPARSE_H */

