Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUDUWGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUDUWGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 18:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUDUWGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 18:06:33 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:1767 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262328AbUDUWGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 18:06:30 -0400
Message-ID: <408645AA.5050400@us.ibm.com>
Date: Wed, 21 Apr 2004 02:58:02 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Andi Kleen <ak@suse.de>, mbligh@aracnet.com, akpm@osdl.org
Subject: [PATCH] include/linux/gfp.h cleanup for NUMA API
Content-Type: multipart/mixed;
 boundary="------------010302050300070009080809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010302050300070009080809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andi,
	Here's a few cleanups to include/linux/gfp.h

1) Move the extern of alloc_pages_current() into #ifdef CONFIG_NUMA. 
The only references to the function are in NUMA code in mempolicy.c

2) Remove the definitions of __alloc_page_vma().  They aren't used.

3) Move forward declaration of struct vm_area_struct to top of file.

-Matt

--------------010302050300070009080809
Content-Type: text/plain;
 name="cleanup-gfp_h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cleanup-gfp_h.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.6-rc1-mm1/include/linux/gfp.h linux-2.6.6-cleanup-gfp_h/include/linux/gfp.h
--- linux-2.6.6-rc1-mm1/include/linux/gfp.h	2004-04-20 14:29:11.000000000 -0700
+++ linux-2.6.6-cleanup-gfp_h/include/linux/gfp.h	2004-04-21 14:47:11.000000000 -0700
@@ -6,6 +6,8 @@
 #include <linux/linkage.h>
 #include <linux/config.h>
 
+struct vm_area_struct;
+
 /*
  * GFP bitmasks..
  */
@@ -84,10 +86,9 @@ static inline struct page *alloc_pages_n
 		NODE_DATA(nid)->node_zonelists + (gfp_mask & GFP_ZONEMASK));
 }
 
+#ifdef CONFIG_NUMA
 extern struct page *alloc_pages_current(unsigned gfp_mask, unsigned order);
-struct vm_area_struct;
 
-#ifdef CONFIG_NUMA
 static inline struct page *
 alloc_pages(unsigned int gfp_mask, unsigned int order)
 {
@@ -96,17 +97,15 @@ alloc_pages(unsigned int gfp_mask, unsig
 
 	return alloc_pages_current(gfp_mask, order);
 }
-extern struct page *__alloc_page_vma(unsigned gfp_mask,
-			struct vm_area_struct *vma, unsigned long off);
 
 extern struct page *alloc_page_vma(unsigned gfp_mask,
 			struct vm_area_struct *vma, unsigned long addr);
-#else
+#else /* !CONFIG_NUMA */
 #define alloc_pages(gfp_mask, order) \
 		alloc_pages_node(numa_node_id(), gfp_mask, order)
 #define alloc_page_vma(gfp_mask, vma, addr) alloc_pages(gfp_mask, 0)
-#define __alloc_page_vma(gfp_mask, vma, addr) alloc_pages(gfp_mask, 0)
-#endif
+#endif /* CONFIG_NUMA */
+
 #define alloc_page(gfp_mask) alloc_pages(gfp_mask, 0)
 
 extern unsigned long FASTCALL(__get_free_pages(unsigned int gfp_mask, unsigned int order));

--------------010302050300070009080809--

