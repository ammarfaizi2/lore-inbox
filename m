Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbUELXNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUELXNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 19:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUELXNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 19:13:19 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:32703 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S263121AbUELXNQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 19:13:16 -0400
Date: Wed, 12 May 2004 19:13:14 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
Subject: Weird cold boot problems with Abit KT7 motherboard
Message-ID: <Pine.LNX.4.58.0405121815120.2967@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have noticed several anomalies with Abit KT7 motherboard.  They all
happen after power on.  First reboot from Linux (using the reboot command
or reset button) usually fixes all the problems.  Sometimes two or three
resets are needed before the motherboard starts working properly.  In two
cases (of about 20) the motherboard started working properly right after
powering up.

I tried removing some cards and disabling the on-board USB.  Since cold
boot is needed to reproduce the problems, there are many things I could
have tried but didn't because I don't want to ruin other hardware by
constant power cycling.

I just hope the description below will rings a bell with somebody, and
I'll gladly test the suggestions.  If not, the motherboard will go to the
dumpster.

Anomalous state will refer to the state after the cold boot.  Normal state
is what I have after sufficient number of resets.  Following effects are
observed:

1) Variable PCI ID of ATI Rage graphics card.

In the anomalous state, the PCI ID of the card is 1002:5247 (ATI
Technologies Inc Rage 128 RG).  In the normal state, it's 1002:5246 (ATI
Technologies Inc Rage 128 RF/SG AGP).  It's also 1002:5246 on another
machine, both after cold boot and reset.  No other bytes in the PCI
configuration space of the card are different.

Another AGP card, ELSA Gloria, doesn't exhibit this anomaly on the same
motherboard.  Its PCI configuration space is unchanged.

2) "Bad slots" for 3com 3c900.

In the anomalous state, the 3com 3c900 doesn't work in certain slots, but
does work in others.  The card can send the data, but doesn't receive
anything.  The interrupt count stops at 94 and doesn't increase afterwards
even if I ping in both directions to and from another machine.

3) Hang on reading PCI configuration space of TI PCI1410.

In the anomalous state, the system hangs if TI PCI1410 (CardBus bridge) is
present.  The hang happens on this line in drivers/pci/probe.c:

pci_read_config_word(dev, PCI_CB_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);

PCI_CB_SUBSYSTEM_VENDOR_ID is 0x40.  Reading the configuration space below
0x40 works fine.  If I comment out this and the next lines, I can boot the
system to the command line.  XFree86 hangs.  lspci also hangs.  I can read
individual files from /proc/bus/pci, but not /proc/bus/pci/00/0f.0, which
corresponds to the CardBus bridge.  Reading that file beyond byte 64
causes the system to hang.

4) Host bridge detects parity error.

In the anomalous state, the PERR (parity error) flag is not set for the
Host bridge 00:00.0.  It is set in the normal state.


I put some data here: http://www.red-bean.com/~proski/kt7/

Most interesting should be lspci-vvvxxx.diff, which is the difference
between "lspci -vvvxxx" outputs for anomalous and normal modes.
lspci-nvvvxxx.diff is the same for "lspci -nvvvxxx".  Kernel log in the
normal mode is in dmesg.  dmesg.bad shows hang while probing TI PCI1410 on
cold boot.  interrupts, iomem and ioports are from /proc/, taken in the
anomalous mode after TI PCI1410 was removed.

I'm using Linux 2.6.6, but I've seen variable PCI ID of ATI Rage for years
with many kernels.  I just never had a chance to look deeper.

I know that the KT7 motherboard is not designed to run Athlon XP 2000+
(which is underclocked to 1.25 GHz), but the same problems existed with
Athlon 1.2 GHz on the same motherboard.

The BIOS is the latest, 07/11/2002-8363-686A-6A6LMA19C-A9.

-- 
Regards,
Pavel Roskin
