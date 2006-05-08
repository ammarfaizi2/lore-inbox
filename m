Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWEHQ2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWEHQ2r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 12:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWEHQ2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 12:28:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751270AbWEHQ2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 12:28:46 -0400
Date: Mon, 8 May 2006 09:28:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, Christoph Lameter <clameter@sgi.com>,
       manfred@colorfullife.com, akpm@osdl.org
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
In-Reply-To: <1147104412.22096.8.camel@localhost>
Message-ID: <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org>
References: <445E80DD.9090507@hozac.com>  <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
  <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com> 
 <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com> 
 <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org> <1147104412.22096.8.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 May 2006, Pekka Enberg wrote:
> 
> I was under the impression that virt_to_page() is expensive, even more
> so on NUMA.

virt_to_page() should be pretty cheap, but you're right, that's probably 
the much higher expense than the test. And reading the "struct page" can 
get a cache-miss.  Although - especially for NUMA - we're actually going 
to do that virt_to_page() _anyway_ just a few lines below (as part of 
"virt_to_slab()".

Similarly, for "kfree()", we will actually have done that same thing 
already (kfree() does "virt_to_cache(objp);").

So we're actually only left with a single case that doesn't currently do 
it (and didn't trigger my trivial two additions): kmem_cache_free() just 
trusts the cachep pointer implicitly. And that's obviously the case that 
the whole fcntl_setlease thing used.

Everybody else would have triggered from my patch which added it at a 
point where it was basically free (because we had looked up the page 
anyway, and we were going to read from the "struct page" info regardless).

So from a performance standpoint, maybe my previous trivial patch is the 
right thing to do, along with an even _stronger_ test for 
kmem_cache_free(), where we could do

	BUG_ON(virt_to_cache(objp) != cachep);

which you can then remove from the slab debug case.

So for a lot of the normal paths, you'd basically have no extra cost (two 
instructions, no data cache pressure), but for kmem_cache_free() we'd have 
a slight overhead (but a lot lower than SLAB_DEBUG, and at least for NUMA 
it's reading a cacheline that we'd be using regardless.

I think it sounds like it's worth it, but I'm not going to really push it.

		Linus
