Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVKODbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVKODbJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVKODbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:31:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:34741 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932352AbVKODbC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:31:02 -0500
Message-ID: <437965A6.6080607@watson.ibm.com>
Date: Mon, 14 Nov 2005 23:35:50 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 3/4] Delay accounting: Page fault delays
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-pgflt.patch

Record time spent by a task waiting for page fault completion.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/delayacct.h |   20 ++++++++++++++++++++
 include/linux/sched.h     |    2 ++
 mm/memory.c               |   17 ++++++++++++++---
 3 files changed, 36 insertions(+), 3 deletions(-)

Index: linux-2.6.14/include/linux/delayacct.h
===================================================================
--- linux-2.6.14.orig/include/linux/delayacct.h
+++ linux-2.6.14/include/linux/delayacct.h
@@ -56,6 +56,24 @@ static inline void delayacct_blkio(unsig
 	spin_unlock(&current->delays.lock);
 }

+static inline void delayacct_pgflt(unsigned long long ts)
+{
+	unsigned long long now = sched_clock();
+
+	if (!test_ts_integrity(ts, now))
+		return;
+
+	/* Lock and pgflt_count may be unnecessary.
+	 * pgflt_count is equivalent to current->min_flt+current->maj_flt
+	 * but if the sum cannot be safely taken when current->delays is read
+	 * the lock and redundant addition may still be needed.
+	 */
+	spin_lock(&current->delays.lock);
+	current->delays.pgflt_delay += now - ts;
+	current->delays.pgflt_count++;
+	spin_unlock(&current->delays.lock);
+}
+
 #else

 static inline void delayacct_init(struct task_struct *tsk)
@@ -65,6 +83,8 @@ static inline void delayacct_timestamp(u
 {}
 static inline void delayacct_blkio(unsigned long long ts)
 {}
+static inline void delayacct_pgflt(unsigned long long ts)
+{}
 #endif /* CONFIG_DELAY_ACCT */


Index: linux-2.6.14/include/linux/sched.h
===================================================================
--- linux-2.6.14.orig/include/linux/sched.h
+++ linux-2.6.14/include/linux/sched.h
@@ -504,6 +504,8 @@ struct task_delay_info {
 	/* Add stats in pairs: uint64_t delay, uint32_t count */
 	uint64_t blkio_delay;	/* wait for block io completion */
 	uint32_t blkio_count;
+	uint64_t pgflt_delay;	/* wait for page fault completion */
+	uint32_t pgflt_count;
 };
 #endif

Index: linux-2.6.14/mm/memory.c
===================================================================
--- linux-2.6.14.orig/mm/memory.c
+++ linux-2.6.14/mm/memory.c
@@ -48,6 +48,8 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/delayacct.h>

 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -2040,13 +2042,19 @@ int __handle_mm_fault(struct mm_struct *
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	int rc;
+	delayacct_def_var(ts);

+	delayacct_timestamp(&ts);
 	__set_current_state(TASK_RUNNING);

 	inc_page_state(pgfault);

-	if (unlikely(is_vm_hugetlb_page(vma)))
-		return hugetlb_fault(mm, vma, address, write_access);
+	if (unlikely(is_vm_hugetlb_page(vma))) {
+		rc = hugetlb_fault(mm, vma, address, write_access);
+		delayacct_pgflt(ts);
+		return rc;
+	}

 	/*
 	 * We need the page table lock to synchronize with kswapd
@@ -2067,10 +2075,13 @@ int __handle_mm_fault(struct mm_struct *
 	if (!pte)
 		goto oom;
 	
-	return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+	rc = handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+	delayacct_pgflt(ts);
+	return rc;

  oom:
 	spin_unlock(&mm->page_table_lock);
+	delayacct_pgflt(ts);
 	return VM_FAULT_OOM;
 }

