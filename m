Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbTIPAjf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 20:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTIPAjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 20:39:35 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:4351 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261750AbTIPAjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 20:39:22 -0400
Message-ID: <3F665AF9.9050505@us.ibm.com>
Date: Mon, 15 Sep 2003 17:36:09 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, wli@holomorphy.com
Subject: [PATCH] Clean up MAX_NR_NODES/NUMNODES/etc. [3/5]
References: <20030910153601.36219ed8.akpm@osdl.org> <41000000.1063237600@flay> <20030911000303.GA20329@sgi.com> <3F6659DF.1090508@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020601020609060306020802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020601020609060306020802
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

--------------020601020609060306020802
Content-Type: text/plain;
 name="03-fix-sh.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-fix-sh.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/asm-sh/numnodes.h linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-sh/numnodes.h
--- linux-2.6.0-test5/include/asm-sh/numnodes.h	Wed Dec 31 16:00:00 1969
+++ linux-2.6.0-test5-max_numnodes2nodes_shift/include/asm-sh/numnodes.h	Fri Sep 12 17:26:31 2003
@@ -0,0 +1,7 @@
+#ifndef _ASM_MAX_NUMNODES_H
+#define _ASM_MAX_NUMNODES_H
+
+/* Max 2 Nodes */
+#define NODES_SHIFT	1
+
+#endif /* _ASM_MAX_NUMNODES_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/arch/sh/mm/init.c linux-2.6.0-test5-nr_nodes/arch/sh/mm/init.c
--- linux-2.6.0-test5/arch/sh/mm/init.c	Mon Sep  8 12:50:21 2003
+++ linux-2.6.0-test5-nr_nodes/arch/sh/mm/init.c	Fri Sep 12 17:28:43 2003
@@ -51,8 +51,8 @@ unsigned long mmu_context_cache = NO_CON
 #endif
 
 #ifdef CONFIG_DISCONTIGMEM
-pg_data_t discontig_page_data[NR_NODES];
-bootmem_data_t discontig_node_bdata[NR_NODES];
+pg_data_t discontig_page_data[MAX_NUMNODES];
+bootmem_data_t discontig_node_bdata[MAX_NUMNODES];
 #endif
 
 void show_mem(void)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-test5/include/asm-sh/mmzone.h linux-2.6.0-test5-nr_nodes/include/asm-sh/mmzone.h
--- linux-2.6.0-test5/include/asm-sh/mmzone.h	Mon Sep  8 12:50:27 2003
+++ linux-2.6.0-test5-nr_nodes/include/asm-sh/mmzone.h	Fri Sep 12 17:28:08 2003
@@ -10,14 +10,14 @@
 
 #include <linux/config.h>
 
+#ifdef CONFIG_DISCONTIGMEM
+
 /* Currently, just for HP690 */
 #define PHYSADDR_TO_NID(phys)	((((phys) - __MEMORY_START) >= 0x01000000)?1:0)
-#define NR_NODES 2
 
-extern pg_data_t discontig_page_data[NR_NODES];
-extern bootmem_data_t discontig_node_bdata[NR_NODES];
+extern pg_data_t discontig_page_data[MAX_NUMNODES];
+extern bootmem_data_t discontig_node_bdata[MAX_NUMNODES];
 
-#ifdef CONFIG_DISCONTIGMEM
 /*
  * Following are macros that each numa implmentation must define.
  */
@@ -46,7 +46,7 @@ static inline int is_valid_page(struct p
 {
 	unsigned int i;
 
-	for (i = 0; i < NR_NODES; i++) {
+	for (i = 0; i < MAX_NUMNODES; i++) {
 		if (page >= NODE_MEM_MAP(i) &&
 		    page < NODE_MEM_MAP(i) + NODE_DATA(i)->node_size)
 			return 1;

--------------020601020609060306020802--

