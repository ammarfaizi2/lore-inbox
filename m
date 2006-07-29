Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161407AbWG2Cwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161407AbWG2Cwa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161408AbWG2Cwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:52:30 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:54758 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161407AbWG2Cw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:52:27 -0400
Subject: [Patch] 2/5 in support of hot-add memory x86_64 create
	arch_find_node
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: lhms-devel <lhms-devel@lists.sourceforge.net>, Andi Kleen <ak@suse.de>,
       andrew <akpm@osdl.org>, dave hansen <haveblue@us.ibm.com>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>, discuss <discuss@x86-64.org>,
       konrad <darnok@us.ibm.com>
Content-Type: multipart/mixed; boundary="=-o/3ydReDfSHscCeg17bk"
Organization: Linux Technology Center IBM
Date: Fri, 28 Jul 2006 19:52:24 -0700
Message-Id: <1154141545.5874.146.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o/3ydReDfSHscCeg17bk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

  With the advent of the new ACPI hot-plug memory driver and mechanism
is needed to deal with ACPI add memory events that do not contain the
pxm (node) information. I do not believe that the add-event is required
to contain this information so I create a arch_find_node generic layer
used in the generic add_memory function. 

  If add_memory is called with node < 0 arch_find_node is invoked to
fine the correct node to add the memory. This created the generic
construct of arch_find_node. 

   
This was built against 2.6.18-rc2.

Signed-off-by:  Keith Mannthey <kmannth@us.ibm.com>

--=-o/3ydReDfSHscCeg17bk
Content-Disposition: attachment; filename=patch-2.6.18-rc2-arch_find_node_generic
Content-Type: text/x-patch; name=patch-2.6.18-rc2-arch_find_node_generic; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN orig/include/linux/memory_hotplug.h work/include/linux/memory_hotplug.h
--- orig/include/linux/memory_hotplug.h	2006-07-28 13:57:37.000000000 -0400
+++ work/include/linux/memory_hotplug.h	2006-07-26 20:18:35.000000000 -0400
@@ -132,7 +132,11 @@
 }
 #endif /* CONFIG_NUMA */
 #endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
-
+#ifdef CONFIG_ARCH_FIND_NODE
+	extern int arch_find_node(unsigned long, unsigned long);
+#else
+	static inline int arch_find_node(unsigned long a,  unsigned long b) {return 0;}
+#endif
 #else /* ! CONFIG_MEMORY_HOTPLUG */
 /*
  * Stub functions for when hotplug is off
diff -urN orig/mm/memory_hotplug.c work/mm/memory_hotplug.c
--- orig/mm/memory_hotplug.c	2006-07-28 13:57:38.000000000 -0400
+++ work/mm/memory_hotplug.c	2006-07-26 20:18:35.000000000 -0400
@@ -233,12 +233,17 @@
 
 
 
-int add_memory(int nid, u64 start, u64 size)
+int add_memory(int node, u64 start, u64 size)
 {
 	pg_data_t *pgdat = NULL;
 	int new_pgdat = 0;
-	int ret;
+	int ret,nid;
 
+	if (node < 0) 
+		nid = arch_find_node(start,size);
+	else
+		nid = node;
+	
 	if (!node_online(nid)) {
 		pgdat = hotadd_new_pgdat(nid, start);
 		if (!pgdat)

--=-o/3ydReDfSHscCeg17bk--

