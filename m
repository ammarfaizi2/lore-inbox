Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbWBHP7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbWBHP7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWBHP7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:59:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47791 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965105AbWBHP73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:59:29 -0500
Date: Wed, 8 Feb 2006 07:59:14 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Bharata B Rao <bharata@in.ibm.com>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes
 2.6.16-rc1[2] on 2 node X86_64
In-Reply-To: <200602081645.24733.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602080755500.908@schroedinger.engr.sgi.com>
References: <20060205163618.GB21972@in.ibm.com> <20060208121000.GA9906@in.ibm.com>
 <Pine.LNX.4.62.0602080736510.908@schroedinger.engr.sgi.com>
 <200602081645.24733.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Andi Kleen wrote:

> On Wednesday 08 February 2006 16:42, Christoph Lameter wrote:
> 
> > However, this has implications for policy_zone. This variable should store
> > the zone that policies apply to. However, in your case this zone will vary 
> > which may lead to all sorts of weird behavior even if we fix 
> > bind_zonelist. To which zone does policy apply? ZONE_NORMAL or ZONE_DMA32?
> 
> It really needs to apply to both (currently you can't police 4GB of your 
> memory on x86-64) But I haven't worked out a good design how to implement it yet.

So a provisional solution would be to simply ignore empty zones in 
bind_zonelist? Or fall back to earlier zones (which includes unpolicied 
zones in the bind zone list?)

Index: linux-2.6.16-rc2/mm/mempolicy.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/mempolicy.c	2006-02-02 22:03:08.000000000 -0800
+++ linux-2.6.16-rc2/mm/mempolicy.c	2006-02-08 07:55:29.000000000 -0800
@@ -143,8 +143,12 @@ static struct zonelist *bind_zonelist(no
 	if (!zl)
 		return NULL;
 	num = 0;
-	for_each_node_mask(nd, *nodes)
-		zl->zones[num++] = &NODE_DATA(nd)->node_zones[policy_zone];
+	for_each_node_mask(nd, *nodes) {
+		struct zone *zone = &NODE_DATA(nd)->node_zones[policy_zone];
+
+		if (zone->present_pages)
+			zl->zones[num++] = &NODE_DATA(nd)->node_zones[policy_zone];
+	}
 	zl->zones[num] = NULL;
 	return zl;
 }
