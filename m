Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbTBOTNd>; Sat, 15 Feb 2003 14:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbTBOTMf>; Sat, 15 Feb 2003 14:12:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52752 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264943AbTBOTLh>; Sat, 15 Feb 2003 14:11:37 -0500
Subject: PATCH: printk levels for mpparse
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Date: Sat, 15 Feb 2003 19:21:47 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k7sh-0007I8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also recognize the NEC98 busses

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/arch/i386/kernel/mpparse.c linux-2.5.61-ac1/arch/i386/kernel/mpparse.c
--- linux-2.5.61/arch/i386/kernel/mpparse.c	2003-02-10 18:38:16.000000000 +0000
+++ linux-2.5.61-ac1/arch/i386/kernel/mpparse.c	2003-02-14 22:47:48.000000000 +0000
@@ -169,7 +169,7 @@
 	num_processors++;
 
 	if (m->mpc_apicid > MAX_APICS) {
-		printk("Processor #%d INVALID. (Max ID: %d).\n",
+		printk(KERN_WARNING "Processor #%d INVALID. (Max ID: %d).\n",
 			m->mpc_apicid, MAX_APICS);
 		--num_processors;
 		return;
@@ -182,7 +182,7 @@
 	 * Validate version
 	 */
 	if (ver == 0x0) {
-		printk("BIOS bug, APIC version is 0 for CPU#%d! fixing up to 0x10. (tell your hw vendor)\n", m->mpc_apicid);
+		printk(KERN_WARNING "BIOS bug, APIC version is 0 for CPU#%d! fixing up to 0x10. (tell your hw vendor)\n", m->mpc_apicid);
 		ver = 0x10;
 	}
 	apic_version[m->mpc_apicid] = ver;
@@ -209,8 +209,10 @@
 		mp_current_pci_id++;
 	} else if (strncmp(str, BUSTYPE_MCA, sizeof(BUSTYPE_MCA)-1) == 0) {
 		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_MCA;
+	} else if (strncmp(str, BUSTYPE_NEC98, sizeof(BUSTYPE_NEC98)-1) == 0) {
+		mp_bus_id_to_type[m->mpc_busid] = MP_BUS_NEC98;
 	} else {
-		printk("Unknown bustype %s - ignoring\n", str);
+		printk(KERN_WARNING "Unknown bustype %s - ignoring\n", str);
 	}
 }
 
@@ -219,10 +221,10 @@
 	if (!(m->mpc_flags & MPC_APIC_USABLE))
 		return;
 
-	printk("I/O APIC #%d Version %d at 0x%lX.\n",
+	printk(KERN_INFO "I/O APIC #%d Version %d at 0x%lX.\n",
 		m->mpc_apicid, m->mpc_apicver, m->mpc_apicaddr);
 	if (nr_ioapics >= MAX_IO_APICS) {
-		printk("Max # of I/O APICs (%d) exceeded (found %d).\n",
+		printk(KERN_CRIT "Max # of I/O APICs (%d) exceeded (found %d).\n",
 			MAX_IO_APICS, nr_ioapics);
 		panic("Recompile kernel with bigger MAX_IO_APICS!.\n");
 	}
@@ -272,10 +274,10 @@
 #ifdef CONFIG_X86_NUMAQ
 static void __init MP_translation_info (struct mpc_config_translation *m)
 {
-	printk("Translation: record %d, type %d, quad %d, global %d, local %d\n", mpc_record, m->trans_type, m->trans_quad, m->trans_global, m->trans_local);
+	printk(KERN_INFO "Translation: record %d, type %d, quad %d, global %d, local %d\n", mpc_record, m->trans_type, m->trans_quad, m->trans_global, m->trans_local);
 
 	if (mpc_record >= MAX_MPC_ENTRY) 
-		printk("MAX_MPC_ENTRY exceeded!\n");
+		printk(KERN_ERR "MAX_MPC_ENTRY exceeded!\n");
 	else
 		translation_table[mpc_record] = m; /* stash this for later */
 	if (m->trans_quad+1 > numnodes)
@@ -293,10 +295,10 @@
 	unsigned char *oemptr = ((unsigned char *)oemtable)+count;
 	
 	mpc_record = 0;
-	printk("Found an OEM MPC table at %8p - parsing it ... \n", oemtable);
+	printk(KERN_INFO "Found an OEM MPC table at %8p - parsing it ... \n", oemtable);
 	if (memcmp(oemtable->oem_signature,MPC_OEM_SIGNATURE,4))
 	{
-		printk("SMP mpc oemtable: bad signature [%c%c%c%c]!\n",
+		printk(KERN_WARNING "SMP mpc oemtable: bad signature [%c%c%c%c]!\n",
 			oemtable->oem_signature[0],
 			oemtable->oem_signature[1],
 			oemtable->oem_signature[2],
@@ -305,7 +307,7 @@
 	}
 	if (mpf_checksum((unsigned char *)oemtable,oemtable->oem_length))
 	{
-		printk("SMP oem mptable: checksum error!\n");
+		printk(KERN_WARNING "SMP oem mptable: checksum error!\n");
 		return;
 	}
 	while (count < oemtable->oem_length) {
@@ -322,7 +324,7 @@
 			}
 			default:
 			{
-				printk("Unrecognised OEM table entry type! - %d\n", (int) *oemptr);
+				printk(KERN_WARNING "Unrecognised OEM table entry type! - %d\n", (int) *oemptr);
 				return;
 			}
 		}
@@ -364,7 +366,7 @@
 	}
 	memcpy(oem,mpc->mpc_oem,8);
 	oem[8]=0;
-	printk("OEM ID: %s ",oem);
+	printk(KERN_INFO "OEM ID: %s ",oem);
 
 	memcpy(str,mpc->mpc_productid,12);
 	str[12]=0;
@@ -479,12 +481,12 @@
 	 *  If it does, we assume it's valid.
 	 */
 	if (mpc_default_type == 5) {
-		printk("ISA/PCI bus type with no IRQ information... falling back to ELCR\n");
+		printk(KERN_INFO "ISA/PCI bus type with no IRQ information... falling back to ELCR\n");
 
 		if (ELCR_trigger(0) || ELCR_trigger(1) || ELCR_trigger(2) || ELCR_trigger(13))
-			printk("ELCR contains invalid data... not using ELCR\n");
+			printk(KERN_WARNING "ELCR contains invalid data... not using ELCR\n");
 		else {
-			printk("Using ELCR to identify PCI interrupts\n");
+			printk(KERN_INFO "Using ELCR to identify PCI interrupts\n");
 			ELCR_fallback = 1;
 		}
 	}
@@ -559,7 +561,8 @@
 	bus.mpc_busid = 0;
 	switch (mpc_default_type) {
 		default:
-			printk("???\nUnknown standard configuration %d\n",
+			printk("???\n");
+			printk(KERN_ERR "Unknown standard configuration %d\n",
 				mpc_default_type);
 			/* fall through */
 		case 1:
@@ -628,12 +631,12 @@
 	else if (acpi_lapic)
 		printk(KERN_INFO "Using ACPI for processor (LAPIC) configuration information\n");
 
-	printk("Intel MultiProcessor Specification v1.%d\n", mpf->mpf_specification);
+	printk("KERN_INFO Intel MultiProcessor Specification v1.%d\n", mpf->mpf_specification);
 	if (mpf->mpf_feature2 & (1<<7)) {
-		printk("    IMCR and PIC compatibility mode.\n");
+		printk(KERN_INFO "    IMCR and PIC compatibility mode.\n");
 		pic_mode = 1;
 	} else {
-		printk("    Virtual Wire compatibility mode.\n");
+		printk(KERN_INFO "    Virtual Wire compatibility mode.\n");
 		pic_mode = 0;
 	}
 
@@ -642,7 +645,7 @@
 	 */
 	if (mpf->mpf_feature1 != 0) {
 
-		printk("Default MP configuration #%d\n", mpf->mpf_feature1);
+		printk(KERN_INFO "Default MP configuration #%d\n", mpf->mpf_feature1);
 		construct_default_ISA_mptable(mpf->mpf_feature1);
 
 	} else if (mpf->mpf_physptr) {
@@ -665,7 +668,7 @@
 		if (!mp_irq_entries) {
 			struct mpc_config_bus bus;
 
-			printk("BIOS bug, no explicit IRQ entries, using default mptable. (tell your hw vendor)\n");
+			printk(KERN_ERR "BIOS bug, no explicit IRQ entries, using default mptable. (tell your hw vendor)\n");
 
 			bus.mpc_type = MP_BUS;
 			bus.mpc_busid = 0;
@@ -678,7 +681,7 @@
 	} else
 		BUG();
 
-	printk("Processors: %d\n", num_processors);
+	printk(KERN_INFO "Processors: %d\n", num_processors);
 	/*
 	 * Only use the first configuration found.
 	 */
@@ -702,7 +705,7 @@
 				|| (mpf->mpf_specification == 4)) ) {
 
 			smp_found_config = 1;
-			printk("found SMP MP-table at %08lx\n",
+			printk(KERN_INFO "found SMP MP-table at %08lx\n",
 						virt_to_phys(mpf));
 			reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE);
 			if (mpf->mpf_physptr)
