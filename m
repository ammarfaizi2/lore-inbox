Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSILLXQ>; Thu, 12 Sep 2002 07:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSILLXQ>; Thu, 12 Sep 2002 07:23:16 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:17422 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315278AbSILLXP>; Thu, 12 Sep 2002 07:23:15 -0400
Date: Thu, 12 Sep 2002 13:27:10 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Daniel Phillips <phillips@arcor.de>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Raceless module interface
In-Reply-To: <E17pCKQ-0007Sz-00@starship>
Message-ID: <Pine.LNX.4.44.0209121043160.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 11 Sep 2002, Daniel Phillips wrote:

> Ah, I remember your original post but I didn't fully understand what you were
> going on about at the time.  Now I do, and we're on the same page.  Not only
> that, but I'm getting to the point with this messy problem where I can
> articulate the issues clearly, so let's try to do it now.  Please ack/nack me
> as I go.
>
> First, let's identify the central issue that's causing conceptual problems
> for some who've sniffed at these issues.  It's simple, there are two broad
> categories of modules:

Sigh, please let's analyze the complete problem first, before making any
more kludges.
Every (loaded) module is at least registered with two hooks in the kernel
- the module structure and a driver structure (e.g. file_system_type for
fs). During unloading we have to remove these hooks safely again.
A module basically goes through these stages during its lifetime:
1. module load
2. module init
3. module exit
4. module unload
The problem now is stage 3, as it's not allowed to fail. This means before
we even start with module exit, we have to make sure nobody has any
reference and nobody gets any new reference to the module through any
hook (the alternative would be to possibly wait forever in the exit
function to wait for these references to go away). So nobody is allowed to
increment the module count or to get any pointer to the driver, this on
the other hand means before you take any reference to the driver, you have
to check the state of the module, so any driver hook must include a
pointer to the module structure. This is also what makes the locking
interesting, since module structure and driver hooks are protected with
different locks, both have to be taken to safely get a single reference to
the driver.
So how does this whole picture change, if we allow the module exit to
fail? Module load/unload and module init/exit can become two independent
stages. This means in order to remove a driver hook, we don't have to
check the module state anymore. Module exit only has to make sure, that
all driver hooks and all references to the driver are gone. How it does
that exactly is up to the driver, whether it uses reference counts, RCU or
other scheduler tricks doesn't matter. We gain complete flexibility here,
only by allowing the exit function to fail.
It's really important to understand this consequence in order to
understand my patch (e.g. try_inc_mod_count() became a dummy). With the
exception of module loading I completely disabled the old interface, but
it probably has to be reenabled (with a big warning) until enough modules
are converted. The start/stop methods I added are completely irrellevant
to solving this problem, they only give us more flexibility in the module
handling, e.g. we can disable new fs mounts, while the fs still has
something mounted.
Anyway, the important consequence is that we can sanely clean up the
module interface this way. The module load/unload phase is private to the
module code, the module init/exit phase is private to the driver. This
means while the module or the driver is in control it doesn't has to
care about the state of the other part.
The core problem is actually not that difficult, you only have to forget
all the old cruft, it's only causing confusion and is not worth fixing.

bye, Roman

