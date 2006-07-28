Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWG1NLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWG1NLK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWG1NLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:11:10 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:3087 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751206AbWG1NLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:11:09 -0400
Date: Fri, 28 Jul 2006 15:08:52 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [patch] bootmem: use MAX_DMA_ADDRESS instead of LOW32LIMIT
Message-ID: <20060728130852.GB9559@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

__alloc_bootmem_low() and __alloc_bootmem_low_node() should use
MAX_DMA_ADDRESS as limit which is per architecture instead of a global
LOW32LIMIT. Otherwise the bootmem allocator may return addresses
to memory regions which cannot be used for DMA access.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 mm/bootmem.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/bootmem.c b/mm/bootmem.c
index 50353e0..541bbe9 100644
--- a/mm/bootmem.c
+++ b/mm/bootmem.c
@@ -436,8 +436,6 @@ void * __init __alloc_bootmem_node(pg_da
 	return __alloc_bootmem(size, align, goal);
 }
 
-#define LOW32LIMIT 0xffffffff
-
 void * __init __alloc_bootmem_low(unsigned long size, unsigned long align, unsigned long goal)
 {
 	bootmem_data_t *bdata;
@@ -445,7 +443,7 @@ void * __init __alloc_bootmem_low(unsign
 
 	list_for_each_entry(bdata, &bdata_list, list)
 		if ((ptr = __alloc_bootmem_core(bdata, size,
-						 align, goal, LOW32LIMIT)))
+						 align, goal, MAX_DMA_ADDRESS)))
 			return(ptr);
 
 	/*
@@ -459,5 +457,6 @@ void * __init __alloc_bootmem_low(unsign
 void * __init __alloc_bootmem_low_node(pg_data_t *pgdat, unsigned long size,
 				       unsigned long align, unsigned long goal)
 {
-	return __alloc_bootmem_core(pgdat->bdata, size, align, goal, LOW32LIMIT);
+	return __alloc_bootmem_core(pgdat->bdata, size, align, goal,
+				    MAX_DMA_ADDRESS);
 }
