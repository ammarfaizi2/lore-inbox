Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293723AbSCAUfa>; Fri, 1 Mar 2002 15:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293731AbSCAUfW>; Fri, 1 Mar 2002 15:35:22 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:59152 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S293728AbSCAUfB>; Fri, 1 Mar 2002 15:35:01 -0500
Date: Fri, 1 Mar 2002 21:34:58 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ben Greear <greearb@candelatech.com>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, zab@zabbo.net
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
Message-ID: <20020301213458.A30120@devcon.net>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Ben Greear <greearb@candelatech.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org, zab@zabbo.net
In-Reply-To: <20020301.072831.120445660.davem@redhat.com> <3C7FA81A.3070602@candelatech.com> <20020301.081110.76328637.davem@redhat.com> <3C7FAC00.4010402@candelatech.com> <3C7FADBB.3A5B338F@mandrakesoft.com> <20020301174619.A6125@devcon.net> <3C7FD1E3.800A61FD@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C7FD1E3.800A61FD@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Mar 01, 2002 at 02:09:23PM -0500
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 02:09:23PM -0500, Jeff Garzik wrote:
> 
> 1) This patch is (like I mentioned earlier) for reference only, not for
> application.

Ack. Although it works like a charme in production here, and I did not
receive any problem reports about it so far. So anyone who needs this
now should apply the patch locally for the moment.

> It is really halfway in between software and hardware VLAN
> support.

Not really. The MTU setting is something which must be done for any
"dumb" card that has no real hardware VLAN support, and the only thing
Cyclone and Tornado cards care about the VlanEtherType is that they
start IP checksumming 4 octets later. They don't care a bit about the
contents of the VLAN tag.

> 2) You don't want to set_8021q_mode if VLAN is not active.  It's silly
> to activate it when VLAN is compiled as a module but no one is using
> vlans.  That's going to be THE common case, because distros will
> inevitably build the VLAN module with their stock kernel.

Well, this was discussed on the VLAN mailing list. The conclusion
there was that it will not hurt on most cards if it is enabled
unconditionally.

The only situation where it will probably hurt is if you have many
frames exceeding ethernet MTU coming in through your ethernet cable.
Those (up to FDDI size e.g. on 3COM cards without MaxPktSize support)
will not be dropped by the card but instead handed up to the network
stack and be dropped there. Are there any situations (except for
failure cases) where a lot large frames are sent over normal ethernet?

And for the 802.1q recognition of Cyclone and Tornado cards, this only
affects the IP checksumming done by the hardware. As plain IP is never
transmitted in frames with an ethernet type of 0x8100, this also will
not affect normal operation.


Anyway, if you want to enable it only if VLANs are really used on the
card, what about adding a new hook to struct net_device, which can be
used by the 802.1q core code to enable VLAN support on the card as
needed (if supported by the driver)? Or, as this is only a boolean
flag, maybe a generic feature_supported/set_feature hook pair that can
be used for other similar situations in the future?

> 3) 3c59x needs real dev->change_mtu support.  This patch provides the
> info needed to do that... but doesn't do that.

Intentionally, as this has nothing to do with VLAN support. The whole
thing about the patch was that you /don't/ have to change the physical
device MTU visible to the network stack. Otherwise the network stack
would start sending oversized frames to the ethernet, which would
render the untagged VLAN useless.

> 4) It uses magic numbers instead of ETH_DATA_LEN and ETH_HLEN

That's what the driver used before ;-)

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
