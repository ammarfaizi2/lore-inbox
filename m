Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbTBUBLo>; Thu, 20 Feb 2003 20:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbTBUBLo>; Thu, 20 Feb 2003 20:11:44 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:11671 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S265865AbTBUBLn>; Thu, 20 Feb 2003 20:11:43 -0500
Message-Id: <5.1.0.14.2.20030220165016.0d47c688@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 20 Feb 2003 17:17:52 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family 
Cc: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030221004041.05C1F2C2D5@lists.samba.org>
References: <Your message of "Thu, 20 Feb 2003 09:38:50 -0800." <5.1.0.14.2.20030220092216.0d3fefd0@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:30 PM 2/20/2003, Rusty Russell wrote:
>In message <5.1.0.14.2.20030220092216.0d3fefd0@mail1.qualcomm.com> you write:
>> >There has been talk of this, but OTOH, the admin has explicitly gone
>> >out of their way to remove this module.  They really don't want anyone
>> >new using it.  Presumably at this very moment they are killing off all
>> >the processes they can find with such a socket.
>> The thing is that once those processes are killed sockets will be 
>> destroyed and release the module anyway. i.e. There is no reason to
>> sort of artificially force accept() to fail. Everything will be cleaned 
>> up once the process is gone.
>
>Yes, but in practical terms it's probably going to fork a child with
>that socket.
But it will also be killed.

>> >I think it can be argued both ways, honestly.
>> Yep. And I'd argue in for of module_get() :)
>
>My only real insistence in this is that such an interface be called
>__try_module_get(), because the "__" warn people that it's a "you'd
>better know *exactly* what you are doing", even though the "try" is a
>bit of a misnomer.
Yeah, I think 'try' is definitely be a misnomer in this case.
How about something like this ?

static inline void __module_get(struct module *mod)
{
#ifdef CONFIG_MODULE_DETECT_API_VIOLATION
        if (!module_refcount(mod))
                __unsafe(mod);
#endif
        local_inc(&mod->ref[get_cpu()].count);
        put_cpu();
}

We will be able to compile the kernel with CONFIG_MODULE_DETECT_API_VIOLATION
and easily find all modules that call __module_get() without holding a reference.

Comments ?

Max





