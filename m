Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262777AbVBYSyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbVBYSyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 13:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVBYSyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 13:54:39 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:26055 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262777AbVBYSyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 13:54:37 -0500
Subject: [PATCH] make highmem_start access only valid addresses (i386)
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 25 Feb 2005 10:54:34 -0800
Message-Id: <E1D4kbj-0004UG-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When CONFIG_HIGHMEM=y, but ZONE_NORMAL isn't quite full, there is, of course,
no actual memory at *high_memory.  This isn't a problem with normal
virt<->phys translations because it's never dereferenced, but CONFIG_NONLINEAR
is a bit more finicky.  So, don't do __va() in non-existent addresses.

BTW, this can certainly wait until the 2.6.12 series.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 sparse-dave/arch/i386/mm/init.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/i386/mm/init.c~A4-highmem_start-valid_addrs arch/i386/mm/init.c
--- sparse/arch/i386/mm/init.c~A4-highmem_start-valid_addrs	2005-02-24 08:56:43.000000000 -0800
+++ sparse-dave/arch/i386/mm/init.c	2005-02-24 08:56:43.000000000 -0800
@@ -563,9 +563,9 @@ void __init mem_init(void)
 	set_max_mapnr_init();
 
 #ifdef CONFIG_HIGHMEM
-	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE);
+	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
 #else
-	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
+	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
 #endif
 
 	/* this will put all low memory onto the freelists */
_
