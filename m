Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267690AbUIOWrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267690AbUIOWrn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267689AbUIOWq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:46:57 -0400
Received: from pD9E7547E.dip0.t-ipconnect.de ([217.231.84.126]:5249 "EHLO
	achilles.nass-vogt.home") by vger.kernel.org with ESMTP
	id S267690AbUIOWkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:40:09 -0400
From: Hans-Frieder Vogt <hfvogt@arcor.de>
Reply-To: hfvogt@arcor.de
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot (FIX included)
Date: Thu, 16 Sep 2004 00:40:03 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@oss.sgi.com
References: <200409130035.50823.hfvogt@arcor.de> <20040913220209.GA13175@electric-eye.fr.zoreil.com> <200409140131.11927.hfvogt@arcor.de>
In-Reply-To: <200409140131.11927.hfvogt@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409160040.03532.hfvogt@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois,

I did a few tests with the r8169 driver on my x86-64 system:

with DAC enabled (as is default),
the first interrupt is a read interrupt, because the status read from 
IntrStatus is 0x8001, i.e. SYSErr | RxOK.
So, a PCI error did occur, which is strange.
Because of the RxOK bit, rtl8169_rx_interrupt is called. In this routine,
tp->cur_rx is 0
tp->dirty_rx is 0
tp->RxDescArray[entry].status is 0,
which then gives a pkt_size of -4!
The system freezes somewhere in rtl8169_rx_interrupt.

When I do a
if (pkt_size < 0) break;
in rtl8169_rx_interrupt to block the errorneous pkt_size, the system still 
freezes, but AFTER LEAVING the interrupt routine rtl8169_interrupt.

Same, when I introduced a shortcut to get rid of the SYSErr.

For comparison:
When I switch off DAC, then the first interrupts are
1: IntrStatus: 0x0484 (? | TxDescUnavail?), -> tx interrupt
2: IntrStatus: 0x0484, -> tx interrupt
3: IntrStatus: 0x0485, -> rx interrupt
...

Just another thought:
Of course x86-64 has the address-space that enables >4GB RAM, and x86-64 
always supports DAC (as stated in include/asm-x86_64/pci.h), but I have 
currently only 1GB RAM, so, strictly speaking, DAC is not really necessary. 
Strange enough, the latest Realtek driver 2.2 does not even support DAC (only 
the lower 32 bit of the DMA-Addresses are written to the registers).
Could it be that the Realtek driver does not support DAC for a good reason?

Anyway, I will continue searching for the problem...

Hans-Frieder

Am Dienstag, 14. September 2004 01:31 schrieb Hans-Frieder Vogt:
> Am Dienstag, 14. September 2004 00:02 schrieb Francois Romieu:
> > Hans-Frieder Vogt <hfvogt@arcor.de> :
> > [...]
> >
> > > no oops (BUG_ON not triggered)! System boots up as normal, but just
> > > after I
> >
> > ...
> >
> > > log in on the console the system freezes, i.e., keyboard does not react
> > > any more and the system is not accessible via network.
> >
> > - do the keyboard leds or the magic sysrq answer (I assume you boot
> > without
>
> X) ?
>
> (To be able to exclude any side effect of X, I have booted without X and I
> have also removed all graphics driver related modules)
>
> When the system freezes, the keyboard is completely dead, the LEDs do not
> react any more and also the sysrq keys do not work.
>
> > - does it make a difference if you boot with the network cable
> > unpluged (i.e. fine until pluged then dead when first packet comes in) ?
>
> YES!! With the network cable unplugged, the system does not freeze!
> Every 10 seconds, I get now the message:
> r8169: eth0: PHY reset until link up
> but otherwise everything seems fine.
>
> > > The time from the moment I log in to the time when the system freezes
> > > varies, but is in the order of 5s.
> >
> > First packet probably. Can you verify this point ?
>
> I think the test with the network cable unplugged supports this assumption.
> With network cable unplugged, /proc/interrupts shows 0 interrupts for the
> network card, so probably the first interrupt leads to the system freeze.
>
> > > There is no difference whether NAPI is enabled or not.
> >
> > I will welcome lspci -vx + gcc version + objdump -S of the r8169 module.
>
> lspci -vx and objdump -S output (gzipped) are attached, gcc version is
> 3.4.2 (Debian 3.4.2-2), but no visible difference with 3.4.1.
>
> > --
> > Ueimor
>
> Thanks for your help, Francois.
> I will put a few printks into the interrupt routine and hope to be able to
> tell you more tomorrow,
>
> Hans-Frieder

-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt (at) arcor (dot) de
