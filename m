Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWATN6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWATN6z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 08:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWATN6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 08:58:55 -0500
Received: from 81-178-84-64.dsl.pipex.com ([81.178.84.64]:33748 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750980AbWATN6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 08:58:55 -0500
Date: Fri, 20 Jan 2006 13:58:45 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] zone_reclaim cpus_empty needs a real variable
Message-ID: <20060120135845.GA8040@shadowen.org>
References: <20060120031555.7b6d65b7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20060120031555.7b6d65b7.akpm@osdl.org>
User-Agent: Mutt/1.5.11
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zone_reclaim cpus_empty needs a real variable

On some architectures cpus_empty() attempts to take the address
of the mask.  Consequently we must store the result of the
node_to_cpumask() before applying it.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 vmscan.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
diff -upN reference/mm/vmscan.c current/mm/vmscan.c
--- reference/mm/vmscan.c
+++ current/mm/vmscan.c
@@ -1836,18 +1836,21 @@ int zone_reclaim(struct zone *zone, gfp_
 	struct task_struct *p = current;
 	struct reclaim_state reclaim_state;
 	struct scan_control sc;
+	cpumask_t mask;
 
 	if (time_before(jiffies,
 		zone->last_unsuccessful_zone_reclaim + ZONE_RECLAIM_INTERVAL))
 			return 0;
 
 	if (!(gfp_mask & __GFP_WAIT) ||
-		(!cpus_empty(node_to_cpumask(zone->zone_pgdat->node_id)) &&
-			 zone->zone_pgdat->node_id != numa_node_id()) ||
 		zone->all_unreclaimable ||
 		atomic_read(&zone->reclaim_in_progress) > 0)
 			return 0;
 
+	mask = node_to_cpumask(zone->zone_pgdat->node_id);
+	if (!cpus_empty(mask) && zone->zone_pgdat->node_id != numa_node_id())
+		return 0;
+
 	sc.may_writepage = 0;
 	sc.may_swap = 0;
 	sc.nr_scanned = 0;
