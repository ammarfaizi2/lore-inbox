Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317979AbSGLDxx>; Thu, 11 Jul 2002 23:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSGLDxw>; Thu, 11 Jul 2002 23:53:52 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:16821 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317979AbSGLDxv>;
	Thu, 11 Jul 2002 23:53:51 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: Roman Zippel <zippel@linux-m68k.org>
Cc: Daniel Phillips <phillips@arcor.de>, "David S. Miller" <davem@redhat.com>,
       adam@yggdrasil.com, R.E.Wolff@bitwizard.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit 
In-reply-to: Your message of "Thu, 11 Jul 2002 19:37:17 -0400."
             <Pine.GSO.4.21.0207111928390.9488-100000@weyl.math.psu.edu> 
Date: Fri, 12 Jul 2002 13:53:27 +1000
Message-Id: <20020712035658.83B41412D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.4.21.0207111928390.9488-100000@weyl.math.psu.edu> you writ
e:
> For filesystems the only currently existing race is in the case when
> init_module() registers one, then decides to bail out and unregisters it.
> If somebody finds the thing between register/unregister the current code
> is screwed.  And no, "don't block in between" is not viable - typically
> the reason of failure is failing allocation and/or timeouts on some sort
> of probing.

Yes.  Of course, drivers tend to be more lax about registering things
*then* setting up the internal stage than filesystems, so they have a
race even without failure (this is, of course, entirely soluble one
driver at a time).

> As for determining the loading/normal/unloading - we _already_ have that
> state, no need to introduce new fields.  How do you think try_inc_mod_count()
> manages to work?  Exactly - there's a field of struct module that contains
> a bunch of flags.  And no, Daniel's ramblings (from what I've seen quoted)
> are pure BS - there's no need to mess with "oh, but I refuse to be
> unregistered"; proper refcounting is easy for normal cases.

try_inc_mod_count() is a hack.  I'm not allergic to hacks: from a
purist POV, any module solution short of "anything can be a module" is
a hack, but you should realize its weaknesses.

As implemented, it results in spurious failure.  Failing to do
something because the module was being removed at the time, and
falling back to module load fails because the old module hasn't
released some resource yet.

> It's not needed.  I don't see where this ret-rmmod crap is coming from -
> module uses some interface and decisions about holding it pinned belong
> to that interface.  Plain, simple and works for all normal drivers.

Sure, but you must define what interfaces modules are allowed to use,
Al.  And any module using an interface not on those lists can't be
unloaded.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
