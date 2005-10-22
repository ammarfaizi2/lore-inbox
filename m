Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVJVQ0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVJVQ0x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 12:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVJVQ0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 12:26:53 -0400
Received: from gold.veritas.com ([143.127.12.110]:45061 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932258AbVJVQ0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 12:26:52 -0400
Date: Sat, 22 Oct 2005 17:25:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] mm: uml pte atomicity
In-Reply-To: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510221724550.18047@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Oct 2005 16:26:52.0374 (UTC) FILETIME=[68E83F60:01C5D725]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's usually a good reason when a pte is examined without the lock;
but it makes me nervous when the pointer is dereferenced more than once.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/um/kernel/process_kern.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

--- mm4/arch/um/kernel/process_kern.c	2005-10-17 12:05:14.000000000 +0100
+++ mm5/arch/um/kernel/process_kern.c	2005-10-22 14:06:58.000000000 +0100
@@ -222,6 +222,7 @@ void *um_virt_to_phys(struct task_struct
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	pte_t ptent;
 
 	if(task->mm == NULL) 
 		return(ERR_PTR(-EINVAL));
@@ -238,12 +239,13 @@ void *um_virt_to_phys(struct task_struct
 		return(ERR_PTR(-EINVAL));
 
 	pte = pte_offset_kernel(pmd, addr);
-	if(!pte_present(*pte)) 
+	ptent = *pte;
+	if(!pte_present(ptent)) 
 		return(ERR_PTR(-EINVAL));
 
 	if(pte_out != NULL)
-		*pte_out = *pte;
-	return((void *) (pte_val(*pte) & PAGE_MASK) + (addr & ~PAGE_MASK));
+		*pte_out = ptent;
+	return((void *) (pte_val(ptent) & PAGE_MASK) + (addr & ~PAGE_MASK));
 }
 
 char *current_cmd(void)
