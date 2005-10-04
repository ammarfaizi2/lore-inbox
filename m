Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVJDQKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVJDQKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVJDQKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:10:47 -0400
Received: from dvhart.com ([64.146.134.43]:63891 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S964842AbVJDQKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:10:47 -0400
Date: Tue, 04 Oct 2005 09:10:48 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Ray Bryant <raybry@mpdtxmail.amd.com>, Andi Kleen <ak@suse.de>
Cc: Rohit Seth <rohit.seth@intel.com>, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
Message-ID: <138020000.1128442248@[10.10.2.4]>
In-Reply-To: <200510041126.53247.raybry@mpdtxmail.amd.com>
References: <20051001120023.A10250@unix-os.sc.intel.com><1128361714.8472.44.camel@akash.sc.intel.com><p733bnh1kgj.fsf@verdi.suse.de> <200510041126.53247.raybry@mpdtxmail.amd.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Ray Bryant <raybry@mpdtxmail.amd.com> wrote (on Tuesday, October 04, 2005 11:26:52 -0500):

> On Tuesday 04 October 2005 08:27, Andi Kleen wrote:
>> Rohit Seth <rohit.seth@intel.com> writes:
>> > I think conceptually this ask for a new flag __GFP_NODEONLY that
>> > indicate allocations to come from current node only.
>> > 
>> > This definitely though means I will need to separate out the allocation
>> > from pcp patch (as Nick suggested earlier).
>> 
>> This reminds me - the current logic is currently a bit suboptimal on
>> many NUMA systems. Often it would be better to be a bit more
>> aggressive at freeing memory (maybe do a very low overhead light try to
>> free pages) in the first node before falling back to other nodes. What
>> right now happens is that when you have even minor memory pressure
>> because e.g. you node is filled up with disk cache the local memory
>> affinity doesn't work too well anymore.
>> 
>> -Andi
>> 
> That's exactly what Martin Hick's additions to __alloc_pages() were trying to 
> achieve.   However, we've never figured out how to make the "very low 
> overhead light try to free pages" thing work with low enough overhead that it 
> can be left on all of the time.    As soon as we make this the least bit more 
> expensive, then this hurts those workloads (file servers being one example) 
> who don't care about local, but who need the fastest possible allocations. 
> 
> This problem is often a showstopper on larger NUMA systems, at least for HPC 
> type applications, where the inability to guarantee local storage allocation 
> when it is requested can make the application run significantly slower.

Can we not do some migration / more targeted pressure balancing in kswapd?
Ie if we had a constant measure of per-node pressure, we could notice an
imbalance, and start migrating the least recently used pages from the node
under most pressure to the node under least ...

M.

