Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbTDWWja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbTDWWja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:39:30 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:20453 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S264282AbTDWWj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:39:27 -0400
Message-Id: <5.1.0.14.2.20030423134636.100e5c60@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 23 Apr 2003 15:51:11 -0700
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [BK ChangeSet@1.1118.1.1] new module infrastructure for
  net_proto_family
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, netdev@oss.sgi.com
In-Reply-To: <20030423192640.GD26052@conectiva.com.br>
References: <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com>
 <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:26 PM 4/23/2003, Arnaldo Carvalho de Melo wrote:
>Em Wed, Apr 23, 2003 at 12:13:37PM -0700, Max Krasnyansky escreveu:
>> Hi Folks,
>> 
>> Can somebody (DaveM perhaps) please explain to me what the hell the following 
>> changset is doing in 2.5.68 
>>         http://linux.bkbits.net:8080/linux-2.5/cset@1.1118.1.1?nav=index.html|ChangeSet@-7d
>> ??
>> 
>> I've spent quite a bit of time looking into what's needed to fix socket module refcounting
>> issues and convicting DaveM and Alex that we need to fix them.
>> Here is the original thread
>>         http://marc.theaimsgroup.com/?l=linux-kernel&m=104308300808557&w=2
>
>I was not aware of this thread, will read it
Please do.

>> My patch was rejected without giving any technical explanation. I was waiting for Rusty's
>> __module_get() patch to get in, to release a new patch which addresses some issues that
>> came up during discussion.
>> Next thing you know, incomplete patch (changeset mentioned above) shows up in the BK and
>> 2.5.68. Without even a simple note on the lkm. And completely ignoring discussion that 
>> we had about this very issue just a few weeks ago.
>
>This is just the first part, DaveM already merged the second part, that deals with struct sock
That's exactly what surprised me. He rejected complete patch and accepted something incomplete
and broken.

>> I don't mind of course if some other (better) patch is accepted instead of mine. But patch 
>> that went in is incomplete and buggy. It doesn't handle accept case properly and doesn't 
>> address the issue of the 'struct sock' ownership (read original thread for more details).
>
>This is dealt with the following patch, and these patches were discussed on the netdev
>mailing list. Considerations ? I'll be sending today patches converting the net protocols
>that I maintain and then for some others that are ummaintained, etc.
I thought changes like that are always discussed on the lkml. They are directly related to the 
new module interface changes. It least CC lkml.

(I've subscribed to netdev list)

The latest patches that I've seen from you on netdev list and in main BK tree still don't 
handle accept() properly

net/socket.c:sys_accept()
        ...
        if (!(newsock = sock_alloc())) 
                goto out_put;

        newsock->type = sock->type;
        newsock->ops = sock->ops;
         ...

newsock is not accounted for (sock_alloc() doesn't bump module refcount).

> struct sock *sk_alloc(int family, int priority, int zero_it, kmem_cache_t *slab)
> {
>-       struct sock *sk;
>-       
>+       struct sock *sk = NULL;
>+
>+       if (!net_family_get(family))
>+               goto out;

Ok. This is wrong. Which should be clear from reading the thread that I mentioned.
Owner of the net_proto_family is not necessarily the owner of the 'struct sock'.
Example: af_inet module registers net_proto_family but udp module owns the socket.
(not that IPv4 code is modular but just an example). Another example would be Bluetooth.
We have Bluetooth core that registers Bluetooth proto_family and several modules
that handle specific protocols (l2cap, rfcomm, etc).

Also net_proto_family has pretty much nothing to do with the struct sock. The only reason 
we would want to hold reference to the module is if the module has replaced default 
callbacks (i.e. sk->data_ready(), etc).
So my point is we need sk->owner field. 

I'd also prefer to see sock->owner which gives more flexibility (i.e. net_proto_family can 
be unregistered while struct socket still exist, etc). 
net_family_get/put() makes no sense net_proto_family has only one function npf->create() 
which is referenced only from net/socket.c. struct socket should inherit owner field from
struct net_proto_family by default but protocol should be able to assign ownership to a 
different module if it needs to.

So I'd suggest reverting the patches that went in and applying my patch instead. Not because 
its mine but because IMO it's a better starting point. Dave, comments ?

Thanks
Max

