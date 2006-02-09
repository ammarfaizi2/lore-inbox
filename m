Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWBIEfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWBIEfE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 23:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbWBIEfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 23:35:04 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:40414 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161020AbWBIEfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 23:35:02 -0500
Date: Thu, 9 Feb 2006 10:09:33 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Message-ID: <20060209043933.GA2986@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20060205163618.GB21972@in.ibm.com> <200602081645.24733.ak@suse.de> <Pine.LNX.4.62.0602080755500.908@schroedinger.engr.sgi.com> <200602081706.26853.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602081706.26853.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 05:06:26PM +0100, Andi Kleen wrote:
> On Wednesday 08 February 2006 16:59, Christoph Lameter wrote:
> > On Wed, 8 Feb 2006, Andi Kleen wrote:
> > 
> > > On Wednesday 08 February 2006 16:42, Christoph Lameter wrote:
> > > 
> > > > However, this has implications for policy_zone. This variable should store
> > > > the zone that policies apply to. However, in your case this zone will vary 
> > > > which may lead to all sorts of weird behavior even if we fix 
> > > > bind_zonelist. To which zone does policy apply? ZONE_NORMAL or ZONE_DMA32?
> > > 
> > > It really needs to apply to both (currently you can't police 4GB of your 
> > > memory on x86-64) But I haven't worked out a good design how to implement it yet.
> > 
> > So a provisional solution would be to simply ignore empty zones in 
> > bind_zonelist?
> 
> That would likely prevent the crash yes (Bharata can you test?)

With this solution, the kernel doesn't crash, but the application does.

Shouldn't we fail mbind if we can't bind any zones ?
Something like this...


Signed-off-by: Bharata B Rao <bharata@in.ibm.com>

--- linux-2.6.16-rc2/mm/mempolicy.c.orig	2006-02-09 01:34:37.000000000 -0800
+++ linux-2.6.16-rc2/mm/mempolicy.c	2006-02-09 01:39:32.000000000 -0800
@@ -143,8 +143,18 @@
 	if (!zl)
 		return NULL;
 	num = 0;
-	for_each_node_mask(nd, *nodes)
-		zl->zones[num++] = &NODE_DATA(nd)->node_zones[policy_zone];
+	for_each_node_mask(nd, *nodes) {
+		struct zone *zone = &NODE_DATA(nd)->node_zones[policy_zone];
+
+		if (zone->present_pages)
+			zl->zones[num++] = zone;
+	}
+
+	if (!num) {
+		/* failed to bind even a single zone */
+		kfree(zl);
+		return NULL;
+	}
 	zl->zones[num] = NULL;
 	return zl;
 }

> 
> But of course it still has the problem of a lot of memory being unpolicied
> on machines with >4GB if there's both DMA32 and NORMAL.
> 
> > Or fall back to earlier zones (which includes unpolicied  
> > zones in the bind zone list?)
> 

Does it make sense to have a separate policy_zone for each node so that we
have atleast one(highest) zone in a node which comes under memory policy ?

Regards,
Bharata.
