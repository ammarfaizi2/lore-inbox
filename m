Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271023AbTGPR5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271016AbTGPRzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:55:38 -0400
Received: from 12-254-105-108.client.attbi.com ([12.254.105.108]:50700 "EHLO
	benatar.snurgle.org") by vger.kernel.org with ESMTP id S270993AbTGPRyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:54:04 -0400
Date: Wed, 16 Jul 2003 14:03:44 -0400 (EDT)
From: William T Wilson <fluffy@snurgle.org>
X-X-Sender: fluffy@benatar
To: linux-kernel@vger.kernel.org
Subject: PCI Configuration Problem
Message-ID: <Pine.LNX.4.44.0307161319520.18906-100000@benatar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a problem with one of my interface boards and it appears to be 
at the PCI level, so I am hoping someone can tell me what is going on and 
whether there is anything I can do to fix it.  I am using kernel 2.4.21 
but the problem occurs with 2.4.20 as well.

The board is a National Instruments PCI-6503 data acquisition board.  The
problem essentially is that the board works properly at first, but after
some period of time, it stops working.  The board communicates with the PC
using two 4KB shared memory regions and an IRQ, which is not used (by my
software).  One of the shared memory regions is used for configuration and
the other is used for the data acquisition itself.

When it stops working, its PCI configuration becomes disrupted so that the
shared memory regions are no longer accessible.  This also causes the
board's functions to reset.  Usually, it will stop working when I start
X, but sometimes it will stop working without that.  I haven't been able
to come up with exactly the conditions under which this will happen.

When the device fails, its appearance in lspci hanges, and I am hoping
someone can tell me the meaning of the output from lspci (especially the
[virtual] flag).  It looks to me like the card's PCI configuration space
is being trampled.  But I am no PCI expert.

I can restore the card's settings with setpci, by putting the address
values back into BASE_ADDRESS_0 and BASE_ADDRESS_1.  I have not been able
to restore the card to normal operation this way, though.  I find that
when I have done this, attempting to reload the driver module triggers the
problem again.  I might get this working with further fiddling around...

When all is well, the device shows up in lspci like this:

00:0b.0 Class ff00: National Instruments: Unknown device 17d0
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at ea400000 (32-bit, non-prefetchable) [size=4K]
        Memory at ea401000 (32-bit, non-prefetchable) [size=4K]

But after it has become confused, it shows up like this:

00:0b.0 Class ff00: National Instruments: Unknown device 17d0
        Flags: medium devsel, IRQ 10
        [virtual] Memory at ea400000 (32-bit, non-prefetchable) [disabled]
[size=4K]
        [virtual] Memory at ea401000 (32-bit, non-prefetchable) [disabled]
[size=4K]

Occasionally, right as the device stops working, I see the following 
output from lspci, which I do not understand at all (note the device 
class also is wrong):

00:0b.0 Class ffff: National Instruments: Unknown device 17d0 (rev ff) 
(prog-if ff)
        !!! Unknown header type 7f

My system configuration is:
Biostar M7VIP (VIA KT333 chipset) with AMD Duron 1.3 and 512MB of RAM
Radeon 9000 video card
NI PCI-6503 DAQ board (of course)

I tried increasing VMALLOC_RESERVE from 128 to 256 but as I somewhat
expected this did not help.  The problem doesn't seem to be that there is
a conflict between shared memory regions (I have verified this by looking
at the other PCI devices and can post my entire lspci -v output if
needed), but that the memory regions themselves become inaccessible.

I also have a network card, sound card, multi-serial interface, cardbus
interface... but the problem persists even with these cards removed.  I
still have the problem with everything taken out except the DAQ and video
boards.

Thanks in advance for any insight anyone might be able to offer!

