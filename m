Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317978AbSGLBwi>; Thu, 11 Jul 2002 21:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317979AbSGLBwh>; Thu, 11 Jul 2002 21:52:37 -0400
Received: from dsl-213-023-020-198.arcor-ip.net ([213.23.20.198]:10707 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317978AbSGLBwg>;
	Thu, 11 Jul 2002 21:52:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Alexander Viro <viro@math.psu.edu>, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Rusty's module talk at the Kernel Summit
Date: Fri, 12 Jul 2002 03:54:58 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "David S. Miller" <davem@redhat.com>, adam@yggdrasil.com,
       R.E.Wolff@bitwizard.nl, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0207111928390.9488-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0207111928390.9488-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Spe7-0002az-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 July 2002 01:37, Alexander Viro wrote:
> As for determining the loading/normal/unloading - we _already_ have that
> state, no need to introduce new fields.  How do you think try_inc_mod_count()
> manages to work?  Exactly - there's a field of struct module that contains
> a bunch of flags.  And no, Daniel's ramblings (from what I've seen quoted)
> are pure BS - there's no need to mess with "oh, but I refuse to be
> unregistered"; proper refcounting is easy for normal cases.

I don't particularly like using the mod count to hold a module in memory.
It's workable but sloppy.  Supposing that the mod count counts the number
of filesystems mounted (it doesn't, it counts the number of mounts, an
even sillier thing to count), and supposing all are unmounted but the
module can't unregister itself for some other reason, say some thread it
owns hasn't exited yet.  Yes, you could say the mod count is the count of
all mounts, plus all the threads the module owns, plus more counts for
other resources the module owns, but why?  Just let the unregister routine
return failure, it's more general and a simpler interface.  Besides,

> It's not needed.  I don't see where this ret-rmmod crap is coming from -
> module uses some interface and decisions about holding it pinned belong
> to that interface.

The ret-rmmod race is what you get when you rely on something in the
module dec'ing the use count, and somebody can come along later to throw
the module out of memory - stepping on still-executing ret code.  This
race isn't obviously gone.

Speaking of crap, this is nothing to be proud of:

637                 spin_lock(&unload_lock);
638                 if (mod->refs == NULL
639                     && (mod->flags & MOD_AUTOCLEAN)
640                     && (mod->flags & MOD_RUNNING)
641                     && !(mod->flags & MOD_DELETED)
642                     && (mod->flags & MOD_USED_ONCE)
643                     && !__MOD_IN_USE(mod)) {
644                         if ((mod->flags & MOD_VISITED)
645                             && !(mod->flags & MOD_JUST_FREED)) {
646                                 spin_unlock(&unload_lock);
647                                 mod->flags &= ~MOD_VISITED;
648                         } else {
649                                 mod->flags |= MOD_DELETED;
650                                 spin_unlock(&unload_lock);
651                                 free_module(mod, 1);
652                                 something_changed = 1;
653                         }
654                 } else {
655                         spin_unlock(&unload_lock);
656                 }

I'm not going to be very easily convinced that the result of this
current effort is going to be the most elegant possible.  Yes, I expect
it to work eventually, but as an shining example of transparent code...
it just isn't.

The rest of the interface seems to run about the same level of
cleanliness.  I suppose I shouldn't be so quick to put away my
dung-shovel.

> Plain, simple and works for all normal drivers.

That we agree on.

-- 
Daniel
