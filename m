Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279896AbRJ3JLr>; Tue, 30 Oct 2001 04:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279897AbRJ3JLh>; Tue, 30 Oct 2001 04:11:37 -0500
Received: from mail201.mail.bellsouth.net ([205.152.58.141]:38108 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279822AbRJ3JLa>; Tue, 30 Oct 2001 04:11:30 -0500
Message-ID: <3BDE6EE7.EC006474@mandrakesoft.com>
Date: Tue, 30 Oct 2001 04:12:07 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Eriksson <nitrax@giron.wox.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: via-rhine and MMIO
In-Reply-To: <04b801c1607a$947dbef0$0201a8c0@HOMER>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Eriksson wrote:
> (drivers/net/via-rhine.c)
> ...
> /* Reload the station address from the EEPROM. */
> writeb(0x20, ioaddr + MACRegEEcsr);
> /* Typically 2 cycles to reload. */
> for (i = 0; i < 150; i++)
>     if (! (readb(ioaddr + MACRegEEcsr) & 0x20))
>         break;
> ...
> 
> If I run this code when I'm using MMIO, I get a hardware adress of
> "ff:ff:ff:ff:ff:ff" instead of the right one (and everything craps up). But
> when I comment out this part all is fine. So what's it needed for anyway?

On init all NIC drivers should get the MAC address from the NIC's
EEPROM, and store it in dev->dev_addr[].

If the MAC address is changed by the user in Windows, or in a previous
driver invocation, you want to change it back to the default.  Obtaining
the address from EEPROM is the only way to do this on most cards.  Since
the via-rhine apparently doesn't support this directly, it does the next
best thing:  kick the h/w to reload the EEPROM into chip registers, and
then read the MAC address from the chip registers.

WRT the above code, you should add a check to see if '150' is enough of
a wait.  MMIO is faster and would affect that loop.  Maybe you want to
schedule_timeout before reading MACRegEEcsr to delay a little bit.


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

