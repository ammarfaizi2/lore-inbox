Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVH1C5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVH1C5v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 22:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVH1C5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 22:57:51 -0400
Received: from mx1.rowland.org ([192.131.102.7]:58384 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750902AbVH1C5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 22:57:50 -0400
Date: Sat, 27 Aug 2005 22:57:45 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Dominik Wezel <dio@qwasartech.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: USB EHCI Problem with Low Speed Devices
 on kernel 2.6.11+
In-Reply-To: <20050827102135.4e0b035d.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.44L0.0508272256010.24489-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2005, Pete Zaitcev wrote:

> On Sat, 27 Aug 2005 15:43:11 +0200, Dominik Wezel <dio@qwasartech.com> wrote:
> 
> Forwarding to linux-usb-devel with comments.
> 
> > Kernel
> > ======
> > - 2.6.8, 2.6.11.10 and 2.6.12.4, all show same problem
> 
> > Problem
> > =======
> > When turning on the laptop and during POST and GrUB loading, all ports 
> > on the hub are enabled.  During the USB initialization phase, when the 
> > hub is detected, shortly all ports become disabled, then turn on again 
> > (uhci_hcd detects the lo-speed ports).  Upon initialization of ehci_hcd 
> > however, the ports are disconnected again (for good):
> > 
> > ---8<----
> > Aug 27 14:29:50 solaris kernel: ehci_hcd 0000:00:1d.7: USB 2.0 
> > initialized, EHCI 1.00, driver 10 Dec 2004
> > Aug 27 14:29:50 solaris kernel: hub 4-0:1.0: USB hub found
> > Aug 27 14:29:50 solaris kernel: hub 4-0:1.0: 6 ports detected
> > Aug 27 14:29:50 solaris kernel: usb 2-1: USB disconnect, address 2
> > Aug 27 14:29:50 solaris kernel: usb 2-1.5: USB disconnect, address 3
> > Aug 27 14:29:50 solaris kernel: usb 2-1.6: USB disconnect, address 4
> > ---8<----
> > 
> > Addresses 2, 3 and 4 are a keyboard, mouse and palm sync cable respectively.
> > 
> > and afterwards the log becomes cluttered with:
> > 
> > ---8<----
> > Aug 27 14:30:31 solaris kernel: usb 4-3: new high speed USB device using 
> > ehci_hcd and address 79
> > Aug 27 14:30:31 solaris kernel: usb 4-3: device not accepting address 
> > 79, error -71
> > Aug 27 14:30:32 solaris kernel: usb 4-3: new high speed USB device using 
> > ehci_hcd and address 81
> > Aug 27 14:30:32 solaris kernel: usb 4-3: device not accepting address 
> > 81, error -71
> > Aug 27 14:30:33 solaris kernel: usb 4-3: new high speed USB device using 
> > ehci_hcd and address 86
> > Aug 27 14:30:34 solaris kernel: usb 4-3: device not accepting address 
> > 86, error -71
> > Aug 27 14:30:34 solaris kernel: usb 4-3: new high speed USB device using 
> > ehci_hcd and address 89
> > Aug 27 14:30:35 solaris kernel: usb 4-3: device not accepting address 
> > 89, error -71
> > Aug 27 14:30:35 solaris kernel: usb 4-3: new high speed USB device using 
> > ehci_hcd and address 90
> > Aug 27 14:30:35 solaris kernel: usb 4-3: device not accepting address 
> > 90, error -71
> > ---8<----
> > 
> > first address to be assigned was 30 in all logs, but the number raises 
> > mostly in increments of 2 till about 120, then restarts with 12.
> > 
> > Interestlingly, the keyboard and mouse have been detected immediately 
> > before the intialization of ehcihcd:
> > 
> > ---8<---
> > Aug 27 14:29:50 solaris kernel: uhci_hcd 0000:00:1d.2: Intel Corp. 
> > 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
> > Aug 27 14:29:50 solaris kernel: PCI: Setting latency timer of device 
> > 0000:00:1d.2 to 64
> > Aug 27 14:29:50 solaris kernel: uhci_hcd 0000:00:1d.2: irq 11, io base 
> > 0x1840
> > Aug 27 14:29:50 solaris kernel: uhci_hcd 0000:00:1d.2: new USB bus 
> > registered, assigned bus number 3
> > Aug 27 14:29:50 solaris kernel: hub 3-0:1.0: USB hub found
> > Aug 27 14:29:50 solaris kernel: hub 3-0:1.0: 2 ports detected
> > /* These are the 2 ports on the laptop */
> > Aug 27 14:29:50 solaris kernel: usb 2-1: new full speed USB device using 
> > uhci_hcd and address 2
> > Aug 27 14:29:50 solaris kernel: hub 2-1:1.0: USB hub found
> > Aug 27 14:29:50 solaris kernel: hub 2-1:1.0: 7 ports detected
> > /* These are the 7 ports of the external hub */
> > Aug 27 14:29:50 solaris kernel: usb 2-1.5: new low speed USB device 
> > using uhci_hcd and address 3
> > Aug 27 14:29:50 solaris kernel: usb 2-1.6: new low speed USB device 
> > using uhci_hcd and address 4
> > Aug 27 14:29:50 solaris kernel: usbcore: registered new driver hiddev
> > Aug 27 14:29:50 solaris kernel: input: USB HID v1.10 Mouse [Logitech 
> > Trackball] on usb-0000:00:1d.1-1.5
> > Aug 27 14:29:50 solaris kernel: input: USB HID v1.10 Keyboard [CHICONY 
> > USB Keyboard] on usb-0000:00:1d.1-1.6
> > Aug 27 14:29:50 solaris kernel: input,hiddev96: USB HID v1.10 Device 
> > [CHICONY USB Keyboard] on usb-0000:00:1d.1-1.6
> > Aug 27 14:29:50 solaris kernel: usbcore: registered new driver usbhid
> > Aug 27 14:29:50 solaris kernel: drivers/usb/input/hid-core.c: v2.0:USB 
> > HID core driver
> > ---8<---
> > 
> > which means the ehci_hcd has afterwards superseded uhci_hcd.
> > 
> > Even more interestingly: in about 5% of the boot cases, ehci_hcd manages 
> > to detect the ports correctly (or at least doesn't interfere with uhci). 
> 
> Curious.
> 
> > Measures taken
> > ==============
> > I've found an article suggesting to
> >          echo Y > /sys/module/usbcore/parameters/old_scheme_first
> 
> Very funny.
> 
> > ---
> > I've also found articles suggesting to throw away the hub and get 
> > another one, which of course I can't take plain seriously, because now I 
> > know the problem of this hub, and I'm not going to change it for a hub 
> > whose problem I even don't know yet... =;)
> 
> Borrow one for testing.
> 
> Also, plug Palm directly into computer. Surely it has more than one
> USB connector.
> 
> > Measures not taken
> > ==================
> > I didn't test the hub on Microsoft Windows, because I assume that 
> > wouldn't add to the solution space, since the problem is clearly located 
> > in the uhci_hcd vs. ehci_hcd domain of the linux kernel, as the hub is 
> > fully functional (within the lo speed scope) when used with only uhci.
> 
> Actually, I suspected that this may be a poorly working Transaction
> Tranlating (TT) hub. Which then may work on certain versions of
> Windows.
> 
> -- Pete

It looks to me more like a timing problem with initialization of the
external high-speed hub.  Try this patch:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=112439094723976&w=2

Alan Stern

