Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSJYWPQ>; Fri, 25 Oct 2002 18:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSJYWPP>; Fri, 25 Oct 2002 18:15:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:45020 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261642AbSJYWPJ>;
	Fri, 25 Oct 2002 18:15:09 -0400
Date: Fri, 25 Oct 2002 15:21:16 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] 0/6 2.5.44 scsi multi-path IO
Message-ID: <20021025152116.A17462@eng2.beaverton.ibm.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

Following is the SCSI mid-layer multi-path patch against 2.5.44,
including NUMA support.

Any flames, comments, patches, etc. appreciated.

This note, the multi-path patch rollup, qla 6.03.00 Beta 7 patch, out
of date documentation, and TODO list can be found under:

http://www-124.ibm.com/storageio/multipath/scsi-multipath/index.php

One rollup patch:

http://www-124.ibm.com/storageio/multipath/scsi-multipath/releases/0.5/patch-scsi_mpath_rollup-2.5.44-0.5.gz

The qla 6.03.00 Beta 7 driver (for use with the Qlogic 2200 or 2300) can
be found under:

http://www.qlogic.com/support/os_detail.asp?seriesid=76&osid=26

Or directly at:

http://download.qlogic.com/drivers/6443/qla2x00-v6.03.00b7-dist.tgz

Major changes since last posting:

  Made multi-path an experimental option - with it on, all SCSI devices
  must have a unique id, and all adapter drivers used must behave
  correctly without the current one-to-one relationship between
  Scsi_Device and a Scsi_Host.

  Removed duplicate code paths. The same code paths are used whether
  CONFIG_SCSI_MULTI_PATH_IO is set or not; with it off, it does not check
  or add multiple paths on scan/probe, but the same code is otherwise used.

  Optimized the IO completion path (don't call scsi_check_paths for a
  succesfull IO completion).

Most significant TODO items affecting non-multi-path config:

  Never remove a failed path, so the standard scsi error handling
  code functions as-is.

  Modify all adapter drivers to use new traversal functions (they must no
  longer use Scsi_Host::host_queue and/or Scsi_Device::next).

  Modify osst upper level driver.

As noted - the config experimental CONFIG_SCSI_MULTI_PATH_IO option must
be enabled to get SCSI multi-path.

If you have multi-port devices with no penalty for switching ports, or
only multi-path hosts (multi-initiated fabrics or busses), use
round-robin multipath routing (CONFIG_SCSI_PATH_POLICY_RR); if you are
unsure, use the last path used selection (CONFIG_SCSI_PATH_POLICY_LPU).

Currently, multi-path support requires a SCSI device that supports one of
the SCSI INQUIRY device identification pages (page 0x80 or 0x83). Devices not
supporting one of these pages are treated as if they were separate devices.
Devices that do not give a unique serial number per LUN for these commands
might incorrectly be identified as multi-pathed.


NUMA testing and performance:

NUMA testing was run on a two node IBM NUMAQ box, with qlogic 2300
adapters and FCP connected Seagate drives.  The qla driver has problems
(use after freed or stack overflow problems?) when configuring many
devices and adapters on a switch, so I had to run with direct attached
loop. 

On a two node (8 processor) IBM NUMAQ box, with 39 drives and 8 qla 2300
adapters, get aggregate throughput (read only using dd and raw IO) of up
to 550 mb/sec was reached. I was actually able to compile a kernel at the
same time in under 3 minutes (make -j9) while still getting about 500
mb/sec of throughput.

Both stock 2.5.44 and 2.5.44-mm3 kernels were run on the NUMAQ +
multi-path, with no noticeable difference in performance (but the system
was very idle, in iowait most of the time).

Unfortunately, high file systems loads with the qla driver were oopsing
the system in odd ways with 2.5.44-mm3 - this is also happening for
2.5.44-mm3 stock kernels with the qla driver, there is some odd memory
corruption happening. I did run fairly file system IO tests with 2.5.44 +
multi-path with 17 of the qla attached drives.


Other testing:

Tests were run with an IBM 3542 (fibre channel disk array) as well as
dual-ported FCP Seagate drives (ST39173F, in a Clariion DAE), with both
direct and and switch attached storage (using an IBM 2109 fibre channel
switch) with both qlogic 2200 and 2300 adapters.

Switch portdisable/portenable commands were used to simulate failures.
The qla driver is taking longer to fail commands than with previous
releases. The /proc/scsi/scsi_path/paths interface was used to re-enable
failed paths.

In addition, systems were booted (with only single paths to devices)
using:

	Adaptec 7896 with the aic7xxx driver, with IBM-PSG ST318203LC disks
	IPS adapter and driver
	isp1020 adatper with qlogicisp driver and IBM OEM DCHS09X drive

Simple single path tape IO was tested using a ISP1020 adapter with the
qlogicisp driver, and a single DLT drive.

CD read tests were run using a Plextor CD-RW attached to an aic7896.

No tests were run using multiple paths (multiple initiators or dual ported
devices) on any SCSI parallel interfaces (such as the aic or qlogic isp).

No testing was run using the qlogicfc driver (tests were run previously
with 2.5.14 and the 0.1 version of this patch, but no tests have been run
with this current patch).

Significant items in the TODO list related to multi-path configuration
(versus single path items listed above) include: 

    separating queue_lock from host_lock - likely create a Scsi_Device::lock

    add SMP locking while manipulating paths (the solution is likely to
    use a Scsi_Device::lock as a queue_lock and for multi-path) - without
    this problems can occur when a path state is changed at the same time
    IO is being sent (the BUG_ON in scsi_get_best_path can be hit).

    fix the error handling code - currently, if all paths fail, the error
    handler will run but not be able to retry any IO. A first pass
    solution will be to run the current error handler after the last path
    to a devic has failed; this is likely inadequate in the long run.

    Apply Dan Mcneil's patch to add device model support for
    multiple-paths (at this time, only the first path shows up in the
    device model), 

-- Patrick Mansfield
