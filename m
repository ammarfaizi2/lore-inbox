Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318200AbSGYBNU>; Wed, 24 Jul 2002 21:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318201AbSGYBNU>; Wed, 24 Jul 2002 21:13:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52211 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318200AbSGYBNT>; Wed, 24 Jul 2002 21:13:19 -0400
Subject: Re: [PATCH] updated low-latency zap_page_range
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: torvalds@transmeta.com, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <3D3F4A2F.B1A9F379@zip.com.au>
References: <1027556975.927.1641.camel@sinai> 
	<3D3F4A2F.B1A9F379@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Jul 2002 18:16:24 -0700
Message-Id: <1027559785.17950.3.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-24 at 17:45, Andrew Morton wrote:

> Robert Love wrote:
> >
> > +static inline void cond_resched_lock(spinlock_t * lock)
> > +{
> > +       if (need_resched() && preempt_count() == 1) {
> > +               _raw_spin_unlock(lock);
> > +               preempt_enable_no_resched();
> > +               __cond_resched();
> > +               spin_lock(lock);
> > +       }
> > +}
> 
> Maybe I'm being thick.  How come a simple spin_unlock() in here
> won't do the right thing?

It will, but we will check need_resched twice.  And preempt_count
again.  My original version just did the "unlock; lock" combo and thus
the checking was automatic... but if we want to check before we unlock,
we might as well be optimal about it.

> And this won't _really_ compile to nothing with CONFIG_PREEMPT=n,
> will it?  It just does nothing because preempt_count() is zero?

I hope it compiles to nothing!  There is a false in an if... oh, wait,
to preserve possible side-effects gcc will keep the need_resched() call
so I guess we should reorder it as:

	if (preempt_count() == 1 && need_resched())

Then we get "if (0 && ..)" which should hopefully be evaluated away. 
Then the inline is empty and nothing need be done.

	Robert Love

