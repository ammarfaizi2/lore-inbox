Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWIVSUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWIVSUf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWIVSUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:20:35 -0400
Received: from mx1.cs.washington.edu ([128.208.5.52]:50911 "EHLO
	mx1.cs.washington.edu") by vger.kernel.org with ESMTP
	id S964857AbWIVSUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:20:34 -0400
Date: Fri, 22 Sep 2006 11:20:22 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: Andrew Morton <akpm@osdl.org>
cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: [PATCH] do not free non slab allocated per_cpu_pageset
In-Reply-To: <Pine.LNX.4.64N.0609212108360.30543@attu1.cs.washington.edu>
Message-ID: <Pine.LNX.4.64N.0609221117210.5858@attu2.cs.washington.edu>
References: <1158884252.5657.38.camel@keithlap> <20060921174134.4e0d30f2.akpm@osdl.org>
 <1158888843.5657.44.camel@keithlap> <20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
 <20060921200806.523ce0b2.akpm@osdl.org> <20060922123045.d7258e13.kamezawa.hiroyu@jp.fujitsu.com>
 <20060921204629.49caa95f.akpm@osdl.org> <Pine.LNX.4.64N.0609212108360.30543@attu1.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006, David Rientjes wrote:

> The _only_ time zone_pcp is slab allocated is through process_zones().  So 
> if we have an error on kmalloc_node for that zone_pcp, all previous 
> allocations are freed and process_zones() fails for that cpu.
> 
> We are guaranteed that the process_zones() for cpu 0 succeeds, otherwise 
> the pageset notifier isn't registered.  On CPU_UP_PREPARE for cpu 4 in 
> this case, process_zones() fails because we couldn't kmalloc the 
> per_cpu_pageset and we return NOTIFY_BAD.  This prints the failed message 
> in the report and then CPU_UP_CANCELED is sent back to the notifier which 
> attempts to kfree the zone that was never kmalloc'd.
> 
> The fix will work except for the case that zone_pcp is never set to NULL 
> as it should be.
> 

As reported by Keith, the following 2.6.18 patch stops the panic 
associated with attempting to free a non slab-allocated per_cpu_pageset.

Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 mm/page_alloc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 54a4f53..e16173f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1845,8 +1845,10 @@ static inline void free_zone_pagesets(in
 	for_each_zone(zone) {
 		struct per_cpu_pageset *pset = zone_pcp(zone, cpu);
 
+		/* Free per_cpu_pageset if it is slab allocated */
+		if (pset != &boot_pageset[cpu])
+			kfree(pset);
 		zone_pcp(zone, cpu) = NULL;
-		kfree(pset);
 	}
 }
 
