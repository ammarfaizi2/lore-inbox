Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTDXWts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 18:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbTDXWtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 18:49:47 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:31240 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S263571AbTDXWtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 18:49:41 -0400
Date: Thu, 24 Apr 2003 20:02:02 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [BK ChangeSet@1.1118.1.1] new module infrastructure for net_proto_family
Message-ID: <20030424230202.GB2931@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Max Krasnyansky <maxk@qualcomm.com>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <5.1.0.14.2.20030423134636.100e5c60@unixmail.qualcomm.com> <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com> <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com> <5.1.0.14.2.20030423134636.100e5c60@unixmail.qualcomm.com> <5.1.0.14.2.20030424094431.080b5320@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030424094431.080b5320@unixmail.qualcomm.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 24, 2003 at 12:33:35PM -0700, Max Krasnyansky escreveu:
> Hi Arnaldo,
> 
> >I did, there are several valid points, I forgot the sys_accept case, I'm
> >studying the code to see how to properly fix it,

> It's pretty easy if we have sock->owner. Take a look how my patch does it 
> (try_module_get should be replaced with __module_get()).
> It also covers the case when net_family_owner transferred ownership to the
> other module.

Yes, this gives us more flexibility, but as well some more overhead in the
common struct sock, I have worked in 2.5 to reduce its size, and want to
reduce it further, if possible. But read on, other reasons below.
 
> >but one thing I want covered
> >is keeping the net_families registered while there is still a struct sock
> >associated with the proto family, while not allowing the criation of new sockets
> >till the last struct sock is sk_freed.
> Why ?
> Like I said all we care about is if non default callbacks in struct sock are valid.
> Please read below.
> 
> >Think about protecting the module with the top level network protocol family
> >->create code on sock_create level and the modules with specific protocols at
> ><net_proto_family>_sock_create level.

> With the current infrastructure you'd need some kind of callback from
> sk_free() for that to work.  I think it's simpler with sk->owner.

not a callback, it'd be in sk_free itself (talking from the top of my head,
just arrived home and will be further studying this now), I pretty much want to
have protocol family maintainers not worrying about module refcounting at all
in the default case of no further modularisation per specific prococol, that
would save, for instance, Steven Whitehouse some work on DecNET :)
 
> >> > struct sock *sk_alloc(int family, int priority, int zero_it, kmem_cache_t *slab)
> >> > {
> >> >-       struct sock *sk;
> >> >-       
> >> >+       struct sock *sk = NULL;
> >> >+
> >> >+       if (!net_family_get(family))
> >> >+               goto out;

> >> Ok. This is wrong. Which should be clear from reading the thread that I
> >> mentioned.  Owner of the net_proto_family is not necessarily the owner of
> >> the 'struct sock'.  Example: af_inet module registers net_proto_family but
> >> udp module owns the socket.  (not that IPv4 code is modular but just an
> >> example). Another example would be Bluetooth.  We have Bluetooth core that
> >> registers Bluetooth proto_family and several modules that handle specific
> >> protocols (l2cap, rfcomm, etc).

> >I'm think that this can be handled at this protocol family code level, i.e.
> >if the net_proto_family wants to further modularise based on specific
> >protocol type this has to be refcounted at this level, example, at
> >bt_sock_create.

> Sure. Transfer of the ownership has to be done on that level. What I'm saying
> is that everything else can be done in generic code. 

So we're in agreement on having most of this infrastructure in generic code :)
 
> >> Also net_proto_family has pretty much nothing to do with the struct sock.
> >> The only reason we would want to hold reference to the module is if the
> >> module has replaced default callbacks (i.e. sk->data_ready(), etc).  So my
> >> point is we need sk->owner field. 

> >That is a way to solve it, yes, but I don't think the only one,
> >net_proto_family has to do with the struct sock as those data structures are
> >related to the network protocol family.

> By the same logic all things are related in the kernel :).

:-)

> struct socket uses net_proto_family ops and stuff and therefor is related.
> But struct sock is just a callbacks.

But I want to avoid having another thing to worry about for net protocol
family writers, i.e. not having to add a sk_set_owner if one decides it has
to change one of the default callbacks.
 
> >> I'd also prefer to see sock->owner which gives more flexibility (i.e.
> >> net_proto_family can be unregistered while struct socket still exist,
> >> etc).  net_family_get/put() makes no sense net_proto_family has only one
> >> function npf->create() which is referenced only from net/socket.c. struct
> >> socket should inherit owner field from struct net_proto_family by default
> >> but protocol should be able to assign ownership to a different module if
> >> it needs to.

> >I'm studying how to signal that the net_proto_family was unregistered while
> >still having the entry in net_families available, that is a problem with the
> >current infrastructure in Linus tree.

> Why do you need that ? 

> Let's just get rid of the net_family_get/put thing. Each socket will have
> owner field so we know who owns it and there is no need to access global
> net_family table.

I'm trying to avoid adding a pointer to struct sock, if it is not possible
at all to avoid, ok, we do it, but I think we can have this at just one
place, the net_family table.

> >Sorry, today I didn't had time to work on this at night at home, but
> >tomorrow I'll be working on this, thing is, as I'm working only on having
> >the infrastructure in place and no protocols have ->owner set there is no
> >way to trigger the problems discussed in this message in any way.

> I actually had it all working with the patch that I mentioned. I can go ahead 
> and add support to Bluetooth stuff, that's the reason I started that effort
> in first place. However current code in main BK tree doesn't cover scenario  
> when owner of net_proto_family != owner of the socket.

> Here is how I think it should work.
> 
> sock_create()
>         if (!try_module_get(npf->owner))
>                 goto fail;
>         sock->owner = npf->owner;
> 
>         if (family_sock_create() < 0) {
>                 sock_release(sock);
>                 goto fail;
>         }
 
>  From this point on we don't care if net_proto_family is still registered or
>  not, we know who owns the socket.
 
> sock_accept()
>         __module_get(sock->owner);
>         newsock->owner = sock->owner;
> 
> sock_release()
>         module_put(sock->owner);
> 
> family_sock_create() (i.e. bt_sock_create(), etc)
>         
> #ifdef SPECIAL_FAMILY_THAT_HANDLES_PROTOCOLS_IN_SEPARATE_MODULES
>         if (!try_module_get(proto_module))
>                 goto fail;
> 
>         prev_owner = sock->owner;
>         sock->owner = proto_module;
>         module_put(prev_owner); 
> #else
>         /* Other families do not have to do anything */
> #endif
 
> That's it for 'struct socket'.  And I mean that is _it_. Family can be
> unregistered and stuff, we don't care, and why should we.
 
> Now 'struct sock'. It can exist independently from 'struct socket' and
> therefor is a separate issue.

> We only care about callbacks (sk->data_ready(), etc) and private sk slab
> caches. Some protocols simply use default callback which belong to non
> modular part of the kernel.  Those don't have to do anything. They will just
> work.  Other protocols replace callbacks and therefor have to make sure that
> module is still loaded while sk exists. For those modules we need the
> following
 
> void sk_set_owner(struct module *owner)
> {
>         /* Module must already hold reference when it call this function. */
>         __module_get(owner);
>         sk->owner = owner;
> }

This is the additional rule I'm trying to avoid.
         
> sk_free()
>         ...
>         module_put(sk->owner);
>         ...

this is already in BK tree.
 
> >>>        IPv4/6 - Private cache, non-default callbacks.
> >>>                Must call sk_set_owner() (cannot be a module, so we don't really care)

Well, I care, I wish to have this as a module at some point, if allowed by
DaveM, of course 8)

- Arnaldo
