Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVKDUM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVKDUM5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 15:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVKDUM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 15:12:57 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:57254 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750897AbVKDUM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 15:12:57 -0500
Date: Fri, 4 Nov 2005 21:12:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andy Nelson <andy@thermo.lanl.gov>
Cc: torvalds@osdl.org, akpm@osdl.org, arjan@infradead.org,
       arjanv@infradead.org, haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051104201248.GA14201@elte.hu>
References: <20051104170359.80947184684@thermo.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104170359.80947184684@thermo.lanl.gov>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Nelson <andy@thermo.lanl.gov> wrote:

> The problem is a different configuration of particles, and about 2 
> times bigger (7Million) than the one in comp.arch (3million I think). 
> I would estimate that the data set in this test spans something like 
> 2-2.5GB or so.
> 
> Here are the results:
> 
> cpus    4k pages   16m pages
> 1       4888.74s   2399.36s
> 2       2447.68s   1202.71s
> 4       1225.98s    617.23s
> 6        790.05s    418.46s
> 8        592.26s    310.03s
> 12       398.46s    210.62s
> 16       296.19s    161.96s

interesting, and thanks for the numbers. Even if hugetlbs were only 
showing a 'mere' 5% improvement, a 5% _user-space improvement_ is still 
a considerable improvement that we should try to achieve, if possible 
cheaply.

the 'separate hugetlb zone' solution is cheap and simple, and i believe 
it should cover your needs of mixed hugetlb and smallpages workloads.

it would work like this: unlike the current hugepages=<nr> boot 
parameter, this zone would be useful for other (4K sized) allocations 
too. If an app requests a hugepage then we have the chance to allocate 
it from the hugetlb zone, in a guaranteed way [up to the point where the 
whole zone consists of hugepages only].

the architectural appeal in this solution is that no additional 
"fragmentation prevention" has to be done on this zone, because we only 
allow content into it that is "easy" to flush - this means that there is 
no complexity drag on the generic kernel VM.

can you think of any reason why the boot-time-configured hugetlb zone 
would be inadequate for your needs?

	Ingo
