Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTBSRkI>; Wed, 19 Feb 2003 12:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTBSRkI>; Wed, 19 Feb 2003 12:40:08 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:41981 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S261495AbTBSRkG>; Wed, 19 Feb 2003 12:40:06 -0500
Message-Id: <5.1.0.14.2.20030219092611.0d0d00c8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 19 Feb 2003 09:45:59 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family 
Cc: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030219035559.7527A2C079@lists.samba.org>
References: <Your message of "Tue, 18 Feb 2003 10:50:49 -0800." <5.1.0.14.2.20030218101309.048d4288@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:54 PM 2/18/2003, Rusty Russell wrote:
>In message <5.1.0.14.2.20030218101309.048d4288@mail1.qualcomm.com> you write:
>> At 07:46 PM 2/17/2003, David S. Miller wrote:
>> 
>> >After talking to Alexey, I don't like this patch.
>> >
>> >The new module subsystem was supposed to deal with things
>> >like this cleanly, and this patch is merely a hack to cover
>> >up for it's shortcomings.
>
>I don't quite understand.  
>
>There are some issue with this patch, however.
>
>Firstly, the owner field should probably be in struct proto_ops not
>struct socket, where the function pointers are.
struct proto_ops doesn't exists on its own without struct socket.
I think it make sense to simply keep track of the sockets but I don't 
see any problem with putting it in proto_ops.

struct sock is different though. callbacks are inside.

>The sk thing looks reasonable at first glance.  Getting a reference to
>npf->owner, then holding it for the socket is a little confusing, but
>an obvious optimization over a naive "get, use, drop, get".
That was an optimization indeed. There is no point in dropping reference
there.


>In sys_accept:
>
>> @@ -1196,9 +1198,13 @@
>>       if (!(newsock = sock_alloc())) 
>>               goto out_put;
>>  
>> -     newsock->type = sock->type;
>> -     newsock->ops = sock->ops;
>> +     newsock->type  = sock->type;
>> +     newsock->ops   = sock->ops;
>> +     newsock->owner = sock->owner;
>>  
>> +     try_module_get(sock->owner);
>> +     newsock->owner = sock->owner;
>> +     
>>       err = sock->ops->accept(sock, newsock, sock->file->f_flags);
>>       if (err < 0)
>>               goto out_release;
>
>You still need to check the result of try_module_get, and fail if it
>fails.  The *only* time this will fail is when someone is doing an
>"rmmod --wait" on the module, which presumably means they really do
>not want you to increase the reference count furthur.
Ohh, I see. My assumption here was that we know for sure 
that module is alive at this point since we already hold a reference to the 
first socket. Actually I was going to send another email and ask for unconditional 
module_get() specifically for the cases like that. 

Even after your explanation I still think we need unconditional module_get() there.
Because in this case 'rmmod --wait' will simply brake accept() logic. I mean it'll 
keep waiting until listening socket is destroyed (i.e. until socket app is killed) 
but accept() will mysteriously fail for no good reason.
Comments ?

Max

