Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUEaNtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUEaNtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 09:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUEaNtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 09:49:11 -0400
Received: from mail005.syd.optusnet.com.au ([211.29.132.54]:11499 "EHLO
	mail005.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264635AbUEaNri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 09:47:38 -0400
From: Con Kolivas <kernel@kolivas.org>
To: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Subject: Re: [PATCH] Autoregulated VM swappiness
Date: Mon, 31 May 2004 23:47:26 +1000
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <200405302330.48595.kernel@kolivas.org> <20040531115009.GG2159@cathedrallabs.org> <200405312154.15592.kernel@kolivas.org>
In-Reply-To: <200405312154.15592.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_udzuAPDUHcLdmOm"
Message-Id: <200405312347.26851.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_udzuAPDUHcLdmOm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 31 May 2004 21:54, Con Kolivas wrote:
> On Mon, 31 May 2004 21:50, Aristeu Sergio Rozanski Filho wrote:
> > Hi Con,
> >
> > +               .ctl_name       = VM_AUTO_SWAPPINESS,
> > +               .procname       = "autoswappiness",
> > +               .data           = &auto_swappiness,
> > +               .maxlen         = sizeof(auto_swappiness),
> > +               .mode           = 0644,
> > +               .proc_handler   = &proc_dointvec_minmax,
> > +               .strategy       = &sysctl_intvec,
> > +               .extra1         = &zero,
> > +               .extra2         = &one_hundred,
> > +       },
> > shouldn't be proc_dointvec here? seems minmax isn't needed.
>
> Err yeah sure, thanks.

How's this version look?

Con

--Boundary-00=_udzuAPDUHcLdmOm
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-2.6.7-rc2-am11"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-2.6.7-rc2-am11"

diff -Naurp --exclude-from=dontdiff linux-2.6.7-rc2-base/include/linux/swap.h linux-2.6.7-rc2-am11/include/linux/swap.h
--- linux-2.6.7-rc2-base/include/linux/swap.h	2004-05-31 21:29:21.000000000 +1000
+++ linux-2.6.7-rc2-am11/include/linux/swap.h	2004-05-31 23:39:26.020055153 +1000
@@ -175,6 +175,7 @@ extern void swap_setup(void);
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
 extern int vm_swappiness;
+extern int auto_swappiness;
 
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
diff -Naurp --exclude-from=dontdiff linux-2.6.7-rc2-base/include/linux/sysctl.h linux-2.6.7-rc2-am11/include/linux/sysctl.h
--- linux-2.6.7-rc2-base/include/linux/sysctl.h	2004-05-31 21:29:21.000000000 +1000
+++ linux-2.6.7-rc2-am11/include/linux/sysctl.h	2004-05-31 23:39:26.021054997 +1000
@@ -164,6 +164,7 @@ enum
 	VM_LAPTOP_MODE=23,	/* vm laptop mode */
 	VM_BLOCK_DUMP=24,	/* block dump mode */
 	VM_HUGETLB_GROUP=25,	/* permitted hugetlb group */
+	VM_AUTO_SWAPPINESS=26,	/* Make vm_swappiness autoregulated */
 };
 
 
diff -Naurp --exclude-from=dontdiff linux-2.6.7-rc2-base/kernel/sysctl.c linux-2.6.7-rc2-am11/kernel/sysctl.c
--- linux-2.6.7-rc2-base/kernel/sysctl.c	2004-05-31 21:29:24.000000000 +1000
+++ linux-2.6.7-rc2-am11/kernel/sysctl.c	2004-05-31 23:40:57.658756170 +1000
@@ -727,6 +727,14 @@ static ctl_table vm_table[] = {
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
diff -Naurp --exclude-from=dontdiff linux-2.6.7-rc2-base/mm/vmscan.c linux-2.6.7-rc2-am11/mm/vmscan.c
--- linux-2.6.7-rc2-base/mm/vmscan.c	2004-05-31 21:29:24.000000000 +1000
+++ linux-2.6.7-rc2-am11/mm/vmscan.c	2004-05-31 23:39:26.051050316 +1000
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

--Boundary-00=_udzuAPDUHcLdmOm--
