Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVAKDVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVAKDVQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVAKDUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 22:20:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:26250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262557AbVAKDRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 22:17:54 -0500
Date: Mon, 10 Jan 2005 19:17:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: DHollenbeck <dick@softplc.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: yenta_socket rapid fires interrupts
In-Reply-To: <41E2BC77.2090509@softplc.com>
Message-ID: <Pine.LNX.4.58.0501101857330.2373@ppc970.osdl.org>
References: <41E2BC77.2090509@softplc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Jan 2005, DHollenbeck wrote:
> 
> However, when I have a "CARDBUS to USB 2.0 Hi-Speed Adapter" installed 
> at the time of modprobe yenta_socket, I get a problem, shown below. 

Can you compile the kernel with kallsyms info? That would make the output 
a whole lot more readable.

> The same problem occurs if the Adapter is inserted after the yenta
> module is loaded.  That is, load the yenta_socket module: no problem,
> then physically insert the Adapter: same problem.

Can you test with another type of card, just to see if it is specific to 
that particular driver, or it happens with any card insertion event?

> This same Adapter card works fine in a different pentium shoebox 
> computer using the same kernel and root file system as the "problem 
> embedded pentium" system, but with a different CARDBUS chipset.

It's entirely possible that they have different behaviours for screaming 
interrupts and/or just different setup.

> irq 11: nobody cared (try booting with the "irqpoll" option.
>  [<c0127362>]
> ....
> handlers:
> [<c2837930>]
> [<c2837930>]

I can't tell what your handlers are, but there are two of them, and they 
are the same, which makes me strongly suspect that it's just the two 
"yenta_socket" handlers for the two slots (sharing the same interrupt).

Which implies that when the card was inserted and powered on, it started 
enabling the interrupt early, before the low-level driver had had a chance 
to register _its_ interrupt handler.

> 01:00.0 Class 0c03: 10b9:5237 (rev 03) (prog-if 10)
>         Subsystem: 10b9:5237
>         Flags: 66Mhz, medium devsel, IRQ 11
>         Memory at 10400000 (32-bit, non-prefetchable) [disabled] [size=4K]
>         Capabilities: [60] Power Management version 2
> 
> 01:00.3 Class 0c03: 10b9:5239 (rev 01) (prog-if 20)
>         Subsystem: 10b9:5272
>         Flags: 66Mhz, medium devsel, IRQ 11
>         Memory at 10401000 (32-bit, non-prefetchable) [disabled] [size=256]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [58] #0a [2090]

Hmm. That would be "PCI_CLASS_SERIAL_USB", but clearly:

> root@EMBEDDED[~]# cat /proc/interrupts
>            CPU0
>  11:      98681          XT-PIC  yenta, yenta

No USB driver there, so the driver never even loaded. The problem probably 
happened immediately on card insertion, and is likely card-indepdendent. 
But it would be nice to have that confirmed by testing.

It seems to be a TI 1520 chipset:

	00:0d.0 Class 0607: 104c:ac55 (rev 01)

	Yenta: CardBus bridge found at 0000:00:0d.0 [0000:0000]
	Yenta: Enabling burst memory read transactions
	Yenta: Using CSCINT to route CSC interrupts to PCI
	Yenta: Routing CardBus interrupts to PCI
	Yenta TI: socket 0000:00:0d.0, mfunc 0x00001022, devctl 0x64
	Yenta: ISA IRQ mask 0x00a8, PCI irq 11
	Socket status: 30000020

and everything looks good in that the interrupt probing seems to have been 
happy at this stage - so at least the CSC interrupt is working right.

There used to be somebody who knew the TI chips on the list - I've only 
worked with the older ones. But everything _looks_ fine.

		Linus
