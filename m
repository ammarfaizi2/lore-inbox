Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTKESTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 13:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbTKESTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 13:19:54 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:172 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S263053AbTKESTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 13:19:51 -0500
Date: Wed, 5 Nov 2003 12:19:11 -0600
From: Jack Steiner <steiner@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, davidm@hpl.hp.com, jbarnes@sgi.com
Subject: [PATCH] - Allow architectures to increase size of MAX_NR_MEMBLKS
Message-ID: <20031105181911.GA22082@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a problem that occurs on system with >64 nodes. 

Previously, MAX_NR_MEMBLKS was defined as BITS_PER_LONG. This
patch allows an architecture to override this definition by
defining a value in the arch-specific asm-xxx/mmzone.h file.





# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1401  -> 1.1402 
#	include/linux/mmzone.h	1.45    -> 1.46   
#	include/asm-ia64/mmzone.h	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/05	steiner@attica.americas.sgi.com	1.1402
# Allow architectures to supply their own value for MAX_NR_MEMBLKS.
# The previous value (64) is not large enough for some systems.
# --------------------------------------------
#



diff -Nru a/include/asm-ia64/mmzone.h b/include/asm-ia64/mmzone.h
--- a/include/asm-ia64/mmzone.h	Wed Nov  5 12:07:34 2003
+++ b/include/asm-ia64/mmzone.h	Wed Nov  5 12:07:34 2003
@@ -27,6 +27,8 @@
 # define NR_MEMBLKS		(NR_NODES)
 #endif
 
+#define MAX_NR_MEMBLKS		NR_MEMBLKS
+
 extern unsigned long max_low_pfn;
 
 #define pfn_valid(pfn)		(((pfn) < max_low_pfn) && ia64_pfn_valid(pfn))
diff -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Wed Nov  5 12:07:34 2003
+++ b/include/linux/mmzone.h	Wed Nov  5 12:07:34 2003
@@ -287,12 +287,6 @@
 extern void setup_per_zone_pages_min(void);
 
 
-#ifdef CONFIG_NUMA
-#define MAX_NR_MEMBLKS	BITS_PER_LONG /* Max number of Memory Blocks */
-#else /* !CONFIG_NUMA */
-#define MAX_NR_MEMBLKS	1
-#endif /* CONFIG_NUMA */
-
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
 #define numa_node_id()		(cpu_to_node(smp_processor_id()))
@@ -322,6 +316,14 @@
 #endif
 
 #endif /* !CONFIG_DISCONTIGMEM */
+
+#ifdef CONFIG_NUMA
+#ifndef MAX_NR_MEMBLKS
+#define MAX_NR_MEMBLKS	BITS_PER_LONG /* Max number of Memory Blocks */
+#endif
+#else /* !CONFIG_NUMA */
+#define MAX_NR_MEMBLKS	1
+#endif /* CONFIG_NUMA */
 
 #if NODES_SHIFT > MAX_NODES_SHIFT
 #error NODES_SHIFT > MAX_NODES_SHIFT




-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


