Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267253AbTA0Rof>; Mon, 27 Jan 2003 12:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267257AbTA0Rof>; Mon, 27 Jan 2003 12:44:35 -0500
Received: from [217.167.51.129] ([217.167.51.129]:37094 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S267253AbTA0Roe>;
	Mon, 27 Jan 2003 12:44:34 -0500
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Martin Mares <mj@ucw.cz>, geert@linux-m68k.org,
       Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030127134010.C2569@jurassic.park.msu.ru>
References: <20030126181326.A799@localhost.park.msu.ru>
	 <20030126214550.GB6873@ucw.cz> <1043624458.2755.37.camel@zion.wanadoo.fr>
	 <20030127094645.GD604@ucw.cz>  <20030127134010.C2569@jurassic.park.msu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043690104.2756.42.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 27 Jan 2003 18:55:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-27 at 11:40, Ivan Kokshaysky wrote:

> Then vgacon.c would be changed like this:
> 
> ...
> -	request_resource(&ioport_resource, &vga_console_resource);
> +	if (legacy_ioport_remap(&vga_console_resource) < 0)
> +		goto failure;
> ...
> 
> And all in/out port calls would use respective resource.start+offset:
> ...
> -	outb_p(6, 0x3ce)
> +	outb_p(6, vga_console_resource.start + 0xe);
> 
> No need for other special IO functions then.

Well, your example clearly limits us to one IO space for VGA, which
might not be what we want. The problem also exist for some fbdev drivers
which might need to tap the VGA IOs of a given PCI card (thus getting
access to the "legacy" IOs of the bus the card is on).
It would be nice to provide some more generic solution to deal with that
"ISA" problem...
Finally, in the embedded world, we frequently have to deal with "legacy"
controllers (ethernet, serial, ...) stuffed on whatever bus we have
around, at addresses that might not be usual port addresses.

It's definitely a good idea to always add a "base" to the legacy IOs as
your examples shows though. The problem remaining is how to actually
obtain this address for the various cases whe are interested in.

Ben.


