Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbVEGR5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVEGR5l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 13:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVEGR5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 13:57:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:35033 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262735AbVEGR5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 13:57:38 -0400
Date: Sat, 7 May 2005 18:57:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix impossible VmallocChunk
Message-ID: <Pine.LNX.4.61.0505071855190.6031@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 07 May 2005 17:57:05.0058 (UTC) 
    FILETIME=[2DB84820:01C5532E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VmallocTotal: 34359738367 kB
VmallocUsed:    266288 kB
VmallocChunk: 18014366299193295 kB
is unsettling - x86_64 and some other architectures keep a separate address
range for modules in vmalloc's vmlist, which /proc/meminfo should pass over.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.12-rc4/fs/proc/mmu.c	2005-03-02 07:37:50.000000000 +0000
+++ linux/fs/proc/mmu.c	2005-05-07 18:32:32.000000000 +0100
@@ -50,13 +50,23 @@ void get_vmalloc_info(struct vmalloc_inf
 		read_lock(&vmlist_lock);
 
 		for (vma = vmlist; vma; vma = vma->next) {
+			unsigned long addr = (unsigned long) vma->addr;
+
+			/*
+			 * Some archs keep another range for modules in vmlist
+			 */
+			if (addr < VMALLOC_START)
+				continue;
+			if (addr >= VMALLOC_END)
+				break;
+
 			vmi->used += vma->size;
 
-			free_area_size = (unsigned long) vma->addr - prev_end;
+			free_area_size = addr - prev_end;
 			if (vmi->largest_chunk < free_area_size)
 				vmi->largest_chunk = free_area_size;
 
-			prev_end = vma->size + (unsigned long) vma->addr;
+			prev_end = vma->size + addr;
 		}
 
 		if (VMALLOC_END - prev_end > vmi->largest_chunk)
