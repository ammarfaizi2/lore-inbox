Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbTBTRsJ>; Thu, 20 Feb 2003 12:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266609AbTBTRsJ>; Thu, 20 Feb 2003 12:48:09 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:5078 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S266535AbTBTRqC>; Thu, 20 Feb 2003 12:46:02 -0500
Message-Id: <5.1.0.14.2.20030220093911.0d40b228@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 20 Feb 2003 09:52:10 -0800
To: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family 
Cc: kuznet@ms2.inr.ac.ru, jt@bougret.hpl.hp.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:04 PM 2/18/2003, David S. Miller wrote:
>>   From: Rusty Russell <rusty@rustcorp.com.au>
>>   Date: Wed, 19 Feb 2003 14:54:21 +1100
>>   
>>   Firstly, the owner field should probably be in struct proto_ops not
>>   struct socket, where the function pointers are.
>>
>>I think this is one of Alexey's main problems with the patch.
>This is a bit more informative than "oh it's an ugly hack" ;-)
>
>Ok. I got at least three reasons why I think owner field should be in struct 
>socket:
>        - struct proto_ops doesn't exists without struct socket.
>        It cannot be registered or otherwise used on it's own. 
>        - struct sock might inherit (when needed see my explanation about different families)
>        its owner from struct socket. In which case sk_set_owner(sk, socket->ops->owner) doesn't
>        look right.
>        - we might want to protect something else besides socket->ops.
>
>None of those reasons are critical. If you guys still feel that ->owner must be in struct 
>proto_ops be that way, I'm ok with it.
Ok. I'll take that back :).
The thing is that socket->ops is set from the protocol itself not in the generic socket code.
Here is what sock_create() does

        if (!(sock = sock_alloc())) 
        {
                printk(KERN_WARNING "socket: no more sockets\n");
                i = -ENFILE;            /* Not exactly a match, but its the
                                           closest posix thing */
                goto out;
        }

        sock->type  = type;

        if ((i = net_families[family]->create(sock, protocol)) < 0) 
        {
                sock_release(sock);
                goto out;
        }

It simply calls net_family->create() which then sets its private struct proto_ops.

So I think owner field should be in the struct socket because it needs to be 
accessible from net/socket.c:sock_create()/sock_release().

Dave, Alexey, do you guys still strongly believe that it's a hack ? 
If yes what do I need to do to convince otherwise ? ;-)

Max

