Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbTEXAHs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 20:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264209AbTEXAHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 20:07:48 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:22417 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264208AbTEXAHr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 20:07:47 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 23 May 2003 17:20:13 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Boehm, Hans" <hans_boehm@hp.com>
cc: "'Arjan van de Ven'" <arjanv@redhat.com>, Hans Boehm <Hans.Boehm@hp.com>,
       "MOSBERGER, DAVID (HP-PaloAlto,unix3)" <davidm@hpl.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@linuxia64.org
Subject: RE: [Linux-ia64] Re: web page on O(1) scheduler
In-Reply-To: <75A9FEBA25015040A761C1F74975667D01442107@hplex4.hpl.hp.com>
Message-ID: <Pine.LNX.4.55.0305231714130.3554@bigblue.dev.mcafeelabs.com>
References: <75A9FEBA25015040A761C1F74975667D01442107@hplex4.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, Boehm, Hans wrote:

> Pthread_spin_lock() under the NPTL version in RH9 does basically what my
> custom locks do in the uncontested case, aside from the function call.
> But remember that this began with a discussion about whether it was
> reasonable for user locking code to explicitly yield rather than relying
> on pthreads to suspend the thread.  I don't think pthread_spin_lock is
> relevant in this context, for two reasons:
>
> 1) At least the RH9 version of pthread_spin_lock in NPTL literally spins
> and makes no attempt to yield or block.  This only makes sense at user
> level if you are 100% certain that the processors won't be
> overcommitted. Otherwise there is little to be lost by blocking once you
> have spun for sufficiently long.  You could use pthread_spin_trylock and
> block explicitly, but that gets us back to custom blocking code.

Yes, that would be a spinlock. Your code was basically a spinlock that
instead of spinning was doing abort() in contention case. Again, you
measured two different things. Even if the pthread mutex does something
very simple like :

	spinlock(mtx->lock);
	while (mtx->busy) {
		spinunlock(mtx->lock);
		waitforunlocks();
		spinlock(mtx->lock);
	}
	mtx->busy++;
	spinunlock(mtx->lock);

Only the fact that this code likely reside inside a deeper call lever will
make you pay in a tight loop like your.


> 2) AFAICT, pthread_spin_lock is currently a little too bleeding edge to
> be widely used.  I tried to time it, but failed.  Pthread.h doesn't
> include the declaration for pthread_spin_lock_t by default, at least not
> yet.  It doesn't seem to have a Linux man page, yet.  I tried to define
> the magic macro to get it declared, but that broke something else.

$ gcc -D_GNU_SOURCE ...



- Davide

