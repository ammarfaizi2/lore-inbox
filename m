Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318075AbSGMAeO>; Fri, 12 Jul 2002 20:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318076AbSGMAeN>; Fri, 12 Jul 2002 20:34:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:38590 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318075AbSGMAeH>;
	Fri, 12 Jul 2002 20:34:07 -0400
Message-ID: <3D2F75D7.3060105@us.ibm.com>
Date: Fri, 12 Jul 2002 17:35:35 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@zip.com.au>
Subject: [patch[ Simple Topology API
Content-Type: multipart/mixed;
 boundary="------------010603020600020604040906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010603020600020604040906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is a very rudimentary topology API for NUMA systems.  It uses prctl() for 
the userland calls, and exposes some useful things to userland.  It would be 
nice to expose these simple structures to both users and the kernel itself. 
Any architecture wishing to use this API simply has to write a .h file that 
defines the 5 calls defined in core_ibmnumaq.h and include it in asm/mmzone.h. 
  Voila!  Instant inclusion in the topology!

Enjoy!

-Matt

--------------010603020600020604040906
Content-Type: text/plain;
 name="2.5.25-simple_topo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.5.25-simple_topo.patch"

diff -Nur linux-2.5.25-vanilla/include/asm-i386/core_ibmnumaq.h linux-2.5.25-api/include/asm-i386/core_ibmnumaq.h
--- linux-2.5.25-vanilla/include/asm-i386/core_ibmnumaq.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.25-api/include/asm-i386/core_ibmnumaq.h	Thu Jul 11 13:58:25 2002
@@ -0,0 +1,62 @@
+/*
+ * linux/include/asm-i386/core_ibmnumaq.h
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
+#ifndef _ASM_CORE_IBMNUMAQ_H_
+#define _ASM_CORE_IBMNUMAQ_H_
+
+/*
+ * These functions need to be defined for every architecture.
+ * The first five are necessary for the Memory Binding API to function.
+ * The last is needed by several pieces of NUMA code.
+ */
+
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
+#endif /* _ASM_CORE_IBMNUMAQ_H_ */
diff -Nur linux-2.5.25-vanilla/include/asm-i386/mmzone.h linux-2.5.25-api/include/asm-i386/mmzone.h
--- linux-2.5.25-vanilla/include/asm-i386/mmzone.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.25-api/include/asm-i386/mmzone.h	Fri Jul 12 16:10:43 2002
@@ -0,0 +1,49 @@
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
+#include <asm/smpboot.h>
+
+#ifdef CONFIG_IBMNUMAQ
+#include <asm/core_ibmnumaq.h>
+/* Other architectures wishing to use this simple topology API should fill
+   in the below functions as appropriate in their own <arch>.h file. */
+#else /* !CONFIG_IBMNUMAQ */
+
+#define _cpu_to_node(cpu)	(0)
+#define _memblk_to_node(memblk)	(0)
+#define _node_to_node(nid)	(0)
+#define _node_to_cpu(node)	(0)
+#define _node_to_memblk(node)	(0)
+
+#endif /* CONFIG_IBMNUMAQ */
+
+/* Returns the number of the current Node. */
+#define numa_node_id()		(_cpu_to_node(smp_processor_id()))
+
+#endif /* _ASM_MMZONE_H_ */
diff -Nur linux-2.5.25-vanilla/include/linux/membind.h linux-2.5.25-api/include/linux/membind.h
--- linux-2.5.25-vanilla/include/linux/membind.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.25-api/include/linux/membind.h	Fri Jul 12 16:31:30 2002
@@ -0,0 +1,38 @@
+/*
+ * linux/include/linux/membind.h
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
+#ifndef _LINUX_MEMBIND_H_
+#define _LINUX_MEMBIND_H_
+
+int cpu_to_node(int);
+int memblk_to_node(int);
+int node_to_node(int);
+int node_to_cpu(int);
+int node_to_memblk(int);
+int get_curr_cpu(void);
+int get_curr_node(void);
+
+#endif /* _LINUX_MEMBIND_H_ */
diff -Nur linux-2.5.25-vanilla/include/linux/prctl.h linux-2.5.25-api/include/linux/prctl.h
--- linux-2.5.25-vanilla/include/linux/prctl.h	Fri Jul  5 16:42:28 2002
+++ linux-2.5.25-api/include/linux/prctl.h	Wed Jul 10 13:58:17 2002
@@ -26,4 +26,17 @@
 # define PR_FPEMU_NOPRINT	1	/* silently emulate fp operations accesses */
 # define PR_FPEMU_SIGFPE	2	/* don't emulate fp operations, send SIGFPE instead */
 
+/* Get CPU/Node */
+#define PR_GET_CURR_CPU		13
+#define PR_GET_CURR_NODE    	14
+
+/* XX to Node conversion functions */
+#define PR_CPU_TO_NODE		15
+#define PR_MEMBLK_TO_NODE      	16
+#define PR_NODE_TO_NODE		17
+
+/* Node to XX conversion functions */
+#define PR_NODE_TO_CPU		18
+#define PR_NODE_TO_MEMBLK      	19
+
 #endif /* _LINUX_PRCTL_H */
diff -Nur linux-2.5.25-vanilla/kernel/membind.c linux-2.5.25-api/kernel/membind.c
--- linux-2.5.25-vanilla/kernel/membind.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.25-api/kernel/membind.c	Fri Jul 12 16:13:17 2002
@@ -0,0 +1,130 @@
+/*
+ * linux/kernel/membind.c
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
+#include <linux/membind.h>
+#include <linux/mmzone.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+
+extern unsigned long memblk_online_map;
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
diff -Nur linux-2.5.25-vanilla/kernel/sys.c linux-2.5.25-api/kernel/sys.c
--- linux-2.5.25-vanilla/kernel/sys.c	Fri Jul  5 16:42:04 2002
+++ linux-2.5.25-api/kernel/sys.c	Fri Jul 12 16:11:16 2002
@@ -19,6 +19,7 @@
 #include <linux/tqueue.h>
 #include <linux/device.h>
 #include <linux/times.h>
+#include <linux/membind.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -1291,6 +1292,27 @@
 			}
 			current->keep_capabilities = arg2;
 			break;
+		case PR_GET_CURR_CPU:
+			error = (long) get_curr_cpu();
+			break;
+		case PR_GET_CURR_NODE:
+			error = (long) get_curr_node();
+			break;
+		case PR_CPU_TO_NODE:
+			error = (long) cpu_to_node((int)arg2);
+			break;
+		case PR_MEMBLK_TO_NODE:
+			error = (long) memblk_to_node((int)arg2);
+			break;
+		case PR_NODE_TO_NODE:
+			error = (long) node_to_node((int)arg2);
+			break;
+		case PR_NODE_TO_CPU:
+			error = (long) node_to_cpu((int)arg2);
+			break;
+		case PR_NODE_TO_MEMBLK:
+			error = (long) node_to_memblk((int)arg2);
+			break;
 		default:
 			error = -EINVAL;
 			break;

--------------010603020600020604040906--

