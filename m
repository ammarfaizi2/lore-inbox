Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWACXbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWACXbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWACXan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:30:43 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:37302 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965101AbWACXae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:30:34 -0500
Message-ID: <43BB0901.9050308@watson.ibm.com>
Date: Tue, 03 Jan 2006 23:30:09 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       LSE <lse-tech@lists.sourceforge.net>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: [Patch 4/6] Delay accounting: Swap in delays
References: <43BB05D8.6070101@watson.ibm.com>
In-Reply-To: <43BB05D8.6070101@watson.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since 12/7/05

- removed __attribute((unused)) qualifiers from timespec vars (dave hansen)
- use existing timestamping function do_posix_clock_monotonic_gettime() (jay lan)

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
 kernel/delayacct.c        |   15 +++++++++++++++
 mm/memory.c               |   16 +++++++++-------
 4 files changed, 29 insertions(+), 7 deletions(-)

Index: linux-2.6.15-rc7/include/linux/delayacct.h
===================================================================
--- linux-2.6.15-rc7.orig/include/linux/delayacct.h
+++ linux-2.6.15-rc7/include/linux/delayacct.h
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
Index: linux-2.6.15-rc7/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc7.orig/include/linux/sched.h
+++ linux-2.6.15-rc7/include/linux/sched.h
@@ -548,6 +548,8 @@ struct task_delay_info {
 	/* Add stats in pairs: uint64_t delay, uint32_t count */
 	uint64_t blkio_delay;	/* wait for sync block io completion */
 	uint32_t blkio_count;
+	uint64_t swapin_delay;	/* wait for pages to be swapped in */
+	uint32_t swapin_count;
 };
 #endif

Index: linux-2.6.15-rc7/mm/memory.c
===================================================================
--- linux-2.6.15-rc7.orig/mm/memory.c
+++ linux-2.6.15-rc7/mm/memory.c
@@ -2171,16 +2171,15 @@ static inline int handle_pte_fault(struc

 	old_entry = entry = *pte;
 	if (!pte_present(entry)) {
-		if (pte_none(entry)) {
-			int ret;
-			struct timespec start, end;
+		int ret;
+		struct timespec start, end;

+		do_posix_clock_monotonic_gettime(&start);
+		if (pte_none(entry)) {
 			if (!vma->vm_ops || !vma->vm_ops->nopage)
 				return do_anonymous_page(mm, vma, address,
 					pte, pmd, write_access);

-			if (vma->vm_file)
-				do_posix_clock_monotonic_gettime(&start);
 			ret = do_no_page(mm, vma, address,
 					 pte, pmd, write_access);
 			if (vma->vm_file) {
@@ -2192,8 +2191,11 @@ static inline int handle_pte_fault(struc
 		if (pte_file(entry))
 			return do_file_page(mm, vma, address,
 					pte, pmd, write_access, entry);
-		return do_swap_page(mm, vma, address,
-					pte, pmd, write_access, entry);
+		ret = do_swap_page(mm, vma, address,
+				   pte, pmd, write_access, entry);
+		do_posix_clock_monotonic_gettime(&end);
+ 		delayacct_swapin(&start, &end);
+		return ret;
 	}

 	ptl = pte_lockptr(mm, pmd);
Index: linux-2.6.15-rc7/kernel/delayacct.c
===================================================================
--- linux-2.6.15-rc7.orig/kernel/delayacct.c
+++ linux-2.6.15-rc7/kernel/delayacct.c
@@ -50,3 +50,18 @@ inline void delayacct_blkio(struct times
 	current->delays.blkio_count++;
 	spin_unlock(&current->delays.lock);
 }
+
+inline void delayacct_swapin(struct timespec *start, struct timespec *end)
+{
+	unsigned long long delay;
+
+	if (!delayacct_on)
+		return;
+
+	delay = timespec_diff_ns(start, end);
+
+	spin_lock(&current->delays.lock);
+	current->delays.swapin_delay += delay;
+	current->delays.swapin_count++;
+	spin_unlock(&current->delays.lock);
+}
