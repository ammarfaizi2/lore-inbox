Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268453AbUIQAX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268453AbUIQAX2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 20:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268458AbUIQAX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 20:23:28 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:62909 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268453AbUIQAXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 20:23:15 -0400
Message-ID: <414A2E5E.6060704@kolivas.org>
Date: Fri, 17 Sep 2004 10:22:54 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <1095186713.6309.15.camel@stantz.corp.sgi.com> <20040914201558.GA32254@logos.cnet> <41477661.9030204@kolivas.org> <20040914214158.GA363@logos.cnet> <41478B56.90607@kolivas.org> <20040916185019.GC11241@logos.cnet>
In-Reply-To: <20040916185019.GC11241@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Con!
> 
> Spent some time reading your patch...

Great!

> Well if "distress" is getting higher (with similar workload/pressure) 
> thats because VM is having a harder time freeing pages (priority increases,
> distress increases).
> 
> You say "distress is getting higher in later kernels". Can you expand
> more on that? How did you find this out, and can you be more especific
> wrt "later kernels".

When I say earlier kernels I mean prior to 2.6.8.

I'm still referring to the "hard_swappiness patch" that Florin was using 
to fix his problem which diagnosed that distress increased. I'm sorry if 
my newer patch confuses the issue. hard_swappiness effectively changed this:

-distress = 100 >> zone->prev_priority
-mapped_ratio = (sc->nr_mapped * 100) / total_memory;
-swap_tendency = mapped_ratio / 2 + distress + vm_swappiness
-if (swap_tendency >= 100)
-		reclaim_mapped = 1;

into this:

+mapped_ratio = (sc->nr_mapped * 100) / total_memory;
+swap_tendency = mapped_ratio / 2 + vm_swappiness
+if (swap_tendency >= 100)
+		reclaim_mapped = 1;

This made swap_tendency dependant _only_ on the mapped_ratio. Now if you 
load up the same desktop and applications your mapped_ratio will be 
virtually identical regardless of the kernel. If you then copy a large 
file or convert a large video file etc, then the mapped ratio will be 
unchanged. Therefore if the swapping increased with this workload in 
2.6.8 and later kernels but did _not_ increase with hard_swappiness it 
must be the "distress" value which is entirely dependant on 
zone->prev_priority. Does that make my conclusion clearer?


Below here you're referring to my mapped_watermark patch so I'll address 
that separately to avoid confusion.

> I see you add a "z->nr_unmapped" watermark a bit above "z->pages_high", 
> and use that to set "pgdat->mapped_nrpages" to what needs to be freed 
> so z->free_pages reaches "z->nr_unmapped".
> 
> And then you use that per-pgdat "mapped_nrpages" count to avoid:
> 
> - moving mapped pages to inactive list (wasting the swappiness algorithm)
> - swapping out pages at shrink_list
> 
> Those two only happen when pgdat->mapped_nrpages is zero, which 
> becomes true when we go below pages_low.
> 
> To resume, deactivation/swapout of mapped pages only happens when we 
> go any zone pages_low.
> 
> Correct?

Yes apart from one big caveat. scanning is expensive, so it only scans 
at lowest priority (DEF_PRIORITY). If it fails to release enough memory 
it simply returns quietly. This means that if vm pressure is hard enough 
and occurs frequently/fast enough it will still drop down below 
pages_high even if the watermarks have not been re-achieved. Then the 
normal algorithm will take over.

> Now with v2.6 stock kernel, kswapd will deactivate (using vm_swappiness algorithm)
> and swapout pages between the low and high zone watermarks. 
> 
> That avoids swapping out as hard as possible until we go below pages_low. 
> 
> IMHO this might be OK for common desktop workloads where people complain 
> about swap, but might be harmful for other workloads where swapping out on
> advance unused anonymous process memory is a _gain_.

As I said, it only does it lightly, and it's tunable.

> I dont understand this check on balance_pgdat (kswapd worker function):

> +       if (maplimit && sc.nr_mapped * 100 / total_memory > vm_mapped)
> +               return 0;
> +
> 
> So "if not any zone is under pages_low, and more than vm_mapped % of ram
> is mapped, bail out." 

This will only be hit if "maplimit" is true. This means we have entered 
balance_pgdat only due to the unmapped watermark (zone->pages_min * 4). 
Here is where the real "tunable" comes into play. If greater than 
vm_mapped % of ram is mapped (ie application) pages, it will not do 
anything at this watermark. By default it is set to 66%. Setting it to 0 
inactivates this patch entirely and makes the vm behave much like 
setting swappiness to 100 in mainline.

> I still think swapout behaviour can be correctly tuned with vm_swappiness,
> and agree with Andrew on that we should not change anything in the algorithm
> if this can be tuned.

I agree it can be, but something in the logic has definitely changed, 
and a different value is not giving users like Florin the desired result 
any more.

Cheers,
Con
