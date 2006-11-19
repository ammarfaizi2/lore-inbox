Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756575AbWKSLPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575AbWKSLPu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 06:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756577AbWKSLPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 06:15:50 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:35724 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1756575AbWKSLPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 06:15:49 -0500
Subject: [patch] Export Last Level Cache topology to userspace
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 19 Nov 2006 12:15:20 +0100
Message-Id: <1163934920.31358.494.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

right now the sysfs topology information exports things like sibling
maps (which cpu is a hyperthreading peer of another) and which "linux
cpus" share the physical package. The patch below adds a bitmap in the
same style that exports which "linux cpus" share the last level cache.
This is relevant at least for the current line of Intel Quad cores (but
also for AMD's dual core offering) where the biggest cache isn't shared
on the package level, but only be some cores (Intel) or only one core
(AMD). 

This information is useful for userspace that wants to do explicit
process placement, and in specific, I'm going to need it in the
irqbalance rewrite (which is going to balance irqs on the cache domain
level).


Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6.19-rc6/drivers/base/topology.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/base/topology.c
+++ linux-2.6.19-rc6/drivers/base/topology.c
@@ -81,11 +81,20 @@ define_one_ro(core_siblings);
 #define ref_core_siblings_attr
 #endif
 
+#ifdef topology_llc_siblings
+define_siblings_show_func(llc_siblings);
+define_one_ro(llc_siblings);
+#define ref_llc_siblings_attr		&attr_llc_siblings.attr,
+#else
+#define ref_llc_siblings_attr
+#endif
+
 static struct attribute *default_attrs[] = {
 	ref_physical_package_id_attr
 	ref_core_id_attr
 	ref_thread_siblings_attr
 	ref_core_siblings_attr
+	ref_llc_siblings_attr
 	NULL
 };
 
Index: linux-2.6.19-rc6/include/asm-x86_64/topology.h
===================================================================
--- linux-2.6.19-rc6.orig/include/asm-x86_64/topology.h
+++ linux-2.6.19-rc6/include/asm-x86_64/topology.h
@@ -60,6 +60,7 @@ extern int __node_distance(int, int);
 #define topology_core_id(cpu)			(cpu_data[cpu].cpu_core_id)
 #define topology_core_siblings(cpu)		(cpu_core_map[cpu])
 #define topology_thread_siblings(cpu)		(cpu_sibling_map[cpu])
+#define topology_llc_siblings(cpu)		(cpu_data[cpu].llc_shared_map)
 #define mc_capable()			(boot_cpu_data.x86_max_cores > 1)
 #define smt_capable() 			(smp_num_siblings > 1)
 #endif

