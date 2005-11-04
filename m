Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbVKDVXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbVKDVXG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 16:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbVKDVXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 16:23:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1975 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750911AbVKDVXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 16:23:04 -0500
Date: Fri, 4 Nov 2005 13:22:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andy Nelson <andy@thermo.lanl.gov>
cc: mingo@elte.hu, akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <20051104210418.BC56F184739@thermo.lanl.gov>
Message-ID: <Pine.LNX.4.64.0511041310130.28804@g5.osdl.org>
References: <20051104210418.BC56F184739@thermo.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Nov 2005, Andy Nelson wrote:
>
> I am not enough of a kernel level person or sysadmin to know for certain,
> but I have still big worries about consecutive jobs that run on the
> same resources, but want extremely different page behavior. If what
> you are suggesting can cause all previous history on those resources
> to be forgotten and then reset to whatever it is that I want when I
> start my run, then yes.

That would largely be the behaviour.

When you use the hugetlb zone for big pages, nothing else would be there.

And when you don't use it, we'd be able to use those zones for at least 
page cache and user private pages - both of which are fairly easy to evict 
if required.

So the downside is that when the admin requests such a zone at boot-time, 
that will mean that the kernel will never be able to use it for its 
"normal" allocations. Not for inodes, not for directory name caching, not 
for page tables and not for process and file descriptors. Only a very 
certain class of allocations that we know how to evict easily could use 
them.

Now, for many loads, that's fine. User virtual pages and page cache pages 
are often a big part (in fact, often a huge majority) of the memory use.

Not always, though. Some loads really want lots of metadata caching, and 
if you make too much of memory be in the largepage zones, performance 
would suffer badly on such loads.

But the point is that this is easy(ish) to do, and would likely work 
wonderfully well for almost all loads. It does put a small onus on the 
maintainer of the machine to give a hint, but it's possible that normal 
loads won't mind the limitation and that we could even have a few hugepage 
zones by default (limit things to 25% of total memory or something). In 
fact, we would almost have to do so initially just to get better test 
coverage.

Now, if you want _most_ of memory to be available for hugepages, you 
really will always require a special boot option, and a friendly machine 
maintainer. Limiting things like inodes, process descriptors etc to a 
smallish percentage of memory would not be acceptable in general. 

Something like 25% "big page zones" probably is fine even in normal use, 
and 50% might be an acceptable compromise even for machines that see a 
mixture of pretty regular use and some specialized use. But a machine that 
only cares about certain loads might boot up with 75% set aside in the 
large-page zones, and that almost certainly would _not_ be a good setup 
for random other usage.

IOW, we want a hit up-front about how important huge pages would be. 
Because it's practically impossible to free pages later, because they 
_will_ become fragmented with stuff that we definitely do not want to 
teach the VM how to handle.

But the hint can be pretty friendly. Especially if it's an option to just 
load a lot of memory into the boxes, and none of the loads are expected to 
want to really be excessively close to memory limits (ie you could just 
buy an extra 16GB to allow for "slop").

		Linus
