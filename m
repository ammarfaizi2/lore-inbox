Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265839AbVBDVMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbVBDVMH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 16:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265656AbVBDVHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 16:07:18 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:34470 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264872AbVBDVGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:06:17 -0500
Subject: [PATCH 3/3] remove-free_all_bootmem() #define
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 04 Feb 2005 13:06:08 -0800
Message-Id: <E1CxAeX-0003uQ-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


in arch/i386/mm/init.c, there's a #define for __free_all_bootmem():

#ifndef CONFIG_DISCONTIGMEM
#define __free_all_bootmem() free_all_bootmem()
#else
#define __free_all_bootmem() free_all_bootmem_node(NODE_DATA(0))
#endif /* !CONFIG_DISCONTIGMEM */

However, both of those functions end up eventually calling the same
thing:

	free_all_bootmem_core(NODE_DATA(0))

This might have once been a placeholder for a more complex bootmem
init call, but that never happened.  So, kill off the DISCONTIG
version, and just call free_all_bootmem() directly in both cases.
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/arch/i386/mm/init.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)

diff -puN arch/i386/mm/init.c~A1.3-remove-free_all_bootmem-define arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~A1.3-remove-free_all_bootmem-define	2005-02-03 11:53:40.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/init.c	2005-02-03 11:53:40.000000000 -0800
@@ -579,12 +579,6 @@ static void __init set_max_mapnr_init(vo
 #endif
 }
 
-#ifndef CONFIG_DISCONTIGMEM
-#define __free_all_bootmem() free_all_bootmem()
-#else
-#define __free_all_bootmem() free_all_bootmem_node(NODE_DATA(0))
-#endif /* !CONFIG_DISCONTIGMEM */
-
 static struct kcore_list kcore_mem, kcore_vmalloc; 
 
 void __init mem_init(void)
@@ -620,7 +614,7 @@ void __init mem_init(void)
 #endif
 
 	/* this will put all low memory onto the freelists */
-	totalram_pages += __free_all_bootmem();
+	totalram_pages += free_all_bootmem();
 
 	reservedpages = 0;
 	for (tmp = 0; tmp < max_low_pfn; tmp++)
_
