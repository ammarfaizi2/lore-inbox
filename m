Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVHSCoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVHSCoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 22:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVHSCoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 22:44:09 -0400
Received: from fsmlabs.com ([168.103.115.128]:8352 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750940AbVHSCoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 22:44:08 -0400
Date: Thu, 18 Aug 2005 20:49:52 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 !NUMA node_to_cpumask broken in early boot
In-Reply-To: <20050819021216.GF22993@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0508182043310.28588@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0508181919230.28588@montezuma.fsmlabs.com>
 <20050819021216.GF22993@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2005, Andi Kleen wrote:

> On Thu, Aug 18, 2005 at 08:07:53PM -0600, Zwane Mwaikambo wrote:
> > node_to_cpumask on non NUMA systems is broken if used before all the 
> > processors have been brought up as it returns cpu_online_map, as opposed 
> > to NUMA i386 systems which does it earlier than AP bringup. So return 
> > which processors responded via cpu_present_map and switch to 
> > cpu_online_map during normal runtime. This was found whilst testing a 
> > patch which does node dependent work before APs have all gone online.
> 
> Very ugly and will probably cause code bloat.
> 
> If anything define a special early_node_to ... function for this.

Thanks for the feedback, ugly indeed, i was really trying to avoid adding 
a new API function or extra cpu_* variables. Ok, here is an 
early_node_to_cpumask instead.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.13-rc5-mm1/include/asm-i386/topology.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc5-mm1/include/asm-i386/topology.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 topology.h
--- linux-2.6.13-rc5-mm1/include/asm-i386/topology.h	7 Aug 2005 21:38:36 -0000	1.1.1.1
+++ linux-2.6.13-rc5-mm1/include/asm-i386/topology.h	19 Aug 2005 02:47:10 -0000
@@ -92,6 +92,7 @@ extern unsigned long node_end_pfn[];
 extern unsigned long node_remap_size[];
 
 #define node_has_online_mem(nid) (node_start_pfn[nid] != node_end_pfn[nid])
+#define early_node_to_cpumask(nid)	node_to_cpumask(nid)
 
 #else /* !CONFIG_NUMA */
 /*
@@ -99,6 +100,14 @@ extern unsigned long node_remap_size[];
  * above macros here.
  */
 
+static inline cpumask_t early_node_to_cpumask(int nid)
+{
+	if (unlikely(system_state == SYSTEM_BOOTING))
+		return cpu_present_map;
+
+	return cpu_online_map;
+}
+
 #include <asm-generic/topology.h>
 
 #endif /* CONFIG_NUMA */
