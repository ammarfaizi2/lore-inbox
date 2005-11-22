Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVKVCpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVKVCpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 21:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVKVCpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 21:45:24 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:13494 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751270AbVKVCpW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 21:45:22 -0500
Date: Mon, 21 Nov 2005 19:45:10 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
Message-ID: <20051122024510.GI1598@parisc-linux.org>
References: <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org> <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org> <20051121190632.GG1598@parisc-linux.org> <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org> <20051121194348.GH1598@parisc-linux.org> <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org> <20051121211544.GA4924@elte.hu> <17282.15177.804471.298409@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0511211339450.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511211339450.13959@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 01:49:45PM -0800, Linus Torvalds wrote:
> On all PC hardware, having a zero in the PCI irq register basically means 
> that no irq is enabled. That's a _fact_. It's a fact however much you may 
> not like it. It's how the hardware comes up, and it's how the BIOS leaves 
> it. So "0" absolutely does mean "not allocated". 

Actually, no.  Here's my x86 laptop's config space ...

0000:02:06.2 System peripheral: Texas Instruments PCI1620 Firmware Loading Function (rev 01)
        Subsystem: Hewlett-Packard Company: Unknown device 08b0
        Flags: bus master, medium devsel, latency 64
        I/O ports at 4000 [size=64]
        Capabilities: [44] Power Management version 2
00: 4c 10 01 82 07 01 10 02 01 00 80 08 08 40 00 00
10: 01 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 3c 10 b0 08
30: 00 00 00 00 44 00 00 00 00 00 00 00 ff 00 07 04

Interrupt Pin is 0x3d and Interrupt Line is 0x3c.  As I explained earlier,
Linux simply never reads Interrupt Line if Interrupt Pin is 0.


Anyway, this doesn't matter too much.  I don't personally care about
NO_IRQ being 0 or -1; that was something benh tried to make me care
about ;-)

So, how about this for a new patch series:

 - Patch 1, same as this series (it just makes sense to bounds-check in
   the irq management functions).
 - Patch 2, add #ifndef NO_IRQ #define NO_IRQ 0 #endif to linux/hardirq.h
 - Patch 3, set dev->irq to NO_IRQ in drivers/pci/probe.c
 - Patch 4, remove custom definition of NO_IRQ from pd6729
 - Patch 5, use NO_IRQ in serial_core

I'll start work on that now, since that fixes the problems I care about
and doesn't negatively affect people with problems I don't care about ;-)
