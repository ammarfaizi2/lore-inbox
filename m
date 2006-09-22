Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWIVDIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWIVDIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 23:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWIVDIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 23:08:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932241AbWIVDIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 23:08:15 -0400
Date: Thu, 21 Sep 2006 20:08:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: kmannth@us.ibm.com, linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: [BUG] i386 2.6.18 cpu_up: attempt to bring up CPU 4 failed :
 kernel BUG at mm/slab.c:2698!
Message-Id: <20060921200806.523ce0b2.akpm@osdl.org>
In-Reply-To: <20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
References: <1158884252.5657.38.camel@keithlap>
	<20060921174134.4e0d30f2.akpm@osdl.org>
	<1158888843.5657.44.camel@keithlap>
	<20060922112427.d5f3aef6.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 11:24:27 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> On Thu, 21 Sep 2006 18:34:03 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> 
> > That unhappy caller in the chain is cpuup_callback in mm/slab.c.  I am
> > still working out as to why, there is a lot going on if this function. 
> > 
> > > b) pageset_cpuup_callback()'s CPU_UP_CANCELED path possibly hasn't been
> > >    tested before.  I'd be guessing that we're not zeroing out the
> > >    zone.pageset[] array when the `struct zone' is first allocated, but I
> > >    don't immediately recall where that code lives.
> > 
> 
> How about here ?
> == at boot time in mm/page_alloc.c ==
> free_area_init_core()
> 	->zone_pcp_init(zone);
>         for (cpu = 0; cpu < NR_CPUS; cpu++) {
> #ifdef CONFIG_NUMA
>                 /* Early boot. Slab allocator not functional yet */
>                 zone_pcp(zone, cpu) = &boot_pageset[cpu];
>                 setup_pageset(&boot_pageset[cpu],0);
> #else
>                 setup_pageset(zone_pcp(zone,cpu), batch);
> #endif
>         }
> ==================
> 
> Not zero-cleared.
> 

Actually, I'd point the finger at process_zones().  If that kmalloc()
fails, we leave garbage in the entries for the remaining zones.  But
free_zone_pagesets() kfrees all of them, uncluding the garbage pointers.

So something like...

--- a/mm/page_alloc.c~a
+++ a/mm/page_alloc.c
@@ -1811,11 +1811,14 @@ static struct per_cpu_pageset boot_pages
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
@@ -1824,17 +1827,16 @@ static int __cpuinit process_zones(int c
 
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
+	for_each_zone(zone) {
+		kfree(zone_pcp(zone, cpu));
+		zone_pcp(zone, cpu) = NULL;
 	}
+	printk(KERN_EMERG "%s: kmalloc() failed\n", __FUNCTION__);
 	return -ENOMEM;
 }
 
_


But why did the kmalloc() fail?

