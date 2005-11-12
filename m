Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbVKLCUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVKLCUz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 21:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVKLCUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 21:20:55 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:63457 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750919AbVKLCUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 21:20:54 -0500
From: bob.picco@hp.com
To: akpm@osdl.org
Cc: pj@sgi.com, simon.derr@bull.net, linux-kernel@vger.kernel.org,
       bob.picco@hp.com
Message-Id: <20051112022122.22085.45247.sendpatchset@localhost.localdomain>
Subject: [PATCH] cpuset - fix return without releasing semaphore
Date: Fri, 11 Nov 2005 19:20:45 -0700 (MST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems wrong to acquire the semaphore and then return from 
cpuset_zone_allowed without releasing it.  This was only compile tested.

bob

Signed-off-by: Bob Picco <bob.picco@hp.com>

 kernel/cpuset.c |    5 +++--

 1 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.14-mm1/kernel/cpuset.c
===================================================================
--- linux-2.6.14-mm1.orig/kernel/cpuset.c	2005-11-07 07:00:13.000000000 -0500
+++ linux-2.6.14-mm1/kernel/cpuset.c	2005-11-09 17:56:28.000000000 -0500
@@ -2036,11 +2036,12 @@ int cpuset_zone_allowed(struct zone *z, 
 	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
 		return 0;
 
+	if (current->flags & PF_EXITING) /* Let dying task have memory */
+		return 1;
+
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
 	down(&callback_sem);
 
-	if (current->flags & PF_EXITING) /* Let dying task have memory */
-		return 1;
 	task_lock(current);
 	cs = nearest_exclusive_ancestor(current->cpuset);
 	task_unlock(current);
