Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266542AbUBESme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUBESme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:42:34 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:62603 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266542AbUBESmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:42:17 -0500
Date: Thu, 5 Feb 2004 18:42:22 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: j-nomura@ce.jp.nec.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4] heavy-load under swap space shortage
In-Reply-To: <20040204.204058.1025214600.nomura@linux.bs1.fc.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0402051834070.1396-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004 j-nomura@ce.jp.nec.com wrote:
> 
> With slight modification (please see the patch below), it's really helpful.
> I hope you push it again to the mainline.

Okay, glad to hear it, I'll try pushing to Marcelo in 2.4.26-pre.
Can you describe the benefit you see?

> I had to remove raciness check in swap_out_mm, otherwise swap_out_mm
> returns immediately and contend on mmlist_lock in mmput().

Ah yes, thanks a lot, leaving that swap_mm != mm check behind
made an utter nonsense of my patch.

> I think removal is ok because we now avoid the 'rush to same mm' by trylock.

I agree, swap_out_mm's TASK_SIZE check was for the previously all too
common case where one by one they spin on and visit the same old mm
too late, no need for it now.  But if we remove that block, the
mmcounter arg becomes pointless, so removed in version below.

> I added the check for 'mm == swap_mm'. It might be necessary to avoid
> the corner case where mmlist_lock being held too long.

Oh, good point.  But I'm uneasy about treating a trip round the mmlist
failing to get a lock as the same thing as finding no pages to free,
your "goto empty": drop lock and come around again instead, as below?

Hugh

--- 2.4.25-rc1/mm/vmscan.c	2004-02-05 17:37:28.755210944 +0000
+++ linux/mm/vmscan.c	2004-02-05 17:48:03.764674832 +0000
@@ -283,7 +283,7 @@
 /*
  * Returns remaining count of pages to be swapped out by followup call.
  */
-static inline int swap_out_mm(struct mm_struct * mm, int count, int * mmcounter, zone_t * classzone)
+static inline int swap_out_mm(struct mm_struct * mm, int count, zone_t * classzone)
 {
 	unsigned long address;
 	struct vm_area_struct* vma;
@@ -292,13 +292,7 @@
 	 * Find the proper vm-area after freezing the vma chain 
 	 * and ptes.
 	 */
-	spin_lock(&mm->page_table_lock);
 	address = mm->swap_address;
-	if (address == TASK_SIZE || swap_mm != mm) {
-		/* We raced: don't count this mm but try again */
-		++*mmcounter;
-		goto out_unlock;
-	}
 	vma = find_vma(mm, address);
 	if (vma) {
 		if (address < vma->vm_start)
@@ -310,15 +304,13 @@
 			if (!vma)
 				break;
 			if (!count)
-				goto out_unlock;
+				goto out;
 			address = vma->vm_start;
 		}
 	}
 	/* Indicate that we reached the end of address space */
 	mm->swap_address = TASK_SIZE;
-
-out_unlock:
-	spin_unlock(&mm->page_table_lock);
+out:
 	return count;
 }
 
@@ -330,6 +322,7 @@
 
 	counter = mmlist_nr << 1;
 	do {
+top:
 		if (unlikely(current->need_resched)) {
 			__set_current_state(TASK_RUNNING);
 			schedule();
@@ -345,12 +338,21 @@
 			swap_mm = mm;
 		}
 
+		/* Scan mmlist and lock the first available mm */
+		while (mm == &init_mm || !spin_trylock(&mm->page_table_lock)) {
+			mm = list_entry(mm->mmlist.next, struct mm_struct, mmlist);
+			if (mm == swap_mm) {
+				spin_unlock(&mmlist_lock);
+				goto top;
+			}
+		}
+
 		/* Make sure the mm doesn't disappear when we drop the lock.. */
 		atomic_inc(&mm->mm_users);
 		spin_unlock(&mmlist_lock);
 
-		nr_pages = swap_out_mm(mm, nr_pages, &counter, classzone);
-
+		nr_pages = swap_out_mm(mm, nr_pages, classzone);
+		spin_unlock(&mm->page_table_lock);
 		mmput(mm);
 
 		if (!nr_pages)

