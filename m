Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319410AbSILCGQ>; Wed, 11 Sep 2002 22:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319411AbSILCGQ>; Wed, 11 Sep 2002 22:06:16 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:50096 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S319410AbSILCGM>; Wed, 11 Sep 2002 22:06:12 -0400
Date: Thu, 12 Sep 2002 03:09:33 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Daniel Phillips <phillips@arcor.de>, Oliver Neukum <oliver@neukum.name>,
       Roman Zippel <zippel@linux-m68k.org>,
       Alexander Viro <viro@math.psu.edu>, kaos@ocs.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface
Message-ID: <20020912030933.A13608@kushida.apsleyroad.org>
References: <E17pFKr-0007V7-00@starship> <20020912014331.961472C12A@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020912014331.961472C12A@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Sep 12, 2002 at 11:42:45AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Ah, yes, four-point module interface: init, start, stop, destroy.
> Then you can call stop, realize the module is not at zero refcnt (you
> lost a race), then call start again.  Similar thing if someone
> requests a stopped module.

That's one fairly complicated way of going about it.

Simpler is three points: init, stop, destroy.  Stop is that part before
you call synchronise_kernel() - it's not something you can turn back
from.

If somebody needs the module, and it currently inside its
cleanup_module() function, they simply wait until destroy finishes, and
the module is unloaded, and then _reload_ the module from scratch.  So,
let the disk I/O happen.  This is a rare.

> Now you're going to have to change request_module() so the kernel can
> realize that you're requesting a module which already exists
> (request_module()'s effect currently depends on /etc/modules.conf of
> course).

Not at all.  Keep request_module() simple, and change module loading,
like this:

   1. Just before a module's cleanup_module() function is called, mark
      the module as "unloading".  This should force
      try_inc_mod_use_count() to fail, causing its caller to behave like
      the associated resource (e.g. filesystem) isn't actually
      registered, and to call request_module().

   2. request_module() should simply ignore modules marked as
      "unloading".  It should proceed to call "insmod" etc.

   3. sys_create_module() or sys_init_module() should block if there is
      a module of the same name currently in the "unloading" state.
      They should block until that module's cleanup_module() returns.

   4. At this point, the new instance of the module will initialise,
      request_module() calls will return and the callers which called
      try_inc_mod_use_count() in step 1 will continue with the resource
      they needed.

> Now, of course, your module interface is starting to look really
> complex, too.  Because you want to solve the "half-loaded" problem, so
> you really want "init" to reserve resources, and "start" to register
> them (ie. start can't fail).  So every register_xxx interface needs to
> be split into reserve_xxx and use_xxx.

I don't see the point in this at all.  What half-loaded problem?  If a
module is destroyed, then reloaded and fails to initialise properly:
tough.  It lost the resources fair and square.

> We can do all this, of course.  I have an awful lot of patches.  But
> I'm not really happy with any of them.

What do you think of the idea described above?: To mark modules as
"unloading" (as we do now), use synchronise_kernel() for an rcu-style
safety pause (as you suggested), and change module loading so that a
dying module is waited for before its replacement takes over?

-- Jamie
