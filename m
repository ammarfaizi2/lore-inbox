Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUGHQYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUGHQYr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 12:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUGHQYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 12:24:47 -0400
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:9688 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261987AbUGHQYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 12:24:39 -0400
Message-ID: <40ED7534.4010409@kolivas.org>
Date: Fri, 09 Jul 2004 02:24:20 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: ck kernel mailing list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Autotune swappiness
References: <40EC13C5.2000101@kolivas.org>	<40EC1930.7010805@comcast.net>	<40EC1B0A.8090802@kolivas.org>	<20040707213822.2682790b.akpm@osdl.org>	<cone.1089268800.781084.4554.502@pc.kolivas.org>	<20040708001027.7fed0bc4.akpm@osdl.org>	<cone.1089273505.418287.4554.502@pc.kolivas.org> <20040708010842.2064a706.akpm@osdl.org>
In-Reply-To: <20040708010842.2064a706.akpm@osdl.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE80D0637B3AA7B3664C25A6D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE80D0637B3AA7B3664C25A6D
Content-Type: multipart/mixed;
 boundary="------------050409050306060907020205"

This is a multi-part message in MIME format.
--------------050409050306060907020205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is another try at providing feedback to tune the vm_swappiness.

This patch tries to tune it dynamically according to the mapped_ratio. 
After some consideration I thought it would be easiest to simply remove 
the vm_swappiness tunable entirely, since that is the point of this patch.

Some in the field modelling and testing showed a biased downwards 
feedback based on the mapped ratio provided good performance under 
different workloads especially improving the desktop experience. The 
practical upshot of this is the machine will only ever swap very lightly 
while the percentage of mapped pages is low and allow more generous 
swapping as the percentage rises within the higher ranges.

The earlier design of this patch was much more complicated and the 
practical upshot of it was that it would make

vm_swappiness = mapped_ratio * mapped_ratio / 100


This had it's effect on the swappiness value in the setting of 
swap_tendency which was:

swap_tendency = mapped_ratio / 2 + distress + vm_swappiness


A close approximation was to make vm_swappiness a range of 0-150 instead 
of 100 and simplify swap tendency to be equal to this:

swap_tendency = distress + vm_swappiness


A follow up patch will use the vm_swappiness value to alter the rate of 
page inactivation as well, but for the moment I'll offer this one change 
for comments.

Patch applies to 2.6.7-mm6
Signed-off-by: Con Kolivas <kernel@kolivas.org>

  include/linux/swap.h   |    1 -
  include/linux/sysctl.h |   15 +++++++--------
  kernel/sysctl.c        |   11 -----------
  mm/vmscan.c            |   15 ++++++++-------
  4 files changed, 15 insertions(+), 27 deletions(-)


--------------050409050306060907020205
Content-Type: text/x-patch;
 name="autotune_swappiness.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autotune_swappiness.diff"

Index: linux-2.6.7-mm6/include/linux/swap.h
===================================================================
--- linux-2.6.7-mm6.orig/include/linux/swap.h	2004-07-09 02:15:07.509902884 +1000
+++ linux-2.6.7-mm6/include/linux/swap.h	2004-07-09 02:15:10.949349575 +1000
@@ -174,7 +174,6 @@
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
-extern int vm_swappiness;
 
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
Index: linux-2.6.7-mm6/include/linux/sysctl.h
===================================================================
--- linux-2.6.7-mm6.orig/include/linux/sysctl.h	2004-07-09 02:15:07.509902884 +1000
+++ linux-2.6.7-mm6/include/linux/sysctl.h	2004-07-09 02:15:10.950349415 +1000
@@ -157,14 +157,13 @@
 	VM_OVERCOMMIT_RATIO=16, /* percent of RAM to allow overcommit in */
 	VM_PAGEBUF=17,		/* struct: Control pagebuf parameters */
 	VM_HUGETLB_PAGES=18,	/* int: Number of available Huge Pages */
-	VM_SWAPPINESS=19,	/* Tendency to steal mapped memory */
-	VM_LOWER_ZONE_PROTECTION=20,/* Amount of protection of lower zones */
-	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
-	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of mmaps/address-space */
-	VM_LAPTOP_MODE=23,	/* vm laptop mode */
-	VM_BLOCK_DUMP=24,	/* block dump mode */
-	VM_HUGETLB_GROUP=25,	/* permitted hugetlb group */
-	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
+	VM_LOWER_ZONE_PROTECTION=19,/* Amount of protection of lower zones */
+	VM_MIN_FREE_KBYTES=20,	/* Minimum free kilobytes to maintain */
+	VM_MAX_MAP_COUNT=21,	/* int: Maximum number of mmaps/address-space */
+	VM_LAPTOP_MODE=22,	/* vm laptop mode */
+	VM_BLOCK_DUMP=23,	/* block dump mode */
+	VM_HUGETLB_GROUP=24,	/* permitted hugetlb group */
+	VM_VFS_CACHE_PRESSURE=25, /* dcache/icache reclaim pressure */
 };
 
 
Index: linux-2.6.7-mm6/kernel/sysctl.c
===================================================================
--- linux-2.6.7-mm6.orig/kernel/sysctl.c	2004-07-09 02:15:07.496904975 +1000
+++ linux-2.6.7-mm6/kernel/sysctl.c	2004-07-09 02:15:10.951349254 +1000
@@ -700,17 +700,6 @@
 		.mode		= 0444 /* read-only*/,
 		.proc_handler	= &proc_dointvec,
 	},
-	{
-		.ctl_name	= VM_SWAPPINESS,
-		.procname	= "swappiness",
-		.data		= &vm_swappiness,
-		.maxlen		= sizeof(vm_swappiness),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec_minmax,
-		.strategy	= &sysctl_intvec,
-		.extra1		= &zero,
-		.extra2		= &one_hundred,
-	},
 #ifdef CONFIG_HUGETLB_PAGE
 	 {
 		.ctl_name	= VM_HUGETLB_PAGES,
Index: linux-2.6.7-mm6/mm/vmscan.c
===================================================================
--- linux-2.6.7-mm6.orig/mm/vmscan.c	2004-07-09 02:15:07.495905136 +1000
+++ linux-2.6.7-mm6/mm/vmscan.c	2004-07-09 02:15:21.366673884 +1000
@@ -116,9 +116,9 @@
 #endif
 
 /*
- * From 0 .. 100.  Higher means more swappy.
+ * From 0 .. 150.  Higher means more swappy.
  */
-int vm_swappiness = 60;
+static int vm_swappiness = 0;
 static long total_memory;
 
 static LIST_HEAD(shrinker_list);
@@ -690,17 +690,18 @@
 	 * is mapped.
 	 */
 	mapped_ratio = (sc->nr_mapped * 100) / total_memory;
-
+	
 	/*
 	 * Now decide how much we really want to unmap some pages.  The mapped
-	 * ratio is downgraded - just because there's a lot of mapped memory
+	 * ratio effect is downgraded by biasing downwards the value of
+	 * vm_swappiness - just because there's a lot of mapped memory
 	 * doesn't necessarily mean that page reclaim isn't succeeding.
 	 *
 	 * The distress ratio is important - we don't want to start going oom.
-	 *
-	 * A 100% value of vm_swappiness overrides this algorithm altogether.
 	 */
-	swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
+	vm_swappiness = mapped_ratio * 150 / 100;
+	vm_swappiness = vm_swappiness * vm_swappiness / 150;
+	swap_tendency = distress + vm_swappiness;
 
 	/*
 	 * Now use this metric to decide whether to start moving mapped memory

--------------050409050306060907020205--

--------------enigE80D0637B3AA7B3664C25A6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7XU0ZUg7+tp6mRURAgm2AJ96vGvqrOA7C34plgMxL1I67YOMWgCfYkep
KlaC/H/+UEVyi5L4r47Y+FQ=
=h0bs
-----END PGP SIGNATURE-----

--------------enigE80D0637B3AA7B3664C25A6D--
