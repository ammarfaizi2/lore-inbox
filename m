Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262512AbSJPNht>; Wed, 16 Oct 2002 09:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSJPNhq>; Wed, 16 Oct 2002 09:37:46 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:9409 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S262512AbSJPNhn>;
	Wed, 16 Oct 2002 09:37:43 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: Generic HDLC interface continued
References: <35278845015.20021010232749@parabel.inc.ru>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 15 Oct 2002 22:20:13 +0200
In-Reply-To: <35278845015.20021010232749@parabel.inc.ru>
Message-ID: <m34rbncv42.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Selivanov <pavel-linux-kernel@parabel.inc.ru> writes:

>  I'm sure that hdlc stack must provide only protocols support (and a
>  configuration utility to configure protocol's parameters only).
>  All other job is developer's problem (even crc type).

That's what the code does - the hdlc_*.c code knows only protocol
ioctls, and passes other things straight to hardware driver.

But the interface (structure definitions) must be the same for all
devices, as we don't want different tools for different cards.

>  While placing interface type in hdlc struct's isn't good,
>  but to place it in net_device is a good idea (I think).

I don't think so. Most cards (not necesarilly WAN ones) have only
one interface (type).

>  2) If I've understand author's ideology, he is going to implement
>  hdlc stack "near" current network stack.
>  I mean hdlc_device appends new fields to net_device, so hdlc device
>  is still the same device as ethernet, and that's fine.

I used to think of it as of inherited structure from, say, C++.

>  I dont understant what is it for (for this ideology)?
>  >>>>>>>>
>  if.h
> struct if_settings
> {
>         unsigned int type;      /* Type of physical device or protocol */
>         union {
>                 /* {atm/eth/dsl}_settings anyone ? */
>                 union hdlc_settings ifsu_hdlc;
>                 union line_settings ifsu_line;
>         } ifs_ifsu;
> };  
> .....
> in struct ifreq
>                 struct  if_settings *ifru_settings;
>  <<<<<<<<
> Is it really necessary ?
> At my opinion it would be better to use char *,

It was done that way at some point and then redesigned, but now I think
we should rather use just a union of struct pointers.

The hdlc/ioctl.h may seem to be a little overkill, I understand the
definitions are there for performance reasons (while building the kernel).

> If someone will have to support one more protocol, he have to modify
> hdlc.h (to add new struct in the union)...

Yes.

> As long as sethdlc tell to hdlc stack: I want ppp-over-fr, hdlc to:
> - search proto_list for ppp, search for fr.
> - attaches ppp to prot pointer in hdlc_device
> - calls fr->attach (which allocated priv pointer)
> - calls ppp->attach (which allocates priv pointer)
> - calls fr->enslave
> 
> This model seems bulki, but It's much more flexible (without changin
> API, what is very important at my opinion.)

That's not about changing API, that's only adding _new_ parts to the API,
it doesn't break anything. Anyway, the current code:
- exist
- is quite simple and thus reliable
- does the job.
So I'm not going to spend time on changing it once again, except for
the union change mentioned earlier (a cosmetic change).

> 5) It's bad to handle get_stats by hdlc stack.
> Some chips provides some info, which I shoud ask(for ifconfig)...

hdlc_* basically only increments rx_errors counter... We could drop
the get_stats() (move it to hw drivers) when we have a driver which
needs that. It's not a problem, it doesn't really change anything.

> It's very comfortable in cisco that I have full protocol's info
> (broadcasts, protocol errors, ...).

Cisco = IOS software or Cisco = protocol?
Yes, it would be better to have another set of stats for hw and another
one for upper layers. That's true for most interface types, not only
WAN HDLC-like ones.

Or should we add new fields to existing struct? Possibly.

> I just want for hdlc stack in Linux to be as usefull as it's
> possible, and to have a single API (HDLC API changing in second
> time...).

That's exactly what I want, too.
-- 
Krzysztof Halasa
Network Administrator
