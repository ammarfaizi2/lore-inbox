Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265225AbSJWU5i>; Wed, 23 Oct 2002 16:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265227AbSJWU5i>; Wed, 23 Oct 2002 16:57:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:7657 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265225AbSJWU51>;
	Wed, 23 Oct 2002 16:57:27 -0400
Message-ID: <3DB70DC1.204@us.ibm.com>
Date: Wed, 23 Oct 2002 13:59:45 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Patrick Mochel <mochel@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [patch] (2/5) i386 driverfs Topology 2.5.44
References: <2699066091.1035310557@[10.10.2.3]> <Pine.LNX.4.44.0210221824430.983-100000@cherise.pdx.osdl.net> <3DB5FCC5.E54808E@digeo.com> <3DB70CDD.8080506@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------030409050607090407090903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030409050607090407090903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Update/Create i386 specific files for DriverFS Topology.

This patch creates the i386 specific files/functions/structures to 
implement
driverfs Topology.  These structures have the generic CPU/MemBlk/Node 
structures
embedded in them.

This patch also creates the arch-specific initialization routine to 
instantiate the topology.

Cheers!

-Matt

--------------030409050607090407090903
Content-Type: text/plain;
 name="01-arch_additions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-arch_additions.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/arch/i386/mach-generic/Makefile linux-2.5.44-arch_additions/arch/i386/mach-generic/Makefile
--- linux-2.5.44-base/arch/i386/mach-generic/Makefile	Fri Oct 18 21:01:19 2002
+++ linux-2.5.44-arch_additions/arch/i386/mach-generic/Makefile	Wed Oct 23 12:06:18 2002
@@ -4,6 +4,6 @@
 
 EXTRA_CFLAGS	+= -I../kernel
 
-obj-y				:= setup.o
+obj-y				:= setup.o topology.o
 
 include $(TOPDIR)/Rules.make
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/arch/i386/mach-generic/topology.c linux-2.5.44-arch_additions/arch/i386/mach-generic/topology.c
--- linux-2.5.44-base/arch/i386/mach-generic/topology.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44-arch_additions/arch/i386/mach-generic/topology.c	Wed Oct 23 12:07:47 2002
@@ -0,0 +1,69 @@
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
+extern int numnodes;
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for (i = 0; i < numnodes; i++)
+		arch_register_node(i);
+	for (i = 0; i < num_online_cpus(); i++)
+		arch_register_cpu(i);
+	for (i = 0; i < numnodes; i++)
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
+	for (i = 0; i < num_online_cpus(); i++)
+		arch_register_cpu(i);
+	return 0;
+}
+
+#endif /* CONFIG_NUMA */
+
+subsys_initcall(topology_init);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/include/asm-i386/cpu.h linux-2.5.44-arch_additions/include/asm-i386/cpu.h
--- linux-2.5.44-base/include/asm-i386/cpu.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44-arch_additions/include/asm-i386/cpu.h	Wed Oct 23 12:06:18 2002
@@ -0,0 +1,30 @@
+#ifndef _ASM_I386_CPU_H_
+#define _ASM_I386_CPU_H_
+
+#include <linux/device.h>
+#include <linux/cpu.h>
+
+#include <asm/topology.h>
+#include <asm/node.h>
+
+struct i386_cpu {
+	struct cpu cpu;
+};
+extern struct i386_cpu cpu_devices[NR_CPUS];
+
+
+#ifdef CONFIG_NUMA
+static inline void arch_register_cpu(int num){
+	int p_node = __cpu_to_node(num);
+	
+	if (p_node >= 0 && p_node < NR_CPUS)
+		register_cpu(&cpu_devices[num].cpu, num, 
+			&node_devices[p_node].node);
+}
+#else /* !CONFIG_NUMA */
+static inline void arch_register_cpu(int num){
+	register_cpu(&cpu_devices[num].cpu, num, (struct node *) NULL);
+}
+#endif /* CONFIG_NUMA */
+
+#endif /* _ASM_I386_CPU_H_ */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/include/asm-i386/memblk.h linux-2.5.44-arch_additions/include/asm-i386/memblk.h
--- linux-2.5.44-base/include/asm-i386/memblk.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44-arch_additions/include/asm-i386/memblk.h	Wed Oct 23 12:06:18 2002
@@ -0,0 +1,24 @@
+#ifndef _ASM_I386_MEMBLK_H_
+#define _ASM_I386_MEMBLK_H_
+
+#include <linux/device.h>
+#include <linux/mmzone.h>
+#include <linux/memblk.h>
+
+#include <asm/topology.h>
+#include <asm/node.h>
+
+struct i386_memblk {
+	struct memblk memblk;
+};
+extern struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
+
+static inline void arch_register_memblk(int num){
+	int p_node = __memblk_to_node(num);
+
+	if (p_node >= 0 && p_node < MAX_NR_MEMBLKS)
+		register_memblk(&memblk_devices[num].memblk, num, 
+			&node_devices[p_node].node);
+}
+
+#endif /* _ASM_I386_MEMBLK_H_ */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/include/asm-i386/node.h linux-2.5.44-arch_additions/include/asm-i386/node.h
--- linux-2.5.44-base/include/asm-i386/node.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44-arch_additions/include/asm-i386/node.h	Wed Oct 23 12:06:18 2002
@@ -0,0 +1,26 @@
+#ifndef _ASM_I386_NODE_H_
+#define _ASM_I386_NODE_H_
+
+#include <linux/device.h>
+#include <linux/mmzone.h>
+#include <linux/node.h>
+
+#include <asm/topology.h>
+
+struct i386_node {
+	struct node node;
+};
+extern struct i386_node node_devices[MAX_NUMNODES];
+
+static inline void arch_register_node(int num){
+	int p_node = __parent_node(num);
+
+	if (p_node != num)
+		register_node(&node_devices[num].node, num, 
+			&node_devices[p_node].node);
+	else
+		register_node(&node_devices[num].node, num, 
+			(struct node *) NULL);
+}
+
+#endif /* _ASM_I386_NODE_H_ */

--------------030409050607090407090903--

