Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAISsV>; Tue, 9 Jan 2001 13:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130018AbRAISsL>; Tue, 9 Jan 2001 13:48:11 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:21520 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129562AbRAISsD>; Tue, 9 Jan 2001 13:48:03 -0500
Date: Tue, 9 Jan 2001 10:47:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Zlatko Calusic <zlatko@iskon.hr>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <dnbstgewoj.fsf@magla.iskon.hr>
Message-ID: <Pine.LNX.4.10.10101091041150.2070-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 Jan 2001, Zlatko Calusic wrote:
> 
> But in the end I'm not sure. I made two simple tests and haven't found
> any problems with 2.4.0 mm logic (opposed to 2.2.17). In fact, the new
> kernel was faster in the more interesting (make -j32) test.

I personally think 2.4.x is going to be as fast or faster at just about
anything. We do have some MM issues still to hash out, and tuning to do,
but I'm absolutely convinced that 2.4.x is going to be a _lot_ easier to
tune than 2.2.x ever was. The "scan the page tables without doing any IO"
thing just makes the 2.4.x memory management several orders of magnitude
more flexible than 2.2.x ever was.

(This is why I worked so hard at getting the PageDirty semantics right in
the last two months or so - and why I released 2.4.0 when I did. Getting
PageDirty right was the big step to make all of the VM stuff possible in
the first place. Even if it probably looked a bit foolhardy to change the
semantics of "writepage()" quite radically just before 2.4 was released).

> Also I have found that new kernel allocates 4 times more swap space
> under some circumstances. That may or may not be alarming, it remains
> to be seen.

Yes. The new VM will allocate the swap space a _lot_ more aggressively.
Many of those allocations will not necessarily ever actually be used, but
the fact that we _have_ allocated backing store for a page is what allows
us to drop it from the VM page tables, so that it can be processed by
page_launder().

And this _is_ a downside, there's no question about it. There's the worry
about the potential loss of locality, but there's also the fact that you
effectively need a bigger swap partition with 2.4.x - never mind that
large portions of the allocations may never be used. You still need the
disk space for good VM behaviour.

There are always trade-offs, I think the 2.4.x tradeoff is a good one.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
