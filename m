Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131414AbRC0Q5N>; Tue, 27 Mar 2001 11:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131429AbRC0Q5D>; Tue, 27 Mar 2001 11:57:03 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:42739 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131414AbRC0Q4w>; Tue, 27 Mar 2001 11:56:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [PATCH] vmtime and vm balancing
Date: Tue, 27 Mar 2001 11:56:10 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01032711561000.01000@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch introduces the idea of vmtime.  vmtime is time as the 
vm percieves it.  Its advanced by memory pressure, which in the end, works 
out to be the page allocation & reclaim rate.  With this figure I attempt to solve 
two problems.

First I slow down the background page scanning to the rate we are allocating
pages.  This means that an idle machine will not end up with all page ages
equal nearly as quickly.  It should also help prevent cases where kswapd
eats too much cpu.  The other effect should be to prevent or reduce some 
swap out spikes.

Second, I add some slab cache pressure.  Without the patch the icache and 
dcache will get shrunk in under extreme cases.  From comments on mm 
list (and personal experience) the slab cache can grow and end up causing
paging when it would make more sense to just shrink it.  This also has
oom implications since the size of the slab cache, and the possible space
we can free from it, are not accounted for in the oom test.  In any case
the patch should help keep this storage under control.  Are there any other
parts of the slab cache we should think about shrinking?

This has survived the night on my box with printk(s) in the if(s) to verify
its actually working.  It should apply to pre8 and ac25/ac26.   The vmscan.c
change made by ac26 should not hurt this patch but may make it age
pages a bit more aggressivily.

We need to find out if this helps.  Reports on what effect this has would
be very welcome.  Rik has looked at the patch and wants to see some
feedback...

Comments on style or bugs very welcome.

---
--- linux/mm/vmscan.c.ac26	Tue Mar 27 10:02:52 2001
+++ linux/mm/vmscan.c	Tue Mar 27 10:08:14 2001
@@ -985,22 +985,51 @@
 	for (;;) {
 		static int recalc = 0;
 
+		/* vmtime tracks time as the vm precieves it.
+		 * It is advanced depending on the ammount of
+		 * memory pressure.
+		 */
+		static int vmtime = 0;	
+		static int bgscan_required = 0;
+		static int slab_scan_required = 0;
+
 		/* If needed, try to free some memory. */
 		if (inactive_shortage() || free_shortage()) 
 			do_try_to_free_pages(GFP_KSWAPD, 0);
 
 		/*
 		 * Do some (very minimal) background scanning. This
-		 * will scan all pages on the active list once
-		 * every minute. This clears old referenced bits
-		 * and moves unused pages to the inactive list.
+		 * tries to scan all pages on the active list at the 
+		 * rate pages are allocated. This clears old referenced
+		 * bits and moves unused pages to the inactive list.
+		 */
+		if (vmtime > bgscan_required ) {
+			refill_inactive_scan(DEF_PRIORITY, 0);
+			bgscan_required = vmtime + (nr_active_pages >> INACTIVE_SHIFT);
+		}
+
+		/* 
+		 * Here we apply some pressure to the slab cache.  We
+		 * apply more pressure as it gets bigger.  This would
+		 * be cleaner if there was a nr_slab_pages...
 		 */
-		refill_inactive_scan(DEF_PRIORITY, 0);
+		if (vmtime > slab_scan_required) {
+			shrink_dcache_memory(DEF_PRIORITY, GFP_KSWAPD);
+			shrink_icache_memory(DEF_PRIORITY, GFP_KSWAPD);
+			kmem_cache_reap(GFP_KSWAPD);
+	 		slab_scan_required = vmtime + num_physpages - nr_free_pages() - atomic_read(&page_cache_size) - atomic_read(&buffermem_pages); 
+		}
 
-		/* Once a second, recalculate some VM stats. */
+		/* Once a second, recalculate some VM stats and the vmtime. */
 		if (time_after(jiffies, recalc + HZ)) {
 			recalc = jiffies;
-			recalculate_vm_stats();
+	 		recalculate_vm_stats();
+			vmtime += (memory_pressure >> INACTIVE_SHIFT); 
+			if (vmtime > INT_MAX - num_physpages) {
+				vmtime = 0;
+				bgscan_required = 0;
+				slab_scan_required = 0;
+			}
 		}
 
 		run_task_queue(&tq_disk);
---

Ed Tomlinson <tomlins@cam.org>

