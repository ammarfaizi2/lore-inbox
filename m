Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbUITLzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUITLzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUITLzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:55:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49573 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266316AbUITLy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:54:57 -0400
Date: Mon, 20 Sep 2004 07:33:12 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Max Michaels <mmichaels@rightmedia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-r1 mem issues
Message-ID: <20040920103312.GA2089@logos.cnet>
References: <0FC82FC6709BE34CB9118EE0E252FD2307994E70@ehost007.exch005intermedia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <0FC82FC6709BE34CB9118EE0E252FD2307994E70@ehost007.exch005intermedia.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 19, 2004 at 04:20:48PM -0700, Max Michaels wrote:
> This is my first post, so please be forgiving of any faux-pas. I am
> having issues with 2.6.8-r1 with memory being eaten by the kernel. Top
> reveals that only about 35% of the memory (3GB) is being used but the
> actual count of free memory is only about 10MB. /proc/slabinfo shows no
> odd numbers and /proc/meminfo shows the same 10MB as the top total. No
> processes account for this memory, so I'm assuming it must be the
> kernel. Eventually, I run out of memory and OOM-killer starts killing
> processes until it has some memory. Is there some troubleshooting method
> I am missing or is this a known issue?

Hi Max,

Please try 2.6.9-rc2-mm1 and see if you can reproduce the problem there. 

If you can, please apply the attached patch and wait for the OOM killer to trigger.

Doing so will show us how many swap pages were free at the moment of the killing,
if there was swap space available there's something wrong.


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vm-reclaim2.patch"

--- mm/page_alloc.c.orig	2004-08-24 20:37:53.000000000 -0300
+++ mm/page_alloc.c	2004-08-24 22:51:49.498375608 -0300
@@ -1021,11 +1021,12 @@
 void show_free_areas(void)
 {
 	struct page_state ps;
-	int cpu, temperature;
+	int cpu, temperature, i;
 	unsigned long active;
 	unsigned long inactive;
 	unsigned long free;
 	struct zone *zone;
+	unsigned int swap_pages = 0;
 
 	for_each_zone(zone) {
 		show_node(zone);
@@ -1086,6 +1087,8 @@
 			" active:%lukB"
 			" inactive:%lukB"
 			" present:%lukB"
+			" pages_scanned:%lu"
+			" all_unreclaimable? %s"
 			"\n",
 			zone->name,
 			K(zone->free_pages),
@@ -1094,7 +1097,9 @@
 			K(zone->pages_high),
 			K(zone->nr_active),
 			K(zone->nr_inactive),
-			K(zone->present_pages)
+			K(zone->present_pages),
+			zone->pages_scanned,
+			(zone->all_unreclaimable ? "yes" : "no")
 			);
 		printk("protections[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
@@ -1125,6 +1130,18 @@
 		printk("= %lukB\n", K(total));
 	}
 
+	swap_list_lock();
+	for (i = 0; i < nr_swapfiles; i++) {
+		if (!(swap_info[i].flags & SWP_USED) ||
+		     (swap_info[i].flags & SWP_WRITEOK))
+                       continue;
+		swap_pages += swap_info[i].inuse_pages;
+	}
+	swap_pages += nr_swap_pages;
+	swap_list_unlock();
+
+	printk("nr_free_swap_pages: %u\n", swap_pages);
+
 	show_swap_cache_info();
 }
 

--AhhlLboLdkugWU4S--
