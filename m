Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVC0Gwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVC0Gwz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 01:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVC0Gwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 01:52:54 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:62656 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261357AbVC0Gws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 01:52:48 -0500
Date: Sat, 26 Mar 2005 22:52:21 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Simon Derr <Simon.Derr@bull.net>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20050327065222.25762.37675.sendpatchset@sam.engr.sgi.com>
Subject: [PATCH 2.6.12-rc1] cpusets special case GFP_ATOMIC allocs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stringent enforcement of cpuset memory placement could cause
the kernel to panic on a GFP_ATOMIC (!wait) memory allocation,
even though memory was available elsewhere in the system.

Relax the cpuset constraint, on the last zone loop in
mm/page_alloc.c:__alloc_pages(), for ATOMIC requests.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.12-pj/Documentation/cpusets.txt
===================================================================
--- 2.6.12-pj.orig/Documentation/cpusets.txt	2005-03-26 22:34:46.000000000 -0800
+++ 2.6.12-pj/Documentation/cpusets.txt	2005-03-26 22:34:47.000000000 -0800
@@ -262,6 +262,14 @@ that has had all its allowed CPUs or Mem
 code should reconfigure cpusets to only refer to online CPUs and Memory
 Nodes when using hotplug to add or remove such resources.
 
+There is a second exception to the above.  GFP_ATOMIC requests are
+kernel internal allocations that must be satisfied, immediately.
+The kernel may panic if such a requested page is not allocated.
+If such a request cannot be satisfied within the cpusets allowed
+memory, then we relax the cpuset boundaries and allow any page in
+the system to satisfy a GFP_ATOMIC request.  It is better to violate
+the cpuset constraints than it is to panic the kernel.
+
 To start a new job that is to be contained within a cpuset, the steps are:
 
  1) mkdir /dev/cpuset
Index: 2.6.12-pj/mm/page_alloc.c
===================================================================
--- 2.6.12-pj.orig/mm/page_alloc.c	2005-03-26 22:34:38.000000000 -0800
+++ 2.6.12-pj/mm/page_alloc.c	2005-03-26 22:47:49.000000000 -0800
@@ -780,6 +780,9 @@ __alloc_pages(unsigned int gfp_mask, uns
 	/*
 	 * Go through the zonelist again. Let __GFP_HIGH and allocations
 	 * coming from realtime tasks to go deeper into reserves
+	 *
+	 * This is the last chance, in general, before the goto nopage.
+	 * Ignore cpuset if GFP_ATOMIC (!wait) - better that than panic.
 	 */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
 		if (!zone_watermark_ok(z, order, z->pages_min,
@@ -787,7 +790,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 				       gfp_mask & __GFP_HIGH))
 			continue;
 
-		if (!cpuset_zone_allowed(z))
+		if (wait && !cpuset_zone_allowed(z))
 			continue;
 
 		page = buffered_rmqueue(z, order, gfp_mask);

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
