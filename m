Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318257AbSHKJU2>; Sun, 11 Aug 2002 05:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318258AbSHKJU2>; Sun, 11 Aug 2002 05:20:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6152 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318257AbSHKJU0>;
	Sun, 11 Aug 2002 05:20:26 -0400
Message-ID: <3D562F8D.30F386AB@zip.com.au>
Date: Sun, 11 Aug 2002 02:34:05 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 19/21] introduce L1_CACHE_SHIFT_MAX
References: <3D5614DC.635ED602@zip.com.au> <E17dokf-0001f5-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Sunday 11 August 2002 09:40, Andrew Morton wrote:
> > zone->lock and zone->lru_lock are two of the hottest locks in the
> > kernel.  Their usage patterns are quite independent.  And they have
> > just been put into the same structure.  It is essential that they not
> > fall into the same cacheline.
> >
> > That could be fixed by padding with L1_CACHE_BYTES.  But the problem
> > with this is that a kernel which was configured for (say) a PIII will
> > perform poorly on SMP PIV.  This will cause problems for kernel
> > vendors.  For example, RH currently ship PII and Athlon binaries.  To
> > get best SMP performance they will end up needing to ship a lot of
> > differently configured kernels.
> >
> > To solve this we need to know, at compile time, the maximum L1 size
> > which this kernel will ever run on.
> >
> > This patch adds L1_CACHE_SHIFT_MAX to every architecture's cache.h.
> >
> > Of course it'll break when newer chips come out with increased
> > cacheline sizes.   Better suggestions are welcome.
> 
> I think you're being too paranoid.

Staring at too many horrific profile outputs does that to one.

These are *the* two big locks.

>  You pushed the performance degradation
> from the PIV to the PIII (because it will tend to hit more cachelines than it
> should)

The buddy info is all in one cacheline and the LRU info is in another.
So there's no loss to PIII here.  But those two things are soooo hot
that paranoia is warranted.

> and you won't be able to build a kernel that is optimal for the PIII
> any more.  I'd say that is PIII kernel is *supposed* to suck to some degree
> when run on a PIV, otherwise why bother having the PIV option?
> 
> I expect the performance difference you're talking about is marginal anyway.
> Maybe you've measured it?

No, I haven't.  NUMA boxes don't need it if the node-local allocation is
working right. But if they go cross-node much, it'll help.  On high-performance
UMA SMP, allowing those two particular locks to fall into the same cacheline
is a big goofup.
