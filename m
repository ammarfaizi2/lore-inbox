Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSGHMkb>; Mon, 8 Jul 2002 08:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316884AbSGHMka>; Mon, 8 Jul 2002 08:40:30 -0400
Received: from pD952ABA4.dip.t-dialin.net ([217.82.171.164]:9685 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316883AbSGHMk3>; Mon, 8 Jul 2002 08:40:29 -0400
Date: Mon, 8 Jul 2002 06:41:27 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Daniel Phillips <phillips@arcor.de>, Pavel Machek <pavel@ucw.cz>,
       "Stephen C. Tweedie" <sct@redhat.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
In-Reply-To: <Pine.LNX.3.95.1020708082014.19138A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0207080632200.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 8 Jul 2002, Richard B. Johnson wrote:
> (3)	Set a global flag "module_remove", it doesn't have to be atomic.
> 	It needs only to be volatile. It is used in schedule() to trap
> 	all CPUs.
>         schedule()
>         {
>             while(module_remove)
>                 ;
>         }

That doesn't sound too clean to me...

Maybe we should lock that module explicitly, instead of halting anything 
that is schedule()d.

We should possibly add something to lock in struct module (or 
module_info), be it some kind of integer or be it a semaphore (which is 
clearly a bit too much, I think) or a spinlock, or whatever. This 
shouldn't protect the module from being used in parallel, but from being 
used in removal. So on removal, we do something like module->remove |= 1 
or even up(module->m_sem), and when we're done, we do something related to 
undo the up, remove or whatever...

BTW, looking at struct module, we have this union

union {
	atomic_t usecount;
	long pad;
}

Fair enough, but if long pad is to pad (as it name tells us), shouldn't it 
be atomic_t then (I mean, what if we change the type for atomic_t)?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

