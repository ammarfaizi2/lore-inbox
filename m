Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVDJLIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVDJLIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 07:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVDJLIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 07:08:53 -0400
Received: from soundwarez.org ([217.160.171.123]:39616 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261471AbVDJLIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 07:08:47 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Kay Sievers <kay.sievers@vrfy.org>
To: johnpol@2ka.mipt.ru
Cc: Herbert Xu <herbert@gondor.apana.org.au>, jmorris@redhat.com,
       ijc@hellion.org.uk, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, netdev@oss.sgi.com,
       jamal <hadi@cyberus.ca>
In-Reply-To: <20050410143205.18bff80d@zanzibar.2ka.mipt.ru>
References: <1112942924.28858.234.camel@uganda>
	 <E1DKZ7e-00070D-00@gondolin.me.apana.org.au>
	 <20050410143205.18bff80d@zanzibar.2ka.mipt.ru>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 13:08:44 +0200
Message-Id: <1113131325.6994.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-10 at 14:32 +0400, Evgeniy Polyakov wrote:
> On Sun, 10 Apr 2005 19:52:54 +1000
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > 
> > > User should not know about low-level transport - 
> > > it is like socket layer -  write only data and do not care about
> > > how it will be delivered.
> > 
> > The delineation between transport and upper layer is fuzzy.
> > In one situation the protocol might be transport and in another
> > it could be above the transport.
> > 
> > So I don't buy this argument.
> 
> Connector allows to hide transport layer completely - 
> concider acrypto or superio - that subsystems do not know
> about network, author of the temperature driver for superio
> should not know how skb is allocated and processed, 
> and acrypto is not network related system, so why
> they should know about network API?
> Why should they know what is skb, how it is allocated, 
> why shared skb can not be used in netlink and so on?
> Users of the connector are only cared about
> destination ID and how to send/receive message.
> And what to do if we do not want something like connector
> to be used for userspace control - we need to create
> each time new netlink socket unit, like kobject's one,
> or netlink_ulog, we need to register it in netlink.h, 
> where already there too many units.
> 
> > > In the previous versions netlink group was assigned as incremented
> > > counter, 
> > > that was not convenient, but now we have 2-way ID, which is better
> > > from users point of view - idx is supposed to be major id, val - 
> > > some subsystem of that set.
> > 
> > Actually netlink does let you bind to a specific ID.
> > 
> > Of course you may argue that a single u32 is not enough.  However,
> > nothing is stopping you from introducing netlink v2 that extends
> > this.
> > 
> > In fact this is my main gripe with your patch: Why aren't you
> > extending netlink instead of hacking something on top of the existing
> > netlink? If the extensions require breaking compatibility: Fine,
> > you just need to call it netlink v2.
> 
> When connector was created in the middle of 2004, it's main aim
> was allowing easy userspace control over netlink.
> Creating it's own skb receive parser was acceptible for
> one project, for two, but it is definitely not the solution
> for general use. And also I think it is not so easy to include new
> netlink family unit for some completely unrelated to network subsystem.
> 
> So I decided to create only one skb parser, and put all skb processing
> in one place, so any user has to do only registration with it's 
> own receive callback, and sending function.

Sure, but that would apply the a generic netlink extension too, right?

> Thus, transport layer was completely hidden from connector users,
> there are no complex netlink macros there, no network API
> and all complex related issues, no huge code duplication in each device,
> which does not want to mess with 32/64 ioctl issues, but 
> want easy userspace control.

I don't see the need for unimplemented abstractions here. You can
replace a generic netlink-use just the same way as you can replace the
connector's own netlink code below the connector API. There is not much
difference.

> Later connector was changed a bit to allow easy notification
> ability and new bus was added.
> Connector is the solution for d-bus related projects, since
> all control is in one place, there are destination ID,
> there is no complex API.

Sorry, what does this have to do with DBUS?

> Concider the latest xfrm event changes - good that we already
> have netlink socket there, but in each sending function 
> [there are at least three new]
> we have all those skb_alloc, skb_put, NLMSG_* and so on which are
> absolutely identical.
> According to names and structures itself, they are too close
> to what connector is for, and how it is implemented, so we already
> have several connectors in the tree, and do we really want 
> to proceed with it all over the place?

That's not the point. Nobody asks to replace the whole connector by raw
netlink. But the message subscription and multicasting could be part of
the generic netlink framework. The connector API would  still be on-top
if it and nothing changes besides that we would have a nice low-level
api to use for other systems too.
The basic idea behind the connector as a nice generic framework for
netlink, as it fills the missing multicast case, while we already can do
singlecast and broadcast with netlink.
It is just the same way the kernel plays with other core functionality
too. If something is not represented in the vfs-layer your are asked to
add it to the generic part and not implement it privately for your
filesystem only.

Thanks,
Kay

