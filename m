Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264367AbUFDGSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbUFDGSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 02:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUFDGSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 02:18:24 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:28155 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S264367AbUFDGSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 02:18:21 -0400
Subject: [PATCH] NUMA-aware per-cpu allocation
From: Rusty Russell <rusty@rustcorp.com.au>
To: Anton Blanchard <anton@samba.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>
Content-Type: text/plain
Message-Id: <1086329823.7990.1101.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Jun 2004 16:17:04 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stolen from x86_64: if we have NUMA, then use alloc_bootmem_node.

Can't hurt, I figure.

In 2.7, my cunning plan is to require contiguous sections, and allocate
similar sections for the dynamic per-cpu allocations, so this won't work
(archs will need to use tricks to create virtually-contiguous memory
from different NUMA nodes).  I have a bitrotted implementation.

Meanwhile, this compiles: does it help performance?

Name: Per-CPU Memory On Right Nodes
Status: Untested

Stolen from x86_64: for NUMA machines, allocate the per-cpu memory
using alloc_bootmem_node so it's optimally placed.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1784-linux-2.6.7-rc2-bk4/include/asm-ppc64/percpu.h .1784-linux-2.6.7-rc2-bk4.updated/include/asm-ppc64/percpu.h
--- .1784-linux-2.6.7-rc2-bk4/include/asm-ppc64/percpu.h	2004-02-04 15:39:11.000000000 +1100
+++ .1784-linux-2.6.7-rc2-bk4.updated/include/asm-ppc64/percpu.h	2004-06-04 14:49:59.000000000 +1000
@@ -1,6 +1,8 @@
 #ifndef __ARCH_PPC64_PERCPU__
 #define __ARCH_PPC64_PERCPU__
 
+/* Big sloppy arch needs more per-cpu room than usual */
+#define PERCPU_ENOUGH_ROOM 65536
 #include <asm-generic/percpu.h>
 
 #endif /* __ARCH_PPC64_PERCPU__ */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .1784-linux-2.6.7-rc2-bk4/init/main.c .1784-linux-2.6.7-rc2-bk4.updated/init/main.c
--- .1784-linux-2.6.7-rc2-bk4/init/main.c	2004-05-31 09:57:40.000000000 +1000
+++ .1784-linux-2.6.7-rc2-bk4.updated/init/main.c	2004-06-04 14:53:17.000000000 +1000
@@ -338,12 +338,26 @@ static void __init setup_per_cpu_areas(v
 		size = PERCPU_ENOUGH_ROOM;
 #endif
 
+	/* Multiple allocs for non-NUMA just wastes memory. */
+#ifdef CONFIG_NUMA
+	for (i = 0; i < NR_CPUS; i++) { 
+		pg_data_t *pgdat;
+
+		pgdat = NODE_DATA(cpu_to_node(i));
+		ptr = alloc_bootmem_node(pgdat, size);
+		if (!ptr)
+			panic("Cannot allocate cpu data for CPU %ld\n", i);
+		__per_cpu_offset[i] = ptr - __per_cpu_start;
+		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
+	}
+#else
 	ptr = alloc_bootmem(size * NR_CPUS);
 
 	for (i = 0; i < NR_CPUS; i++, ptr += size) {
 		__per_cpu_offset[i] = ptr - __per_cpu_start;
 		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
 	}
+#endif /* CONFIG_NUMA */
 }
 #endif /* !__GENERIC_PER_CPU */
 

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

