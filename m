Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbTBTECW>; Wed, 19 Feb 2003 23:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbTBTECW>; Wed, 19 Feb 2003 23:02:22 -0500
Received: from dp.samba.org ([66.70.73.150]:6080 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264815AbTBTECV>;
	Wed, 19 Feb 2003 23:02:21 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family 
In-reply-to: Your message of "Wed, 19 Feb 2003 09:45:59 -0800."
             <5.1.0.14.2.20030219092611.0d0d00c8@mail1.qualcomm.com> 
Date: Thu, 20 Feb 2003 12:21:08 +1100
Message-Id: <20030220041225.AC0A42C5AB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <5.1.0.14.2.20030219092611.0d0d00c8@mail1.qualcomm.com> you write:
> >Firstly, the owner field should probably be in struct proto_ops not
> >struct socket, where the function pointers are.
> struct proto_ops doesn't exists on its own without struct socket.
> I think it make sense to simply keep track of the sockets but I don't 
> see any problem with putting it in proto_ops.

Well, the purpose is to stop those methods from vanishing, so it makes
sense to have the owner field next to those pointers.  It's
nitpicking, really.

> struct sock is different though. callbacks are inside.

Yes.

> >> +     try_module_get(sock->owner);
> >> +     newsock->owner = sock->owner;
> >> +     
> >>       err = sock->ops->accept(sock, newsock, sock->file->f_flags);
> >>       if (err < 0)
> >>               goto out_release;
> >
> >You still need to check the result of try_module_get, and fail if it
> >fails.  The *only* time this will fail is when someone is doing an
> >"rmmod --wait" on the module, which presumably means they really do
> >not want you to increase the reference count furthur.

> Ohh, I see. My assumption here was that we know for sure that module
> is alive at this point since we already hold a reference to the
> first socket. Actually I was going to send another email and ask for
> unconditional module_get() specifically for the cases like that.

There has been talk of this, but OTOH, the admin has explicitly gone
out of their way to remove this module.  They really don't want anyone
new using it.  Presumably at this very moment they are killing off all
the processes they can find with such a socket.

My other reluctance is that people will use "module_get" the way they
used MOD_INC_USE_COUNT() (ie. when *not* already holding a reference),
and we'll have all those races back.

I think it can be argued both ways, honestly.

Clarifies?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
