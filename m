Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbTIHWwE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbTIHWwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:52:04 -0400
Received: from dsl82-heaton3.usc.edu ([128.125.82.32]:64855 "EHLO
	rider.ipom.net") by vger.kernel.org with ESMTP id S263768AbTIHWvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:51:54 -0400
Date: Mon, 8 Sep 2003 15:51:07 -0700
From: Phil Dibowitz <phil@ipom.com>
To: linux-kernel@vger.kernel.org
Cc: phil@ipom.com
Subject: Linux IDE bug in 2.4.21 and 2.4.22 ?
Message-ID: <20030908225107.GE17108@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

I think I may have found a bug in the Linux IDE subsystem
introduced in 2.4.21 and still present in 2.4.22.

SHORT SYNOPSIS: I played with various combinations of drivers, and no
matter what I do I can only get ONE of the IDE controllers in my machine
recognized at a time. I find this in both 2.4.21 and 2.4.22.
Howerver, 2.4.20 and prior were NOT affected.

Anyway, I have 4 IDE disks in my system, each of which is one its own 
chain, so I'm using both the onboard controller as well as a PCI IDE card.
Thus my system looks like this:

On-Board IDE
   IDE0 Primary: HD
        Secondary: -
   IDE1 Primary: DVD
        Secondary: -
PCI Card IDE
   IDE2 Primary: CDRW
        Secondary: -
   IDE3 Primary: ZIP
        Secondary: -

My On-Board is, according to lspci, a:
     VIA VT82C586/B/686A/B PIPC Bus Master IDE (rev 06)
     (prog-if 8a [Master SecP PriP])
My PCI card is, according to lspci, a:
     CMD Technology Inc PCI0649 (rev 02)

Up until (and including) 2.4.20, my kernel IDE configuration has always
looked like

CONFIG_BLK_DEV_IDEDISK=y      
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_IDEPCI=y           
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y             
CONFIG_PIIX_TUNING=y 
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

The noteworthy thing about the above is that I'm NOT enabling CMD64X -- the 
CMD640 has always handled the CMD649 PCI IDE controller just fine.

As of 2.4.21, this configuration no longer works -- which is not necessarily
a bug. I'm almost there, stay with me. =)

So the PCI IDE card isn't recognized with the above configuration. So I decided
to enable the CMD64X driver. This caused my PCI IDE card to be recognized BUT 
as a side effect, my onboard controller was *NOT* recognized!! At this point
I had built the CMD64X driver into the kernel.

So my next experiment was to build CMD64X as a module instead. At this point
the PCI IDE controller wasn't recognized on boot -- as expected. I then 
manually loaded the CMD64X driver and it .. "unrecognized" my onboard 
controller *reassigning* ide0 and ide1 to the chains on the PCI card and no
longer seeing the onboard controller (and thus unable to find the HD, and...)
That, I believe is a bug in ... possibly the driver, or possibly the IDE
subsystem, I'm not sure.


Some other general information that might be useful:
Debian Unstable
lspci -v of onboard:
 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master
        IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at c000 [size=16]
        Capabilities: [c0] Power Management version 2

lspci -v of PCI IDE:
  00:0a.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
        Subsystem: CMD Technology Inc PCI0649
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d800 [size=8]
        I/O ports at dc00 [size=4]
        I/O ports at e000 [size=8]
        I/O ports at e400 [size=4]
        I/O ports at e800 [size=16]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2

All kernels are stock kernel.org kernels.

If I can provide any more information, run any tests, or be of any help, please
let me know. Any help or thoughts you can provide would be much appreciated.

Thanks,
-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
 - Benjamin Franklin, 1759

