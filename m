Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310511AbSBRMNE>; Mon, 18 Feb 2002 07:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310510AbSBRMMz>; Mon, 18 Feb 2002 07:12:55 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:8940 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S310505AbSBRMMr>;
	Mon, 18 Feb 2002 07:12:47 -0500
To: Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, torvalds@transmeta.com,
        jgarzik@mandrakesoft.com
Subject: Re: [PATCH] HDLC patch for 2.5.5 (0/3)
In-Reply-To: <20020217193005.B14629@se1.cogenit.fr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Feb 2002 13:09:19 +0100
In-Reply-To: <20020217193005.B14629@se1.cogenit.fr>
Message-ID: <m3zo27outs.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Francois Romieu <romieu@cogenit.fr> writes:

> [0/3]:

Looks ok for me.

> - SIOCDEVICE -> SIOCWANDEV conversion

But I wonder if that's what we really want. IIRC, the conclusion was
that we need a uniform interface for both LAN and WAN (with the ETHTOOL
being replaced eventually by it). That was why I changed it to "DEVICE"
the first time (for me personally, there is no problem with that).

> [1/3]:
> - struct if_settings in struct ifreq becomes struct if_settings *;
> - anonymous data pointer in struct if_settings is now a pointer to a
>   union of struct containing l2 parameters. These structs can be of
>   arbitrary size. So far, hdlc_settings is the only one available;

These two are IMHO bad :-(
The union would then be as big as the largest struct.
What's worse, the size would change when we add larger struct (i.e.
new protocol), causing binary incompatibility. With my patch, if we
add a new protocol (struct), existing utils would work.

The whole
+struct hdlc_settings {
+	union {
+		raw_hdlc_proto		raw_hdlc;
+		cisco_proto		cisco;
+		fr_proto		fr;
+		fr_proto_pvc		fr_pvc;
+		sync_serial_settings	sync;
+		te1_settings		te1;
+	} hdlcs_hdlcu;
+};
idea is IMHO bad - we need a variable size, separate structures for
separate protocols/interfaces. I think we should avoid a union at all costs.

Creating the new ioctl.h file seem ok to me.


Remember that i.e. sync_serial_settings are not related to any HDLC
protocol - that's just a physical interface which could be used for
things like SDLC, transparent transmissions etc. - or even for async
things (the synchronous interface can work in async mode as well).

> [2/3]:
> - conversion of drivers/net/wan/hdlc_xxx.c files.
> 
> [3/3]:
> - some device are converted (c101.c/dscc4.c/farsync.c/n2.c).

IMHO we could wait with the real code until the interface is stable.

> Remarks:
> - As hdlc_{raw/cisco/fr/x25} doesn't need knowledge of struct ifreq, I would 
> happily pass them a pointer to a struct if_settings. This way the 2 stage 
> ioctl would be clearer imho.

Yes. The previous implementation depends on dev->do_ioctl and the
whole "PRIVATE" ioctls idea. When it's dead, we no longer require the
cmd/ifreq/etc.
-- 
Krzysztof Halasa
Network Administrator
