Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267494AbTBRBJL>; Mon, 17 Feb 2003 20:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267524AbTBRBJL>; Mon, 17 Feb 2003 20:09:11 -0500
Received: from almesberger.net ([63.105.73.239]:27911 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267494AbTBRBJK>; Mon, 17 Feb 2003 20:09:10 -0500
Date: Mon, 17 Feb 2003 22:18:37 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kuznet@ms2.inr.ac.ru,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Is an alternative module interface needed/possible?
Message-ID: <20030217221837.Q2092@almesberger.net>
References: <20030214105338.E2092@almesberger.net> <Pine.LNX.4.44.0302141500540.1336-100000@serv> <20030214153039.G2092@almesberger.net> <Pine.LNX.4.44.0302142106140.1336-100000@serv> <20030214211226.I2092@almesberger.net> <Pine.LNX.4.44.0302150148010.1336-100000@serv> <20030214232818.J2092@almesberger.net> <Pine.LNX.4.44.0302151816550.1336-100000@serv> <20030217140423.N2092@almesberger.net> <Pine.LNX.4.44.0302172019220.1336-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302172019220.1336-100000@serv>; from zippel@linux-m68k.org on Tue, Feb 18, 2003 at 12:09:04AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> If it was perfectly good, we hadn't a problem. :)

I said we he have the method. Now we need to use it properly :-)

> You're skipping ahead. You haven't solved the problem yet, but you're 
> already jumping to conclusions. :-)

The solution is another issue. I simply stated that the problem
happens with or without modules.

> module count: by design this only works for entries, which are removed 
> during module exit, but not for dynamic entries.

Works only for modules, not good.

> failure: if the object is still busy, we just return -EBUSY. This is 
> simple, but this doesn't work for modules, since during module exit you 
> can't fail anymore.

That's a modules API problem. And yes, I think modules should
eventually be able to say that they're busy.

> callbacks: the callback function itself had to be protected somehow, so 
> just to unregister a proc entry, you have to register a callback. To 
> unregister that callback, it would be silly to use another callback and 

If all you want to do is to decrement the module count, you could
have a global handler for this that is guaranteed not to reside
in a module.

By the way, a loong time ago, in the modules thread, I suggested
a "decrement_module_count_and_return" function [1]. Such a
construct would be useful in this specific case.

[1] http://www.uwsg.iu.edu/hypermail/linux/kernel/0207.0/0147.html

> failure doesn't work with modules, so that only leaves the module count.

And how would you ensure correct access to static data in the
absence of modules ? Any solution that _requires_ a module count
looks highly suspicious to me.

Likewise, possibly dynamically allocated data that is synchronized
by the caller, e.g. "user" in "struct proc_dir_entry".

> The last solution sounds complicated, but exactly this is done for 
> filesystems and we didn't really get rid of the second reference count, we 
> just moved it somewhere else, where it hurts least.

Hmm, I'm confused. With "filesystem", do you mean the file system
driver per se (e.g. "ext3"), or a specific instance of such a file
system (e.g. /dev/hda1 mounted on /) ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
