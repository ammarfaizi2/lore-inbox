Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVBUIJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVBUIJX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 03:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVBUIJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 03:09:22 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:23719 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261915AbVBUIJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 03:09:16 -0500
Message-ID: <42199727.2010309@yahoo.com.au>
Date: Mon, 21 Feb 2005 19:09:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andi Kleen <ak@suse.de>, davem@davemloft.net,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] page table iterators
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>	 <20050217194336.GA8314@wotan.suse.de> <1108680578.5665.14.camel@gaston>	 <20050217230342.GA3115@wotan.suse.de>	 <20050217153031.011f873f.davem@davemloft.net>	 <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au>	 <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>	 <20050220224022.5b5c4a09.akpm@osdl.org> <1108969783.5411.6.camel@gaston>
In-Reply-To: <1108969783.5411.6.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> All of them are slightly differently implemented, some check overflow,
> some don't, some have redudant checking, some aren't even consistent
> between all 3/4 loops of a given walk routine set, and we have seen the
> tendency to introduce subtle bugs in one of them when they all have to
> be changed for some reason.
> 
> I'm all for turning them into something more consistent, and I like the
> for_each_* idea...
> 
> It also allows to completely remove the code of the unused levels on 2
> and 3 level page tables easily, regaining some of the perfs lost by the
> move to 4 levels.
> 

It appears to do even better on 2-levels (i386, !PAE) than the old
3-level code, not surprisingly. lmbench fork+exit overhead is under
100us on a 3.4GHz xeon now, which is the lowest I've seen.

Haven't yet pulled out a pre-4-level kernel to see how 3-level compares
I guess I'll do that now.

> Now, we also need, in the long run, to improve perfs of walking the page
> tables, especially PTEs, for things like tearing down processes or fork,
> for example via a bitmap of used PGD entries etc... 
> 
> With proper iterators, such a thing could be implemented just by
> modifying the iterator, and all loops would benefit from it.
> 

After looking at David's bitmap walking code, I'm starting to think
that my current macros only _just_ scrape by because of the uniform
nature of the walkers, and their relative simplicity. Anything much
more complex will start to get ugly.

I'd like to look at a slightly more involved reworking in order to
nicely support optimisations like bitmap walking, without blowing out
the complexity of the macros and without hiding too much of the
workings.

However, my main aim for these macros was mainly to fix the
performance regressions on 2 and 3 level architectures. Ben's
complaints about these loops just served to hurry it along. I think
that these reasons (performance, code consistency) make it a good
idea.

Nick

