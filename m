Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbUKPAoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUKPAoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 19:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbUKPAoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 19:44:55 -0500
Received: from inx.pm.waw.pl ([195.116.170.20]:7615 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261728AbUKPAos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 19:44:48 -0500
To: Ferenci Daniel <Daniel.Ferenci@siemens.com>
Cc: eis@baty.hanse.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: hdlc bridge
References: <4198B949.40504@siemens.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 16 Nov 2004 01:42:44 +0100
In-Reply-To: <4198B949.40504@siemens.com> (Ferenci Daniel's message of "Mon,
 15 Nov 2004 15:12:25 +0100")
Message-ID: <m38y928vzv.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

BTW: I would appreciate being Cc:'ied while discussing generic HDLC
things, especially the ones which are aimed at the official kernels.
Thanks.

Added netdev, too.

Ferenci Daniel <Daniel.Ferenci@siemens.com> writes:

> HDLC bridge is kind of a stack for hdlc bridging.
> It can be usefull for sniffing hdlc traffic (within two hdlc interface).

Right.

Of course, given the isolated nature of such bridge, it can be implemented
in either kernel-space or user-space.

> sethdlc hdlc0 hdlc-bridge
> sethdlc hdlc1 hdlc-bridge

You should be able to use more than one bridge I think - the syntax should
allow this.

Something like:
	sethdlc hdlc0 hdlc
	sethdlc hdlc1 add-to-bridge hdlc0
or
	sethdlc create-hdlc-bridge hdlcbr0
        sethdlc hdlc0 add-to-bridge hdlcbr0
        sethdlc hdlc1 add-to-bridge hdlcbr0

would probably be better.

> +++ linux-2.4.25.intel/include/net/hdlcbridge.h    Sat Nov 13 08:21:12 2004

First, I would do all works against 2.6 kernel. You may want to check
with Marcelo, Jeff and/or David, but I wouldn't expect them to apply
such patches to 2.4 when 2.6 doesn't have them.
I wouldn't do that either.

> +typedef enum {
> +    PHYS_OK,
> +    PHYS_NOK
> +} STAT;

I don't think such bridge has anything to do with anything "physical".
I would rather change "PHYS" into something related to the actual
nature of underlying device (which could be virtual, a tunnel, or
anything).

> +++ linux-2.4.25.intel/net/Config.in    Sat Nov 13 08:22:39 2004
> @@ -1,6 +1,8 @@
>  #
>  # Network configuration
>  #
> +# 12.11.2004 Daniel Ferenci added parts for hdlcbridge
> +
>  mainmenu_option next_comment
>  comment 'Networking options'
>  tristate 'Packet socket' CONFIG_PACKET
> @@ -9,6 +11,9 @@
>  fi
>  tristate 'Netlink device emulation' CONFIG_NETLINK_DEV
> +tristate 'Netlink sockets' CONFIG_NETLINK
> +

I sense something not related to HDLC bridging here.

> +++ linux-2.4.25.intel/net/hdlcbridge/hdlc_bridge.c    Sat Nov 13
...

> +int phys_bridge_data_received(hdlc_device *hdlc, struct sk_buff *skb)

I think it should be run directly in/from hdlc->netif_rx().
Possibly using *_type_trans() etc.
Not sure why it has to be that complicated - one more file in drivers/wan
would be enough, wouldn't it?

> +++ linux-2.4.25.intel/drivers/net/wan/hdlc_bridge.c    Sat Nov 13

Exactly such a file.

> +static void bridge_rx(struct sk_buff *skb)
> +{
> +    hdlc_device *hdlc = dev_to_hdlc(skb->dev);
> +    +    printk(KERN_ERR "bridge_rx device: %s", skb->dev->name);
> +
> +    if (phys_bridge_data_received(hdlc, skb) == PHYS_OK)
> +        return;
> +    hdlc->stats.rx_errors++;
> +    dev_kfree_skb_any(skb);
> +}

bridge_rx() should IMHO just send the frame to the other end,
if of course possible (device up etc). This module would better know
both ends, right?

> +++ linux-2.4.25.intel/drivers/net/wan/hdlc_generic.c    Sat Oct 30

> +    case IF_PROTO_LAPB:    return hdlc_x25_ioctl(hdlc, ifr);

Something extra I'd say.

> +#include <linux/lapb/ioctl.h>

Same here.

> +#define IF_GET_ST3    0x0003

Hmm... Not sure.

> +#define IF_PROTO_HDLC_BRIDGE 0x200C     /* hdlc bridge stack */

This one is probably fine, but not sure about the following two:

> +#define IF_PROTO_HDLC_SEND 0x200D     /* hdlc bridge stack */
> +#define IF_PROTO_LAPB 0x200E     /* lapb stack */

> -
> +        struct lapb_parms_struct    *lapb_stuff;

Same here.

> +        st3_status        *st3;
> +        +        buffer            *data;
> +obj-$(CONFIG_TAHOE9XX)        += tahoe9xx.o
> +obj-$(CONFIG_X25TAP)        += x25tap.o
> +

Hmm...
-- 
Krzysztof Halasa
