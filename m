Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbUC2M7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUC2MaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:30:03 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:44219 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262850AbUC2MRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:17:48 -0500
Date: Mon, 29 Mar 2004 04:16:17 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT:  remove x86_64 topology.h cpumask hack  [20/22]
Message-Id: <20040329041617.2c3c1034.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_20_of_22 - Remove cpumask hack from asm-x86_64/topology.h
	This file had the cpumask cpu_online_map as type
	unsigned long, instead of type cpumask_t, for no good
	reason that I could see.  So I changed it.  Everywhere
	else, cpu_online_map is already of type cpumask_t.

diffstat Patch_20_of_22:
 topology.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1726  -> 1.1727 
#	include/asm-x86_64/topology.h	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/29	pj@sgi.com	1.1727
# Respecify cpu_online_map as actual cpumask_t, instead of unsigned long hack.
# --------------------------------------------
#
diff -Nru a/include/asm-x86_64/topology.h b/include/asm-x86_64/topology.h
--- a/include/asm-x86_64/topology.h	Mon Mar 29 01:04:06 2004
+++ b/include/asm-x86_64/topology.h	Mon Mar 29 01:04:06 2004
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
