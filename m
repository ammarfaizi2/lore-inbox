Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVKFIZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVKFIZa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVKFIZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:25:29 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:52402 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932328AbVKFIZ0 (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:25:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=4UarmlXXqEYfIE9G1oy0XXo94Wdw6NyPdnWAka+w96+n0OJ0uQki712qIeawiwZ+tgoCtptsiNhCISZ6QwtItjR7xnfvl2rkSVqBo5TMC+0APM3KZlRID2YnBQEA0RULwmShEQ0HZA9L6ZS4YaJRsnSrQxNtcElRAFZ7kTPi/lM=  ;
Message-ID: <436DBE78.3060405@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:27:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 13/14] mm: cleanup zone_pcp
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au> <436DBDA9.2040908@yahoo.com.au> <436DBDC8.5090308@yahoo.com.au> <436DBDE5.2010405@yahoo.com.au> <436DBE03.90009@yahoo.com.au> <436DBE26.5080504@yahoo.com.au> <436DBE43.1080405@yahoo.com.au> <436DBE5E.2060509@yahoo.com.au>
In-Reply-To: <436DBE5E.2060509@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------060602070305090001060303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060602070305090001060303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

13/14

-- 
SUSE Labs, Novell Inc.


--------------060602070305090001060303
Content-Type: text/plain;
 name="mm-cleanup-zone_pcp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-cleanup-zone_pcp.patch"

Use zone_pcp everywhere even though NUMA code "knows" the internal
details of the zone. Stop other people trying to copy, and it looks
nicer.

Also, only print the pagesets of online cpus in zoneinfo.

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -544,7 +544,7 @@ void drain_remote_pages(void)
 
 		local_irq_save(flags);
 		if (zone->zone_pgdat->node_id != numa_node_id()) {
-			pset = zone->pageset[smp_processor_id()];
+			pset = zone_pcp(zone, smp_processor_id());
 			if (pset->count)
 				pset->count -= free_pages_bulk(zone,
 						pset->count, &pset->list, 0);
@@ -1822,9 +1822,9 @@ static int __devinit process_zones(int c
 	for_each_zone(zone) {
 		unsigned long size, batch;
 
-		zone->pageset[cpu] = kmalloc_node(sizeof(struct per_cpu_pageset),
+		zone_pcp(zone, cpu) = kmalloc_node(sizeof(struct per_cpu_pageset),
 					 GFP_KERNEL, cpu_to_node(cpu));
-		if (!zone->pageset[cpu])
+		if (!zone_pcp(zone, cpu))
 			goto bad;
 
 		batch = zone_batchsize(zone);
@@ -1832,7 +1832,7 @@ static int __devinit process_zones(int c
 			size = batch * 32;
 		else
 			size = batch * 4;
-		setup_pageset(zone->pageset[cpu], size, batch);
+		setup_pageset(zone_pcp(zone, cpu), size, batch);
 	}
 
 	return 0;
@@ -1840,8 +1840,8 @@ bad:
 	for_each_zone(dzone) {
 		if (dzone == zone)
 			break;
-		kfree(dzone->pageset[cpu]);
-		dzone->pageset[cpu] = NULL;
+		kfree(zone_pcp(dzone, cpu));
+		zone_pcp(dzone, cpu) = NULL;
 	}
 	return -ENOMEM;
 }
@@ -1929,8 +1929,8 @@ static __devinit void zone_pcp_init(stru
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 #ifdef CONFIG_NUMA
 		/* Early boot. Slab allocator not functional yet */
-		zone->pageset[cpu] = &boot_pageset[cpu];
 		setup_pageset(&boot_pageset[cpu], 0, 0);
+		zone_pcp(zone, cpu) = &boot_pageset[cpu];
 #else
 		setup_pageset(zone_pcp(zone, cpu), batch * 32, batch);
 #endif
@@ -2172,7 +2172,7 @@ static int zoneinfo_show(struct seq_file
 		seq_printf(m,
 			   ")"
 			   "\n  pagesets");
-		for (i = 0; i < ARRAY_SIZE(zone->pageset); i++) {
+		for_each_online_cpu(i) {
 			struct per_cpu_pageset *pset;
 
 			pset = zone_pcp(zone, i);

--------------060602070305090001060303--
Send instant messages to your online friends http://au.messenger.yahoo.com 
