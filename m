Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269161AbUIHVqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269161AbUIHVqs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 17:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269169AbUIHVqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 17:46:48 -0400
Received: from fmr03.intel.com ([143.183.121.5]:6339 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S269161AbUIHVqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 17:46:45 -0400
Date: Wed, 8 Sep 2004 14:45:52 -0700
From: tony.luck@intel.com
Message-Id: <200409082145.i88LjqR05556@unix-os.sc.intel.com>
Subject: RE: [PATCH] SN2 build fix CONFIG_VIRTUAL_MEM_MAP and CONFIG_DISCONTIGMEM
Thread-Topic: [PATCH] SN2 build fix CONFIG_VIRTUAL_MEM_MAP and CONFIG_DISCONTIGMEM
Thread-Index: AcSVXJ2V2rOB091wQv2KBMoL91BIGgAZ9Gug
To: "Jesse Barnes" <jbarnes@engr.sgi.com>, "Paul Jackson" <pj@sgi.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>, <ianw@gelato.unsw.edu.au>,
       "William Irwin" <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Thanks Paul, this looks a little simpler than the patch I 
>>posted (I'd rather just make CONFIG_DISCONTIGMEM and
>>CONFIG_VIRTUAL_MEMMAP mandatory on ia64, but that's for
>>another patch).  Linus, since this breakage is in your
>>tree now, can you please apply this assuming Tony has
>>no complaints so that people can build on ia64 again?
>
>I have no complaints.  I see that Linus has already
>applied Paul's patch to his BK tree.

I want to change my vote :-)  The problem isn't a spurious extra
"#else" (which Paul's patch removed) ... it is a missing "#endif"

Here's a patch that puts the #else back, adds the #endif, and
fixes the whitespace to make this nested mess of pre-processor
noise a bit more legible.

Signed-off-by: Tony Luck <tony.luck@intel.com>

===== include/asm-ia64/page.h 1.28 vs edited =====
--- 1.28/include/asm-ia64/page.h	2004-09-05 20:48:22 +00:00
+++ edited/include/asm-ia64/page.h	2004-09-08 20:39:23 +00:00
@@ -86,13 +86,14 @@
 #ifndef CONFIG_DISCONTIGMEM
 # ifdef CONFIG_VIRTUAL_MEM_MAP
 extern struct page *vmem_map;
-#  define pfn_valid(pfn)       (((pfn) < max_mapnr) && ia64_pfn_valid(pfn))
-#  define page_to_pfn(page)    ((unsigned long) (page - vmem_map))
-#  define pfn_to_page(pfn)     (vmem_map + (pfn))
+#  define pfn_valid(pfn)	(((pfn) < max_mapnr) && ia64_pfn_valid(pfn))
+#  define page_to_pfn(page)	((unsigned long) (page - vmem_map))
+#  define pfn_to_page(pfn)	(vmem_map + (pfn))
+# else
+#  define pfn_valid(pfn)	(((pfn) < max_mapnr) && ia64_pfn_valid(pfn))
+#  define page_to_pfn(page)	((unsigned long) (page - mem_map))
+#  define pfn_to_page(pfn)	(mem_map + (pfn))
 # endif
-#define pfn_valid(pfn)		(((pfn) < max_mapnr) && ia64_pfn_valid(pfn))
-#define page_to_pfn(page)	((unsigned long) (page - mem_map))
-#define pfn_to_page(pfn)	(mem_map + (pfn))
 #endif /* CONFIG_DISCONTIGMEM */
 
 #define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
