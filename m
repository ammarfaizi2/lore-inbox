Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVGQUgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVGQUgp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 16:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVGQUgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 16:36:45 -0400
Received: from mx1.rowland.org ([192.131.102.7]:56324 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S261388AbVGQUgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 16:36:42 -0400
Date: Sun, 17 Jul 2005 16:36:39 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: bjorn.helgaas@hp.com,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <liste@jordet.nu>, <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
In-Reply-To: <200507171958.49770@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507171606320.30920-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2005, Michel Bouissou wrote:

> Hi there,
> 
> Natalie Protasevich and Alan Stern have worked a lot on helping me out with a 
> VIA KT400 chipset / kernel 2.6.12 / IO-APIC / IRQ problem "irq 21: nobody 
> cared!", which so far hasn't found its solution.
> 
> Research done with Alan shows that, on my system, the USB 2.0 controller seems 
> to generate interrupts on the IRQ line attributed to the USB 1.1 controller, 
> which isn't supposed to happen, and puzzles the system, when IO-APIC is 
> enabled.
> 
> However, this didn't cause problems with 2.4 series kernels.
> 
> For the time being, there is no solution (Natalie is still investigating 
> this), and it boils down to the following:
> 
> - If I boot with USB 2.0 enabled in BIOS, AND IO-APIC enabled in the kernel, 
> then it badly breaks.
> 
> - If I either disable USB 2.0 in BIOS, or IO-APIC in the kernel, then it's OK.
> 
> I found today the thread between Bjorn Helgaas and Mathieu Bérard on LKML, 
> where Mathieu reported the same problem, and Bjorn advised him to reverse a 
> kernel patch (http://lkml.org/lkml/2005/6/21/243 ).
> 
> Mathieu (I don't have his email address, Bjorn, could you be so kind to 
> forward this message to him) reports that it apparently solved this problem, 
> so I tried to do the same, and reversed the same patch.
> 
> At first boot it seems to solve the issue, but when I rebooted again, it broke 
> again, so this is not the solution -- the problem is not completely stable, 
> sometimes it doesn't happen for some reason unknown to me... But most of the 
> times it _does_ happen :-/
> 
> So this message is to inform different people who have suffered from this same 
> problem, or are working for finding it a fix...
> 
> I'll be on travel for the coming week, and may or may not have occasional 
> access to my email. (Please copy me on answers, as I'm not subscribed to the 
> linux-kernel ML).

Determining whether or not the system is working shouldn't be hit-or-miss.

To start out, try to determine whether each of the UHCI controllers really 
is mapped to IRQ 21.  Do this by booting with no USB devices plugged in, 
and then plugging a full- or low-speed device (like a USB mouse) into each 
of the ports in turn.  Check to make sure it works in each port and that 
that counts for IRQ 21 in /proc/interrupts increase each time.  To make 
this even more reliable you should run the test twice -- you don't have to 
reboot in between.  The first time, rmmod ehci-hcd before plugging in 
anything; the second time modprobe ehci-hcd before plugging.

The results you have reported make me a little suspicious.  The best way
to see whether the EHCI controller really is at fault is to plug in a
high-speed USB device.  I'm not totally familiar with the operation of
ehci-hcd, and it's quite possible that plugging in a low- or full-speed
device would not cause it to generate enough interrupts to be a problem --
even though you did trigger the fault by plugging in a low-speed mouse --
but plugging in a high-speed device ought to, provided ehci-hcd is loaded.  
Again, monitor the numbers in /proc/interrupts to see which is going up:  
IRQ 19 or IRQ 21.

The instability you mention is another cause for concern.  It may indicate 
that at some times, or under certain circumstances, the IRQs are routed 
wrongly whereas at others they are routed correctly.  And without any 
changes to the software!  If this is a random hardware fault it may be 
impossible to fix.  (But then why would it be so reliable under 2.4?)

Do you have a high-speed USB device?  Has it ever worked at high speed 
under 2.6?

Alan Stern

