Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266677AbUFWVKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266677AbUFWVKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266685AbUFWVKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:10:11 -0400
Received: from holomorphy.com ([207.189.100.168]:19333 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266677AbUFWVHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:07:54 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [oom]: [4/4] check __GFP_WIRED in out_of_memory()
Message-ID: <0406231407.WaKbLbIb0a0a0aKbLbJbJb3a2aMbZa4aMb4aZa5a1aZaWaIbIbZaIbHbKbYaIb3a342@holomorphy.com>
In-Reply-To: <0406231407.1a2a3aHb2aIbHbLbHb5a0a5a0aWaJbJbLbIbXaJbLbIbWaKbXa0a4aMbJbHb4aXa342@holomorphy.com>
CC: akpm@osdl.org
Date: Wed, 23 Jun 2004 14:07:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6.7/include/linux/swap.h
===================================================================
--- linux-2.6.7.orig/include/linux/swap.h	2004-06-16 05:18:55.000000000 +0000
+++ linux-2.6.7/include/linux/swap.h	2004-06-23 16:41:20.000000000 +0000
@@ -148,7 +148,7 @@
 #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
 
 /* linux/mm/oom_kill.c */
-extern void out_of_memory(void);
+void out_of_memory(int gfp_mask);
 
 /* linux/mm/memory.c */
 extern void swapin_readahead(swp_entry_t, unsigned long, struct vm_area_struct *);
Index: linux-2.6.7/mm/oom_kill.c
===================================================================
--- linux-2.6.7.orig/mm/oom_kill.c	2004-06-16 05:19:29.000000000 +0000
+++ linux-2.6.7/mm/oom_kill.c	2004-06-23 16:41:58.000000000 +0000
@@ -220,7 +220,7 @@
 /**
  * out_of_memory - is the system out of memory?
  */
-void out_of_memory(void)
+void out_of_memory(int gfp_mask)
 {
 	/*
 	 * oom_lock protects out_of_memory()'s static variables.
@@ -233,7 +233,7 @@
 	/*
 	 * Enough swap space left?  Not OOM.
 	 */
-	if (nr_swap_pages > 0)
+	if (!(gfp_mask & __GFP_WIRED) && nr_swap_pages > 0)
 		return;
 
 	spin_lock(&oom_lock);
Index: linux-2.6.7/mm/vmscan.c
===================================================================
--- linux-2.6.7.orig/mm/vmscan.c	2004-06-16 05:18:58.000000000 +0000
+++ linux-2.6.7/mm/vmscan.c	2004-06-23 16:42:12.000000000 +0000
@@ -944,7 +944,7 @@
 			blk_congestion_wait(WRITE, HZ/10);
 	}
 	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
-		out_of_memory();
+		out_of_memory(gfp_mask);
 out:
 	for (i = 0; zones[i] != 0; i++)
 		zones[i]->prev_priority = zones[i]->temp_priority;
