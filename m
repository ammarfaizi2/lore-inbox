Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSKTQVG>; Wed, 20 Nov 2002 11:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbSKTQVG>; Wed, 20 Nov 2002 11:21:06 -0500
Received: from thunk.org ([140.239.227.29]:36287 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261486AbSKTQVF>;
	Wed, 20 Nov 2002 11:21:05 -0500
Date: Wed, 20 Nov 2002 11:27:57 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: the random driver
Message-ID: <20021120162757.GA1922@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>
References: <3DDB3DED.A4C9DC56@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDB3DED.A4C9DC56@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 11:46:53PM -0800, Andrew Morton wrote:
> a) It's racy.  The head and tail pointers have no SMP protection
>    and a race will cause it to dump 128 already-processed items
>    back into the entropy pool.

Yeah, that's a real problem.  The random driver was never adequately
or locked for SMP case.  We also have a problem on the output side;
two processes that read from /dev/random at the same time can get the
exact same value.  This is **bad**, especially if it is being used for
UUID generation or for session key generation.

The output side SMP locking is on my todo queue, but this week I'm in
Atlanta dealing with IPSE Cat the the IETF meeting....  when I get
back in Boston next week, I'll look at fixing this, but if someone
wants to beat me to it, feel free....

> b) It's weird.  What's up with this?
> 
>         batch_entropy_pool[2*batch_head] = a;
>         batch_entropy_pool[(2*batch_head) + 1] = b;
> 
>    It should be an array of 2-element structures.

The entropy returned by the drivers is essentially just an arbitrary
64 bit value.  It's treated as two 32 bit values so that we don't lose
horribly given GCC's pathetic 64-bit code generator for the ia32
platform. 

> d) It's punting work up to process context which could be performed
>    right there in interrupt context.

The idea was to trying to pacify the soft realtime nazi's that are
stressing out over every single microsecond of interrupt latency.
Realistically, it's about dozen memory memory cache misses, so it's
not *that* bad.  Originally though the batched work was being done in
a bottom-half handler, so there wasn't a process context switch
overhead.  So perhaps we should rethink the design decision of
deffering the work in the interests of reducing interrupt latency.

> My suggestion, if anyone cares, is to convert the entropy pool
> into smaller per-cpu buffers, protected by local_irq_save() only.
> This way the global lock (which isn't there yet) only needs to
> be taken when a CPU is actually dumping its buffer.

Yeah, that's probably what we should do.

						- Ted
