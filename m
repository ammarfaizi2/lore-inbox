Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbTBTRdr>; Thu, 20 Feb 2003 12:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbTBTRdr>; Thu, 20 Feb 2003 12:33:47 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:49398 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S266379AbTBTRcx>; Thu, 20 Feb 2003 12:32:53 -0500
Message-Id: <5.1.0.14.2.20030220092216.0d3fefd0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 20 Feb 2003 09:38:50 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family 
Cc: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030220041225.AC0A42C5AB@lists.samba.org>
References: <Your message of "Wed, 19 Feb 2003 09:45:59 -0800." <5.1.0.14.2.20030219092611.0d0d00c8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:21 PM 2/19/2003, Rusty Russell wrote:
>In message <5.1.0.14.2.20030219092611.0d0d00c8@mail1.qualcomm.com> you write:
>> >Firstly, the owner field should probably be in struct proto_ops not
>> >struct socket, where the function pointers are.
>> struct proto_ops doesn't exists on its own without struct socket.
>> I think it make sense to simply keep track of the sockets but I don't 
>> see any problem with putting it in proto_ops.
>
>Well, the purpose is to stop those methods from vanishing, so it makes
>sense to have the owner field next to those pointers.  It's
>nitpicking, really.
Actually I think I have strong reason to have it in struct socket. I'll reply to
Dave's email and explain it there.

>> >> +     try_module_get(sock->owner);
>> >> +     newsock->owner = sock->owner;
>> >> +     
>> >>       err = sock->ops->accept(sock, newsock, sock->file->f_flags);
>> >>       if (err < 0)
>> >>               goto out_release;
>> >
>> >You still need to check the result of try_module_get, and fail if it
>> >fails.  The *only* time this will fail is when someone is doing an
>> >"rmmod --wait" on the module, which presumably means they really do
>> >not want you to increase the reference count furthur.
>
>> Ohh, I see. My assumption here was that we know for sure that module
>> is alive at this point since we already hold a reference to the
>> first socket. Actually I was going to send another email and ask for
>> unconditional module_get() specifically for the cases like that.
>
>There has been talk of this, but OTOH, the admin has explicitly gone
>out of their way to remove this module.  They really don't want anyone
>new using it.  Presumably at this very moment they are killing off all
>the processes they can find with such a socket.
The thing is that once those processes are killed sockets will be 
destroyed and release the module anyway. i.e. There is no reason to
sort of artificially force accept() to fail. Everything will be cleaned 
up once the process is gone.

>My other reluctance is that people will use "module_get" the way they
>used MOD_INC_USE_COUNT() (ie. when *not* already holding a reference),
>and we'll have all those races back.
Yes that'd be wrong. However I think in general when module wants to create 
a copy of its own object (ie already holds reference) it should be able to 
copy the object and simply bump refcount with module_get(). That will help 
to avoid a lot of unnecessary error recovery paths (like in the accept() case).

>I think it can be argued both ways, honestly.
Yep. And I'd argue in for of module_get() :)

Thanks
Max

