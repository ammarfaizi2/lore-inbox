Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTJVVq2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 17:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTJVVq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 17:46:28 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:47321 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261193AbTJVVqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 17:46:23 -0400
Subject: [PATCH] trivial ia64 numa/discontig fixes
From: Alex Williamson <alex.williamson@hp.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1066859181.1191.96.camel@patsy.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 22 Oct 2003 15:46:21 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I stumbled on a couple trivial bugs in ia64 numa/discontig support. 
The first just sets the default number of nodes to something reasonable
for a generic kernel, otherwise it's really easy to start walking over
your initdata (more error checking should probably be added).  The
second fixes a memcpy to a physical address.  Patch below, please
apply.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

--- linux-2.5/include/asm-ia64/numnodes.h	Wed Oct 22 15:14:03 2003
+++ linux-2.5/include/asm-ia64/numnodes.h	Wed Oct 22 13:26:08 2003
@@ -4,7 +4,7 @@
 #ifdef CONFIG_IA64_DIG
 /* Max 8 Nodes */
 #define NODES_SHIFT	3
-#elif defined(CONFIG_IA64_SGI_SN2)
+#elif defined(CONFIG_IA64_SGI_SN2) || defined(CONFIG_IA64_GENERIC)
 /* Max 128 Nodes */
 #define NODES_SHIFT	7
 #endif
--- linux-2.5/arch/ia64/mm/discontig.c	Wed Oct 22 15:13:48 2003
+++ linux-2.5/arch/ia64/mm/discontig.c	Wed Oct 22 15:16:42 2003
@@ -186,7 +186,7 @@
 			 */
 			for (cpu = 0; cpu < NR_CPUS; cpu++) {
 				if (node == node_cpuid[cpu].nid) {
-					memcpy(cpu_data, __phys_per_cpu_start,
+					memcpy(__va(cpu_data), __phys_per_cpu_start,
 					       __per_cpu_end-__per_cpu_start);
 					__per_cpu_offset[cpu] =
 						(char*)__va(cpu_data) -


