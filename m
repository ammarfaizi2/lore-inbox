Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267966AbTBSDp6>; Tue, 18 Feb 2003 22:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267970AbTBSDp6>; Tue, 18 Feb 2003 22:45:58 -0500
Received: from dp.samba.org ([66.70.73.150]:2237 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267966AbTBSDp4>;
	Tue, 18 Feb 2003 22:45:56 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family 
In-reply-to: Your message of "Tue, 18 Feb 2003 10:50:49 -0800."
             <5.1.0.14.2.20030218101309.048d4288@mail1.qualcomm.com> 
Date: Wed, 19 Feb 2003 14:54:21 +1100
Message-Id: <20030219035559.7527A2C079@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <5.1.0.14.2.20030218101309.048d4288@mail1.qualcomm.com> you write:
> At 07:46 PM 2/17/2003, David S. Miller wrote:
> 
> >After talking to Alexey, I don't like this patch.
> >
> >The new module subsystem was supposed to deal with things
> >like this cleanly, and this patch is merely a hack to cover
> >up for it's shortcomings.

I don't quite understand.  

There are some issue with this patch, however.

Firstly, the owner field should probably be in struct proto_ops not
struct socket, where the function pointers are.

The sk thing looks reasonable at first glance.  Getting a reference to
npf->owner, then holding it for the socket is a little confusing, but
an obvious optimization over a naive "get, use, drop, get".

In sys_accept:

> @@ -1196,9 +1198,13 @@
>  	if (!(newsock = sock_alloc())) 
>  		goto out_put;
>  
> -	newsock->type = sock->type;
> -	newsock->ops = sock->ops;
> +	newsock->type  = sock->type;
> +	newsock->ops   = sock->ops;
> +	newsock->owner = sock->owner;
>  
> +	try_module_get(sock->owner);
> +	newsock->owner = sock->owner;
> +	
>  	err = sock->ops->accept(sock, newsock, sock->file->f_flags);
>  	if (err < 0)
>  		goto out_release;

You still need to check the result of try_module_get, and fail if it
fails.  The *only* time this will fail is when someone is doing an
"rmmod --wait" on the module, which presumably means they really do
not want you to increase the reference count furthur.

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
