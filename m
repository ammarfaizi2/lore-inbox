Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316912AbSGHN5r>; Mon, 8 Jul 2002 09:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316952AbSGHN5q>; Mon, 8 Jul 2002 09:57:46 -0400
Received: from pD952ABA4.dip.t-dialin.net ([217.82.171.164]:37077 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316912AbSGHN5o>; Mon, 8 Jul 2002 09:57:44 -0400
Date: Mon, 8 Jul 2002 07:58:50 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Thunder from the hill <thunder@ngforever.de>,
       Daniel Phillips <phillips@arcor.de>, Pavel Machek <pavel@ucw.cz>,
       "Stephen C. Tweedie" <sct@redhat.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
In-Reply-To: <Pine.LNX.3.95.1020708084535.19250A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0207080750510.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 8 Jul 2002, Richard B. Johnson wrote:
> > That doesn't sound too clean to me...
> > 
> > Maybe we should lock that module explicitly, instead of halting anything 
> > that is schedule()d.

Not to mention that we even stop our own cleanup thread, looking at this.

> Locking the module does nothing except increase module overhead. The
> premise is that we don't care how long it takes to remove a module. It
> just must be done safely. So, what we need to do it make certain that...
> 
> (1) All calls from the module have returned.
> (2) All calls to the module code have returned.
> (3) All user-access has completed.
> 
> That's what the trap in schedule() does, in conjunction with the
> wait-for-timer-ticks. We don't want to have lots of locks and semiphores
> that have to be accessed during normal execution paths.

Still, we shouldn't lock everything. I could do awful lots of interesting 
things while the only thing that is being done is to remove a module. It 
doesn't make sense IMO to lock things that are completely unrelated to 
modules.

And BTW, what's so much of an overhead if we tell everyone who tries to 
mess around with a certain module that he'd better wait until we unloaded 
it? It could be done like your schedule hack, but cleaner in that respect 
that those who got nothing to do with the module can keep on running.

> Good point. Member usecount could be anything. A 'long' isn't the
> correct pad for all types, but it will probably handle everything that
> was intended.

But as I mentioned - atomic_t is changed (e.g. to long long) -> 
module->pad blows up, because the sizeof(struct module) is different, 
depending on which part of the union we're using.

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

