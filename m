Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318487AbSHGOW1>; Wed, 7 Aug 2002 10:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318590AbSHGOW1>; Wed, 7 Aug 2002 10:22:27 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:15877 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318487AbSHGOW0>; Wed, 7 Aug 2002 10:22:26 -0400
Date: Wed, 7 Aug 2002 16:25:32 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at tg3.c:1557
In-Reply-To: <20020807.050329.92273054.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0208071613120.3705-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your quick reply.

On Wed, 7 Aug 2002, David S. Miller wrote:

>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 07 Aug 2002 14:14:37 +0100
> 
>    I've never been able to get a broadcom chipset ethernet card stable on a
>    dual athlon with AMD 76x chipset. I have no idea what the problem is
>    although it certainly appears to be PCI versus main memory ordering
>    funnies.
> 
> One thing you can try is the following in tg3.c:
> 
> 1) Force TG3_FLAG_PCIX_TARGET_HWBUG to be set in tp->tg3_flags
> 
> 2) Change "tw32_mailbox(reg, val)" define to just be identical
>    to "tw32(reg, val)"

The second change is straightforward, and I implemented the first by 
setting

*** around line 5569
        pci_read_config_dword(tp->pdev, TG3PCI_PCISTATE,
                              &pci_state_reg);

+       tp->tg3_flags |= TG3_FLAG_PCIX_TARGET_HWBUG; // rk
        if ((pci_state_reg & PCISTATE_CONV_PCI_MODE) == 0) {
                tp->tg3_flags |= TG3_FLAG_PCIX_MODE;

***

With these changes I'm unable to bring the interface up again, getting 
timeouts from tg3_stop_block:

Aug  7 16:06:47 pccoeb09 kernel: tg3.c:v0.99 (Jun 11, 2002)
Aug  7 16:06:47 pccoeb09 kernel: AMD756: dev 14e4:1644, router pirq : 86 
get irq :  0
Aug  7 16:06:47 pccoeb09 kernel: AMD756: dev 14e4:1644, router pirq : 86 
SET irq : 11
Aug  7 16:06:47 pccoeb09 kernel: PCI: Assigned IRQ 11 for device 00:08.0
Aug  7 16:06:47 pccoeb09 kernel: IRQ routing conflict for 00:09.0, have 
irq 5, want i
rq 11
Aug  7 16:06:47 pccoeb09 kernel: eth0: Tigon3 [partno(BCM95700A6) rev 7102 
PHY(5401)]
 (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:04:76:30:7e:ee
Aug  7 16:06:49 pccoeb09 kernel: tg3: tg3_stop_block timed out, ofs=2c00 
enable_bit=2
Aug  7 16:06:48 pccoeb09 kernel: tg3: tg3_stop_block timed out, ofs=2000 
enable_bit=2
Aug  7 16:06:49 pccoeb09 kernel: tg3: tg3_stop_block timed out, ofs=3400 
enable_bit=2
Aug  7 16:06:50 pccoeb09 kernel: tg3: tg3_stop_block timed out, ofs=2400 
enable_bit=2
Aug  7 16:06:48 pccoeb09 kernel: tg3: tg3_stop_block timed out, ofs=2800 
enable_bit=2
Aug  7 16:06:49 pccoeb09 kernel: tg3: tg3_stop_block timed out, ofs=3000 
enable_bit=2
Aug  7 16:06:50 pccoeb09 kernel: tg3: tg3_stop_block timed out, ofs=1400 
enable_bit=2
Aug  7 16:06:48 pccoeb09 kernel: tg3: tg3_stop_block timed out, ofs=1800 
enable_bit=2
Aug  7 16:06:49 pccoeb09 kernel: tg3: tg3_stop_block timed out, ofs=c00 
enable_bit=2
Aug  7 16:06:47 pccoeb09 kernel: tg3: tg3_stop_block timed out, ofs=4800 
enable_bit=2
Aug  7 16:06:48 pccoeb09 kernel: tg3: tg3_stop_block timed out, ofs=1000 
enable_bit=2
Aug  7 16:06:49 pccoeb09 kernel: tg3: tg3_stop_block timed out, ofs=1c00 
enable_bit=2
Aug  7 16:06:47 pccoeb09 ifup: SIOCSIFFLAGS: Device or resource busy
Aug  7 16:06:47 pccoeb09 ifup: Failed to bring up eth0.

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

