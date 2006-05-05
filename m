Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751724AbWEETZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbWEETZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 15:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbWEETZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 15:25:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:27840 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750993AbWEETZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 15:25:46 -0400
Message-ID: <445BA6B2.4030807@us.ibm.com>
Date: Fri, 05 May 2006 14:25:38 -0500
From: Brian Twichell <tbrian@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave McCracken <dmccr@us.ibm.com>
CC: Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, slpratt@us.ibm.com
Subject: Re: [PATCH 0/2][RFC] New version of shared page tables
References: <1146671004.24422.20.camel@wildcat.int.mccr.org>
In-Reply-To: <1146671004.24422.20.camel@wildcat.int.mccr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We reevaluated shared pagetables with recent patches from Dave.  As with 
our previous evaluation, a database transaction-processing workload was 
used.  This time our evaluation focused on a 4-way x86-64 configuration 
with 8 GB of memory.

In the case that the bufferpools were in small pages, shared pagetables 
provided a 27% improvement in transaction throughput.  The performance 
increase is attributable to multiple factors.  First, pagetable memory 
consumption was reduced from 1.65 GB to 51 MB, freeing up 20% of the 
system's memory.  This memory was devoted to enlarging the database 
bufferpools, which allowed more database data to be cached in memory.  
The effect of this was to reduce the number of disk I/O's per 
transaction by 23%, which contributed to a similar reduction in the 
context switch rate.  A second major component of the performance 
improvement is reduced TLB and cache miss rates, due to the smaller 
pagetable footprint.  To try to isolate this benefit, we performed an 
experiment where pagetables were shared, but the database bufferpools 
were not enlarged.  In this configuration, shared pagetables provided a 
9% increase in database transaction throughput.  Analysis of processor 
performance counters revealed the following benefits from pagetable sharing:

- ITLB and DTLB page walks were reduced by 27% and 26%, respectively.
- L1 and L2 cache misses were reduced by 5%.  This is due to fewer 
pagetable entries crowding the caches.
- Front-side bus traffic was reduced approximately 10%.

When the bufferpools were in hugepages, shared pagetables provided a 3% 
increase in database transaction throughput.  Some of the underlying 
benefits of pagetable sharing were as follows:

- Pagetable memory consumption was reduced from 53 MB to 37 MB.
- ITLB and DTLB page walks were reduced by 28% and 10%, respectively.
- L1 and L2 cache misses were reduced by 2% and 6.5%, respectively.
- Front-side bus traffic was reduced by approximately 4%.

The database transaction throughput achieved using small pages with 
shared pagetables (with bufferpools enlarged) was within 3% of the 
transaction throughput achieved using hugepages without shared 
pagetables.  Thus shared pagetables provided nearly all the benefit of 
hugepages, without the requirement of having to deal with limitations of 
hugepages.  We believe this would be a significant benefit to customers 
running these types of workloads.

We also measured the benefit of shared pagetables on our larger setups.  
On our 4-way x86-64 setup with 64 GB memory, using small pages for the 
bufferpools, shared pagetables provided a 33% increase in transaction 
throughput.  Using hugepages for the bufferpools, shared pagetables 
provided a 3% increase.  Performance with small pages and shared 
pagetables was within 4% of the performance using hugepages without 
shared pagetables.

On our ppc64 setups we used both Oracle and DB2 to evaluate the benefit 
of shared pagetables.  When database bufferpools were in small pages, 
shared pagetables provided an increase in database transaction 
throughput in the range of 60-65%, while in the hugepage case the 
improvement was up to 2.4%.

We thank Kshitij Doshi and Ken Chen from Intel for their assistance in 
analyzing the x86-64 data.

Cheers,
Brian


