Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVCKELe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVCKELe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVCKEJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:09:48 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:24507 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263191AbVCKEAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:00:14 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Mar 2005 15:00:09 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.6089.517130.140756@berry.gelato.unsw.EDU.AU>
Subject: Microstate Accounting for 2.6.11, patch 6/6
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Microstate accounting: Track time spent asleep while paging,
in poll() or select(), or on a futex separately from other sleeps.

 fs/select.c |    2 ++
 kernel/futex.c |    2 ++
 mm/memory.c |    6 +++++-


Index: linux-2.6-ustate/mm/memory.c
===================================================================
--- linux-2.6-ustate.orig/mm/memory.c	2005-03-10 09:12:59.492564100 +1100
+++ linux-2.6-ustate/mm/memory.c	2005-03-10 09:16:16.583875465 +1100
@@ -2079,6 +2079,7 @@
 	if (is_vm_hugetlb_page(vma))
 		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
 
+	msa_next_state(current, PAGING_SLEEP);
 	/*
 	 * We need the page table lock to synchronize with kswapd
 	 * and the SMP-safe atomic PTE updates.
@@ -2098,10 +2099,13 @@
 	if (!pte)
 		goto oom;
 	
-	return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+	int ret = handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+	msa_next_state(current, MSA_UNKNOWN);
+	return ret;
 
  oom:
 	spin_unlock(&mm->page_table_lock);
+	msa_next_state(current, MSA_UNKNOWN);
 	return VM_FAULT_OOM;
 }
 

Index: linux-2.6-ustate/kernel/futex.c
===================================================================
--- linux-2.6-ustate.orig/kernel/futex.c	2005-03-10 09:12:58.843154938 +1100
+++ linux-2.6-ustate/kernel/futex.c	2005-03-10 09:16:17.109262256 +1100
@@ -39,6 +39,7 @@
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
+#include <linux/msa.h>
 
 #define FUTEX_HASHBITS (CONFIG_BASE_SMALL ? 4 : 8)
 
@@ -571,6 +572,7 @@
 	 * wakes us up.
 	 */
 
+	msa_next_state(current, FUTEX_SLEEP);
 	/* add_wait_queue is the barrier after __set_current_state. */
 	__set_current_state(TASK_INTERRUPTIBLE);
 	add_wait_queue(&q.waiters, &wait);


Index: linux-2.6-ustate/fs/select.c
===================================================================
--- linux-2.6-ustate.orig/fs/select.c	2005-03-10 09:12:59.182996124 +1100
+++ linux-2.6-ustate/fs/select.c	2005-03-10 09:16:16.843639194 +1100
@@ -256,6 +256,7 @@
 			retval = table.error;
 			break;
 		}
+		msa_next_state(current, POLL_SLEEP);
 		__timeout = schedule_timeout(__timeout);
 	}
 	__set_current_state(TASK_RUNNING);
@@ -447,6 +448,7 @@
 		count = wait->error;
 		if (count)
 			break;
+		msa_next_state(current, POLL_SLEEP);
 		timeout = schedule_timeout(timeout);
 	}
 	__set_current_state(TASK_RUNNING);
