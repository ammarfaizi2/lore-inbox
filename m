Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVLMQcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVLMQcU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVLMQcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:32:20 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:58570 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932353AbVLMQcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:32:20 -0500
Message-ID: <439EF75D.50206@cosmosbay.com>
Date: Tue, 13 Dec 2005 17:31:25 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, Simon.Derr@bull.net, ak@suse.de,
       clameter@sgi.com
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>	<439D39A8.1020806@cosmosbay.com>	<20051212020211.1394bc17.pj@sgi.com>	<20051212021247.388385da.akpm@osdl.org> <20051213075345.c39f335d.pj@sgi.com>
In-Reply-To: <20051213075345.c39f335d.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Tue, 13 Dec 2005 17:31:26 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson a écrit :

> 
> 
> Hmmm ... I suspect one possible downside.
> 
> I would think we would want to spread the hot spots out, to reduce the
> chance of getting two hot spots in the same cache line, and starting a
> bidding war for that line.
> 
> So my intuition is:
>   If read alot but seldom written, mark "__read_mostly".
>   If seldom read or written, leave unmarked.
> 

Your analysis is very good but not complete :)

There are different kind of hot cache lines, depending if they are :
- Mostly read
- read/written

Say you move to read mostly most of struct kmem_cache *, they are guaranteed 
to stay in 'mostly read'.

Mixing for example filp_cachep and dcache_lock in the same cache line is not a 
good thing. And this is what happening on typical kernel :

c04f15f0 B dcache_lock
c04f15f4 B names_cachep
c04f15f8 B filp_cachep
c04f15fc b rename_lock

I do think we should have defined a special section for very hot (and written) 
spots. It's more easy to locate thos hot spots than 'mostly read and shared by 
all cpus without cache ping pongs' places...




> so as to leave plenty of the rarely used (neither read nor written on
> kernel hot path code) as "cannon fodder" to fill the rest of the cache
> lines favored by the hot data.
> 
> This leads me to ask, of any item marked "__read_mostly":
> 
>   Is it accessed (for read, presumably) frequently, on a hot path?
> 
> If not, then I'd favor (absent actual measurements to the contrary) not
> marking it.
> 
> By this criteria:
> 
>   1) I would -not- mark "struct kmem_cache *cpuset" __read_mostly, as it
>      is rarely accessed on -any- code path, much less a hot one.  It is
>      ideal cannon fodder.
> 
>   2) I -would- (following a private email suggestion of Christoph Lameter)
>      mark my recently added "int number_of_cpusets" __read_mostly,
>      because it is accessed for every zone considered in the loops
>      within^Wbeneath __alloc_pages().
> 
> Disclaimer -- none of the above speculation is tempered by the heat of any
> actual performance measurements.  Hence, it is worth about as much as my
> legal advice.
> 

