Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265382AbUFBXzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265382AbUFBXzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbUFBXzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:55:14 -0400
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:63904 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265382AbUFBXyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:54:38 -0400
From: Con Kolivas <kernel@kolivas.org>
To: FabF <fabian.frederick@skynet.be>
Subject: Re: why swap at all?
Date: Thu, 3 Jun 2004 09:54:25 +1000
User-Agent: KMail/1.6.1
Cc: Valdis.Kletnieks@vt.edu, Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
References: <E1BVIVG-0003wL-00@calista.eckenfels.6bone.ka-ip.net> <200406021759.i52Hx00N022255@turing-police.cc.vt.edu> <1086201031.2047.13.camel@localhost.localdomain>
In-Reply-To: <1086201031.2047.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ximvAOu6y/Y2mL+"
Message-Id: <200406030954.25222.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ximvAOu6y/Y2mL+
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 3 Jun 2004 04:30, FabF wrote:
> On Wed, 2004-06-02 at 19:59, Valdis.Kletnieks@vt.edu wrote:
> > On Wed, 02 Jun 2004 07:38:41 +0200, FabF said:
> > > > Yes but: your wm is so  often used/activated it will not get swaped 
> > > > out. But if your mouse passes over mozilla and tries to focus it,
> > > > then you will feel the pain of a swapped-out x program.
> > >
> > > Exactly !
> > > Does autoregulated VM swap. patch could help here ?
> >
> > Con's auto-adjusting swappiness patch did in fact help that quite a bit,
> > especially for the case of heavy file I/O causing process images to be
> > swapped out.  I need to do some comparisons of that to Nick's MM work...
>
> It helps inactive applications to re-ermerge smoothly, heavy I/O and
> global tuning.I've got 20 swapping delta from start to high usage.
> That patch rock'n'roll my box until updatedb makes sw climbs up to 80
> and freezes my box :(

Try this version instead which biases it downwards.

Con

--Boundary-00=_ximvAOu6y/Y2mL+
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-2.6.7-rc2-as"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-2.6.7-rc2-as"

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
+			/*
+			 * Autoregulate vm_swappiness to be equal to the lowest of
+			 * app_percent and swap_centile.  Bias it downwards -ck
+			 */
+			vm_swappiness = min(app_percent, swap_centile);
+			vm_swappiness = vm_swappiness * vm_swappiness / 100;
+		} else 
+			vm_swappiness = 0;
+#endif
+	}
+	
 	/*
 	 * Now decide how much we really want to unmap some pages.  The mapped
 	 * ratio is downgraded - just because there's a lot of mapped memory

--Boundary-00=_ximvAOu6y/Y2mL+--
