Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWILFaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWILFaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 01:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWILFaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 01:30:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:51640 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964797AbWILFaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 01:30:46 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: jbarnes@virtuousgeek.org, alan@lxorguk.ukuu.org.uk, davem@davemloft.net,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, segher@kernel.crashing.org
In-Reply-To: <787b0d920609112130v2d855023ief2457942736ccfd@mail.gmail.com>
References: <787b0d920609112130v2d855023ief2457942736ccfd@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 15:30:03 +1000
Message-Id: <1158039004.15465.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Oh no, it's great for regular device driver work. I used this
> type of system all the time on a different PowerPC OS.
> 
> Suppose you need to set up a piece of hardware. Assume that the
> hardware isn't across some nasty bridge. You do this:
> 
> hw->x = 42;
> hw->y = 19;
> eieio();
> hw->p = 11;
> hw->q = 233;
> hw->r = 87;
> eieio()
> hw->n = 101;
> hw->m = 5;
> eieio()
> 
> In that ficticious example, I get 7 writes to the hardware device
> with only 3 "eieio" operations. It's not hard at all. Sometimes
> a "sync" is used instead, also explicitly.

You can do that with my proposed __writel which is a simple store as
writes to non-cacheable and guarded storage have to stay in order
according to the PowerPC architecture. No need for __raw.

> To get even more speed, you can mark memory as non-coherent.

Ugh ? MMIO space is always marked non-coherent. You are not supposed to
set the M bit if the I is set in the page tables. If you are talking
about main memory, then it's a completely different discussion.

> You can even do this for RAM. There are cache control instructions
> to take care of any problems; simply ask the CPU to write things
> out as needed.

Sure, though that's not the topic.

> Linux should probably do this:
> 
> Plain stuff is like x86. If you want the performance of loose
> ordering, ask for it when you get the mapping and use read/write
> functions that have a "_" prefix. If you mix the "_" versions
> with a plain x86-like mapping or the other way, the behavior you
> get will be an arch-specific middle ground.

No. I want precisely defined semantics in all cases.

Ben.


