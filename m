Return-Path: <linux-kernel-owner+w=401wt.eu-S932403AbXAPFuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbXAPFuD (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 00:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbXAPFuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 00:50:01 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40811 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932403AbXAPFsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 00:48:24 -0500
Date: Mon, 15 Jan 2007 21:48:14 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Paul Menage <menage@google.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>, Christoph Lameter <clameter@sgi.com>
Message-Id: <20070116054814.15358.81212.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 6/8] Throttle vm writeout per cpuset
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Throttle VM writeout in a cpuset aware way

This bases the vm throttling from the reclaim path on the dirty ratio
of the cpuset. Note that a cpuset is only effective if shrink_zone is called
from direct reclaim.

kswapd has a cpuset context that includes the whole machine and will
therefore not throttle unless global limits are reached.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.20-rc5/include/linux/writeback.h
===================================================================
--- linux-2.6.20-rc5.orig/include/linux/writeback.h	2007-01-15 21:37:05.209897874 -0600
+++ linux-2.6.20-rc5/include/linux/writeback.h	2007-01-15 21:37:33.283671963 -0600
@@ -85,7 +85,7 @@ static inline void wait_on_inode(struct 
 int wakeup_pdflush(long nr_pages, nodemask_t *nodes);
 void laptop_io_completion(void);
 void laptop_sync_completion(void);
-void throttle_vm_writeout(void);
+void throttle_vm_writeout(nodemask_t *);
 
 /* These are exported to sysctl. */
 extern int dirty_background_ratio;
Index: linux-2.6.20-rc5/mm/page-writeback.c
===================================================================
--- linux-2.6.20-rc5.orig/mm/page-writeback.c	2007-01-15 21:35:28.013794159 -0600
+++ linux-2.6.20-rc5/mm/page-writeback.c	2007-01-15 21:37:33.302228293 -0600
@@ -349,12 +349,12 @@ void balance_dirty_pages_ratelimited_nr(
 }
 EXPORT_SYMBOL(balance_dirty_pages_ratelimited_nr);
 
-void throttle_vm_writeout(void)
+void throttle_vm_writeout(nodemask_t *nodes)
 {
 	struct dirty_limits dl;
 
         for ( ; ; ) {
-		get_dirty_limits(&dl, NULL, &node_online_map);
+		get_dirty_limits(&dl, NULL, nodes);
 
                 /*
                  * Boost the allowable dirty threshold a bit for page
Index: linux-2.6.20-rc5/mm/vmscan.c
===================================================================
--- linux-2.6.20-rc5.orig/mm/vmscan.c	2007-01-15 21:37:26.605346439 -0600
+++ linux-2.6.20-rc5/mm/vmscan.c	2007-01-15 21:37:33.316878027 -0600
@@ -949,7 +949,7 @@ static unsigned long shrink_zone(int pri
 		}
 	}
 
-	throttle_vm_writeout();
+	throttle_vm_writeout(&cpuset_current_mems_allowed);
 
 	atomic_dec(&zone->reclaim_in_progress);
 	return nr_reclaimed;
