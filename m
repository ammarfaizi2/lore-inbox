Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbTFYSN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264924AbTFYSN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:13:29 -0400
Received: from air-2.osdl.org ([65.172.181.6]:42645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264900AbTFYSMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:12:50 -0400
Date: Wed, 25 Jun 2003 11:23:37 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] IO-APIC unions
Message-Id: <20030625112337.2deceb75.rddunlap@osdl.org>
In-Reply-To: <Pine.GSO.3.96.1030625180438.19428C-100000@delta.ds2.pg.gda.pl>
References: <20030625085714.3cd7759e.rddunlap@osdl.org>
	<Pine.GSO.3.96.1030625180438.19428C-100000@delta.ds2.pg.gda.pl>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003 18:11:06 +0200 (MET DST) "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:

| On Wed, 25 Jun 2003, Randy.Dunlap wrote:
| 
| > | But the ugliness part I care about, and I wonder if it wouldn't be better 
| > | in this case to just make the register definition a "union", and have 
| > | something like
| > | 
| > | 	union reg_03 {
| > | 		u32 value;
| > | 		struct {
| > | 			u32 boot_DT:1,
| > | 			    reserved:31;
| > | 		} bits;
| > | 	};
| [...]
| > Sure, I'll do that.
| 
|  Perhaps using "raw" instead of "value" would be prettier and certainly we
| would save two characters per reference. ;-)  Anyway, it's indeed a good
| opportunity to do a clean-up while fiddling with these bits.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I prefer that name also.  Patch is below.

Linus, this patch is on top of yesterday's patch (or on top of
today's -bk3 snapshot).  Please apply.  Builds and boots.


--
~Randy
~ http://developer.osdl.org/rddunlap/ ~ http://www.xenotime.net/linux/ ~


patch_name:	ioapic_union.patch
patch_version:	2003-06-25.10:52:07
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	use unions in IO APIC data structs;
product:	Linux
product_versions: linux-2.5.73
maintainer:	Maciej W. Rozycki <macro@ds2.pg.gda.pl>
diffstat:	=
 arch/i386/kernel/io_apic.c |  138 ++++++++++++++++++++++-----------------------
 include/asm-i386/io_apic.h |   58 +++++++++++-------
 2 files changed, 104 insertions(+), 92 deletions(-)


diff -Naur ./arch/i386/kernel/io_apic.c~union ./arch/i386/kernel/io_apic.c
--- ./arch/i386/kernel/io_apic.c~union	2003-06-25 10:51:59.000000000 -0700
+++ ./arch/i386/kernel/io_apic.c	2003-06-25 10:50:00.000000000 -0700
@@ -1272,10 +1272,10 @@
 void __init print_IO_APIC(void)
 {
 	int apic, i;
-	struct IO_APIC_reg_00 reg_00;
-	struct IO_APIC_reg_01 reg_01;
-	struct IO_APIC_reg_02 reg_02;
-	struct IO_APIC_reg_03 reg_03;
+	union IO_APIC_reg_00 reg_00;
+	union IO_APIC_reg_01 reg_01;
+	union IO_APIC_reg_02 reg_02;
+	union IO_APIC_reg_03 reg_03;
 	unsigned long flags;
 
  	printk(KERN_DEBUG "number of MP IRQ sources: %d.\n", mp_irq_entries);
@@ -1292,47 +1292,47 @@
 	for (apic = 0; apic < nr_ioapics; apic++) {
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	*(int *)&reg_00 = io_apic_read(apic, 0);
-	*(int *)&reg_01 = io_apic_read(apic, 1);
-	if (reg_01.version >= 0x10)
-		*(int *)&reg_02 = io_apic_read(apic, 2);
-	if (reg_01.version >= 0x20)
-		*(int *)&reg_03 = io_apic_read(apic, 3);
+	reg_00.raw = io_apic_read(apic, 0);
+	reg_01.raw = io_apic_read(apic, 1);
+	if (reg_01.bits.version >= 0x10)
+		reg_02.raw = io_apic_read(apic, 2);
+	if (reg_01.bits.version >= 0x20)
+		reg_03.raw = io_apic_read(apic, 3);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	printk("\n");
 	printk(KERN_DEBUG "IO APIC #%d......\n", mp_ioapics[apic].mpc_apicid);
-	printk(KERN_DEBUG ".... register #00: %08X\n", *(int *)&reg_00);
-	printk(KERN_DEBUG ".......    : physical APIC id: %02X\n", reg_00.ID);
-	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.delivery_type);
-	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.LTS);
-	if (reg_00.ID >= APIC_BROADCAST_ID)
+	printk(KERN_DEBUG ".... register #00: %08X\n", reg_00.raw);
+	printk(KERN_DEBUG ".......    : physical APIC id: %02X\n", reg_00.bits.ID);
+	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.bits.delivery_type);
+	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.bits.LTS);
+	if (reg_00.bits.ID >= APIC_BROADCAST_ID)
 		UNEXPECTED_IO_APIC();
-	if (reg_00.__reserved_1 || reg_00.__reserved_2)
+	if (reg_00.bits.__reserved_1 || reg_00.bits.__reserved_2)
 		UNEXPECTED_IO_APIC();
 
-	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
-	printk(KERN_DEBUG ".......     : max redirection entries: %04X\n", reg_01.entries);
-	if (	(reg_01.entries != 0x0f) && /* older (Neptune) boards */
-		(reg_01.entries != 0x17) && /* typical ISA+PCI boards */
-		(reg_01.entries != 0x1b) && /* Compaq Proliant boards */
-		(reg_01.entries != 0x1f) && /* dual Xeon boards */
-		(reg_01.entries != 0x22) && /* bigger Xeon boards */
-		(reg_01.entries != 0x2E) &&
-		(reg_01.entries != 0x3F)
+	printk(KERN_DEBUG ".... register #01: %08X\n", reg_01.raw);
+	printk(KERN_DEBUG ".......     : max redirection entries: %04X\n", reg_01.bits.entries);
+	if (	(reg_01.bits.entries != 0x0f) && /* older (Neptune) boards */
+		(reg_01.bits.entries != 0x17) && /* typical ISA+PCI boards */
+		(reg_01.bits.entries != 0x1b) && /* Compaq Proliant boards */
+		(reg_01.bits.entries != 0x1f) && /* dual Xeon boards */
+		(reg_01.bits.entries != 0x22) && /* bigger Xeon boards */
+		(reg_01.bits.entries != 0x2E) &&
+		(reg_01.bits.entries != 0x3F)
 	)
 		UNEXPECTED_IO_APIC();
 
-	printk(KERN_DEBUG ".......     : PRQ implemented: %X\n", reg_01.PRQ);
-	printk(KERN_DEBUG ".......     : IO APIC version: %04X\n", reg_01.version);
-	if (	(reg_01.version != 0x01) && /* 82489DX IO-APICs */
-		(reg_01.version != 0x10) && /* oldest IO-APICs */
-		(reg_01.version != 0x11) && /* Pentium/Pro IO-APICs */
-		(reg_01.version != 0x13) && /* Xeon IO-APICs */
-		(reg_01.version != 0x20)    /* Intel P64H (82806 AA) */
+	printk(KERN_DEBUG ".......     : PRQ implemented: %X\n", reg_01.bits.PRQ);
+	printk(KERN_DEBUG ".......     : IO APIC version: %04X\n", reg_01.bits.version);
+	if (	(reg_01.bits.version != 0x01) && /* 82489DX IO-APICs */
+		(reg_01.bits.version != 0x10) && /* oldest IO-APICs */
+		(reg_01.bits.version != 0x11) && /* Pentium/Pro IO-APICs */
+		(reg_01.bits.version != 0x13) && /* Xeon IO-APICs */
+		(reg_01.bits.version != 0x20)    /* Intel P64H (82806 AA) */
 	)
 		UNEXPECTED_IO_APIC();
-	if (reg_01.__reserved_1 || reg_01.__reserved_2)
+	if (reg_01.bits.__reserved_1 || reg_01.bits.__reserved_2)
 		UNEXPECTED_IO_APIC();
 
 	/*
@@ -1340,10 +1340,10 @@
 	 * but the value of reg_02 is read as the previous read register
 	 * value, so ignore it if reg_02 == reg_01.
 	 */
-	if (reg_01.version >= 0x10 && *(int *)&reg_02 != *(int *)&reg_01) {
-		printk(KERN_DEBUG ".... register #02: %08X\n", *(int *)&reg_02);
-		printk(KERN_DEBUG ".......     : arbitration: %02X\n", reg_02.arbitration);
-		if (reg_02.__reserved_1 || reg_02.__reserved_2)
+	if (reg_01.bits.version >= 0x10 && reg_02.raw != reg_01.raw) {
+		printk(KERN_DEBUG ".... register #02: %08X\n", reg_02.raw);
+		printk(KERN_DEBUG ".......     : arbitration: %02X\n", reg_02.bits.arbitration);
+		if (reg_02.bits.__reserved_1 || reg_02.bits.__reserved_2)
 			UNEXPECTED_IO_APIC();
 	}
 
@@ -1352,11 +1352,11 @@
 	 * or reg_03, but the value of reg_0[23] is read as the previous read
 	 * register value, so ignore it if reg_03 == reg_0[12].
 	 */
-	if (reg_01.version >= 0x20 && *(int *)&reg_03 != *(int *)&reg_02 &&
-	    *(int *)&reg_03 != *(int *)&reg_01) {
-		printk(KERN_DEBUG ".... register #03: %08X\n", *(int *)&reg_03);
-		printk(KERN_DEBUG ".......     : Boot DT    : %X\n", reg_03.boot_DT);
-		if (reg_03.__reserved_1)
+	if (reg_01.bits.version >= 0x20 && reg_03.raw != reg_02.raw &&
+	    reg_03.raw != reg_01.raw) {
+		printk(KERN_DEBUG ".... register #03: %08X\n", reg_03.raw);
+		printk(KERN_DEBUG ".......     : Boot DT    : %X\n", reg_03.bits.boot_DT);
+		if (reg_03.bits.__reserved_1)
 			UNEXPECTED_IO_APIC();
 	}
 
@@ -1365,7 +1365,7 @@
 	printk(KERN_DEBUG " NR Log Phy Mask Trig IRR Pol"
 			  " Stat Dest Deli Vect:   \n");
 
-	for (i = 0; i <= reg_01.entries; i++) {
+	for (i = 0; i <= reg_01.bits.entries; i++) {
 		struct IO_APIC_route_entry entry;
 
 		spin_lock_irqsave(&ioapic_lock, flags);
@@ -1546,7 +1546,7 @@
 
 static void __init enable_IO_APIC(void)
 {
-	struct IO_APIC_reg_01 reg_01;
+	union IO_APIC_reg_01 reg_01;
 	int i;
 	unsigned long flags;
 
@@ -1563,9 +1563,9 @@
 	 */
 	for (i = 0; i < nr_ioapics; i++) {
 		spin_lock_irqsave(&ioapic_lock, flags);
-		*(int *)&reg_01 = io_apic_read(i, 1);
+		reg_01.raw = io_apic_read(i, 1);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
-		nr_ioapic_registers[i] = reg_01.entries+1;
+		nr_ioapic_registers[i] = reg_01.bits.entries+1;
 	}
 
 	/*
@@ -1597,7 +1597,7 @@
 #ifndef CONFIG_X86_NUMAQ
 static void __init setup_ioapic_ids_from_mpc(void)
 {
-	struct IO_APIC_reg_00 reg_00;
+	union IO_APIC_reg_00 reg_00;
 	unsigned long phys_id_present_map;
 	int apic;
 	int i;
@@ -1617,7 +1617,7 @@
 
 		/* Read the register 0 value */
 		spin_lock_irqsave(&ioapic_lock, flags);
-		*(int *)&reg_00 = io_apic_read(apic, 0);
+		reg_00.raw = io_apic_read(apic, 0);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 		
 		old_id = mp_ioapics[apic].mpc_apicid;
@@ -1626,8 +1626,8 @@
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
-				reg_00.ID);
-			mp_ioapics[apic].mpc_apicid = reg_00.ID;
+				reg_00.bits.ID);
+			mp_ioapics[apic].mpc_apicid = reg_00.bits.ID;
 		}
 
 		/*
@@ -1671,18 +1671,18 @@
 		printk(KERN_INFO "...changing IO-APIC physical APIC ID to %d ...",
 					mp_ioapics[apic].mpc_apicid);
 
-		reg_00.ID = mp_ioapics[apic].mpc_apicid;
+		reg_00.bits.ID = mp_ioapics[apic].mpc_apicid;
 		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(apic, 0, *(int *)&reg_00);
+		io_apic_write(apic, 0, reg_00.raw);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 
 		/*
 		 * Sanity check
 		 */
 		spin_lock_irqsave(&ioapic_lock, flags);
-		*(int *)&reg_00 = io_apic_read(apic, 0);
+		reg_00.raw = io_apic_read(apic, 0);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
-		if (reg_00.ID != mp_ioapics[apic].mpc_apicid)
+		if (reg_00.bits.ID != mp_ioapics[apic].mpc_apicid)
 			panic("could not set ID!\n");
 		else
 			printk(" ok.\n");
@@ -2220,7 +2220,7 @@
 
 int __init io_apic_get_unique_id (int ioapic, int apic_id)
 {
-	struct IO_APIC_reg_00 reg_00;
+	union IO_APIC_reg_00 reg_00;
 	static unsigned long apic_id_map = 0;
 	unsigned long flags;
 	int i = 0;
@@ -2238,13 +2238,13 @@
 		apic_id_map = phys_cpu_present_map;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	*(int *)&reg_00 = io_apic_read(ioapic, 0);
+	reg_00.raw = io_apic_read(ioapic, 0);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	if (apic_id >= IO_APIC_MAX_ID) {
 		printk(KERN_WARNING "IOAPIC[%d]: Invalid apic_id %d, trying "
-			"%d\n", ioapic, apic_id, reg_00.ID);
-		apic_id = reg_00.ID;
+			"%d\n", ioapic, apic_id, reg_00.bits.ID);
+		apic_id = reg_00.bits.ID;
 	}
 
 	/*
@@ -2269,16 +2269,16 @@
 
 	apic_id_map |= apicid_to_cpu_present(apic_id);
 
-	if (reg_00.ID != apic_id) {
-		reg_00.ID = apic_id;
+	if (reg_00.bits.ID != apic_id) {
+		reg_00.bits.ID = apic_id;
 
 		spin_lock_irqsave(&ioapic_lock, flags);
-		io_apic_write(ioapic, 0, *(int *)&reg_00);
-		*(int *)&reg_00 = io_apic_read(ioapic, 0);
+		io_apic_write(ioapic, 0, reg_00.raw);
+		reg_00.raw = io_apic_read(ioapic, 0);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 
 		/* Sanity check */
-		if (reg_00.ID != apic_id)
+		if (reg_00.bits.ID != apic_id)
 			panic("IOAPIC[%d]: Unable change apic_id!\n", ioapic);
 	}
 
@@ -2290,27 +2290,27 @@
 
 int __init io_apic_get_version (int ioapic)
 {
-	struct IO_APIC_reg_01	reg_01;
+	union IO_APIC_reg_01	reg_01;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	*(int *)&reg_01 = io_apic_read(ioapic, 1);
+	reg_01.raw = io_apic_read(ioapic, 1);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
-	return reg_01.version;
+	return reg_01.bits.version;
 }
 
 
 int __init io_apic_get_redir_entries (int ioapic)
 {
-	struct IO_APIC_reg_01	reg_01;
+	union IO_APIC_reg_01	reg_01;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	*(int *)&reg_01 = io_apic_read(ioapic, 1);
+	reg_01.raw = io_apic_read(ioapic, 1);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
-	return reg_01.entries;
+	return reg_01.bits.entries;
 }
 
 
diff -Naur ./include/asm-i386/io_apic.h~union ./include/asm-i386/io_apic.h
--- ./include/asm-i386/io_apic.h~union	2003-06-24 13:44:21.000000000 -0700
+++ ./include/asm-i386/io_apic.h	2003-06-25 10:05:50.000000000 -0700
@@ -22,32 +22,44 @@
 /*
  * The structure of the IO-APIC:
  */
-struct IO_APIC_reg_00 {
-	__u32	__reserved_2	: 14,
-		LTS		:  1,
-		delivery_type	:  1,
-		__reserved_1	:  8,
-		ID		:  8;
-} __attribute__ ((packed));
+union IO_APIC_reg_00 {
+	u32	raw;
+	struct {
+		u32	__reserved_2	: 14,
+			LTS		:  1,
+			delivery_type	:  1,
+			__reserved_1	:  8,
+			ID		:  8;
+	} __attribute__ ((packed)) bits;
+};
 
-struct IO_APIC_reg_01 {
-	__u32	version		:  8,
-		__reserved_2	:  7,
-		PRQ		:  1,
-		entries		:  8,
-		__reserved_1	:  8;
-} __attribute__ ((packed));
+union IO_APIC_reg_01 {
+	u32	raw;
+	struct {
+		u32	version		:  8,
+			__reserved_2	:  7,
+			PRQ		:  1,
+			entries		:  8,
+			__reserved_1	:  8;
+	} __attribute__ ((packed)) bits;
+};
 
-struct IO_APIC_reg_02 {
-	__u32	__reserved_2	: 24,
-		arbitration	:  4,
-		__reserved_1	:  4;
-} __attribute__ ((packed));
+union IO_APIC_reg_02 {
+	u32	raw;
+	struct {
+		u32	__reserved_2	: 24,
+			arbitration	:  4,
+			__reserved_1	:  4;
+	} __attribute__ ((packed)) bits;
+};
 
-struct IO_APIC_reg_03 {
-	__u32	boot_DT		:  1,
-		__reserved_1	: 31;
-} __attribute__ ((packed));
+union IO_APIC_reg_03 {
+	u32	raw;
+	struct {
+		u32	boot_DT		:  1,
+			__reserved_1	: 31;
+	} __attribute__ ((packed)) bits;
+};
 
 /*
  * # of IO-APICs and # of IRQ routing registers
