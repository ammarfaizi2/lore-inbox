Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275237AbTHMPdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275238AbTHMPdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:33:18 -0400
Received: from mail.suse.de ([213.95.15.193]:17674 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S275237AbTHMPcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:32:42 -0400
Date: Wed, 13 Aug 2003 17:32:35 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Message-ID: <20030813153235.GB21081@wotan.suse.de>
References: <20030813025542.32429718.akpm@osdl.org.suse.lists.linux.kernel> <1060772769.8009.4.camel@localhost.localdomain.suse.lists.linux.kernel> <20030813042544.5064b3f4.akpm@osdl.org.suse.lists.linux.kernel> <1060774803.8008.24.camel@localhost.localdomain.suse.lists.linux.kernel> <p7365l17o70.fsf@oldwotan.suse.de> <1060778924.8008.39.camel@localhost.localdomain> <20030813131457.GD32290@wotan.suse.de> <1060783794.8008.62.camel@dhcp23.swansea.linux.org.uk> <20030813142055.GC9179@wotan.suse.de> <1060788009.8957.5.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060788009.8957.5.camel@dhcp23.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 04:20:11PM +0100, Alan Cox wrote:
> On Mer, 2003-08-13 at 15:20, Andi Kleen wrote:
> > stuff is basically useless in the kernel because it only helps with data
> > sets significantly bigger than your cache, and we usually only deal
> > with 4K chunks of everything.
> 
> Could be. I didnt write that code. I think Manfred also played with the
> copy tricks that came from the AMD slides.

The AMD slides assume all very big data sets ;-)

I would recommend to remove it.

> > Of course it should be fixed, but the fix as it is a bug workaround
> > doesn't have to be very fast. So it would be ok to just clear the 3dnow bit.
> > But then to handle the K6 case (which is interesting, I didn't know) too it
> > would be probably better to define a separate bit. 
> 
> What else checks the 3Dnow bit ?

Nothing in kernel AFAIK, but it's possible that it is used by user space
reading /proc/cpuinfo.

> > 
> > Ok. I will do that when I'm back next week unless someone beats me
> > to it ;-)
> 
> Some kind of "has prefetch and its actually useful" 8)

X86_FEATURE_PREFETCHW
X86_FEATURE_PREFETCH3DNOW

(note I didn't volunteer to write alternative3 for the later, 
someone else has to do that if they want it ;-)

> > But is it slower than an aligned execution? If yes I would prefer my 
> > solution because it keeps the fast path as fast as possible.
> 
> Has AMD confirmed that your solution is ok for the K7 as well as K8 - ie
> that if we hit the errata the fixup recovers the CPU from whatever
> lunatic state it is now in  ?

My solution is a fix as the problem is described in the Opteron
Specification Update (and also as our own testing showed - we discovered
the problem originally) 

The Errata is basically: When there is a prefetch and a load for the 
same address in flight and the load faults and the CPU is in a
very specific complicated state then the Exception is reported
on the prefetch, not the fault. 

The fix just handles the exception and doesn't crash.

At least on Opteron it can be also fixed with a magic bit in the BIOS,
maybe that's possible on XP too. But I opted to work around it in the kernel
to not force all people to get a new BIOS.

BTW we saw it mainly in the x86-64 copy_*_user and csum_copy_* functions
which do also prefetches. LTP would sometimes trigger it when it tests
how the kernel behaves with invalid addresses. But it happened very
rarely in the dcache hash too. But still it's hard to trigger, the
linked list one is very hard to hit. I tried to reproduce it in user space,
but failed. The LTP one is much easier, but still not that common.

-Andi

