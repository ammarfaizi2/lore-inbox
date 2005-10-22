Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVJVQZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVJVQZv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 12:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVJVQZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 12:25:51 -0400
Received: from gold.veritas.com ([143.127.12.110]:32517 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932257AbVJVQZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 12:25:50 -0400
Date: Sat, 22 Oct 2005 17:24:50 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Mikael Starvik <mikael.starvik@axis.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] mm: cris v32 mmu_context_lock
In-Reply-To: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510221723320.18047@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Oct 2005 16:25:50.0738 (UTC) FILETIME=[442B5720:01C5D725]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cris v32 switch_mm guards get_mmu_context with next->page_table_lock:
good it's not really SMP yet, since get_mmu_context messes with global
variables affecting other mms.  Replace by global mmu_context_lock.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/cris/arch-v32/mm/tlb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- mm3/arch/cris/arch-v32/mm/tlb.c	2005-10-17 12:05:08.000000000 +0100
+++ mm4/arch/cris/arch-v32/mm/tlb.c	2005-10-22 14:06:42.000000000 +0100
@@ -175,6 +175,8 @@ init_new_context(struct task_struct *tsk
 	return 0;
 }
 
+static DEFINE_SPINLOCK(mmu_context_lock);
+
 /* Called in schedule() just before actually doing the switch_to. */
 void
 switch_mm(struct mm_struct *prev, struct mm_struct *next,
@@ -183,10 +185,10 @@ switch_mm(struct mm_struct *prev, struct
 	int cpu = smp_processor_id();
 
 	/* Make sure there is a MMU context. */
-	spin_lock(&next->page_table_lock);
+	spin_lock(&mmu_context_lock);
 	get_mmu_context(next);
 	cpu_set(cpu, next->cpu_vm_mask);
-	spin_unlock(&next->page_table_lock);
+	spin_unlock(&mmu_context_lock);
 
 	/*
 	 * Remember the pgd for the fault handlers. Keep a seperate copy of it
