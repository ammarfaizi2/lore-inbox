Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbVLGWPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbVLGWPY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbVLGWPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:15:24 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:36035 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1030384AbVLGWPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:15:22 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: uart_match_port() question
Date: Wed, 7 Dec 2005 15:15:11 -0700
User-Agent: KMail/1.8.2
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1133050906.7768.66.camel@gaston>
In-Reply-To: <1133050906.7768.66.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071515.11937.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 November 2005 5:21 pm, Benjamin Herrenschmidt wrote:
> The reason is a bit complicated, but basically, we have some arch code
> that builds a list of available serial ports very early and registers that
> as a platform device. It also detects which one is the default firmware port
> and what speed it's been configured for and builds a proper config line to
> pass to add_preferred_console() so we get the default serial console setup
> properly automatically.
> 
> This list includes however ports that are on PCI devices on some recent
> machines. Thus, we need to make sure that, when 8250_pci.c kicks in, it
> property detects that those platform ports are the same it's discovered
> and thus properly re-uses the same port & minor.

[Sorry for the late response, I haven't been keeping up on lkml lately.]

ia64 has basically the same situation.  I decided it was a mistake to
have the arch code register serial ports early, because we only learn
about a few of the ports early, and the firmware console configuration
determines which ones we learn about.

The consequence is that changing the firmware configuration changes the
serial device names, which I thought was a bad thing.

I finally settled on this scheme:
	- discover default firmware port (pcdp.c)
	- set it up as an "early uart" which has no ttyS name
	  and runs in polled mode (early_serial_console_init())
	- register it as a console
	- let 8250_{pci,pnp,etc} discover all the ports and
	  figure out minor numbers (i.e., ttyS names)
	- locate the port that matches the default firmware port,
	  switch console to it, and unregister the "early uart"
	  (early_uart_console_switch())

This all should work for any arch, though I've only really tried it on
ia64.  Of course, the pcdp.c part would have to be replaced.  You can
try it out without the firmware support using the "console=uart"
argument:

        console=        [KNL] Output console device and options.
        ...
                uart,io,<addr>[,options]
                uart,mmio,<addr>[,options]
                        Start an early, polled-mode console on the 8250/16550
                        UART at the specified I/O port or MMIO address,
                        switching to the matching ttyS device later.  The
                        options are the same as for ttyS, above.
