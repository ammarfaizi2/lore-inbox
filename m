Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTL2VgO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 16:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTL2VgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 16:36:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:57986 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264254AbTL2VgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 16:36:07 -0500
Date: Mon, 29 Dec 2003 13:35:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
In-Reply-To: <m1ekuncorr.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58.0312291320140.2113@home.osdl.org>
References: <179fV-1iK-23@gated-at.bofh.it> <179IS-1VD-13@gated-at.bofh.it>
 <2003Dec27.212103@a0.complang.tuwien.ac.at> <Pine.LNX.4.58.0312271245370.2274@home.osdl.org>
 <m1smj596t1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0312272046400.2274@home.osdl.org>
 <m1ekuncorr.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, Eric W. Biederman wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> >  
> > Why? Because the fact is, that as memory gets further and further away 
> > from CPU's, caches have gotten further and further away from being direct 
> > mapped. 
> 
> Except for L1 caches.  The hit of an associate lookup there is inherently
> costly.

Having worked for a hardware company, and talked to hardware engineers, I 
can say that it generally isn't all that true.

The reason is that you can start the lookup before you even do the TLB 
lookup, and in fact you _want_ highly associative L1 caches to do that.

For example, if you have a 16kB L1 cache, and a 4kB page size, and you
want your memory accesses to go fast, you definitely want to index the L1
by the virtual access, which means that you can only use the low 12 bits
for indexing.

So what you do is you make your L1 be 4-way set-associative, so that by 
the time the TLB lookup is done, you've already looked up the index, and 
you only have to compare the TAG with one of the four possible ways.

In short: you actually _want_ your L1 to be associative, because it's the 
best way to avoid having nasty alias issues.

The only people who have a direct-mapped L1 are one of:
 - crazy and/or stupid
 - really cheap (mainly embedded space)
 - not high-performance anyway (ie their L1 is really small)
 - really sorry, and are fixing it.
 - really _really_ sorry, and have a virtually indexed cache. In which 
   case page coloring doesn't matter anyway.

Notice how high performance is _not_ on the list. Because you simply can't 
_get_ high performance with a direct-mapped L1. Those days are long gone.

There is another reason why L1's have long since moved away from
direct-mapped: the miss ratio goes up quote a bit for the same size cache.  
And things like OoO are pretty good at hiding one cycle of latency (OoO is
_not_ good at hiding memory latency, but one or two cycles are usually
ok), so even if having a larger L1 (and thus inherently more complex - not
only in associativity) means that you end up having an extra cycle access,
it's likely a win.

This is, for example, what alpha did between 21164 and the 21264: when
they went out-of-order, they did all the simulation to prove that it was
much more efficient to have a larger L1 with a higher hit ratio, even if
the latency was one cycle higher than the 21164 which was strictly
in-order.

In short, I'll bet you a dollar that you won't see a single direct-mapped 
L1 _anywhere_ where it matters. They are already pretty much gone. Can you 
name one that doesn't fit the four criteria above?

		Linus
