Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVKFIZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVKFIZI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVKFIZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:25:07 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:19798 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932328AbVKFIZE (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:25:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=JyNmCM9TiHKBoW8KTHWLMpuGceBl/RYl3sPaHWbltr+wfKb+YKfs/1fco4SvoOnNrUd0MIEfyk2JGczhRXoMkeyoIVZN2zbpyhP7yUSu71VD4pC//p7ptYLMCvZCkpTvEzxOenSj0KhdwSmvWQr1e6PAPDpy/g1GPh3ycZtFd/w=  ;
Message-ID: <436DBE5E.2060509@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:27:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 12/14] mm: variable pcp size
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au> <436DBDA9.2040908@yahoo.com.au> <436DBDC8.5090308@yahoo.com.au> <436DBDE5.2010405@yahoo.com.au> <436DBE03.90009@yahoo.com.au> <436DBE26.5080504@yahoo.com.au> <436DBE43.1080405@yahoo.com.au>
In-Reply-To: <436DBE43.1080405@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------020707000007030709090504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020707000007030709090504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

12/14

-- 
SUSE Labs, Novell Inc.


--------------020707000007030709090504
Content-Type: text/plain;
 name="mm-variable-pcp-size.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-variable-pcp-size.patch"

The previous increase in pcp list size will probably be too much for
huge NUMA machines, despite advances in keeping remote pagesets in check.
Make pcp sizes for remote zones much smaller (slightly smaller than before
the increase), and take advantage of this to increase local pcp list size
again.

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -1779,13 +1779,14 @@ static int __devinit zone_batchsize(stru
 	return batch;
 }
 
-inline void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
+static inline void setup_pageset(struct per_cpu_pageset *p,
+				unsigned long size, unsigned long batch)
 {
 	memset(p, 0, sizeof(*p));
 	p->count = 0;
 	p->cold_count = 0;
-	p->high = 16 * batch;
-	p->batch = max(1UL, 1 * batch);
+	p->high = max(1UL, size);
+	p->batch = max(1UL, batch);
 	INIT_LIST_HEAD(&p->list);
 }
 
@@ -1819,13 +1820,19 @@ static int __devinit process_zones(int c
 	struct zone *zone, *dzone;
 
 	for_each_zone(zone) {
+		unsigned long size, batch;
 
 		zone->pageset[cpu] = kmalloc_node(sizeof(struct per_cpu_pageset),
 					 GFP_KERNEL, cpu_to_node(cpu));
 		if (!zone->pageset[cpu])
 			goto bad;
 
-		setup_pageset(zone->pageset[cpu], zone_batchsize(zone));
+		batch = zone_batchsize(zone);
+		if (cpu_to_node(cpu) == zone->zone_pgdat->node_id)
+			size = batch * 32;
+		else
+			size = batch * 4;
+		setup_pageset(zone->pageset[cpu], size, batch);
 	}
 
 	return 0;
@@ -1923,9 +1930,9 @@ static __devinit void zone_pcp_init(stru
 #ifdef CONFIG_NUMA
 		/* Early boot. Slab allocator not functional yet */
 		zone->pageset[cpu] = &boot_pageset[cpu];
-		setup_pageset(&boot_pageset[cpu],0);
+		setup_pageset(&boot_pageset[cpu], 0, 0);
 #else
-		setup_pageset(zone_pcp(zone,cpu), batch);
+		setup_pageset(zone_pcp(zone, cpu), batch * 32, batch);
 #endif
 	}
 	printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%lu\n",

--------------020707000007030709090504--
Send instant messages to your online friends http://au.messenger.yahoo.com 
