Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275887AbSIURE2>; Sat, 21 Sep 2002 13:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275896AbSIURE2>; Sat, 21 Sep 2002 13:04:28 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:18182 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S275887AbSIUREY>; Sat, 21 Sep 2002 13:04:24 -0400
Date: Sat, 21 Sep 2002 19:09:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: kaos@ocs.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-Reply-To: <20020921041941.8A9482C135@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209211411010.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 21 Sep 2002, Rusty Russell wrote:

> initfn()
> {
> 	register_notifier(some_notifier); /* Entry point one */
> 	if (register_filesystem(some_notifier2) != 0) {
> 		unregister_notifier(some_notifier); /* This fails! */
> 		return -EBUSY;
> 	}
>
> How does your solution of failing the unregister_notifier in this case
> stop the race?  I probably missed something here?

You shouldn't do any cleanup in the init function and do it instead in
the exit function. That's the reason why I said earlier that calling exit
even after a failed init is not just an implementation detail. So your
functions would look like this:

int initfn()
{
	int err;

	err = register_notifier(&some_notifier);
	if (err)
		return err;
	err = register_filesystem(&some_notifier2);
	return err;
}

int exitfn()
{
	int err;

	err = unregister_filesystem(&some_notifier2);
	if (err)
		return err;
	err = unregister_notifier(&some_notifier);
	return err;
}

This means we get rid of duplicated cleanup paths and drivers are easier
to verify.
The unregister functions would look like this:

int unregister(notifier)
{
	if (notifier->count == 0)
		return 0;
	unlink(notifier);
	if (notifier->count > 1)
		return -EBUSY;
	...
	notifier->count = 0;
	return 0;
}

> > For an alternative solution:
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103246649130126&w=2
>
> Yes, two stage remove.  I liked it, except for the fact that you want
> to be able to re-init the module in the case where you lose the race
> between between I and II.  Then you also need two-stage init (or a
> re-init function), whereas the try_module_get solution makes this easy
> (ie. no requirement on the module author).

If you insist on doing the synchronize call in the module code, then you
need two stages. On the other you also could simply do this in the driver
code:

	if (hook) {
		hook = NULL;
		synchronize();
	}
	...


> > Even your bigref is still overkill. When packets come in, you already have
> > to take _some_ lock, under the protection of this lock you can implement
> > cheap, simple, portable and cache friendly counts, which can be used for
> > synchronization.
>
> No: networking uses the network brlock for exactly this reason 8(

It can't be that difficult. After you removed the hooks you only have to
wait for some time and I can't believe it's that difficult to calculate
the needed time. Using the number of incoming packets is one possibility,
the number of network interrupts should be another way.
You could even temporarily shutdown all network interfaces, if it's really
that difficult.

> > - A call to exit does in any case start the removal of the module, that
> > means it starts removing interface (and which won't get reinstalled).
> > If there is still any user, exit will fail, you can try it later again
> > after you killed that user.
>
> If the exit fails and you fail the rmmod, you need to reinit the
> module.  Otherwise noone can use it, but it cannot be replaced (say
> it's holding some io region or other resource).

Why would I want to reinit the module after a failed exit? As long as
someone is still using the module, you cannot remove the module. If you
look at the unregister example above, you see that the hook is removed
first, so nobody can start using the module again. If a module exit fails
it means you have to take care of the remaining users to complete module
unload. This means if you want to force the removal of a module, you have
to kill its users.

> If you want to wait, that may be OK, but if you want to abort the
> unload, the module needs to give you a *third* function, and that's
> where my "too much work for every module author" line gets crossed 8(

What do you mean?

> > Anyway, almost any access to a driver goes through the filesystem and
> > there it's a well known problem of unlinked but still open files. Driver
> > access is pretty much the same problem to which you can apply the same
> > well known solutions.
>
> Not sure what you mean here.

You start using drivers like files by opening them, while it's open it can
be removed (made unreachable), but only when the last user is gone can the
resources be released. Treat a driver like a file (or maybe a complete
file system) and you can use a lot of Al-proof infrastructure for free.

bye, Roman

