Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265233AbSJWVE0>; Wed, 23 Oct 2002 17:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbSJWVEY>; Wed, 23 Oct 2002 17:04:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:8170 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265233AbSJWVEV>;
	Wed, 23 Oct 2002 17:04:21 -0400
Message-ID: <3DB70F4F.2000203@us.ibm.com>
Date: Wed, 23 Oct 2002 14:06:23 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Patrick Mochel <mochel@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [patch] (5/5) create node_online_map 2.5.44
References: <2699066091.1035310557@[10.10.2.3]> <Pine.LNX.4.44.0210221824430.983-100000@cherise.pdx.osdl.net> <3DB5FCC5.E54808E@digeo.com> <3DB70CDD.8080506@us.ibm.com> <3DB70DC1.204@us.ibm.com> <3DB70E67.9040704@us.ibm.com> <3DB70F01.9050906@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------010803040507040501000907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010803040507040501000907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Create and use node_online_map.

This patch creates a node_online_map, much like cpu_online_map.  It
also creates the standard helper functions, ie: node_online(),
num_online_nodes(), node_set_online(), node_set_offline().

This is used by driverFS topology to keep track of which Nodes
are in the system and online.

Cheers!

-Matt

--------------010803040507040501000907
Content-Type: text/plain;
 name="04-node_online_map.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-node_online_map.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/arch/i386/kernel/numaq.c linux-2.5.44-node_online_map/arch/i386/kernel/numaq.c
--- linux-2.5.44-base/arch/i386/kernel/numaq.c	Fri Oct 18 21:01:17 2002
+++ linux-2.5.44-node_online_map/arch/i386/kernel/numaq.c	Wed Oct 23 12:14:49 2002
@@ -52,6 +52,7 @@
 	numnodes = 0;
 	for(node = 0; node < MAX_NUMNODES; node++) {
 		if(scd->quads_present31_0 & (1 << node)) {
+			node_set_online(node);
 			numnodes++;
 			eq = &scd->eq[node];
 			/* Convert to pages */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/arch/i386/mach-generic/topology.c linux-2.5.44-node_online_map/arch/i386/mach-generic/topology.c
--- linux-2.5.44-base/arch/i386/mach-generic/topology.c	Wed Oct 23 12:13:31 2002
+++ linux-2.5.44-node_online_map/arch/i386/mach-generic/topology.c	Wed Oct 23 12:14:50 2002
@@ -38,13 +38,11 @@
 struct i386_node node_devices[MAX_NUMNODES];
 struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
 
-extern int numnodes;
-
 static int __init topology_init(void)
 {
 	int i;
 
-	for (i = 0; i < numnodes; i++)
+	for (i = 0; i < num_online_nodes(); i++)
 		arch_register_node(i);
 	for (i = 0; i < num_online_cpus(); i++)
 		arch_register_cpu(i);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/include/linux/mmzone.h linux-2.5.44-node_online_map/include/linux/mmzone.h
--- linux-2.5.44-base/include/linux/mmzone.h	Wed Oct 23 12:13:31 2002
+++ linux-2.5.44-node_online_map/include/linux/mmzone.h	Wed Oct 23 12:14:50 2002
@@ -263,10 +263,25 @@
 #endif /* !CONFIG_DISCONTIGMEM */
 
 
+extern DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
 extern DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
 
 #if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_NUMA)
 
+#define node_online(node)	test_bit(node, node_online_map)
+#define node_set_online(node)	set_bit(node, node_online_map)
+#define node_set_offline(node)	clear_bit(node, node_online_map)
+static inline unsigned int num_online_nodes(void)
+{
+	int i, num = 0;
+
+	for(i = 0; i < MAX_NUMNODES; i++){
+		if (node_online(i))
+			num++;
+	}
+	return num;
+}
+
 #define memblk_online(memblk)		test_bit(memblk, memblk_online_map)
 #define memblk_set_online(memblk)	set_bit(memblk, memblk_online_map)
 #define memblk_set_offline(memblk)	clear_bit(memblk, memblk_online_map)
@@ -283,6 +298,14 @@
 
 #else /* !CONFIG_DISCONTIGMEM && !CONFIG_NUMA */
 
+#define node_online(node) \
+	({ BUG_ON((node) != 0); test_bit(node, node_online_map); })
+#define node_set_online(node) \
+	({ BUG_ON((node) != 0); set_bit(node, node_online_map); })
+#define node_set_offline(node) \
+	({ BUG_ON((node) != 0); clear_bit(node, node_online_map); })
+#define num_online_nodes()	1
+
 #define memblk_online(memblk) \
 	({ BUG_ON((memblk) != 0); test_bit(memblk, memblk_online_map); })
 #define memblk_set_online(memblk) \
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/mm/page_alloc.c linux-2.5.44-node_online_map/mm/page_alloc.c
--- linux-2.5.44-base/mm/page_alloc.c	Wed Oct 23 12:13:31 2002
+++ linux-2.5.44-node_online_map/mm/page_alloc.c	Wed Oct 23 12:14:50 2002
@@ -28,6 +28,7 @@
 
 #include <asm/topology.h>
 
+DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
 DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
 struct pglist_data *pgdat_list;
 unsigned long totalram_pages;

--------------010803040507040501000907--

