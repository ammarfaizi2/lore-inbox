Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268759AbUHTVml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268759AbUHTVml (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 17:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268765AbUHTVml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 17:42:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:15492 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268759AbUHTVmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 17:42:32 -0400
Date: Fri, 20 Aug 2004 14:41:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Timer allocates too many ports
Message-Id: <20040820144106.46fb3b1b.rddunlap@osdl.org>
In-Reply-To: <41266C5D.7000908@drzeus.cx>
References: <4126600F.4050302@drzeus.cx>
	<20040820140503.67d23479.rddunlap@osdl.org>
	<41266C5D.7000908@drzeus.cx>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 23:25:49 +0200 Pierre Ossman wrote:

| Randy.Dunlap wrote:
| 
| >On Fri, 20 Aug 2004 22:33:19 +0200 Pierre Ossman wrote:
| >
| >| The timer in linux allocates the io ports 0x40 to 0x5F. This is causing 
| >| some problems for me since the hardware I'm writing a driver for has its 
| >| ports at 0x4E and 0x4F. In Windows the ports 0x40 to 0x43 are used for 
| >| the timer. Why does linux allocate so many more ports?
| >
| >Seems reasonable to me for Linux timer driver (resource) to allocate
| >0x40 - 0x43 and 0x50 - 0x53 (on intel x86; only 0x40 - 0x43 for AMD x86-64).
| >At least that's what is in some Intel specs.  That would be accurate
| >AFAIK and still leave 0x4e - 0x4f available.
| >  
| >
| Unfortunately the driver allocates 0x40-0x5f as can be seen in 
| /proc/ioports:
| 0040-005f : timer

Yes, I know, I wasn't questioning that.

| I do not know which file contains this allocation so I haven't been able 
| to change it. Any ideas?

Sure, arch/i386/kernel/setup.c, near line 221 (in 2.6.8.1):

	.name	= "timer",
	.start	= 0x0040,
	.end	= 0x005f,
	.flags	= IORESOURCE_BUSY | IORESOURCE_IO

Just split that into 2 entries in the standard_io_resources[] array
and it's done.


| >What kind of device uses IO addresses 0x4e - 0x4f?
| >Is it a motherboard device?  Intel ICH specs think that 0x4e - 0x4f
| >are for LPC SIO and are forwarded to the LPC device.
| >
| >
| The device is a SD/MMC card reader which is indeed an LPC device. The 
| ports in question are needed to identify the chip and determine which 
| resources it has. Actual usage is done on higher ports.


--
~Randy
