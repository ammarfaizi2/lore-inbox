Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSGKXek>; Thu, 11 Jul 2002 19:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSGKXek>; Thu, 11 Jul 2002 19:34:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23221 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313087AbSGKXei>;
	Thu, 11 Jul 2002 19:34:38 -0400
Date: Thu, 11 Jul 2002 19:37:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Daniel Phillips <phillips@arcor.de>, Rusty Russell <rusty@rustcorp.com.au>,
       "David S. Miller" <davem@redhat.com>, adam@yggdrasil.com,
       R.E.Wolff@bitwizard.nl, linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit
In-Reply-To: <Pine.LNX.4.44.0207112059580.8911-100000@serv>
Message-ID: <Pine.GSO.4.21.0207111928390.9488-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jul 2002, Roman Zippel wrote:

> > In short, it's close to the truth, but it's not quite there in its current
> > form.  Al said as much himself.
> 
> He was talking about a generic interface. I stared now long enough at
> that code, could anyone point me to where exactly is there a race in
> the filesystem code??? IMO it's more complex than necessary (because it
> has to work around the problem that unregister can't fail), but it should
> work.

For filesystems the only currently existing race is in the case when
init_module() registers one, then decides to bail out and unregisters it.
If somebody finds the thing between register/unregister the current code
is screwed.  And no, "don't block in between" is not viable - typically
the reason of failure is failing allocation and/or timeouts on some sort
of probing.

As for determining the loading/normal/unloading - we _already_ have that
state, no need to introduce new fields.  How do you think try_inc_mod_count()
manages to work?  Exactly - there's a field of struct module that contains
a bunch of flags.  And no, Daniel's ramblings (from what I've seen quoted)
are pure BS - there's no need to mess with "oh, but I refuse to be
unregistered"; proper refcounting is easy for normal cases.

> BTW this example shows also the limitation of the current module
> interface. It's impossible for a module to control itself, whether it can
> be unloaded or not. All code for this must be outside of this module,
> after __MOD_DEC_USE_COUNT() the module must not be touched anymore (so
> this call can't be inside of a module).

It's not needed.  I don't see where this ret-rmmod crap is coming from -
module uses some interface and decisions about holding it pinned belong
to that interface.  Plain, simple and works for all normal drivers.

/me ponders removing Daniel from killfile and decides that it's not worth
the trouble...

