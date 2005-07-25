Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVGYTWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVGYTWz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGYTUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:20:04 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51130 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261464AbVGYTSc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:18:32 -0400
Date: Mon, 25 Jul 2005 15:18:29 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: bjorn.helgaas@hp.com,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
In-Reply-To: <200507252006.17330@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507251500270.8043-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2005, Michel Bouissou wrote:

> 1/ rmmod ehci-hcd
> 
> 2/ Plugged the mouse in each and every USB connector I have, in turn. The 
> mouse was working good on each of them. IRQ 21 showed nicely incrementing 
> each time I plugged / unplugged or moved the plugged mouse. System was happy 
> and didn't log anything abnormal.

So it's definite that all three UHCI controllers use IRQ 21.

> 3/ Unplugged the mouse
> 
> 4/ modprobe ehci-hcd
> 
> 5/ Plugged the mouse. Immediately got "IRQ21: Nobody cared" and "Disabling IRQ 
> 21" messages.

I'm not aware under what circumstances the EHCI controller generates 
interrupt requests upon plugging in a new device, but apparently it did so 
for you.  Maybe because there were no other devices plugged in and the 
controller was suspended.

Clearly the EHCI controller also uses IRQ 21, even though the system 
thinks it is mapped to a different IRQ.

> => Noticed IRQ21 count has suddenly been set to exactly 200000

This is an artifact of the way the system detects and reports unhandled 
IRQs.

> After this, the mouse was now behaving slowly and erratically (USB polled 
> without interrupts ?)

Probably.

> 6/ Unplugged the mouse, then:
> - rmmod ehci-hcd
> - rmmod uhci-hcd
> - modprobe ehci-hcd

Do you really mean "modprobe ehci-hcd" here?  So the EHCI driver was
loaded and not the UHCI driver?  Or was that a typo?

> 7/ Plugged the mouse back. It was working happily again.

With no UHCI driver?

> 8/ Keeping the mouse plugged:
> - modprobe ehci-hcd

But you had just previously loaded ehci-hcd.  Unless the earlier line was 
a typo.

> => Immediately got the IRQ21 insults again.
> => Noticed IRQ21 count has suddenly been set to exactly 400000
> Mouse behaviour was slow and erratical again.
> 
> Repeated steps 6-8 using another USB socket, with the exact same results.
> 
> What do you think about this ?

It seems quite clear that the EHCI controller's IRQ line is causing the
problems.  Just out of curiousity, what happens if you really do remove
the UHCI driver, keeping only the EHCI driver, and then plug in the mouse?  
Off hand I would expect nothing much to happen -- maybe a line or two in
the system log, no change to the IRQ counters, and the mouse doesn't work
(not even erratically).

Alan Stern

