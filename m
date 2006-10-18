Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbWJRO4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWJRO4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbWJRO4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:56:22 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:8876 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161102AbWJRO4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:56:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=K+osH6Zftm9hJ7WE+ehvJRAAMisWmSZ84C3Vcum1WxAmOiaxvlPHw7GUniKErwe5qUt3/DKoy7x0cdw/KiV/w/q5mxXwDeQlnjiZCjl7ApzWhC6u8eVKyGdbX+B6zFWg5UK1i5VLDe0sgy3PKu1LxABSlxtj28IZoGhy2Z30QNc=  ;
Message-ID: <45364092.3030206@yahoo.com.au>
Date: Thu, 19 Oct 2006 00:56:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Nick Piggin <npiggin@suse.de>
Subject: Re: [RFC] Remove temp_priority
References: <45351423.70804@google.com> <4535160E.2010908@yahoo.com.au> <45351877.9030107@google.com> <45362130.6020804@yahoo.com.au> <45363E66.8010201@google.com>
In-Reply-To: <45363E66.8010201@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>> Coming from another angle, I am thinking about doing away with direct
>> reclaim completely. That means we don't need any GFP_IO or GFP_FS, and
>> solves the problem of large numbers of processes stuck in reclaim and
>> skewing aging and depleting the memory reserve.
> 
> 
> Last time I proposed that, the objection was how to throttle the heavy
> dirtiers so they don't fill up RAM with dirty pages?

Now that we have the dirty mmap accounting, page dirtiers should be
throttled pretty well via page writeback throttling.

> Also, how do you do atomic allocations? Create a huge memory pool and
> pray really hard?

Well, yes. Atomic allocations as of *today* cannot do any reclaim, and
thus they rely on kswapd to free their memory, and we keep a (not huge)
memory pool for them. They also have to be able to handle failures, and
by and large they do OK.

>> But that's tricky because we don't have enough kswapds to get maximum
>> reclaim throughput on many configurations (only single core opterons
>> and UP systems, really).
> 
> 
> It's not a question of enough kswapds. It's that we can dirty pages
> faster than they can possibly be written to disk.
> 
> dd if=/dev/zero of=/tmp/foo

You can't catch that at the allocation side anyway because clean pagecache
may already exist for /tmp/foo.

We've always done pretty well (in 2.6) with correctly throttling and
limiting write(2) writes into pagecache, haven't we?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
