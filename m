Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSEBWyD>; Thu, 2 May 2002 18:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSEBWyC>; Thu, 2 May 2002 18:54:02 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:63424 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315455AbSEBWwy>; Thu, 2 May 2002 18:52:54 -0400
Message-ID: <3CD1C2A3.95321649@us.ibm.com>
Date: Thu, 02 May 2002 15:50:11 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
CC: mjbligh@us.ibm.com, lse-tech@lists.sourceforge.net, rml@tech9.net,
        efocht@ess.nec.de
Subject: [patch] NUMA API for 2.5.12 (1/4)
Content-Type: multipart/mixed;
 boundary="------------8E8A4080AA15267D387D6664"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8E8A4080AA15267D387D6664
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ok all,
	I'm going to go ahead and assume (hope) that the no response on the last
posting was because the patch was really large.  We'll try this again with 4
smaller patches and see what happens.

	This patch implements the NUMA API specified at:
http://lse.sourceforge.net/numa/numa_api.html for the 2.5.12 version of the
kernel.  The API implements such features as binding processes to CPUs
(similar to Robert Love's recent patch), binding to memory blocks, setting
launch policies for processes, and rudimentary topology features.  The patch
is currently used via a prctl() interface with a possible /proc interface in
the future.  I also have a syscall version if that is preferred.

	Again, this is a slightly cleaned-up, and (more) bite-sized version of the
previous patch sent out...

Enjoy, and please send me any comments on the patch, or the API it implements!

-Matt
colpatch@us.ibm.com
--------------8E8A4080AA15267D387D6664
Content-Type: text/plain; charset=us-ascii;
 name="numa_api-arch_dep-2.5.12.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numa_api-arch_dep-2.5.12.patch"

diff -Nur linux-2.5.12-vanilla/arch/i386/Config.help linux-2.5.12-api/arch/i386/Config.help
--- linux-2.5.12-vanilla/arch/i386/Config.help	Sun Apr 28 20:11:34 2002
+++ linux-2.5.12-api/arch/i386/Config.help	Wed May  1 17:21:13 2002
@@ -48,6 +48,13 @@
   You will need a new lynxer.elf file to flash your firmware with - send
   email to Martin.Bligh@us.ibm.com
 
+CONFIG_NUMA_API
+  This option is used to turn on support for the NUMA API, which allows
+  the binding of processes to specific processors/nodes/memory blocks.
+  This option is also used for some of the NUMA Topology features.
+  Please email Matthew Dobson <colpatch@us.ibm.com> with questions
+  and/or concerns.
+
 CONFIG_X86_UP_IOAPIC
   An IO-APIC (I/O Advanced Programmable Interrupt Controller) is an
   SMP-capable replacement for PC-style interrupt controllers. Most
diff -Nur linux-2.5.12-vanilla/arch/i386/config.in linux-2.5.12-api/arch/i386/config.in
--- linux-2.5.12-vanilla/arch/i386/config.in	Sun Apr 28 20:12:15 2002
+++ linux-2.5.12-api/arch/i386/config.in	Wed May  1 17:21:13 2002
@@ -198,6 +198,7 @@
    fi
 else
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   bool 'Non-Uniform Memory Access API support' CONFIG_NUMA_API
 fi
 
 if [ "$CONFIG_SMP" = "y" -o "$CONFIG_PREEMPT" = "y" ]; then
diff -Nur linux-2.5.12-vanilla/include/asm-i386/core_ibmnumaq.h linux-2.5.12-api/include/asm-i386/core_ibmnumaq.h
--- linux-2.5.12-vanilla/include/asm-i386/core_ibmnumaq.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.12-api/include/asm-i386/core_ibmnumaq.h	Wed May  1 17:24:25 2002
@@ -0,0 +1,60 @@
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
+#ifndef _ASM_CORE_IBMNUMAQ_H_
+#define _ASM_CORE_IBMNUMAQ_H_
+
+/*
+ * These functions need to be defined for every architecture.
+ * The first five are necessary for the NUMA API to function.
+ * The last is needed by several pieces of NUMA code.
+ */
+
+/* Returns the number of the node containing CPU 'cpu' */
+#define _cpu_to_node(cpu)	(cpu_to_logical_apicid(cpu) >> 4)
+
+/* Returns the number of the node containing MemBlk 'memblk' */
+#define _memblk_to_node(memblk)	(memblk)
+
+/* Returns the number of the node containing Node 'nid'.  This architecture is flat, 
+   so it is a pretty simple function. */
+#define _node_to_node(nid)	(nid)
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
+#define _node_to_memblk(node)	(node)
+
+#endif /* _ASM_CORE_IBMNUMAQ_H_ */
diff -Nur linux-2.5.12-vanilla/include/asm-i386/mmzone.h linux-2.5.12-api/include/asm-i386/mmzone.h
--- linux-2.5.12-vanilla/include/asm-i386/mmzone.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.12-api/include/asm-i386/mmzone.h	Wed May  1 17:24:25 2002
@@ -0,0 +1,44 @@
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
+#else /* !CONFIG_IBMNUMAQ */
+#define _cpu_to_node(cpu)	(0)
+#define _memblk_to_node(memblk)	(0)
+#define _node_to_node(nid)	(0)
+#define _node_to_cpu(node)	(0)
+#define _node_to_memblk(node)	(0)
+#endif /* CONFIG_IBMNUMAQ */
+
+/* Returns the number of the current Node. */
+#define numa_node_id()		(_cpu_to_node(smp_processor_id()))
+
+#endif /* _ASM_MMZONE_H_ */

--------------8E8A4080AA15267D387D6664--

