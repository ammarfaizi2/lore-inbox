Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbUKCBYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbUKCBYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUKCBYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:24:39 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:44460 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261219AbUKCBYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:24:17 -0500
Date: Tue, 02 Nov 2004 17:18:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@novell.com>
cc: Andrew Morton <akpm@osdl.org>, Andrew Morton <akpm@digeo.com>,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <253740000.1099444711@flay>
In-Reply-To: <20041103010952.GA3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <418671AA.6020307@yahoo.com.au> <161650000.1099332236@flay> <20041101223419.GG3571@dualathlon.random> <20041102022122.GJ3571@dualathlon.random> <11900000.1099410137@[10.10.2.4]> <20041102130910.3e779d32.akpm@osdl.org> <20041102215651.GU3571@dualathlon.random> <235610000.1099435275@flay> <20041103010952.GA3571@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, November 03, 2004 02:09:52 +0100 Andrea Arcangeli <andrea@novell.com> wrote:

> On Tue, Nov 02, 2004 at 02:41:15PM -0800, Martin J. Bligh wrote:
>> eh? I don't see how that matters at all. After the DMA transfer, all the 
>> cache lines will have to be invalidated in every CPUs cache anyway, so
>> it's guaranteed to be stone-dead zero-degrees-kelvin cold. I don't see how
>> however hot it becomes afterwards is relevant? 
> 
> if the cold page becomes hot, it means the hot pages in the hot
> quicklist will become colder. The cache size is limited, so if something
> becomes hot, something will become cold.

Aaah. OK - I see what you mean. Not sure I agree, but at least I understand
now ;-) will think on that some more, but I'm still not sure it makes any
difference.
 
> The only difference is that the hot pages will become cold during the
> dma if we return an hot page, or the hot pages will become cold while
> the cpu touches the data of the previously cold page, if we return a
> cold page. Or are you worried that the cache snooping is measurable?

Not really, I just don't want to waste hot pages on DMA that we could
be using for something else.

...

> NOTE: I'm not talking about the freeing of cold pages. the freeing of
> cold pages definitely must not free at the head, this way hot
> allocations will keep going fast. But reserving hot pages during cold
> allocations I doubt it's measurable. I wonder if you've any measurement
> that collides with my theory. I could be wrong of course.

Mmmm. probably depends on cache size vs readahead windows, etc. I'm don't
think either of us has any numbers, so we're both postulating ;-)
 
> I can change my patch to reserve hot pages during cold allocations, no
> problem, but I'd really like to have any measurement data before doing
> that, since I feel I'd be wasting some tons of memory on a many-cpu
> lots-of-ram box for a worthless cause.

Why is it tons of memory? Shouldn't be more that cache-size * nr_cpus,
and as long as we fetch from the cold to the hot, it's not really wasted
at all, it's just sitting in the cache. I guess we don't steal from other
cpu's caches (maybe we ought to when we're under very heavy pressure),
but still ... I think it's a marginal amount of memory, not "tons" ;-)

M.

