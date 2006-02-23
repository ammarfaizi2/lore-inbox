Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWBWLIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWBWLIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 06:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWBWLIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 06:08:17 -0500
Received: from fgwmail.fujitsu.co.jp ([164.71.1.133]:13778 "EHLO
	fgwmail.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750717AbWBWLIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 06:08:16 -0500
Message-ID: <43FD97E1.2010307@jp.fujitsu.com>
Date: Thu, 23 Feb 2006 20:09:21 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] unify pfn_to_page take3 [23/23] ia64 pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com> <43F1B950.4040403@jp.fujitsu.com>
In-Reply-To: <43F1B950.4040403@jp.fujitsu.com>
Content-Type: multipart/mixed;
 boundary="------------080508030302030003010406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080508030302030003010406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

KAMEZAWA Hiroyuki wrote:
> ia64 has special config CONFIG_VIRTUAL_MEM_MAP.
This vesion had a BUG. This is fixed one.
--Kame

--------------080508030302030003010406
Content-Type: text/x-patch;
 name="b022-ia64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="b022-ia64.patch"


ia64 has special config CONFIG_VIRTUAL_MEM_MAP.
CONFIG_DISCONTIGMEM=y && CONFIG_VIRTUAL_MEM_MAP!=y is bug ?

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: unify_page_to_pfn/include/asm-ia64/page.h
===================================================================
--- unify_page_to_pfn.orig/include/asm-ia64/page.h
+++ unify_page_to_pfn/include/asm-ia64/page.h
@@ -104,17 +104,25 @@ extern int ia64_pfn_valid (unsigned long
 # define ia64_pfn_valid(pfn) 1
 #endif
 
+#ifdef CONFIG_VIRTUAL_MEM_MAP
+extern struct page *vmem_map;
+#ifdef CONFIG_DISCONTIGMEM
+# define page_to_pfn(page)	((unsigned long) (page - vmem_map))
+# define pfn_to_page(pfn)	(vmem_map + (pfn))
+#endif
+#endif
+
+#if defined(CONFIG_FLATMEM) || defined(CONFIG_SPARSEMEM)
+/* FLATMEM always configures mem_map (mem_map = vmem_map if necessary) */
+#include <asm-generic/memory_model.h>
+#endif
+
 #ifdef CONFIG_FLATMEM
 # define pfn_valid(pfn)		(((pfn) < max_mapnr) && ia64_pfn_valid(pfn))
-# define page_to_pfn(page)	((unsigned long) (page - mem_map))
-# define pfn_to_page(pfn)	(mem_map + (pfn))
 #elif defined(CONFIG_DISCONTIGMEM)
-extern struct page *vmem_map;
 extern unsigned long min_low_pfn;
 extern unsigned long max_low_pfn;
 # define pfn_valid(pfn)		(((pfn) >= min_low_pfn) && ((pfn) < max_low_pfn) && ia64_pfn_valid(pfn))
-# define page_to_pfn(page)	((unsigned long) (page - vmem_map))
-# define pfn_to_page(pfn)	(vmem_map + (pfn))
 #endif
 
 #define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)

--------------080508030302030003010406--


