Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVAZA1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVAZA1w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVAZA0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:26:50 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:13995 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262255AbVAZAXr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:23:47 -0500
Subject: [RFC][PATCH 3/5] remove-free_all_bootmem() #define
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 25 Jan 2005 16:23:40 -0800
Message-Id: <E1CtayD-0006sU-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



in arch/i386/mm/init.c, there's a #define for __free_all_bootmem():

#ifndef CONFIG_DISCONTIGMEM
#define __free_all_bootmem() free_all_bootmem()
#else
#define __free_all_bootmem() free_all_bootmem_node(NODE_DATA(0))
#endif /* !CONFIG_DISCONTIGMEM */

However, both of those functions end up eventuall calling the same
thing:

	free_all_bootmem_core(NODE_DATA(0))

This might have once been a placeholder for a more complex bootmem
init call, but that never happened.  So, kill off the DISCONTIG
version, and just call free_all_bootmem() directly in both cases.

---

 memhotplug-dave/arch/i386/mm/init.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)

diff -puN arch/i386/mm/init.c~A1.3-remove-free_all_bootmem-define arch/i386/mm/init.c
--- memhotplug/arch/i386/mm/init.c~A1.3-remove-free_all_bootmem-define	2005-01-25 13:59:50.000000000 -0800
+++ memhotplug-dave/arch/i386/mm/init.c	2005-01-25 14:00:14.000000000 -0800
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
