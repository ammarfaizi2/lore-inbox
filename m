Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbTDQUf4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTDQUf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:35:56 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:7710 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S262600AbTDQUfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:35:54 -0400
Date: Thu, 17 Apr 2003 21:49:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Joern Engel <joern@wohnheim.fh-wedel.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] stop swapoff 3/3 OOMkill
In-Reply-To: <Pine.LNX.4.44.0304172142530.2039-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0304172147330.2039-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current behaviour is that once swapoff has filled memory, other tasks
get OOMkilled one by one until it completes, or more likely hangs.
Better that swapoff be the first choice for OOMkill.

I feel a little ashamed of adding another PF_flag for this, and it
may be done in other ways; but I've found none compellingly elegant.
And it would be enough for sys_swapoff to return failure rather than
be killed (along with any other tasks sharing its mm); but the OOMkill
mechanism gets the job done, I don't think we need complicate it.

--- swapoff2/include/linux/sched.h	Mon Apr 14 13:05:34 2003
+++ swapoff3/include/linux/sched.h	Thu Apr 17 18:33:00 2003
@@ -477,6 +477,7 @@
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
 #define PF_KSWAPD	0x00040000	/* I am kswapd */
+#define PF_SWAPOFF	0x00080000	/* I am in swapoff */
 
 #if CONFIG_SMP
 extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
--- swapoff2/mm/oom_kill.c	Tue Mar 25 08:06:56 2003
+++ swapoff3/mm/oom_kill.c	Thu Apr 17 18:33:00 2003
@@ -129,6 +129,8 @@
 				chosen = p;
 				maxpoints = points;
 			}
+			if (p->flags & PF_SWAPOFF)
+				return p;
 		}
 	while_each_thread(g, p);
 	return chosen;
--- swapoff2/mm/swapfile.c	Thu Apr 17 18:32:50 2003
+++ swapoff3/mm/swapfile.c	Thu Apr 17 18:33:00 2003
@@ -1060,7 +1060,9 @@
 	total_swap_pages -= p->pages;
 	p->flags &= ~SWP_WRITEOK;
 	swap_list_unlock();
+	current->flags |= PF_SWAPOFF;
 	err = try_to_unuse(type);
+	current->flags &= ~PF_SWAPOFF;
 	if (err) {
 		/* re-insert swap space back into swap_list */
 		swap_list_lock();

