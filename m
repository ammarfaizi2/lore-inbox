Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269868AbSISD4a>; Wed, 18 Sep 2002 23:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269897AbSISD4a>; Wed, 18 Sep 2002 23:56:30 -0400
Received: from franka.aracnet.com ([216.99.193.44]:35294 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269868AbSISD43>; Wed, 18 Sep 2002 23:56:29 -0400
Date: Wed, 18 Sep 2002 20:59:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-mm mailing list <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, colpatch@us.ibm.com
Subject: Three little fixes for 2.5.36-mm1 (discontigmem)
Message-ID: <379836976.1032382769@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three little fixes for 2.5.36-mm1.

1. numa_node_id is defined in both asm/mmzone.h and linux/mmzone.h
	I remove the former, seems like the right thing to do now
	that we have a generic topology patch
2. The topo patch for i386 uses a (potentially) uninitialised
	variable that gcc whines about (correctly).
3. kswapd carefully typecasts it's argument to the correct pointer
	type ... then forgets to use it.

M.

diff -urN -X /home/mbligh/.diff.exclude virgin/include/asm-i386/mmzone.h numafixes/include/asm-i386/mmzone.h
--- virgin/include/asm-i386/mmzone.h	Wed Sep 18 20:41:12 2002
+++ numafixes/include/asm-i386/mmzone.h	Wed Sep 18 20:43:23 2002
@@ -19,10 +19,6 @@
 #endif /* CONFIG_NUMA */
 #endif /* CONFIG_X86_NUMAQ */
 
-#ifdef CONFIG_NUMA
-#define numa_node_id() _cpu_to_node(smp_processor_id())
-#endif /* CONFIG_NUMA */
-
 extern struct pglist_data *node_data[];
 
 /*
diff -urN -X /home/mbligh/.diff.exclude virgin/include/asm-i386/topology.h numafixes/include/asm-i386/topology.h
--- virgin/include/asm-i386/topology.h	Wed Sep 18 20:41:12 2002
+++ numafixes/include/asm-i386/topology.h	Wed Sep 18 20:50:40 2002
@@ -65,7 +65,7 @@
 static inline unsigned long
__node_to_cpu_mask(int node)
 {
 	int i, cpu, logical_apicid = node << 4;
-	unsigned long mask;
+	unsigned long mask = 0UL;
 
 	for(i = 1; i < 16; i <<= 1)
 		/* check to see if the cpu is in the system */
diff -urN -X /home/mbligh/.diff.exclude virgin/include/asm-ppc64/mmzone.h numafixes/include/asm-ppc64/mmzone.h
--- virgin/include/asm-ppc64/mmzone.h	Tue Sep 17 17:59:18 2002
+++ numafixes/include/asm-ppc64/mmzone.h	Wed Sep 18 20:43:47 2002
@@ -68,7 +68,6 @@
         return node;
 }
 
-#define numa_node_id()	__cpu_to_node(smp_processor_id())
 #endif /* CONFIG_NUMA */
 
 /*
diff -urN -X /home/mbligh/.diff.exclude virgin/mm/vmscan.c numafixes/mm/vmscan.c
--- virgin/mm/vmscan.c	Wed Sep 18 20:41:12 2002
+++ numafixes/mm/vmscan.c	Wed Sep 18 20:48:47
2002
@@ -749,7 +749,7 @@
 	DEFINE_WAIT(wait);
 
 	daemonize();
-	set_cpus_allowed(tsk, __node_to_cpu_mask(p->node_id));
+	set_cpus_allowed(tsk, __node_to_cpu_mask(pgdat->node_id));
 	sprintf(tsk->comm, "kswapd%d", pgdat->node_id);
 	sigfillset(&tsk->blocked);
 	

