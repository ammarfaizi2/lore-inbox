Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVAKTzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVAKTzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVAKTzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:55:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:29881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262042AbVAKTyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:54:10 -0500
Date: Tue, 11 Jan 2005 11:54:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: DHollenbeck <dick@softplc.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       magnus.damm@gmail.com
Subject: Re: yenta_socket rapid fires interrupts
In-Reply-To: <41E42691.3060102@softplc.com>
Message-ID: <Pine.LNX.4.58.0501111143370.2373@ppc970.osdl.org>
References: <41E2BC77.2090509@softplc.com> <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
 <41E42691.3060102@softplc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Jan 2005, DHollenbeck wrote:
> 
> then a dmesg extract, now with kallsyms:

Ok, that wasn't very interesting ;)

If anything, it does show that the interrupt doesn't happen at any "enable
device" point, which in turn would tend to indicate that it's not some
Linux device initialization that brings on the interrupts storm: it really
looks like it is the act of inserting this particular card that makes the
hardware start to act up.

Which means that I agree with you: it's something specific to the 
initialization of the TI CardBus bridge. Exactly what, I have no friggin 
clue. Some incorrect state initialization for interrupts for that 
particular board.

> handlers:
> [<c2842930>] (yenta_interrupt+0x0/0x40 [yenta_socket])
> [<c2842930>] (yenta_interrupt+0x0/0x40 [yenta_socket])
> Disabling IRQ #11
> PCI: Enabling device 0000:05:00.3 (0000 -> 0002)
> ehci_hcd 0000:05:00.3: ALi Corporation USB 2.0 Controller
> ehci_hcd 0000:05:00.3: irq 11, pci mem 0x10c01000
> ehci_hcd 0000:05:00.3: new USB bus registered, assigned bus number 1
> ehci_hcd 0000:05:00.3: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 2 ports detected

.. but clearly the card is _seen_. I assume that this is the USB 
controller card that you just inserted. Everything looks good, except for 
the fact that the damn interrupt storm started.

> >Can you test with another type of card, just to see if it is specific to 
> >that particular driver, or it happens with any card insertion event?
> 
> Yes, a PRISM54 PCMCIA (WL54G) card seems to work in the slot.  With it :

Uhhuh. Both look like proper CardBus cards, so this isn't even some 
"16-bit card works fine, 32-bit does not".

> The console dumps from my original posting were done without first 
> loading ehci_hcd.  Today you can see above ehci_hcd was loaded first, 
> but this does not fix the problem.

No, but it shows that the card is recognized, and the yenta subsystem 
works fine _except_ for the fact that it for some reason results in tons 
of interrupts.

Can you add a "printk()" to "yenta_events()" that shows the value of both 
"csc" and "cb_event", and additionally shows CB_STATUS. Something like 
the appended (and totally untested) patch..

It's going to be very noisy when the problem happens (you'll see 10000 
lines scroll by very quickly), but it would be good to see what the last 
lines were. Just to see if some event/state seems stuck..

		Linus

===== drivers/pcmcia/yenta_socket.c 1.65 vs edited =====
--- 1.65/drivers/pcmcia/yenta_socket.c	2004-12-01 00:14:04 -08:00
+++ edited/drivers/pcmcia/yenta_socket.c	2005-01-11 11:52:10 -08:00
@@ -401,7 +401,7 @@
 static unsigned int yenta_events(struct yenta_socket *socket)
 {
 	u8 csc;
-	u32 cb_event;
+	u32 cb_event, cb_state;
 	unsigned int events;
 
 	/* Clear interrupt status for the event */
@@ -409,6 +409,9 @@
 	cb_writel(socket, CB_SOCKET_EVENT, cb_event);
 
 	csc = exca_readb(socket, I365_CSC);
+
+	cb_state = cb_readl(socket, CB_SOCKET_STATE);
+	printk("yenta: event %08x state %08x csc %02x\n", cb_event, cb_state, csc);
 
 	events = (cb_event & (CB_CD1EVENT | CB_CD2EVENT)) ? SS_DETECT : 0 ;
 	events |= (csc & I365_CSC_DETECT) ? SS_DETECT : 0;
