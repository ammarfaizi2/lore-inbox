Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVJOWR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVJOWR6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 18:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVJOWR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 18:17:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:51129 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751241AbVJOWR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 18:17:57 -0400
Subject: Re: Possible memory ordering bug in page reclaim?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, hugh@veritas.com,
       paulus@samba.org, anton@samba.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051015180018.GN18159@opteron.random>
References: <4350C4F6.4030807@yahoo.com.au>
	 <E1EQkpc-0007FI-00@gondolin.me.apana.org.au>
	 <20051015180018.GN18159@opteron.random>
Content-Type: text/plain
Date: Sun, 16 Oct 2005 08:16:30 +1000
Message-Id: <1129414591.7620.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Even a write barrier is required on the left side, the read barrier on
> the right side is useless if there is no write barrier on the left side.
> 
> Note that the barrier in atomic_add_negative is useless here because it
> happens way too late, _after_ the count is decremented (not _before_)
> so the decreased count could be already visible to the other cpu.

Not on ppc64. Our atomic*return functions have a write barrier before
the atomic operation. I think there is just too much code out there that
either expects implicit barriers done by atomics (abuse them as locks)
or simply written by people who don't understand those ordering issues
(to be fair, they can be fairly brain damaging).

I agree this is not a good generic solution though.

> Not all archs are like x86 where a barrier happens implicitly both
> before and after the instruction, and the way atomic_add_negative is
> implemented the barrier from a common code point of view is only added
> _after_ the instruction. 

