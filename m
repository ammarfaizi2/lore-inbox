Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWIVSkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWIVSkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWIVSkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:40:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43931 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964880AbWIVSj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:39:59 -0400
Date: Fri, 22 Sep 2006 11:39:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Rientjes <rientjes@cs.washington.edu>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: [PATCH] do not free non slab allocated per_cpu_pageset
Message-Id: <20060922113924.014ce28f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64N.0609221117210.5858@attu2.cs.washington.edu>
References: <1158884252.5657.38.camel@keithlap>
	<20060921174134.4e0d30f2.akpm@osdl.org>
	<1158888843.5657.44.camel@keithlap>
	<20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
	<20060921200806.523ce0b2.akpm@osdl.org>
	<20060922123045.d7258e13.kamezawa.hiroyu@jp.fujitsu.com>
	<20060921204629.49caa95f.akpm@osdl.org>
	<Pine.LNX.4.64N.0609212108360.30543@attu1.cs.washington.edu>
	<Pine.LNX.4.64N.0609221117210.5858@attu2.cs.washington.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 11:20:22 -0700 (PDT)
David Rientjes <rientjes@cs.washington.edu> wrote:

> On Thu, 21 Sep 2006, David Rientjes wrote:
> 
> > The _only_ time zone_pcp is slab allocated is through process_zones().  So 
> > if we have an error on kmalloc_node for that zone_pcp, all previous 
> > allocations are freed and process_zones() fails for that cpu.
> > 
> > We are guaranteed that the process_zones() for cpu 0 succeeds, otherwise 
> > the pageset notifier isn't registered.  On CPU_UP_PREPARE for cpu 4 in 
> > this case, process_zones() fails because we couldn't kmalloc the 
> > per_cpu_pageset and we return NOTIFY_BAD.  This prints the failed message 
> > in the report and then CPU_UP_CANCELED is sent back to the notifier which 
> > attempts to kfree the zone that was never kmalloc'd.
> > 
> > The fix will work except for the case that zone_pcp is never set to NULL 
> > as it should be.
> > 
> 
> As reported by Keith, the following 2.6.18 patch stops the panic 
> associated with attempting to free a non slab-allocated per_cpu_pageset.
> 
> Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
> ---
>  mm/page_alloc.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 54a4f53..e16173f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1845,8 +1845,10 @@ static inline void free_zone_pagesets(in
>  	for_each_zone(zone) {
>  		struct per_cpu_pageset *pset = zone_pcp(zone, cpu);
>  
> +		/* Free per_cpu_pageset if it is slab allocated */
> +		if (pset != &boot_pageset[cpu])
> +			kfree(pset);
>  		zone_pcp(zone, cpu) = NULL;
> -		kfree(pset);
>  	}
>  }
>  

I think I preferred my earlier fix, recently reworked as:

--- a/mm/page_alloc.c~process_zones-fix-error-handling
+++ a/mm/page_alloc.c
@@ -1805,17 +1805,30 @@ static void setup_pagelist_highmark(stru
  */
 static struct per_cpu_pageset boot_pageset[NR_CPUS];
 
+static void free_zone_pagesets(int cpu)
+{
+	struct zone *zone;
+
+	for_each_zone(zone) {
+		kfree(zone_pcp(zone, cpu));
+		zone_pcp(zone, cpu) = NULL;
+	}
+}
+
 /*
  * Dynamically allocate memory for the
  * per cpu pageset array in struct zone.
  */
 static int __cpuinit process_zones(int cpu)
 {
-	struct zone *zone, *dzone;
+	struct zone *zone;
 
-	for_each_zone(zone) {
+	for_each_zone(zone)
+		zone_pcp(zone, cpu) = NULL;
 
-		zone_pcp(zone, cpu) = kmalloc_node(sizeof(struct per_cpu_pageset),
+	for_each_zone(zone) {
+		zone_pcp(zone, cpu) =
+			kmalloc_node(sizeof(struct per_cpu_pageset),
 					 GFP_KERNEL, cpu_to_node(cpu));
 		if (!zone_pcp(zone, cpu))
 			goto bad;
@@ -1824,32 +1837,16 @@ static int __cpuinit process_zones(int c
 
 		if (percpu_pagelist_fraction)
 			setup_pagelist_highmark(zone_pcp(zone, cpu),
-			 	(zone->present_pages / percpu_pagelist_fraction));
+			    (zone->present_pages / percpu_pagelist_fraction));
 	}
 
 	return 0;
 bad:
-	for_each_zone(dzone) {
-		if (dzone == zone)
-			break;
-		kfree(zone_pcp(dzone, cpu));
-		zone_pcp(dzone, cpu) = NULL;
-	}
+	free_zone_pagesets(cpu);
+	printk(KERN_EMERG "%s: kmalloc() failed\n", __FUNCTION__);
 	return -ENOMEM;
 }
 
-static inline void free_zone_pagesets(int cpu)
-{
-	struct zone *zone;
-
-	for_each_zone(zone) {
-		struct per_cpu_pageset *pset = zone_pcp(zone, cpu);
-
-		zone_pcp(zone, cpu) = NULL;
-		kfree(pset);
-	}
-}
-
 static int __cpuinit pageset_cpuup_callback(struct notifier_block *nfb,
 		unsigned long action,
 		void *hcpu)
_


ie:

static void free_zone_pagesets(int cpu)
{
	struct zone *zone;

	for_each_zone(zone) {
		kfree(zone_pcp(zone, cpu));
		zone_pcp(zone, cpu) = NULL;
	}
}

/*
 * Dynamically allocate memory for the
 * per cpu pageset array in struct zone.
 */
static int __cpuinit process_zones(int cpu)
{
	struct zone *zone;

	for_each_zone(zone)
		zone_pcp(zone, cpu) = NULL;

	for_each_zone(zone) {
		zone_pcp(zone, cpu) =
			kmalloc_node(sizeof(struct per_cpu_pageset),
					 GFP_KERNEL, cpu_to_node(cpu));
		if (!zone_pcp(zone, cpu))
			goto bad;

		setup_pageset(zone_pcp(zone, cpu), zone_batchsize(zone));

		if (percpu_pagelist_fraction)
			setup_pagelist_highmark(zone_pcp(zone, cpu),
			    (zone->present_pages / percpu_pagelist_fraction));
	}

	return 0;
bad:
	free_zone_pagesets(cpu);
	printk(KERN_EMERG "%s: kmalloc() failed\n", __FUNCTION__);
	return -ENOMEM;
}

It simplifies the code both from a to-look-at-it perspective and also
conceptually: it flips all the per-cpu pointers from their bootstrap state
into their kfreeable state in a single hit, rather than leaving them
holding an unknown mixture of the two.

I haven't tested it though..
