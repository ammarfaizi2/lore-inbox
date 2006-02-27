Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWB0IWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWB0IWd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWB0IWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:22:33 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:61613 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932254AbWB0IWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:22:32 -0500
Subject: [Patch 6/7] Swapin page fault delays
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <1141026996.5785.38.camel@elinux04.optonline.net>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1141028549.5785.67.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 27 Feb 2006 03:22:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-swapin.patch

Record time spent by a task waiting for its pages to be swapped in.
This statistic can help in adjusting the rss limits of 
tasks (process), especially relative to each other, when the system is 
under memory pressure.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/delayacct.h |    8 ++++++++
 include/linux/sched.h     |    2 ++
 kernel/delayacct.c        |   14 ++++++++++++++
 mm/memory.c               |    7 +++++--
 4 files changed, 29 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc4/include/linux/delayacct.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/delayacct.h	2006-02-27 01:52:59.000000000 -0500
+++ linux-2.6.16-rc4/include/linux/delayacct.h	2006-02-27 01:53:01.000000000 -0500
@@ -26,6 +26,7 @@ extern int delayacct_init(void);
 extern void __delayacct_tsk_init(struct task_struct *);
 extern void __delayacct_tsk_exit(struct task_struct *);
 extern void __delayacct_blkio(void);
+extern void __delayacct_swapin(void);
 
 static inline void delayacct_tsk_early_init(struct task_struct *tsk)
 {
@@ -54,6 +55,11 @@ static inline void delayacct_blkio(void)
 	if (unlikely(current->delays && delayacct_on))
 		__delayacct_blkio();
 }
+static inline void delayacct_swapin(void)
+{
+	if (unlikely(current->delays && delayacct_on))
+		__delayacct_swapin();
+}
 #else
 static inline void delayacct_tsk_early_init(struct task_struct *tsk)
 {}
@@ -65,6 +71,8 @@ static inline void delayacct_timestamp_s
 {}
 static inline void delayacct_blkio(void)
 {}
+static inline void delayacct_swapin(void)
+{}
 static inline int delayacct_init(void)
 {}
 #endif /* CONFIG_TASK_DELAY_ACCT */
Index: linux-2.6.16-rc4/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/sched.h	2006-02-27 01:52:59.000000000 -0500
+++ linux-2.6.16-rc4/include/linux/sched.h	2006-02-27 01:53:01.000000000 -0500
@@ -552,7 +552,9 @@ struct task_delay_info {
 
 	/* Add stats in pairs: u64 delay, u32 count, aligned properly */
 	u64 blkio_delay;	/* wait for sync block io completion */
+	u64 swapin_delay;	/* wait for pages to be swapped in */
 	u32 blkio_count;
+	u32 swapin_count;
 };
 #endif
 
Index: linux-2.6.16-rc4/kernel/delayacct.c
===================================================================
--- linux-2.6.16-rc4.orig/kernel/delayacct.c	2006-02-27 01:52:59.000000000 -0500
+++ linux-2.6.16-rc4/kernel/delayacct.c	2006-02-27 01:53:01.000000000 -0500
@@ -92,6 +92,20 @@ void __delayacct_blkio(void)
 	spin_unlock(&current->delays->lock);
 }
 
+void __delayacct_swapin(void)
+{
+	nsec_t delay;
+
+	delay = delayacct_measure();
+	if (delay < 0)
+		return;
+
+	spin_lock(&current->delays->lock);
+	current->delays->swapin_delay += delay;
+	current->delays->swapin_count++;
+	spin_unlock(&current->delays->lock);
+}
+
 /* Allocate task_delay_info for all tasks without one */
 static int alloc_delays(void)
 {
Index: linux-2.6.16-rc4/mm/memory.c
===================================================================
--- linux-2.6.16-rc4.orig/mm/memory.c	2006-02-27 01:52:59.000000000 -0500
+++ linux-2.6.16-rc4/mm/memory.c	2006-02-27 01:53:01.000000000 -0500
@@ -2209,9 +2209,10 @@ static inline int handle_pte_fault(struc
 
 	old_entry = entry = *pte;
 	if (!pte_present(entry)) {
+		int ret;
+
 		delayacct_timestamp_start();
 		if (pte_none(entry)) {
-			int ret;
 			if (!vma->vm_ops || !vma->vm_ops->nopage)
 				return do_anonymous_page(mm, vma, address,
 					pte, pmd, write_access);
@@ -2224,8 +2225,10 @@ static inline int handle_pte_fault(struc
 		if (pte_file(entry))
 			return do_file_page(mm, vma, address,
 					pte, pmd, write_access, entry);
-		return do_swap_page(mm, vma, address,
+		ret = do_swap_page(mm, vma, address,
 					pte, pmd, write_access, entry);
+		delayacct_swapin();
+		return ret;
 	}
 
 	ptl = pte_lockptr(mm, pmd);


