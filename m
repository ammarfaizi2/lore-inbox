Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWDCFMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWDCFMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWDCFMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:12:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30947 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751387AbWDCFMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:12:47 -0400
Date: Sun, 2 Apr 2006 22:12:29 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Sonny Rao <sonny@burdell.org>
cc: ak@suse.com, Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
In-Reply-To: <20060402213216.2e61b74e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
References: <20060402213216.2e61b74e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Apr 2006, Andrew Morton wrote:

> I have a vague feeling that you guys worked on numastat?

This is mostly Andi's code although I added the zone_pcp() stuff. This is 
failing because zone_pcp() only returns valid information for online 
processors.

Initially all zone_pcps() point to the boot_cpuset (see zone_pcp_init)
and therefore zone_pcp) is always valid and we do not see this bug. But 
if someone downs a processor or a processor dies then free_zone_pageset() 
is called which will set zone_pcp() = NULL.


Fix NULL pointer dereference in node_read_numastat()

zone_pcp() only returns valid values if the processor is online.

Change node_read_numastat() to only scan online processors.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.16/drivers/base/node.c
===================================================================
--- linux-2.6.16.orig/drivers/base/node.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16/drivers/base/node.c	2006-04-02 21:59:49.000000000 -0700
@@ -106,7 +106,7 @@ static ssize_t node_read_numastat(struct
 	other_node = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zone *z = &pg->node_zones[i];
-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		for_each_online_cpu(cpu) {
 			struct per_cpu_pageset *ps = zone_pcp(z,cpu);
 			numa_hit += ps->numa_hit;
 			numa_miss += ps->numa_miss;

