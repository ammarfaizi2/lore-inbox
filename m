Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSILM6s>; Thu, 12 Sep 2002 08:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSILM6r>; Thu, 12 Sep 2002 08:58:47 -0400
Received: from dp.samba.org ([66.70.73.150]:34518 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S315454AbSILM6q>;
	Thu, 12 Sep 2002 08:58:46 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface 
In-reply-to: Your message of "Thu, 12 Sep 2002 13:27:10 +0200."
             <Pine.LNX.4.44.0209121043160.28515-100000@serv> 
Date: Thu, 12 Sep 2002 23:03:18 +1000
Message-Id: <20020912130337.3FFBF2C1CD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209121043160.28515-100000@serv> you write:
> Sigh, please let's analyze the complete problem first, before making any
> more kludges.
> Every (loaded) module is at least registered with two hooks in the kernel
> - the module structure and a driver structure (e.g. file_system_type for
> fs). During unloading we have to remove these hooks safely again.
> A module basically goes through these stages during its lifetime:
> 1. module load
> 2. module init
> 3. module exit
> 4. module unload
> The problem now is stage 3, as it's not allowed to fail. This means before

Nope, that's one of the two problems.  Read my previous post: the
other is partial initialization.

Your patch is two-stage delete, with the additional of a usecount
function.  So you have to move the usecount from the module to each
object it registers: great for filesystems, but I don't think it buys
you anything (since they were easy anyway).

Moreover, I don't see where your patch prevented someone increasing
the module count during try_unregister_module(), so that check is
pointless (do it in userspace unless they specify rmmod -f).

Alexey said we needed two-stage module delete back in 1999, so this is
not a new idea...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
