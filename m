Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310486AbSCCAV6>; Sat, 2 Mar 2002 19:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310487AbSCCAVs>; Sat, 2 Mar 2002 19:21:48 -0500
Received: from trillium-hollow.org ([209.180.166.89]:14783 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S310486AbSCCAVn>; Sat, 2 Mar 2002 19:21:43 -0500
To: Julian Anastasov <ja@ssi.bg>, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Szekeres Bela <szekeres@lhsystems.hu>,
        Daniel Gryniewicz <dang@fprintf.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: Network Security hole (was -> Re: arp bug ) 
In-Reply-To: Your message of "Sun, 03 Mar 2002 00:46:12 GMT."
             <Pine.LNX.4.44.0203030035030.9147-100000@u.domain.uli> 
Date: Sat, 02 Mar 2002 16:21:24 -0800
From: erich@uruk.org
Message-Id: <E16hJki-0000rY-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[followons after this should probably go to "netdev@oss.sgi.com" and not
 the kernel list]

Julian Anastasov <ja@ssi.bg> wrote:

> On Sat, 2 Mar 2002, Alan Cox wrote:
> 
> > > behavior causes some problems for setups with rp_filter protection
> > > and interfaces attached to same hub. If you want to find the reason
> > > for this, here it is:
> >
> > rp_filter is an add on - not exactly default standards behaviour. If you
> > want to make the case that rp_filter = 2 means apply a both way rule then
> > I've personally no problem with that argument
> 
> 	The rp_filter value of 2 is not support from Linux and
> after reading the "5.3.8 Source Address Validation" paragraph
> from rfc1812 it seems rp_filter 1 covers it. What exactly do
> you mean by value of 2? Note that the remote box does not want to
> spoof, it was directed from BOX1 to a wrong MAC where the traffic is 
> spoofed, the remote hosts are not guilty. They connect to the MAC we 
> provide by broadcasts.
> 
> 	To Erich, rfc1812, 5.3.8 Source Address Validation:
> 
> If this feature is implemented, it MUST be disabled by default

That's not what I was talking about.  I'm talking about
Destination Address Validation based on the network you're getting
the packet from, before it's passed on up to the protocol layers
to the application.

This is, frankly, the most important part for determining if you
want to firewall off a packet from the wrong place.  And if you
don't have routing set up in your machine, I still kind of think
it's an end-user box.

The fact that the routing layer and application layers of Linux's
TCP/IP stack are one and the same is a difficulty here which the
IP firewalling code in Linux does not fix.  I.e. if I wanted to
have routing as well, but not accept any packets internally *not*
destined for my interface, I'm not sure how to specify it without
something like TCP wrappers, as sleazy as they can be, and they
don't offer this kind of capability in general as is.

I have been sniffing through the RFCs (and my trusty copy of TCP/IP
Illustrated Vol 1), and while no guru on these issues, have found
nothing specififying that a non-router must accept packets that
have the wrong destination address.

In fact, there are several places that make it clear that hosts
(as opposed to routers) must not forward packets.  I assume they're
talking about a host not accidentally confusing routers by moving
packets from one network to another without having routes programmed,
but that language is *still* relevant in the case when a packet is
received by the wrong interface.  It should not be arbitrarily
forwarding them internally to different interfaces without being
told to.

I think that is a standards-based reason to change the default
behavior.  If you need proof, I can look up the part saying that
hosts must never forward packets unless explicitly commanded to,
and the interpretation that if they are asked to they must refuse
should be sufficient.

Also, if I'm understanding this language correctly, hosts and
routers are distinctly not the same, and RFC 1812 is talking about
routers.  It's possible I'm not understanding the language correctly
though, as I'm not deeply familiar with the IP RFCs by any means.

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
