Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVDJLjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVDJLjU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 07:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVDJLjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 07:39:20 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:52424 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261474AbVDJLix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 07:38:53 -0400
Date: Sun, 10 Apr 2005 15:37:57 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, jmorris@redhat.com,
       ijc@hellion.org.uk, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, netdev@oss.sgi.com,
       jamal <hadi@cyberus.ca>
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-ID: <20050410153757.104fe611@zanzibar.2ka.mipt.ru>
In-Reply-To: <1113131325.6994.66.camel@localhost.localdomain>
References: <1112942924.28858.234.camel@uganda>
	<E1DKZ7e-00070D-00@gondolin.me.apana.org.au>
	<20050410143205.18bff80d@zanzibar.2ka.mipt.ru>
	<1113131325.6994.66.camel@localhost.localdomain>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Sun, 10 Apr 2005 15:37:59 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Apr 2005 13:08:44 +0200
Kay Sievers <kay.sievers@vrfy.org> wrote:

> On Sun, 2005-04-10 at 14:32 +0400, Evgeniy Polyakov wrote:
> > On Sun, 10 Apr 2005 19:52:54 +1000
> > Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > 
> > > > User should not know about low-level transport - 
> > > > it is like socket layer -  write only data and do not care about
> > > > how it will be delivered.
> > > 
> > > The delineation between transport and upper layer is fuzzy.
> > > In one situation the protocol might be transport and in another
> > > it could be above the transport.
> > > 
> > > So I don't buy this argument.
> > 
> > Connector allows to hide transport layer completely - 
> > concider acrypto or superio - that subsystems do not know
> > about network, author of the temperature driver for superio
> > should not know how skb is allocated and processed, 
> > and acrypto is not network related system, so why
> > they should know about network API?
> > Why should they know what is skb, how it is allocated, 
> > why shared skb can not be used in netlink and so on?
> > Users of the connector are only cared about
> > destination ID and how to send/receive message.
> > And what to do if we do not want something like connector
> > to be used for userspace control - we need to create
> > each time new netlink socket unit, like kobject's one,
> > or netlink_ulog, we need to register it in netlink.h, 
> > where already there too many units.
> > 
> > > > In the previous versions netlink group was assigned as incremented
> > > > counter, 
> > > > that was not convenient, but now we have 2-way ID, which is better
> > > > from users point of view - idx is supposed to be major id, val - 
> > > > some subsystem of that set.
> > > 
> > > Actually netlink does let you bind to a specific ID.
> > > 
> > > Of course you may argue that a single u32 is not enough.  However,
> > > nothing is stopping you from introducing netlink v2 that extends
> > > this.
> > > 
> > > In fact this is my main gripe with your patch: Why aren't you
> > > extending netlink instead of hacking something on top of the existing
> > > netlink? If the extensions require breaking compatibility: Fine,
> > > you just need to call it netlink v2.
> > 
> > When connector was created in the middle of 2004, it's main aim
> > was allowing easy userspace control over netlink.
> > Creating it's own skb receive parser was acceptible for
> > one project, for two, but it is definitely not the solution
> > for general use. And also I think it is not so easy to include new
> > netlink family unit for some completely unrelated to network subsystem.
> > 
> > So I decided to create only one skb parser, and put all skb processing
> > in one place, so any user has to do only registration with it's 
> > own receive callback, and sending function.
> 
> Sure, but that would apply the a generic netlink extension too, right?

Sending is the only and not the most significant part of the connector.
Of course cn_netlink_send() can be split into prepare_send() and commit_send(),
where commit_send() will live in af_netlink.c and do 
allocation and so on.
But it will not change the fact, that kernel users still need
to allocate a netlink socket, register it's own family unit, and so on...

Direct netlink usage is like using raw socket or even tun/tap device for TCP/IP, 
noone use it in that way, although we can, but connector is like
using socket interface.

> > Thus, transport layer was completely hidden from connector users,
> > there are no complex netlink macros there, no network API
> > and all complex related issues, no huge code duplication in each device,
> > which does not want to mess with 32/64 ioctl issues, but 
> > want easy userspace control.
> 
> I don't see the need for unimplemented abstractions here. You can
> replace a generic netlink-use just the same way as you can replace the
> connector's own netlink code below the connector API. There is not much
> difference.

Kernel users do not want to implement it's own transport over netlink.
Socket allocation was changed in 2.5 - we could need to change
each driver that use it instead of changing only one place in connector.c
Abstration over netlink already implemented in connector and is used
in acrypto, superio and even kobject_uevent was changed to do it.

> > Later connector was changed a bit to allow easy notification
> > ability and new bus was added.
> > Connector is the solution for d-bus related projects, since
> > all control is in one place, there are destination ID,
> > there is no complex API.
> 
> Sorry, what does this have to do with DBUS?

Kernel now has only two ways to inform to userspace about it's things - 
kobject [uevent] and hotplug. There is inotify/dnotify too, but it is 
diferent in some way.

The second one is a huge monster that can not be used in embedded
systems, calling userspace process from inside the kernel is 
now very flexible way.
The first one has it's own socket, it's own protocol and infrastructure
based on strings.

What if we want to inform about some new event?
Should we use kobject_uevent mechanism? Not anything can be 
described as kobject strings.
Should we create new socket/proto/infratructure? We do not
have another way.

That is why connector is usefull here - only one set of 
methods, known proto, just change "val" in ID and 
drop it in the userspace if it is not updated to use
new events.


> > Concider the latest xfrm event changes - good that we already
> > have netlink socket there, but in each sending function 
> > [there are at least three new]
> > we have all those skb_alloc, skb_put, NLMSG_* and so on which are
> > absolutely identical.
> > According to names and structures itself, they are too close
> > to what connector is for, and how it is implemented, so we already
> > have several connectors in the tree, and do we really want 
> > to proceed with it all over the place?
> 
> That's not the point. Nobody asks to replace the whole connector by raw
> netlink. But the message subscription and multicasting could be part of
> the generic netlink framework. The connector API would  still be on-top
> if it and nothing changes besides that we would have a nice low-level
> api to use for other systems too.

Netlink already has it's groups - why doesn't it meet your needs?
If someone "subscribed" [bound to that group], so message
sent to it will be delivered, otherwise - not.

One thing may be added to raw netlink - ability to send
to the group but not in a "that" multicast way,
i.e. send message to all subscribed _exactly_ to that group,
so one bound to -1 group will not receive message to
0x123 group when that group was specified in netlink header.

I can prepare a patch it is something like following:
--- ./net/netlink/af_netlink.c.orig     2005-04-10 15:46:48.000000000 +0400
+++ ./net/netlink/af_netlink.c  2005-04-10 15:47:04.000000000 +0400
@@ -747,7 +747,7 @@
        if (p->exclude_sk == sk)
                goto out;
 
-       if (nlk->pid == p->pid || !(nlk->groups & p->group))
+       if (nlk->pid == p->pid || (nlk->groups != p->group))
                goto out;
 
        if (p->failure) {

and requires new name...

> The basic idea behind the connector as a nice generic framework for
> netlink, as it fills the missing multicast case, while we already can do
> singlecast and broadcast with netlink.
> It is just the same way the kernel plays with other core functionality
> too. If something is not represented in the vfs-layer your are asked to
> add it to the generic part and not implement it privately for your
> filesystem only.

Exactly for that reason connector was created - so noone
needs to create it's private sockets/netlink API wrappers/skb handlers
and so on, just register callback and have a ->send() call.
 
> Thanks,
> Kay


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
