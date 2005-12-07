Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751816AbVLGXPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbVLGXPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbVLGXPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:15:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:42909 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751816AbVLGXPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:15:19 -0500
Subject: Re: uart_match_port() question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200512071515.11937.bjorn.helgaas@hp.com>
References: <1133050906.7768.66.camel@gaston>
	 <200512071515.11937.bjorn.helgaas@hp.com>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 10:13:45 +1100
Message-Id: <1133997226.7168.93.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ia64 has basically the same situation.  I decided it was a mistake to
> have the arch code register serial ports early, because we only learn
> about a few of the ports early, and the firmware console configuration
> determines which ones we learn about.
> 
> The consequence is that changing the firmware configuration changes the
> serial device names, which I thought was a bad thing.
> 
> I finally settled on this scheme:
> 	- discover default firmware port (pcdp.c)
> 	- set it up as an "early uart" which has no ttyS name
> 	  and runs in polled mode (early_serial_console_init())
> 	- register it as a console
> 	- let 8250_{pci,pnp,etc} discover all the ports and
> 	  figure out minor numbers (i.e., ttyS names)
> 	- locate the port that matches the default firmware port,
> 	  switch console to it, and unregister the "early uart"
> 	  (early_uart_console_switch())

Yup, I've been thinking about a similar approach yah. My main issue is
your last step: "locate the port that matches the default firmware
port". Right now, thins works because the early registration allow me to
know in advance what the ttyS number will be. If I go your way,  which I
'm tempted to do, I need to figure out precisely how to properly match
the ports. Part of the problem here is for example PIO. There is no such
thing as PIO on a PowerPC, it's purely a PCI abstraction, thus inX/outX
will only work once the PCI host briges have been discovered and their
IO space mapped (setup_arch() time, but I definitely want my early
console earlier). Thus, for early ports, we use the open firmware tree
to translate all (including PIO) addresses to MMIO in CPU space.

Thus, later on, when the serial driver kicks in, it can't match the PCI
IO resources it's getting from the PCI code to the MMIO physical
addresses or ioremaped addresses that were used at early boot time.

That sort of thing ...

Anyway, things work now with the fix for properly matching MMIO ports
with their physical address and my current mecanism, even if it's not
the nicest solution. I'll still look into reworking it a better way but
I don't have the time right now.


