Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136757AbRAHEXI>; Sun, 7 Jan 2001 23:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136756AbRAHEW6>; Sun, 7 Jan 2001 23:22:58 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:37905 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S136708AbRAHEWl>;
	Sun, 7 Jan 2001 23:22:41 -0500
Message-ID: <3A594F55.298EBCF8@candelatech.com>
Date: Sun, 07 Jan 2001 22:25:41 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: Sandy Harris <sandy@storm.ca>, linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: routable interfaces  WAS( Re: [PATCH] hashed device 
 lookup(DoesNOTmeet Linus' sumission policy!)
In-Reply-To: <Pine.GSO.4.30.0101071922200.18916-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> 
> On Sun, 7 Jan 2001, Ben Greear wrote:
> 
> > Hrm, what if they just made each IP-SEC interface a net_device?  If they
> > are a routable entity, with it's own IP address, it starts to look a lot
> > like an interface/net_device.
> 
> As in my response to Matti, i thing a netdevice is a generalized link
> layer structure and should remain that way.

Yes, but VLANs are a link-layer structure too, and things like tunnels
are really link-layer too, as far as protocols using them are concerned.

With tunneling and virtual interfaces, you could conceivably do something
like:

OC3 - ATM - Ethernet - VLAN - IP - IP-Sec - IP
as well as plain old:
Ethernet - IP

Which of these are netdevices?

(I argue that at least the Ethernet-over-ATM, VLAN, and IP-Sec entities could
profit from being a net_device at it's core.)

You argue that we should split the net_device into physical and virtual portions.

Perhaps you could give an idea of the data members that would belong in the new
structures?  I argue that you lose the minute you need one in both structures :)

> > This has seeming worked well for VLANs:  Maybe net_device is already
> > general enough??
> 
> I think it is not proper to generalize netdevices for IP. I am not
> thinking of dead protocols like IPX, more of other newer encapsulations
> such as MPLS etc.

MPLS can run over FrameRelay, Ethernet, and ATM, at the moment (right?).

What if you want to run MPLS over an IP-Sec link?  If you want it to
magically work, IP-Sec could be a net_device with it's own particular
member methods and private data that let it do the right thing.

> > So, what would be the down-side of having VLANs and other virtual interfaces
> > be net_devices?  The only thing I ever thought of was the linear lookups,
> > which is why I wrote the hash code.  The beauty of working with existing
> > user-space tools should not be over-looked!
> >
> 
> IP configuration tools you mean. Fine, they should be used to configure
> "interfaces" in the way i defined them above.

Think also of creating sockets with SOCK_RAW and other lower-level
(but user-space) access to the net_device's methods.

> It makes sense from an abstraction and management perspective to have all
> virtual interfaces which run on top of a physical interface to be
> managed in conjuction with the device.

What if you had an inverse-MUX type of device that spanned two different
physical interfaces.  Then, one can go down, but the virtual interface
is still up.  So, there is not a one-to-one coorespondence.  At a higher
level, what if your interface is some tunnel running over IP.  IP in turn
can be routed out any physical interface (and may dynamically change due
to routing protocols.)

> Device goes down, you destroy them
> or send them to a shutdown state (instead of messaging) etc.
> 
> cheers,
> jamal

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
