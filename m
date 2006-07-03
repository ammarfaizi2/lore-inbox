Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWGCV4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWGCV4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWGCV4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:56:33 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:32416 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932137AbWGCV4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:56:24 -0400
Date: Mon, 3 Jul 2006 14:56:16 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060703215616.7566.56782.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 8/8] Fix i386 SRAT check for MAX_NR_ZONES
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swap_prefetch: Make use of ZONE_HIGHMEM conditional

swap prefetch uses ZONE_HIGHMEM even if CONFIG_HIGHMEM is off. Make
that use conditional.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17.orig/mm/swap_prefetch.c	2006-07-03 13:11:06.000000000 -0700
+++ linux-2.6.17/mm/swap_prefetch.c	2006-07-03 13:12:08.000000000 -0700
@@ -277,8 +277,10 @@
 
 		ns = &sp_stat.node[z->zone_pgdat->node_id];
 		idx = zone_idx(z);
-		ns->lowfree[idx] = z->pages_high * 3 +
-			z->lowmem_reserve[ZONE_HIGHMEM];
+		ns->lowfree[idx] = z->pages_high * 3;
+#ifdef CONFIG_HIGHMEM
+		ns->lowfree[idx] += z->lowmem_reserve[ZONE_HIGHMEM];
+#endif
 		ns->highfree[idx] = ns->lowfree[idx] + z->pages_high;
 
 		if (z->free_pages > ns->highfree[idx]) {
