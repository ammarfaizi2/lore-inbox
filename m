Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbUBZCfH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUBZCfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:35:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37329 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261625AbUBZCeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:34:50 -0500
Message-ID: <403D5B3D.6060804@pobox.com>
Date: Wed, 25 Feb 2004 21:34:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Serial ATA (SATA) status report
Content-Type: multipart/mixed;
 boundary="------------050408090309020106060701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050408090309020106060701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

attached.

--------------050408090309020106060701
Content-Type: text/plain;
 name="sata-status.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata-status.txt"




Serial ATA (SATA) for Linux
status report
Feb 25, 2004


Hardware support
================


Intel ICH5 and ICH5-R
---------------------
Summary:  No TCQ.  Looks like a PATA controller, but with a few added,
non-standard SATA port controls.  Hardware does not support hotplug.
"Coldplug" support is potentially feasible.

libata driver status:  Production, but see issue #2, #3, #4.

drivers/ide driver status:  Production, but see issue #1, #2.


Issue #1:  Depending on BIOS settings, IDE driver may lock up computer
when probing drives.

Issue #2:  Excessive interrupts are seen in some configurations.

Issue #3:  "Enhanced mode" or "SATA-only mode" may need to be set in BIOS.

Issue #4:  Driver disables SATA port on unload, but does not re-enable
SATA port on load.


Intel ICH6 ("AHCI")
-------------------
Summary:  Per-device queues, full SATA control including hotplug
and PM.

libata driver status:  "looks like ICH5" support available in ata_piix
very soon.  Full support available in a week or two.


Promise TX2/TX4/SX4
-------------------
Summary:  Per-host queues on all controllers.  Full SATA control
including hotplug and PM on all but one controller.

libata driver status:  Beta, but see issue #5.


Issue #5:  Some boards appear to have PATA as well as SATA ports.  PATA
is not currently supported, and no plans have yet been made to rectify
this.  Ideally drivers/ide would drive PATA, but if they are the same
PCI device, that would not be feasible.


Silicon Image 3112/3114
-----------------------
Summary:  No TCQ.  Looks like a PATA controller, but with full SATA
control including hotplug and PM.

libata driver status:  Alpha.

drivers/ide driver status:  Production, but see issue #4.

Issue #4:  Need to have the most recent fixes posted to lkml, for stable
operation and full performance (where possible).


Silicon Image 3124
------------------
Soon, hopefully.  User-written.


Broadcom/ServerWorks/Apple
--------------------------
Summary:  Huge per-device queues, full SATA control including hotplug
and PM.

libata driver status:  Beta.


VIA
---
Summary:  No TCQ.  Looks like a PATA controller, but with full SATA
control including hotplug and PM.

libata driver status:  Beta.


SiS
---

libata driver status:  in progress (user-written)


Vitesse
-------

libata driver status:  in progress


Marvell
-------
libata driver status:  in progress




Software support
================


Basic Serial ATA support
------------------------
The "ATA host state machine", the core of the entire driver, is
considered production-stable.

The error handling is _very_ simple, but at this stage that is an
advantage.  Error handling code anywhere is inevitably both complex and
sorely under-tested.  libata error handling is intentionally simple.
Positives:  Easy to review and verify correctness.  Never data
corruption.  Negatives:  if an error occurs, libata will simply send
the error back the block layer.  There are limited retries by the block
layer, depending on the type of error, but there is never a bus reset.

Or in other words:  "it's better to stop talking to the disk than
compound existing problems with further problems."

As Serial ATA matures, and host- and device-side errata become apparent,
the error handling will be slowly refined.  I am planning to work with a
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
stretch of testing on a large variety of controllers and drives.  This
is very time-intensive, and is the largest part of this task.


Tangent:  Host-based queueing and Native Command Queueing

Queueing is the process of sending multiple commands to a single device,
without waiting for prior commands to finish.  This increases
performance and reduces latency.  There are three types of queueing in
the ATA world:

1) "legacy TCQ" -- some PATA devices support this.  Just ignore it,
it's going away.

2) "host-based TCQ" -- the host controller supports a queue of drive
commands, whether or not the drive supports it.

3) "Native Command Queueing" -- both host and drive cooperate in the
queueing and execution of drive commands.  This should provide the
highest performance and lowest latency of all three options.


#1 is support by drivers/ide _only_.  libata will not support this.
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
Soon.  Requires the capability to directly submit ATA commands from
userspace to the low-level device, which must be added with care.



--------------050408090309020106060701--

