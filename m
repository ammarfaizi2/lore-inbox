Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUEJWZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUEJWZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUEJWZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:25:47 -0400
Received: from havoc.gtf.org ([216.162.42.101]:44715 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261680AbUEJWZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:25:08 -0400
Date: Mon, 10 May 2004 18:25:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Serial ATA (SATA) on Linux status report
Message-ID: <20040510222506.GA21370@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Serial ATA (SATA) for Linux
status report
May 10, 2004


Hardware support
================


Intel ICH5 and ICH5-R
---------------------
Summary: No TCQ. Looks like a PATA controller, but with a few added,
non-standard SATA port controls. Hardware does not support hotplug.
"Coldplug" support is potentially feasible.

libata driver status: Production, but see issue #2, #3.

drivers/ide driver status: Production, but see issue #1, #2.


Issue #1: Depending on BIOS settings, IDE driver may lock up computer
when probing drives.

Issue #2: Excessive interrupts are seen in some configurations.

Issue #3: "Enhanced mode" or "SATA-only mode" may need to be set in BIOS.



Intel ICH6 ("AHCI")
-------------------
Summary: Per-device queues, full SATA control including hotplug
and PM.

libata driver status: "looks like ICH5" support available in ata_piix.
Preliminary driver with full AHCI support now exists, and is being
integrated into libata mainline.


Promise TX2/TX4/SX4
-------------------
Summary: Per-host queues on all controllers. Full SATA control
including hotplug and PM on all but one controller.

libata TX2/TX4 driver status: Production, but see issue #5.

libata SX4 driver status: Production, but see issue #6.


Issue #5: Some boards appear to have PATA as well as SATA ports. PATA
is not currently supported, and no plans have yet been made to rectify
this. Ideally drivers/ide would drive PATA, but if they are the same
PCI device, that would not be feasible.

Issue #6: The SX4 hardware is not fully utilized by the Linux kernel
driver.  The SX4 hardware includes an on-board DIMM and hardware XOR
offload.  Using the on-board DIMM as cache, and issuing each RAID
transaction once (instead of once for each disk), will result in
increased performance, but the driver doesn't do that yet.  SX4 hardware
is very "RAID friendly", particularly RAID1/5.  Users may wish to use
the Promise driver to fully utilize the hardware.


Silicon Image 3112/3114
-----------------------
Summary: No TCQ. Looks like a PATA controller, but with full SATA
control including hotplug and PM.

libata driver status: Beta.

drivers/ide driver status: Production, but see issue #4.

Issue #4: Need to have the most recent fixes posted to lkml, for stable
operation and full performance (where possible).


Silicon Image 3124
------------------
Soon, hopefully.  Silicon Image has made documentation and sample
hardware available to me (jgarzik) for development.  Some code exists
internally.


Broadcom/ServerWorks/Apple
--------------------------
Summary: Huge per-device queues, full SATA control including hotplug
and PM for the "Frodo4" and "Frodo8" boards.  Apple K2 SATA, which also
uses this chipset, has all the feature of Frodo4/8 save the host DMA
queueing feature ("QDMA").

libata driver status: Beta, but no QDMA support yet.


VIA
---
Summary: No TCQ. Looks like a PATA controller, but with full SATA
control including hotplug and PM.

libata driver status: Beta.


SiS
---

libata driver status: Beta


Vitesse
-------

libata driver status: Beta


Marvell
-------
libata driver status: in progress




Software support
================


Basic Serial ATA support
------------------------
The "ATA host state machine", the core of the entire driver, is
considered production-stable.

The error handling is _very_ simple, but at this stage that is an
advantage. Error handling code anywhere is inevitably both complex and
sorely under-tested. libata error handling is intentionally simple.
Positives: Easy to review and verify correctness. Never data
corruption. Negatives: if an error occurs, libata will simply send
the error back the block layer. There are limited retries by the block
layer, depending on the type of error, but there is never a bus reset.

Or in other words: "it's better to stop talking to the disk than
compound existing problems with further problems."

As Serial ATA matures, and host- and device-side errata become apparent,
the error handling will be slowly refined. I am planning to work with a
few (kind!) disk vendors, to obtain special drives/firmwares that allow
me to inject faults, and otherwise exercise error handling code.



Queueing support
----------------
Even though some SATA host controllers on the market already support
command queueing (a.k.a. "TCQ"), libata does not yet support it.

However, libata was designed from the ground-up to support queueing, so
I need only change a few lines of code, and write two functions, to
enable this behavior.

Queueing will be enabled in libata soon, but to do so requires a long
stretch of testing on a large variety of controllers and drives. This
is very time-intensive, and is the largest part of this task.


Tangent: Host-based queueing and Native Command Queueing

Queueing is the process of sending multiple commands to a single device,
without waiting for prior commands to finish. This increases
performance and reduces latency. There are three types of queueing in
the ATA world:

1) "legacy TCQ" -- some PATA devices support this. Just ignore it,
it's going away.

2) "host-based TCQ" -- the host controller supports a queue of drive
commands, whether or not the drive supports it.

3) "Native Command Queueing" -- both host and drive cooperate in the
queueing and execution of drive commands. This should provide the
highest performance and lowest latency of all three options.


#1 is support by drivers/ide _only_. libata will not support this.
#2 will soon be supported by libata.
#3 will be supported by libata when hardware is available from drive
manufacturers.


Hotplug support
---------------
All SATA is hotplug.

libata does not support hotplug... yet.



Power Management support
------------------------
Over and above the power management specified in the ATA/ATAPI
specification, one can aggressively control the power consumption of
SATA hosts, the SATA bus, and the SATA device.



SMART support
-------------
Soon. Requires the capability to directly submit ATA commands from
userspace to the low-level device, which must be added with care.

