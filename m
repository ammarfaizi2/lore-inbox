Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUHDSu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUHDSu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 14:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266781AbUHDSu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 14:50:27 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23521 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267375AbUHDSuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 14:50:03 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] don't pass mem_map into init functions
Date: Wed, 4 Aug 2004 11:48:03 -0700
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1091581282.27397.6676.camel@nighthawk>
In-Reply-To: <1091581282.27397.6676.camel@nighthawk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_j9SEBzvyoeri07E"
Message-Id: <200408041148.03729.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_j9SEBzvyoeri07E
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, August 3, 2004 6:01 pm, Dave Hansen wrote:
> Jesse, could you follow up to this mail with a copy of your patch?
>
> Attached patch is against 2.6.8-rc2-mm2.

Fix up ia64 specific memory map init function in light of Dave's memmap_init 
cleanups.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Jesse

--Boundary-00=_j9SEBzvyoeri07E
Content-Type: text/plain;
  charset="iso-8859-1";
  name="memmap-cleanup-fix-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="memmap-cleanup-fix-2.patch"

diff -Napur -X /home/jbarnes/dontdiff linux-2.6.8-rc2-mm2.orig/arch/ia64/mm/init.c linux-2.6.8-rc2-mm2/arch/ia64/mm/init.c
--- linux-2.6.8-rc2-mm2.orig/arch/ia64/mm/init.c	2004-08-04 11:45:06.000000000 -0700
+++ linux-2.6.8-rc2-mm2/arch/ia64/mm/init.c	2004-08-04 11:47:29.000000000 -0700
@@ -433,14 +433,16 @@ virtual_memmap_init (u64 start, u64 end,
 }
 
 void
-memmap_init (struct page *start, unsigned long size, int nid,
-	     unsigned long zone, unsigned long start_pfn)
+memmap_init (unsigned long size, int nid, unsigned long zone,
+	     unsigned long start_pfn)
 {
 	if (!vmem_map)
 		memmap_init_zone(start, size, nid, zone, start_pfn);
 	else {
+		struct page *start;
 		struct memmap_init_callback_data args;
 
+		start = pfn_to_page(start_pfn);
 		args.start = start;
 		args.end = start + size;
 		args.nid = nid;
diff -Napur -X /home/jbarnes/dontdiff linux-2.6.8-rc2-mm2.orig/include/asm-ia64/pgtable.h linux-2.6.8-rc2-mm2/include/asm-ia64/pgtable.h
--- linux-2.6.8-rc2-mm2.orig/include/asm-ia64/pgtable.h	2004-08-04 11:45:08.000000000 -0700
+++ linux-2.6.8-rc2-mm2/include/asm-ia64/pgtable.h	2004-08-04 11:45:40.000000000 -0700
@@ -520,7 +520,7 @@ do {											\
 #  ifdef CONFIG_VIRTUAL_MEM_MAP
   /* arch mem_map init routine is needed due to holes in a virtual mem_map */
 #   define __HAVE_ARCH_MEMMAP_INIT
-    extern void memmap_init (struct page *start, unsigned long size, int nid, unsigned long zone,
+    extern void memmap_init (unsigned long size, int nid, unsigned long zone,
 			     unsigned long start_pfn);
 #  endif /* CONFIG_VIRTUAL_MEM_MAP */
 # endif /* !__ASSEMBLY__ */

--Boundary-00=_j9SEBzvyoeri07E--
