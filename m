Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbVLHBOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbVLHBOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 20:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVLHBOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 20:14:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28851 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750939AbVLHBOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 20:14:45 -0500
Date: Wed, 7 Dec 2005 17:14:34 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH] swap migration: Fix lru drain
In-Reply-To: <20051207165730.02dc591e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0512071706001.26471@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0512071351010.25527@schroedinger.engr.sgi.com>
 <20051207161319.6ada5c33.akpm@osdl.org> <Pine.LNX.4.62.0512071635250.26288@schroedinger.engr.sgi.com>
 <20051207165730.02dc591e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Andrew Morton wrote:

> I'll change this to return 0 on success, or -ENOMEM.  Bit more
> conventional, no?

Ok. That also allows the addition of other error conditions in the future.
Need to revise isolate_lru_page to reflect that.

Index: linux-2.6.15-rc5-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/mm/vmscan.c	2005-12-06 18:03:24.000000000 -0800
+++ linux-2.6.15-rc5-mm1/mm/vmscan.c	2005-12-07 17:11:58.000000000 -0800
@@ -1038,8 +1038,8 @@ redo:
 		 * Maybe this page is still waiting for a cpu to drain it
 		 * from one of the lru lists?
 		 */
-		schedule_on_each_cpu(lru_add_drain_per_cpu, NULL);
-		if (PageLRU(page))
+		rc = schedule_on_each_cpu(lru_add_drain_per_cpu, NULL);
+		if (rc == 0 && PageLRU(page))
 			goto redo;
 	}
 	return rc;
Index: linux-2.6.15-rc5-mm1/kernel/workqueue.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/workqueue.c	2005-12-07 16:38:54.000000000 -0800
+++ linux-2.6.15-rc5-mm1/kernel/workqueue.c	2005-12-07 17:13:04.000000000 -0800
@@ -432,7 +432,7 @@ int schedule_on_each_cpu(void (*func) (v
 	work = kmalloc(NR_CPUS * sizeof(struct work_struct), GFP_KERNEL);
 
 	if (!work)
-		return 0;
+		return -ENOMEM;
 	for_each_online_cpu(cpu) {
 		INIT_WORK(work + cpu, func, info);
 		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
@@ -440,7 +440,7 @@ int schedule_on_each_cpu(void (*func) (v
 	}
 	flush_workqueue(keventd_wq);
 	kfree(work);
-	return 1;
+	return 0;
 }
 
 void flush_scheduled_work(void)

