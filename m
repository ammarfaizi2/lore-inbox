Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319403AbSILBin>; Wed, 11 Sep 2002 21:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319405AbSILBin>; Wed, 11 Sep 2002 21:38:43 -0400
Received: from dp.samba.org ([66.70.73.150]:39392 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319403AbSILBil>;
	Wed, 11 Sep 2002 21:38:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface 
In-reply-to: Your message of "Wed, 11 Sep 2002 20:35:05 +0200."
             <E17pCKQ-0007Sz-00@starship> 
Date: Thu, 12 Sep 2002 11:31:21 +1000
Message-Id: <20020912014331.908E42C123@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17pCKQ-0007Sz-00@starship> you write:
> Hi Roman,
> 
> On Tuesday 10 September 2002 12:17, Roman Zippel wrote:
> > I implemented something like this some time ago. If module->count isn't
> > used by module.c anymore, why should it be in the module structure?
> > Consequently I removed it from the module struct (what breaks of course
> > unloading of all modules, so I'll probably reintroduce it with big a
> > warning). If the count isn't in the module structure, the locking will
> > become quite simpler. More info is here
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=102754132716703&w=2
> 
> Ah, I remember your original post but I didn't fully understand what you were

I hate people who can't be concise.  It's a sign of sloppy thinking.

1) You only need reference counts if you want to unload a module.

2) A module can control its own reference counts safely if it does not
   sleep without holding a reference, and you use the rcu patch's
   synchronize_kernel() primitive.

3) Relying on *every* driver to control its own reference counts is a
   recipe for disaster: some subsystems will want to control module
   counts for their users.

4) Moving reference counts out of the module and into the particular
   objects is *not* a good idea, since per-cpu cache-friendly
   refcounting schemes are (almost by definition) about
   SMP_CACHE_BYTES*NR_CPUS in size.

Hope I haven't missed anything,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
