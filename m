Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTLCUpM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTLCUpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:45:11 -0500
Received: from havoc.gtf.org ([63.247.75.124]:37808 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261188AbTLCUor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:44:47 -0500
Date: Wed, 3 Dec 2003 15:44:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Serial ATA (SATA) for Linux status report
Message-ID: <20031203204445.GA26987@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Editor's preface:  This is clearly a first draft, only covering the
basics.  In order for this document to be effective, I request that
users and developers send me (or post) their SATA driver questions and
issues.  I will do my best to address them here.


Serial ATA (SATA) for Linux
status report
Dec 3, 2003


Hardware support
================


Intel ICH5
----------
Summary:  No TCQ.  Looks like a PATA controller, but with a few added,
non-standard SATA port controls.

libata driver status:  Production, but see issue #2, #3.

drivers/ide driver status:  Production, but see issue #1, #2.


Issue #1:  Depending on BIOS settings, IDE driver may lock up computer
when probing drives.

Issue #2:  Excessive interrupts are seen in some configurations.

Issue #3:  "Enhanced mode" or "SATA-only mode" may need to be set in BIOS.


Intel ICH6 ("AHCI")
-------------------
Summary:  Per-device queues, full SATA control including hotplug
and PM.

libata driver status:  In development.


Promise
-------
Summary:  Per-host queues on all controllers.  Full SATA control
including hotplug and PM on all but one controller.

libata driver status:  Beta.


Silicon Image 3112
------------------
Summary:  No TCQ.  Looks like a PATA controller, but with full SATA
control including hotplug and PM.

libata driver status:  Alpha.

drivers/ide driver status:  Production, but see issue #4.

Issue #4:  Need to have the most recent fixes posted to lkml, for stable
operation and full performance (where possible).


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


