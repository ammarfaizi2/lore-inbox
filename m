Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264635AbSIWASJ>; Sun, 22 Sep 2002 20:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSIWASJ>; Sun, 22 Sep 2002 20:18:09 -0400
Received: from dp.samba.org ([66.70.73.150]:45288 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264635AbSIWASD>;
	Sun, 22 Sep 2002 20:18:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Kevin O'Connor" <kevin@koconnor.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Sat, 21 Sep 2002 03:38:30 -0400."
             <20020921033830.A32446@arizona.localdomain> 
Date: Mon, 23 Sep 2002 09:31:42 +1000
Message-Id: <20020923002313.EAA412C12D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020921033830.A32446@arizona.localdomain> you write:
> Please consider the following non-module code snippet:
> 
> int
> sys_enable_foo_security()
> {
>         foocache = kmalloc(100000);
>         register_security(&foo_ops);
> }
> 
> int
> sys_disable_foo_security()
> {
>         unregister_security(&foo_ops);
>         kfree(foocache);  // OOPS
> }
> 
> 
> If I follow Roman's argument correctly, the unload race is not module
> specific.  (The problem is that unregister_security() only asserts that no
> new callers will be made to foo_ops, it doesn't guarantee that there are no
> current callers.)

But in practice there are many resources which are only unregistered
in the "unloading module" case: certainly by far the most common
case.  It's hard for most module authors to spot this kind of race.

> In the above example, one solution would be to reference count foocache.
> However, another viable solution would be to ref-count the security_ops
> field.
> 
> Anyway, given that the problem is a general resource management issue (and
> not module specific), I think one could implement call_security() with less
> overhead:
> 
> #define call_security(method , ...)					\
> 	({ int __ret;							\
> 	   read_lock(&SecurityLock);                                    \
> 	   __ret = security_ops->method(__VA_ARGS__);                   \
>            read_unlock(&SecurityLock);                                  \
> 	  __ret;							\
> 	})

Whack me with a cacheline... that's going to hurt on SMP.  You could
use a brlock, though.

You're assuming security methods cannot sleep?  If true, use a brlock
and be done with it.  Otherwise, you'll need a refcount, and we're
back to bigrefs and synchronize_kernel.  Adding a bigref to each
security_ops struct might be acceptable, since it's so big.  Adding a
single "owner" field certainly is.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
