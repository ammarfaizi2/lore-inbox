Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289341AbSAJFdi>; Thu, 10 Jan 2002 00:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289342AbSAJFd1>; Thu, 10 Jan 2002 00:33:27 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:17414 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S289341AbSAJFdP>; Thu, 10 Jan 2002 00:33:15 -0500
Date: Wed, 9 Jan 2002 21:38:15 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Robert Love <rml@tech9.net>
cc: kevin@koconnor.net, Ingo Molnar <mingo@elte.hu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: lock order in O(1) scheduler
In-Reply-To: <1010640369.5335.289.camel@phantasy>
Message-ID: <Pine.LNX.4.40.0201092136460.933-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2002, Robert Love wrote:

> On Thu, 2002-01-10 at 00:10, kevin@koconnor.net wrote:
>
> > I was unable to figure out what the logic of the '(smp_processor_id() <
> > p->cpu)' test is..  (Why should the CPU number of the process being awoken
> > matter?)  My best guess is that this is to enforce a locking invariant -
> > but if so, isn't this test backwards?  If p->cpu > current->cpu then
> > p->cpu's runqueue is locked first followed by this_rq - locking greatest to
> > least, where the rest of the code does least to greatest..
>
> Not so sure of the validity, but it is to respect lock order.  Locking
> order is to obtain the locks lowest CPU id first to prevent AB/BA
> deadlock.  See the comment above the runqueue data structure for
> explanation.
>
> > Also, this code in set_cpus_allowed() looks bogus:
> >
> >         if (target_cpu < smp_processor_id()) {
> >                 spin_lock_irq(&target_rq->lock);
> >                 spin_lock(&this_rq->lock);
> >         } else {
> >                 spin_lock_irq(&target_rq->lock);
> >                 spin_lock(&this_rq->lock);
> >         }
>
> This is certainly wrong, I noticed this earlier today.  The unlocking
> order is not respected either, I suspect.
>
> I believe the code should be:
>
>          if (target_cpu < smp_processor_id()) {
>                  spin_lock_irq(&target_rq->lock);
>                  spin_lock(&this_rq->lock);
>          } else {
>                  spin_lock_irq(&this_rq->lock);
>                  spin_lock(&target_rq->lock);
>          }

Yes, this is a classical example of the famous cut-and-paste bug :)


>
> Not so sure about unlocking.  Ingo?

Unlocking doesn't matter.




- Davide


