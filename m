Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSGYW3R>; Thu, 25 Jul 2002 18:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSGYW3R>; Thu, 25 Jul 2002 18:29:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:9403 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316632AbSGYW3H>;
	Thu, 25 Jul 2002 18:29:07 -0400
Message-ID: <3D407BD2.10907@us.ibm.com>
Date: Thu, 25 Jul 2002 15:29:38 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       lse-tech@lists.sourceforge.net, Andrea Arcangeli <andrea@suse.de>
Subject: [patch] Simple Topology API v0.2
Content-Type: multipart/mixed;
 boundary="------------020102040608000204040404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020102040608000204040404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is the latest revision of the Simple Topology API discussed here on LKML 
last week.  The patch is against 2.5.28.  I have made changes to incorporate 
most of the feedback that I got from the last posting.  Some of the calls have 
changed from prctl() to syscalls.  A couple of functions have been optimized. 
Some files and config options have been renamed to be more in-sync with things 
I expect to happen in the near future.  And the locking was revised.

I look forward to additional discussion on both this and the Memory Binding API 
I'll be posting momentarily.

Cheers!

-Matt

--------------020102040608000204040404
Content-Type: text/plain;
 name="simple_topo-v0.2-2.5.28.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="simple_topo-v0.2-2.5.28.patch"

diff -Nur linux-2.5.27-vanilla/arch/i386/config.in linux-2.5.27-api/arch/i386/config.in
--- linux-2.5.27-vanilla/arch/i386/config.in	Sat Jul 20 12:11:12 2002
+++ linux-2.5.27-api/arch/i386/config.in	Wed Jul 24 17:33:41 2002
@@ -165,7 +165,10 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
-   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   bool 'Multiquad NUMA system' CONFIG_X86_NUMAQ
+   if [ "$CONFIG_X86_NUMAQ" = y ]; then
+      define_bool CONFIG_MULTIQUAD y
+   fi
 fi
 
 bool 'Machine Check Exception' CONFIG_X86_MCE
diff -Nur linux-2.5.27-vanilla/arch/i386/kernel/entry.S linux-2.5.27-api/arch/i386/kernel/entry.S
--- linux-2.5.27-vanilla/arch/i386/kernel/entry.S	Sat Jul 20 12:11:11 2002
+++ linux-2.5.27-api/arch/i386/kernel/entry.S	Wed Jul 24 17:33:41 2002
@@ -753,6 +753,7 @@
 	.long sys_futex		/* 240 */
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
+	.long sys_check_topology
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -Nur linux-2.5.27-vanilla/arch/i386/kernel/smpboot.c linux-2.5.27-api/arch/i386/kernel/smpboot.c
--- linux-2.5.27-vanilla/arch/i386/kernel/smpboot.c	Sat Jul 20 12:11:18 2002
+++ linux-2.5.27-api/arch/i386/kernel/smpboot.c	Wed Jul 24 17:33:41 2002
@@ -63,6 +63,9 @@
 /* Bitmask of currently online CPUs */
 unsigned long cpu_online_map;
 
+/* Bitmask of currently online memory blocks */
+unsigned long memblk_online_map;
+
 static volatile unsigned long cpu_callin_map;
 static volatile unsigned long cpu_callout_map;
 
diff -Nur linux-2.5.27-vanilla/include/asm-i386/mmzone.h linux-2.5.27-api/include/asm-i386/mmzone.h
--- linux-2.5.27-vanilla/include/asm-i386/mmzone.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.27-api/include/asm-i386/mmzone.h	Wed Jul 24 17:33:41 2002
@@ -0,0 +1,57 @@
+/*
+ * linux/include/asm-i386/mmzone.h
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
+#ifndef _ASM_MMZONE_H_
+#define _ASM_MMZONE_H_
+
+#ifdef CONFIG_NUMA
+#define NR_MEMBLKS	32 /* Max number of Memory Blocks */
+#define NR_NODES	32 /* Max number of Nodes */
+#else
+#define NR_MEMBLKS	1
+#define NR_NODES	1
+#endif
+
+#ifdef CONFIG_X86_NUMAQ
+
+#include <asm/numaq.h>
+
+#else /* !CONFIG_X86_NUMAQ */
+
+/* Other architectures wishing to use this simple topology API should fill
+   in the below functions as appropriate in their own <arch>.h file. */
+#define _cpu_to_node(cpu)	(0)
+#define _memblk_to_node(memblk)	(0)
+#define _node_to_node(nid)	(0)
+#define _node_to_cpu(node)	(0)
+#define _node_to_memblk(node)	(0)
+
+#endif /* CONFIG_X86_NUMAQ */
+
+/* Returns the number of the current Node. */
+#define numa_node_id()		(_cpu_to_node(smp_processor_id()))
+
+#endif /* _ASM_MMZONE_H_ */
diff -Nur linux-2.5.27-vanilla/include/asm-i386/numaq.h linux-2.5.27-api/include/asm-i386/numaq.h
--- linux-2.5.27-vanilla/include/asm-i386/numaq.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.27-api/include/asm-i386/numaq.h	Wed Jul 24 17:33:41 2002
@@ -0,0 +1,60 @@
+/*
+ * linux/include/asm-i386/numaq.h
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
+#ifndef _I386_NUMAQ_H
+#define _I386_NUMAQ_H
+
+#ifdef CONFIG_X86_NUMAQ
+
+#include <asm/smpboot.h>
+
+/* Returns the number of the node containing CPU 'cpu' */
+#define _cpu_to_node(cpu) (cpu_to_logical_apicid(cpu) >> 4)
+
+/* Returns the number of the node containing MemBlk 'memblk' */
+#define _memblk_to_node(memblk) (memblk)
+
+/* Returns the number of the node containing Node 'nid'.  This architecture is flat, 
+   so it is a pretty simple function! */
+#define _node_to_node(nid) (nid)
+
+/* Returns the number of the first CPU on Node 'node' */
+static inline int _node_to_cpu(int node)
+{
+	int i, cpu, logical_apicid = node << 4;
+
+	for(i = 1; i < 16; i <<= 1)
+		if ((cpu = logical_apicid_to_cpu(logical_apicid | i)) >= 0)
+			return cpu;
+
+	return 0;
+}
+
+/* Returns the number of the first MemBlk on Node 'node' */
+#define _node_to_memblk(node) (node)
+
+#endif /* CONFIG_X86_NUMAQ */
+#endif /* _I386_NUMAQ_H */
diff -Nur linux-2.5.27-vanilla/include/asm-i386/smp.h linux-2.5.27-api/include/asm-i386/smp.h
--- linux-2.5.27-vanilla/include/asm-i386/smp.h	Sat Jul 20 12:11:06 2002
+++ linux-2.5.27-api/include/asm-i386/smp.h	Wed Jul 24 17:33:41 2002
@@ -55,6 +55,7 @@
 extern void smp_alloc_memory(void);
 extern unsigned long phys_cpu_present_map;
 extern unsigned long cpu_online_map;
+extern unsigned long memblk_online_map;
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
 extern int smp_num_siblings;
@@ -99,6 +100,11 @@
 	return hweight32(cpu_online_map);
 }
 
+extern inline unsigned int num_online_memblks(void)
+{
+	return hweight32(memblk_online_map);
+}
+
 extern inline int any_online_cpu(unsigned int mask)
 {
 	if (mask & cpu_online_map)
diff -Nur linux-2.5.27-vanilla/include/asm-i386/unistd.h linux-2.5.27-api/include/asm-i386/unistd.h
--- linux-2.5.27-vanilla/include/asm-i386/unistd.h	Sat Jul 20 12:11:26 2002
+++ linux-2.5.27-api/include/asm-i386/unistd.h	Wed Jul 24 17:33:41 2002
@@ -247,6 +247,7 @@
 #define __NR_futex		240
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
+#define __NR_check_topology	243
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Nur linux-2.5.27-vanilla/include/linux/mmzone.h linux-2.5.27-api/include/linux/mmzone.h
--- linux-2.5.27-vanilla/include/linux/mmzone.h	Sat Jul 20 12:11:05 2002
+++ linux-2.5.27-api/include/linux/mmzone.h	Wed Jul 24 17:33:41 2002
@@ -9,6 +9,8 @@
 #include <linux/list.h>
 #include <linux/wait.h>
 
+#include <asm/mmzone.h>
+
 /*
  * Free memory management - zoned buddy allocator.
  */
@@ -169,9 +171,7 @@
 #define NODE_MEM_MAP(nid)	mem_map
 #define MAX_NR_NODES		1
 
-#else /* !CONFIG_DISCONTIGMEM */
-
-#include <asm/mmzone.h>
+#else /* CONFIG_DISCONTIGMEM */
 
 /* page->zone is currently 8 bits ... */
 #define MAX_NR_NODES		(255 / MAX_NR_ZONES)
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
diff -Nur linux-2.5.27-vanilla/include/linux/smp.h linux-2.5.27-api/include/linux/smp.h
--- linux-2.5.27-vanilla/include/linux/smp.h	Sat Jul 20 12:11:22 2002
+++ linux-2.5.27-api/include/linux/smp.h	Wed Jul 24 17:33:41 2002
@@ -86,6 +86,7 @@
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
+#define memblk_online_map			1
 #define cpu_online_map				1
 #define cpu_online(cpu)				1
 #define num_online_cpus()			1
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
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o \
+	    topology.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
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

--------------020102040608000204040404--

