Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272141AbTHKGYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 02:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272281AbTHKGYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 02:24:55 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:44421 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272141AbTHKGYw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 02:24:52 -0400
Date: Mon, 11 Aug 2003 07:24:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Matt Mackall <mpm@selenic.com>
Cc: James Morris <jmorris@intercode.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com, tytso@mit.edu
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030811062423.GB11641@mail.jlokier.co.uk>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030811020919.GD10446@mail.jlokier.co.uk> <20030811023553.GC31810@waste.org> <20030811045947.GI10446@mail.jlokier.co.uk> <20030811050414.GE31810@waste.org> <20030811052035.GK10446@mail.jlokier.co.uk> <20030811055442.GF31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811055442.GF31810@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Mon, Aug 11, 2003 at 06:20:35AM +0100, Jamie Lokier wrote:
> > Matt Mackall wrote:
> > > On Mon, Aug 11, 2003 at 05:59:47AM +0100, Jamie Lokier wrote:
> > > > Matt Mackall wrote:
> > > > > And we're safe here. The default pool size is 1024 bits, of which we
> > > > > hash 512. I could hash even fewer, say, 480 (and this would deal with the
> > > > > cryptoapi padding stuff nicely).
> > > > 
> > > > Where is the pool size set to 1024 bits?  I'm reading 2.5.75, and it
> > > > looks to me like the hash is over the whole pool, of 512 bits for the
> > > > primary and 128 bits for the secondary pool:
> > > > 
> > > > 	for (i = 0, x = 0; i < r->poolinfo.poolwords; i += 16, x+=2) {
> > >                                                ^^^^
> > > 
> > > Unfortunately, there's an ugly mix of words, bytes, and bits here (and it
> > > was actually broken for years because of it). The input pool is 4kbits
> > > and the output pools are 1k.
> > 
> > You're right about the sizes.  But you said it hashes only half of the
> > pool.  Where is that?
> 
> Hmmm, you may have something. I've been over this code in great depth
> and I keep finding bits that didn't work quite the way I (or the
> original author) thought they did.
> 
> The old version does:
> 
>  reset hash state
>  for each 512 bit chunk in pool:
>    hash 512 bit
>    mix cumulative 160 bit result back in
>  
>  fold cumulative result
>  return 80 bit result
> 
> ..which is vulnerable to your (entirely theoretical) attack
> 
> The cryptoapi version I posted does:
> 
>  for each 512 bit chunk in pool:
>    reset hash state
>    hash 512 bits
>    mix 160 bits back in
> 
>  return 160 bit result

Remember that mixing 160 bits into the pool changes only 160 bits in
the pool, due to the way the mixing function works.  Furthermore, they
are consecutive words.

This means that when you hash over the second chunk, there is a good
chance that the bits you mixed in from the first chunk have no effect
on the second hash.

That's severely flawed: it means that consecutive reads can return
identical hash results!

> An ideal version would do:
> 
>  pick an offset into the pool
>  hash somewhere in the neighborhood of 512 bits
>  mix 160 bits back in
>  update offset
> 
>  return 160 bit result
> 
> ..which is not vulnerable and faster. I'll whip something up.

You must pick the offset carefully so that bits mixed back in affect
consecutive hash results which you are returning.

-- Jamie

