Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268161AbUIPUXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268161AbUIPUXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 16:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268200AbUIPUXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 16:23:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4814 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268161AbUIPUXK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 16:23:10 -0400
Date: Thu, 16 Sep 2004 15:50:19 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-ID: <20040916185019.GC11241@logos.cnet>
References: <413CB661.6030303@sgi.com> <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <1095186713.6309.15.camel@stantz.corp.sgi.com> <20040914201558.GA32254@logos.cnet> <41477661.9030204@kolivas.org> <20040914214158.GA363@logos.cnet> <41478B56.90607@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41478B56.90607@kolivas.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con!

Spent some time reading your patch...

On Wed, Sep 15, 2004 at 10:22:46AM +1000, Con Kolivas wrote:

> >>I already answered this. That hard swappiness patch does not really 
> >>rewrite swapping policy. It identifies exactly what has changed because 
> >>it does not count "distress in the swap tendency". Therefore if the 
> >>swappiness value is the same, the mapped ratio is the same (in the 
> >>workload) yet the vm is swappinig more, it is getting into more 
> >>"distress". The mapped ratio is the same but the "distress" is for some 
> >>reason much higher in later kernels, meaning the priority of our 
> >>scanning is getting more and more intense. This should help direct your 
> >>searches.

Well if "distress" is getting higher (with similar workload/pressure) 
thats because VM is having a harder time freeing pages (priority increases,
distress increases).

You say "distress is getting higher in later kernels". Can you expand
more on that? How did you find this out, and can you be more especific
wrt "later kernels".

> >>These are the relevant lines of code _from mainline_:
> >>
> >>distress = 100 >> zone->prev_priority
> >>mapped_ratio = (sc->nr_mapped * 100) / total_memory;
> >>swap_tendency = mapped_ratio / 2 + distress + vm_swappiness
> >>if (swap_tendency >= 100)
> >>-		reclaim_mapped = 1;
> >>
> >>
> >>That hard swappiness patch effectively made "distress == 0" always.
> >
> >So isnt it true that decreasing vm_swappiness should compensate 
> >distress and have the same effect of your patch? 
> 
> Nope. We swap large amounts with the wrong workload at swappiness==0 
> where we wouldn't before at swappiness==60. ie there is no workaround 
> possible without changing the code in some way.

"we wouldn't before" refering to older kernel versions?

I see you add a "z->nr_unmapped" watermark a bit above "z->pages_high", 
and use that to set "pgdat->mapped_nrpages" to what needs to be freed 
so z->free_pages reaches "z->nr_unmapped".

And then you use that per-pgdat "mapped_nrpages" count to avoid:

- moving mapped pages to inactive list (wasting the swappiness algorithm)
- swapping out pages at shrink_list

Those two only happen when pgdat->mapped_nrpages is zero, which 
becomes true when we go below pages_low.

To resume, deactivation/swapout of mapped pages only happens when we 
go any zone pages_low.

Correct?

Now with v2.6 stock kernel, kswapd will deactivate (using vm_swappiness algorithm)
and swapout pages between the low and high zone watermarks. 

That avoids swapping out as hard as possible until we go below pages_low. 

IMHO this might be OK for common desktop workloads where people complain 
about swap, but might be harmful for other workloads where swapping out on
advance unused anonymous process memory is a _gain_.

I dont understand this check on balance_pgdat (kswapd worker function):

+       /*
+        * kswapd does a light balance_pgdat() when there is less than 1/3
+        * ram free provided there is less than vm_mapped % of that ram
+        * mapped.
+        */
+       if (maplimit && sc.nr_mapped * 100 / total_memory > vm_mapped)
+               return 0;
+

So "if not any zone is under pages_low, and more than vm_mapped % of ram
is mapped, bail out." 

I dont get what you're trying to achieve with this.

> 
> >To be fair I'm just arguing, haven't really looked at the code.
> 
> Thats cool ;)

I still think swapout behaviour can be correctly tuned with vm_swappiness,
and agree with Andrew on that we should not change anything in the algorithm
if this can be tuned.

Andrew, maybe decrease vm_swappiness to 50 on the next -mm for a test?

