Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSKTT3I>; Wed, 20 Nov 2002 14:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSKTT3H>; Wed, 20 Nov 2002 14:29:07 -0500
Received: from packet.digeo.com ([12.110.80.53]:9374 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262789AbSKTT2x>;
	Wed, 20 Nov 2002 14:28:53 -0500
Message-ID: <3DDBE418.CDD874FF@digeo.com>
Date: Wed, 20 Nov 2002 11:35:52 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: the random driver
References: <3DDB3DED.A4C9DC56@digeo.com> <20021120162757.GA1922@think.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Nov 2002 19:35:52.0801 (UTC) FILETIME=[0990D510:01C290CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> 
> On Tue, Nov 19, 2002 at 11:46:53PM -0800, Andrew Morton wrote:
> > a) It's racy.  The head and tail pointers have no SMP protection
> >    and a race will cause it to dump 128 already-processed items
> >    back into the entropy pool.
> 
> Yeah, that's a real problem.  The random driver was never adequately
> or locked for SMP case.  We also have a problem on the output side;
> two processes that read from /dev/random at the same time can get the
> exact same value.  This is **bad**, especially if it is being used for
> UUID generation or for session key generation.

It was pointed out (alleged?) to me that the lack of input-side locking is
a feature - if the SMP race hits, it adds unpredicatability.

> ...
> > b) It's weird.  What's up with this?
> >
> >         batch_entropy_pool[2*batch_head] = a;
> >         batch_entropy_pool[(2*batch_head) + 1] = b;
> >
> >    It should be an array of 2-element structures.
> 
> The entropy returned by the drivers is essentially just an arbitrary
> 64 bit value.  It's treated as two 32 bit values so that we don't lose
> horribly given GCC's pathetic 64-bit code generator for the ia32
> platform.

heh, I see.  Presumably u64 loads and stores would be OK though?
 
> > d) It's punting work up to process context which could be performed
> >    right there in interrupt context.
> 
> The idea was to trying to pacify the soft realtime nazi's that are
> stressing out over every single microsecond of interrupt latency.
> Realistically, it's about dozen memory memory cache misses, so it's
> not *that* bad.  Originally though the batched work was being done in
> a bottom-half handler, so there wasn't a process context switch
> overhead.  So perhaps we should rethink the design decision of
> deffering the work in the interests of reducing interrupt latency.

That would suit.  If you go this way, the batching is probably
detrimental - it would increase peak latencies.  Could do the
work direct in the interrupt handler or schedule a softirq.

I think what bit us in 2.5 was the HZ=1000 change - with HZ=100
the context switch rate would be lower.  But yes, using a workqueue
here seems inappropriate.

The whole idea of scheduling the work on the calling CPU is a 
little inappropriate in this case.  I have one CPU working hard
and three idle.  Yet the deferred work and all the context
switching is being performed on the busy CPU.  hmm.
