Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVHSCBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVHSCBy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 22:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVHSCBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 22:01:54 -0400
Received: from fsmlabs.com ([168.103.115.128]:62366 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750926AbVHSCBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 22:01:53 -0400
Date: Thu, 18 Aug 2005 20:07:53 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] i386 !NUMA node_to_cpumask broken in early boot
Message-ID: <Pine.LNX.4.61.0508181919230.28588@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

node_to_cpumask on non NUMA systems is broken if used before all the 
processors have been brought up as it returns cpu_online_map, as opposed 
to NUMA i386 systems which does it earlier than AP bringup. So return 
which processors responded via cpu_present_map and switch to 
cpu_online_map during normal runtime. This was found whilst testing a 
patch which does node dependent work before APs have all gone online.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.13-rc5-mm1/include/asm-i386/topology.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc5-mm1/include/asm-i386/topology.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 topology.h
--- linux-2.6.13-rc5-mm1/include/asm-i386/topology.h	7 Aug 2005 21:38:36 -0000	1.1.1.1
+++ linux-2.6.13-rc5-mm1/include/asm-i386/topology.h	19 Aug 2005 01:35:07 -0000
@@ -99,6 +99,15 @@ extern unsigned long node_remap_size[];
  * above macros here.
  */
 
+#define node_to_cpumask(node)	_node_to_cpumask(node)
+static inline cpumask_t _node_to_cpumask(int node)
+{
+	if (unlikely(system_state == SYSTEM_BOOTING))
+		return cpu_present_map;
+
+	return cpu_online_map;
+}
+
 #include <asm-generic/topology.h>
 
 #endif /* CONFIG_NUMA */
