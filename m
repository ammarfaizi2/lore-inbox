Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSHGVRo>; Wed, 7 Aug 2002 17:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSHGVRo>; Wed, 7 Aug 2002 17:17:44 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:25871 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S313305AbSHGVRn>; Wed, 7 Aug 2002 17:17:43 -0400
Date: Wed, 7 Aug 2002 18:21:07 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jesse Barnes <jbarnes@sgi.com>
cc: linux-kernel@vger.kernel.org, <jmacd@namesys.com>, <phillips@arcor.de>,
       <rml@tech9.net>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
In-Reply-To: <20020807210855.GA27182@sgi.com>
Message-ID: <Pine.LNX.4.44L.0208071814250.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Jesse Barnes wrote:

> > > +#define MUST_HOLD(lock)			BUG_ON(!spin_is_locked(lock))
> > > +#define MUST_NOT_HOLD(lock)		BUG_ON(spin_is_locked(lock))
> >
> > Please tell me the MUST_NOT_HOLD thing is a joke.
>
> Nothing at all, but isn't that how the scsi ASSERT_LOCK(&lock, 0)
> macro worked before?  I could just remove all those checks in the scsi
> code I guess.

That would be a better option.

> --- linux-2.5.30/drivers/scsi/scsi_lib.c        Thu Aug  1 14:16:26 2002
> +++ linux-2.5.30-lockassert/drivers/scsi/scsi_lib.c     Wed Aug  7 11:34:39 2002
> @@ -202,7 +202,7 @@
>        Scsi_Device *SDpnt;
>        struct Scsi_Host *SHpnt;
>
> -      ASSERT_LOCK(q->queue_lock, 0);
> +      MUST_NOT_HOLD(q->queue_lock);
>
>        spin_lock_irqsave(q->queue_lock, flags);
>        if (SCpnt != NULL) {

> After I posted the last patch, a few people asked for MUST_NOT_HOLD so
> I added it back in.  Do you think it's a bad idea?

Just look at the above code (also from your patch).

The fact that we take the spin_lock_irqsave() at that point
means we want to protect ourselves from another CPU here.

The MUST_NOT_HOLD basically means the kernel will OOPS the
moment the lock is contended.

In effect, this debugging code makes lock contention fatal!


If you want to detect lock recursion on the same CPU, I'd
suggest the following:

1) add a 'cpu' member to spinlock_t

2) whenever we take a spinlock, assign the current CPU
   id to the spinlock->cpu

3) in the spinlock slow path (ie. when the spinlock is
   contended and we have to spin) check if the CPU holding
   the spinlock is the current CPU ... if it is, BUG()

4) on spin_unlock, check that the CPU unlocking the spinlock
   is the same one that's holding the spinlock

This will have the advantages that it'll actually work and
it will also debug spinlock recursion for ANY spinlock in
the system, without the need to insert special debugging
macros into the code...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

