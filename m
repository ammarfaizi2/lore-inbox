Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbTIPAhd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 20:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbTIPAhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 20:37:33 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:18924 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261728AbTIPAhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 20:37:22 -0400
Message-ID: <3F665A80.2020808@us.ibm.com>
Date: Mon, 15 Sep 2003 17:34:08 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, wli@holomorphy.com
Subject: [PATCH] Clean up MAX_NR_NODES/NUMNODES/etc. [1/5]
References: <20030910153601.36219ed8.akpm@osdl.org> <41000000.1063237600@flay> <20030911000303.GA20329@sgi.com> <3F6659DF.1090508@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020509090809080405050402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020509090809080405050402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Matthew Dobson wrote:
> Ok, I made an attempt to clean up this mess quite a while ago (2.5.47), 
> but that patch is utterly useless now.  At Martin's urging I've created 
> a new series of patches to resolve this.
> 
> 01 - Make sure MAX_NUMNODES is defined in one and only one place. Remove 
> superfluous definitions.  Instead of defining MAX_NUMNODES in 
> asm/numnodes.h, we define NODES_SHIFT there.  Then in linux/mmzone.h we 
> turn that NODES_SHIFT value into MAX_NUMNODES.
> 
> 02 - Remove MAX_NR_NODES.  This value is only used in a couple of 
> places, and it's incorrectly used in all those places as far as I can 
> tell.  Replace with MAX_NUMNODES.  Create MAX_NODES_SHIFT and use this 
> value to check NODES_SHIFT is appropriate.  A possible future patch 
> should make MAX_NODES_SHIFT vary based on 32 vs. 64 bit archs.
> 
> 03 - Fix up the sh arch.  sh defined NR_NODES, change sh to use standard 
> MAX_NUMNODES instead.
> 
> 04 - Fix up the arm arch.  This needs to be reviewed.  Relatively 
> straightforward replacement of NR_NODES with standard MAX_NUMNODES.
> 
> 05 - Fix up the ia64 arch.  This *definitely* needs to be reviewed. This 
> code made my head hurt.  I think I may have gotten it right. Totally 
> untested.

Cheers!

-Matt

--------------020509090809080405050402
Content-Type: text/plain;
 name="01-max_numnodes2nodes_shift.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-max_numnodes2nodes_shift.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/asm-alpha/numnodes.h linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-alpha/numnodes.h
--- linux-2.6.0-test5/include/asm-alpha/numnodes.h	Mon Sep  8 12:49:53 2003
+++ linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-alpha/numnodes.h	Mon Sep 15 13:28:10 2003
@@ -1,6 +1,7 @@
 #ifndef _ASM_MAX_NUMNODES_H
 #define _ASM_MAX_NUMNODES_H
 
-#define MAX_NUMNODES		128 /* Marvel */
+/* Max 128 Nodes - Marvel */
+#define NODES_SHIFT	7
 
 #endif /* _ASM_MAX_NUMNODES_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/asm-i386/numaq.h linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-i386/numaq.h
--- linux-2.6.0-test5/include/asm-i386/numaq.h	Mon Sep  8 12:50:06 2003
+++ linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-i386/numaq.h	Fri Sep 12 16:58:19 2003
@@ -28,7 +28,6 @@
 
 #ifdef CONFIG_X86_NUMAQ
 
-#define MAX_NUMNODES		16
 extern void get_memcfg_numaq(void);
 #define get_memcfg_numa() get_memcfg_numaq()
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/asm-i386/numnodes.h linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-i386/numnodes.h
--- linux-2.6.0-test5/include/asm-i386/numnodes.h	Mon Sep  8 12:49:54 2003
+++ linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-i386/numnodes.h	Fri Sep 12 16:58:19 2003
@@ -4,11 +4,15 @@
 #include <linux/config.h>
 
 #ifdef CONFIG_X86_NUMAQ
-#include <asm/numaq.h>
+
+/* Max 16 Nodes */
+#define NODES_SHIFT	4
+
 #elif CONFIG_NUMA
-#include <asm/srat.h>
-#else
-#define MAX_NUMNODES	1
+
+/* Max 8 Nodes */
+#define NODES_SHIFT	3
+
 #endif /* CONFIG_X86_NUMAQ */
 
 #endif /* _ASM_MAX_NUMNODES_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/asm-i386/srat.h linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-i386/srat.h
--- linux-2.6.0-test5/include/asm-i386/srat.h	Mon Sep  8 12:49:58 2003
+++ linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-i386/srat.h	Fri Sep 12 16:37:51 2003
@@ -27,7 +27,6 @@
 #ifndef _ASM_SRAT_H_
 #define _ASM_SRAT_H_
 
-#define MAX_NUMNODES		8
 extern void get_memcfg_from_srat(void);
 extern unsigned long *get_zholes_size(int);
 #define get_memcfg_numa() get_memcfg_from_srat()
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/asm-ppc64/numnodes.h linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-ppc64/numnodes.h
--- linux-2.6.0-test5/include/asm-ppc64/numnodes.h	Mon Sep  8 12:50:22 2003
+++ linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-ppc64/numnodes.h	Fri Sep 12 16:58:19 2003
@@ -1,6 +1,7 @@
 #ifndef _ASM_MAX_NUMNODES_H
 #define _ASM_MAX_NUMNODES_H
 
-#define MAX_NUMNODES 16
+/* Max 16 Nodes */
+#define NODES_SHIFT	4
 
 #endif /* _ASM_MAX_NUMNODES_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/asm-x86_64/mmzone.h linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-x86_64/mmzone.h
--- linux-2.6.0-test5/include/asm-x86_64/mmzone.h	Mon Sep  8 12:50:22 2003
+++ linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-x86_64/mmzone.h	Fri Sep 12 16:37:51 2003
@@ -10,7 +10,6 @@
 
 #define VIRTUAL_BUG_ON(x) 
 
-#include <asm/numnodes.h>
 #include <asm/smp.h>
 
 #define MAXNODE 8 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/asm-x86_64/numnodes.h linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-x86_64/numnodes.h
--- linux-2.6.0-test5/include/asm-x86_64/numnodes.h	Mon Sep  8 12:50:03 2003
+++ linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-x86_64/numnodes.h	Fri Sep 12 16:37:51 2003
@@ -3,10 +3,7 @@
 
 #include <linux/config.h>
 
-#ifdef CONFIG_DISCONTIGMEM
-#define MAX_NUMNODES 8	/* APIC limit currently */
-#else
-#define MAX_NUMNODES 1
-#endif
+/* Max 8 Nodes - APIC limit currently */
+#define NODES_SHIFT	3
 
 #endif
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/linux/mmzone.h linux-2.6.0-test5-max_numnodes2nodes_shift/include/linux/mmzone.h
--- linux-2.6.0-test5/include/linux/mmzone.h	Mon Sep  8 12:50:07 2003
+++ linux-2.6.0-test5-max_numnodes2nodes_shift/include/linux/mmzone.h	Mon Sep 15 13:29:53 2003
@@ -14,9 +14,10 @@
 #ifdef CONFIG_DISCONTIGMEM
 #include <asm/numnodes.h>
 #endif
-#ifndef MAX_NUMNODES
-#define MAX_NUMNODES 1
+#ifndef NODES_SHIFT
+#define NODES_SHIFT	0
 #endif
+#define MAX_NUMNODES	(1 << NODES_SHIFT)
 
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_FORCE_MAX_ZONEORDER
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/mm/slab.c linux-2.6.0-test5-nr_nodes/mm/slab.c
--- linux-2.6.0-test5/mm/slab.c	Mon Sep  8 12:50:21 2003
+++ linux-2.6.0-test5-nr_nodes/mm/slab.c	Fri Sep 12 17:10:01 2003
@@ -249,7 +249,7 @@ struct kmem_cache_s {
 	unsigned int		limit;
 /* 2) touched by every alloc & free from the backend */
 	struct kmem_list3	lists;
-	/* NUMA: kmem_3list_t	*nodelists[NR_NODES] */
+	/* NUMA: kmem_3list_t	*nodelists[MAX_NUMNODES] */
 	unsigned int		objsize;
 	unsigned int	 	flags;	/* constant flags */
 	unsigned int		num;	/* # of objs per slab */

--------------020509090809080405050402--

