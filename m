Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265810AbUGHGqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUGHGqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 02:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265813AbUGHGqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 02:46:24 -0400
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:18151 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265810AbUGHGqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:46:04 -0400
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net> <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org> <cone.1089268800.781084.4554.502@pc.kolivas.org>
Message-ID: <cone.1089269144.63871.4554.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, nigelenki@comcast.net,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: Autoregulate swappiness & inactivation
Date: Thu, 08 Jul 2004 16:45:44 +1000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_pc.kolivas.org-1089269144-0000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_pc.kolivas.org-1089269144-0000
Content-Type: multipart/signed;
    boundary="=_mimegpg-pc.kolivas.org-4554-1089269144-0011";
    micalg=pgp-sha1; protocol="application/pgp-signature"

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-pc.kolivas.org-4554-1089269144-0011
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Con Kolivas writes:

> Andrew Morton writes:
> 
>> Con Kolivas <kernel@kolivas.org> wrote:
>>>
>>> > How about autoregulated swappiness, which seems to be very efficient at
>>>  > its job?
>>> 
>>>  It's been around for quite a while, and akpm has not expressed any 
>>>  interest in it so I think this will only ever flounder in the -ck domain.
>> 
>> Nobody sent me the patch.  And the
>> justification/explanation/sales-brochure.  And the benchmarks...
> 
> Ah what the heck. They can only be knocked back to where they already are.

Hmm the second patch doesn't appear complete against mm6. I'll have to 
re-create it once I can look at the code at home. Here is the version 
against vanilla so you can see what it's supposed to do. Apologies.

Con

--=_mimegpg-pc.kolivas.org-4554-1089269144-0011
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA7O2YZUg7+tp6mRURAqn5AJ9bkgM/1xdTAxBtzJrLKr+XldB7yACfbRKB
/D+0DsdY9A2p8CGF24VdrHk=
=fLBa
-----END PGP SIGNATURE-----

--=_mimegpg-pc.kolivas.org-4554-1089269144-0011--

--=_pc.kolivas.org-1089269144-0000
Content-Type: multipart/signed;
    boundary="=_mimegpg-pc.kolivas.org-4554-1089269144-0012";
    micalg=pgp-sha1; protocol="application/pgp-signature"

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-pc.kolivas.org-4554-1089269144-0012
Content-Description: vm_autoregulate
Content-Disposition: inline;
  FILENAME="vm_autoregulate2.diff"
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Index: linux-2.6.7-ck/include/linux/swap.h
===================================================================
--- linux-2.6.7-ck.orig/include/linux/swap.h	2004-07-01 19:41:13.375151780 +1000
+++ linux-2.6.7-ck/include/linux/swap.h	2004-07-01 19:41:30.134517540 +1000
@@ -175,7 +175,7 @@
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
-extern int auto_swappiness;
+extern int vm_autoregulate;
 
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
Index: linux-2.6.7-ck/include/linux/sysctl.h
===================================================================
--- linux-2.6.7-ck.orig/include/linux/sysctl.h	2004-07-01 19:41:13.376151623 +1000
+++ linux-2.6.7-ck/include/linux/sysctl.h	2004-07-01 19:41:30.136517226 +1000
@@ -166,7 +166,7 @@
 	VM_LAPTOP_MODE=23,	/* vm laptop mode */
 	VM_BLOCK_DUMP=24,	/* block dump mode */
 	VM_HUGETLB_GROUP=25,	/* permitted hugetlb group */
-	VM_AUTO_SWAPPINESS=26,	/* Make vm_swappiness autoregulated */
+	VM_AUTOREGULATE=26,     /* swappiness and inactivation autoregulated */
 };
 
 
Index: linux-2.6.7-ck/kernel/sysctl.c
===================================================================
--- linux-2.6.7-ck.orig/kernel/sysctl.c	2004-07-01 19:41:13.377151466 +1000
+++ linux-2.6.7-ck/kernel/sysctl.c	2004-07-01 19:41:30.137517069 +1000
@@ -744,9 +744,9 @@
 		.extra2		= &one_hundred,
 	},
 	{
-		.ctl_name	= VM_AUTO_SWAPPINESS,
-		.procname	= "autoswappiness",
-		.data		= &auto_swappiness,
+		.ctl_name	= VM_AUTOREGULATE,
+		.procname	= "autoregulate",
+		.data		= &vm_autoregulate,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
Index: linux-2.6.7-ck/mm/vmscan.c
===================================================================
--- linux-2.6.7-ck.orig/mm/vmscan.c	2004-07-01 19:41:13.378151309 +1000
+++ linux-2.6.7-ck/mm/vmscan.c	2004-07-01 19:45:01.086359211 +1000
@@ -43,7 +43,8 @@
  * From 0 .. 100.  Higher means more swappy.
  */
 int vm_swappiness = 60;
-int auto_swappiness = 1;
+int vm_autoregulate = 1;
+static int app_percent = 1;
 static long total_memory;
 
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
@@ -649,7 +650,9 @@
 	long mapped_ratio;
 	long distress;
 	long swap_tendency;
+	struct sysinfo i;
 
+	si_meminfo(&i);
 	lru_add_drain();
 	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
@@ -691,23 +694,21 @@
 	 */
 	mapped_ratio = (sc->nr_mapped * 100) / total_memory;
 
+	/*
+	 * app_percent is the percentage of physical ram used
+	 * by application pages.
+	 */
+	si_meminfo(&i);
 #ifdef CONFIG_SWAP
-	if (auto_swappiness) {
-		int app_percent;
-		struct sysinfo i;
-		
+	app_percent = 100 - ((i.freeram + get_page_cache_size() -
+		swapper_space.nrpages) / (i.totalram / 100));
+
+	if (vm_autoregulate) {
 		si_swapinfo(&i);
 			
 		if (likely(i.totalswap >= 100)) {
 			int swap_centile;
 	
-			/*
-			 * app_percent is the percentage of physical ram used
-			 * by application pages.
-			 */
-			si_meminfo(&i);
-			app_percent = 100 - ((i.freeram + get_page_cache_size() -
-				swapper_space.nrpages) / (i.totalram / 100));
 	
 			/*
 			 * swap_centile is the percentage of the last (sizeof physical
@@ -724,6 +725,9 @@
 		} else 
 			vm_swappiness = 0;
 	}
+#else
+	app_percent = 100 - ((i.freeram + get_page_cache_size()) / 
+		(i.totalram / 100));
 #endif
 	
 	/*
@@ -834,11 +838,16 @@
 static void
 shrink_zone(struct zone *zone, struct scan_control *sc)
 {
-	unsigned long scan_active, scan_inactive;
-	int count;
+	unsigned long scan_active, scan_inactive, biased_active;
+	int count, biased_ap;
 
 	scan_inactive = (zone->nr_active + zone->nr_inactive) >> sc->priority;
 
+	if (vm_autoregulate) {
+		biased_ap = app_percent * app_percent / 100;
+		biased_active = zone->nr_active / (101 - biased_ap) * 100;
+	} else
+		biased_active = zone->nr_active;
 	/*
 	 * Try to keep the active list 2/3 of the size of the cache.  And
 	 * make sure that refill_inactive is given a decent number of pages.
@@ -849,7 +858,7 @@
 	 * `scan_active' just to make sure that the kernel will slowly sift
 	 * through the active list.
 	 */
-	if (zone->nr_active >= 4*(zone->nr_inactive*2 + 1)) {
+	if (biased_active >= 4*(zone->nr_inactive*2 + 1)) {
 		/* Don't scan more than 4 times the inactive list scan size */
 		scan_active = 4*scan_inactive;
 	} else {
@@ -857,7 +866,7 @@
 
 		/* Cast to long long so the multiply doesn't overflow */
 
-		tmp = (unsigned long long)scan_inactive * zone->nr_active;
+		tmp = (unsigned long long)scan_inactive * biased_active;
 		do_div(tmp, zone->nr_inactive*2 + 1);
 		scan_active = (unsigned long)tmp;
 	}

--=_mimegpg-pc.kolivas.org-4554-1089269144-0012
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA7O2YZUg7+tp6mRURAlbkAJ9+RDELlGuQ5W94Z9eVVk/SvLgIaQCdEo6c
F78vmrGwhaM93ykCILdFe38=
=IURR
-----END PGP SIGNATURE-----

--=_mimegpg-pc.kolivas.org-4554-1089269144-0012--

--=_pc.kolivas.org-1089269144-0000--
