Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319500AbSIMCMZ>; Thu, 12 Sep 2002 22:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319504AbSIMCMZ>; Thu, 12 Sep 2002 22:12:25 -0400
Received: from dsl-213-023-020-157.arcor-ip.net ([213.23.20.157]:18828 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319500AbSIMCMY>;
	Thu, 12 Sep 2002 22:12:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] Raceless module interface
Date: Fri, 13 Sep 2002 04:19:18 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
References: <20020913015502.1D43F2C070@lists.samba.org>
In-Reply-To: <20020913015502.1D43F2C070@lists.samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pg3H-0007pb-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 03:30, Rusty Russell wrote:
> In message <Pine.LNX.4.44.0209121520300.28515-100000@serv> you write:
> > The usecount is optional, the only important question a module must be
> > able to answer is: Are there any objects/references belonging to the
> > module? It's a simple yes/no question. If a module can't answer that, it
> > likely has more problem than just module unloading.
> 
> Ah, we're assuming you insert synchronize_kernel() between the call
> to stop and the call to exit?
> 
> In which case *why* do you check the use count *inside* exit_affs_fs?
> Why not get exit_module() to do "if (mod->usecount() != 0) return
> -EBUSY; else mod->exit();"?

Because mod->usecount may be a totally inadequate way of determining
if a module is busy.  How does it work for LSM, for example?

> There's the other issue of symmetry.  If you allocate memory, in
> start, do you clean it up in stop or exit?

Actually, I'm going to press you on why you think you even need a
two stage stop.  I know you have your reasons, but I doubt any of
the effects you aim at cannot be achieved with a single stage
stop/exit.  Could you please summarize the argument in favor of the
two stage stop?

> Similarly for other
> resources: you call mod->exit() every time start fails, so that is
> supposed to check that mod->start() succeeded?

He does?  That's not right.  ->start should clean up after itself if
it fails, like any other good Linux citizen.

> Of course, separating start into "init" and "start" allows you to
> solve the half-initialized problem as well as clarify the rules.

I doubt it gives any new capability at all.  The same with the
entrenched separation at the user level between create and init
module: what does it give you that an error exit from a single
create/init would not?  Sure, I know it's not going to change,
but I'd like to know what the thinking was, and especially, if
there's a non-bogus reason, I'd like to know it.

-- 
Daniel
