Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWAUB5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWAUB5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWAUB5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:57:55 -0500
Received: from ns1.siteground.net ([207.218.208.2]:3457 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932386AbWAUB5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:57:54 -0500
Date: Fri, 20 Jan 2006 17:56:33 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>,
       discuss@x86-64.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>, tony.luck@intel.com
Subject: [patch] Fix the node cpumask of a cpu going down
Message-ID: <20060121015633.GD3573@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, x86_64 and ia64 arches do not clear the corresponding bits 
in the node's cpumask when a cpu goes down or cpu bring up is cancelled.  
This is buggy since there are pieces of common code where the cpumask is
checked in the cpu down code path to decide on things (like in  the slab
down path).  PPC does the right thing, but x86_64 and ia64 don't (This 
was the reason Sonny hit upon a slab bug during cpu offline on ppc and
could not reproduce on other arches).  This patch fixes it for x86_64. 
I won't attempt ia64 as I cannot test it.  

Credit for spotting this should go to Alok.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16-rc1/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.16-rc1.orig/arch/x86_64/kernel/smpboot.c	2006-01-20 12:49:06.000000000 -0800
+++ linux-2.6.16-rc1/arch/x86_64/kernel/smpboot.c	2006-01-20 12:49:32.000000000 -0800
@@ -59,6 +59,7 @@
 #include <asm/nmi.h>
 #include <asm/irq.h>
 #include <asm/hw_irq.h>
+#include <asm/numa.h>
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
@@ -890,6 +891,7 @@ do_rest:
 	if (boot_error) {
 		cpu_clear(cpu, cpu_callout_map); /* was set here (do_boot_cpu()) */
 		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
+		clear_node_cpumask(cpu); /* was set by numa_add_cpu */
 		cpu_clear(cpu, cpu_present_map);
 		cpu_clear(cpu, cpu_possible_map);
 		x86_cpu_to_apicid[cpu] = BAD_APICID;
@@ -1187,6 +1189,7 @@ void remove_cpu_from_maps(void)
 	cpu_clear(cpu, cpu_callout_map);
 	cpu_clear(cpu, cpu_callin_map);
 	clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
+	clear_node_cpumask(cpu);
 }
 
 int __cpu_disable(void)
Index: linux-2.6.16-rc1/include/asm-x86_64/numa.h
===================================================================
--- linux-2.6.16-rc1.orig/include/asm-x86_64/numa.h	2006-01-20 12:49:06.000000000 -0800
+++ linux-2.6.16-rc1/include/asm-x86_64/numa.h	2006-01-20 12:49:32.000000000 -0800
@@ -22,8 +22,15 @@ extern void numa_set_node(int cpu, int n
 extern unsigned char apicid_to_node[256];
 #ifdef CONFIG_NUMA
 extern void __init init_cpu_to_node(void);
+
+static inline void clear_node_cpumask(int cpu) 
+{
+	clear_bit(cpu, &node_to_cpumask[cpu_to_node(cpu)]);
+}
+
 #else
 #define init_cpu_to_node() do {} while (0)
+#define clear_node_cpumask(cpu) do {} while (0)
 #endif
 
 #define NUMA_NO_NODE 0xff
