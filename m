Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275879AbSIUEOf>; Sat, 21 Sep 2002 00:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275880AbSIUEOf>; Sat, 21 Sep 2002 00:14:35 -0400
Received: from dp.samba.org ([66.70.73.150]:48825 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S275879AbSIUEOe>;
	Sat, 21 Sep 2002 00:14:34 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Fri, 20 Sep 2002 11:32:42 +0200."
             <Pine.LNX.4.44.0209201105330.338-100000@serv> 
Date: Sat, 21 Sep 2002 14:17:58 +1000
Message-Id: <20020921041941.8A9482C135@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209201105330.338-100000@serv> you write:
> Hi,
> 
> On Fri, 20 Sep 2002, Rusty Russell wrote:
> 
> > 1) You keep ignoring the load race problem.  Your solution does not
> >    solve that, so you will need something else as well.
> 
> Could you please explain, why you think I'm ignoring this problem?
> (I think I don't, but I want to be sure we talk about the same problem.)

initfn()
{
	register_notifier(some_notifier); /* Entry point one */
	if (register_filesystem(some_notifier2) != 0) {
		unregister_notifier(some_notifier); /* This fails! */
		return -EBUSY;
	}

How does your solution of failing the unregister_notifier in this case
stop the race?  I probably missed something here?

> > 2) Several places in the kernel do *not* keep reference counts, for
> >    example net/core/dev.c's dev_add_pack and dev_remove_pack.  You
> >    want to add reference counts to all of them, but the only reason
> >    for the reference counts is for module unload: you are penalizing
> >    everyone just *in case* one is a module.
> 
> For an alternative solution:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103246649130126&w=2

Yes, two stage remove.  I liked it, except for the fact that you want
to be able to re-init the module in the case where you lose the race
between between I and II.  Then you also need two-stage init (or a
re-init function), whereas the try_module_get solution makes this easy
(ie. no requirement on the module author).

> > 3) The cost of doing atomic_incs and decs on eg. our network performance
> >    is simply unacceptable.  The only way to avoid hitting the same
> >    cacheline all the time is to use bigrefs, and the kernel bloat will
> >    kill us (and they're still not free for the 99% of people who don't
> >    have IPv4 and TCP as modules).
> 
> Even your bigref is still overkill. When packets come in, you already have
> to take _some_ lock, under the protection of this lock you can implement
> cheap, simple, portable and cache friendly counts, which can be used for
> synchronization.

No: networking uses the network brlock for exactly this reason 8(

> > 4) Your solution does not allow implementation of "rmmod -f" which
> >    prevents module count from increasing, and removes it when it is
> >    done.  This is very nice when your usage count is controlled by an
> >    external source (eg. your network).
> 
> Multiple possible solutions:
> - Separate stop/exit is probably the most elegant solution.
> - A call to exit does in any case start the removal of the module, that
> means it starts removing interface (and which won't get reinstalled).
> If there is still any user, exit will fail, you can try it later again
> after you killed that user.

If the exit fails and you fail the rmmod, you need to reinit the
module.  Otherwise noone can use it, but it cannot be replaced (say
it's holding some io region or other resource).

If you want to wait, that may be OK, but if you want to abort the
unload, the module needs to give you a *third* function, and that's
where my "too much work for every module author" line gets crossed 8(

> Anyway, almost any access to a driver goes through the filesystem and
> there it's a well known problem of unlinked but still open files. Driver
> access is pretty much the same problem to which you can apply the same
> well known solutions.

Not sure what you mean here.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
