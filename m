Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVDJKdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVDJKdq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 06:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVDJKdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 06:33:45 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:20145 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261467AbVDJKdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 06:33:12 -0400
Date: Sun, 10 Apr 2005 14:32:05 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: jmorris@redhat.com, kay.sievers@vrfy.org, ijc@hellion.org.uk,
       guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, netdev@oss.sgi.com,
       jamal <hadi@cyberus.ca>
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-ID: <20050410143205.18bff80d@zanzibar.2ka.mipt.ru>
In-Reply-To: <E1DKZ7e-00070D-00@gondolin.me.apana.org.au>
References: <1112942924.28858.234.camel@uganda>
	<E1DKZ7e-00070D-00@gondolin.me.apana.org.au>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Sun, 10 Apr 2005 14:32:07 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Apr 2005 19:52:54 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Please add netdev to the CC list since this discussion pertains to
> the networking subsystem.
> 
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > 
> > User should not know about low-level transport - 
> > it is like socket layer -  write only data and do not care about
> > how it will be delivered.
> 
> The delineation between transport and upper layer is fuzzy.
> In one situation the protocol might be transport and in another
> it could be above the transport.
> 
> So I don't buy this argument.

Connector allows to hide transport layer completely - 
concider acrypto or superio - that subsystems do not know
about network, author of the temperature driver for superio
should not know how skb is allocated and processed, 
and acrypto is not network related system, so why
they should know about network API?
Why should they know what is skb, how it is allocated, 
why shared skb can not be used in netlink and so on?
Users of the connector are only cared about
destination ID and how to send/receive message.
And what to do if we do not want something like connector
to be used for userspace control - we need to create
each time new netlink socket unit, like kobject's one,
or netlink_ulog, we need to register it in netlink.h, 
where already there too many units.

> > In the previous versions netlink group was assigned as incremented
> > counter, 
> > that was not convenient, but now we have 2-way ID, which is better
> > from users point of view - idx is supposed to be major id, val - 
> > some subsystem of that set.
> 
> Actually netlink does let you bind to a specific ID.
> 
> Of course you may argue that a single u32 is not enough.  However,
> nothing is stopping you from introducing netlink v2 that extends
> this.
> 
> In fact this is my main gripe with your patch: Why aren't you
> extending netlink instead of hacking something on top of the existing
> netlink? If the extensions require breaking compatibility: Fine,
> you just need to call it netlink v2.

When connector was created in the middle of 2004, it's main aim
was allowing easy userspace control over netlink.
Creating it's own skb receive parser was acceptible for
one project, for two, but it is definitely not the solution
for general use. And also I think it is not so easy to include new
netlink family unit for some completely unrelated to network subsystem.

So I decided to create only one skb parser, and put all skb processing
in one place, so any user has to do only registration with it's 
own receive callback, and sending function.

Thus, transport layer was completely hidden from connector users,
there are no complex netlink macros there, no network API
and all complex related issues, no huge code duplication in each device,
which does not want to mess with 32/64 ioctl issues, but 
want easy userspace control.

Later connector was changed a bit to allow easy notification
ability and new bus was added.
Connector is the solution for d-bus related projects, since
all control is in one place, there are destination ID,
there is no complex API.

Concider the latest xfrm event changes - good that we already
have netlink socket there, but in each sending function 
[there are at least three new]
we have all those skb_alloc, skb_put, NLMSG_* and so on which are
absolutely identical.
According to names and structures itself, they are too close
to what connector is for, and how it is implemented, so we already
have several connectors in the tree, and do we really want 
to proceed with it all over the place?


> Cheers,
> -- 
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
