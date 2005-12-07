Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbVLGW2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbVLGW2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbVLGW2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:28:36 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:14046 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751798AbVLGW2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:28:35 -0500
Message-ID: <4397620B.1070303@watson.ibm.com>
Date: Wed, 07 Dec 2005 22:28:27 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       lse-tech@lists.sourceforge.net,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jay Lan <jlan@sgi.com>, Jens Axboe <axboe@suse.de>
Subject: [RFC][Patch 4/5] Per-task delay accounting: Swap in delays
References: <43975D45.3080801@watson.ibm.com>
In-Reply-To: <43975D45.3080801@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since 11/14/05

- use nanosecond resolution, adjusted wall clock time for timestamps
  instead of sched_clock (akpm, andi, marcelo)
- collect stats only if delay accounting enabled (parag)
- collect delays for only swapin page faults instead of all page faults.

11/14/05: First post


delayacct-swapin.patch

Record time spent by a task waiting for its pages to be swapped in.
This statistic can help in adjusting the rss limits of
tasks (process), especially relative to each other, when the system is
under memory pressure.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/delayacct.h |    3 +++
 include/linux/sched.h     |    2 ++
 mm/memory.c               |   16 +++++++++-------
 3 files changed, 14 insertions(+), 7 deletions(-)

Index: linux-2.6.15-rc5/include/linux/delayacct.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/delayacct.h
+++ linux-2.6.15-rc5/include/linux/delayacct.h
@@ -20,11 +20,14 @@
 extern int delayacct_on;	/* Delay accounting turned on/off */
 extern void delayacct_tsk_init(struct task_struct *tsk);
 extern void delayacct_blkio(struct timespec *start, struct timespec *end);
+extern void delayacct_swapin(struct timespec *start, struct timespec *end);
 #else
 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {}
 static inline void delayacct_blkio(struct timespec *start, struct timespec *end)
 {}
+static inline void delayacct_swapin(struct timespec *start, struct timespec *end)
+{}

 #endif /* CONFIG_TASK_DELAY_ACCT */
 #endif /* _LINUX_TASKDELAYS_H */
Index: linux-2.6.15-rc5/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/sched.h
+++ linux-2.6.15-rc5/include/linux/sched.h
@@ -548,6 +548,8 @@ struct task_delay_info {
 	/* Add stats in pairs: uint64_t delay, uint32_t count */
 	uint64_t blkio_delay;	/* wait for sync block io completion */
 	uint32_t blkio_count;
+	uint64_t swapin_delay;	/* wait for pages to be swapped in */
+	uint32_t swapin_count;
 };
 #endif

Index: linux-2.6.15-rc5/mm/memory.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/memory.c
+++ linux-2.6.15-rc5/mm/memory.c
@@ -2201,16 +2201,15 @@ static inline int handle_pte_fault(struc

 	old_entry = entry = *pte;
 	if (!pte_present(entry)) {
-		if (pte_none(entry)) {
-			int ret;
-			__attribute__((unused)) struct timespec start, end;
+		int ret;
+		__attribute__((unused)) struct timespec start, end;

+		getnstimestamp(&start);
+		if (pte_none(entry)) {
 			if (!vma->vm_ops || !vma->vm_ops->nopage)
 				return do_anonymous_page(mm, vma, address,
 					pte, pmd, write_access);

-			if (vma->vm_file)
-				getnstimestamp(&start);
 			ret = do_no_page(mm, vma, address,
 					 pte, pmd, write_access);
 			if (vma->vm_file) {
@@ -2222,8 +2221,11 @@ static inline int handle_pte_fault(struc
 		if (pte_file(entry))
 			return do_file_page(mm, vma, address,
 					pte, pmd, write_access, entry);
-		return do_swap_page(mm, vma, address,
-					pte, pmd, write_access, entry);
+		ret = do_swap_page(mm, vma, address,
+				   pte, pmd, write_access, entry);
+		getnstimestamp(&end);
+ 		delayacct_swapin(&start, &end);
+		return ret;
 	}

 	ptl = pte_lockptr(mm, pmd);
