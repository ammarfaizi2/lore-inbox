Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267129AbTBLOBf>; Wed, 12 Feb 2003 09:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbTBLOBf>; Wed, 12 Feb 2003 09:01:35 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:42368 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267130AbTBLOAs>; Wed, 12 Feb 2003 09:00:48 -0500
Date: Wed, 12 Feb 2003 23:09:30 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (24/34) mach-update
Message-ID: <20030212140930.GY1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (24/34).

Updates files under arch/i386/mach-pc9800 in 2.5.50-ac1.

- Osamu Tomita

diff -Nru linux-2.5.50-ac1/arch/i386/mach-pc9800/Makefile linux98-2.5.52/arch/i386/mach-pc9800/Makefile
--- linux-2.5.50-ac1/arch/i386/mach-pc9800/Makefile	2002-12-17 09:07:10.000000000 +0900
+++ linux98-2.5.52/arch/i386/mach-pc9800/Makefile	2002-12-16 11:07:52.000000000 +0900
@@ -1,15 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
-# Note 2! The CFLAGS definitions are now in the main makefile...
 
 EXTRA_CFLAGS	+= -I../kernel
-export-objs     := 
-
-obj-y				:= setup.o
 
-include $(TOPDIR)/Rules.make
+obj-y				:= setup.o topology.o
diff -Nru linux-2.5.50-ac1/arch/i386/mach-pc9800/setup.c linux98-2.5.52/arch/i386/mach-pc9800/setup.c
--- linux-2.5.50-ac1/arch/i386/mach-pc9800/setup.c	2002-12-11 13:09:57.000000000 +0900
+++ linux98-2.5.52/arch/i386/mach-pc9800/setup.c	2002-12-20 15:08:00.000000000 +0900
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/apm_bios.h>
 #include <asm/setup.h>
 #include <asm/arch_hooks.h>
 
@@ -16,9 +17,6 @@
 	unsigned char table[0];
 };
 
-/* Indicates PC-9800 architecture  No:0 Yes:1 */
-extern int pc98;
-
 /**
  * pre_intr_init_hook - initialisation prior to setting up interrupt vectors
  *
@@ -68,7 +66,9 @@
 {
 	SYS_DESC_TABLE.length = 0;
 	MCA_bus = 0;
-	pc98 = 1;
+	/* In PC-9800, APM BIOS version is written in BCD...?? */
+	APM_BIOS_INFO.version = (APM_BIOS_INFO.version & 0xff00)
+				| ((APM_BIOS_INFO.version & 0x00f0) >> 4);
 }
 
 /**
diff -Nru linux-2.5.52/arch/i386/mach-pc9800/topology.c linux98-2.5.52/arch/i386/mach-pc9800/topology.c
--- linux-2.5.52/arch/i386/mach-pc9800/topology.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.52/arch/i386/mach-pc9800/topology.c	2002-12-16 11:08:16.000000000 +0900
@@ -0,0 +1,68 @@
+/*
+ * arch/i386/mach-generic/topology.c - Populate driverfs with topology information
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ * Original Code: Paul Dorwin, IBM Corporation, Patrick Mochel, OSDL
+ *
+ * Copyright (C) 2002, IBM Corp.
+ *
+ * All rights reserved.          
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <colpatch@us.ibm.com>
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <asm/cpu.h>
+
+struct i386_cpu cpu_devices[NR_CPUS];
+
+#ifdef CONFIG_NUMA
+#include <linux/mmzone.h>
+#include <asm/node.h>
+#include <asm/memblk.h>
+
+struct i386_node node_devices[MAX_NUMNODES];
+struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for (i = 0; i < num_online_nodes(); i++)
+		arch_register_node(i);
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i)) arch_register_cpu(i);
+	for (i = 0; i < num_online_memblks(); i++)
+		arch_register_memblk(i);
+	return 0;
+}
+
+#else /* !CONFIG_NUMA */
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i)) arch_register_cpu(i);
+	return 0;
+}
+
+#endif /* CONFIG_NUMA */
+
+subsys_initcall(topology_init);
