Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316889AbSGHMxI>; Mon, 8 Jul 2002 08:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316891AbSGHMxH>; Mon, 8 Jul 2002 08:53:07 -0400
Received: from chaos.analogic.com ([204.178.40.224]:34947 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316889AbSGHMxF>; Mon, 8 Jul 2002 08:53:05 -0400
Date: Mon, 8 Jul 2002 08:57:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Thunder from the hill <thunder@ngforever.de>
cc: Daniel Phillips <phillips@arcor.de>, Pavel Machek <pavel@ucw.cz>,
       "Stephen C. Tweedie" <sct@redhat.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
In-Reply-To: <Pine.LNX.4.44.0207080632200.10105-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.3.95.1020708084535.19250A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2002, Thunder from the hill wrote:

> Hi,
> 
> On Mon, 8 Jul 2002, Richard B. Johnson wrote:
> > (3)	Set a global flag "module_remove", it doesn't have to be atomic.
> > 	It needs only to be volatile. It is used in schedule() to trap
> > 	all CPUs.
> >         schedule()
> >         {
> >             while(module_remove)
> >                 ;
> >         }
> 
> That doesn't sound too clean to me...
> 
> Maybe we should lock that module explicitly, instead of halting anything 
> that is schedule()d.

Locking the module does nothing except increase module overhead. The
premise is that we don't care how long it takes to remove a module. It
just must be done safely. So, what we need to do it make certain that...

(1) All calls from the module have returned.
(2) All calls to the module code have returned.
(3) All user-access has completed.

That's what the trap in schedule() does, in conjunction with the
wait-for-timer-ticks. We don't want to have lots of locks and semiphores
that have to be accessed during normal execution paths.

> 
> We should possibly add something to lock in struct module (or 
> module_info), be it some kind of integer or be it a semaphore (which is 
> clearly a bit too much, I think) or a spinlock, or whatever.

But this doesn't solve the module-removal problem .

> shouldn't protect the module from being used in parallel, but from being 
> used in removal. So on removal, we do something like module->remove |= 1 
> or even up(module->m_sem), and when we're done, we do something related to 
> undo the up, remove or whatever...
> 

Again, it's not the problem I'm addressing.


> BTW, looking at struct module, we have this union
> 
> union {
> 	atomic_t usecount;
> 	long pad;
> }
> 
> Fair enough, but if long pad is to pad (as it name tells us), shouldn't it 
> be atomic_t then (I mean, what if we change the type for atomic_t)?
> 

Good point. Member usecount could be anything. A 'long' isn't the correct
pad for all types, but it will probably handle everything that was
intended.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

