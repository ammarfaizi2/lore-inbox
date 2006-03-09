Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWCIRyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWCIRyZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWCIRyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:54:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4818 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750758AbWCIRyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:54:23 -0500
Date: Thu, 9 Mar 2006 09:54:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers 
In-Reply-To: <12101.1141925945@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603090947290.18022@g5.osdl.org>
References: <Pine.LNX.4.64.0603090814530.18022@g5.osdl.org> 
 <1141855305.10606.6.camel@localhost.localdomain> <20060308161829.GC3669@elf.ucw.cz>
 <31492.1141753245@warthog.cambridge.redhat.com> <24309.1141848971@warthog.cambridge.redhat.com>
 <24280.1141904462@warthog.cambridge.redhat.com>  <12101.1141925945@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Mar 2006, David Howells wrote:
> 
> I think for the purposes of talking about memory barriers, we consider the
> cache to be part of the memory since the cache coherency mechanisms will give
> the same effect.

Yes and no.

The yes comes from the normal "smp_xxx()" barriers. As far as they are 
concerned, the cache coherency means that caches are invisible.

The "no" comes from the IO side. Basically, since IO bypasses caches and 
sometimes write buffers, it's simply not ordered wrt normal accesses.

And that's where "bus cycles" actually matter wrt barriers. If you have a 
barrier that creates a bus cycle, it suddenly can be ordered wrt IO.

So the fact that x86 SMP ops basically never guarantee any bus cycles 
basically means that they are fundamentally no-ops when it comes to IO 
serialization. That was really my only point.

> > I think x86 still support the notion of a "locked cycle" on the 
> > bus,
> 
> I wonder if that's what XCHG and XADD do... There's no particular reason they
> should be that much slower than LOCK INCL/DECL. Of course, I've only measured
> this on my Dual-PPro test box, so other i386 arch CPUs may exhibit other
> behaviour.

I think it's an internal core implementation detail. I don't think they do 
anything on the bus, but I suspect that they could easily generate less 
optimized uops, simply because they didn't matter as much and didn't fit 
the "normal" core uop sequence.

			Linus
