Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbTDXGcd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 02:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTDXGcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 02:32:33 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:53512 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261829AbTDXGcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 02:32:31 -0400
Date: Thu, 24 Apr 2003 03:44:53 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, netdev@oss.sgi.com
Subject: Re: [BK ChangeSet@1.1118.1.1] new module infrastructure for net_proto_family
Message-ID: <20030424064453.GA29078@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Max Krasnyansky <maxk@qualcomm.com>, linux-kernel@vger.kernel.org,
	davem@redhat.com, netdev@oss.sgi.com
References: <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com> <5.1.0.14.2.20030423114915.10840678@unixmail.qualcomm.com> <5.1.0.14.2.20030423134636.100e5c60@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030423134636.100e5c60@unixmail.qualcomm.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 23, 2003 at 03:51:11PM -0700, Max Krasnyansky escreveu:
> At 12:26 PM 4/23/2003, Arnaldo Carvalho de Melo wrote:
> >Em Wed, Apr 23, 2003 at 12:13:37PM -0700, Max Krasnyansky escreveu:
> >> Hi Folks,
> >> 
> >> Can somebody (DaveM perhaps) please explain to me what the hell the following 
> >> changset is doing in 2.5.68 
> >>         http://linux.bkbits.net:8080/linux-2.5/cset@1.1118.1.1?nav=index.html|ChangeSet@-7d
> >> ??
> >> 
> >> I've spent quite a bit of time looking into what's needed to fix socket module refcounting
> >> issues and convicting DaveM and Alex that we need to fix them.
> >> Here is the original thread
> >>         http://marc.theaimsgroup.com/?l=linux-kernel&m=104308300808557&w=2
> >
> >I was not aware of this thread, will read it
> Please do.

I did, there are several valid points, I forgot the sys_accept case, I'm
studying the code to see how to properly fix it, but one thing I want covered
is keeping the net_families registered while there is still a struct sock
associated with the proto family, while not allowing the criation of new sockets
till the last struct sock is sk_freed.

Think about protecting the module with the top level network protocol family
->create code on sock_create level and the modules with specific protocols at
<net_proto_family>_sock_create level.
 
> >> I don't mind of course if some other (better) patch is accepted instead of mine. But patch 
> >> that went in is incomplete and buggy. It doesn't handle accept case properly and doesn't 
> >> address the issue of the 'struct sock' ownership (read original thread for more details).
> >
> >This is dealt with the following patch, and these patches were discussed on the netdev
> >mailing list. Considerations ? I'll be sending today patches converting the net protocols
> >that I maintain and then for some others that are ummaintained, etc.
> I thought changes like that are always discussed on the lkml. They are directly related to the 
> new module interface changes. It least CC lkml.
> 
> (I've subscribed to netdev list)
> 
> The latest patches that I've seen from you on netdev list and in main BK tree still don't 
> handle accept() properly
> 
> net/socket.c:sys_accept()
>         ...
>         if (!(newsock = sock_alloc())) 
>                 goto out_put;
> 
>         newsock->type = sock->type;
>         newsock->ops = sock->ops;
>          ...
> 
> newsock is not accounted for (sock_alloc() doesn't bump module refcount).
> 
> > struct sock *sk_alloc(int family, int priority, int zero_it, kmem_cache_t *slab)
> > {
> >-       struct sock *sk;
> >-       
> >+       struct sock *sk = NULL;
> >+
> >+       if (!net_family_get(family))
> >+               goto out;
> 
> Ok. This is wrong. Which should be clear from reading the thread that I mentioned.
> Owner of the net_proto_family is not necessarily the owner of the 'struct sock'.
> Example: af_inet module registers net_proto_family but udp module owns the socket.
> (not that IPv4 code is modular but just an example). Another example would be Bluetooth.
> We have Bluetooth core that registers Bluetooth proto_family and several modules
> that handle specific protocols (l2cap, rfcomm, etc).

I'm think that this can be handled at this protocol family code level, i.e.  if
the net_proto_family wants to further modularise based on specific protocol
type this has to be refcounted at this level, example, at bt_sock_create.
 
> Also net_proto_family has pretty much nothing to do with the struct sock. The only reason 
> we would want to hold reference to the module is if the module has replaced default 
> callbacks (i.e. sk->data_ready(), etc).
> So my point is we need sk->owner field. 

That is a way to solve it, yes, but I don't think the only one,
net_proto_family has to do with the struct sock as those data structures are
related to the network protocol family.

> I'd also prefer to see sock->owner which gives more flexibility (i.e.
> net_proto_family can be unregistered while struct socket still exist, etc).
> net_family_get/put() makes no sense net_proto_family has only one function
> npf->create() which is referenced only from net/socket.c. struct socket
> should inherit owner field from struct net_proto_family by default but
> protocol should be able to assign ownership to a different module if it needs
> to.

I'm studying how to signal that the net_proto_family was unregistered while
still having the entry in net_families available, that is a problem with the
current infrastructure in Linus tree.

Sorry, today I didn't had time to work on this at night at home, but tomorrow
I'll be working on this, thing is, as I'm working only on having the
infrastructure in place and no protocols have ->owner set there is no way to
trigger the problems discussed in this message in any way.

Ah, and thanks for raising these issues and pointing me to the previous
discussion that I had not read before, just too much e-mail on lkml, netdev
is more manageable :-)

- Arnaldo
