Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267096AbSIRP4I>; Wed, 18 Sep 2002 11:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbSIRP4I>; Wed, 18 Sep 2002 11:56:08 -0400
Received: from dmz.hesby.net ([81.29.32.2]:45252 "HELO firewall.hesbynett.no")
	by vger.kernel.org with SMTP id <S267096AbSIRP4G> convert rfc822-to-8bit;
	Wed, 18 Sep 2002 11:56:06 -0400
Subject: Re: Virtual to physical address mapping
From: Ole =?ISO-8859-1?Q?Andr=E9?= Vadla =?ISO-8859-1?Q?Ravn=E5s?= 
	<oleavr-lkml@jblinux.net>
To: root@chaos.analogic.com
Cc: steve@neptune.ca, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020918075900.3583A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1020918075900.3583A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Sep 2002 18:04:44 +0200
Message-Id: <1032365084.3481.12.camel@zole.jblinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 14:06, Richard B. Johnson wrote:
> On 18 Sep 2002, Ole [ISO-8859-1] André Vadla [ISO-8859-1] Ravnås wrote:
> 
> > Thanks, but the address specified there is certainly not the same as the
> > base address ifconfig reports. I made a simple program to verify this:
> 
> [SNIPPED...]
> 
> `ifconfig` reports the base address of a port (I don't know why).
> There are other addresses in use.

Ah.. that explains it all, as I modified net/core/dev.c earlier today to
report the base_addr present in the net_device structure in the
sprintf_stats() which is responsible for the /proc/net/dev output --
and, what I got was:
0xf88fa000
where the ifmap structure returned by the SIOCGIFMAP ioctl contained a
base_addr saying:
0xa000
I did this ugly hack (WRT net/core/dev.c) since I discovered that the
net_device()'s base_addr was an unsigned long, while ifmap's base_addr
was an unsigned short - and indeed, just like you said, it's only the
base-address that's returned in the ifmap. :-)

> eth0      Link encap:Ethernet  HWaddr 00:50:DA:19:7A:7D  
>           inet addr:10.100.2.224  Bcast:10.255.255.255  Mask:255.0.0.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:2630005 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:307396 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:2430 txqueuelen:100 
>           Interrupt:10 Base address:0xb800 
> 
> [SNIPPED...]
> 
> A private version of `lspci` that actually reads the PCI ports
> shows:
> 
> Device      Vendor                    Type
>    0   Intel Corporation              440BX/ZX - 82443BX/ZX Host bridge
> [SNIPPED...]
>   11   3Com Corporation               3c905B 100BaseTX [Cyclone]         
>        IRQ 10 Pin A
>        I/O  ports : 0xb800->0xb87e
>        I/O memory : 0xdf800000->0xdf80007f
> 
> Notice that it has memory-mapped I/O.
> That said, neither of these addresses are the virtual addresses.
> On an ix86, these are physical addresses which are the same as
> the bus addresses. Other machines may not have the same physical
> and bus address. The virtual address is whatever mmap() returns
> in user-space, and whatever ioremap() returns in kernel space.
> Note that in kernel space, the returned value should not be used
> as a pointer. There are macros defined to access the I/O addressed
> elements. See .../linux/Documentation/IO-mapping.txt.

Ah, I see! Thanks a lot for your help! :-)

Best regards
Ole André


