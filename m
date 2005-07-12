Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVGLVmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVGLVmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVGLVj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:39:28 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:17357 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S262486AbVGLVhz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:37:55 -0400
Date: Tue, 12 Jul 2005 17:37:53 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
In-Reply-To: <200507122240.53390@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507121730590.4764-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Michel Bouissou wrote:

> I've tested as you suggest :
> 
> - Disabled USB 2.0 in BIOS
> 
> - Renamed ehci_hcd.ko so that modprobe can't find it
> 
> - Booted the test-patched kernel with same options as previously, MOUSE 
> UNPLUGGED.
> 
> - After boot "cat /proc/interrupts" shows "0" count for IRQ 21
> 
> - Nothing special isn't logged anymore in dmesg or /var/log/messages.
> 
> - Plugging / unplugging the mouse or other devices doesn't cause anything 
> visible to happen. Nothing gets logged, IRQ 21 counter stays at 0. I could as 
> well not have done it ;-)
> 
> > Without ehci_hcd loaded, the EHCI controller should not generate any
> > interrupt requests.  If your problem then goes away, and plugging or
> > unplugging the mouse doesn't cause anything unusual to happen, that will
> > be a pretty clear indication.
> 
> Well, so that's a pretty clear indication, but surely clearer to you than to 
> me ;-)
> 
> So, what's up, doc ? ;-))

Then it's definite.  The EHCI controller is issuing interrupt requests on
IRQ 21, but its driver is registered on a different IRQ.  Hence the
interrupts aren't getting handled correctly.

So probably the usb_handoff parameter won't be needed.  And if you leave 
USB 2.0 disabled in the BIOS then there's no need to hide ehci_hcd.ko, as 
it won't get loaded anyway.  You should be able to remove the test patch 
and resume normal operations.


On Tue, 12 Jul 2005, Protasevich, Natalie wrote:

> I suspect that some device is actually on the IRQ 21, and that's how its 
> IO-APIC line is set up. Later on, its driver tries to assign different
> IRQ, due to some discrepancy, and the handler gets registered on say IRQ
> 11, and to a wrong pin, so the actual interrupts go unattended. If this
> what's happening, the trace will hopefully tell the story. I suggest to
> boot with "apic=debug" and also perhaps with "pci=routeirq" and collect
> the trace. You can attach the part up to the point when it reports usb
> devices set up.

At this point I can leave it up to the two of you.  Now that we know which
is the offending device, it should be easy to find out why the IRQ
assignments go wrong.  That certainly needs to be fixed, even though
Michel's problem appears to be solved.

Alan Stern

