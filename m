Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbUDRM5b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 08:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264159AbUDRM5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 08:57:31 -0400
Received: from mailout.mbnet.fi ([194.100.161.24]:264 "EHLO posti.mbnet.fi")
	by vger.kernel.org with ESMTP id S264029AbUDRM52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 08:57:28 -0400
From: Kimmo Sundqvist <musher@mbnet.fi>
Organization: Unorganized
To: Andrew Morton <akpm@osdl.org>
Subject: Re: modprobe 3c509 segfaults
Date: Sun, 18 Apr 2004 15:55:05 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
References: <200404171554.29419.musher@mbnet.fi> <20040417105557.55ea8520.akpm@osdl.org>
In-Reply-To: <20040417105557.55ea8520.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404181555.05741.musher@mbnet.fi>
X-OriginalArrivalTime: 18 Apr 2004 12:57:27.0359 (UTC) FILETIME=[B38D1CF0:01C42544]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 April 2004 20:55, Andrew Morton wrote:

> Seems that we used to unconditionally link the device into the
> el3_root_devchain in el3_common_init(), but that was removed, and we now
> conditionally link it, denendent upon sone ifdefs which you presumably have
> not set.

> Does this fix it up?

Now I can use modprobe and then remove the module as many times as I want, but 
some a bit odd behavior appeared.  Some details are repeated from my original 
message:

Two 3c509 cards, a BNC/AUI one, configured with 3com's setup utility 
(3c5x9cfg.exe) to IRQ 9, port 0x210, and a RJ-45 one, configured to IRQ 5, 
port 0x300.  Both use non-pnp initalisation, and don't say anything if I do 
pnpdump.

Under Debian (kernel 2.4.22), the cards were probed IRQ 12 and 5, but ifconfig 
said IRQ 9 and 5 if I had told modprobe "irq=9,5", and both cards worked 
perfectly.

Under Gentoo, kernel 2.6.6-rc1 and your patch applied (I couldn't figure out 
how to correctly use patch, so I deleted the two lines in 3c509.c manually), 
the BNC card is found at IRQ 12 and RJ-45 card at IRQ 5 according 
to /var/log/messages.  And this is the same with every single run of insmod.

1. modprobe (or insmod) with no irq given:
eth0 doesn't come up, Device or resource busy
eth1 comes up with IRQ 5, port 0x300, and appears working

2. modprobe (or insmod) with irq=9,5 given:
eth0 comes up with IRQ _5_, port 0x210, and for some odd reason, works
eth1: Device or resource busy

3. same as the above, (irq=9,5) but eth1 up first
eth1 comes up with IRQ 5, port 0x300, and appears working
eth0: Device or resource busy

4. modprobe (or insmod) with irq=5,9 given:
both come up and work as expected
eth0 is IRQ 9, eth1 is IRQ 5

It is documented that the order of detection is arbitrary.  Both systems have 
the card at IRQ 9 (IRQ 12 in logs) always found first, but Gentoo (kernel 
2.6.6-rc1) needs irq=5,9 while Debian (vanilla kernel 2.4.22) needs irq=9,5.

Biggest thing left to understand is, why does the card work in try 2?  I know 
for sure that eth0 of try 2 is eth0 of try 3 (the BNC card), so we have 
different cards working there.

There is a network only at the BNC connector of one card, so by "appears 
working" I mean that the RJ-45 card comes up and generates interrupts, takes 
an IP address and transmits pings, but - as is expected - doesn't get any 
replies.

-Kimmo S.
