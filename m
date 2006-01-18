Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWARRGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWARRGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWARRGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:06:07 -0500
Received: from cantor.suse.de ([195.135.220.2]:19913 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751368AbWARRGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:06:06 -0500
Date: Wed, 18 Jan 2006 18:05:58 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, David Miller <davem@davemloft.net>
Subject: Re: [patch 0/4] mm: de-skew page refcount
Message-ID: <20060118170558.GE28418@wotan.suse.de>
References: <20060118024106.10241.69438.sendpatchset@linux.site> <Pine.LNX.4.64.0601180830520.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601180830520.3240@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 08:38:44AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 18 Jan 2006, Nick Piggin wrote:
> >
> > The following patchset (against 2.6.16-rc1 + migrate race fixes) uses the new
> > atomic ops to do away with the offset page refcounting, and simplify the race
> > that it was designed to cover.
> > 
> > This allows some nice optimisations
> 
> Why?
> 
> The real downside is that "atomic_inc_nonzero()" is a lot more expensive 
> than checking for zero on x86 (and x86-64).
> 
> The reason it's offset is that on architectures that automatically test 
> the _result_ of an atomic op (ie x86[-64]), it's easy to see when 
> something _becomes_ negative or _becomes_ zero, and that's what
> 
> 	atomic_add_negative
> 	atomic_inc_and_test
> 
> are optimized for (there's also "atomic_dec_and_test()" which reacts on 
> the count becoming zero, but that doesn't have a pairing: there's no way 
> to react to the count becoming one for the increment operation, so the 
> "atomic_dec_and_test()" is used for things where zero means "free it").
> 
> Nothing else can be done that fast on x86. Everything else requires an 
> insane "load, update, cmpxchg" sequence.
> 

Yes, I realise inc_not_zero isn't as fast as dec_and_test on x86(-64).
In this case when the cacheline will already be exclusive I bet it isn't
that much of a difference (in the noise from my testing).

> So I disagree with this patch series. It has real downsides. There's a 
> reason we have the offset.
> 

Yes, there is a reason, I detailed it in the changelog and got rid of it.

> "nice optimizations"

They're in this patchset.

Nick
