Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUH2Qsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUH2Qsi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268161AbUH2Qsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:48:38 -0400
Received: from holomorphy.com ([207.189.100.168]:27822 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268132AbUH2Qsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:48:32 -0400
Date: Sun, 29 Aug 2004 09:48:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       nathanl@austin.ibm.com, jbarnes@sgi.com
Subject: Re: sched_domains + NUMA issue
Message-ID: <20040829164825.GI5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
	nickpiggin@yahoo.com.au, nathanl@austin.ibm.com, jbarnes@sgi.com
References: <20040829111855.GB26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829111855.GB26072@krispykreme>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 09:18:55PM +1000, Anton Blanchard wrote:
> We are seeing errors in the sched domains debug code when SMT + NUMA is
> enabled. Nathan pointed out that the recent change to limit the number
> of nodes in a scheduling group may be causing this - in particular
> sched_domain_node_span.
> It looks like ia64 are the only ones implementing a reasonable
> node_distance, the others just do:
> #define node_distance(from,to) (from != to)
> On these architectures I wonder if we should disable the
> sched_domain_node_span code since we will just get a random grouping of
> cpus.

For fsck's sake... macro writers need to exercise more discipline.


Index: wait-2.6.9-rc1-mm1/include/linux/topology.h
===================================================================
--- wait-2.6.9-rc1-mm1.orig/include/linux/topology.h	2004-08-24 00:03:18.000000000 -0700
+++ wait-2.6.9-rc1-mm1/include/linux/topology.h	2004-08-29 09:44:35.932705488 -0700
@@ -55,7 +55,7 @@
 	for (node = 0; node < numnodes; node = __next_node_with_cpus(node))
 
 #ifndef node_distance
-#define node_distance(from,to)	(from != to)
+#define node_distance(from,to)	((from) != (to))
 #endif
 #ifndef PENALTY_FOR_NODE_WITH_CPUS
 #define PENALTY_FOR_NODE_WITH_CPUS	(1)
Index: wait-2.6.9-rc1-mm1/include/asm-ia64/numa.h
===================================================================
--- wait-2.6.9-rc1-mm1.orig/include/asm-ia64/numa.h	2004-08-24 00:02:26.000000000 -0700
+++ wait-2.6.9-rc1-mm1/include/asm-ia64/numa.h	2004-08-29 09:45:07.223948496 -0700
@@ -59,7 +59,7 @@
  */
 
 extern u8 numa_slit[MAX_NUMNODES * MAX_NUMNODES];
-#define node_distance(from,to) (numa_slit[from * numnodes + to])
+#define node_distance(from,to) (numa_slit[(from) * numnodes + (to)])
 
 extern int paddr_to_nid(unsigned long paddr);
 
Index: wait-2.6.9-rc1-mm1/include/asm-i386/topology.h
===================================================================
--- wait-2.6.9-rc1-mm1.orig/include/asm-i386/topology.h	2004-08-24 00:02:20.000000000 -0700
+++ wait-2.6.9-rc1-mm1/include/asm-i386/topology.h	2004-08-29 09:45:24.973250192 -0700
@@ -67,7 +67,7 @@
 }
 
 /* Node-to-Node distance */
-#define node_distance(from, to) (from != to)
+#define node_distance(from, to) ((from) != (to))
 
 /* Cross-node load balancing interval. */
 #define NODE_BALANCE_RATE 100
