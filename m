Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWDBW4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWDBW4b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 18:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWDBW4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 18:56:31 -0400
Received: from swan.nt.tuwien.ac.at ([128.131.67.158]:46472 "EHLO
	swan.nt.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1751506AbWDBW4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 18:56:30 -0400
Date: Mon, 3 Apr 2006 00:56:25 +0200
From: Thomas Zeitlhofer <thomas.zeitlhofer@nt.tuwien.ac.at>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       netdev@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: bridge+netfilter broken for IP fragments in 2.6.16?
Message-ID: <20060402225625.GA22612@swan.nt.tuwien.ac.at>
References: <20060401143011.GA28333@swan.nt.tuwien.ac.at> <443023C2.6020401@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443023C2.6020401@trash.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 09:19:30PM +0200, Patrick McHardy wrote:
> Thomas Zeitlhofer wrote:
> > I have set up a bridge with two ports:
> > 
> > # brctl show br0
> > bridge name     bridge id               STP enabled     interfaces
> > br0             8000.000021f23d58       no              eth1
> >                                                         tap1
> > 
> > Using 2.6.16/.1 non fragmented IP packets are passing the bridge without
> > problems, but fragmented IP packets do not show up on the outgoing
> > interface. E.g., for fragmented traffic coming in from tap1 and going
> > out via eth1 tcpdump shows:
> > 
> >   1) on tap1: fragmented packets
> >   2) on br0: the defragmented packet (connection tracking)
> >   3) on eth1: no packet!?
> > 
> > This breaks IPsec connections for example.
> > 
> > 
> > Doing the same on 2.6.15.x shows:
> > 
> >   1) on tap1: fragmented packets
> >   2) on br0: the defragmented packet (connection tracking)
> >   3) on eth1: fragmented packets
> 
> Are you sure this is correct? I think in 2.6.15 you should see
> the fragments on br0 already.

Just verified it, at least in 2.6.15.6 tcpdump shows the defragmented
packet on br0.

> Anyway, since 2.6.16 ip_conntrack doesn't do refragmentation anymore
> but relies on fragmentation in the IP layer. Purely bridged packets
> don't go through the IP layer, so the bridge netfilter code needs to
> take care of fragmentation itself. Please try if this patch helps.

Your patch solves the problem - tcpdump now shows the refragmented
packets on eth1. Thanks for the quick solution.

Just a note, your patch does not work when bridge is compiled as a
module. In this case modprobe failes with "bridge: Unknown symbol
ip_fragment". Using CONFIG_BRIDGE=y works.

> > and IPsec connections are ok.
> 
> This is probably a different issue. 

I don't think so, with your patch IPsec connection can be established
again. The problem was that racoon generates UDP packets of length 2600
during isakmp phase 1 which did not pass the bridge. 

> Please describe your setup (IPsec, NAT and filtering).

The setup here is UML behind tap1 where br0 is used to bridge the
physical interface (eth1) to the UML's eth0 (=> tap1). The IPsec
connection is going from the UML to the outside world over the bridge.
NAT is not used and at the moment filtering is just used for
accounting. So nothing special, only two rules in the FORWARD chain
that accept all traffic in both directions.

--
Thomas
