Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbTBQQyz>; Mon, 17 Feb 2003 11:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267208AbTBQQyz>; Mon, 17 Feb 2003 11:54:55 -0500
Received: from almesberger.net ([63.105.73.239]:19974 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267206AbTBQQyq>; Mon, 17 Feb 2003 11:54:46 -0500
Date: Mon, 17 Feb 2003 14:04:23 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030217140423.N2092@almesberger.net>
References: <20030214120628.208112C464@lists.samba.org> <Pine.LNX.4.44.0302141410540.1336-100000@serv> <20030214105338.E2092@almesberger.net> <Pine.LNX.4.44.0302141500540.1336-100000@serv> <20030214153039.G2092@almesberger.net> <Pine.LNX.4.44.0302142106140.1336-100000@serv> <20030214211226.I2092@almesberger.net> <Pine.LNX.4.44.0302150148010.1336-100000@serv> <20030214232818.J2092@almesberger.net> <Pine.LNX.4.44.0302151816550.1336-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302151816550.1336-100000@serv>; from zippel@linux-m68k.org on Sun, Feb 16, 2003 at 12:20:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Let's stay at the main problem, we have find out when it's safe to delete 
> an object. For dynamic objects you have the following options:
[...]
> Static objects and functions are freed by the module code and usually we
[...]

Okay so far.

> If we exclude the possibly-wait-forever-option, do you see the problem 
> for dynamic objects which also contain references to static data/
> functions?

You mean that two locking mechanisms are used, where one of them
shouldn't be doing all that much ? Well, yes.

Now, is this a problem, or just a symptom ? I'd say it's a symptom:
we already have a perfectly good locking/synchronization method,
and that's through the register/unregister interface, so the
module-specific part is unnecessary.

That much about the theory. Of course, in real life, we have to
face a few more problems:

 - if callbacks can happen after apparently successful "unregister",
   we die
 - if accesses to other static data owned by a module can happen
   after apparently successful "unregister", we may die
 - if a module doesn't "unregister" at all, we die too

But all these problems equally affect code that does other things
that can break a callback/access, e.g. if we destroy *de->data
immediately after remove_proc_entry returns.

So this is not a module-specific problem.

Agreed ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
