Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVJOSAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVJOSAW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 14:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVJOSAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 14:00:21 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31598
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1751161AbVJOSAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 14:00:21 -0400
Date: Sat, 15 Oct 2005 20:00:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, benh@kernel.crashing.org,
       hugh@veritas.com, paulus@samba.org, anton@samba.org, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Possible memory ordering bug in page reclaim?
Message-ID: <20051015180018.GN18159@opteron.random>
References: <4350C4F6.4030807@yahoo.com.au> <E1EQkpc-0007FI-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EQkpc-0007FI-00@gondolin.me.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 10:08:08PM +1000, Herbert Xu wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> > Well yes, that's on the store side (1, above). However can't a CPU
> > still speculatively (eg. guess the branch) load the page->flags
> > cacheline which might be satisfied from memory before the page->count
> > cacheline loads? Ie. you can still have the correct write ordering
> > but have incorrect read ordering?
> > 
> > Because neither PageDirty nor page_count is a barrier, and there is
> > no read barrier between them.
> 
> Yes you're right.  A read barrier is required here.

Even a write barrier is required on the left side, the read barrier on
the right side is useless if there is no write barrier on the left side.

Note that the barrier in atomic_add_negative is useless here because it
happens way too late, _after_ the count is decremented (not _before_)
so the decreased count could be already visible to the other cpu.

Not all archs are like x86 where a barrier happens implicitly both
before and after the instruction, and the way atomic_add_negative is
implemented the barrier from a common code point of view is only added
_after_ the instruction. 
