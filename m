Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbUDEQMi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 12:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbUDEQMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 12:12:37 -0400
Received: from usea-naimss3.unisys.com ([192.61.61.105]:50956 "EHLO
	usea-naimss3.unisys.com") by vger.kernel.org with ESMTP
	id S262914AbUDEQMa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 12:12:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH] 2.6.5- es7000 subarch update
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
Date: Mon, 5 Apr 2004 11:12:24 -0500
Message-ID: <452548B29F0CCE48B8ABB094307EBA1C04C55160@USRV-EXCH2.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.5- es7000 subarch update
Thread-Index: AcQbKL6u4nh526XqRQ+QFHI0Io60FQ==
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: <akpm@digeo.com>, <lse-tech@lists.sourceforge.net>
X-OriginalArrivalTime: 05 Apr 2004 16:12:26.0661 (UTC) FILETIME=[C9822D50:01C41B28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ES7000 was failing to boot since first couple revisions of 2.6. The patch fixes the boot problem. 
In the patch, some maintenance and cleanup was done for es7000 subarch, such as APIC destinations were corrected, missing initialization for the variable was added, extraneous file was removed, etc.
The patch was created against 2.6.5, compiled  cleanly, and tested on the ES7000 system.

Thanks,
--Natalie
------------------------------------

diff -Naur linux6.5/arch/i386/mach-es7000/Makefile linux-2.6.5/arch/i386/mach-es7000/Makefile
--- linux6.5/arch/i386/mach-es7000/Makefile	2004-04-04 18:22:39.000000000 -0400
+++ linux-2.6.5/arch/i386/mach-es7000/Makefile	2004-04-05 00:07:13.000000000 -0400
@@ -2,4 +2,4 @@
 # Makefile for the linux kernel.
 #
 
-obj-y		:= setup.o topology.o es7000.o
+obj-y		:= setup.o es7000.o
diff -Naur linux6.5/arch/i386/mach-es7000/es7000.c linux-2.6.5/arch/i386/mach-es7000/es7000.c
--- linux6.5/arch/i386/mach-es7000/es7000.c	2004-04-04 18:22:39.000000000 -0400
+++ linux-2.6.5/arch/i386/mach-es7000/es7000.c	2004-04-05 00:07:13.000000000 -0400
@@ -82,6 +82,7 @@
 			host_addr = val;
 			host = (struct mip_reg *)val;
 			host_reg = __va(host);
+			mip_port = MIP_PORT(mi->mip_info);
 			val = MIP_RD_LO(mi->mip_reg);
 			mip_addr = val;
 			mip = (struct mip_reg *)val;
diff -Naur linux6.5/arch/i386/mach-es7000/es7000.h linux-2.6.5/arch/i386/mach-es7000/es7000.h
--- linux6.5/arch/i386/mach-es7000/es7000.h	2004-04-04 18:22:39.000000000 -0400
+++ linux-2.6.5/arch/i386/mach-es7000/es7000.h	2004-04-05 00:07:13.000000000 -0400
@@ -32,6 +32,7 @@
 #define	MIP_VALID		0x0100000000000000
 
 #define	MIP_RD_LO(VALUE)	(VALUE & 0xffffffff)   
+#define	MIP_PORT(VALUE)		((VALUE >> 32) & 0xffff)
 
 struct mip_reg_info {
 	unsigned long long mip_info;
diff -Naur linux6.5/arch/i386/mach-es7000/topology.c linux-2.6.5/arch/i386/mach-es7000/topology.c
--- linux6.5/arch/i386/mach-es7000/topology.c	2004-04-04 18:22:39.000000000 -0400
+++ linux-2.6.5/arch/i386/mach-es7000/topology.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,64 +0,0 @@
-/*
- * arch/i386/mach-generic/topology.c - Populate driverfs with topology information
- *
- * Written by: Matthew Dobson, IBM Corporation
- * Original Code: Paul Dorwin, IBM Corporation, Patrick Mochel, OSDL
- *
- * Copyright (C) 2002, IBM Corp.
- *
- * All rights reserved.          
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
-	for (i = 0; i < num_online_nodes(); i++)
-		arch_register_node(i);
-	for (i = 0; i < NR_CPUS; i++)
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
-	for (i = 0; i < NR_CPUS; i++)
-		if (cpu_possible(i)) arch_register_cpu(i);
-	return 0;
-}
-
-#endif /* CONFIG_NUMA */
-
-subsys_initcall(topology_init);
diff -Naur linux6.5/arch/i386/kernel/mpparse.c linux-2.6.5/arch/i386/kernel/mpparse.c
--- linux6.5/arch/i386/kernel/mpparse.c	2004-04-04 18:22:39.000000000 -0400
+++ linux-2.6.5/arch/i386/kernel/mpparse.c	2004-04-05 00:07:13.000000000 -0400
@@ -969,7 +969,7 @@
 	 */
 	for (i = 0; i < mp_irq_entries; i++) {
 		if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus) 
-			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
+			&& (mp_irqs[i].mpc_dstirq == intsrc.mpc_dstirq)) {
 			mp_irqs[i] = intsrc;
 			found = 1;
 			break;
diff -Naur linux6.5/include/asm-i386/mach-es7000/mach_apic.h linux-2.6.5/include/asm-i386/mach-es7000/mach_apic.h
--- linux6.5/include/asm-i386/mach-es7000/mach_apic.h	2004-04-04 18:22:46.000000000 -0400
+++ linux-2.6.5/include/asm-i386/mach-es7000/mach_apic.h	2004-04-05 00:11:50.000000000 -0400
@@ -39,7 +39,7 @@
 #endif
 
 #define APIC_BROADCAST_ID	(0xff)
-#define NO_IOAPIC_CHECK (0)
+#define NO_IOAPIC_CHECK (1)
 
 static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)
 { 
@@ -166,10 +166,12 @@
 	int cpu;
 	int apicid;	
 
+#if defined CONFIG_ES7000_CLUSTERED_APIC
+	return 0xFF;
+#endif
 	num_bits_set = cpus_weight_const(cpumask);
-	/* Return id to all */
 	if (num_bits_set == NR_CPUS)
-		return 0xFF;
+		return cpu_to_logical_apicid(0);
 	/* 
 	 * The cpus in the mask must all be on the apic cluster.  If are not 
 	 * on the same apicid cluster return default value of TARGET_CPUS. 
@@ -182,7 +184,7 @@
 			if (apicid_cluster(apicid) != 
 					apicid_cluster(new_apicid)){
 				printk ("%s: Not a valid mask!\n",__FUNCTION__);
-				return 0xFF;
+				return cpu_to_logical_apicid(0);
 			}
 			apicid = new_apicid;
 			cpus_found++;

----------------------------------------------------


