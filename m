Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTDXTVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 15:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTDXTVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 15:21:48 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:4806 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S263468AbTDXTVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 15:21:42 -0400
Message-Id: <5.1.0.14.2.20030424094431.080b5320@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 24 Apr 2003 12:33:35 -0700
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [BK ChangeSet@1.1118.1.1] new module infrastructure for
  net_proto_family
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20030424064453.GA29078@conectiva.com.br>
References: <5.1.0.14.2.20030423134636.100e5c60@unixmail.qualcomm.com>
 <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com>
 <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com>
 <5.1.0.14.2.20030423134636.100e5c60@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

>I did, there are several valid points, I forgot the sys_accept case, I'm
>studying the code to see how to properly fix it,
It's pretty easy if we have sock->owner. Take a look how my patch does it 
(try_module_get should be replaced with __module_get()).
It also covers the case when net_family_owner transferred ownership to the
other module.

>but one thing I want covered
>is keeping the net_families registered while there is still a struct sock
>associated with the proto family, while not allowing the criation of new sockets
>till the last struct sock is sk_freed.
Why ?
Like I said all we care about is if non default callbacks in struct sock are valid.
Please read below.

>Think about protecting the module with the top level network protocol family
>->create code on sock_create level and the modules with specific protocols at
><net_proto_family>_sock_create level.
With the current infrastructure you'd need some kind of callback from sk_free() for
that to work.
I think it's simpler with sk->owner.

>> > struct sock *sk_alloc(int family, int priority, int zero_it, kmem_cache_t *slab)
>> > {
>> >-       struct sock *sk;
>> >-       
>> >+       struct sock *sk = NULL;
>> >+
>> >+       if (!net_family_get(family))
>> >+               goto out;
>> 
>> Ok. This is wrong. Which should be clear from reading the thread that I mentioned.
>> Owner of the net_proto_family is not necessarily the owner of the 'struct sock'.
>> Example: af_inet module registers net_proto_family but udp module owns the socket.
>> (not that IPv4 code is modular but just an example). Another example would be Bluetooth.
>> We have Bluetooth core that registers Bluetooth proto_family and several modules
>> that handle specific protocols (l2cap, rfcomm, etc).
>
>I'm think that this can be handled at this protocol family code level, i.e.  if
>the net_proto_family wants to further modularise based on specific protocol
>type this has to be refcounted at this level, example, at bt_sock_create.
Sure. Transfer of the ownership has to be done on that level. What I'm saying is
that everything else can be done in generic code. 

>> Also net_proto_family has pretty much nothing to do with the struct sock. The only reason 
>> we would want to hold reference to the module is if the module has replaced default 
>> callbacks (i.e. sk->data_ready(), etc).
>> So my point is we need sk->owner field. 
>
>That is a way to solve it, yes, but I don't think the only one,
>net_proto_family has to do with the struct sock as those data structures are
>related to the network protocol family.
By the same logic all things are related in the kernel :).
struct socket uses net_proto_family ops and stuff and therefor is related.
But struct sock is just a callbacks.

>> I'd also prefer to see sock->owner which gives more flexibility (i.e.
>> net_proto_family can be unregistered while struct socket still exist, etc).
>> net_family_get/put() makes no sense net_proto_family has only one function
>> npf->create() which is referenced only from net/socket.c. struct socket
>> should inherit owner field from struct net_proto_family by default but
>> protocol should be able to assign ownership to a different module if it needs
>> to.
>
>I'm studying how to signal that the net_proto_family was unregistered while
>still having the entry in net_families available, that is a problem with the
>current infrastructure in Linus tree.
Why do you need that ? 
Let's just get rid of the net_family_get/put thing. Each socket will have owner
field so we know who owns it and there is no need to access global net_family 
table.

>Sorry, today I didn't had time to work on this at night at home, but tomorrow
>I'll be working on this, thing is, as I'm working only on having the
>infrastructure in place and no protocols have ->owner set there is no way to
>trigger the problems discussed in this message in any way.
I actually had it all working with the patch that I mentioned. I can go ahead 
and add support to Bluetooth stuff, that's the reason I started that effort
in first place. However current code in main BK tree doesn't cover scenario  
when owner of net_proto_family != owner of the socket.

Here is how I think it should work.

sock_create()
        if (!try_module_get(npf->owner))
                goto fail;
        sock->owner = npf->owner;

        if (family_sock_create() < 0) {
                sock_release(sock);
                goto fail;
        }

 From this point on we don't care if net_proto_family is still registered or not, we know
who owns the socket.

sock_accept()
        __module_get(sock->owner);
        newsock->owner = sock->owner;

sock_release()
        module_put(sock->owner);

family_sock_create() (i.e. bt_sock_create(), etc)
        
#ifdef SPECIAL_FAMILY_THAT_HANDLES_PROTOCOLS_IN_SEPARATE_MODULES
        if (!try_module_get(proto_module))
                goto fail;

        prev_owner = sock->owner;
        sock->owner = proto_module;
        module_put(prev_owner); 
#else
        /* Other families do not have to do anything */
#endif

That's it for 'struct socket'.  And I mean that is _it_. Family can be unregistered 
and stuff, we don't care, and why should we.

Now 'struct sock'. It can exist independently from 'struct socket' and therefor
is a separate issue.
We only care about callbacks (sk->data_ready(), etc) and private sk slab caches. Some 
protocols simply use default callback which belong to non modular part of the kernel. 
Those don't have to do anything. They will just work.
Other protocols replace callbacks and therefor have to make sure that module is still 
loaded while sk exists. For those modules we need the following

void sk_set_owner(struct module *owner)
{
        /* Module must already hold reference when it call this function. */
        __module_get(owner);
        sk->owner = owner;
}
        
sk_free()
        ...
        module_put(sk->owner);
        ...

proto_set_sk_callbacks()

        sk_set_owner(THIS_MODULE);
        sk->destroy = proto_destroy;
        ...

That's it. There is no need to modify sk_alloc() or anything else. So it's not going
to introduce any overhead during socket creation from protocols that aren't modules or 
use default callback. And it gives us a flexibility of being able to pass ownership of 
the socket to another module or release module without having to access global family 
array.
For example if protocol wants to be unloaded by socket is still being used by net code
it could do something like
        write_lock(&sk->callback_lock);
        sk->data_ready = default_data_ready;
        ... other non default callbacks ...
        module_put(sk->owner);
        sk_set_owner(NULL);
        write_unlock(&sk->callback_lock);

Here is my original explanation.

>>>Here is the list of sk callbacks
>>>        void                    (*state_change)(struct sock *sk);
>>>        void                    (*data_ready)(struct sock *sk, int bytes);
>>>        void                    (*write_space)(struct sock *sk);
>>>        void                    (*error_report)(struct sock *sk);
>>>        int                     (*backlog_rcv) (struct sock *sk, struct sk_buff *skb);  
>>>        void                    (*destruct)(struct sock *sk);
>>>Net core doesn't make any other calls into the protocol module.
>>>
>>>In any case if protocol module wants, for some reason, to be around until sk is destroyed
>>>it can call sk_set_owner() right after sk_alloc(), even if it uses default callbacks.
>>>
>>>While looking at the net families that we support I realized that there is one more reason
>>>why protocol may have to call sk_set_owner(). Is if protocol uses private slab cache for its 
>>>sks. Otherwise cache will be destroyed during module unloading but sk may still be alive.
>>>
>>>Here is a little summary about families that I looked at:
>>>        Netlink - Global sk cache, replaces sk->destruct() callback.
>>>                  Must call sk_set_owner()
>>>
>>>        Unix -  Private sk cache, replaces sk->destruct() and sk->write_space() callbacks
>>>                Must call sk_set_owner()
>>>
>>>        IPv4/6 - Private cache, non-default callbacks.
>>>                Must call sk_set_owner() (cannot be a module, so we don't really care)
>>>
>>>        IPX - Global cache, default callbacks.
>>>
>>>        ATM - Global cache, default callbacks.
>>>                
>>>        IRDA - Global cache, default callbacks.
>>>
>>>        Bluetooth - Private cache (don't really need it, will change to global), non-default callbacks
>>>                Must call sk_set_owner()
>>>
>>>        AX25 - Global cache, non-default sk->destroy()
>>>                Must call sk_set_owner()
>>>
>>>        Rose - Global cache, default callbacks. 
>>>        
>>>        DecNet - Private cache, non-default callbacks.
>>>                Must call sk_set_owner()
>>>        
>>>        LLC - Global cache, default callbacks.

And here is the patch that implements it
        http://marc.theaimsgroup.com/?l=linux-kernel&m=104308300808557&w=2
(try_module_get() should be replaced with __module_get() in some places).

>Ah, and thanks for raising these issues and pointing me to the previous
>discussion that I had not read before,
>just too much e-mail on lkml, netdev is more manageable :-)
You're very welcome. I'm very interested to get this thing fixed.

(I wish Dave and Alexey were involved in this discussion and expressed their
thoughts/ideas/concerns instead of ignoring it.)

Max

