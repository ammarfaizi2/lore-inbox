Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUGHGkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUGHGkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 02:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265813AbUGHGkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 02:40:47 -0400
Received: from mail019.syd.optusnet.com.au ([211.29.132.73]:53123 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265051AbUGHGkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:40:32 -0400
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net> <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org>
Message-ID: <cone.1089268800.781084.4554.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Cc: nigelenki@comcast.net, linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: [PATCH] Autoregulate swappiness & inactivation
Date: Thu, 08 Jul 2004 16:40:00 +1000
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_pc.kolivas.org-1089268800-0000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_pc.kolivas.org-1089268800-0000
Content-Type: multipart/signed;
    boundary="=_mimegpg-pc.kolivas.org-4554-1089268800-0008";
    micalg=pgp-sha1; protocol="application/pgp-signature"

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-pc.kolivas.org-4554-1089268800-0008
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Andrew Morton writes:

> Con Kolivas <kernel@kolivas.org> wrote:
>>
>> > How about autoregulated swappiness, which seems to be very efficient at
>>  > its job?
>> 
>>  It's been around for quite a while, and akpm has not expressed any 
>>  interest in it so I think this will only ever flounder in the -ck domain.
> 
> Nobody sent me the patch.  And the
> justification/explanation/sales-brochure.  And the benchmarks...

Ah what the heck. They can only be knocked back to where they already are.

Attached are two patches designed to address the need to change the 
swap behaviour under different loads in 2.6.  They work on the premise that 
it is the percentage of application pages in physical ram that determines 
the need to be hitting swap. 

The first patch varies the global "swappiness" value by making it depend on 
the application pages% biased downwards in a pseudo-logarithmic fashion. It 
also looks at the percentage of swap space used and will decrease the 
swappiness value once the percentage of this free is less than 100 - 
application pages%.  It also introduces the sysctl of autoswappiness to 
disable this mechanism entirely if a manual swappiness is still 
desired.
It has the effect of running the machine with a fairly low swappiness during 
low periods of memory stress making it very unlikely to hit swap during 
large file transfers and the like, but allowing a more generous swappiness 
once physical ram is heavily consumed by applications. It also improves 
fairly dramatically the duration of swap thrash:

Make -j32 on mem=128M on P4:
8:25.92

with autoswappiness:
4:40.9

The second patch extends the autoswappiness to also start inactivating pages 
more aggressively as the application pages% increases, also with the same 
aims as the first patch. The sysctl introduced with autoswappiness is 
renamed to autoregulation to reflect the larger scope of the changes, and 
once again may be disabled to allow aiming for the fixed 2/3 active/inactive 
ratio and the manual swappiness.

with autoinactivation and no autoswappiness:
4:16.79

with autoswappiness and autoinactivation:
3:06.64

As well as the swap thrash scenario, on a desktop this has markedly reduced 
times for applications to come back to life after periods of non application 
memory stress such as copying iso images and the standard test case of the 
overnight run of updatedb.

Patches against 2.6.7-mm6 attached

Signed-off-by: Con Kolivas <kernel@kolivas.org>


--=_mimegpg-pc.kolivas.org-4554-1089268800-0008
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA7OxAZUg7+tp6mRURAtxtAJ0ahd+dQBYayZZY6R7lw+Jfk01/tgCfc8Aw
GUtFinH3rY/kmw1fCq17xh0=
=alhY
-----END PGP SIGNATURE-----

--=_mimegpg-pc.kolivas.org-4554-1089268800-0008--

--=_pc.kolivas.org-1089268800-0000
Content-Type: multipart/signed;
    boundary="=_mimegpg-pc.kolivas.org-4554-1089268800-0009";
    micalg=pgp-sha1; protocol="application/pgp-signature"

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-pc.kolivas.org-4554-1089268800-0009
Content-Description: autoswappiness
Content-Disposition: inline;
  FILENAME="autoswap.diff"
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Index: linux-2.6.7-mm6/include/linux/swap.h
===================================================================
--- linux-2.6.7-mm6.orig/include/linux/swap.h	2004-07-05 19:41:48.000000000 +1000
+++ linux-2.6.7-mm6/include/linux/swap.h	2004-07-05 23:18:01.980100050 +1000
@@ -175,6 +175,7 @@
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
+extern int auto_swappiness;
 
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
Index: linux-2.6.7-mm6/include/linux/sysctl.h
===================================================================
--- linux-2.6.7-mm6.orig/include/linux/sysctl.h	2004-07-05 19:44:05.000000000 +1000
+++ linux-2.6.7-mm6/include/linux/sysctl.h	2004-07-05 23:18:38.651379506 +1000
@@ -167,6 +167,7 @@
 	VM_BLOCK_DUMP=24,	/* block dump mode */
 	VM_HUGETLB_GROUP=25,	/* permitted hugetlb group */
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
+	VM_AUTO_SWAPPINESS=27,	/* Make vm_swappiness autoregulated */
 };
 
 
Index: linux-2.6.7-mm6/kernel/sysctl.c
===================================================================
--- linux-2.6.7-mm6.orig/kernel/sysctl.c	2004-07-05 19:44:05.000000000 +1000
+++ linux-2.6.7-mm6/kernel/sysctl.c	2004-07-05 23:18:01.983099583 +1000
@@ -727,6 +727,14 @@
 		.extra1		= &zero,
 		.extra2		= &one_hundred,
 	},
+	{
+		.ctl_name	= VM_AUTO_SWAPPINESS,
+		.procname	= "autoswappiness",
+		.data		= &auto_swappiness,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #ifdef CONFIG_HUGETLB_PAGE
 	 {
 		.ctl_name	= VM_HUGETLB_PAGES,
Index: linux-2.6.7-mm6/mm/vmscan.c
===================================================================
--- linux-2.6.7-mm6.orig/mm/vmscan.c	2004-07-05 19:41:49.000000000 +1000
+++ linux-2.6.7-mm6/mm/vmscan.c	2004-07-05 23:18:01.984099427 +1000
@@ -119,6 +119,7 @@
  * From 0 .. 100.  Higher means more swappy.
  */
 int vm_swappiness = 60;
+int auto_swappiness = 1;
 static long total_memory;
 
 static LIST_HEAD(shrinker_list);
@@ -691,6 +692,41 @@
 	 */
 	mapped_ratio = (sc->nr_mapped * 100) / total_memory;
 
+#ifdef CONFIG_SWAP
+	if (auto_swappiness) {
+		int app_percent;
+		struct sysinfo i;
+		
+		si_swapinfo(&i);
+			
+		if (likely(i.totalswap >= 100)) {
+			int swap_centile;
+	
+			/*
+			 * app_percent is the percentage of physical ram used
+			 * by application pages.
+			 */
+			si_meminfo(&i);
+			app_percent = 100 - ((i.freeram + get_page_cache_size() -
+				swapper_space.nrpages) / (i.totalram / 100));
+	
+			/*
+			 * swap_centile is the percentage of the last (sizeof physical
+			 * ram) of swap free.
+			 */
+			swap_centile = i.freeswap / 
+				(min(i.totalswap, i.totalram) / 100);
+			/*
+			 * Autoregulate vm_swappiness to be equal to the lowest of
+			 * app_percent and swap_centile.  Bias it downwards -ck
+			 */
+			vm_swappiness = min(app_percent, swap_centile);
+			vm_swappiness = vm_swappiness * vm_swappiness / 100;
+		} else 
+			vm_swappiness = 0;
+	}
+#endif
+	
 	/*
 	 * Now decide how much we really want to unmap some pages.  The mapped
 	 * ratio is downgraded - just because there's a lot of mapped memory

--=_mimegpg-pc.kolivas.org-4554-1089268800-0009
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA7OxAZUg7+tp6mRURAjwpAJ4/ZBaD97TxtcIEY8Uib7ThfQ1H8ACeJRUi
3PbFqUumhwzU6i1+s4vkLAo=
=vzFM
-----END PGP SIGNATURE-----

--=_mimegpg-pc.kolivas.org-4554-1089268800-0009--

--=_pc.kolivas.org-1089268800-0000
Content-Type: multipart/signed;
    boundary="=_mimegpg-pc.kolivas.org-4554-1089268800-0010";
    micalg=pgp-sha1; protocol="application/pgp-signature"

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-pc.kolivas.org-4554-1089268800-0010
Content-Description: vm_autoregulate
Content-Disposition: inline;
  FILENAME="vm_autoregulate2.diff"
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Index: linux-2.6.7-mm6/include/linux/swap.h
===================================================================
--- linux-2.6.7-mm6.orig/include/linux/swap.h	2004-07-05 23:18:01.980100050 +1000
+++ linux-2.6.7-mm6/include/linux/swap.h	2004-07-05 23:19:20.614833487 +1000
@@ -175,7 +175,7 @@
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
-extern int auto_swappiness;
+extern int vm_autoregulate;
 
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
Index: linux-2.6.7-mm6/include/linux/sysctl.h
===================================================================
--- linux-2.6.7-mm6.orig/include/linux/sysctl.h	2004-07-05 23:18:38.651379506 +1000
+++ linux-2.6.7-mm6/include/linux/sysctl.h	2004-07-05 23:19:42.367440258 +1000
@@ -167,7 +167,7 @@
 	VM_BLOCK_DUMP=24,	/* block dump mode */
 	VM_HUGETLB_GROUP=25,	/* permitted hugetlb group */
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
-	VM_AUTO_SWAPPINESS=27,	/* Make vm_swappiness autoregulated */
+	VM_AUTOREGULATE=27,     /* swappiness and inactivation autoregulated */
 };
 
 
Index: linux-2.6.7-mm6/kernel/sysctl.c
===================================================================
--- linux-2.6.7-mm6.orig/kernel/sysctl.c	2004-07-05 23:18:01.983099583 +1000
+++ linux-2.6.7-mm6/kernel/sysctl.c	2004-07-05 23:19:20.618832863 +1000
@@ -728,9 +728,9 @@
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
Index: linux-2.6.7-mm6/mm/vmscan.c
===================================================================
--- linux-2.6.7-mm6.orig/mm/vmscan.c	2004-07-05 23:18:01.984099427 +1000
+++ linux-2.6.7-mm6/mm/vmscan.c	2004-07-05 23:19:20.619832707 +1000
@@ -119,7 +119,8 @@
  * From 0 .. 100.  Higher means more swappy.
  */
 int vm_swappiness = 60;
-int auto_swappiness = 1;
+int vm_autoregulate = 1;
+static int app_percent = 1;
 static long total_memory;
 
 static LIST_HEAD(shrinker_list);
@@ -650,7 +651,9 @@
 	long mapped_ratio;
 	long distress;
 	long swap_tendency;
+	struct sysinfo i;
 
+	si_meminfo(&i);
 	lru_add_drain();
 	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
@@ -692,23 +695,21 @@
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
@@ -725,6 +726,9 @@
 		} else 
 			vm_swappiness = 0;
 	}
+#else
+	app_percent = 100 - ((i.freeram + get_page_cache_size()) / 
+		(i.totalram / 100));
 #endif
 	
 	/*

--=_mimegpg-pc.kolivas.org-4554-1089268800-0010
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA7OxAZUg7+tp6mRURAkIEAJ4gTrhhyCfIDHtILcim9hwbLjtiYQCgjDjZ
W92+OCA0TSTIEtjFv66Zq2Y=
=RsMd
-----END PGP SIGNATURE-----

--=_mimegpg-pc.kolivas.org-4554-1089268800-0010--

--=_pc.kolivas.org-1089268800-0000--
