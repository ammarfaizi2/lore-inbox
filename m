Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWCNAv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWCNAv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWCNAv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:51:29 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:19430 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932388AbWCNAv2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:51:28 -0500
Subject: [Patch 5/9] Swapin delays
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>
In-Reply-To: <1142296834.5858.3.camel@elinux04.optonline.net>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1142297486.5858.21.camel@elinux04.optonline.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 13 Mar 2006 19:51:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

delayacct-swapin.patch

Account separately for block I/O delays 
incurred as a result of swapin page faults since
these are a result of insufficient rss limit.

Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/sched.h |    5 ++++-
 kernel/delayacct.c    |   17 ++++++++++++-----
 mm/memory.c           |    4 ++++
 3 files changed, 20 insertions(+), 6 deletions(-)

Index: linux-2.6.16-rc5/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc5.orig/include/linux/sched.h	2006-03-11 07:41:38.000000000 -0500
+++ linux-2.6.16-rc5/include/linux/sched.h	2006-03-11 07:41:39.000000000 -0500
@@ -550,9 +550,11 @@ struct task_delay_info {
 	 * u32 XXX_count;
 	 */
 
-	struct timespec blkio_start, blkio_end;
+	struct timespec blkio_start, blkio_end;	/* Shared by blkio, swapin */
 	u64 blkio_delay;	/* wait for sync block io completion */
+	u64 swapin_delay;	/* wait for sync block io completion */
 	u32 blkio_count;
+	u32 swapin_count;
 };
 #endif
 
@@ -949,6 +951,7 @@ static inline void put_task_struct(struc
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
 #define PF_SWAPWRITE	0x01000000	/* Allowed to write to swap */
+#define PF_SWAPIN	0x02000000	/* I am doing a swap in */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
Index: linux-2.6.16-rc5/kernel/delayacct.c
===================================================================
--- linux-2.6.16-rc5.orig/kernel/delayacct.c	2006-03-11 07:41:38.000000000 -0500
+++ linux-2.6.16-rc5/kernel/delayacct.c	2006-03-11 07:41:39.000000000 -0500
@@ -98,9 +98,16 @@ void __delayacct_blkio_start(void)
 
 void __delayacct_blkio_end(void)
 {
-	if (current->delays)
-		delayacct_end(&current->delays->blkio_start,
-				&current->delays->blkio_end,
-				&current->delays->blkio_delay,
-				&current->delays->blkio_count);
+	if (current->delays) {
+		if (current->flags & PF_SWAPIN)	/* Swapping a page in */
+			delayacct_end(&current->delays->blkio_start,
+				      &current->delays->blkio_end,
+				      &current->delays->swapin_delay,
+				      &current->delays->swapin_count);
+		else	/* Other block I/O */
+			delayacct_end(&current->delays->blkio_start,
+				      &current->delays->blkio_end,
+				      &current->delays->blkio_delay,
+				      &current->delays->blkio_count);
+	}
 }
Index: linux-2.6.16-rc5/mm/memory.c
===================================================================
--- linux-2.6.16-rc5.orig/mm/memory.c	2006-03-11 07:41:32.000000000 -0500
+++ linux-2.6.16-rc5/mm/memory.c	2006-03-11 07:41:39.000000000 -0500
@@ -1882,6 +1882,7 @@ static int do_swap_page(struct mm_struct
 
 	entry = pte_to_swp_entry(orig_pte);
 again:
+	current->flags |= PF_SWAPIN;
 	page = lookup_swap_cache(entry);
 	if (!page) {
  		swapin_readahead(entry, address, vma);
@@ -1894,6 +1895,7 @@ again:
 			page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 			if (likely(pte_same(*page_table, orig_pte)))
 				ret = VM_FAULT_OOM;
+			current->flags &= ~PF_SWAPOFF;
 			goto unlock;
 		}
 
@@ -1905,6 +1907,8 @@ again:
 
 	mark_page_accessed(page);
 	lock_page(page);
+	current->flags &= ~PF_SWAPOFF;
+
 	if (!PageSwapCache(page)) {
 		/* Page migration has occured */
 		unlock_page(page);


