Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130218AbRAORsB>; Mon, 15 Jan 2001 12:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130304AbRAORrv>; Mon, 15 Jan 2001 12:47:51 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:16644 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130218AbRAORrf>;
	Mon, 15 Jan 2001 12:47:35 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
Date: Mon, 15 Jan 2001 18:45:06 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, har
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-mailer: Pegasus Mail v3.40
Message-ID: <12A9B4484604@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan 01 at 14:36, Roeland Th. Jansen wrote:
> On Fri, Jan 12, 2001 at 12:04:21PM -0800, Linus Torvalds wrote:
> > Ok, so it's tentatively the IOAPIC disable/enable code.  But it could
> > obviously be something that just interacts with it, including just a
> > timing issue (ie the _real_ bug might just be bad behaviour when
> > changing IO-APIC state at the same time as an interrupt happens, and
> > disable/enable-irq just happen to be the only things that do it at a
> > high enough frequency that you can see the problem). 
> 
> my BP6 with the patch frank sent me and the apic code at line 273 (or
> so) defined as '1' and a flood ping :
> 
> Jan 14 19:56:19 grobbebol kernel: APIC error on CPU1: 02(02)
> Jan 14 19:56:25 grobbebol kernel: APIC error on CPU1: 02(02)
> Jan 14 19:58:10 grobbebol last message repeated 2 times
> Jan 14 20:00:01 grobbebol kernel: APIC error on CPU1: 02(02)
> Jan 14 20:01:11 grobbebol last message repeated 2 times
> Jan 14 20:01:48 grobbebol kernel: APIC error on CPU1: 02(02)
> Jan 14 20:01:59 grobbebol kernel: APIC error on CPU1: 02(08)
> Jan 14 20:02:10 grobbebol kernel: APIC error on CPU1: 08(08)
> Jan 14 20:02:39 grobbebol kernel: APIC error on CPU1: 08(02)
> Jan 14 20:02:39 grobbebol kernel: unexpected IRQ trap at vector 8d
> Jan 14 20:15:32 grobbebol kernel: APIC error on CPU1: 02(08)
> [....]
> ad the network is dead. however, no crashes seen during this.

It is expected. inter-APIC message got finally so damaged that
checksum was OK, but IRQ trap vector got mangled from 99 -> 8d
(I bet that it was 99->8d, as both have same checksum, and 99 could
be used...). So local APIC confirmed reception of 8d interrupt, 
but 8d interrupt was never requested by IOAPIC :-( So 8d confirmation
is droped into wastebasket, but 99 IRQ is still marked as serviced
in IOAPIC, but never seen/EOIed by CPU.

For such motherboard you have two choices: (1) do not use IOAPIC at all 
(when LINT#0/#1 are used in 8259 mode, they are not so sensitive to
electrical noise) or (2) apply another (frank's?) patch which resets IRQ 
line every few seconds. Maybe hooking this reinitialization into NE2K 
timeout hook... Or into userspace daemon when received packets does not 
climb up for couple of seconds... 

I think that on BP6 hardware there is no way around except using 'noapic', 
or passing board through Abit replacement program. There is only two bit 
checksum which guards 8 or 22 data bits. I have no idea how frequent two 
bits errors are, but, as your example shows, they definitely happen on 
your hardware.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
