Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTJWO6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 10:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbTJWO6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 10:58:14 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:32991
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263584AbTJWO6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 10:58:11 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Autoregulate vm swappiness 2.6.0-test8
Date: Fri, 24 Oct 2003 01:03:19 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
References: <200310232337.50538.kernel@kolivas.org> <8720000.1066920153@[10.10.2.4]>
In-Reply-To: <8720000.1066920153@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_32+l/hoK185duMr"
Message-Id: <200310240103.19336.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_32+l/hoK185duMr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 24 October 2003 00:42, Martin J. Bligh wrote:
> > +	 * Autoregulate vm_swappiness to be application pages % -ck.
> > +	 */
> > +	si_meminfo(&i);
> > +	si_swapinfo(&i);
> > +	pg_size = get_page_cache_size() - i.bufferram ;
> > +	vm_swappiness = 100 - (((i.freeram + i.bufferram +
> > +		(pg_size - swapper_space.nrpages)) * 100) /
> > +		(i.totalram ? i.totalram : 1));
> > +
> > +	/*
>
> It seems that you don't need si_swapinfo here, do you? i.freeram,
> i.bufferram, and i.totalram all come from meminfo, as far as I can
> see? Maybe I'm missing a bit ...

Well I did do it a while ago and it seems I got carried away adding and 
subtracting info indeed. :-) Here's a simpler patch that does the same thing.

Con



--Boundary-00=_32+l/hoK185duMr
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-test8-am-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-test8-am-2"

--- linux-2.6.0-test8-base/mm/vmscan.c	2003-10-19 20:24:36.000000000 +1000
+++ linux-2.6.0-test8-am/mm/vmscan.c	2003-10-24 00:46:52.000000000 +1000
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
@@ -642,6 +643,13 @@ refill_inactive_zone(struct zone *zone, 
 	mapped_ratio = (ps->nr_mapped * 100) / total_memory;
 
 	/*
+	 * Autoregulate vm_swappiness to be application pages% -ck
+	 */
+	si_meminfo(&i);
+	vm_swappiness = 100 - (((i.freeram + get_page_cache_size() -
+		swapper_space.nrpages) * 100) / (i.totalram ? i.totalram : 1));
+
+	/*
 	 * Now decide how much we really want to unmap some pages.  The mapped
 	 * ratio is downgraded - just because there's a lot of mapped memory
 	 * doesn't necessarily mean that page reclaim isn't succeeding.

--Boundary-00=_32+l/hoK185duMr--

