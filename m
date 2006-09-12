Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWILGNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWILGNF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 02:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWILGNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 02:13:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:25785 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751173AbWILGNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 02:13:02 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: jbarnes@virtuousgeek.org, alan@lxorguk.ukuu.org.uk, davem@davemloft.net,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, segher@kernel.crashing.org
In-Reply-To: <787b0d920609112304x3342e3bek88a8e12da62adac4@mail.gmail.com>
References: <787b0d920609112130v2d855023ief2457942736ccfd@mail.gmail.com>
	 <1158039004.15465.62.camel@localhost.localdomain>
	 <787b0d920609112304x3342e3bek88a8e12da62adac4@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 16:12:38 +1000
Message-Id: <1158041558.15465.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Oops, I forgot about store-store ordering being automatic.
> Pretend I had some loads in my example.

Well, in 99% of the cases, you want MMIO loads to be orderd vs. MMIO
stores and thus you can use __writel and __readl (which will only do an
eieio in __readl). If you are really that picky, then, of course you can
go use the __raw_* versions.
  
> A proper interface would be more explicit about what the
> fence does, so that driver authors shouldn't need to know
> this detail.

What detail ? Isn't my document explicit enough ? If not, please let me
know what is not clear in the definition of the 4 ordering rules and the
matching fences.

> OK, a different discussion... though memory being used
> for DMA seems rather related. You need to flush before
> a DMA out, or invalidate before a DMA in.

This is already documented elsewhere.

> So you say: never mix strict mappings with loose operations,
> and never mix loose mappings with strict operations.

I don't want the concept of "lose mappings" in the generic driver
interface for now anyway :)

It's too implementation specific and I want to know that a given access
is strictly ordered or relaxed just by looking at the accessor used, not
having to go look for where the driver did the ioremap. We can still
provide arch specific things where we feel it's useful but let's move
one step at a time with the generic accessors.

The only "lose" mapping that we'll introduce next is write combining,
but that's also a different debate. Again, one thing at a time :)

> That is an excellent rule. I see no need to stop people from
> actively trying to shoot their feet though. I'm certainly not
> suggesting that people be mixing things.
> 
> For some CPUs, you want to be specifying things when you
> set up the mapping. For other CPUs, the read/write code is
> how this gets determined. So developers specify both.

For now, we are assuming that if the mapping controls ordering, then
it's strictly order. We'll see if we hit an arch where that becomes a
problem.

Ben.


