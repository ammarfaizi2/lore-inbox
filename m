Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318942AbSIJAlF>; Mon, 9 Sep 2002 20:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318946AbSIJAlF>; Mon, 9 Sep 2002 20:41:05 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:29863 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318942AbSIJAlE>; Mon, 9 Sep 2002 20:41:04 -0400
Date: Tue, 10 Sep 2002 01:44:59 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@arcor.de>
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about pseudo filesystems
Message-ID: <20020910014459.B5875@kushida.apsleyroad.org>
References: <20020907192736.A22492@kushida.apsleyroad.org> <E17o4UE-0006Zh-00@starship> <20020909204834.A5243@kushida.apsleyroad.org> <E17oUnq-0006tg-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17oUnq-0006tg-00@starship>; from phillips@arcor.de on Mon, Sep 09, 2002 at 10:06:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> It wasn't obvious to you, was it.  So how can you call it simple.

I have to agree.

> [...] This doesn't cover the whole range of module applications.
> There is a significant class of module types that must rely on
> sheduling techniques to prove inactivity.  My suggestion covers both,
> Al has his blinders on.

Unfortunately having cleanup_module() return a value don't necessarily
make things simpler.  Sure, it's a general solution, but it's not always
easier to use.

Typically, your module's resources are protected by a lock or so.
cleanup_module() could take this lock, check any private reference
counts, and (because it has the lock) decide whether to proceed with
unregistering the module's resources.  Once it begins unregistering
resources, it's pretty committed to unregistering them all and saying it
exited ok.

Unfortunately, once it has the lock, and the reference counts are all
zero, it's still _not_ generally safe to cleanup up a module.

This is because any other function, for example a release() op on a
file, or a remove() op on a PCI device, can't take a module's private
lock, decrement the private reference count, release the lock and
return.  There's a race between releasing the lock and returning, where
it still isn't safe to remove the module's memory.

Even waiting for a schedule to happen won't help if CONFIG_PREEMPT is
enabled.

In other words, the module's idea of whether it's own resources are no
longer in use _must_ be released by code outside the module - or at
very least, locks protecting that information must be released outside
the module.

> Designs are not always correct just because they work.

Unfortunately it's not immediately clear to me that having
cleanup_module() be able to abort an exit actually helps.

Doing so with RCU-style "wait until none of my module functions could
possible be in their race window" might work, though.  If you could 100%
trust GCC's sibling call optimisation, variations on
`spin_unlock_and_return' and `up_and_return' could be written.

But even if you can write code that's safe, is it likely to be
understood by most module authors?  If not, it's no better than Al
Viro's filesystem method.

-- Jamie
