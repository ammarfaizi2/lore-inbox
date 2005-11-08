Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbVKHWRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbVKHWRF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbVKHWRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:17:05 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:24070 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S1030328AbVKHWRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:17:03 -0500
From: James Cloos <cloos@jhcloos.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org
Subject: pcmcia card takes down system
Copyright: Copyright 2005 James Cloos
X-Hashcash: 1:23:051108:linux-kernel@vger.kernel.org::tsrOVn6oq+AMp1WA:0000000000000000000000000000000009GSn
X-Hashcash: 1:23:051108:linux-pcmcia@lists.infradead.org::QQX2QKxiYNH79kVQ:00000000000000000000000000001aba/
Date: Tue, 08 Nov 2005 16:25:50 -0500
Message-ID: <m3slu625nl.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I decided to give my old orinco gold card a test under the new pcmcia
framework.  Box is an inspiron 8100 currently running 2.6.14-g9f75e1ef
from Linus' git tree, w/ no other mods.

As some may remember, the i8100 has a poor design, routing all of usb,
1394, pccard and mini-pci interupts to irq10.  Other than the stuff on
the north and south bridges, only the audio and video cards get their
own interupts....  (That said the old pcmcia drivers were able to use
spare interupts for pcmcia cards; the new drivers seem to use irq10
for pcmcia just liek thye do for cardbus.)

When I inserted the card the box froze.  So I removed it.

That gave me this:

,----
| [5060571.782000] irq 10: nobody cared (try booting with the "irqpoll" option)
| [5060571.782000]  [<c0103447>] dump_stack+0x17/0x20
| [5060571.782000]  [<c013cdc7>] __report_bad_irq+0x27/0x90
| [5060571.782000]  [<c013ced2>] note_interrupt+0x82/0xe0
| [5060571.782000]  [<c013c911>] __do_IRQ+0xa1/0xb0
| [5060571.782000]  [<c0104547>] do_IRQ+0x37/0x70
| [5060571.782000]  [<c01030b6>] common_interrupt+0x1a/0x20
| [5060571.782000]  [<c0120b0b>] do_softirq+0x2b/0x30
| [5060571.782000]  [<c0120bc5>] irq_exit+0x35/0x40
| [5060571.782000]  [<c010454c>] do_IRQ+0x3c/0x70
| [5060571.782000]  [<c01030b6>] common_interrupt+0x1a/0x20
| [5060571.782000]  [<c0101113>] cpu_idle+0x63/0x70
| [5060571.782000]  [<c010023e>] _stext+0x1e/0x20
| [5060571.782000]  [<c05ce831>] start_kernel+0x171/0x1b0
| [5060571.782000]  [<c0100199>] 0xc0100199
| [5060571.782000] handlers:
| [5060571.782000] [<c0371670>] (ohci_irq_handler+0x0/0x760)
| [5060571.782000] [<c0383360>] (yenta_interrupt+0x0/0xf0)
| [5060571.782000] [<c0383360>] (yenta_interrupt+0x0/0xf0)
| [5060571.782000] [<c0250bf0>] (usb_hcd_irq+0x0/0x60)
| [5060571.782000] [<c032b320>] (e100_intr+0x0/0x130)
| [5060571.782000] Disabling IRQ #10
`----

Note the last line.  

That took out eth0, usb and 1394.  And I had a sbp2 drive mounted,
plus active ipv4 sockets.

I couldn't come up with anything better than rebooting to regain
the irq and the devices behind it.  (And this mail should go out
as soon as it is back up. :)

First of all, is there a way to re-enable the irq?

Second, should the kernel disable a shared irq just because one of the
drivers that is supposed to handle some of those interupts fails?

It seems like it shouldn't, given the problems that causes for other
devices on that irq.  At least when there isn't a continuous storm
of ignored interupts.

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>




