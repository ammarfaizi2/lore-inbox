Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVJKN1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVJKN1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 09:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVJKN1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:27:54 -0400
Received: from mail.renesas.com ([202.234.163.13]:20105 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751209AbVJKN1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:27:53 -0400
Date: Tue, 11 Oct 2005 22:27:48 +0900 (JST)
Message-Id: <20051011.222748.116352990.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: takata@linux-m32r.org, linux-kernel@vger.kernel.org,
       hitoshiy@isl.melco.co.jp
Subject: [PATCH 2.6.14-rc2-mm2] m32r: Fix smp.c for preempt kernel
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following BUG message of arch/m32r/smp.c
for CONFIG_DEBUG_PREEMPT:

BUG: using smp_processor_id() in preemptible

This message is displayed by an smp_processor_id() execution during
kernel's preemptible-state.

Signed-off-by: Hitoshi Yamamoto <hitoshiy@isl.melco.co.jp>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/smp.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Index: linux-2.6.14-rc2-mm2/arch/m32r/kernel/smp.c
===================================================================
--- linux-2.6.14-rc2-mm2.orig/arch/m32r/kernel/smp.c	2005-09-20 12:00:41.000000000 +0900
+++ linux-2.6.14-rc2-mm2/arch/m32r/kernel/smp.c	2005-10-11 21:21:50.819863288 +0900
@@ -275,12 +275,14 @@ static void flush_tlb_all_ipi(void *info
  *==========================================================================*/
 void smp_flush_tlb_mm(struct mm_struct *mm)
 {
-	int cpu_id = smp_processor_id();
+	int cpu_id;
 	cpumask_t cpu_mask;
-	unsigned long *mmc = &mm->context[cpu_id];
+	unsigned long *mmc;
 	unsigned long flags;
 
 	preempt_disable();
+	cpu_id = smp_processor_id();
+	mmc = &mm->context[cpu_id];
 	cpu_mask = mm->cpu_vm_mask;
 	cpu_clear(cpu_id, cpu_mask);
 
@@ -343,12 +345,14 @@ void smp_flush_tlb_range(struct vm_area_
 void smp_flush_tlb_page(struct vm_area_struct *vma, unsigned long va)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	int cpu_id = smp_processor_id();
+	int cpu_id;
 	cpumask_t cpu_mask;
-	unsigned long *mmc = &mm->context[cpu_id];
+	unsigned long *mmc;
 	unsigned long flags;
 
 	preempt_disable();
+	cpu_id = smp_processor_id();
+	mmc = &mm->context[cpu_id];
 	cpu_mask = mm->cpu_vm_mask;
 	cpu_clear(cpu_id, cpu_mask);

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
