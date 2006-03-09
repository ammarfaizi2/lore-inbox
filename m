Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932674AbWCIEg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbWCIEg3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbWCIEg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:36:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:7042 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932674AbWCIEg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:36:27 -0500
Date: Wed, 8 Mar 2006 20:36:20 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: No zone_reclaim if PF_MALLOC is set.
Message-ID: <Pine.LNX.4.64.0603082027450.12877@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the process has already set PF_MALLOC and is already using
current->reclaim_state then do not try to reclaim memory from the zone.
This is set by kswapd and/or synchrononous global reclaim which will not
take it lightly if we zap the reclaim_state.

Signed-off-by: Christoph Lameter <clameter@sig.com>

Index: linux-2.6.16-rc5/mm/vmscan.c
===================================================================
--- linux-2.6.16-rc5.orig/mm/vmscan.c	2006-02-26 21:09:35.000000000 -0800
+++ linux-2.6.16-rc5/mm/vmscan.c	2006-03-08 20:35:47.000000000 -0800
@@ -1883,7 +1883,8 @@ int zone_reclaim(struct zone *zone, gfp_
 
 	if (!(gfp_mask & __GFP_WAIT) ||
 		zone->all_unreclaimable ||
-		atomic_read(&zone->reclaim_in_progress) > 0)
+		atomic_read(&zone->reclaim_in_progress) > 0 ||
+		(p->flags & PF_MEMALLOC))
 			return 0;
 
 	node_id = zone->zone_pgdat->node_id;
