Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVKDXU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVKDXU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVKDXU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:20:28 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:11982 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750846AbVKDXU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:20:27 -0500
Date: Fri, 4 Nov 2005 15:20:24 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: [PATCH 3/4] Memory Add Fixes for ppc64
Message-ID: <20051104232024.GD25545@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104231552.GA25545@w-mikek2.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a temporary kludge that supports adding all new memory to
node 0.  I will provide a more complete solution similar to that
used for dynamically added CPUs in a few days.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.14-git7/include/asm-ppc64/mmzone.h linux-2.6.14-git7.work/include/asm-ppc64/mmzone.h
--- linux-2.6.14-git7/include/asm-ppc64/mmzone.h	2005-11-04 21:21:09.000000000 +0000
+++ linux-2.6.14-git7.work/include/asm-ppc64/mmzone.h	2005-11-04 22:10:44.000000000 +0000
@@ -33,6 +33,9 @@ extern int numa_cpu_lookup_table[];
 extern char *numa_memory_lookup_table;
 extern cpumask_t numa_cpumask_lookup_table[];
 extern int nr_cpus_in_node[];
+#ifdef CONFIG_MEMORY_HOTPLUG
+extern unsigned long max_pfn;
+#endif
 
 /* 16MB regions */
 #define MEMORY_INCREMENT_SHIFT 24
@@ -45,6 +48,11 @@ static inline int pa_to_nid(unsigned lon
 {
 	int nid;
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+	/* kludge hot added sections default to node 0 */
+	if (pa >= (max_pfn << PAGE_SHIFT))
+		return 0;
+#endif
 	nid = numa_memory_lookup_table[pa >> MEMORY_INCREMENT_SHIFT];
 
 #ifdef DEBUG_NUMA
