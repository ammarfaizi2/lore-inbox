Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264215AbUEDDdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbUEDDdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 23:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264214AbUEDDdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 23:33:42 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:782 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S264215AbUEDDci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 23:32:38 -0400
Content-class: urn:content-classes:message
Subject: [PATCH] 2.6.5- es7000 subarch update for generic arch
Date: Mon, 3 May 2004 22:32:26 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C43188.6B76E757"
Message-ID: <452548B29F0CCE48B8ABB094307EBA1C04C55251@USRV-EXCH2.na.uis.unisys.com>
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.5- es7000 subarch update for generic arch
Thread-Index: AcQxiGpK7xIzSc40RxqSc2PjpxTSqA==
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: <akpm@digeo.com>, <lse-tech@lists.sourceforge.net>,
       "Andi Kleen" <ak@suse.de>
X-OriginalArrivalTime: 04 May 2004 03:32:26.0496 (UTC) FILETIME=[6BABF000:01C43188]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C43188.6B76E757
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,
This is ES7000 sub architecture update. It makes ES7000 a part of the =
generic architecture, so the single compiled kernel will be able to =
choose a correct set of parameters, routines ("genapic"), and a boot =
path. It uses criteria provided by the subarch for platform =
identification. In case of ES7000, it is a unique product/vendor string =
in the ACPI/MP OEM table, and server control registers.
The patch is confined to only es7000 subarch and generic subarch. It was =
tested on ES7000 as well as generic Intel 8x Xeon system. Andi Kleen has =
reviewed the changes.=20

Thanks,
--Natalie


-------------------------------------------------------------------------=
--------------------------------------
diff -Naur linux-2.6.5-vanilla/arch/i386/Kconfig =
linux-2.6.5/arch/i386/Kconfig
--- linux-2.6.5-vanilla/arch/i386/Kconfig	2004-04-03 22:36:25.000000000 =
-0500
+++ linux-2.6.5/arch/i386/Kconfig	2004-05-03 16:48:50.000000000 -0400
@@ -102,10 +102,10 @@
 	  and vice versa. See <file:Documentation/sgi-visws.txt> for details.
=20
 config X86_GENERICARCH
-       bool "Generic architecture (Summit, bigsmp, default)"
+       bool "Generic architecture (Summit, bigsmp, ES7000, default)"
        depends on SMP
        help
-          This option compiles in the Summit, bigsmp, default =
subarchitectures.
+          This option compiles in the Summit, bigsmp, ES7000, default =
subarchitectures.
 	  It is intended for a generic binary kernel.
=20
 config X86_ES7000
diff -Naur linux-2.6.5-vanilla/arch/i386/Makefile =
linux-2.6.5/arch/i386/Makefile
--- linux-2.6.5-vanilla/arch/i386/Makefile	2004-04-03 22:36:56.000000000 =
-0500
+++ linux-2.6.5/arch/i386/Makefile	2004-05-03 09:11:18.000000000 -0400
@@ -92,7 +92,8 @@
=20
 # ES7000 subarch support
 mflags-$(CONFIG_X86_ES7000)	:=3D -Iinclude/asm-i386/mach-es7000
-mcore-$(CONFIG_X86_ES7000)	:=3D mach-es7000
+mcore-$(CONFIG_X86_ES7000)	:=3D mach-default
+core-$(CONFIG_X86_ES7000)	:=3D arch/i386/mach-es7000/
=20
 # default subarch .h files
 mflags-y +=3D -Iinclude/asm-i386/mach-default
diff -Naur linux-2.6.5-vanilla/arch/i386/mach-es7000/Makefile =
linux-2.6.5/arch/i386/mach-es7000/Makefile
--- linux-2.6.5-vanilla/arch/i386/mach-es7000/Makefile	2004-04-03 =
22:37:07.000000000 -0500
+++ linux-2.6.5/arch/i386/mach-es7000/Makefile	2004-05-03 =
09:11:18.000000000 -0400
@@ -2,4 +2,5 @@
 # Makefile for the linux kernel.
 #
=20
-obj-y		:=3D setup.o topology.o es7000.o
+obj-$(CONFIG_X86_ES7000)	:=3D es7000plat.o
+obj-$(CONFIG_X86_GENERICARCH)	:=3D es7000plat.o
diff -Naur linux-2.6.5-vanilla/arch/i386/mach-es7000/es7000.c =
linux-2.6.5/arch/i386/mach-es7000/es7000.c
--- linux-2.6.5-vanilla/arch/i386/mach-es7000/es7000.c	2004-05-03 =
08:58:55.000000000 -0400
+++ linux-2.6.5/arch/i386/mach-es7000/es7000.c	1969-12-31 =
19:00:00.000000000 -0500
@@ -1,280 +0,0 @@
-/*
- * Written by: Garry Forsgren, Unisys Corporation
- *             Natalie Protasevich, Unisys Corporation
- * This file contains the code to configure and interface=20
- * with Unisys ES7000 series hardware system manager.
- *
- * Copyright (c) 2003 Unisys Corporation.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify =
it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License =
along
- * with this program; if not, write the Free Software Foundation, Inc., =
59
- * Temple Place - Suite 330, Boston MA 02111-1307, USA.
- *
- * Contact information: Unisys Corporation, Township Line & Union =
Meeting=20
- * Roads-A, Unisys Way, Blue Bell, Pennsylvania, 19424, or:
- *
- * http://www.unisys.com
- */
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/smp.h>
-#include <linux/string.h>
-#include <linux/spinlock.h>
-#include <linux/errno.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
-#include <linux/init.h>
-#include <linux/acpi.h>
-#include <asm/io.h>
-#include <asm/nmi.h>
-#include <asm/smp.h>
-#include <asm/apicdef.h>
-#include "es7000.h"
-
-/*
- * ES7000 Globals
- */
-
-volatile unsigned long	*psai =3D NULL;
-struct mip_reg		*mip_reg; =20
-struct mip_reg		*host_reg;
-int 			mip_port;
-unsigned long		mip_addr, host_addr;
-
-/*
- * Parse the OEM Table
- */
-
-void __init
-parse_unisys_oem (char *oemptr, int oem_entries)
-{
-	int                     i;
-	int 			success =3D 0;
-	unsigned char           type, size;
-	unsigned long           val;
-	char                    *tp =3D NULL; =20
-	struct psai             *psaip =3D NULL;
-	struct mip_reg_info 	*mi;
-	struct mip_reg		*host, *mip;
-
-	tp =3D oemptr;
-
-	tp +=3D 8;
-
-	for (i=3D0; i <=3D oem_entries; i++) {
-		type =3D *tp++;
-		size =3D *tp++;
-		tp -=3D 2;
-		switch (type) {
-		case MIP_REG:
-			mi =3D (struct mip_reg_info *)tp;
-			val =3D MIP_RD_LO(mi->host_reg);
-			host_addr =3D val;
-			host =3D (struct mip_reg *)val;
-			host_reg =3D __va(host);
-			val =3D MIP_RD_LO(mi->mip_reg);
-			mip_port =3D MIP_PORT(mi->mip_info);
-			mip_addr =3D val;
-			mip =3D (struct mip_reg *)val;
-			mip_reg =3D __va(mip);
-			Dprintk("es7000_mipcfg: host_reg =3D 0x%lx \n",=20
-				(unsigned long)host_reg);
-			Dprintk("es7000_mipcfg: mip_reg =3D 0x%lx \n",=20
-				(unsigned long)mip_reg);
-			success++;
-			break;
-		case MIP_PSAI_REG:
-			psaip =3D (struct psai *)tp;
-			if (tp !=3D NULL) {
-				if (psaip->addr)
-					psai =3D __va(psaip->addr);
-				else
-					psai =3D NULL;
-				success++;
-			}
-			break;
-		default:
-			break;
-		}
-		if (i =3D=3D 6) break;
-		tp +=3D size;
-	}
-
-	if (success < 2) {
-		printk("\nNo ES7000 found.\n");
-		es7000_plat =3D 0;
-	} else {
-		printk("\nEnabling ES7000 specific features...\n");
-		es7000_plat =3D 1;
-	}
-	return;
-}
-
-int __init=20
-find_unisys_acpi_oem_table(unsigned long *oem_addr, int *length)=20
-{
-	struct acpi_table_rsdp		*rsdp =3D NULL;
-	unsigned long			rsdp_phys =3D 0;
-	struct acpi_table_header 	*header =3D NULL;
-	int				i;
-	struct acpi_table_sdt		sdt;
-
-	rsdp_phys =3D acpi_find_rsdp();
-	rsdp =3D __va(rsdp_phys);
-	if (rsdp->rsdt_address) {
-		struct acpi_table_rsdt	*mapped_rsdt =3D NULL;
-		sdt.pa =3D rsdp->rsdt_address;
-
-		header =3D (struct acpi_table_header *)
-			__acpi_map_table(sdt.pa, sizeof(struct acpi_table_header));
-		if (!header)
-			return -ENODEV;
-
-		sdt.count =3D (header->length - sizeof(struct acpi_table_header)) >> =
3;
-		mapped_rsdt =3D (struct acpi_table_rsdt *)
-			__acpi_map_table(sdt.pa, header->length);
-		if (!mapped_rsdt)
-			return -ENODEV;
-
-		header =3D &mapped_rsdt->header;
-
-		for (i =3D 0; i < sdt.count; i++)
-			sdt.entry[i].pa =3D (unsigned long) mapped_rsdt->entry[i];
-	};
-	for (i =3D 0; i < sdt.count; i++) {
-
-		header =3D (struct acpi_table_header *)
-			__acpi_map_table(sdt.entry[i].pa,
-				sizeof(struct acpi_table_header));
-		if (!header)
-			continue;
-		if (!strncmp((char *) &header->signature, "OEM1", 4)) {
-			if (!strncmp((char *) &header->oem_id, "UNISYS", 6)) {
-				void *addr;
-				struct oem_table *t;
-				acpi_table_print(header, sdt.entry[i].pa);
-				t =3D (struct oem_table *) __acpi_map_table(sdt.entry[i].pa, =
header->length);
-				addr =3D (void *) __acpi_map_table(t->OEMTableAddr, =
t->OEMTableSize);
-				*length =3D header->length;
-				*oem_addr =3D (unsigned long) addr;
-				return 0;
-			}
-		}
-	}
-	printk("ES7000: did not find Unisys ACPI OEM table!\n");
-	return -1;
-}
-
-static void
-es7000_spin(int n)
-{
-	int i =3D 0;
-
-	while (i++ < n)=20
-		rep_nop();
-}
-
-static int __init
-es7000_mip_write(struct mip_reg *mip_reg)
-{
-	int			status =3D 0;
-	int			spin;
-
-	spin =3D MIP_SPIN;
-	while (((unsigned long long)host_reg->off_38 &
-		(unsigned long long)MIP_VALID) !=3D 0) {
-			if (--spin <=3D 0) {
-				printk("es7000_mip_write: Timeout waiting for Host Valid Flag");
-				return -1;
-			}
-		es7000_spin(MIP_SPIN);
-	}
-
-	memcpy(host_reg, mip_reg, sizeof(struct mip_reg));
-	outb(1, mip_port);
-
-	spin =3D MIP_SPIN;
-
-	while (((unsigned long long)mip_reg->off_38 &
-		(unsigned long long)MIP_VALID) =3D=3D 0) {
-		if (--spin <=3D 0) {
-			printk("es7000_mip_write: Timeout waiting for MIP Valid Flag");
-			return -1;
-		}
-		es7000_spin(MIP_SPIN);
-	}
-
-	status =3D ((unsigned long long)mip_reg->off_0 &
-		(unsigned long long)0xffff0000000000) >> 48;
-	mip_reg->off_38 =3D ((unsigned long long)mip_reg->off_38 &
-		(unsigned long long)~MIP_VALID);
-	return status;
-}
-
-int=20
-es7000_start_cpu(int cpu, unsigned long eip)
-{
-	unsigned long vect =3D 0, psaival =3D 0;
-
-	if (psai =3D=3D NULL)
-		return -1;
-
-	vect =3D ((unsigned long)__pa(eip)/0x1000) << 16;
-	psaival =3D (0x1000000 | vect | cpu);
-
-	while (*psai & 0x1000000)
-                ;
-
-	*psai =3D psaival;
-
-	return 0;
-
-}
-
-int=20
-es7000_stop_cpu(int cpu)
-{
-	int startup;
-
-	if (psai =3D=3D NULL)
-		return -1;
-
-	startup=3D (0x1000000 | cpu);
-
-	while ((*psai & 0xff00ffff) !=3D startup)
-		;
-
-	startup =3D (*psai & 0xff0000) >> 16;
-	*psai &=3D 0xffffff;
-
-	return 0;
-
-}
-
-void __init
-es7000_sw_apic()
-{
-	if (es7000_plat) {
-		int mip_status;
-		struct mip_reg es7000_mip_reg;
-
-		printk("ES7000: Enabling APIC mode.\n");
-        	memset(&es7000_mip_reg, 0, sizeof(struct mip_reg));
-        	es7000_mip_reg.off_0 =3D MIP_SW_APIC;
-        	es7000_mip_reg.off_38 =3D (MIP_VALID);
-        	while ((mip_status =3D es7000_mip_write(&es7000_mip_reg)) !=3D =
0)
-              		printk("es7000_sw_apic: command failed, status =3D =
%x\n",=20
-				mip_status);
-		return;
-	}
-}
diff -Naur linux-2.6.5-vanilla/arch/i386/mach-es7000/es7000.h =
linux-2.6.5/arch/i386/mach-es7000/es7000.h
--- linux-2.6.5-vanilla/arch/i386/mach-es7000/es7000.h	2004-05-03 =
08:58:55.000000000 -0400
+++ linux-2.6.5/arch/i386/mach-es7000/es7000.h	2004-05-03 =
11:12:08.000000000 -0400
@@ -104,7 +103,7 @@
 #define	MIP_SW_APIC		0x1020b
 #define	MIP_FUNC(VALUE) 	(VALUE & 0xff)
=20
-extern void parse_unisys_oem (char *oemptr, int oem_entries);
+extern int parse_unisys_oem (char *oemptr, int oem_entries);
 extern int find_unisys_acpi_oem_table(unsigned long *oem_addr, int =
*length);
 extern int es7000_start_cpu(int cpu, unsigned long eip);
 extern void es7000_sw_apic(void);
diff -Naur linux-2.6.5-vanilla/arch/i386/mach-es7000/es7000plat.c =
linux-2.6.5/arch/i386/mach-es7000/es7000plat.c
--- linux-2.6.5-vanilla/arch/i386/mach-es7000/es7000plat.c	1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.5/arch/i386/mach-es7000/es7000plat.c	2004-05-03 =
09:11:33.000000000 -0400
@@ -0,0 +1,280 @@
+/*
+ * Written by: Garry Forsgren, Unisys Corporation
+ *             Natalie Protasevich, Unisys Corporation
+ * This file contains the code to configure and interface=20
+ * with Unisys ES7000 series hardware system manager.
+ *
+ * Copyright (c) 2003 Unisys Corporation.  All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * You should have received a copy of the GNU General Public License =
along
+ * with this program; if not, write the Free Software Foundation, Inc., =
59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ *
+ * Contact information: Unisys Corporation, Township Line & Union =
Meeting=20
+ * Roads-A, Unisys Way, Blue Bell, Pennsylvania, 19424, or:
+ *
+ * http://www.unisys.com
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <asm/io.h>
+#include <asm/nmi.h>
+#include <asm/smp.h>
+#include <asm/apicdef.h>
+#include "es7000.h"
+
+/*
+ * ES7000 Globals
+ */
+
+volatile unsigned long	*psai =3D NULL;
+struct mip_reg		*mip_reg; =20
+struct mip_reg		*host_reg;
+int 			mip_port;
+unsigned long		mip_addr, host_addr;
+
+/*
+ * Parse the OEM Table
+ */
+
+int __init
+parse_unisys_oem (char *oemptr, int oem_entries)
+{
+	int                     i;
+	int 			success =3D 0;
+	unsigned char           type, size;
+	unsigned long           val;
+	char                    *tp =3D NULL; =20
+	struct psai             *psaip =3D NULL;
+	struct mip_reg_info 	*mi;
+	struct mip_reg		*host, *mip;
+
+	tp =3D oemptr;
+
+	tp +=3D 8;
+
+	for (i=3D0; i <=3D oem_entries; i++) {
+		type =3D *tp++;
+		size =3D *tp++;
+		tp -=3D 2;
+		switch (type) {
+		case MIP_REG:
+			mi =3D (struct mip_reg_info *)tp;
+			val =3D MIP_RD_LO(mi->host_reg);
+			host_addr =3D val;
+			host =3D (struct mip_reg *)val;
+			host_reg =3D __va(host);
+			val =3D MIP_RD_LO(mi->mip_reg);
+			mip_port =3D MIP_PORT(mi->mip_info);
+			mip_addr =3D val;
+			mip =3D (struct mip_reg *)val;
+			mip_reg =3D __va(mip);
+			Dprintk("es7000_mipcfg: host_reg =3D 0x%lx \n",=20
+				(unsigned long)host_reg);
+			Dprintk("es7000_mipcfg: mip_reg =3D 0x%lx \n",=20
+				(unsigned long)mip_reg);
+			success++;
+			break;
+		case MIP_PSAI_REG:
+			psaip =3D (struct psai *)tp;
+			if (tp !=3D NULL) {
+				if (psaip->addr)
+					psai =3D __va(psaip->addr);
+				else
+					psai =3D NULL;
+				success++;
+			}
+			break;
+		default:
+			break;
+		}
+		if (i =3D=3D 6) break;
+		tp +=3D size;
+	}
+
+	if (success < 2) {
+		printk("\nNo ES7000 found.\n");
+		es7000_plat =3D 0;
+	} else {
+		printk("\nEnabling ES7000 specific features...\n");
+		es7000_plat =3D 1;
+	}
+	return es7000_plat;
+}
+
+int __init=20
+find_unisys_acpi_oem_table(unsigned long *oem_addr, int *length)=20
+{
+	struct acpi_table_rsdp		*rsdp =3D NULL;
+	unsigned long			rsdp_phys =3D 0;
+	struct acpi_table_header 	*header =3D NULL;
+	int				i;
+	struct acpi_table_sdt		sdt;
+
+	rsdp_phys =3D acpi_find_rsdp();
+	rsdp =3D __va(rsdp_phys);
+	if (rsdp->rsdt_address) {
+		struct acpi_table_rsdt	*mapped_rsdt =3D NULL;
+		sdt.pa =3D rsdp->rsdt_address;
+
+		header =3D (struct acpi_table_header *)
+			__acpi_map_table(sdt.pa, sizeof(struct acpi_table_header));
+		if (!header)
+			return -ENODEV;
+
+		sdt.count =3D (header->length - sizeof(struct acpi_table_header)) >> =
3;
+		mapped_rsdt =3D (struct acpi_table_rsdt *)
+			__acpi_map_table(sdt.pa, header->length);
+		if (!mapped_rsdt)
+			return -ENODEV;
+
+		header =3D &mapped_rsdt->header;
+
+		for (i =3D 0; i < sdt.count; i++)
+			sdt.entry[i].pa =3D (unsigned long) mapped_rsdt->entry[i];
+	};
+	for (i =3D 0; i < sdt.count; i++) {
+
+		header =3D (struct acpi_table_header *)
+			__acpi_map_table(sdt.entry[i].pa,
+				sizeof(struct acpi_table_header));
+		if (!header)
+			continue;
+		if (!strncmp((char *) &header->signature, "OEM1", 4)) {
+			if (!strncmp((char *) &header->oem_id, "UNISYS", 6)) {
+				void *addr;
+				struct oem_table *t;
+				acpi_table_print(header, sdt.entry[i].pa);
+				t =3D (struct oem_table *) __acpi_map_table(sdt.entry[i].pa, =
header->length);
+				addr =3D (void *) __acpi_map_table(t->OEMTableAddr, =
t->OEMTableSize);
+				*length =3D header->length;
+				*oem_addr =3D (unsigned long) addr;
+				return 0;
+			}
+		}
+	}
+	printk("ES7000: did not find Unisys ACPI OEM table!\n");
+	return -1;
+}
+
+static void
+es7000_spin(int n)
+{
+	int i =3D 0;
+
+	while (i++ < n)=20
+		rep_nop();
+}
+
+static int __init
+es7000_mip_write(struct mip_reg *mip_reg)
+{
+	int			status =3D 0;
+	int			spin;
+
+	spin =3D MIP_SPIN;
+	while (((unsigned long long)host_reg->off_38 &
+		(unsigned long long)MIP_VALID) !=3D 0) {
+			if (--spin <=3D 0) {
+				printk("es7000_mip_write: Timeout waiting for Host Valid Flag");
+				return -1;
+			}
+		es7000_spin(MIP_SPIN);
+	}
+
+	memcpy(host_reg, mip_reg, sizeof(struct mip_reg));
+	outb(1, mip_port);
+
+	spin =3D MIP_SPIN;
+
+	while (((unsigned long long)mip_reg->off_38 &
+		(unsigned long long)MIP_VALID) =3D=3D 0) {
+		if (--spin <=3D 0) {
+			printk("es7000_mip_write: Timeout waiting for MIP Valid Flag");
+			return -1;
+		}
+		es7000_spin(MIP_SPIN);
+	}
+
+	status =3D ((unsigned long long)mip_reg->off_0 &
+		(unsigned long long)0xffff0000000000) >> 48;
+	mip_reg->off_38 =3D ((unsigned long long)mip_reg->off_38 &
+		(unsigned long long)~MIP_VALID);
+	return status;
+}
+
+int=20
+es7000_start_cpu(int cpu, unsigned long eip)
+{
+	unsigned long vect =3D 0, psaival =3D 0;
+
+	if (psai =3D=3D NULL)
+		return -1;
+
+	vect =3D ((unsigned long)__pa(eip)/0x1000) << 16;
+	psaival =3D (0x1000000 | vect | cpu);
+
+	while (*psai & 0x1000000)
+                ;
+
+	*psai =3D psaival;
+
+	return 0;
+
+}
+
+int=20
+es7000_stop_cpu(int cpu)
+{
+	int startup;
+
+	if (psai =3D=3D NULL)
+		return -1;
+
+	startup=3D (0x1000000 | cpu);
+
+	while ((*psai & 0xff00ffff) !=3D startup)
+		;
+
+	startup =3D (*psai & 0xff0000) >> 16;
+	*psai &=3D 0xffffff;
+
+	return 0;
+
+}
+
+void __init
+es7000_sw_apic()
+{
+	if (es7000_plat) {
+		int mip_status;
+		struct mip_reg es7000_mip_reg;
+
+		printk("ES7000: Enabling APIC mode.\n");
+        	memset(&es7000_mip_reg, 0, sizeof(struct mip_reg));
+        	es7000_mip_reg.off_0 =3D MIP_SW_APIC;
+        	es7000_mip_reg.off_38 =3D (MIP_VALID);
+        	while ((mip_status =3D es7000_mip_write(&es7000_mip_reg)) !=3D =
0)
+              		printk("es7000_sw_apic: command failed, status =3D =
%x\n",=20
+				mip_status);
+		return;
+	}
+}
diff -Naur linux-2.6.5-vanilla/arch/i386/mach-es7000/setup.c =
linux-2.6.5/arch/i386/mach-es7000/setup.c
--- linux-2.6.5-vanilla/arch/i386/mach-es7000/setup.c	2004-04-03 =
22:37:07.000000000 -0500
+++ linux-2.6.5/arch/i386/mach-es7000/setup.c	1969-12-31 =
19:00:00.000000000 -0500
@@ -1,105 +0,0 @@
-/*
- *	Machine specific setup for es7000
- */
-
-#include <linux/config.h>
-#include <linux/smp.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <asm/arch_hooks.h>
-
-/**
- * pre_intr_init_hook - initialisation prior to setting up interrupt =
vectors
- *
- * Description:
- *	Perform any necessary interrupt initialisation prior to setting up
- *	the "ordinary" interrupt call gates.  For legacy reasons, the ISA
- *	interrupts should be initialised here if the machine emulates a PC
- *	in any way.
- **/
-void __init pre_intr_init_hook(void)
-{
-	init_ISA_irqs();
-}
-
-/*
- * IRQ2 is cascade interrupt to second interrupt controller
- */
-static struct irqaction irq2 =3D { no_action, 0, 0, "cascade", NULL, =
NULL};
-
-/**
- * intr_init_hook - post gate setup interrupt initialisation
- *
- * Description:
- *	Fill in any interrupts that may have been left out by the general
- *	init_IRQ() routine.  interrupts having to do with the machine rather
- *	than the devices on the I/O bus (like APIC interrupts in intel MP
- *	systems) are started here.
- **/
-void __init intr_init_hook(void)
-{
-#ifdef CONFIG_X86_LOCAL_APIC
-	apic_intr_init();
-#endif
-
-	setup_irq(2, &irq2);
-}
-
-/**
- * pre_setup_arch_hook - hook called prior to any setup_arch() =
execution
- *
- * Description:
- *	generally used to activate any machine specific identification
- *	routines that may be needed before setup_arch() runs.  On VISWS
- *	this is used to get the board revision and type.
- **/
-void __init pre_setup_arch_hook(void)
-{
-}
-
-/**
- * trap_init_hook - initialise system specific traps
- *
- * Description:
- *	Called as the final act of trap_init().  Used in VISWS to initialise
- *	the various board specific APIC traps.
- **/
-void __init trap_init_hook(void)
-{
-}
-
-static struct irqaction irq0  =3D { timer_interrupt, SA_INTERRUPT, 0, =
"timer", NULL, NULL};
-
-/**
- * time_init_hook - do any specific initialisations for the system =
timer.
- *
- * Description:
- *	Must plug the system timer interrupt source at HZ into the IRQ =
listed
- *	in irq_vectors.h:TIMER_IRQ
- **/
-void __init time_init_hook(void)
-{
-	setup_irq(0, &irq0);
-}
-
-#ifdef CONFIG_MCA
-/**
- * mca_nmi_hook - hook into MCA specific NMI chain
- *
- * Description:
- *	The MCA (Microchannel Arcitecture) has an NMI chain for NMI sources
- *	along the MCA bus.  Use this to hook into that chain if you will =
need
- *	it.
- **/
-void __init mca_nmi_hook(void)
-{
-	/* If I recall correctly, there's a whole bunch of other things that
-	 * we can do to check for NMI problems, but that's all I know about
-	 * at the moment.
-	 */
-
-	printk("NMI generated from unknown source!\n");
-}
-
-#endif
diff -Naur linux-2.6.5-vanilla/arch/i386/mach-es7000/topology.c =
linux-2.6.5/arch/i386/mach-es7000/topology.c
--- linux-2.6.5-vanilla/arch/i386/mach-es7000/topology.c	2004-04-03 =
22:38:15.000000000 -0500
+++ linux-2.6.5/arch/i386/mach-es7000/topology.c	1969-12-31 =
19:00:00.000000000 -0500
@@ -1,64 +0,0 @@
-/*
- * arch/i386/mach-generic/topology.c - Populate driverfs with topology =
information
- *
- * Written by: Matthew Dobson, IBM Corporation
- * Original Code: Paul Dorwin, IBM Corporation, Patrick Mochel, OSDL
- *
- * Copyright (C) 2002, IBM Corp.
- *
- * All rights reserved.         =20
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send feedback to <colpatch@us.ibm.com>
- */
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <asm/cpu.h>
-
-struct i386_cpu cpu_devices[NR_CPUS];
-
-#ifdef CONFIG_NUMA
-#include <linux/mmzone.h>
-#include <asm/node.h>
-
-struct i386_node node_devices[MAX_NUMNODES];
-
-static int __init topology_init(void)
-{
-	int i;
-
-	for (i =3D 0; i < num_online_nodes(); i++)
-		arch_register_node(i);
-	for (i =3D 0; i < NR_CPUS; i++)
-		if (cpu_possible(i)) arch_register_cpu(i);
-	return 0;
-}
-
-#else /* !CONFIG_NUMA */
-
-static int __init topology_init(void)
-{
-	int i;
-
-	for (i =3D 0; i < NR_CPUS; i++)
-		if (cpu_possible(i)) arch_register_cpu(i);
-	return 0;
-}
-
-#endif /* CONFIG_NUMA */
-
-subsys_initcall(topology_init);
diff -Naur linux-2.6.5-vanilla/arch/i386/mach-generic/Makefile =
linux-2.6.5/arch/i386/mach-generic/Makefile
--- linux-2.6.5-vanilla/arch/i386/mach-generic/Makefile	2004-04-03 =
22:37:23.000000000 -0500
+++ linux-2.6.5/arch/i386/mach-generic/Makefile	2004-05-03 =
09:11:33.000000000 -0400
@@ -4,15 +4,4 @@
=20
 EXTRA_CFLAGS	+=3D -I../kernel
=20
-obj-y				:=3D probe.o summit.o bigsmp.o default.o
-
-
-#
-# Makefile for the generic architecture
-#
-
-EXTRA_CFLAGS	+=3D -I../kernel
-
-obj-y				:=3D probe.o summit.o bigsmp.o default.o
-
-
+obj-y				:=3D probe.o summit.o bigsmp.o es7000.o default.o =
../mach-es7000/
diff -Naur linux-2.6.5-vanilla/arch/i386/mach-generic/es7000.c =
linux-2.6.5/arch/i386/mach-generic/es7000.c
--- linux-2.6.5-vanilla/arch/i386/mach-generic/es7000.c	1969-12-31 =
19:00:00.000000000 -0500
+++ linux-2.6.5/arch/i386/mach-generic/es7000.c	2004-05-03 =
09:11:33.000000000 -0400
@@ -0,0 +1,28 @@
+/*=20
+ * APIC driver for the Unisys ES7000 chipset.
+ */
+#define APIC_DEFINITION 1
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <linux/cpumask.h>
+#include <asm/mpspec.h>
+#include <asm/genapic.h>
+#include <asm/fixmap.h>
+#include <asm/apicdef.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <asm/mach-es7000/mach_apicdef.h>
+#include <asm/mach-es7000/mach_apic.h>
+#include <asm/mach-es7000/mach_ipi.h>
+#include <asm/mach-es7000/mach_mpparse.h>
+#include <asm/mach-es7000/mach_wakecpu.h>
+
+static __init int probe_es7000(void)
+{=20
+	/* probed later in mptable/ACPI hooks */
+	return 0;
+}=20
+
+struct genapic apic_es7000 =3D APIC_INIT("es7000", probe_es7000);=20
diff -Naur linux-2.6.5-vanilla/arch/i386/mach-generic/probe.c =
linux-2.6.5/arch/i386/mach-generic/probe.c
--- linux-2.6.5-vanilla/arch/i386/mach-generic/probe.c	2004-04-03 =
22:36:16.000000000 -0500
+++ linux-2.6.5/arch/i386/mach-generic/probe.c	2004-05-03 =
09:11:33.000000000 -0400
@@ -17,6 +17,7 @@
=20
 extern struct genapic apic_summit;
 extern struct genapic apic_bigsmp;
+extern struct genapic apic_es7000;
 extern struct genapic apic_default;
=20
 struct genapic *genapic =3D &apic_default;
@@ -24,6 +25,7 @@
 struct genapic *apic_probe[] __initdata =3D {=20
 	&apic_summit,
 	&apic_bigsmp,=20
+	&apic_es7000,
 	&apic_default,	/* must be last */
 	NULL,
 };
diff -Naur linux-2.6.5-vanilla/include/asm-i386/genapic.h =
linux-2.6.5/include/asm-i386/genapic.h
--- linux-2.6.5-vanilla/include/asm-i386/genapic.h	2004-04-03 =
22:37:23.000000000 -0500
+++ linux-2.6.5/include/asm-i386/genapic.h	2004-05-03 09:20:03.000000000 =
-0400
@@ -26,7 +26,8 @@
 	int int_delivery_mode;
 	int int_dest_mode;=20
 	int apic_broadcast_id;=20
-	int esr_disable;
+	int ESR_DISABLE;
+	int apic_destination_logical;
 	unsigned long (*check_apicid_used)(physid_mask_t bitmap, int apicid);
 	unsigned long (*check_apicid_present)(int apicid);=20
 	int no_balance_irq;
@@ -80,6 +81,8 @@
 	.apic_broadcast_id =3D APIC_BROADCAST_ID, \
 	.no_balance_irq =3D NO_BALANCE_IRQ, \
 	.no_ioapic_check =3D NO_IOAPIC_CHECK, \
+	.ESR_DISABLE =3D esr_disable, \
+	.apic_destination_logical =3D APIC_DEST_LOGICAL, \
 	APICFUNC(apic_id_registered), \
 	APICFUNC(target_cpus), \
 	APICFUNC(check_apicid_used), \
diff -Naur linux-2.6.5-vanilla/include/asm-i386/mach-es7000/mach_ipi.h =
linux-2.6.5/include/asm-i386/mach-es7000/mach_ipi.h
--- linux-2.6.5-vanilla/include/asm-i386/mach-es7000/mach_ipi.h	=
2004-04-03 22:36:55.000000000 -0500
+++ linux-2.6.5/include/asm-i386/mach-es7000/mach_ipi.h	2004-05-03 =
09:12:00.000000000 -0400
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_IPI_H
 #define __ASM_MACH_IPI_H
=20
-static inline void send_IPI_mask_sequence(cpumask_t mask, int vector);
+inline void send_IPI_mask_sequence(cpumask_t mask, int vector);
=20
 static inline void send_IPI_mask(cpumask_t mask, int vector)
 {
diff -Naur =
linux-2.6.5-vanilla/include/asm-i386/mach-es7000/mach_mpparse.h =
linux-2.6.5/include/asm-i386/mach-es7000/mach_mpparse.h
--- linux-2.6.5-vanilla/include/asm-i386/mach-es7000/mach_mpparse.h	=
2004-04-03 22:36:13.000000000 -0500
+++ linux-2.6.5/include/asm-i386/mach-es7000/mach_mpparse.h	2004-05-03 =
09:12:00.000000000 -0400
@@ -12,26 +12,28 @@
 {
 }
=20
-extern void parse_unisys_oem (char *oemptr, int oem_entries);
+extern int parse_unisys_oem (char *oemptr, int oem_entries);
 extern int find_unisys_acpi_oem_table(unsigned long *oem_addr, int =
*length);
=20
-static inline void mps_oem_check(struct mp_config_table *mpc, char =
*oem,=20
+static inline int mps_oem_check(struct mp_config_table *mpc, char *oem, =

 		char *productid)
 {
 	if (mpc->mpc_oemptr) {
 		struct mp_config_oemtable *oem_table =3D=20
 			(struct mp_config_oemtable *)mpc->mpc_oemptr;
-		parse_unisys_oem((char *)oem_table, oem_table->oem_length);
+		return parse_unisys_oem((char *)oem_table, oem_table->oem_length);
 	}
+	return 0;
 }
=20
 /* Hook from generic ACPI tables.c */
-static inline void acpi_madt_oem_check(char *oem_id, char =
*oem_table_id)
+static inline int acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
 	unsigned long oem_addr;=20
 	int oem_entries;
 	if (!find_unisys_acpi_oem_table(&oem_addr, &oem_entries))
-		parse_unisys_oem((char *)oem_addr, oem_entries);
+		return parse_unisys_oem((char *)oem_addr, oem_entries);
+	return 0;
 }
=20
=20
diff -Naur linux-2.6.5-vanilla/include/asm-i386/mach-generic/mach_apic.h =
linux-2.6.5/include/asm-i386/mach-generic/mach_apic.h
--- linux-2.6.5-vanilla/include/asm-i386/mach-generic/mach_apic.h	=
2004-04-03 22:36:56.000000000 -0500
+++ linux-2.6.5/include/asm-i386/mach-generic/mach_apic.h	2004-05-03 =
09:20:41.000000000 -0400
@@ -3,15 +3,16 @@
=20
 #include <asm/genapic.h>
=20
-#define esr_disable (genapic->esr_disable)
+#define esr_disable (genapic->ESR_DISABLE)
 #define NO_BALANCE_IRQ (genapic->no_balance_irq)
 #define NO_IOAPIC_CHECK	(genapic->no_ioapic_check)
 #define APIC_BROADCAST_ID (genapic->apic_broadcast_id)
 #define INT_DELIVERY_MODE (genapic->int_delivery_mode)
 #define INT_DEST_MODE (genapic->int_dest_mode)
+#undef APIC_DEST_LOGICAL
+#define APIC_DEST_LOGICAL (genapic->apic_destination_logical)
 #define TARGET_CPUS	  (genapic->target_cpus())
 #define apic_id_registered (genapic->apic_id_registered)
-#define apic_id_registered (genapic->apic_id_registered)
 #define init_apic_ldr (genapic->init_apic_ldr)
 #define ioapic_phys_id_map (genapic->ioapic_phys_id_map)
 #define clustered_apic_check (genapic->clustered_apic_check)=20


-------------------------------------------------------------------------=
------------------------------------

 <<genapic-2.6.5.patch>>=20

------_=_NextPart_001_01C43188.6B76E757
Content-Type: application/octet-stream;
	name="genapic-2.6.5.patch"
Content-Transfer-Encoding: base64
Content-Description: genapic-2.6.5.patch
Content-Disposition: attachment;
	filename="genapic-2.6.5.patch"

ZGlmZiAtTmF1ciBsaW51eC0yLjYuNS12YW5pbGxhL2FyY2gvaTM4Ni9LY29uZmlnIGxpbnV4LTIu
Ni41L2FyY2gvaTM4Ni9LY29uZmlnCi0tLSBsaW51eC0yLjYuNS12YW5pbGxhL2FyY2gvaTM4Ni9L
Y29uZmlnCTIwMDQtMDQtMDMgMjI6MzY6MjUuMDAwMDAwMDAwIC0wNTAwCisrKyBsaW51eC0yLjYu
NS9hcmNoL2kzODYvS2NvbmZpZwkyMDA0LTA1LTAzIDE2OjQ4OjUwLjAwMDAwMDAwMCAtMDQwMApA
QCAtMTAyLDEwICsxMDIsMTAgQEAKIAkgIGFuZCB2aWNlIHZlcnNhLiBTZWUgPGZpbGU6RG9jdW1l
bnRhdGlvbi9zZ2ktdmlzd3MudHh0PiBmb3IgZGV0YWlscy4KIAogY29uZmlnIFg4Nl9HRU5FUklD
QVJDSAotICAgICAgIGJvb2wgIkdlbmVyaWMgYXJjaGl0ZWN0dXJlIChTdW1taXQsIGJpZ3NtcCwg
ZGVmYXVsdCkiCisgICAgICAgYm9vbCAiR2VuZXJpYyBhcmNoaXRlY3R1cmUgKFN1bW1pdCwgYmln
c21wLCBFUzcwMDAsIGRlZmF1bHQpIgogICAgICAgIGRlcGVuZHMgb24gU01QCiAgICAgICAgaGVs
cAotICAgICAgICAgIFRoaXMgb3B0aW9uIGNvbXBpbGVzIGluIHRoZSBTdW1taXQsIGJpZ3NtcCwg
ZGVmYXVsdCBzdWJhcmNoaXRlY3R1cmVzLgorICAgICAgICAgIFRoaXMgb3B0aW9uIGNvbXBpbGVz
IGluIHRoZSBTdW1taXQsIGJpZ3NtcCwgRVM3MDAwLCBkZWZhdWx0IHN1YmFyY2hpdGVjdHVyZXMu
CiAJICBJdCBpcyBpbnRlbmRlZCBmb3IgYSBnZW5lcmljIGJpbmFyeSBrZXJuZWwuCiAKIGNvbmZp
ZyBYODZfRVM3MDAwCmRpZmYgLU5hdXIgbGludXgtMi42LjUtdmFuaWxsYS9hcmNoL2kzODYvTWFr
ZWZpbGUgbGludXgtMi42LjUvYXJjaC9pMzg2L01ha2VmaWxlCi0tLSBsaW51eC0yLjYuNS12YW5p
bGxhL2FyY2gvaTM4Ni9NYWtlZmlsZQkyMDA0LTA0LTAzIDIyOjM2OjU2LjAwMDAwMDAwMCAtMDUw
MAorKysgbGludXgtMi42LjUvYXJjaC9pMzg2L01ha2VmaWxlCTIwMDQtMDUtMDMgMDk6MTE6MTgu
MDAwMDAwMDAwIC0wNDAwCkBAIC05Miw3ICs5Miw4IEBACiAKICMgRVM3MDAwIHN1YmFyY2ggc3Vw
cG9ydAogbWZsYWdzLSQoQ09ORklHX1g4Nl9FUzcwMDApCTo9IC1JaW5jbHVkZS9hc20taTM4Ni9t
YWNoLWVzNzAwMAotbWNvcmUtJChDT05GSUdfWDg2X0VTNzAwMCkJOj0gbWFjaC1lczcwMDAKK21j
b3JlLSQoQ09ORklHX1g4Nl9FUzcwMDApCTo9IG1hY2gtZGVmYXVsdAorY29yZS0kKENPTkZJR19Y
ODZfRVM3MDAwKQk6PSBhcmNoL2kzODYvbWFjaC1lczcwMDAvCiAKICMgZGVmYXVsdCBzdWJhcmNo
IC5oIGZpbGVzCiBtZmxhZ3MteSArPSAtSWluY2x1ZGUvYXNtLWkzODYvbWFjaC1kZWZhdWx0CmRp
ZmYgLU5hdXIgbGludXgtMi42LjUtdmFuaWxsYS9hcmNoL2kzODYvbWFjaC1lczcwMDAvTWFrZWZp
bGUgbGludXgtMi42LjUvYXJjaC9pMzg2L21hY2gtZXM3MDAwL01ha2VmaWxlCi0tLSBsaW51eC0y
LjYuNS12YW5pbGxhL2FyY2gvaTM4Ni9tYWNoLWVzNzAwMC9NYWtlZmlsZQkyMDA0LTA0LTAzIDIy
OjM3OjA3LjAwMDAwMDAwMCAtMDUwMAorKysgbGludXgtMi42LjUvYXJjaC9pMzg2L21hY2gtZXM3
MDAwL01ha2VmaWxlCTIwMDQtMDUtMDMgMDk6MTE6MTguMDAwMDAwMDAwIC0wNDAwCkBAIC0yLDQg
KzIsNSBAQAogIyBNYWtlZmlsZSBmb3IgdGhlIGxpbnV4IGtlcm5lbC4KICMKIAotb2JqLXkJCTo9
IHNldHVwLm8gdG9wb2xvZ3kubyBlczcwMDAubworb2JqLSQoQ09ORklHX1g4Nl9FUzcwMDApCTo9
IGVzNzAwMHBsYXQubworb2JqLSQoQ09ORklHX1g4Nl9HRU5FUklDQVJDSCkJOj0gZXM3MDAwcGxh
dC5vCmRpZmYgLU5hdXIgbGludXgtMi42LjUtdmFuaWxsYS9hcmNoL2kzODYvbWFjaC1lczcwMDAv
ZXM3MDAwLmMgbGludXgtMi42LjUvYXJjaC9pMzg2L21hY2gtZXM3MDAwL2VzNzAwMC5jCi0tLSBs
aW51eC0yLjYuNS12YW5pbGxhL2FyY2gvaTM4Ni9tYWNoLWVzNzAwMC9lczcwMDAuYwkyMDA0LTA1
LTAzIDA4OjU4OjU1LjAwMDAwMDAwMCAtMDQwMAorKysgbGludXgtMi42LjUvYXJjaC9pMzg2L21h
Y2gtZXM3MDAwL2VzNzAwMC5jCTE5NjktMTItMzEgMTk6MDA6MDAuMDAwMDAwMDAwIC0wNTAwCkBA
IC0xLDI4MCArMCwwIEBACi0vKgotICogV3JpdHRlbiBieTogR2FycnkgRm9yc2dyZW4sIFVuaXN5
cyBDb3Jwb3JhdGlvbgotICogICAgICAgICAgICAgTmF0YWxpZSBQcm90YXNldmljaCwgVW5pc3lz
IENvcnBvcmF0aW9uCi0gKiBUaGlzIGZpbGUgY29udGFpbnMgdGhlIGNvZGUgdG8gY29uZmlndXJl
IGFuZCBpbnRlcmZhY2UgCi0gKiB3aXRoIFVuaXN5cyBFUzcwMDAgc2VyaWVzIGhhcmR3YXJlIHN5
c3RlbSBtYW5hZ2VyLgotICoKLSAqIENvcHlyaWdodCAoYykgMjAwMyBVbmlzeXMgQ29ycG9yYXRp
b24uICBBbGwgUmlnaHRzIFJlc2VydmVkLgotICoKLSAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0Ci0gKiB1bmRl
ciB0aGUgdGVybXMgb2YgdmVyc2lvbiAyIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBhcwotICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCi0gKgot
ICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd291bGQg
YmUgdXNlZnVsLCBidXQKLSAqIFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhl
IGltcGxpZWQgd2FycmFudHkgb2YKLSAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBB
IFBBUlRJQ1VMQVIgUFVSUE9TRS4KLSAqCi0gKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBj
b3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZwotICogd2l0aCB0aGlz
IHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgSW5j
LiwgNTkKLSAqIFRlbXBsZSBQbGFjZSAtIFN1aXRlIDMzMCwgQm9zdG9uIE1BIDAyMTExLTEzMDcs
IFVTQS4KLSAqCi0gKiBDb250YWN0IGluZm9ybWF0aW9uOiBVbmlzeXMgQ29ycG9yYXRpb24sIFRv
d25zaGlwIExpbmUgJiBVbmlvbiBNZWV0aW5nIAotICogUm9hZHMtQSwgVW5pc3lzIFdheSwgQmx1
ZSBCZWxsLCBQZW5uc3lsdmFuaWEsIDE5NDI0LCBvcjoKLSAqCi0gKiBodHRwOi8vd3d3LnVuaXN5
cy5jb20KLSAqLwotCi0jaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Ci0jaW5jbHVkZSA8bGludXgv
dHlwZXMuaD4KLSNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KLSNpbmNsdWRlIDxsaW51eC9zbXAu
aD4KLSNpbmNsdWRlIDxsaW51eC9zdHJpbmcuaD4KLSNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5o
PgotI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+Ci0jaW5jbHVkZSA8bGludXgvbm90aWZpZXIuaD4K
LSNpbmNsdWRlIDxsaW51eC9yZWJvb3QuaD4KLSNpbmNsdWRlIDxsaW51eC9pbml0Lmg+Ci0jaW5j
bHVkZSA8bGludXgvYWNwaS5oPgotI2luY2x1ZGUgPGFzbS9pby5oPgotI2luY2x1ZGUgPGFzbS9u
bWkuaD4KLSNpbmNsdWRlIDxhc20vc21wLmg+Ci0jaW5jbHVkZSA8YXNtL2FwaWNkZWYuaD4KLSNp
bmNsdWRlICJlczcwMDAuaCIKLQotLyoKLSAqIEVTNzAwMCBHbG9iYWxzCi0gKi8KLQotdm9sYXRp
bGUgdW5zaWduZWQgbG9uZwkqcHNhaSA9IE5VTEw7Ci1zdHJ1Y3QgbWlwX3JlZwkJKm1pcF9yZWc7
ICAKLXN0cnVjdCBtaXBfcmVnCQkqaG9zdF9yZWc7Ci1pbnQgCQkJbWlwX3BvcnQ7Ci11bnNpZ25l
ZCBsb25nCQltaXBfYWRkciwgaG9zdF9hZGRyOwotCi0vKgotICogUGFyc2UgdGhlIE9FTSBUYWJs
ZQotICovCi0KLXZvaWQgX19pbml0Ci1wYXJzZV91bmlzeXNfb2VtIChjaGFyICpvZW1wdHIsIGlu
dCBvZW1fZW50cmllcykKLXsKLQlpbnQgICAgICAgICAgICAgICAgICAgICBpOwotCWludCAJCQlz
dWNjZXNzID0gMDsKLQl1bnNpZ25lZCBjaGFyICAgICAgICAgICB0eXBlLCBzaXplOwotCXVuc2ln
bmVkIGxvbmcgICAgICAgICAgIHZhbDsKLQljaGFyICAgICAgICAgICAgICAgICAgICAqdHAgPSBO
VUxMOyAgCi0Jc3RydWN0IHBzYWkgICAgICAgICAgICAgKnBzYWlwID0gTlVMTDsKLQlzdHJ1Y3Qg
bWlwX3JlZ19pbmZvIAkqbWk7Ci0Jc3RydWN0IG1pcF9yZWcJCSpob3N0LCAqbWlwOwotCi0JdHAg
PSBvZW1wdHI7Ci0KLQl0cCArPSA4OwotCi0JZm9yIChpPTA7IGkgPD0gb2VtX2VudHJpZXM7IGkr
KykgewotCQl0eXBlID0gKnRwKys7Ci0JCXNpemUgPSAqdHArKzsKLQkJdHAgLT0gMjsKLQkJc3dp
dGNoICh0eXBlKSB7Ci0JCWNhc2UgTUlQX1JFRzoKLQkJCW1pID0gKHN0cnVjdCBtaXBfcmVnX2lu
Zm8gKil0cDsKLQkJCXZhbCA9IE1JUF9SRF9MTyhtaS0+aG9zdF9yZWcpOwotCQkJaG9zdF9hZGRy
ID0gdmFsOwotCQkJaG9zdCA9IChzdHJ1Y3QgbWlwX3JlZyAqKXZhbDsKLQkJCWhvc3RfcmVnID0g
X192YShob3N0KTsKLQkJCXZhbCA9IE1JUF9SRF9MTyhtaS0+bWlwX3JlZyk7Ci0JCQltaXBfcG9y
dCA9IE1JUF9QT1JUKG1pLT5taXBfaW5mbyk7Ci0JCQltaXBfYWRkciA9IHZhbDsKLQkJCW1pcCA9
IChzdHJ1Y3QgbWlwX3JlZyAqKXZhbDsKLQkJCW1pcF9yZWcgPSBfX3ZhKG1pcCk7Ci0JCQlEcHJp
bnRrKCJlczcwMDBfbWlwY2ZnOiBob3N0X3JlZyA9IDB4JWx4IFxuIiwgCi0JCQkJKHVuc2lnbmVk
IGxvbmcpaG9zdF9yZWcpOwotCQkJRHByaW50aygiZXM3MDAwX21pcGNmZzogbWlwX3JlZyA9IDB4
JWx4IFxuIiwgCi0JCQkJKHVuc2lnbmVkIGxvbmcpbWlwX3JlZyk7Ci0JCQlzdWNjZXNzKys7Ci0J
CQlicmVhazsKLQkJY2FzZSBNSVBfUFNBSV9SRUc6Ci0JCQlwc2FpcCA9IChzdHJ1Y3QgcHNhaSAq
KXRwOwotCQkJaWYgKHRwICE9IE5VTEwpIHsKLQkJCQlpZiAocHNhaXAtPmFkZHIpCi0JCQkJCXBz
YWkgPSBfX3ZhKHBzYWlwLT5hZGRyKTsKLQkJCQllbHNlCi0JCQkJCXBzYWkgPSBOVUxMOwotCQkJ
CXN1Y2Nlc3MrKzsKLQkJCX0KLQkJCWJyZWFrOwotCQlkZWZhdWx0OgotCQkJYnJlYWs7Ci0JCX0K
LQkJaWYgKGkgPT0gNikgYnJlYWs7Ci0JCXRwICs9IHNpemU7Ci0JfQotCi0JaWYgKHN1Y2Nlc3Mg
PCAyKSB7Ci0JCXByaW50aygiXG5ObyBFUzcwMDAgZm91bmQuXG4iKTsKLQkJZXM3MDAwX3BsYXQg
PSAwOwotCX0gZWxzZSB7Ci0JCXByaW50aygiXG5FbmFibGluZyBFUzcwMDAgc3BlY2lmaWMgZmVh
dHVyZXMuLi5cbiIpOwotCQllczcwMDBfcGxhdCA9IDE7Ci0JfQotCXJldHVybjsKLX0KLQotaW50
IF9faW5pdCAKLWZpbmRfdW5pc3lzX2FjcGlfb2VtX3RhYmxlKHVuc2lnbmVkIGxvbmcgKm9lbV9h
ZGRyLCBpbnQgKmxlbmd0aCkgCi17Ci0Jc3RydWN0IGFjcGlfdGFibGVfcnNkcAkJKnJzZHAgPSBO
VUxMOwotCXVuc2lnbmVkIGxvbmcJCQlyc2RwX3BoeXMgPSAwOwotCXN0cnVjdCBhY3BpX3RhYmxl
X2hlYWRlciAJKmhlYWRlciA9IE5VTEw7Ci0JaW50CQkJCWk7Ci0Jc3RydWN0IGFjcGlfdGFibGVf
c2R0CQlzZHQ7Ci0KLQlyc2RwX3BoeXMgPSBhY3BpX2ZpbmRfcnNkcCgpOwotCXJzZHAgPSBfX3Zh
KHJzZHBfcGh5cyk7Ci0JaWYgKHJzZHAtPnJzZHRfYWRkcmVzcykgewotCQlzdHJ1Y3QgYWNwaV90
YWJsZV9yc2R0CSptYXBwZWRfcnNkdCA9IE5VTEw7Ci0JCXNkdC5wYSA9IHJzZHAtPnJzZHRfYWRk
cmVzczsKLQotCQloZWFkZXIgPSAoc3RydWN0IGFjcGlfdGFibGVfaGVhZGVyICopCi0JCQlfX2Fj
cGlfbWFwX3RhYmxlKHNkdC5wYSwgc2l6ZW9mKHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlcikpOwot
CQlpZiAoIWhlYWRlcikKLQkJCXJldHVybiAtRU5PREVWOwotCi0JCXNkdC5jb3VudCA9IChoZWFk
ZXItPmxlbmd0aCAtIHNpemVvZihzdHJ1Y3QgYWNwaV90YWJsZV9oZWFkZXIpKSA+PiAzOwotCQlt
YXBwZWRfcnNkdCA9IChzdHJ1Y3QgYWNwaV90YWJsZV9yc2R0ICopCi0JCQlfX2FjcGlfbWFwX3Rh
YmxlKHNkdC5wYSwgaGVhZGVyLT5sZW5ndGgpOwotCQlpZiAoIW1hcHBlZF9yc2R0KQotCQkJcmV0
dXJuIC1FTk9ERVY7Ci0KLQkJaGVhZGVyID0gJm1hcHBlZF9yc2R0LT5oZWFkZXI7Ci0KLQkJZm9y
IChpID0gMDsgaSA8IHNkdC5jb3VudDsgaSsrKQotCQkJc2R0LmVudHJ5W2ldLnBhID0gKHVuc2ln
bmVkIGxvbmcpIG1hcHBlZF9yc2R0LT5lbnRyeVtpXTsKLQl9OwotCWZvciAoaSA9IDA7IGkgPCBz
ZHQuY291bnQ7IGkrKykgewotCi0JCWhlYWRlciA9IChzdHJ1Y3QgYWNwaV90YWJsZV9oZWFkZXIg
KikKLQkJCV9fYWNwaV9tYXBfdGFibGUoc2R0LmVudHJ5W2ldLnBhLAotCQkJCXNpemVvZihzdHJ1
Y3QgYWNwaV90YWJsZV9oZWFkZXIpKTsKLQkJaWYgKCFoZWFkZXIpCi0JCQljb250aW51ZTsKLQkJ
aWYgKCFzdHJuY21wKChjaGFyICopICZoZWFkZXItPnNpZ25hdHVyZSwgIk9FTTEiLCA0KSkgewot
CQkJaWYgKCFzdHJuY21wKChjaGFyICopICZoZWFkZXItPm9lbV9pZCwgIlVOSVNZUyIsIDYpKSB7
Ci0JCQkJdm9pZCAqYWRkcjsKLQkJCQlzdHJ1Y3Qgb2VtX3RhYmxlICp0OwotCQkJCWFjcGlfdGFi
bGVfcHJpbnQoaGVhZGVyLCBzZHQuZW50cnlbaV0ucGEpOwotCQkJCXQgPSAoc3RydWN0IG9lbV90
YWJsZSAqKSBfX2FjcGlfbWFwX3RhYmxlKHNkdC5lbnRyeVtpXS5wYSwgaGVhZGVyLT5sZW5ndGgp
OwotCQkJCWFkZHIgPSAodm9pZCAqKSBfX2FjcGlfbWFwX3RhYmxlKHQtPk9FTVRhYmxlQWRkciwg
dC0+T0VNVGFibGVTaXplKTsKLQkJCQkqbGVuZ3RoID0gaGVhZGVyLT5sZW5ndGg7Ci0JCQkJKm9l
bV9hZGRyID0gKHVuc2lnbmVkIGxvbmcpIGFkZHI7Ci0JCQkJcmV0dXJuIDA7Ci0JCQl9Ci0JCX0K
LQl9Ci0JcHJpbnRrKCJFUzcwMDA6IGRpZCBub3QgZmluZCBVbmlzeXMgQUNQSSBPRU0gdGFibGUh
XG4iKTsKLQlyZXR1cm4gLTE7Ci19Ci0KLXN0YXRpYyB2b2lkCi1lczcwMDBfc3BpbihpbnQgbikK
LXsKLQlpbnQgaSA9IDA7Ci0KLQl3aGlsZSAoaSsrIDwgbikgCi0JCXJlcF9ub3AoKTsKLX0KLQot
c3RhdGljIGludCBfX2luaXQKLWVzNzAwMF9taXBfd3JpdGUoc3RydWN0IG1pcF9yZWcgKm1pcF9y
ZWcpCi17Ci0JaW50CQkJc3RhdHVzID0gMDsKLQlpbnQJCQlzcGluOwotCi0Jc3BpbiA9IE1JUF9T
UElOOwotCXdoaWxlICgoKHVuc2lnbmVkIGxvbmcgbG9uZylob3N0X3JlZy0+b2ZmXzM4ICYKLQkJ
KHVuc2lnbmVkIGxvbmcgbG9uZylNSVBfVkFMSUQpICE9IDApIHsKLQkJCWlmICgtLXNwaW4gPD0g
MCkgewotCQkJCXByaW50aygiZXM3MDAwX21pcF93cml0ZTogVGltZW91dCB3YWl0aW5nIGZvciBI
b3N0IFZhbGlkIEZsYWciKTsKLQkJCQlyZXR1cm4gLTE7Ci0JCQl9Ci0JCWVzNzAwMF9zcGluKE1J
UF9TUElOKTsKLQl9Ci0KLQltZW1jcHkoaG9zdF9yZWcsIG1pcF9yZWcsIHNpemVvZihzdHJ1Y3Qg
bWlwX3JlZykpOwotCW91dGIoMSwgbWlwX3BvcnQpOwotCi0Jc3BpbiA9IE1JUF9TUElOOwotCi0J
d2hpbGUgKCgodW5zaWduZWQgbG9uZyBsb25nKW1pcF9yZWctPm9mZl8zOCAmCi0JCSh1bnNpZ25l
ZCBsb25nIGxvbmcpTUlQX1ZBTElEKSA9PSAwKSB7Ci0JCWlmICgtLXNwaW4gPD0gMCkgewotCQkJ
cHJpbnRrKCJlczcwMDBfbWlwX3dyaXRlOiBUaW1lb3V0IHdhaXRpbmcgZm9yIE1JUCBWYWxpZCBG
bGFnIik7Ci0JCQlyZXR1cm4gLTE7Ci0JCX0KLQkJZXM3MDAwX3NwaW4oTUlQX1NQSU4pOwotCX0K
LQotCXN0YXR1cyA9ICgodW5zaWduZWQgbG9uZyBsb25nKW1pcF9yZWctPm9mZl8wICYKLQkJKHVu
c2lnbmVkIGxvbmcgbG9uZykweGZmZmYwMDAwMDAwMDAwKSA+PiA0ODsKLQltaXBfcmVnLT5vZmZf
MzggPSAoKHVuc2lnbmVkIGxvbmcgbG9uZyltaXBfcmVnLT5vZmZfMzggJgotCQkodW5zaWduZWQg
bG9uZyBsb25nKX5NSVBfVkFMSUQpOwotCXJldHVybiBzdGF0dXM7Ci19Ci0KLWludCAKLWVzNzAw
MF9zdGFydF9jcHUoaW50IGNwdSwgdW5zaWduZWQgbG9uZyBlaXApCi17Ci0JdW5zaWduZWQgbG9u
ZyB2ZWN0ID0gMCwgcHNhaXZhbCA9IDA7Ci0KLQlpZiAocHNhaSA9PSBOVUxMKQotCQlyZXR1cm4g
LTE7Ci0KLQl2ZWN0ID0gKCh1bnNpZ25lZCBsb25nKV9fcGEoZWlwKS8weDEwMDApIDw8IDE2Owot
CXBzYWl2YWwgPSAoMHgxMDAwMDAwIHwgdmVjdCB8IGNwdSk7Ci0KLQl3aGlsZSAoKnBzYWkgJiAw
eDEwMDAwMDApCi0gICAgICAgICAgICAgICAgOwotCi0JKnBzYWkgPSBwc2FpdmFsOwotCi0JcmV0
dXJuIDA7Ci0KLX0KLQotaW50IAotZXM3MDAwX3N0b3BfY3B1KGludCBjcHUpCi17Ci0JaW50IHN0
YXJ0dXA7Ci0KLQlpZiAocHNhaSA9PSBOVUxMKQotCQlyZXR1cm4gLTE7Ci0KLQlzdGFydHVwPSAo
MHgxMDAwMDAwIHwgY3B1KTsKLQotCXdoaWxlICgoKnBzYWkgJiAweGZmMDBmZmZmKSAhPSBzdGFy
dHVwKQotCQk7Ci0KLQlzdGFydHVwID0gKCpwc2FpICYgMHhmZjAwMDApID4+IDE2OwotCSpwc2Fp
ICY9IDB4ZmZmZmZmOwotCi0JcmV0dXJuIDA7Ci0KLX0KLQotdm9pZCBfX2luaXQKLWVzNzAwMF9z
d19hcGljKCkKLXsKLQlpZiAoZXM3MDAwX3BsYXQpIHsKLQkJaW50IG1pcF9zdGF0dXM7Ci0JCXN0
cnVjdCBtaXBfcmVnIGVzNzAwMF9taXBfcmVnOwotCi0JCXByaW50aygiRVM3MDAwOiBFbmFibGlu
ZyBBUElDIG1vZGUuXG4iKTsKLSAgICAgICAgCW1lbXNldCgmZXM3MDAwX21pcF9yZWcsIDAsIHNp
emVvZihzdHJ1Y3QgbWlwX3JlZykpOwotICAgICAgICAJZXM3MDAwX21pcF9yZWcub2ZmXzAgPSBN
SVBfU1dfQVBJQzsKLSAgICAgICAgCWVzNzAwMF9taXBfcmVnLm9mZl8zOCA9IChNSVBfVkFMSUQp
OwotICAgICAgICAJd2hpbGUgKChtaXBfc3RhdHVzID0gZXM3MDAwX21pcF93cml0ZSgmZXM3MDAw
X21pcF9yZWcpKSAhPSAwKQotICAgICAgICAgICAgICAJCXByaW50aygiZXM3MDAwX3N3X2FwaWM6
IGNvbW1hbmQgZmFpbGVkLCBzdGF0dXMgPSAleFxuIiwgCi0JCQkJbWlwX3N0YXR1cyk7Ci0JCXJl
dHVybjsKLQl9Ci19CmRpZmYgLU5hdXIgbGludXgtMi42LjUtdmFuaWxsYS9hcmNoL2kzODYvbWFj
aC1lczcwMDAvZXM3MDAwLmggbGludXgtMi42LjUvYXJjaC9pMzg2L21hY2gtZXM3MDAwL2VzNzAw
MC5oCi0tLSBsaW51eC0yLjYuNS12YW5pbGxhL2FyY2gvaTM4Ni9tYWNoLWVzNzAwMC9lczcwMDAu
aAkyMDA0LTA1LTAzIDA4OjU4OjU1LjAwMDAwMDAwMCAtMDQwMAorKysgbGludXgtMi42LjUvYXJj
aC9pMzg2L21hY2gtZXM3MDAwL2VzNzAwMC5oCTIwMDQtMDUtMDMgMTE6MTI6MDguMDAwMDAwMDAw
IC0wNDAwCkBAIC0xMDQsNyArMTAzLDcgQEAKICNkZWZpbmUJTUlQX1NXX0FQSUMJCTB4MTAyMGIK
ICNkZWZpbmUJTUlQX0ZVTkMoVkFMVUUpIAkoVkFMVUUgJiAweGZmKQogCi1leHRlcm4gdm9pZCBw
YXJzZV91bmlzeXNfb2VtIChjaGFyICpvZW1wdHIsIGludCBvZW1fZW50cmllcyk7CitleHRlcm4g
aW50IHBhcnNlX3VuaXN5c19vZW0gKGNoYXIgKm9lbXB0ciwgaW50IG9lbV9lbnRyaWVzKTsKIGV4
dGVybiBpbnQgZmluZF91bmlzeXNfYWNwaV9vZW1fdGFibGUodW5zaWduZWQgbG9uZyAqb2VtX2Fk
ZHIsIGludCAqbGVuZ3RoKTsKIGV4dGVybiBpbnQgZXM3MDAwX3N0YXJ0X2NwdShpbnQgY3B1LCB1
bnNpZ25lZCBsb25nIGVpcCk7CiBleHRlcm4gdm9pZCBlczcwMDBfc3dfYXBpYyh2b2lkKTsKZGlm
ZiAtTmF1ciBsaW51eC0yLjYuNS12YW5pbGxhL2FyY2gvaTM4Ni9tYWNoLWVzNzAwMC9lczcwMDBw
bGF0LmMgbGludXgtMi42LjUvYXJjaC9pMzg2L21hY2gtZXM3MDAwL2VzNzAwMHBsYXQuYwotLS0g
bGludXgtMi42LjUtdmFuaWxsYS9hcmNoL2kzODYvbWFjaC1lczcwMDAvZXM3MDAwcGxhdC5jCTE5
NjktMTItMzEgMTk6MDA6MDAuMDAwMDAwMDAwIC0wNTAwCisrKyBsaW51eC0yLjYuNS9hcmNoL2kz
ODYvbWFjaC1lczcwMDAvZXM3MDAwcGxhdC5jCTIwMDQtMDUtMDMgMDk6MTE6MzMuMDAwMDAwMDAw
IC0wNDAwCkBAIC0wLDAgKzEsMjgwIEBACisvKgorICogV3JpdHRlbiBieTogR2FycnkgRm9yc2dy
ZW4sIFVuaXN5cyBDb3Jwb3JhdGlvbgorICogICAgICAgICAgICAgTmF0YWxpZSBQcm90YXNldmlj
aCwgVW5pc3lzIENvcnBvcmF0aW9uCisgKiBUaGlzIGZpbGUgY29udGFpbnMgdGhlIGNvZGUgdG8g
Y29uZmlndXJlIGFuZCBpbnRlcmZhY2UgCisgKiB3aXRoIFVuaXN5cyBFUzcwMDAgc2VyaWVzIGhh
cmR3YXJlIHN5c3RlbSBtYW5hZ2VyLgorICoKKyAqIENvcHlyaWdodCAoYykgMjAwMyBVbmlzeXMg
Q29ycG9yYXRpb24uICBBbGwgUmlnaHRzIFJlc2VydmVkLgorICoKKyAqIFRoaXMgcHJvZ3JhbSBp
cyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0
CisgKiB1bmRlciB0aGUgdGVybXMgb2YgdmVyc2lvbiAyIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSBhcworICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b24uCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQg
aXQgd291bGQgYmUgdXNlZnVsLCBidXQKKyAqIFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0
IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRO
RVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVj
ZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZworICog
d2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbiwgSW5jLiwgNTkKKyAqIFRlbXBsZSBQbGFjZSAtIFN1aXRlIDMzMCwgQm9zdG9uIE1BIDAy
MTExLTEzMDcsIFVTQS4KKyAqCisgKiBDb250YWN0IGluZm9ybWF0aW9uOiBVbmlzeXMgQ29ycG9y
YXRpb24sIFRvd25zaGlwIExpbmUgJiBVbmlvbiBNZWV0aW5nIAorICogUm9hZHMtQSwgVW5pc3lz
IFdheSwgQmx1ZSBCZWxsLCBQZW5uc3lsdmFuaWEsIDE5NDI0LCBvcjoKKyAqCisgKiBodHRwOi8v
d3d3LnVuaXN5cy5jb20KKyAqLworCisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVk
ZSA8bGludXgvdHlwZXMuaD4KKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KKyNpbmNsdWRlIDxs
aW51eC9zbXAuaD4KKyNpbmNsdWRlIDxsaW51eC9zdHJpbmcuaD4KKyNpbmNsdWRlIDxsaW51eC9z
cGlubG9jay5oPgorI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+CisjaW5jbHVkZSA8bGludXgvbm90
aWZpZXIuaD4KKyNpbmNsdWRlIDxsaW51eC9yZWJvb3QuaD4KKyNpbmNsdWRlIDxsaW51eC9pbml0
Lmg+CisjaW5jbHVkZSA8bGludXgvYWNwaS5oPgorI2luY2x1ZGUgPGFzbS9pby5oPgorI2luY2x1
ZGUgPGFzbS9ubWkuaD4KKyNpbmNsdWRlIDxhc20vc21wLmg+CisjaW5jbHVkZSA8YXNtL2FwaWNk
ZWYuaD4KKyNpbmNsdWRlICJlczcwMDAuaCIKKworLyoKKyAqIEVTNzAwMCBHbG9iYWxzCisgKi8K
Kwordm9sYXRpbGUgdW5zaWduZWQgbG9uZwkqcHNhaSA9IE5VTEw7CitzdHJ1Y3QgbWlwX3JlZwkJ
Km1pcF9yZWc7ICAKK3N0cnVjdCBtaXBfcmVnCQkqaG9zdF9yZWc7CitpbnQgCQkJbWlwX3BvcnQ7
Cit1bnNpZ25lZCBsb25nCQltaXBfYWRkciwgaG9zdF9hZGRyOworCisvKgorICogUGFyc2UgdGhl
IE9FTSBUYWJsZQorICovCisKK2ludCBfX2luaXQKK3BhcnNlX3VuaXN5c19vZW0gKGNoYXIgKm9l
bXB0ciwgaW50IG9lbV9lbnRyaWVzKQoreworCWludCAgICAgICAgICAgICAgICAgICAgIGk7CisJ
aW50IAkJCXN1Y2Nlc3MgPSAwOworCXVuc2lnbmVkIGNoYXIgICAgICAgICAgIHR5cGUsIHNpemU7
CisJdW5zaWduZWQgbG9uZyAgICAgICAgICAgdmFsOworCWNoYXIgICAgICAgICAgICAgICAgICAg
ICp0cCA9IE5VTEw7ICAKKwlzdHJ1Y3QgcHNhaSAgICAgICAgICAgICAqcHNhaXAgPSBOVUxMOwor
CXN0cnVjdCBtaXBfcmVnX2luZm8gCSptaTsKKwlzdHJ1Y3QgbWlwX3JlZwkJKmhvc3QsICptaXA7
CisKKwl0cCA9IG9lbXB0cjsKKworCXRwICs9IDg7CisKKwlmb3IgKGk9MDsgaSA8PSBvZW1fZW50
cmllczsgaSsrKSB7CisJCXR5cGUgPSAqdHArKzsKKwkJc2l6ZSA9ICp0cCsrOworCQl0cCAtPSAy
OworCQlzd2l0Y2ggKHR5cGUpIHsKKwkJY2FzZSBNSVBfUkVHOgorCQkJbWkgPSAoc3RydWN0IG1p
cF9yZWdfaW5mbyAqKXRwOworCQkJdmFsID0gTUlQX1JEX0xPKG1pLT5ob3N0X3JlZyk7CisJCQlo
b3N0X2FkZHIgPSB2YWw7CisJCQlob3N0ID0gKHN0cnVjdCBtaXBfcmVnICopdmFsOworCQkJaG9z
dF9yZWcgPSBfX3ZhKGhvc3QpOworCQkJdmFsID0gTUlQX1JEX0xPKG1pLT5taXBfcmVnKTsKKwkJ
CW1pcF9wb3J0ID0gTUlQX1BPUlQobWktPm1pcF9pbmZvKTsKKwkJCW1pcF9hZGRyID0gdmFsOwor
CQkJbWlwID0gKHN0cnVjdCBtaXBfcmVnICopdmFsOworCQkJbWlwX3JlZyA9IF9fdmEobWlwKTsK
KwkJCURwcmludGsoImVzNzAwMF9taXBjZmc6IGhvc3RfcmVnID0gMHglbHggXG4iLCAKKwkJCQko
dW5zaWduZWQgbG9uZylob3N0X3JlZyk7CisJCQlEcHJpbnRrKCJlczcwMDBfbWlwY2ZnOiBtaXBf
cmVnID0gMHglbHggXG4iLCAKKwkJCQkodW5zaWduZWQgbG9uZyltaXBfcmVnKTsKKwkJCXN1Y2Nl
c3MrKzsKKwkJCWJyZWFrOworCQljYXNlIE1JUF9QU0FJX1JFRzoKKwkJCXBzYWlwID0gKHN0cnVj
dCBwc2FpICopdHA7CisJCQlpZiAodHAgIT0gTlVMTCkgeworCQkJCWlmIChwc2FpcC0+YWRkcikK
KwkJCQkJcHNhaSA9IF9fdmEocHNhaXAtPmFkZHIpOworCQkJCWVsc2UKKwkJCQkJcHNhaSA9IE5V
TEw7CisJCQkJc3VjY2VzcysrOworCQkJfQorCQkJYnJlYWs7CisJCWRlZmF1bHQ6CisJCQlicmVh
azsKKwkJfQorCQlpZiAoaSA9PSA2KSBicmVhazsKKwkJdHAgKz0gc2l6ZTsKKwl9CisKKwlpZiAo
c3VjY2VzcyA8IDIpIHsKKwkJcHJpbnRrKCJcbk5vIEVTNzAwMCBmb3VuZC5cbiIpOworCQllczcw
MDBfcGxhdCA9IDA7CisJfSBlbHNlIHsKKwkJcHJpbnRrKCJcbkVuYWJsaW5nIEVTNzAwMCBzcGVj
aWZpYyBmZWF0dXJlcy4uLlxuIik7CisJCWVzNzAwMF9wbGF0ID0gMTsKKwl9CisJcmV0dXJuIGVz
NzAwMF9wbGF0OworfQorCitpbnQgX19pbml0IAorZmluZF91bmlzeXNfYWNwaV9vZW1fdGFibGUo
dW5zaWduZWQgbG9uZyAqb2VtX2FkZHIsIGludCAqbGVuZ3RoKSAKK3sKKwlzdHJ1Y3QgYWNwaV90
YWJsZV9yc2RwCQkqcnNkcCA9IE5VTEw7CisJdW5zaWduZWQgbG9uZwkJCXJzZHBfcGh5cyA9IDA7
CisJc3RydWN0IGFjcGlfdGFibGVfaGVhZGVyIAkqaGVhZGVyID0gTlVMTDsKKwlpbnQJCQkJaTsK
KwlzdHJ1Y3QgYWNwaV90YWJsZV9zZHQJCXNkdDsKKworCXJzZHBfcGh5cyA9IGFjcGlfZmluZF9y
c2RwKCk7CisJcnNkcCA9IF9fdmEocnNkcF9waHlzKTsKKwlpZiAocnNkcC0+cnNkdF9hZGRyZXNz
KSB7CisJCXN0cnVjdCBhY3BpX3RhYmxlX3JzZHQJKm1hcHBlZF9yc2R0ID0gTlVMTDsKKwkJc2R0
LnBhID0gcnNkcC0+cnNkdF9hZGRyZXNzOworCisJCWhlYWRlciA9IChzdHJ1Y3QgYWNwaV90YWJs
ZV9oZWFkZXIgKikKKwkJCV9fYWNwaV9tYXBfdGFibGUoc2R0LnBhLCBzaXplb2Yoc3RydWN0IGFj
cGlfdGFibGVfaGVhZGVyKSk7CisJCWlmICghaGVhZGVyKQorCQkJcmV0dXJuIC1FTk9ERVY7CisK
KwkJc2R0LmNvdW50ID0gKGhlYWRlci0+bGVuZ3RoIC0gc2l6ZW9mKHN0cnVjdCBhY3BpX3RhYmxl
X2hlYWRlcikpID4+IDM7CisJCW1hcHBlZF9yc2R0ID0gKHN0cnVjdCBhY3BpX3RhYmxlX3JzZHQg
KikKKwkJCV9fYWNwaV9tYXBfdGFibGUoc2R0LnBhLCBoZWFkZXItPmxlbmd0aCk7CisJCWlmICgh
bWFwcGVkX3JzZHQpCisJCQlyZXR1cm4gLUVOT0RFVjsKKworCQloZWFkZXIgPSAmbWFwcGVkX3Jz
ZHQtPmhlYWRlcjsKKworCQlmb3IgKGkgPSAwOyBpIDwgc2R0LmNvdW50OyBpKyspCisJCQlzZHQu
ZW50cnlbaV0ucGEgPSAodW5zaWduZWQgbG9uZykgbWFwcGVkX3JzZHQtPmVudHJ5W2ldOworCX07
CisJZm9yIChpID0gMDsgaSA8IHNkdC5jb3VudDsgaSsrKSB7CisKKwkJaGVhZGVyID0gKHN0cnVj
dCBhY3BpX3RhYmxlX2hlYWRlciAqKQorCQkJX19hY3BpX21hcF90YWJsZShzZHQuZW50cnlbaV0u
cGEsCisJCQkJc2l6ZW9mKHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlcikpOworCQlpZiAoIWhlYWRl
cikKKwkJCWNvbnRpbnVlOworCQlpZiAoIXN0cm5jbXAoKGNoYXIgKikgJmhlYWRlci0+c2lnbmF0
dXJlLCAiT0VNMSIsIDQpKSB7CisJCQlpZiAoIXN0cm5jbXAoKGNoYXIgKikgJmhlYWRlci0+b2Vt
X2lkLCAiVU5JU1lTIiwgNikpIHsKKwkJCQl2b2lkICphZGRyOworCQkJCXN0cnVjdCBvZW1fdGFi
bGUgKnQ7CisJCQkJYWNwaV90YWJsZV9wcmludChoZWFkZXIsIHNkdC5lbnRyeVtpXS5wYSk7CisJ
CQkJdCA9IChzdHJ1Y3Qgb2VtX3RhYmxlICopIF9fYWNwaV9tYXBfdGFibGUoc2R0LmVudHJ5W2ld
LnBhLCBoZWFkZXItPmxlbmd0aCk7CisJCQkJYWRkciA9ICh2b2lkICopIF9fYWNwaV9tYXBfdGFi
bGUodC0+T0VNVGFibGVBZGRyLCB0LT5PRU1UYWJsZVNpemUpOworCQkJCSpsZW5ndGggPSBoZWFk
ZXItPmxlbmd0aDsKKwkJCQkqb2VtX2FkZHIgPSAodW5zaWduZWQgbG9uZykgYWRkcjsKKwkJCQly
ZXR1cm4gMDsKKwkJCX0KKwkJfQorCX0KKwlwcmludGsoIkVTNzAwMDogZGlkIG5vdCBmaW5kIFVu
aXN5cyBBQ1BJIE9FTSB0YWJsZSFcbiIpOworCXJldHVybiAtMTsKK30KKworc3RhdGljIHZvaWQK
K2VzNzAwMF9zcGluKGludCBuKQoreworCWludCBpID0gMDsKKworCXdoaWxlIChpKysgPCBuKSAK
KwkJcmVwX25vcCgpOworfQorCitzdGF0aWMgaW50IF9faW5pdAorZXM3MDAwX21pcF93cml0ZShz
dHJ1Y3QgbWlwX3JlZyAqbWlwX3JlZykKK3sKKwlpbnQJCQlzdGF0dXMgPSAwOworCWludAkJCXNw
aW47CisKKwlzcGluID0gTUlQX1NQSU47CisJd2hpbGUgKCgodW5zaWduZWQgbG9uZyBsb25nKWhv
c3RfcmVnLT5vZmZfMzggJgorCQkodW5zaWduZWQgbG9uZyBsb25nKU1JUF9WQUxJRCkgIT0gMCkg
eworCQkJaWYgKC0tc3BpbiA8PSAwKSB7CisJCQkJcHJpbnRrKCJlczcwMDBfbWlwX3dyaXRlOiBU
aW1lb3V0IHdhaXRpbmcgZm9yIEhvc3QgVmFsaWQgRmxhZyIpOworCQkJCXJldHVybiAtMTsKKwkJ
CX0KKwkJZXM3MDAwX3NwaW4oTUlQX1NQSU4pOworCX0KKworCW1lbWNweShob3N0X3JlZywgbWlw
X3JlZywgc2l6ZW9mKHN0cnVjdCBtaXBfcmVnKSk7CisJb3V0YigxLCBtaXBfcG9ydCk7CisKKwlz
cGluID0gTUlQX1NQSU47CisKKwl3aGlsZSAoKCh1bnNpZ25lZCBsb25nIGxvbmcpbWlwX3JlZy0+
b2ZmXzM4ICYKKwkJKHVuc2lnbmVkIGxvbmcgbG9uZylNSVBfVkFMSUQpID09IDApIHsKKwkJaWYg
KC0tc3BpbiA8PSAwKSB7CisJCQlwcmludGsoImVzNzAwMF9taXBfd3JpdGU6IFRpbWVvdXQgd2Fp
dGluZyBmb3IgTUlQIFZhbGlkIEZsYWciKTsKKwkJCXJldHVybiAtMTsKKwkJfQorCQllczcwMDBf
c3BpbihNSVBfU1BJTik7CisJfQorCisJc3RhdHVzID0gKCh1bnNpZ25lZCBsb25nIGxvbmcpbWlw
X3JlZy0+b2ZmXzAgJgorCQkodW5zaWduZWQgbG9uZyBsb25nKTB4ZmZmZjAwMDAwMDAwMDApID4+
IDQ4OworCW1pcF9yZWctPm9mZl8zOCA9ICgodW5zaWduZWQgbG9uZyBsb25nKW1pcF9yZWctPm9m
Zl8zOCAmCisJCSh1bnNpZ25lZCBsb25nIGxvbmcpfk1JUF9WQUxJRCk7CisJcmV0dXJuIHN0YXR1
czsKK30KKworaW50IAorZXM3MDAwX3N0YXJ0X2NwdShpbnQgY3B1LCB1bnNpZ25lZCBsb25nIGVp
cCkKK3sKKwl1bnNpZ25lZCBsb25nIHZlY3QgPSAwLCBwc2FpdmFsID0gMDsKKworCWlmIChwc2Fp
ID09IE5VTEwpCisJCXJldHVybiAtMTsKKworCXZlY3QgPSAoKHVuc2lnbmVkIGxvbmcpX19wYShl
aXApLzB4MTAwMCkgPDwgMTY7CisJcHNhaXZhbCA9ICgweDEwMDAwMDAgfCB2ZWN0IHwgY3B1KTsK
KworCXdoaWxlICgqcHNhaSAmIDB4MTAwMDAwMCkKKyAgICAgICAgICAgICAgICA7CisKKwkqcHNh
aSA9IHBzYWl2YWw7CisKKwlyZXR1cm4gMDsKKworfQorCitpbnQgCitlczcwMDBfc3RvcF9jcHUo
aW50IGNwdSkKK3sKKwlpbnQgc3RhcnR1cDsKKworCWlmIChwc2FpID09IE5VTEwpCisJCXJldHVy
biAtMTsKKworCXN0YXJ0dXA9ICgweDEwMDAwMDAgfCBjcHUpOworCisJd2hpbGUgKCgqcHNhaSAm
IDB4ZmYwMGZmZmYpICE9IHN0YXJ0dXApCisJCTsKKworCXN0YXJ0dXAgPSAoKnBzYWkgJiAweGZm
MDAwMCkgPj4gMTY7CisJKnBzYWkgJj0gMHhmZmZmZmY7CisKKwlyZXR1cm4gMDsKKworfQorCit2
b2lkIF9faW5pdAorZXM3MDAwX3N3X2FwaWMoKQoreworCWlmIChlczcwMDBfcGxhdCkgeworCQlp
bnQgbWlwX3N0YXR1czsKKwkJc3RydWN0IG1pcF9yZWcgZXM3MDAwX21pcF9yZWc7CisKKwkJcHJp
bnRrKCJFUzcwMDA6IEVuYWJsaW5nIEFQSUMgbW9kZS5cbiIpOworICAgICAgICAJbWVtc2V0KCZl
czcwMDBfbWlwX3JlZywgMCwgc2l6ZW9mKHN0cnVjdCBtaXBfcmVnKSk7CisgICAgICAgIAllczcw
MDBfbWlwX3JlZy5vZmZfMCA9IE1JUF9TV19BUElDOworICAgICAgICAJZXM3MDAwX21pcF9yZWcu
b2ZmXzM4ID0gKE1JUF9WQUxJRCk7CisgICAgICAgIAl3aGlsZSAoKG1pcF9zdGF0dXMgPSBlczcw
MDBfbWlwX3dyaXRlKCZlczcwMDBfbWlwX3JlZykpICE9IDApCisgICAgICAgICAgICAgIAkJcHJp
bnRrKCJlczcwMDBfc3dfYXBpYzogY29tbWFuZCBmYWlsZWQsIHN0YXR1cyA9ICV4XG4iLCAKKwkJ
CQltaXBfc3RhdHVzKTsKKwkJcmV0dXJuOworCX0KK30KZGlmZiAtTmF1ciBsaW51eC0yLjYuNS12
YW5pbGxhL2FyY2gvaTM4Ni9tYWNoLWVzNzAwMC9zZXR1cC5jIGxpbnV4LTIuNi41L2FyY2gvaTM4
Ni9tYWNoLWVzNzAwMC9zZXR1cC5jCi0tLSBsaW51eC0yLjYuNS12YW5pbGxhL2FyY2gvaTM4Ni9t
YWNoLWVzNzAwMC9zZXR1cC5jCTIwMDQtMDQtMDMgMjI6Mzc6MDcuMDAwMDAwMDAwIC0wNTAwCisr
KyBsaW51eC0yLjYuNS9hcmNoL2kzODYvbWFjaC1lczcwMDAvc2V0dXAuYwkxOTY5LTEyLTMxIDE5
OjAwOjAwLjAwMDAwMDAwMCAtMDUwMApAQCAtMSwxMDUgKzAsMCBAQAotLyoKLSAqCU1hY2hpbmUg
c3BlY2lmaWMgc2V0dXAgZm9yIGVzNzAwMAotICovCi0KLSNpbmNsdWRlIDxsaW51eC9jb25maWcu
aD4KLSNpbmNsdWRlIDxsaW51eC9zbXAuaD4KLSNpbmNsdWRlIDxsaW51eC9pbml0Lmg+Ci0jaW5j
bHVkZSA8bGludXgvaXJxLmg+Ci0jaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+Ci0jaW5jbHVk
ZSA8YXNtL2FyY2hfaG9va3MuaD4KLQotLyoqCi0gKiBwcmVfaW50cl9pbml0X2hvb2sgLSBpbml0
aWFsaXNhdGlvbiBwcmlvciB0byBzZXR0aW5nIHVwIGludGVycnVwdCB2ZWN0b3JzCi0gKgotICog
RGVzY3JpcHRpb246Ci0gKglQZXJmb3JtIGFueSBuZWNlc3NhcnkgaW50ZXJydXB0IGluaXRpYWxp
c2F0aW9uIHByaW9yIHRvIHNldHRpbmcgdXAKLSAqCXRoZSAib3JkaW5hcnkiIGludGVycnVwdCBj
YWxsIGdhdGVzLiAgRm9yIGxlZ2FjeSByZWFzb25zLCB0aGUgSVNBCi0gKglpbnRlcnJ1cHRzIHNo
b3VsZCBiZSBpbml0aWFsaXNlZCBoZXJlIGlmIHRoZSBtYWNoaW5lIGVtdWxhdGVzIGEgUEMKLSAq
CWluIGFueSB3YXkuCi0gKiovCi12b2lkIF9faW5pdCBwcmVfaW50cl9pbml0X2hvb2sodm9pZCkK
LXsKLQlpbml0X0lTQV9pcnFzKCk7Ci19Ci0KLS8qCi0gKiBJUlEyIGlzIGNhc2NhZGUgaW50ZXJy
dXB0IHRvIHNlY29uZCBpbnRlcnJ1cHQgY29udHJvbGxlcgotICovCi1zdGF0aWMgc3RydWN0IGly
cWFjdGlvbiBpcnEyID0geyBub19hY3Rpb24sIDAsIDAsICJjYXNjYWRlIiwgTlVMTCwgTlVMTH07
Ci0KLS8qKgotICogaW50cl9pbml0X2hvb2sgLSBwb3N0IGdhdGUgc2V0dXAgaW50ZXJydXB0IGlu
aXRpYWxpc2F0aW9uCi0gKgotICogRGVzY3JpcHRpb246Ci0gKglGaWxsIGluIGFueSBpbnRlcnJ1
cHRzIHRoYXQgbWF5IGhhdmUgYmVlbiBsZWZ0IG91dCBieSB0aGUgZ2VuZXJhbAotICoJaW5pdF9J
UlEoKSByb3V0aW5lLiAgaW50ZXJydXB0cyBoYXZpbmcgdG8gZG8gd2l0aCB0aGUgbWFjaGluZSBy
YXRoZXIKLSAqCXRoYW4gdGhlIGRldmljZXMgb24gdGhlIEkvTyBidXMgKGxpa2UgQVBJQyBpbnRl
cnJ1cHRzIGluIGludGVsIE1QCi0gKglzeXN0ZW1zKSBhcmUgc3RhcnRlZCBoZXJlLgotICoqLwot
dm9pZCBfX2luaXQgaW50cl9pbml0X2hvb2sodm9pZCkKLXsKLSNpZmRlZiBDT05GSUdfWDg2X0xP
Q0FMX0FQSUMKLQlhcGljX2ludHJfaW5pdCgpOwotI2VuZGlmCi0KLQlzZXR1cF9pcnEoMiwgJmly
cTIpOwotfQotCi0vKioKLSAqIHByZV9zZXR1cF9hcmNoX2hvb2sgLSBob29rIGNhbGxlZCBwcmlv
ciB0byBhbnkgc2V0dXBfYXJjaCgpIGV4ZWN1dGlvbgotICoKLSAqIERlc2NyaXB0aW9uOgotICoJ
Z2VuZXJhbGx5IHVzZWQgdG8gYWN0aXZhdGUgYW55IG1hY2hpbmUgc3BlY2lmaWMgaWRlbnRpZmlj
YXRpb24KLSAqCXJvdXRpbmVzIHRoYXQgbWF5IGJlIG5lZWRlZCBiZWZvcmUgc2V0dXBfYXJjaCgp
IHJ1bnMuICBPbiBWSVNXUwotICoJdGhpcyBpcyB1c2VkIHRvIGdldCB0aGUgYm9hcmQgcmV2aXNp
b24gYW5kIHR5cGUuCi0gKiovCi12b2lkIF9faW5pdCBwcmVfc2V0dXBfYXJjaF9ob29rKHZvaWQp
Ci17Ci19Ci0KLS8qKgotICogdHJhcF9pbml0X2hvb2sgLSBpbml0aWFsaXNlIHN5c3RlbSBzcGVj
aWZpYyB0cmFwcwotICoKLSAqIERlc2NyaXB0aW9uOgotICoJQ2FsbGVkIGFzIHRoZSBmaW5hbCBh
Y3Qgb2YgdHJhcF9pbml0KCkuICBVc2VkIGluIFZJU1dTIHRvIGluaXRpYWxpc2UKLSAqCXRoZSB2
YXJpb3VzIGJvYXJkIHNwZWNpZmljIEFQSUMgdHJhcHMuCi0gKiovCi12b2lkIF9faW5pdCB0cmFw
X2luaXRfaG9vayh2b2lkKQotewotfQotCi1zdGF0aWMgc3RydWN0IGlycWFjdGlvbiBpcnEwICA9
IHsgdGltZXJfaW50ZXJydXB0LCBTQV9JTlRFUlJVUFQsIDAsICJ0aW1lciIsIE5VTEwsIE5VTEx9
OwotCi0vKioKLSAqIHRpbWVfaW5pdF9ob29rIC0gZG8gYW55IHNwZWNpZmljIGluaXRpYWxpc2F0
aW9ucyBmb3IgdGhlIHN5c3RlbSB0aW1lci4KLSAqCi0gKiBEZXNjcmlwdGlvbjoKLSAqCU11c3Qg
cGx1ZyB0aGUgc3lzdGVtIHRpbWVyIGludGVycnVwdCBzb3VyY2UgYXQgSFogaW50byB0aGUgSVJR
IGxpc3RlZAotICoJaW4gaXJxX3ZlY3RvcnMuaDpUSU1FUl9JUlEKLSAqKi8KLXZvaWQgX19pbml0
IHRpbWVfaW5pdF9ob29rKHZvaWQpCi17Ci0Jc2V0dXBfaXJxKDAsICZpcnEwKTsKLX0KLQotI2lm
ZGVmIENPTkZJR19NQ0EKLS8qKgotICogbWNhX25taV9ob29rIC0gaG9vayBpbnRvIE1DQSBzcGVj
aWZpYyBOTUkgY2hhaW4KLSAqCi0gKiBEZXNjcmlwdGlvbjoKLSAqCVRoZSBNQ0EgKE1pY3JvY2hh
bm5lbCBBcmNpdGVjdHVyZSkgaGFzIGFuIE5NSSBjaGFpbiBmb3IgTk1JIHNvdXJjZXMKLSAqCWFs
b25nIHRoZSBNQ0EgYnVzLiAgVXNlIHRoaXMgdG8gaG9vayBpbnRvIHRoYXQgY2hhaW4gaWYgeW91
IHdpbGwgbmVlZAotICoJaXQuCi0gKiovCi12b2lkIF9faW5pdCBtY2Ffbm1pX2hvb2sodm9pZCkK
LXsKLQkvKiBJZiBJIHJlY2FsbCBjb3JyZWN0bHksIHRoZXJlJ3MgYSB3aG9sZSBidW5jaCBvZiBv
dGhlciB0aGluZ3MgdGhhdAotCSAqIHdlIGNhbiBkbyB0byBjaGVjayBmb3IgTk1JIHByb2JsZW1z
LCBidXQgdGhhdCdzIGFsbCBJIGtub3cgYWJvdXQKLQkgKiBhdCB0aGUgbW9tZW50LgotCSAqLwot
Ci0JcHJpbnRrKCJOTUkgZ2VuZXJhdGVkIGZyb20gdW5rbm93biBzb3VyY2UhXG4iKTsKLX0KLQot
I2VuZGlmCmRpZmYgLU5hdXIgbGludXgtMi42LjUtdmFuaWxsYS9hcmNoL2kzODYvbWFjaC1lczcw
MDAvdG9wb2xvZ3kuYyBsaW51eC0yLjYuNS9hcmNoL2kzODYvbWFjaC1lczcwMDAvdG9wb2xvZ3ku
YwotLS0gbGludXgtMi42LjUtdmFuaWxsYS9hcmNoL2kzODYvbWFjaC1lczcwMDAvdG9wb2xvZ3ku
YwkyMDA0LTA0LTAzIDIyOjM4OjE1LjAwMDAwMDAwMCAtMDUwMAorKysgbGludXgtMi42LjUvYXJj
aC9pMzg2L21hY2gtZXM3MDAwL3RvcG9sb2d5LmMJMTk2OS0xMi0zMSAxOTowMDowMC4wMDAwMDAw
MDAgLTA1MDAKQEAgLTEsNjQgKzAsMCBAQAotLyoKLSAqIGFyY2gvaTM4Ni9tYWNoLWdlbmVyaWMv
dG9wb2xvZ3kuYyAtIFBvcHVsYXRlIGRyaXZlcmZzIHdpdGggdG9wb2xvZ3kgaW5mb3JtYXRpb24K
LSAqCi0gKiBXcml0dGVuIGJ5OiBNYXR0aGV3IERvYnNvbiwgSUJNIENvcnBvcmF0aW9uCi0gKiBP
cmlnaW5hbCBDb2RlOiBQYXVsIERvcndpbiwgSUJNIENvcnBvcmF0aW9uLCBQYXRyaWNrIE1vY2hl
bCwgT1NETAotICoKLSAqIENvcHlyaWdodCAoQykgMjAwMiwgSUJNIENvcnAuCi0gKgotICogQWxs
IHJpZ2h0cyByZXNlcnZlZC4gICAgICAgICAgCi0gKgotICogVGhpcyBwcm9ncmFtIGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKLSAqIGl0IHVu
ZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlz
aGVkIGJ5Ci0gKiB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAy
IG9mIHRoZSBMaWNlbnNlLCBvcgotICogKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lv
bi4KLSAqCi0gKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBp
dCB3aWxsIGJlIHVzZWZ1bCwgYnV0Ci0gKiBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBl
dmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCi0gKiBNRVJDSEFOVEFCSUxJVFkgT1IgRklUTkVT
UyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UsIEdPT0QgVElUTEUgb3IKLSAqIE5PTiBJTkZSSU5H
RU1FTlQuICBTZWUgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlCi0gKiBk
ZXRhaWxzLgotICoKLSAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdO
VSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCi0gKiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYg
bm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQotICogRm91bmRhdGlvbiwgSW5jLiwgNjc1
IE1hc3MgQXZlLCBDYW1icmlkZ2UsIE1BIDAyMTM5LCBVU0EuCi0gKgotICogU2VuZCBmZWVkYmFj
ayB0byA8Y29scGF0Y2hAdXMuaWJtLmNvbT4KLSAqLwotI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4K
LSNpbmNsdWRlIDxsaW51eC9zbXAuaD4KLSNpbmNsdWRlIDxhc20vY3B1Lmg+Ci0KLXN0cnVjdCBp
Mzg2X2NwdSBjcHVfZGV2aWNlc1tOUl9DUFVTXTsKLQotI2lmZGVmIENPTkZJR19OVU1BCi0jaW5j
bHVkZSA8bGludXgvbW16b25lLmg+Ci0jaW5jbHVkZSA8YXNtL25vZGUuaD4KLQotc3RydWN0IGkz
ODZfbm9kZSBub2RlX2RldmljZXNbTUFYX05VTU5PREVTXTsKLQotc3RhdGljIGludCBfX2luaXQg
dG9wb2xvZ3lfaW5pdCh2b2lkKQotewotCWludCBpOwotCi0JZm9yIChpID0gMDsgaSA8IG51bV9v
bmxpbmVfbm9kZXMoKTsgaSsrKQotCQlhcmNoX3JlZ2lzdGVyX25vZGUoaSk7Ci0JZm9yIChpID0g
MDsgaSA8IE5SX0NQVVM7IGkrKykKLQkJaWYgKGNwdV9wb3NzaWJsZShpKSkgYXJjaF9yZWdpc3Rl
cl9jcHUoaSk7Ci0JcmV0dXJuIDA7Ci19Ci0KLSNlbHNlIC8qICFDT05GSUdfTlVNQSAqLwotCi1z
dGF0aWMgaW50IF9faW5pdCB0b3BvbG9neV9pbml0KHZvaWQpCi17Ci0JaW50IGk7Ci0KLQlmb3Ig
KGkgPSAwOyBpIDwgTlJfQ1BVUzsgaSsrKQotCQlpZiAoY3B1X3Bvc3NpYmxlKGkpKSBhcmNoX3Jl
Z2lzdGVyX2NwdShpKTsKLQlyZXR1cm4gMDsKLX0KLQotI2VuZGlmIC8qIENPTkZJR19OVU1BICov
Ci0KLXN1YnN5c19pbml0Y2FsbCh0b3BvbG9neV9pbml0KTsKZGlmZiAtTmF1ciBsaW51eC0yLjYu
NS12YW5pbGxhL2FyY2gvaTM4Ni9tYWNoLWdlbmVyaWMvTWFrZWZpbGUgbGludXgtMi42LjUvYXJj
aC9pMzg2L21hY2gtZ2VuZXJpYy9NYWtlZmlsZQotLS0gbGludXgtMi42LjUtdmFuaWxsYS9hcmNo
L2kzODYvbWFjaC1nZW5lcmljL01ha2VmaWxlCTIwMDQtMDQtMDMgMjI6Mzc6MjMuMDAwMDAwMDAw
IC0wNTAwCisrKyBsaW51eC0yLjYuNS9hcmNoL2kzODYvbWFjaC1nZW5lcmljL01ha2VmaWxlCTIw
MDQtMDUtMDMgMDk6MTE6MzMuMDAwMDAwMDAwIC0wNDAwCkBAIC00LDE1ICs0LDQgQEAKIAogRVhU
UkFfQ0ZMQUdTCSs9IC1JLi4va2VybmVsCiAKLW9iai15CQkJCTo9IHByb2JlLm8gc3VtbWl0Lm8g
Ymlnc21wLm8gZGVmYXVsdC5vCi0KLQotIwotIyBNYWtlZmlsZSBmb3IgdGhlIGdlbmVyaWMgYXJj
aGl0ZWN0dXJlCi0jCi0KLUVYVFJBX0NGTEFHUwkrPSAtSS4uL2tlcm5lbAotCi1vYmoteQkJCQk6
PSBwcm9iZS5vIHN1bW1pdC5vIGJpZ3NtcC5vIGRlZmF1bHQubwotCi0KK29iai15CQkJCTo9IHBy
b2JlLm8gc3VtbWl0Lm8gYmlnc21wLm8gZXM3MDAwLm8gZGVmYXVsdC5vIC4uL21hY2gtZXM3MDAw
LwpkaWZmIC1OYXVyIGxpbnV4LTIuNi41LXZhbmlsbGEvYXJjaC9pMzg2L21hY2gtZ2VuZXJpYy9l
czcwMDAuYyBsaW51eC0yLjYuNS9hcmNoL2kzODYvbWFjaC1nZW5lcmljL2VzNzAwMC5jCi0tLSBs
aW51eC0yLjYuNS12YW5pbGxhL2FyY2gvaTM4Ni9tYWNoLWdlbmVyaWMvZXM3MDAwLmMJMTk2OS0x
Mi0zMSAxOTowMDowMC4wMDAwMDAwMDAgLTA1MDAKKysrIGxpbnV4LTIuNi41L2FyY2gvaTM4Ni9t
YWNoLWdlbmVyaWMvZXM3MDAwLmMJMjAwNC0wNS0wMyAwOToxMTozMy4wMDAwMDAwMDAgLTA0MDAK
QEAgLTAsMCArMSwyOCBAQAorLyogCisgKiBBUElDIGRyaXZlciBmb3IgdGhlIFVuaXN5cyBFUzcw
MDAgY2hpcHNldC4KKyAqLworI2RlZmluZSBBUElDX0RFRklOSVRJT04gMQorI2luY2x1ZGUgPGxp
bnV4L2NvbmZpZy5oPgorI2luY2x1ZGUgPGxpbnV4L3RocmVhZHMuaD4KKyNpbmNsdWRlIDxsaW51
eC9jcHVtYXNrLmg+CisjaW5jbHVkZSA8YXNtL21wc3BlYy5oPgorI2luY2x1ZGUgPGFzbS9nZW5h
cGljLmg+CisjaW5jbHVkZSA8YXNtL2ZpeG1hcC5oPgorI2luY2x1ZGUgPGFzbS9hcGljZGVmLmg+
CisjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CisjaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+Cisj
aW5jbHVkZSA8bGludXgvc21wLmg+CisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUg
PGFzbS9tYWNoLWVzNzAwMC9tYWNoX2FwaWNkZWYuaD4KKyNpbmNsdWRlIDxhc20vbWFjaC1lczcw
MDAvbWFjaF9hcGljLmg+CisjaW5jbHVkZSA8YXNtL21hY2gtZXM3MDAwL21hY2hfaXBpLmg+Cisj
aW5jbHVkZSA8YXNtL21hY2gtZXM3MDAwL21hY2hfbXBwYXJzZS5oPgorI2luY2x1ZGUgPGFzbS9t
YWNoLWVzNzAwMC9tYWNoX3dha2VjcHUuaD4KKworc3RhdGljIF9faW5pdCBpbnQgcHJvYmVfZXM3
MDAwKHZvaWQpCit7IAorCS8qIHByb2JlZCBsYXRlciBpbiBtcHRhYmxlL0FDUEkgaG9va3MgKi8K
KwlyZXR1cm4gMDsKK30gCisKK3N0cnVjdCBnZW5hcGljIGFwaWNfZXM3MDAwID0gQVBJQ19JTklU
KCJlczcwMDAiLCBwcm9iZV9lczcwMDApOyAKZGlmZiAtTmF1ciBsaW51eC0yLjYuNS12YW5pbGxh
L2FyY2gvaTM4Ni9tYWNoLWdlbmVyaWMvcHJvYmUuYyBsaW51eC0yLjYuNS9hcmNoL2kzODYvbWFj
aC1nZW5lcmljL3Byb2JlLmMKLS0tIGxpbnV4LTIuNi41LXZhbmlsbGEvYXJjaC9pMzg2L21hY2gt
Z2VuZXJpYy9wcm9iZS5jCTIwMDQtMDQtMDMgMjI6MzY6MTYuMDAwMDAwMDAwIC0wNTAwCisrKyBs
aW51eC0yLjYuNS9hcmNoL2kzODYvbWFjaC1nZW5lcmljL3Byb2JlLmMJMjAwNC0wNS0wMyAwOTox
MTozMy4wMDAwMDAwMDAgLTA0MDAKQEAgLTE3LDYgKzE3LDcgQEAKIAogZXh0ZXJuIHN0cnVjdCBn
ZW5hcGljIGFwaWNfc3VtbWl0OwogZXh0ZXJuIHN0cnVjdCBnZW5hcGljIGFwaWNfYmlnc21wOwor
ZXh0ZXJuIHN0cnVjdCBnZW5hcGljIGFwaWNfZXM3MDAwOwogZXh0ZXJuIHN0cnVjdCBnZW5hcGlj
IGFwaWNfZGVmYXVsdDsKIAogc3RydWN0IGdlbmFwaWMgKmdlbmFwaWMgPSAmYXBpY19kZWZhdWx0
OwpAQCAtMjQsNiArMjUsNyBAQAogc3RydWN0IGdlbmFwaWMgKmFwaWNfcHJvYmVbXSBfX2luaXRk
YXRhID0geyAKIAkmYXBpY19zdW1taXQsCiAJJmFwaWNfYmlnc21wLCAKKwkmYXBpY19lczcwMDAs
CiAJJmFwaWNfZGVmYXVsdCwJLyogbXVzdCBiZSBsYXN0ICovCiAJTlVMTCwKIH07CmRpZmYgLU5h
dXIgbGludXgtMi42LjUtdmFuaWxsYS9pbmNsdWRlL2FzbS1pMzg2L2dlbmFwaWMuaCBsaW51eC0y
LjYuNS9pbmNsdWRlL2FzbS1pMzg2L2dlbmFwaWMuaAotLS0gbGludXgtMi42LjUtdmFuaWxsYS9p
bmNsdWRlL2FzbS1pMzg2L2dlbmFwaWMuaAkyMDA0LTA0LTAzIDIyOjM3OjIzLjAwMDAwMDAwMCAt
MDUwMAorKysgbGludXgtMi42LjUvaW5jbHVkZS9hc20taTM4Ni9nZW5hcGljLmgJMjAwNC0wNS0w
MyAwOToyMDowMy4wMDAwMDAwMDAgLTA0MDAKQEAgLTI2LDcgKzI2LDggQEAKIAlpbnQgaW50X2Rl
bGl2ZXJ5X21vZGU7CiAJaW50IGludF9kZXN0X21vZGU7IAogCWludCBhcGljX2Jyb2FkY2FzdF9p
ZDsgCi0JaW50IGVzcl9kaXNhYmxlOworCWludCBFU1JfRElTQUJMRTsKKwlpbnQgYXBpY19kZXN0
aW5hdGlvbl9sb2dpY2FsOwogCXVuc2lnbmVkIGxvbmcgKCpjaGVja19hcGljaWRfdXNlZCkocGh5
c2lkX21hc2tfdCBiaXRtYXAsIGludCBhcGljaWQpOwogCXVuc2lnbmVkIGxvbmcgKCpjaGVja19h
cGljaWRfcHJlc2VudCkoaW50IGFwaWNpZCk7IAogCWludCBub19iYWxhbmNlX2lycTsKQEAgLTgw
LDYgKzgxLDggQEAKIAkuYXBpY19icm9hZGNhc3RfaWQgPSBBUElDX0JST0FEQ0FTVF9JRCwgXAog
CS5ub19iYWxhbmNlX2lycSA9IE5PX0JBTEFOQ0VfSVJRLCBcCiAJLm5vX2lvYXBpY19jaGVjayA9
IE5PX0lPQVBJQ19DSEVDSywgXAorCS5FU1JfRElTQUJMRSA9IGVzcl9kaXNhYmxlLCBcCisJLmFw
aWNfZGVzdGluYXRpb25fbG9naWNhbCA9IEFQSUNfREVTVF9MT0dJQ0FMLCBcCiAJQVBJQ0ZVTkMo
YXBpY19pZF9yZWdpc3RlcmVkKSwgXAogCUFQSUNGVU5DKHRhcmdldF9jcHVzKSwgXAogCUFQSUNG
VU5DKGNoZWNrX2FwaWNpZF91c2VkKSwgXApkaWZmIC1OYXVyIGxpbnV4LTIuNi41LXZhbmlsbGEv
aW5jbHVkZS9hc20taTM4Ni9tYWNoLWVzNzAwMC9tYWNoX2lwaS5oIGxpbnV4LTIuNi41L2luY2x1
ZGUvYXNtLWkzODYvbWFjaC1lczcwMDAvbWFjaF9pcGkuaAotLS0gbGludXgtMi42LjUtdmFuaWxs
YS9pbmNsdWRlL2FzbS1pMzg2L21hY2gtZXM3MDAwL21hY2hfaXBpLmgJMjAwNC0wNC0wMyAyMjoz
Njo1NS4wMDAwMDAwMDAgLTA1MDAKKysrIGxpbnV4LTIuNi41L2luY2x1ZGUvYXNtLWkzODYvbWFj
aC1lczcwMDAvbWFjaF9pcGkuaAkyMDA0LTA1LTAzIDA5OjEyOjAwLjAwMDAwMDAwMCAtMDQwMApA
QCAtMSw3ICsxLDcgQEAKICNpZm5kZWYgX19BU01fTUFDSF9JUElfSAogI2RlZmluZSBfX0FTTV9N
QUNIX0lQSV9ICiAKLXN0YXRpYyBpbmxpbmUgdm9pZCBzZW5kX0lQSV9tYXNrX3NlcXVlbmNlKGNw
dW1hc2tfdCBtYXNrLCBpbnQgdmVjdG9yKTsKK2lubGluZSB2b2lkIHNlbmRfSVBJX21hc2tfc2Vx
dWVuY2UoY3B1bWFza190IG1hc2ssIGludCB2ZWN0b3IpOwogCiBzdGF0aWMgaW5saW5lIHZvaWQg
c2VuZF9JUElfbWFzayhjcHVtYXNrX3QgbWFzaywgaW50IHZlY3RvcikKIHsKZGlmZiAtTmF1ciBs
aW51eC0yLjYuNS12YW5pbGxhL2luY2x1ZGUvYXNtLWkzODYvbWFjaC1lczcwMDAvbWFjaF9tcHBh
cnNlLmggbGludXgtMi42LjUvaW5jbHVkZS9hc20taTM4Ni9tYWNoLWVzNzAwMC9tYWNoX21wcGFy
c2UuaAotLS0gbGludXgtMi42LjUtdmFuaWxsYS9pbmNsdWRlL2FzbS1pMzg2L21hY2gtZXM3MDAw
L21hY2hfbXBwYXJzZS5oCTIwMDQtMDQtMDMgMjI6MzY6MTMuMDAwMDAwMDAwIC0wNTAwCisrKyBs
aW51eC0yLjYuNS9pbmNsdWRlL2FzbS1pMzg2L21hY2gtZXM3MDAwL21hY2hfbXBwYXJzZS5oCTIw
MDQtMDUtMDMgMDk6MTI6MDAuMDAwMDAwMDAwIC0wNDAwCkBAIC0xMiwyNiArMTIsMjggQEAKIHsK
IH0KIAotZXh0ZXJuIHZvaWQgcGFyc2VfdW5pc3lzX29lbSAoY2hhciAqb2VtcHRyLCBpbnQgb2Vt
X2VudHJpZXMpOworZXh0ZXJuIGludCBwYXJzZV91bmlzeXNfb2VtIChjaGFyICpvZW1wdHIsIGlu
dCBvZW1fZW50cmllcyk7CiBleHRlcm4gaW50IGZpbmRfdW5pc3lzX2FjcGlfb2VtX3RhYmxlKHVu
c2lnbmVkIGxvbmcgKm9lbV9hZGRyLCBpbnQgKmxlbmd0aCk7CiAKLXN0YXRpYyBpbmxpbmUgdm9p
ZCBtcHNfb2VtX2NoZWNrKHN0cnVjdCBtcF9jb25maWdfdGFibGUgKm1wYywgY2hhciAqb2VtLCAK
K3N0YXRpYyBpbmxpbmUgaW50IG1wc19vZW1fY2hlY2soc3RydWN0IG1wX2NvbmZpZ190YWJsZSAq
bXBjLCBjaGFyICpvZW0sIAogCQljaGFyICpwcm9kdWN0aWQpCiB7CiAJaWYgKG1wYy0+bXBjX29l
bXB0cikgewogCQlzdHJ1Y3QgbXBfY29uZmlnX29lbXRhYmxlICpvZW1fdGFibGUgPSAKIAkJCShz
dHJ1Y3QgbXBfY29uZmlnX29lbXRhYmxlICopbXBjLT5tcGNfb2VtcHRyOwotCQlwYXJzZV91bmlz
eXNfb2VtKChjaGFyICopb2VtX3RhYmxlLCBvZW1fdGFibGUtPm9lbV9sZW5ndGgpOworCQlyZXR1
cm4gcGFyc2VfdW5pc3lzX29lbSgoY2hhciAqKW9lbV90YWJsZSwgb2VtX3RhYmxlLT5vZW1fbGVu
Z3RoKTsKIAl9CisJcmV0dXJuIDA7CiB9CiAKIC8qIEhvb2sgZnJvbSBnZW5lcmljIEFDUEkgdGFi
bGVzLmMgKi8KLXN0YXRpYyBpbmxpbmUgdm9pZCBhY3BpX21hZHRfb2VtX2NoZWNrKGNoYXIgKm9l
bV9pZCwgY2hhciAqb2VtX3RhYmxlX2lkKQorc3RhdGljIGlubGluZSBpbnQgYWNwaV9tYWR0X29l
bV9jaGVjayhjaGFyICpvZW1faWQsIGNoYXIgKm9lbV90YWJsZV9pZCkKIHsKIAl1bnNpZ25lZCBs
b25nIG9lbV9hZGRyOyAKIAlpbnQgb2VtX2VudHJpZXM7CiAJaWYgKCFmaW5kX3VuaXN5c19hY3Bp
X29lbV90YWJsZSgmb2VtX2FkZHIsICZvZW1fZW50cmllcykpCi0JCXBhcnNlX3VuaXN5c19vZW0o
KGNoYXIgKilvZW1fYWRkciwgb2VtX2VudHJpZXMpOworCQlyZXR1cm4gcGFyc2VfdW5pc3lzX29l
bSgoY2hhciAqKW9lbV9hZGRyLCBvZW1fZW50cmllcyk7CisJcmV0dXJuIDA7CiB9CiAKIApkaWZm
IC1OYXVyIGxpbnV4LTIuNi41LXZhbmlsbGEvaW5jbHVkZS9hc20taTM4Ni9tYWNoLWdlbmVyaWMv
bWFjaF9hcGljLmggbGludXgtMi42LjUvaW5jbHVkZS9hc20taTM4Ni9tYWNoLWdlbmVyaWMvbWFj
aF9hcGljLmgKLS0tIGxpbnV4LTIuNi41LXZhbmlsbGEvaW5jbHVkZS9hc20taTM4Ni9tYWNoLWdl
bmVyaWMvbWFjaF9hcGljLmgJMjAwNC0wNC0wMyAyMjozNjo1Ni4wMDAwMDAwMDAgLTA1MDAKKysr
IGxpbnV4LTIuNi41L2luY2x1ZGUvYXNtLWkzODYvbWFjaC1nZW5lcmljL21hY2hfYXBpYy5oCTIw
MDQtMDUtMDMgMDk6MjA6NDEuMDAwMDAwMDAwIC0wNDAwCkBAIC0zLDE1ICszLDE2IEBACiAKICNp
bmNsdWRlIDxhc20vZ2VuYXBpYy5oPgogCi0jZGVmaW5lIGVzcl9kaXNhYmxlIChnZW5hcGljLT5l
c3JfZGlzYWJsZSkKKyNkZWZpbmUgZXNyX2Rpc2FibGUgKGdlbmFwaWMtPkVTUl9ESVNBQkxFKQog
I2RlZmluZSBOT19CQUxBTkNFX0lSUSAoZ2VuYXBpYy0+bm9fYmFsYW5jZV9pcnEpCiAjZGVmaW5l
IE5PX0lPQVBJQ19DSEVDSwkoZ2VuYXBpYy0+bm9faW9hcGljX2NoZWNrKQogI2RlZmluZSBBUElD
X0JST0FEQ0FTVF9JRCAoZ2VuYXBpYy0+YXBpY19icm9hZGNhc3RfaWQpCiAjZGVmaW5lIElOVF9E
RUxJVkVSWV9NT0RFIChnZW5hcGljLT5pbnRfZGVsaXZlcnlfbW9kZSkKICNkZWZpbmUgSU5UX0RF
U1RfTU9ERSAoZ2VuYXBpYy0+aW50X2Rlc3RfbW9kZSkKKyN1bmRlZiBBUElDX0RFU1RfTE9HSUNB
TAorI2RlZmluZSBBUElDX0RFU1RfTE9HSUNBTCAoZ2VuYXBpYy0+YXBpY19kZXN0aW5hdGlvbl9s
b2dpY2FsKQogI2RlZmluZSBUQVJHRVRfQ1BVUwkgIChnZW5hcGljLT50YXJnZXRfY3B1cygpKQog
I2RlZmluZSBhcGljX2lkX3JlZ2lzdGVyZWQgKGdlbmFwaWMtPmFwaWNfaWRfcmVnaXN0ZXJlZCkK
LSNkZWZpbmUgYXBpY19pZF9yZWdpc3RlcmVkIChnZW5hcGljLT5hcGljX2lkX3JlZ2lzdGVyZWQp
CiAjZGVmaW5lIGluaXRfYXBpY19sZHIgKGdlbmFwaWMtPmluaXRfYXBpY19sZHIpCiAjZGVmaW5l
IGlvYXBpY19waHlzX2lkX21hcCAoZ2VuYXBpYy0+aW9hcGljX3BoeXNfaWRfbWFwKQogI2RlZmlu
ZSBjbHVzdGVyZWRfYXBpY19jaGVjayAoZ2VuYXBpYy0+Y2x1c3RlcmVkX2FwaWNfY2hlY2spIAo=

------_=_NextPart_001_01C43188.6B76E757--
