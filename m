Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbTEFBVU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 21:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTEFBVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 21:21:20 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:24264 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262254AbTEFBVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 21:21:16 -0400
Message-ID: <3EB70FC2.1010903@us.ibm.com>
Date: Mon, 05 May 2003 18:28:34 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>, Dave Hansen <haveblue@us.ibm.com>,
       Bill Hartner <bhartner@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: [patch] Re: Bug 619 - sched_best_cpu does not pick best cpu (2/2)
References: <3EB70EEC.9040004@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------070707040200090902030808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070707040200090902030808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch is in regard to bugme.osdl.org bug 619, link here:

http://bugme.osdl.org/show_bug.cgi?id=619

This is the second of two patches to fix this bug.  This patch fills in 
include/linux/topology.h (created in the last patch) with a couple 
#defines.  The patch also creates a generic_hweight64() in 
include/linux/bitops.h, which we've been lacking for a while.  It then 
uses these new macros in sched.c to ensure that if a node has no CPUs, 
it is not used in scheduling decisions.

[mcd@arrakis src]$ diffstat ~/patches/node_online.patch
  include/linux/bitops.h   |   27 +++++++++++++++++++++++++++
  include/linux/topology.h |    7 +++++++
  kernel/sched.c           |    2 +-
  3 files changed, 35 insertions(+), 1 deletion(-)

Cheers!

-Matt

--------------070707040200090902030808
Content-Type: text/plain;
 name="node_online.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="node_online.patch"

diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-add_linux_topo/include/linux/bitops.h linux-2.5.69-node_online_fix/include/linux/bitops.h
--- linux-2.5.69-add_linux_topo/include/linux/bitops.h	Sun May  4 16:53:42 2003
+++ linux-2.5.69-node_online_fix/include/linux/bitops.h	Mon May  5 18:00:00 2003
@@ -107,6 +107,33 @@
         return (res & 0x0F) + ((res >> 4) & 0x0F);
 }
 
+#if (BITS_PER_LONG == 64)
+
+static inline unsigned int generic_hweight64(unsigned int w)
+{
+        unsigned int res = (w & 0x5555555555555555) + ((w >> 1) & 0x5555555555555555);
+        res = (res & 0x3333333333333333) + ((res >> 2) & 0x3333333333333333);
+        res = (res & 0x0F0F0F0F0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F0F0F0F0F);
+        res = (res & 0x00FF00FF00FF00FF) + ((res >> 8) & 0x00FF00FF00FF00FF);
+        res = (res & 0x0000FFFF0000FFFF) + ((res >> 16) & 0x0000FFFF0000FFFF);
+        return (res & 0x00000000FFFFFFFF) + ((res >> 32) & 0x00000000FFFFFFFF);
+}
+
+#define hweight_long(w)	generic_hweight64(w)
+
+#endif /* BITS_PER_LONG == 64 */
+
+#if (BITS_PER_LONG == 32)
+
+static inline unsigned int generic_hweight64(unsigned int *w)
+{
+	return generic_hweight32(w[0]) + generic_hweight32(w[1]);
+}
+
+#define hweight_long(w)	generic_hweight32(w)
+
+#endif /* BITS_PER_LONG == 32 */
+
 #include <asm/bitops.h>
 
 
diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-add_linux_topo/include/linux/topology.h linux-2.5.69-node_online_fix/include/linux/topology.h
--- linux-2.5.69-add_linux_topo/include/linux/topology.h	Mon May  5 17:43:35 2003
+++ linux-2.5.69-node_online_fix/include/linux/topology.h	Mon May  5 18:10:29 2003
@@ -27,6 +27,13 @@
 #ifndef _LINUX_TOPOLOGY_H
 #define _LINUX_TOPOLOGY_H
 
+#include <linux/bitops.h>
 #include <asm/topology.h>
 
+#define nr_cpus_node(node)	(hweight_long(node_to_cpumask(node)))
+
+#define for_each_node_with_cpus(node) \
+	for (node = 0; node < numnodes; node++) \
+		if (nr_cpus_node(node)
+
 #endif /* _LINUX_TOPOLOGY_H */
diff -Nur --exclude-from=/home/mcd/.dontdiff linux-2.5.69-add_linux_topo/kernel/sched.c linux-2.5.69-node_online_fix/kernel/sched.c
--- linux-2.5.69-add_linux_topo/kernel/sched.c	Sun May  4 16:53:37 2003
+++ linux-2.5.69-node_online_fix/kernel/sched.c	Mon May  5 18:10:58 2003
@@ -802,7 +802,7 @@
 		return best_cpu;
 
 	minload = 10000000;
-	for (i = 0; i < numnodes; i++) {
+	for_each_node_with_cpus(i) {
 		load = atomic_read(&node_nr_running[i]);
 		if (load < minload) {
 			minload = load;

--------------070707040200090902030808--

