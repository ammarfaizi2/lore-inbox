Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbUDAV31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUDAV24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:28:56 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:13622 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263205AbUDAVO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:14:28 -0500
Date: Thu, 1 Apr 2004 13:13:09 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 22/23] mask v2 - Fix cpumask in asm-x86_64/topology.h
Message-Id: <20040401131309.6b1881b3.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_22_of_23 - Remove cpumask hack from asm-x86_64/topology.h
	This file had the cpumask cpu_online_map as type
	unsigned long, instead of type cpumask_t, for no good
	reason that I could see.  So I changed it.  Everywhere
	else, cpu_online_map is already of type cpumask_t.

Diffstat Patch_22_of_23:
 topology.h                     |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

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
