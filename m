Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143633AbRAHNHC>; Mon, 8 Jan 2001 08:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143621AbRAHNGx>; Mon, 8 Jan 2001 08:06:53 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:59044 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S143570AbRAHNGf>;
	Mon, 8 Jan 2001 08:06:35 -0500
Date: Mon, 8 Jan 2001 08:05:49 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Ben Greear <greearb@candelatech.com>
cc: Sandy Harris <sandy@storm.ca>, linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: routable interfaces  WAS( Re: [PATCH] hashed device  lookup(DoesNOTmeet
 Linus' sumission policy!)
In-Reply-To: <3A594F55.298EBCF8@candelatech.com>
Message-ID: <Pine.GSO.4.30.0101080642000.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Ben Greear wrote:
> jamal wrote:

> > As in my response to Matti, i thing a netdevice is a generalized link
> > layer structure and should remain that way.
>
> Yes, but VLANs are a link-layer structure too, and things like tunnels
> are really link-layer too, as far as protocols using them are concerned.
>
> With tunneling and virtual interfaces, you could conceivably do something
> like:
>
> OC3 - ATM - Ethernet - VLAN - IP - IP-Sec - IP
> as well as plain old:
> Ethernet - IP
>
> Which of these are netdevices?
>

I think you are mixing up the packet munging/management part of the entity
and the data part. There is a very close relation, however the munger is
_not_ a netdevice. The entry l2 protocol demuxing selects the munger.

> (I argue that at least the Ethernet-over-ATM, VLAN, and IP-Sec entities could
> profit from being a net_device at it's core.)
>
> You argue that we should split the net_device into physical and virtual
> portions.

Iam not asking for this. It is pseudo-already-there.
What i am asking for is consistency. A virtual IP address is "virtual" and
resides on top of a link (eg ethernet) as does a VLAN. Yet a VLAN gets its
own life as a netdevice. Why? so that it can be "routable".

> Perhaps you could give an idea of the data members that would belong in the new
> structures?  I argue that you lose the minute you need one in both structures :)
>

I dont have to add new data structures. The ifa structure on a netdevice
is sufficient. It has a name/label, it has an IP address, it lacks an
ifindex. counters is the other lacking one (thinking of what Gleb posted).
A vlan device could be a simple IP-alias.
I am not all bent to insist that it has to be an ifa. What matters is
consistency. I want an alias to be used by a route daemon. The easiest
brute force way is to make it a netdevice. You might hack this from the
route daemon itself as well but as Gleb was pointing out SNMP wont be
happy.

> > > This has seeming worked well for VLANs:  Maybe net_device is already
> > > general enough??
> >
> > I think it is not proper to generalize netdevices for IP. I am not
> > thinking of dead protocols like IPX, more of other newer encapsulations
> > such as MPLS etc.
>
> MPLS can run over FrameRelay, Ethernet, and ATM, at the moment (right?).
>
> What if you want to run MPLS over an IP-Sec link?  If you want it to
> magically work, IP-Sec could be a net_device with it's own particular
> member methods and private data that let it do the right thing.
>

Again, this is an issue of netdevice data vs its associated methods/mungers.

>
> What if you had an inverse-MUX type of device that spanned two different
> physical interfaces.  Then, one can go down, but the virtual interface
> is still up.  So, there is not a one-to-one coorespondence.  At a higher
> level, what if your interface is some tunnel running over IP.  IP in turn
> can be routed out any physical interface (and may dynamically change due
> to routing protocols.)

it's that thin line between a netdevice and the packet munging.
Today the first association is via a l2 demux point -- that split is very
clean, IMO.
An IP packet comes in, you invoke the IP handling code. a type
ETH_P_802_1Q comes in you invoke the vlan handling code. At some point
along that path you invoke the ip handling code which ends up invoking the
IPSEC handler etc. IP/GRE or IPIP tunnels get handled the same way.
NOTE that this has absolutely nothing to do with a netdevice. Your VLAN
code manages the state mapping of what vlanid maps to what skb->dev. I
would say this is where the one-to-one mapping is maintained. You dont
have to assume a device to get the mapping.
Infact each of those stages maintains some state to work. IP maintains a
route table.
it should probably be refined further to be based on a classification of
any sort needed instead of the incremental classification only.
The posting by Matti pointed to some page that was suggesting a netif_rx
per input device. I also think this is that linked association that a
netdvice is a net-munger as well as a routable interface.
Maybe the netdevice is the best abstraction for a routable interface
because it is already stamped in people's heads and also because IP rules.
Once you've stripped all headers and done what you need to do just pass it
to a dev->rx() and it will take it from there. I still see confusion.

BTW,The problem you described will face you on a VLAN spanning two physical
ports ;-> Do tell me how you solve it.

cheers,
jamal




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
