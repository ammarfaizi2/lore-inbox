Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVBVJzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVBVJzS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 04:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVBVJzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 04:55:18 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:41553 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262054AbVBVJyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 04:54:53 -0500
Message-ID: <421B0163.3050802@yahoo.com.au>
Date: Tue, 22 Feb 2005 20:54:43 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>     <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston>     <20050217230342.GA3115@wotan.suse.de>     <20050217153031.011f873f.davem@davemloft.net>     <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au> <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Sun, 20 Feb 2005, Nick Piggin wrote:

>>
>>>Open coding is probably the smaller evil.
>>>And they're really not changed that often.
> 
> 
> My opinion FWIW: I'm all for regularizing the pagetable loops to
> work the same way, changing their variables to use the same names,
> improving their efficiency; but I do like to see what a loop is up to.
> 
> list_for_each and friends are very widely used, they're fine, and I'm
> quite glad to have their prefetching hidden away from me; but usually
> I groan, grin and bear it, each time someone devises a clever new
> for_each macro concealing half the details of some specialist loop.
> 
> In a minority?

OK, I think Andrew is now sitting on the fence after seeing the
code. So you (and Andi?) are the ones with remaining reservations
about this.

I don't disagree with your stance entirely, Hugh. I think these
macros are close to being too complicated... But I don't think
they is hiding too much detail: we all know that conceptually,
walking a page table page is reasonably simple. There are just a
few tricky bits like wrapping and termination that caused such
a divergent range of implementations - I would argue that hiding
these details is OK, because they are basically inconsequencial
to the job at hand. I think that actually makes the high level
intention of the code clearer, if anything.

If you are reading just the patch, that doesn't quite do it
justice IMO - in that case, have a look at the code after the
patch is applied (I can send you one which applies to current
kernels if you'd like).

Also, the implementation of the macros is not insanely difficult
to understand, so the details are still accessible.

Lastly, they fold to 2 and 3 levels easily, which is something
that couldn't sanely be done with the open-coded implementation.
I think with an infinitely smart compiler, there shouldn't need
to be any folding here. But in practice I see quite a large
speedup, which is something we shouldn't ignore.

I do think that they are probably not ideal candidates for a
more general abstraction that would allow for example the
transparent drop in of Dave's bitmap walking functions (it
would be possible, but would not be pretty AFAIKS). I have some
other ideas to work towards those goals, but before that I
think these macros do help with the deficiencies of the current
situation.

Nick

