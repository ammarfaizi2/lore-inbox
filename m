Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291284AbSBGUvO>; Thu, 7 Feb 2002 15:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291293AbSBGUvF>; Thu, 7 Feb 2002 15:51:05 -0500
Received: from mail.epost.de ([64.39.38.71]:27039 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id <S291284AbSBGUuy>;
	Thu, 7 Feb 2002 15:50:54 -0500
Message-ID: <3C62E871.4514B926@epost.de>
Date: Thu, 07 Feb 2002 21:49:53 +0100
From: Martin Wirth <martin.wirth@epost.de>
Reply-To: martin.wirth@dlr.de
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org, akpm@zip.com.au,
        mingo@elte.hu
Subject: [RFC] New locking primitive for 2.5
In-Reply-To: <3C629F91.2869CB1F@dlr.de> <1013107259.10430.29.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig  wrote:
> I think this API is really ugly.  If both pathes actually do the same,
> just with different defaults, one lock function with a flag would be
> much nicer.  
Just to use plain numbers is not very instructive, so you ask for a
macro 
definition like COMBI_LOCK_SPIN_MODE ????? 


> Also why do we need two unlock functions?
There is the generic_unlock function, if you forgot in which mode you
are.
The main reason is performance for the spin mode: combi_spin_unlock is
just
a spin_unlock, no test, no branch. So you are faster if you know what
you did
a few lines of code before ;-)


Robert Love wrote:
> > If a spin_lock request is blocked by a mutex_lock call, the spin_lock
> > attempt also sleeps i.e. behaves like a semaphore.
> > If you gained ownership of the lock, you can switch between spin-mode
> > and mutex-(ie.e sleeping) mode by calling:
> 
> This can be bad.  What if I grab a spinlock in a codepath where only a
> spinlock is appropriate (i.e. somewhere I can't sleep, like an irq
> handler) -- and then I sleep?

As noted in my initial e-mail the current implementation is not for
use in irq-handlers or BHs etc. 
> 
> > Open questions:
> >
> >   * Does it make sense to also provide irq-save versions of the
> >     locking functions? This means you could use the unlock functions
> >     from interrupt context. But the main use in this situation is
> >     completion handling and there are already (new) completion handlers
> >     available. So I don't think this is a must have
> 
> You can't sleep in an interrupt request handler, so this wouldn't make a
> lot of sense.

You of course were only allowed to call the unlock() functions!!
Therefore you could use them to free a resource from the handler
(but that's very much completion handling, see above).

> We shouldn't engage in wholesale changing of spinlocks to semaphores
> without a priority-inheritance mechanism.  And _that_ is the bigger
> issue ...

The combilock at least can be used to narrow the time windows for
priority
inversion because for most purposes you would use the spin mode. I
thinking
about some extension in this direction (that's why the owner field is a
pointer
to the owning task btw.).



> As for combi lock itself, it would be great, if it were possible to
> detect whether lock is held by thread running on the same CPU and sleep
> if so. This would allow for implementing interrupts as separate threads,
> etc.

That the e.g. the aproach of Solaris which results in about 5 time
higher 
latencies from a hardware interrupt to the waiting process.


    Martin Wirth
