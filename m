Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUDVHOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUDVHOD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUDVHNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:13:13 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:440 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263732AbUDVHJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:09:52 -0400
Date: Thu, 22 Apr 2004 00:07:56 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [Patch 16 of 17] cpumask v4 - Remove cpumask hack from
 asm-x86_64/topology.h
Message-Id: <20040422000756.5dc7c245.pj@sgi.com>
In-Reply-To: <20040421232247.22ffe1f2.pj@sgi.com>
References: <20040421232247.22ffe1f2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mask16-cpumask-x86-64-online - Remove cpumask hack from asm-x86_64/topology.h
        This file had the cpumask cpu_online_map as type
        unsigned long, instead of type cpumask_t, for no good
        reason that I could see.  So I changed it.  Everywhere
        else, cpu_online_map is already of type cpumask_t.

Index: 2.6.5.bitmap/include/asm-x86_64/topology.h
===================================================================
--- 2.6.5.bitmap.orig/include/asm-x86_64/topology.h	2004-04-05 02:41:33.000000000 -0700
+++ 2.6.5.bitmap/include/asm-x86_64/topology.h	2004-04-08 04:23:24.000000000 -0700
@@ -10,18 +10,18 @@
 /* Map the K8 CPU local memory controllers to a simple 1:1 CPU:NODE topology */
 
 extern int fake_node;
-/* This is actually a cpumask_t, but doesn't matter because we don't have
-   >BITS_PER_LONG CPUs */
-extern unsigned long cpu_online_map;
+extern cpumask_t cpu_online_map;
 
 #define cpu_to_node(cpu)		(fake_node ? 0 : (cpu))
 #define parent_node(node)		(node)
 #define node_to_first_cpu(node) 	(fake_node ? 0 : (node))
 #define node_to_cpumask(node)	(fake_node ? cpu_online_map : (1UL << (node)))
 
-static inline unsigned long pcibus_to_cpumask(int bus)
+static inline cpumask_t pcibus_to_cpumask(int bus)
 {
-	return mp_bus_to_cpumask[bus] & cpu_online_map; 
+	cpumask_t tmp;
+	cpus_and(tmp, mp_bus_to_cpumask[bus], cpu_online_map);
+	return tmp;
 }
 
 #define NODE_BALANCE_RATE 30	/* CHECKME */ 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
