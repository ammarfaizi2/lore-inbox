Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271715AbTHRMxd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271724AbTHRMxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:53:32 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:56075 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S271715AbTHRMxI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:53:08 -0400
Date: Mon, 18 Aug 2003 14:51:58 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, willy@w.ods.org,
       alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-ID: <20030818125158.GA18699@alpha.home.local>
References: <200308171555280781.0067FB36@192.168.128.16> <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk> <200308171759540391.00AA8CAB@192.168.128.16> <1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk> <200308171827130739.00C3905F@192.168.128.16> <1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk> <20030817224849.GB734@alpha.home.local> <20030817223118.3cbc497c.davem@redhat.com> <20030818133957.3d3d51d2.skraw@ithnet.com> <20030818044419.0bc24d14.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818044419.0bc24d14.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 04:44:19AM -0700, David S. Miller wrote:
> On Mon, 18 Aug 2003 13:39:57 +0200
> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> 
> > Can you please give us a striking example of a widespread application where
> > current behaviour is a requirement or at least a very positive thing?
> 
> [ I've been waiting what seems like centuries for someone
>   to even consider talking about source address selection,
>   alas I have to bring it up myself :( ]

You're not fair, David, that was *exactly* my concern when I jumped into the
thread : the SELECTED SOURCE address for ARP requests is wrong by default as
soon as you manually set the IP source address. (but perhaps you didn't have
time to read my long mail).

> Do you know how source address selection works when the user tries to
> connect to a remote location yet doesn't specify a specific source
> address to use?

In my case, although I don't know the internals, I think I have a clear enough
idea of it (but I may be wrong) : the IP source address used when connecting to
a remote host should be either the one manually specified on the most
appropriate route, or one local address which can reach the remote host or a
gateway indicated by the most appropriate route. The ARP source is the IP
source address if this address is a local one, or one of those assigned to the
NIC from which either the host or the gateway should be reached.

> 1) consider how you might want to make that configurable
>    by the user

ip route ... src ... is really fine to me for the IP part, and I would have
expected it to act on ARP too ;-)

> 2) what the default behavior should be

I think we should apply the exact same source selection as IP to ARP. That is,
if we need to reach host X or gateway X on the LAN, we should do a route lookup
and use a valid source (or the manually set one) associated to the most
appropriate route. That is what Julian Anastasov's patch does, and it does it
fairly well IMHO.

> 3) what kind of ARP behavior is necessary in order for
>    these various configurations to work

The one detailed above by default, then use arptables (or ip arp) for all
tricky configurations.

BTW, I've tried arptables-0.0.1. Except that I had to patch it to make it
usable on 2.4.22-rc2 (because the FORWARD chain doesn't exist on 2.4), it
allows me to do the same as what 'ip arp' did for me on a patched kernel
(although I prefer the iproute interface, just a matter of taste). Using my
previous example, I now do the following which works :

   ip address add 10.0.0.1/24 dev eth0
   ip address add 11.0.0.1/24 dev eth0
   ip route   add default     via 11.0.0.2 src 10.0.0.1
   arptables -A OUTPUT -d 11.0.0.0/24 -o eth0 -j mangle --mangle-ip-s 11.0.0.1

I'll send a fix to the arptable's maintainer so that it works again on 2.4.

Cheers,
Willy

