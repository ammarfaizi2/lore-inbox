Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSHVTMI>; Thu, 22 Aug 2002 15:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSHVTMI>; Thu, 22 Aug 2002 15:12:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:50328 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315690AbSHVTMF>; Thu, 22 Aug 2002 15:12:05 -0400
Message-ID: <3D6537D3.3080905@us.ibm.com>
Date: Thu, 22 Aug 2002 12:13:23 -0700
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
Subject: [patch] SImple Topology API v0.3 (1/2)
Content-Type: multipart/mixed;
 boundary="------------000502020802040909080606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000502020802040909080606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew, Linus, et al:
	Here's the latest version of the Simple Topology API.  I've broken the patches 
into a solely in-kernel portion, and a portion that exposes the API to 
userspace via syscalls and prctl.  This patch (part 1) is the in-kernel part. 
I hope that the smaller versions of these patches will draw more feedback, 
comments, flames, etc.  Other than that, the patch remains relatively unchanged 
from the last posting.

Cheers!

-Matt

--------------000502020802040909080606
Content-Type: text/plain;
 name="simple_topo-v0.3-in_kernel-2.5.31.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="simple_topo-v0.3-in_kernel-2.5.31.patch"

diff -Nur linux-2.5.27-vanilla/arch/i386/config.in linux-2.5.27-api/arch/i386/config.in
--- linux-2.5.27-vanilla/arch/i386/config.in	Sat Jul 20 12:11:12 2002
+++ linux-2.5.27-api/arch/i386/config.in	Wed Jul 24 17:33:41 2002
@@ -166,7 +166,15 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
-   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
+   if [ "$CONFIG_X86_NUMA" = "y" ]; then
+      #Platform Choices
+      bool 'Multiquad (IBM/Sequent) NUMAQ support' CONFIG_X86_NUMAQ
+      if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
+         define_bool CONFIG_MULTIQUAD y
+         define_bool CONFIG_X86_TSC_DISABLE y
+      fi
+   fi
 fi
 
 bool 'Machine Check Exception' CONFIG_X86_MCE
diff -Nur linux-2.5.27-vanilla/arch/i386/kernel/smpboot.c linux-2.5.27-api/arch/i386/kernel/smpboot.c
--- linux-2.5.27-vanilla/arch/i386/kernel/smpboot.c	Sat Jul 20 12:11:18 2002
+++ linux-2.5.27-api/arch/i386/kernel/smpboot.c	Wed Jul 24 17:33:41 2002
@@ -60,6 +60,9 @@
 /* Bitmask of currently online CPUs */
 unsigned long cpu_online_map;
 
+/* Bitmask of currently online memory blocks */
+unsigned long memblk_online_map;
+
 static volatile unsigned long cpu_callin_map;
 volatile unsigned long cpu_callout_map;
 static unsigned long smp_commenced_mask;
diff -Nur linux-2.5.27-vanilla/include/asm-i386/mmzone.h linux-2.5.27-api/include/asm-i386/mmzone.h
--- linux-2.5.27-vanilla/include/asm-i386/mmzone.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.27-api/include/asm-i386/mmzone.h	Wed Jul 24 17:33:41 2002
@@ -0,0 +1,53 @@
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
+#ifdef CONFIG_X86_NUMAQ
+
+#define NR_MEMBLKS	32 /* Max number of Memory Blocks */
+
+#include <asm/numaq.h>
+
+#else /* !CONFIG_X86_NUMAQ */
+
+#define NR_MEMBLKS	1
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
@@ -95,6 +96,11 @@
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
diff -Nur linux-2.5.27-vanilla/include/linux/mmzone.h linux-2.5.27-api/include/linux/mmzone.h
--- linux-2.5.27-vanilla/include/linux/mmzone.h	Sat Jul 20 12:11:05 2002
+++ linux-2.5.27-api/include/linux/mmzone.h	Wed Jul 24 17:33:41 2002
@@ -220,15 +20,15 @@
 #define NODE_MEM_MAP(nid)	mem_map
 #define MAX_NR_NODES		1
 
-#else /* !CONFIG_DISCONTIGMEM */
-
-#include <asm/mmzone.h>
+#else /* CONFIG_DISCONTIGMEM */
 
 /* page->zone is currently 8 bits ... */
 #define MAX_NR_NODES		(255 / MAX_NR_ZONES)
 
 #endif /* !CONFIG_DISCONTIGMEM */
 
+#include <asm/mmzone.h>
+
 #define MAP_ALIGN(x)	((((x) % sizeof(struct page)) == 0) ? (x) : ((x) + \
 		sizeof(struct page) - ((x) % sizeof(struct page))))
 
diff -Nur linux-2.5.27-vanilla/include/linux/smp.h linux-2.5.27-api/include/linux/smp.h
--- linux-2.5.27-vanilla/include/linux/smp.h	Sat Jul 20 12:11:22 2002
+++ linux-2.5.27-api/include/linux/smp.h	Wed Jul 24 17:33:41 2002
@@ -93,6 +93,7 @@
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
+#define memblk_online_map			1
 #define cpu_online_map				1
 #define cpu_online(cpu)				({ cpu; 1; })
 #define num_online_cpus()			1

--------------000502020802040909080606--

