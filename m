Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319558AbSIMIOk>; Fri, 13 Sep 2002 04:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319559AbSIMIOj>; Fri, 13 Sep 2002 04:14:39 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:61189 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S319558AbSIMIOd>; Fri, 13 Sep 2002 04:14:33 -0400
Message-ID: <3D819F6B.FBECDF0F@aitel.hist.no>
Date: Fri, 13 Sep 2002 10:18:51 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Raceless module interface
References: <20020912031345.760A32C061@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> In message <20020912030933.A13608@kushida.apsleyroad.org> you write:
> > I don't see the point in this at all.
> 
> Yes, I'm starting to realize that.
> 
> Frankly, I'm sick of pointing out the same problems individually to
> every shallow thinker who thinks that "it's easy".
> 
> The fundamental problems with modules are as follows:
> A) Many places in the kernel do not increment module reference counts
>    for you, and it is difficult currently write a module which safely
>    looks after its own reference counts (see
>    net/ipv4/netfilter/ip_conntrack_core.c's ip_conntrack_cleanup())

This sort of thing makes correct unloading hard, but in my eyes it
is an argument for changing the module interface to something better
and say "that thing CAN'T be a module of its own!"

What if we *require* modules to use some open/close reference count that
don't change so often as to be a performance problem?

It makes the unloading/reloading problem easier, similiar to
mount/umount.  

It'll work for lots of modules, such as: 
* drivers for hardware devices, char, block, and NIC.
* filesystems

Things with no easy refcounting (and it cannot even be grafted on)
will have to be non-modular, or folded into some parent module.

Maybe IP connection tracking can't be modular with these rules - so
what?  Make it compiled-in, or a part of the IPV4-module.  So
if you really need to load and unload that you unload the
ipv4_with_conntrack module and then load a ipv4_without_conntrack
module.

To me, it seems like the current module interface is too fine-grained,
and that cause trouble.  I.e. the overhead of correct refcounting
is so high in some cases that it isn't used - causing trouble
with safe unloading.  The solution is to say no to such modules.
Making them work isn't easy - but why try?


Helge Hafting
