Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUCFBoi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 20:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUCFBoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 20:44:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:15818 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261419AbUCFBof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 20:44:35 -0500
Date: Fri, 5 Mar 2004 17:46:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: jes@trained-monkey.org, linux-kernel@vger.kernel.org, jbarnes@sgi.com,
       j-nomura@ce.jp.nec.com
Subject: Re: [patch] 2.6.4-rc1-mm2 page_alloc on NUMA
Message-Id: <20040305174634.763a5df7.akpm@osdl.org>
In-Reply-To: <1078536125.797.64.camel@cog.beaverton.ibm.com>
References: <16454.3720.225353.650939@gargle.gargle.HOWL>
	<1078536125.797.64.camel@cog.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> With 2.6.4-rc1-mm2, I'm still seeing compile errors in page_alloc even
> with this patch. Looks like the numa-aware-zonelist-builder patch isn't
> defining PENALTY_FOR_NODE_WITH_CPUS properly.

Yup.   I'll be fixing it thusly:



- Move the default definition of node_distance() and
  PENALTY_FOR_NODE_WITH_CPUS up a level into linux/topology.h.  This probably
  fixes ia64 CONFIG_NUMA builds.

- Make node_distance() a macro, since we're testing for its presence with
  #ifdef.



---

 include/asm-generic/topology.h |    7 -------
 include/asm-i386/topology.h    |    5 +----
 include/linux/topology.h       |    7 +++++++
 3 files changed, 8 insertions(+), 11 deletions(-)

diff -puN include/asm-generic/topology.h~numa-aware-zonelist-builder-fix-2 include/asm-generic/topology.h
--- 25/include/asm-generic/topology.h~numa-aware-zonelist-builder-fix-2	2004-03-03 23:40:22.000000000 -0800
+++ 25-akpm/include/asm-generic/topology.h	2004-03-03 23:40:42.000000000 -0800
@@ -45,13 +45,6 @@
 #define pcibus_to_cpumask(bus)	(cpu_online_map)
 #endif
 
-#ifndef node_distance
-#define node_distance(from,to)	(from != to)
-#endif
-#ifndef PENALTY_FOR_NODE_WITH_CPUS
-#define PENALTY_FOR_NODE_WITH_CPUS	(1)
-#endif
-
 /* Cross-node load balancing interval. */
 #ifndef NODE_BALANCE_RATE
 #define NODE_BALANCE_RATE 10
diff -puN include/asm-i386/topology.h~numa-aware-zonelist-builder-fix-2 include/asm-i386/topology.h
--- 25/include/asm-i386/topology.h~numa-aware-zonelist-builder-fix-2	2004-03-03 23:40:22.000000000 -0800
+++ 25-akpm/include/asm-i386/topology.h	2004-03-03 23:41:33.000000000 -0800
@@ -67,10 +67,7 @@ static inline cpumask_t pcibus_to_cpumas
 }
 
 /* Node-to-Node distance */
-static inline int node_distance(int from, int to)
-{
-	return (from != to);
-}
+#define node_distance(from, to) (from != to)
 
 /* Cross-node load balancing interval. */
 #define NODE_BALANCE_RATE 100
diff -puN include/linux/topology.h~numa-aware-zonelist-builder-fix-2 include/linux/topology.h
--- 25/include/linux/topology.h~numa-aware-zonelist-builder-fix-2	2004-03-03 23:40:22.000000000 -0800
+++ 25-akpm/include/linux/topology.h	2004-03-03 23:41:45.000000000 -0800
@@ -54,4 +54,11 @@ static inline int __next_node_with_cpus(
 #define for_each_node_with_cpus(node) \
 	for (node = 0; node < numnodes; node = __next_node_with_cpus(node))
 
+#ifndef node_distance
+#define node_distance(from,to)	(from != to)
+#endif
+#ifndef PENALTY_FOR_NODE_WITH_CPUS
+#define PENALTY_FOR_NODE_WITH_CPUS	(1)
+#endif
+
 #endif /* _LINUX_TOPOLOGY_H */

_

