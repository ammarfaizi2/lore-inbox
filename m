Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbTBTCHT>; Wed, 19 Feb 2003 21:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbTBTCHT>; Wed, 19 Feb 2003 21:07:19 -0500
Received: from almesberger.net ([63.105.73.239]:4623 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S264715AbTBTCHQ>; Wed, 19 Feb 2003 21:07:16 -0500
Date: Wed, 19 Feb 2003 23:17:10 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
Message-ID: <20030219231710.Y2092@almesberger.net>
References: <20030217221837.Q2092@almesberger.net> <20030218050349.44B092C04E@lists.samba.org> <20030218042042.R2092@almesberger.net> <Pine.LNX.4.44.0302181252570.1336-100000@serv> <20030218111215.T2092@almesberger.net> <20030218142257.A10210@almesberger.net> <Pine.LNX.4.44.0302191454520.1336-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302191454520.1336-100000@serv>; from zippel@linux-m68k.org on Thu, Feb 20, 2003 at 01:40:48AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Sleeping is not a good general solution, as you have to be very careful 
> not to hold any important locks, otherwise it's easy to abuse.

Sleeping has many problems, but it also has one great advantage:
it's relatively easy to understand and doesn't need much extra
code (if any) in the user.

Also, I wouldn't expect lock interdependencies to be a major
problem at the level of something removing all traces of itself
(e.g. a driver module unregistering itself). Or would you happen
to know some example where such problems are happening ?

> > 6) export the lookup mechanism, and let the caller poll for
> >    removal. Problem: races with creation of a new entry with
> >    the same name.
> 
> I don't really understand this one.

Something like:

	foo_schedule_destruction(&whatever);
	while (foo_lookup(whatever.name))
		yield();

Usually too ugly to consider for anything but desperate cases.

> It would not be difficult to separate an unlink_proc_entry from 
> remove_proc_entry, so we can force an unlink if needed and we can reduce 
> this again to two basic options in two variations. :)

Yes, separating unlink (quick, non-blocking, always succeeds) and
destruction (slow, may run nethack, fragile) clearly has some appeal.

> The question is now whether we return an error value or use a callback. 

There's also the difference that the version using a callback would
schedule the removal, while the version returning an error would do
nothing (unless the caller tries again).

You could also do both, but that gets pretty difficult to use.

> Now I need a bigger example to put this into a context, a nice example is 
> scsi_unregister.

Nicely illustrates the problem of the "can look around one corner,
but not two" property of things like try_module_get, yes.

I'd also expect many cases of multiple devices which are serviced by
the same driver to have the same sort of problems. E.g. I'm pretty
sure I committed a few such sins in the ATM code, too.

> So what speaks against forcing driver/interface writers to get it
> right from the beginning?

Raising the general awareness of such problems is exactly what I'm
trying to accomplish here :-) By the way, also the argument "it may
be broken but it has never failed so far" is getting weaker with
the emergence of technologies that change relative code path
lengths, like hyperthreading.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
