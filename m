Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUIOIXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUIOIXz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 04:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUIOIXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 04:23:55 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:4177 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263769AbUIOIXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 04:23:52 -0400
Message-ID: <4147FC14.2010205@yahoo.com.au>
Date: Wed, 15 Sep 2004 18:23:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
References: <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914145457.GA13113@elte.hu> <414776CE.5030302@yahoo.com.au> <20040915061922.GA11683@elte.hu>
In-Reply-To: <20040915061922.GA11683@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>No, but I mean putting them right down into fastpaths like the vmscan
>>one, for example.
> 
> 
> it is a very simple no-parameters call to a function that reads a
> likely-cached word and returns. The cost is in the 2-3 cycles range - a
> _single_ cachemiss can be 10-100 times more expensive, and cachemisses
> happen very frequently in every iteration of the VM _scanning_ path
> since it (naturally and inevitably) deals with lots of sparsely
> scattered data structures that havent been referenced for quite some
> time.
> 

OK, this one thing isn't going to be noticable. But why you really
must have the check for every page, and not in the logical place
where we batch them up? You're obviously aiming for the lowest
latencies possible *without* CONFIG_PREEMPT.

But I'm thinking, why add overhead for people who don't care about
sub-ms latency (ie. most of us)? And at the same time, why would
anyone in a latency critical environment not enable preempt?


> The function (cond_resched()) triggers scheduling only very rarely, you
> should not be worried about that aspect either.
> 

No, I'm not worried about that.

> 
>>And if I remember correctly, you resorted to putting them into
>>might_sleep as well (but I haven't read the code for a while, maybe
>>you're now getting decent results without doing that).
> 
> 
> i'm not arguing that now at all, that preemption model clearly has to be
> an optional thing - at least initially.
> 

OK.

Alternatively, I'd say tell everyone who wants really low latency to
enable CONFIG_PREEMPT, which automatically gives the minimum possible
preempt latency, delimited (and defined) by critical sections, instead
of the more ad-hoc "sprinkling" ;)
