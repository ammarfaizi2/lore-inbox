Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317883AbSGKTpq>; Thu, 11 Jul 2002 15:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317885AbSGKTpp>; Thu, 11 Jul 2002 15:45:45 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:23308 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317883AbSGKTpn>; Thu, 11 Jul 2002 15:45:43 -0400
Date: Thu, 11 Jul 2002 21:48:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Daniel Phillips <phillips@arcor.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, Alexander Viro <viro@math.psu.edu>,
       "David S. Miller" <davem@redhat.com>, <adam@yggdrasil.com>,
       <R.E.Wolff@bitwizard.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: Rusty's module talk at the Kernel Summit
In-Reply-To: <E17SigN-0002V1-00@starship>
Message-ID: <Pine.LNX.4.44.0207112059580.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Jul 2002, Daniel Phillips wrote:

> > Please check try_inc_mod_count(). It's already done.
>
> It's a good start, but it's not quite right.  Deregister_filesystem has to be
> the authority on whether the module can be deleted or not, and there's no
> interface for that at the moment.

That's right, but the filesystem code shows that this is not strictly
necessary. In get_fs_type() you can't get access to a filesystem that will
be removed, either it's first marked deleted or the use count is
incremented, both are protected by the unload_lock. file_systems_lock now
takes care that get_fs_type() doesn't see an invalid filesystem/owner
pointer.

> In short, it's close to the truth, but it's not quite there in its current
> form.  Al said as much himself.

He was talking about a generic interface. I stared now long enough at
that code, could anyone point me to where exactly is there a race in
the filesystem code??? IMO it's more complex than necessary (because it
has to work around the problem that unregister can't fail), but it should
work.
BTW this example shows also the limitation of the current module
interface. It's impossible for a module to control itself, whether it can
be unloaded or not. All code for this must be outside of this module,
after __MOD_DEC_USE_COUNT() the module must not be touched anymore (so
this call can't be inside of a module).

bye, Roman

