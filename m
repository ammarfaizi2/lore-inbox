Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264896AbSJ3V7X>; Wed, 30 Oct 2002 16:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264902AbSJ3V7W>; Wed, 30 Oct 2002 16:59:22 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40668 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264896AbSJ3V7V>; Wed, 30 Oct 2002 16:59:21 -0500
Message-ID: <3DC056C2.4070609@us.ibm.com>
Date: Wed, 30 Oct 2002 14:01:38 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] use asm-generic/topology.h
Content-Type: multipart/mixed;
 boundary="------------070909060602030603080904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070909060602030603080904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,

use_generic_topology.patch

This patch changes ppc64 & alpha to use the generic topology.h for the 
non-NUMA case rather than redefining the same macros.  It is much easier 
to maintain one set of generic non-NUMA macros than several.

[mcd@arrakis patches]$ diffstat use_generic_topo-2.5.44.patch
  asm-alpha/topology.h |   19 +++++++------------
  asm-ppc64/topology.h |    8 ++------
  2 files changed, 9 insertions(+), 18 deletions(-)

Cheers!

-Matt

--------------070909060602030603080904
Content-Type: text/plain;
 name="use_generic_topo-2.5.44.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="use_generic_topo-2.5.44.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-alpha/topology.h linux-2.5.44-topology_fixup/include/asm-alpha/topology.h
--- linux-2.5.44-vanilla/include/asm-alpha/topology.h	Fri Oct 18 21:01:18 2002
+++ linux-2.5.44-topology_fixup/include/asm-alpha/topology.h	Wed Oct 30 13:51:56 2002
@@ -1,20 +1,15 @@
 #ifndef _ASM_ALPHA_TOPOLOGY_H
 #define _ASM_ALPHA_TOPOLOGY_H
 
-#ifdef CONFIG_NUMA
-#ifdef CONFIG_ALPHA_WILDFIRE
+#if defined(CONFIG_NUMA) && defined(CONFIG_ALPHA_WILDFIRE)
+
 /* With wildfire assume 4 CPUs per node */
 #define __cpu_to_node(cpu)		((cpu) >> 2)
-#endif /* CONFIG_ALPHA_WILDFIRE */
-#endif /* CONFIG_NUMA */
 
-#if !defined(CONFIG_NUMA) || !defined(CONFIG_ALPHA_WILDFIRE)
-#define __cpu_to_node(cpu)		(0)
-#define __memblk_to_node(memblk)	(0)
-#define __parent_node(nid)		(0)
-#define __node_to_first_cpu(node)	(0)
-#define __node_to_cpu_mask(node)	(cpu_online_map)
-#define __node_to_memblk(node)		(0)
-#endif /* !CONFIG_NUMA || !CONFIG_ALPHA_WILDFIRE */
+#else /* !CONFIG_NUMA || !CONFIG_ALPHA_WILDFIRE */
+
+#include <asm-generic/topology.h>
+
+#endif /* CONFIG_NUMA && CONFIG_ALPHA_WILDFIRE */
 
 #endif /* _ASM_ALPHA_TOPOLOGY_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-vanilla/include/asm-ppc64/topology.h linux-2.5.44-topology_fixup/include/asm-ppc64/topology.h
--- linux-2.5.44-vanilla/include/asm-ppc64/topology.h	Fri Oct 18 21:01:52 2002
+++ linux-2.5.44-topology_fixup/include/asm-ppc64/topology.h	Wed Oct 30 13:45:23 2002
@@ -48,12 +48,8 @@
 
 #else /* !CONFIG_NUMA */
 
-#define __cpu_to_node(cpu)		(0)
-#define __memblk_to_node(memblk)	(0)
-#define __parent_node(nid)		(0)
-#define __node_to_first_cpu(node)	(0)
-#define __node_to_cpu_mask(node)	(cpu_online_map)
-#define __node_to_memblk(node)		(0)
+/* If non-NUMA, grab the generic macros */
+#include <asm-generic/topology.h>
 
 #endif /* CONFIG_NUMA */
 

--------------070909060602030603080904--

