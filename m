Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTJZKVS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 05:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbTJZKVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 05:21:18 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:28890 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262709AbTJZKVP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 05:21:15 -0500
Message-ID: <3F9BAE6F.5070009@cyberone.com.au>
Date: Sun, 26 Oct 2003 22:22:23 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Autoregulate vm swappiness cleanup
References: <200310232337.50538.kernel@kolivas.org> <8720000.1066920153@[10.10.2.4]> <200310240103.19336.kernel@kolivas.org> <200310251658.23070.kernel@kolivas.org>
In-Reply-To: <200310251658.23070.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Fri, 24 Oct 2003 01:03, Con Kolivas wrote:
>
>>On Friday 24 October 2003 00:42, Martin J. Bligh wrote:
>>
>>>It seems that you don't need si_swapinfo here, do you? i.freeram,
>>>i.bufferram, and i.totalram all come from meminfo, as far as I can
>>>see? Maybe I'm missing a bit ...
>>>
>>Well I did do it a while ago and it seems I got carried away adding and
>>subtracting info indeed. :-) Here's a simpler patch that does the same
>>thing.
>>
>
>The off-list enthusiasm has been rather strong so here is a patch done the 
>right way (tm). There is no need for the check of totalram being zero (the 
>original version of this patch modified the swappiness every tick which was 
>wasteful and had a divide by zero on init). Adjusting vm_swappiness only when 
>there is pressure to swap means totalram shouldn't be ever be zero. The 
>sysctl is made read only since writing to it would be ignored now.
>
>Con
>
>
>
>------------------------------------------------------------------------
>
>--- linux-2.6.0-test8-base/kernel/sysctl.c	2003-10-19 20:24:49.000000000 +1000
>+++ linux-2.6.0-test8-am/kernel/sysctl.c	2003-10-25 16:37:44.384824976 +1000
>@@ -664,11 +664,8 @@ static ctl_table vm_table[] = {
> 		.procname	= "swappiness",
> 		.data		= &vm_swappiness,
> 		.maxlen		= sizeof(vm_swappiness),
>-		.mode		= 0644,
>-		.proc_handler	= &proc_dointvec_minmax,
>-		.strategy	= &sysctl_intvec,
>-		.extra1		= &zero,
>-		.extra2		= &one_hundred,
>+		.mode		= 0444 /* read-only*/,
>+		.proc_handler	= &proc_dointvec,
> 	},
> #ifdef CONFIG_HUGETLB_PAGE
> 	 {
>--- linux-2.6.0-test8-base/mm/vmscan.c	2003-10-19 20:24:36.000000000 +1000
>+++ linux-2.6.0-test8-am/mm/vmscan.c	2003-10-25 16:40:33.099176496 +1000
>@@ -47,7 +47,7 @@
> /*
>  * From 0 .. 100.  Higher means more swappy.
>  */
>-int vm_swappiness = 60;
>+int vm_swappiness = 0;
> static long total_memory;
> 
> #ifdef ARCH_HAS_PREFETCH
>@@ -600,6 +600,7 @@ refill_inactive_zone(struct zone *zone, 
> 	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
> 	struct page *page;
> 	struct pagevec pvec;
>+	struct sysinfo i;
> 	int reclaim_mapped = 0;
> 	long mapped_ratio;
> 	long distress;
>@@ -642,6 +643,14 @@ refill_inactive_zone(struct zone *zone, 
> 	mapped_ratio = (ps->nr_mapped * 100) / total_memory;
> 
> 	/*
>+	 * Autoregulate vm_swappiness to be equal to the percentage of
>+	 * pages in physical ram that are application pages. -ck
>+	 */
>+	si_meminfo(&i);
>+	vm_swappiness = 100 - (((i.freeram + get_page_cache_size() -
>+		swapper_space.nrpages) * 100) / i.totalram);
>+
>+	/*
> 	 * Now decide how much we really want to unmap some pages.  The mapped
> 	 * ratio is downgraded - just because there's a lot of mapped memory
> 	 * doesn't necessarily mean that page reclaim isn't succeeding.
>

Hi Con,
If this indeed makes VM behaviour better, why not just merge the calculation
with the swap_tendancy calculation and leave vm_swappiness there as a 
tunable?


