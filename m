Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422739AbWBOLWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbWBOLWF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 06:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBOLWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 06:22:05 -0500
Received: from mail.suse.de ([195.135.220.2]:26338 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932452AbWBOLWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 06:22:03 -0500
From: Andi Kleen <ak@suse.de>
To: bharata@in.ibm.com
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Date: Wed, 15 Feb 2006 12:21:53 +0100
User-Agent: KMail/1.8.2
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
References: <20060205163618.GB21972@in.ibm.com> <20060215054620.GA2966@in.ibm.com> <20060215103813.GD2966@in.ibm.com>
In-Reply-To: <20060215103813.GD2966@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602151221.53730.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 February 2006 11:38, Bharata B Rao wrote:

> 
> Even with this, mbind still needs to be fixed. Even though it
> can't get a conforming zone in the node (MPOL_BIND case),

It should just use lower zones then (e.g. if no ZONE_NORMAL
use ZONE_DMA32). yes that needs to be fixed.

How about the appended patch? Does it fix the problem for you?

-Andi

Handle all and empty zones when setting up custom zonelists for mbind

The memory allocator doesn't like empty zones (which have an 
uninitialized freelist), so a x86-64 system with a node fully
in GFP_DMA32 only would crash on mbind.

Fix that up by putting all possible zones as fallback into the zonelist
and skipping the empty ones.

In fact the code always enough allocated space for all zones,
but only used it for the highest. This change just uses all the
memory that was allocated before.

This should work fine for now, but whoever implements node hot removal
needs to fix this somewhere else too (or make sure zone datastructures 
by itself never go away, only their memory)

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/mm/mempolicy.c
===================================================================
--- linux.orig/mm/mempolicy.c
+++ linux/mm/mempolicy.c
@@ -132,19 +132,29 @@ static int mpol_check_policy(int mode, n
 	}
 	return nodes_subset(*nodes, node_online_map) ? 0 : -EINVAL;
 }
+
 /* Generate a custom zonelist for the BIND policy. */
 static struct zonelist *bind_zonelist(nodemask_t *nodes)
 {
 	struct zonelist *zl;
-	int num, max, nd;
+	int num, max, nd, k;
 
 	max = 1 + MAX_NR_ZONES * nodes_weight(*nodes);
-	zl = kmalloc(sizeof(void *) * max, GFP_KERNEL);
+	zl = kmalloc(sizeof(struct zone *) * max, GFP_KERNEL);
 	if (!zl)
 		return NULL;
 	num = 0;
-	for_each_node_mask(nd, *nodes)
-		zl->zones[num++] = &NODE_DATA(nd)->node_zones[policy_zone];
+	/* First put in the highest zones from all nodes, then all the next 
+	   lower zones etc. Avoid empty zones because the memory allocator
+	   doesn't like them. If you implement node hot removal you
+	   have to fix that. */
+	for (k = policy_zone; k >= 0; k--) { 
+		for_each_node_mask(nd, *nodes) { 
+			struct zone *z = &NODE_DATA(nd)->node_zones[k];
+			if (z->present_pages > 0) 
+				zl->zones[num++] = z;
+		}
+	}
 	zl->zones[num] = NULL;
 	return zl;
 }
