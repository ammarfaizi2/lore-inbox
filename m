Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUE3Na6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUE3Na6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 09:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUE3Na6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 09:30:58 -0400
Received: from mail005.syd.optusnet.com.au ([211.29.132.54]:19604 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263725AbUE3Naw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 09:30:52 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] Autoregulated VM swappiness
Date: Sun, 30 May 2004 23:30:41 +1000
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BIeuAGNbQsbnkwl"
Message-Id: <200405302330.48595.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_BIeuAGNbQsbnkwl
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

With all the recent attention paid to swap I thought I'd resync this patch=
=20
with 2.6.7-rc2 in it's more recent incarnation.

What this patch does is this:
The swappiness is made proportional to the amount of ram consumed by=20
application pages, and inversely proportional to the amount of the last=20
(sizeof physical ram) of swap ram used up. This has the effect of hardly ev=
er=20
using swap if you have large amounts of cached data by say copying an iso=20
image or manipulating video files. Conversely if you have lots of=20
applications running at once it will allow the less used ones to swap out b=
y=20
increasing the swappiness, giving preference to the "foreground" one.=20

Changes from the first version announced on lkml:
Amount of swap space consumed is also taken into account, and the size of i=
t=20
compared to the physical ram is taken into consideration when making it's=20
effect on the value of swappiness. With this patch, this should make any=20
machine that has swapspace as resistant to OOM as possible.
This version by default autoregulates the swappiness, but also allows you t=
o=20
choose a manual setting if you so desire by

echo 0 > /proc/sys/vm/autoswappiness

and then setting the swappiness the manual way as previously. This makes=20
comparison with autoregulation easy.
A few bugfixes.

Con


=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAueIEZUg7+tp6mRURAnx5AJ9bkBsu+nAxT3fXJe2qLQ3PSYVL7wCbBrrC
pZOZHLOBhVsVdrd1a1ozKS4=3D
=3DXeIZ
=2D----END PGP SIGNATURE-----

--Boundary-00=_BIeuAGNbQsbnkwl
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.6.7-rc2-am10"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-2.6.7-rc2-am10"

diff -Naurp linux-2.6.7-rc2-base/include/linux/swap.h linux-2.6.7-rc2-am9/include/linux/swap.h
--- linux-2.6.7-rc2-base/include/linux/swap.h	2004-05-30 17:51:45.896165842 +1000
+++ linux-2.6.7-rc2-am9/include/linux/swap.h	2004-05-30 23:07:34.718254427 +1000
@@ -175,6 +175,7 @@ extern void swap_setup(void);
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
+extern int auto_swappiness;
 
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
diff -Naurp linux-2.6.7-rc2-base/include/linux/sysctl.h linux-2.6.7-rc2-am9/include/linux/sysctl.h
--- linux-2.6.7-rc2-base/include/linux/sysctl.h	2004-05-30 17:51:45.897165687 +1000
+++ linux-2.6.7-rc2-am9/include/linux/sysctl.h	2004-05-30 23:08:29.022809409 +1000
@@ -164,6 +164,7 @@ enum
 	VM_LAPTOP_MODE=23,	/* vm laptop mode */
 	VM_BLOCK_DUMP=24,	/* block dump mode */
 	VM_HUGETLB_GROUP=25,	/* permitted hugetlb group */
+	VM_AUTO_SWAPPINESS=26,	/* Make vm_swappiness autoregulated */
 };
 
 
diff -Naurp linux-2.6.7-rc2-base/kernel/sysctl.c linux-2.6.7-rc2-am9/kernel/sysctl.c
--- linux-2.6.7-rc2-base/kernel/sysctl.c	2004-05-30 17:51:45.978153070 +1000
+++ linux-2.6.7-rc2-am9/kernel/sysctl.c	2004-05-30 23:07:14.588384816 +1000
@@ -727,6 +727,17 @@ static ctl_table vm_table[] = {
 		.extra1		= &zero,
 		.extra2		= &one_hundred,
 	},
+	{
+		.ctl_name	= VM_AUTO_SWAPPINESS,
+		.procname	= "autoswappiness",
+		.data		= &auto_swappiness,
+		.maxlen		= sizeof(auto_swappiness),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+		.extra2		= &one_hundred,
+	},
 #ifdef CONFIG_HUGETLB_PAGE
 	 {
 		.ctl_name	= VM_HUGETLB_PAGES,
diff -Naurp linux-2.6.7-rc2-base/mm/vmscan.c linux-2.6.7-rc2-am9/mm/vmscan.c
--- linux-2.6.7-rc2-base/mm/vmscan.c	2004-05-30 17:51:46.041143257 +1000
+++ linux-2.6.7-rc2-am9/mm/vmscan.c	2004-05-30 23:07:14.260435815 +1000
@@ -43,6 +43,7 @@
  * From 0 .. 100.  Higher means more swappy.
  */
 int vm_swappiness = 60;
+int auto_swappiness = 1;
 static long total_memory;
 
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
@@ -634,6 +635,41 @@ refill_inactive_zone(struct zone *zone, 
 	 */
 	mapped_ratio = (ps->nr_mapped * 100) / total_memory;
 
+	if (auto_swappiness) {
+#ifdef CONFIG_SWAP
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
+	
+			/*
+			 * Autoregulate vm_swappiness to be equal to the lowest of
+			 * app_percent and swap_centile. -ck
+			 */
+			vm_swappiness = min(app_percent, swap_centile);
+		} else 
+			vm_swappiness = 0;
+#endif
+	}
+	
 	/*
 	 * Now decide how much we really want to unmap some pages.  The mapped
 	 * ratio is downgraded - just because there's a lot of mapped memory

--Boundary-00=_BIeuAGNbQsbnkwl--
