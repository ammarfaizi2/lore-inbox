Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUHMRdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUHMRdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUHMRdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:33:21 -0400
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:52364 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266292AbUHMRbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:31:52 -0400
Message-ID: <411CFB04.603@yahoo.com.au>
Date: Sat, 14 Aug 2004 03:31:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
References: <200408121646.50740.jbarnes@engr.sgi.com> <200408130859.24637.jbarnes@engr.sgi.com> <89760000.1092414010@[10.10.2.4]> <200408130934.20913.jbarnes@engr.sgi.com> <92140000.1092415652@[10.10.2.4]>
In-Reply-To: <92140000.1092415652@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> --Jesse Barnes <jbarnes@engr.sgi.com> wrote (on Friday, August 13, 2004 09:34:20 -0700):
> 
> 
>>On Friday, August 13, 2004 9:20 am, Martin J. Bligh wrote:
>>
>>>>>I really don't think this is a good idea - you're assuming there's
>>>>>really no locality of reference, which I don't think is at all true in
>>>>>most cases.
>>>>
>>>>No, not at all, just that locality of reference matters more for stack
>>>>and anonymous pages than it does for page cache pages.  I.e. we don't
>>>>want a node to be filled up with page cache pages causing all other
>>>>memory references from the process to be off node.
>>>
>>>Does that actually happen though? Looking at the current code makes me
>>>think it'll keep some pages free on all nodes at all times, and if kswapd
>>>does it's job, we'll never fall back across nodes. Now ... I think that's
>>>broken, but I think that's what currently happens - that was what we
>>>discussed at KS ... I might be misreading it though, I should test it.
>>
>>Not nearly enough pages for any sizeable app though.  Maybe the behavior could 
>>be configurable?
> 
> 
> Well, either we're:
> 
> 1. Falling back and putting all our most recent accesses off-node.
> 
> or.
> 
> 2. Not falling back and only able to use one node's memory for any one 
> (single threaded) app.
> 
> Either situation is crap, though I'm not sure which turd we picked right
> now ... I'd have to look at the code again ;-) I thought it was 2, but
> I might be wrong.
>  

I'm looking at this now. We are doing 1 currently.

There are a couple of issues. The first is that you need to minimise
regressions for when working set size is bigger than the local node.
The second is a fundamental tradeoff where purely FIFO touch patterns
will never be allowed to expand past local node memory for any sane
and simple (ie 2.6 worthy) scanning algorithms that I can think of.

I have a patch going now that just reclaims use-once file cache before
going off node. Seems to help a bit for basic things that just push
pagecache through the system. It definitely reduces remote allocations
by several orders of magnitude for those cases.
