Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264651AbSIQWow>; Tue, 17 Sep 2002 18:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264674AbSIQWow>; Tue, 17 Sep 2002 18:44:52 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:6302 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264651AbSIQWor>;
	Tue, 17 Sep 2002 18:44:47 -0400
Date: Tue, 17 Sep 2002 15:49:40 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC] [PATCH] 0/7 2.5.35 SCSI multi-path
Message-ID: <20020917154940.A18401@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

Any comments or testing of this patch is appreciated.

SCSI mid-layer multi-path IO version 0.4.0

The release note, multi-path patch rollup (against 2.5.35), qla
6.01b5 patch, more documentation, and TODO list can be found under:

http://www-124.ibm.com/storageio/multipath/scsi-multipath/index.php

The patch sets (following separate emails) are based on _top_ of Mike
Anderson's scsi_error patch, apply this before the patch sets, it is
against 2.5.34, but applies clean against 2.5.35:

http://www-124.ibm.com/storageio/gen-io/patch-scsi_error-2.5.34-1.gz

If you want to see this as one big patch against 2.5.35, a rollup
patch (including Mike Anderson's patch) is at:

http://www-124.ibm.com/storageio/multipath/scsi-multipath/releases/0.4/patch-scsi_mpath_rollup-2.5.35-0.4.gz

The qla 6.01b5 driver (for use with the Qlogic 2200 or 2300) can be found
under:

http://www.qlogic.com/support/os_detail.asp?seriesid=76&osid=26

Or directly at:

http://download.qlogic.com/drivers/5642/qla2x00-v6.1b5-dist.tgz


Apply the patch(es), and configure SCSI mid layer multi-path IO support
(CONFIG_SCSI_MULTI_PATH_IO). If you have multi-port devices with no
penalty for switching ports, or only multi-path hosts (multi-initiated
fabrics and busses), use round-robin multipath routing
(CONFIG_SCSI_PATH_POLICY_RR); if you are unsure, use the last path used
selection (CONFIG_SCSI_PATH_POLICY_LPU).

Currently, multi-path support requires a SCSI device that supports one of
the SCSI INQUIRY device identification pages (page 0x80 or 0x83). Devices not
supporting one of these pages are treated as if they were separate devices.
Devices that do not give a unique serial number per LUN for these commands
might incorrectly be identified as multi-pathed.

The biggest functional change since the last (0.1.0) posted version of the
patch is the addition of support for NUMA systems - current support treats
all node local adapters as being closest to a node (i.e. distance of 0),
and all other adapters as being equal distance from that node. This means
that if a node has no local adapters, it will treat all other adapters as
equal distance from itself.

2.5.32 + discontigmem patch + numa topology patch  + numaq patches + soft
irq patch + a bit earlier version of this multi-path patch was tested, but
I haven't been able to keep up with that train, so no NUMA testing has
been run since 2.5.32. A simple test program was used to read a "raw"
device on a specified cpu. Some file system testing was also run. The raw
device testing and file system testing showed that node local adapters
(paths) were used for IO rather than non-local adapters (FC switch
statistics were used to see the traffic, there are no per-paths statistics).

IBM NUMAQ boxes were used for the NUMA testing, with qlogic 2300 adapters.
The latest qla 6.01b5 driver had problems configuring the non-node 0
adapters (with memory mapped IO on), so an older version of the driver was
used.


Other Multi-path testing:

Tests were run with an IBM 3542 (fibre channel disk array) as well as
dual-ported FCP Seagate drives (ST39173F, in a Clariion DAE), with all
devices attached via multiple adapters connected to an IBM 2109 fibre
channel switch via qlogic 2200 and 2300 adapters.

Switch portdisable/portenable commands were used to simulate failures.
The /proc/scsi/scsi_path/paths interface was used to re-enable failed
paths.

In addition, systems were booted (with only single paths to devices)
using:

	Adaptec 7896 with the aic7xxx driver, with IBM-PSG ST318203LC disks
	IPS adapter and driver

Simple single path tape IO was tested using a ISP1020 adapter with the
qlogicisp driver, and a single DLT drive.

CD read tests were run using a Plextor CD-RW attached to an aic7896.

No tests were run using multiple paths (multiple initiators or dual ported
devices) on any SCSI parallel interfaces (such as the aic or qlogic isp).

No testing was run using the qlogicfc driver (tests were run previously
with 2.5.14 and the 0.1 version of this patch, but no tests have been run
with this current patch).


The multi-path patch removes several structures commonly used by adapter
drivers, the main patch includes modifications for the AIC, qlogicfc, and
IPS drivers; there is a separate patch for the qla 6.01b5 driver. It's
likely you'll have to make modifications if you use an adapter and driver
combination other than these.


Some of the more significant items in the TODO list include: 

    separating queue_lock from host_lock - likely create a Scsi_Device::lock

    add SMP locking while manipulating paths (the solution is likely to
    use a Scsi_Device::lock as a queue_lock and for multi-path) - without
    this problems can occur when a path state is changed at the same time
    IO is being sent (the BUG_ON in scsi_get_best_path can be hit).

    fix the error handling code - currently, if all paths fail, the error
    handler will run but not be able to retry any IO. A first pass
    solution will be to run the current error handler after the last path
    to a devic has failed; this is likely inadequate in the long run.

    add device model support for multiple-paths (at this time, only the
    first path shows up in the device model)

-- Patrick Mansfield
