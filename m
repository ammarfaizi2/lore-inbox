Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSGLL1w>; Fri, 12 Jul 2002 07:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315971AbSGLL1v>; Fri, 12 Jul 2002 07:27:51 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:23053 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315942AbSGLL1u>; Fri, 12 Jul 2002 07:27:50 -0400
Date: Fri, 12 Jul 2002 13:30:17 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Alexander Viro <viro@math.psu.edu>
cc: Daniel Phillips <phillips@arcor.de>, Rusty Russell <rusty@rustcorp.com.au>,
       "David S. Miller" <davem@redhat.com>, <adam@yggdrasil.com>,
       <R.E.Wolff@bitwizard.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: Rusty's module talk at the Kernel Summit
In-Reply-To: <Pine.GSO.4.21.0207111928390.9488-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0207121257470.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Jul 2002, Alexander Viro wrote:

> For filesystems the only currently existing race is in the case when
> init_module() registers one, then decides to bail out and unregisters it.
> If somebody finds the thing between register/unregister the current code
> is screwed.  And no, "don't block in between" is not viable - typically
> the reason of failure is failing allocation and/or timeouts on some sort
> of probing.

In the load path there are more races. Read access to the module list is
only protected by the BKL. This makes it possible to create multiple
modules with the same name in sys_create_module (module_map() can sleep).

> As for determining the loading/normal/unloading - we _already_ have that
> state, no need to introduce new fields.  How do you think try_inc_mod_count()
> manages to work?  Exactly - there's a field of struct module that contains
> a bunch of flags.  And no, Daniel's ramblings (from what I've seen quoted)
> are pure BS - there's no need to mess with "oh, but I refuse to be
> unregistered"; proper refcounting is easy for normal cases.

normal cases or simple cases? The filesystem interface is a very simple
one, now e.g. add a proc interface to it. The current module interface
requires that any first reference to a module must be protected against
module load/unload and unregister, what requires two locks. It could be
reduced to a single lock, if the module was allowed to let the unload
fail, because there are still users. The module actually knows best,
whether there are still references to the module, but it can't tell that
the kernel.

bye, Roman

