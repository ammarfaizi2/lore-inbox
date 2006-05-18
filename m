Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWEREg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWEREg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 00:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWEREg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 00:36:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17586 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750935AbWEREgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 00:36:14 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Paul Jackson <pj@sgi.com>
Date: Wed, 17 May 2006 21:36:07 -0700
Message-Id: <20060518043607.15898.97283.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com>
References: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 03/03] Cpuset: might_sleep_if check in cpuset_zones_allowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

It's too easy to incorrectly call cpuset_zone_allowed() in an
atomic context without __GFP_HARDWALL set, and when done, it is
not noticed until a tight memory situation forces allocations
to be tried outside the current cpuset.

Add a 'might_sleep_if()' check, to catch this earlier on, instead
of waiting for a similar check in the mutex_lock() code, which
is only rarely invoked.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |    1 +
 1 file changed, 1 insertion(+)

--- 2.6.17-rc4-mm1.orig/kernel/cpuset.c	2006-05-17 20:31:22.577065566 -0700
+++ 2.6.17-rc4-mm1/kernel/cpuset.c	2006-05-17 20:31:36.261218192 -0700
@@ -2261,6 +2261,7 @@ int __cpuset_zone_allowed(struct zone *z
 	if (in_interrupt())
 		return 1;
 	node = z->zone_pgdat->node_id;
+	might_sleep_if(!(gfp_mask & __GFP_HARDWALL));
 	if (node_isset(node, current->mems_allowed))
 		return 1;
 	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
