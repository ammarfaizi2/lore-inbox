Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSHVTNe>; Thu, 22 Aug 2002 15:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSHVTNe>; Thu, 22 Aug 2002 15:13:34 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:43175 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315748AbSHVTN3>; Thu, 22 Aug 2002 15:13:29 -0400
Message-ID: <3D65383B.9030406@us.ibm.com>
Date: Thu, 22 Aug 2002 12:15:07 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
CC: Martin Bligh <mjbligh@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: [patch] Simple Topology API v0.3 (2/2)
Content-Type: multipart/mixed;
 boundary="------------080604070304050503010508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080604070304050503010508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew, Linus, et al:
	Here's the latest version of the Simple Topology API.  I've broken the patches 
into a solely in-kernel portion, and a portion that exposes the API to 
userspace via syscalls and prctl.  This patch (part 2) is the userspace part. I 
hope that the smaller versions of these patches will draw more feedback, 
comments, flames, etc.  Other than that, the patch remains relatively unchanged 
from the last posting.

Cheers!

-Matt



--------------080604070304050503010508
Content-Type: text/plain;
 name="simple_topo-v0.3-userspace-2.5.31.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="simple_topo-v0.3-userspace-2.5.31.patch"

diff -Nur linux-2.5.27-vanilla/arch/i386/kernel/entry.S linux-2.5.27-api/arch/i386/kernel/entry.S
--- linux-2.5.27-vanilla/arch/i386/kernel/entry.S	Sat Jul 20 12:11:11 2002
+++ linux-2.5.27-api/arch/i386/kernel/entry.S	Wed Jul 24 17:33:41 2002
@@ -753,6 +753,7 @@
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
 	.long sys_set_thread_area
+	.long sys_check_topology
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -Nur linux-2.5.27-vanilla/include/asm-i386/unistd.h linux-2.5.27-api/include/asm-i386/unistd.h
--- linux-2.5.27-vanilla/include/asm-i386/unistd.h	Sat Jul 20 12:11:26 2002
+++ linux-2.5.27-api/include/asm-i386/unistd.h	Wed Jul 24 17:33:41 2002
@@ -248,6 +248,7 @@
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
 #define __NR_set_thread_area	243
+#define __NR_check_topology	244
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Nur linux-2.5.27-vanilla/include/linux/prctl.h linux-2.5.27-api/include/linux/prctl.h
--- linux-2.5.27-vanilla/include/linux/prctl.h	Sat Jul 20 12:11:22 2002
+++ linux-2.5.27-api/include/linux/prctl.h	Wed Jul 24 17:33:41 2002
@@ -26,4 +26,8 @@
 # define PR_FPEMU_NOPRINT	1	/* silently emulate fp operations accesses */
 # define PR_FPEMU_SIGFPE	2	/* don't emulate fp operations, send SIGFPE instead */
 
+/* Get CPU/Node */
+#define PR_GET_CURR_CPU		11
+#define PR_GET_CURR_NODE    	12
+
 #endif /* _LINUX_PRCTL_H */
diff -Nur linux-2.5.27-vanilla/include/linux/topology.h linux-2.5.27-api/include/linux/topology.h
--- linux-2.5.27-vanilla/include/linux/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.27-api/include/linux/topology.h	Wed Jul 24 17:33:41 2002
@@ -0,0 +1,46 @@
+/*
+ * linux/include/linux/topology.h
+ *
+ * Written by: Matthew Dobson, IBM Corporation
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
+#ifndef _LINUX_TOPOLOGY_H
+#define _LINUX_TOPOLOGY_H
+
+/* For topology conversion functions */
+#define CPU_TO_NODE		1
+#define MEMBLK_TO_NODE      	2
+#define NODE_TO_NODE		3
+#define NODE_TO_CPU		4
+#define NODE_TO_MEMBLK      	5
+
+/* Prototypes */
+int cpu_to_node(int);
+int memblk_to_node(int);
+int node_to_node(int);
+int node_to_cpu(int);
+int node_to_memblk(int);
+int get_curr_cpu(void);
+int get_curr_node(void);
+
+#endif /* _LINUX_TOPOLOGY_H */
diff -Nur linux-2.5.27-vanilla/kernel/Makefile linux-2.5.27-api/kernel/Makefile
--- linux-2.5.27-vanilla/kernel/Makefile	Sat Jul 20 12:11:10 2002
+++ linux-2.5.27-api/kernel/Makefile	Wed Jul 24 17:33:41 2002
@@ -15,7 +15,8 @@
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o \
+	    topology.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -Nur linux-2.5.27-vanilla/kernel/sys.c linux-2.5.27-api/kernel/sys.c
--- linux-2.5.27-vanilla/kernel/sys.c	Sat Jul 20 12:11:07 2002
+++ linux-2.5.27-api/kernel/sys.c	Wed Jul 24 17:33:41 2002
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/times.h>
 #include <linux/security.h>
+#include <linux/topology.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -1236,6 +1237,31 @@
 	mask = xchg(&current->fs->umask, mask & S_IRWXUGO);
 	return mask;
 }
+
+asmlinkage long sys_check_topology(int convert_type, int to_convert)
+{
+	int ret = 0;
+
+	switch (convert_type) {
+		case CPU_TO_NODE:
+			ret = cpu_to_node(to_convert);
+			break;
+		case MEMBLK_TO_NODE:
+			ret = memblk_to_node(to_convert);
+			break;
+		case NODE_TO_NODE:
+			ret = node_to_node(to_convert);
+			break;
+		case NODE_TO_CPU:
+			ret = node_to_cpu(to_convert);
+			break;
+		case NODE_TO_MEMBLK:
+			ret = node_to_memblk(to_convert);
+			break;
+	}
+
+	return (long)ret;
+}
     
 asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
 			  unsigned long arg4, unsigned long arg5)
@@ -1295,6 +1321,12 @@
 			}
 			current->keep_capabilities = arg2;
 			break;
+		case PR_GET_CURR_CPU:
+			error = get_curr_cpu();
+			break;
+		case PR_GET_CURR_NODE:
+			error = get_curr_node();
+			break;
 		default:
 			error = -EINVAL;
 			break;
diff -Nur linux-2.5.27-vanilla/kernel/topology.c linux-2.5.27-api/kernel/topology.c
--- linux-2.5.27-vanilla/kernel/topology.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.27-api/kernel/topology.c	Wed Jul 24 17:33:41 2002
@@ -0,0 +1,127 @@
+/*
+ * linux/kernel/topology.c
+ *
+ * Written by: Matthew Dobson, IBM Corporation
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
+#include <linux/kernel.h>
+#include <linux/unistd.h>
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/mmzone.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+
+/*
+ * cpu_to_node(cpu): Returns the number of the most specific Node 
+ * containing CPU 'cpu'.
+ */
+inline int cpu_to_node(int cpu)
+{
+	if (cpu == -1)     /* return highest numbered node */
+		return (numnodes - 1);
+
+	if ((cpu < 0) || (cpu >= NR_CPUS) ||
+	    (!(cpu_online_map & (1 << cpu))))   /* invalid cpu # */
+		return -ENODEV;
+
+	return _cpu_to_node(cpu);
+}
+
+/*
+ * memblk_to_node(memblk): Returns the number of the most specific Node 
+ * containing Memory Block 'memblk'.
+ */
+inline int memblk_to_node(int memblk)
+{
+	if (memblk == -1)  /* return highest numbered node */
+		return (numnodes - 1);
+
+	if ((memblk < 0) || (memblk >= NR_MEMBLKS) ||
+	    (!(memblk_online_map & (1 << memblk))))   /* invalid memblk # */
+		return -ENODEV;
+
+	return _memblk_to_node(memblk);
+}
+
+/*
+ * node_to_node(nid): Returns the number of the of the most specific Node that
+ * encompasses Node 'nid'.  Some may call this the parent Node of 'nid'.
+ */
+int node_to_node(int nid)
+{
+	if ((nid < 0) || (nid >= numnodes))   /* invalid node # */
+		return -ENODEV;
+
+	return _node_to_node(nid);
+}
+
+/*
+ * node_to_cpu(nid): Returns the lowest numbered CPU on Node 'nid'
+ */
+inline int node_to_cpu(int nid)
+{
+	if (nid == -1)  /* return highest numbered cpu */
+		return (num_online_cpus() - 1);
+
+	if ((nid < 0) || (nid >= numnodes))   /* invalid node # */
+		return -ENODEV;
+
+	return _node_to_cpu(nid);
+}
+
+/*
+ * node_to_memblk(nid): Returns the lowest numbered MemBlk on Node 'nid'
+ */
+inline int node_to_memblk(int nid)
+{
+	if (nid == -1)  /* return highest numbered memblk */
+		return (num_online_memblks() - 1);
+
+	if ((nid < 0) || (nid >= numnodes))   /* invalid node # */
+		return -ENODEV;
+
+	return _node_to_memblk(nid);
+}
+
+/*
+ * get_curr_cpu(): Returns the currently executing CPU number.
+ * For now, this has only mild usefulness, as this information could
+ * change on the return from syscall (which automatically calls schedule()).
+ * Due to this, the data could be stale by the time it gets back to the user.
+ * It will have to do, until a better method is found.
+ */
+inline int get_curr_cpu(void)
+{
+	return smp_processor_id();
+}
+
+/*
+ * get_curr_node(): Returns the number of the Node containing 
+ * the currently executing CPU.  Subject to the same caveat
+ * as the get_curr_cpu() call.
+ */
+inline int get_curr_node(void)
+{
+	return cpu_to_node(get_curr_cpu());
+}

--------------080604070304050503010508--

