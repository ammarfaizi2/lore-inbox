Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbTBOXKx>; Sat, 15 Feb 2003 18:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbTBOXKx>; Sat, 15 Feb 2003 18:10:53 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:12303 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265385AbTBOXKt>; Sat, 15 Feb 2003 18:10:49 -0500
Date: Sun, 16 Feb 2003 00:20:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Werner Almesberger <wa@almesberger.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <kuznet@ms2.inr.ac.ru>,
       <davem@redhat.com>, <kronos@kronoz.cjb.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Migrating net/sched to new module interface
In-Reply-To: <20030214232818.J2092@almesberger.net>
Message-ID: <Pine.LNX.4.44.0302151816550.1336-100000@serv>
References: <20030214120628.208112C464@lists.samba.org>
 <Pine.LNX.4.44.0302141410540.1336-100000@serv> <20030214105338.E2092@almesberger.net>
 <Pine.LNX.4.44.0302141500540.1336-100000@serv> <20030214153039.G2092@almesberger.net>
 <Pine.LNX.4.44.0302142106140.1336-100000@serv> <20030214211226.I2092@almesberger.net>
 <Pine.LNX.4.44.0302150148010.1336-100000@serv> <20030214232818.J2092@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Feb 2003, Werner Almesberger wrote:

> > Yes, and now compare how the solutions differ when the data is static and 
> > when it's allocated.
> 
> Do they ? Even if the data is static, it can become invalid
> (in the sense that accessing it from a callback would lead
> to some kind of undesirable behaviour, even though the access
> itself would work), so I don't quite see why the difference
> would matter.

Let's stay at the main problem, we have find out when it's safe to delete 
an object. For dynamic objects you have the following options:
- callbacks: when the refcount becomes zero, we call a function to remove 
  the object.
- failure: we just return -EBUSY and try again later.
- wait: we simply wait until the refcount becomes zero

Static objects and functions are freed by the module code and usually we
want to unregister them at module unload time, so there are basically two 
ways:
- we use the module count via try_module_get/module_put
- we use your own refcount and must wait in module_exit until all users 
  are gone

If we exclude the possibly-wait-forever-option, do you see the problem 
for dynamic objects which also contain references to static data/
functions? Procfs entries are such objects, there is a count field for the 
dynamic part and an owner field for the static part and proc_get_inode 
always has to get two references. The interesting question is now, can we 
get rid of one of them?
If the answer is no, it would mean we need two procfs APIs, one which can 
be used from module_exit and another which can be used to remove dynamic 
entries. OTOH if we want to avoid this it would mean we have to make one 
or more of the above options generically usable.

I stop here, because before we can discuss possible solutions, we have to 
agree, that this problem is real.
Rusty, did I make any mistake so far? I'd really like to have your opinion 
too. You are free to flame me, if I made any mistake, but please do it 
with a bit more substance than just accusing me of ignorance.

bye, Roman

