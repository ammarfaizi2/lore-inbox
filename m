Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWAWTcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWAWTcI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWAWTcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:32:08 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:1222 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964912AbWAWTcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:32:06 -0500
Date: Mon, 23 Jan 2006 13:32:04 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm2
Message-ID: <20060123193204.GB13532@sergelap.austin.ibm.com>
References: <20060120031555.7b6d65b7.akpm@osdl.org> <20060123184157.GA11148@sergelap.austin.ibm.com> <Pine.LNX.4.62.0601231046590.31765@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601231046590.31765@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christoph Lameter (clameter@engr.sgi.com):
> On Mon, 23 Jan 2006, Serge E. Hallyn wrote:
> 
> > I don't understand why this wouldn't die on every architecture,
> > since node_to_cpumask is an inline function.
> 
> Its an array lookup on ia64.

Oh I see, sorry, I was looking at only partial lxr ouput.

Is the following patch an ok fix?

thanks
-serge

On alpha, powerpc, and i386, node_to_cpumask is an inline function
rather than a #define to an array lookup.

--
Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.15/mm/vmscan.c
===================================================================
--- linux-2.6.15.orig/mm/vmscan.c	2006-01-23 07:14:48.000000000 -0600
+++ linux-2.6.15/mm/vmscan.c	2006-01-23 07:26:51.000000000 -0600
@@ -1836,13 +1836,15 @@ int zone_reclaim(struct zone *zone, gfp_
 	struct task_struct *p = current;
 	struct reclaim_state reclaim_state;
 	struct scan_control sc;
+	cpumask_t mask;
 
 	if (time_before(jiffies,
 		zone->last_unsuccessful_zone_reclaim + ZONE_RECLAIM_INTERVAL))
 			return 0;
 
+	mask = node_to_cpumask(zone->zone_pgdat->node_id);
 	if (!(gfp_mask & __GFP_WAIT) ||
-		(!cpus_empty(node_to_cpumask(zone->zone_pgdat->node_id)) &&
+		(!cpus_empty(mask) &&
 			 zone->zone_pgdat->node_id != numa_node_id()) ||
 		zone->all_unreclaimable ||
 		atomic_read(&zone->reclaim_in_progress) > 0)
