Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261399AbSKGQXF>; Thu, 7 Nov 2002 11:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbSKGQXF>; Thu, 7 Nov 2002 11:23:05 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:53551 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261399AbSKGQXD>; Thu, 7 Nov 2002 11:23:03 -0500
Message-ID: <3DCA94BA.2C5B4925@cinet.co.jp>
Date: Fri, 08 Nov 2002 01:28:42 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.45-ac1-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.5.45-ac1 CardBus compile Fix
References: <3DCA89A0.E6B6DDEF@cinet.co.jp> <20021107155404.B11437@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Fri, Nov 08, 2002 at 12:41:20AM +0900, Osamu Tomita wrote:
> > I couldn't compile cistpl.c, that call obsolete function.
> >
> > Here is trivial patch. This works fine for me.
> >
> > Regards,
> > Osamu Tomita
> > --- linux-2.5.45-ac1/drivers/pcmcia/cistpl.c.orig     Thu Oct 31 09:42:24 2002
> > +++ linux-2.5.45-ac1/drivers/pcmcia/cistpl.c  Thu Nov  7 01:03:55 2002
> > @@ -429,7 +429,7 @@
> >  #ifdef CONFIG_CARDBUS
> >      if (s->state & SOCKET_CARDBUS) {
> >       u_int ptr;
> > -     pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
> > +     pci_bus_read_config_dword(s->cap.cb_dev->bus, 0, 0x28, &ptr);
> >       tuple->CISOffset = ptr & ~7;
> >       SPACE(tuple->Flags) = (ptr & 7);
> >      } else
> 
> I think dev->bus the bus number for the bus that the Cardbus controller
> is connected to?  If so, this change is wrong.
> 
> bus:device.function = 0:0.0
> +--------+
> | host   |
> | bridge >--------+------------------ dev->bus
> +--------+        |
>                   |
>              +----v----+ dev
>              | Cardbus |
>              | Bridge  |
>              +---------+
>                   |
>                   | bus number = dev->subordinate->number
>                   |
>                   |
>              +----v----+ bus = dev->subordinate->number
>              | Cardbus | device = 0
>              |   card  |
>              +---------+
> 
> The device we want to read the CIS offset from is the cardbus card.
> In the above case, your change means we'll try to read the CIS offset
> from the host bridge, which is obviously wrong.
Thanks for exposition.
Is this right?

--- linux-2.5.45-ac1/drivers/pcmcia/cistpl.c.orig       Thu Oct 31 09:42:24 2002
+++ linux-2.5.45-ac1/drivers/pcmcia/cistpl.c    Fri Nov  8 01:19:32 2002
@@ -429,7 +429,7 @@
 #ifdef CONFIG_CARDBUS
     if (s->state & SOCKET_CARDBUS) {
        u_int ptr;
-       pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
+       pci_bus_read_config_dword(s->cap.cb_dev->subordinate, 0, 0x28, &ptr);
        tuple->CISOffset = ptr & ~7;
        SPACE(tuple->Flags) = (ptr & 7);
     } else
