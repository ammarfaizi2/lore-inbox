Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTKCAtN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 19:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTKCAtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 19:49:13 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:21195
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261877AbTKCAtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 19:49:00 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Chris Vine <chris@cvine.freeserve.co.uk>, Rik van Riel <riel@redhat.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Date: Mon, 3 Nov 2003 11:48:40 +1100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311022306.20825.chris@cvine.freeserve.co.uk>
In-Reply-To: <200311022306.20825.chris@cvine.freeserve.co.uk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oXap/8FlfKvCq7I"
Message-Id: <200311031148.40242.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_oXap/8FlfKvCq7I
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 3 Nov 2003 10:06, Chris Vine wrote:
> On Friday 31 October 2003 3:57 am, Rik van Riel wrote:
> > On Wed, 29 Oct 2003, Chris Vine wrote:
> > > However, on a low end machine (200MHz Pentium MMX uniprocessor with
> > > only 32MB of RAM and 70MB of swap) I get poor performance once
> > > extensive use is made of the swap space.
> >
> > Could you try the patch Con Kolivas posted on the 25th ?
> >
> > Subject: [PATCH] Autoregulate vm swappiness cleanup
>
> OK.  I have now done some testing.
>
> The default swappiness in the kernel (without Con's patch) is 60.  This
> gives hopeless swapping results on a 200MHz Pentium with 32MB of RAM once
> the amount of memory swapped out exceeds about 15 to 20MB.  A static
> swappiness of 10 gives results which work under load, with up to 40MB
> swapped out (I haven't tested beyond that).  Compile times with a test file
> requiring about 35MB of swap and with everything else the same are:
>
> 2.4.22 - average of 1 minute 35 seconds
> 2.6.0-test9 (swappiness 10) - average of 5 minutes 56 seconds
>
> A swappiness of 5 on the test compile causes the machine to hang in some
> kind of "won't swap/can't continue without more memory" stand-off, and a
> swappiness of 20 starts the machine thrashing to the point where I stopped
> the compile.  A swappiness of 10 would complete anything I threw at it and
> without excessive thrashing, but more slowly (and using a little more swap
> space) than 2.4.22.
>
> With Con's dynamic swappiness patch things were worse, rather than better.
> With no load, the swappiness (now read only) was around 37.  Under load
> with the test compile, swappiness went up to around 62, thrashing began,
> and after 30 minutes the compile still had not completed, swappiness had
> reached 70, and I abandoned it.

Well I was considering adding the swap pressure to this algorithm but I had 
hoped 2.6 behaved better than this under swap overload which is what appears 
to happen to yours. Can you try this patch? It takes into account swap 
pressure as well. It wont be as aggressive as setting the swappiness manually 
to 10, but unlike a swappiness of 10 it will be more useful over a wide range 
of hardware and circumstances.

Con

P.S. patches available here: http://ck.kolivas.org/patches

--Boundary-00=_oXap/8FlfKvCq7I
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="patch-test9-am-5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-test9-am-5"

--- linux-2.6.0-test8-base/kernel/sysctl.c	2003-10-20 14:16:54.000000000 +1000
+++ linux-2.6.0-test8/kernel/sysctl.c	2003-11-03 10:49:15.000000000 +1100
@@ -664,11 +664,8 @@ static ctl_table vm_table[] = {
 		.procname	= "swappiness",
 		.data		= &vm_swappiness,
 		.maxlen		= sizeof(vm_swappiness),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec_minmax,
-		.strategy	= &sysctl_intvec,
-		.extra1		= &zero,
-		.extra2		= &one_hundred,
+		.mode		= 0444 /* read-only*/,
+		.proc_handler	= &proc_dointvec,
 	},
 #ifdef CONFIG_HUGETLB_PAGE
 	 {
--- linux-2.6.0-test8-base/mm/vmscan.c	2003-10-20 14:16:54.000000000 +1000
+++ linux-2.6.0-test8/mm/vmscan.c	2003-11-03 11:38:08.542960408 +1100
@@ -47,7 +47,7 @@
 /*
  * From 0 .. 100.  Higher means more swappy.
  */
-int vm_swappiness = 60;
+int vm_swappiness = 0;
 static long total_memory;
 
 #ifdef ARCH_HAS_PREFETCH
@@ -600,6 +600,7 @@ refill_inactive_zone(struct zone *zone, 
 	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
 	struct page *page;
 	struct pagevec pvec;
+	struct sysinfo i;
 	int reclaim_mapped = 0;
 	long mapped_ratio;
 	long distress;
@@ -641,14 +642,38 @@ refill_inactive_zone(struct zone *zone, 
 	 */
 	mapped_ratio = (ps->nr_mapped * 100) / total_memory;
 
+	si_swapinfo(&i);
+	if (unlikely(!i.totalswap))
+		vm_swappiness = 0;
+	else {
+		int app_centile, swap_centile;
+
+		/*
+		 * app_centile is the percentage of physical ram used
+		 * by application pages.
+		 */
+		si_meminfo(&i);
+		app_centile = 100 - (((i.freeram + get_page_cache_size() -
+			swapper_space.nrpages) * 100) / i.totalram);
+
+		/*
+		 * swap_centile is the percentage of free swap.
+		 */
+		swap_centile = i.freeswap * 100 / i.totalswap;
+
+		/*
+		 * Autoregulate vm_swappiness to be equal to the lowest of
+		 * app_centile and swap_centile. -ck
+		 */
+		vm_swappiness = min(app_centile, swap_centile);
+	}
+
 	/*
 	 * Now decide how much we really want to unmap some pages.  The mapped
 	 * ratio is downgraded - just because there's a lot of mapped memory
 	 * doesn't necessarily mean that page reclaim isn't succeeding.
 	 *
 	 * The distress ratio is important - we don't want to start going oom.
-	 *
-	 * A 100% value of vm_swappiness overrides this algorithm altogether.
 	 */
 	swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
 

--Boundary-00=_oXap/8FlfKvCq7I--

