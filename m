Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130108AbQKYTee>; Sat, 25 Nov 2000 14:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131212AbQKYTeO>; Sat, 25 Nov 2000 14:34:14 -0500
Received: from maile.telia.com ([194.22.190.16]:46602 "EHLO maile.telia.com")
        by vger.kernel.org with ESMTP id <S130108AbQKYTeL>;
        Sat, 25 Nov 2000 14:34:11 -0500
From: Roger Larsson <roger.larsson@norran.net>
Date: Sat, 25 Nov 2000 19:58:15 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Rik van Riel <riel@conectiva.com.br>,
        torvalds@transmeta.com (Linus Torvalds), Nigel Gamble <nigel@nrg.org>
In-Reply-To: <Pine.LNX.4.21.0011251547210.8818-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0011251547210.8818-100000@duckman.distro.conectiva>
Subject: Re: *_trylock return on success?
MIME-Version: 1.0
Message-Id: <00112519581501.01122@dox>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 November 2000 18:49, Rik van Riel wrote:
> On Sat, 25 Nov 2000, Roger Larsson wrote:
> > Questions:
> >   What are _trylocks supposed to return?
>
> It depends on the type of _trylock  ;(
>
> >   Does spin_trylock and down_trylock behave differently?
> >   Why isn't the expected return value documented?
>
> The whole trylock stuff is, IMHO, a big mess. When you
> change from one type of trylock to another, you may be
> forced to invert the logic of your code since the return
> code from the different locks is different.
>
> For bitflags, for example, the trylock returns the state
> the bit had before the lock (ie. 1 if the thing was already
> locked).
>

This holds for down_trylocks too.
It looks like it is the spinlocks that are wrong... :-(

As most return values tend to be error returns that also
matches other code in functionallity.

>
> For spinlocks, it'll probably return something else ;/
It does...

I guess fixing this is too much too late?


It looks like ppc mixes the ways... from arch/ppc/lib/locks.c:46

int spin_trylock(spinlock_t *lock)
{
	if (__spin_trylock(&lock->lock))                  /* one on failure */
		return 0;				  /* zero on failure */ 
	lock->owner_cpu = smp_processor_id(); 
	lock->owner_pc = (unsigned long)__builtin_return_address(0);
	return 1;
}


BUT anyway...
 The thing I hit is not a bug in the kernel proper - it is in the preemptive 
stuff.

/RogerL

-- 
Home page:
  http://www.norran.net/nra02596/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
