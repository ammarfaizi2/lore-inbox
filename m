Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289336AbSAJFYH>; Thu, 10 Jan 2002 00:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289337AbSAJFX6>; Thu, 10 Jan 2002 00:23:58 -0500
Received: from zero.tech9.net ([209.61.188.187]:29963 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289336AbSAJFXs>;
	Thu, 10 Jan 2002 00:23:48 -0500
Subject: Re: lock order in O(1) scheduler
From: Robert Love <rml@tech9.net>
To: kevin@koconnor.net
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20020110001002.A13456@arizona.localdomain>
In-Reply-To: <20020110001002.A13456@arizona.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 10 Jan 2002 00:26:08 -0500
Message-Id: <1010640369.5335.289.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-10 at 00:10, kevin@koconnor.net wrote:

> I was unable to figure out what the logic of the '(smp_processor_id() <
> p->cpu)' test is..  (Why should the CPU number of the process being awoken
> matter?)  My best guess is that this is to enforce a locking invariant -
> but if so, isn't this test backwards?  If p->cpu > current->cpu then
> p->cpu's runqueue is locked first followed by this_rq - locking greatest to
> least, where the rest of the code does least to greatest..

Not so sure of the validity, but it is to respect lock order.  Locking
order is to obtain the locks lowest CPU id first to prevent AB/BA
deadlock.  See the comment above the runqueue data structure for
explanation.

> Also, this code in set_cpus_allowed() looks bogus:
> 
>         if (target_cpu < smp_processor_id()) {
>                 spin_lock_irq(&target_rq->lock);
>                 spin_lock(&this_rq->lock);
>         } else {
>                 spin_lock_irq(&target_rq->lock);
>                 spin_lock(&this_rq->lock);
>         }

This is certainly wrong, I noticed this earlier today.  The unlocking
order is not respected either, I suspect.

I believe the code should be:

         if (target_cpu < smp_processor_id()) {
                 spin_lock_irq(&target_rq->lock);
                 spin_lock(&this_rq->lock);
         } else {
                 spin_lock_irq(&this_rq->lock);
                 spin_lock(&target_rq->lock);
         }

Not so sure about unlocking.  Ingo?

	Robert Love

