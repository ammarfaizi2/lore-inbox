Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVC1HDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVC1HDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 02:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVC1HDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 02:03:35 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:18304 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261165AbVC1HD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 02:03:28 -0500
Date: Sun, 27 Mar 2005 23:03:05 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: torvalds@osdl.org, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc1] cpusets GFP_ATOMIC fix: tonedown panic comment
Message-Id: <20050327230305.2783a353.pj@engr.sgi.com>
In-Reply-To: <424659D9.9000705@yahoo.com.au>
References: <20050327065222.25762.37675.sendpatchset@sam.engr.sgi.com>
	<424659D9.9000705@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies on top of my patch of March 26, entitled "cpusets
special case GFP_ATOMIC allocs".  It tones down my panic'y commentary.

My commentary shouldn't imply that failed GFP_ATOMICs should lead to,
or normally lead to, panics.  Even though there are a few panic()
calls following failed GFP_ATOMIC allocs, this is not the usual or
desired result of a failed GFP_ATOMIC.  The kernel will probably
drop some detail on the floor and keep on working.

Thanks to Nick Piggin for noticing (I hope this answers his point.)

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.12-pj/Documentation/cpusets.txt
===================================================================
--- 2.6.12-pj.orig/Documentation/cpusets.txt	2005-03-27 22:48:14.000000000 -0800
+++ 2.6.12-pj/Documentation/cpusets.txt	2005-03-27 22:48:22.000000000 -0800
@@ -264,11 +264,11 @@ Nodes when using hotplug to add or remov
 
 There is a second exception to the above.  GFP_ATOMIC requests are
 kernel internal allocations that must be satisfied, immediately.
-The kernel may panic if such a requested page is not allocated.
-If such a request cannot be satisfied within the cpusets allowed
-memory, then we relax the cpuset boundaries and allow any page in
-the system to satisfy a GFP_ATOMIC request.  It is better to violate
-the cpuset constraints than it is to panic the kernel.
+The kernel may drop some request, in rare cases even panic, if a
+GFP_ATOMIC alloc fails.  If the request cannot be satisfied within
+the current tasks cpuset, then we relax the cpuset, and look for
+memory anywhere we can find it.  It's better to violate the cpuset
+than stress the kernel.
 
 To start a new job that is to be contained within a cpuset, the steps are:
 
Index: 2.6.12-pj/mm/page_alloc.c
===================================================================
--- 2.6.12-pj.orig/mm/page_alloc.c	2005-03-27 22:48:14.000000000 -0800
+++ 2.6.12-pj/mm/page_alloc.c	2005-03-27 22:48:42.000000000 -0800
@@ -782,7 +782,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 	 * coming from realtime tasks to go deeper into reserves
 	 *
 	 * This is the last chance, in general, before the goto nopage.
-	 * Ignore cpuset if GFP_ATOMIC (!wait) - better that than panic.
+	 * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
 	 */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
 		if (!zone_watermark_ok(z, order, z->pages_min,


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
