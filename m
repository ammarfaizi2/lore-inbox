Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbSKGPra>; Thu, 7 Nov 2002 10:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbSKGPra>; Thu, 7 Nov 2002 10:47:30 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3599 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261316AbSKGPr3>; Thu, 7 Nov 2002 10:47:29 -0500
Date: Thu, 7 Nov 2002 15:54:04 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.5.45-ac1 CardBus compile Fix
Message-ID: <20021107155404.B11437@flint.arm.linux.org.uk>
Mail-Followup-To: Osamu Tomita <tomita@cinet.co.jp>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <3DCA89A0.E6B6DDEF@cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DCA89A0.E6B6DDEF@cinet.co.jp>; from tomita@cinet.co.jp on Fri, Nov 08, 2002 at 12:41:20AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 12:41:20AM +0900, Osamu Tomita wrote:
> I couldn't compile cistpl.c, that call obsolete function.
> 
> Here is trivial patch. This works fine for me.
> 
> Regards,
> Osamu Tomita
> --- linux-2.5.45-ac1/drivers/pcmcia/cistpl.c.orig	Thu Oct 31 09:42:24 2002
> +++ linux-2.5.45-ac1/drivers/pcmcia/cistpl.c	Thu Nov  7 01:03:55 2002
> @@ -429,7 +429,7 @@
>  #ifdef CONFIG_CARDBUS
>      if (s->state & SOCKET_CARDBUS) {
>  	u_int ptr;
> -	pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
> +	pci_bus_read_config_dword(s->cap.cb_dev->bus, 0, 0x28, &ptr);
>  	tuple->CISOffset = ptr & ~7;
>  	SPACE(tuple->Flags) = (ptr & 7);
>      } else

I think dev->bus the bus number for the bus that the Cardbus controller
is connected to?  If so, this change is wrong.

bus:device.function = 0:0.0
+--------+
| host   |
| bridge >--------+------------------ dev->bus
+--------+        |
                  |
             +----v----+ dev
             | Cardbus |
             | Bridge  |
             +---------+
                  |
                  | bus number = dev->subordinate->number
                  |
                  |
             +----v----+ bus = dev->subordinate->number
             | Cardbus | device = 0
             |   card  |
             +---------+

The device we want to read the CIS offset from is the cardbus card.
In the above case, your change means we'll try to read the CIS offset
from the host bridge, which is obviously wrong.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

