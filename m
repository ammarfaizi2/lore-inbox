Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWDCCJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWDCCJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 22:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWDCCJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 22:09:28 -0400
Received: from mx1.rowland.org ([192.131.102.7]:41224 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S964810AbWDCCJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 22:09:28 -0400
Date: Sun, 2 Apr 2006 22:09:24 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Joshua Kwan <joshk@triplehelix.org>
cc: linux-kernel@vger.kernel.org, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Problems with USB setup with Linux 2.6.16
In-Reply-To: <20060403004806.GA25553@triplehelix.org>
Message-ID: <Pine.LNX.4.44L0.0604022155060.29134-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Apr 2006, Joshua Kwan wrote:

> Hello,
> 
> I've got some problems getting my USB stuff to work in 2.6.16.
> 
> I see normal USB initialization as the machine comes up, then suddenly:
> 
> ehci_hcd 0000:00:10.4: EHCI Host Controller
> ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
> ehci_hcd 0000:00:10.4: irq 17, io mem 0xf9e00000
> ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb usb5: configuration #1 chosen from 1 choice
> hub 5-0:1.0: USB hub found
> usb 2-1: USB disconnect, address 2
> hub 5-0:1.0: 8 ports detected
> usb 2-2: USB disconnect, address 3
> usb 3-1: USB disconnect, address 2
> Initializing USB Mass Storage driver...
> GSI 21 sharing vector 0xD1 and IRQ 21
> usb 1-1: USB disconnect, address 2
> drivers/usb/class/usblp.c: usblp0: removed
> 
> Everything that just got probed gets 'disconnected', udev's startup
> script times out, and cupsd will hang forever looking for my printer.
> 
> Interestingly, it worked perfectly one time, and I saw a 'EHCI BIOS handoff
> failed' message way at the top of dmesg.
> 
> What's going on? I assume this is EHCI's fault. I'm on a VIA K8T800 chipset,
> Asus A8V Deluxe motherboard.

If you want to point a finger, I suppose you could say it's EHCI's fault.  
However, this is how things are _supposed_ to work (all except for the 
"cupsd will hang forever part" -- it's not clear whether that's a kernel 
issue or an application program issue).

The idea is that each USB connector on your motherboard is wired to two
USB controller ports: one on a UHCI controller (for low- and full-speed
devices) and one on the EHCI controller (for high-speed devices).  The
connections are controlled by switches inside the EHCI controller.

Initially the switches are set to hook each connector up to a UHCI
controller, so your devices enumerate on the various UHCI buses.  Then
when ehci-hcd gets loaded it takes over, and the switches are changed to
hook each device up to the EHCI controller.  As far as the UHCI
controllers are concerned this looks like the devices were unplugged.  
Hence all those "disconnect" messages.

If you were to continue looking farther down in the log, you would find
that ehci-hcd sees all those devices.  Those that can run at high speed
continue using the EHCI controller.  For those that can't, the switch is 
reset and they get reconnected to their UHCI controller.

All this backing and forthing would be eliminated if the ehci-hcd driver
was loaded before uhci-hcd rather than after.  Perhaps you can fiddle with
your startup scripts to make that happen.  But even if things always go
the way you showed here, the devices should all work properly in the end.

Alan Stern

