Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267355AbTBQW7b>; Mon, 17 Feb 2003 17:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267632AbTBQW7b>; Mon, 17 Feb 2003 17:59:31 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:54546 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267355AbTBQW73>; Mon, 17 Feb 2003 17:59:29 -0500
Date: Tue, 18 Feb 2003 00:09:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Werner Almesberger <wa@almesberger.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <kuznet@ms2.inr.ac.ru>,
       <davem@redhat.com>, <kronos@kronoz.cjb.net>,
       <linux-kernel@vger.kernel.org>
Subject: [RFC] Is an alternative module interface needed/possible?
In-Reply-To: <20030217140423.N2092@almesberger.net>
Message-ID: <Pine.LNX.4.44.0302172019220.1336-100000@serv>
References: <20030214120628.208112C464@lists.samba.org>
 <Pine.LNX.4.44.0302141410540.1336-100000@serv> <20030214105338.E2092@almesberger.net>
 <Pine.LNX.4.44.0302141500540.1336-100000@serv> <20030214153039.G2092@almesberger.net>
 <Pine.LNX.4.44.0302142106140.1336-100000@serv> <20030214211226.I2092@almesberger.net>
 <Pine.LNX.4.44.0302150148010.1336-100000@serv> <20030214232818.J2092@almesberger.net>
 <Pine.LNX.4.44.0302151816550.1336-100000@serv> <20030217140423.N2092@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(Subject changed to hopefully get a bit more attention.)

On Mon, 17 Feb 2003, Werner Almesberger wrote:

> > If we exclude the possibly-wait-forever-option, do you see the problem 
> > for dynamic objects which also contain references to static data/
> > functions?
> 
> You mean that two locking mechanisms are used, where one of them
> shouldn't be doing all that much ? Well, yes.
> 
> Now, is this a problem, or just a symptom ? I'd say it's a symptom:
> we already have a perfectly good locking/synchronization method,
> and that's through the register/unregister interface, so the
> module-specific part is unnecessary.

If it was perfectly good, we hadn't a problem. :)

> That much about the theory. Of course, in real life, we have to
> face a few more problems:
> 
>  - if callbacks can happen after apparently successful "unregister",
>    we die
>  - if accesses to other static data owned by a module can happen
>    after apparently successful "unregister", we may die
>  - if a module doesn't "unregister" at all, we die too
> 
> But all these problems equally affect code that does other things
> that can break a callback/access, e.g. if we destroy *de->data
> immediately after remove_proc_entry returns.
> 
> So this is not a module-specific problem.

You're skipping ahead. You haven't solved the problem yet, but you're 
already jumping to conclusions. :-)
Remember, that we want to savely remove a proc entry and as added bonus, 
we only want a single reference count. Let's look first at the possible 
solutions:
module count: by design this only works for entries, which are removed 
during module exit, but not for dynamic entries.
failure: if the object is still busy, we just return -EBUSY. This is 
simple, but this doesn't work for modules, since during module exit you 
can't fail anymore.
callbacks: the callback function itself had to be protected somehow, so 
just to unregister a proc entry, you have to register a callback. To 
unregister that callback, it would be silly to use another callback and 
failure doesn't work with modules, so that only leaves the module count.

The last solution sounds complicated, but exactly this is done for 
filesystems and we didn't really get rid of the second reference count, we 
just moved it somewhere else, where it hurts least.
Without interface changes this is also the only generic option to export 
dynamic data - the drivers have to get a filesystem like interface (or 
just become filesystem themselves).

The very basic reason which prevents another solution is that static data 
(which includes functions) is controlled by the generic module code and 
dynamic data is controlled by the driver itself. It's obvious that we 
can't give the module code control over dynamic data, on the other hand 
would it be possible to give the driver control over the static data? This 
way it suddenly it becomes a module-specific problem - how can we give 
drivers more control over its data?

bye, Roman

