Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318812AbSIIT7k>; Mon, 9 Sep 2002 15:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318814AbSIIT7k>; Mon, 9 Sep 2002 15:59:40 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:47808 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318812AbSIIT7j>;
	Mon, 9 Sep 2002 15:59:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: Question about pseudo filesystems
Date: Mon, 9 Sep 2002 22:06:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
References: <20020907192736.A22492@kushida.apsleyroad.org> <E17o4UE-0006Zh-00@starship> <20020909204834.A5243@kushida.apsleyroad.org>
In-Reply-To: <20020909204834.A5243@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oUnq-0006tg-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 21:48, Jamie Lokier wrote:
> Daniel Phillips wrote:
> > > But you've rather cutely arranged that these kinds of mount _do_
> > > disappear when the last file being used on them disappears.  Clever, if
> > > a bit disturbing.
> > 
> > And it's not a good way to drive module unloading.  It is rmmod that
> > should cause a module to be unloaded, not close.  The final close
> > *allows* the module to be unloaded, it does not *cause* it to be.  So
> > to get the expected behaviour, you have to lather on some other fanciful
> > construction to garbage collect modules ready to be unloaded, or to let
> > rmmod inquire the state of the module in the process of attempting to
> > unload it, and not trigger the nasty races we've discussed.  Enter
> > fancy locking regime that 3 people in the world actually understand.
> 
> Eh?  In this case, Al Viro's scheme is really simple and works: the
> kern_mount keeps the module use-count non-zero so long as any file
> descriptors are using the module's filesystem.  fput() decrements the
> use-count at a safe time -- no race conditions.

It wasn't obvious to you, was it.  So how can you call it simple.  For
modules, we need something that is truly simple, and having __exit return
a flag is it.  That is not to say that Al's mechanism is wrong, at least
as far as filesystem modules go.  In this case you'd rely on (part of)
it to determine the correct flag to return.  It's just that this is not
the most straightforward mechanism for the job, and therefore wrong.

Besides, how much sense does it make for __exit to be incapable of
returning an error code?

> The expected behaviour is as it has always been: rmmod fails if anyone
> is using the module, and succeeds if nobody is using the module.  The
> garbage collection of modules is done using "rmmod -a" periodically, as
> it always has been.

Al's analysis is all focussed on the filesystem case, where you can
prove assertions about whether the subsystem defined by the module is
active or not.  This doesn't cover the whole range of module applications.
There is a significant class of module types that must rely on sheduling
techniques to prove inactivity.  My suggestion covers both, Al has his
blinders on.

Designs are not always correct just because they work.

-- 
Daniel
