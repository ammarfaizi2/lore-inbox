Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVBCVVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVBCVVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVBCVVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:21:41 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:57997 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S263155AbVBCVUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:20:42 -0500
Date: Thu, 3 Feb 2005 22:10:19 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] ide-dev-2.6 update
Message-ID: <Pine.GSO.4.58.0502032205420.7496@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

ChangeLog:

* sync with linux-2.6 tree
* merge "next bunch of IDE fixes (on the way to the driver-model)" serie
* merge via82cxxx resume fix

BK users:

	bk pull bk://bart.bkbits.net/ide-dev-2.6

This will update the following files:

 drivers/ide/Kconfig            |    8 -
 drivers/ide/ide-cd.c           |  157 +++++++++++++--------
 drivers/ide/ide-cd.h           |    2
 drivers/ide/ide-default.c      |   17 +-
 drivers/ide/ide-disk.c         |  305 +++++++++++++----------------------------
 drivers/ide/ide-floppy.c       |  132 +++++++++++++----
 drivers/ide/ide-io.c           |  163 +++++++++++++++++++++
 drivers/ide/ide-iops.c         |   20 ++
 drivers/ide/ide-probe.c        |   62 ++++++++
 drivers/ide/ide-proc.c         |    8 -
 drivers/ide/ide-tape.c         |  117 +++++++++++----
 drivers/ide/ide-taskfile.c     |    6
 drivers/ide/ide.c              |   82 -----------
 drivers/ide/pci/pdc202xx_new.h |    6
 drivers/ide/pci/pdc202xx_old.h |   17 --
 drivers/ide/pci/via82cxxx.c    |    7
 drivers/ide/setup-pci.c        |   15 --
 drivers/scsi/ide-scsi.c        |   79 +++++++++-
 include/linux/ide.h            |    9 -
 19 files changed, 724 insertions(+), 488 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (05/02/03 1.2057)
   [ide] fix via82cxxx resume failure

   With David Woodhouse <dwmw2@infradead.org>.

   On resume from sleep, via_set_speed() doesn't reinstate the correct
   mode, because it thinks the drive is already configured correctly.

   Also kill redundant printk, ide_config_drive_speed() warns about errors.

<bzolnier@trik.(none)> (05/02/03 1.2056)
   [ide] ide-scsi: add basic refcounting

   * pointers to a SCSI host and a drive are added to idescsi_scsi_t
   * pointer to the SCSI host is stored in disk->private_data
   * ide_scsi_{get,put}() is used to {get,put} reference to the SCSI host

<bzolnier@trik.(none)> (05/02/03 1.2055)
   [ide] ide-tape: add basic refcounting

   Similar changes as for ide-cd.c.

<bzolnier@trik.(none)> (05/02/03 1.2054)
   [ide] ide-floppy: add basic refcounting

   Similar changes as for ide-cd.c.

<bzolnier@trik.(none)> (05/02/03 1.2053)
   [ide] ide-disk: add basic refcounting

   Similar changes as for ide-cd.c (except that struct ide_disk_obj is added).

<bzolnier@trik.(none)> (05/02/03 1.2052)
   [ide] ide-cd: add basic refcounting

   * based on reference counting in drivers/scsi/{sd,sr}.c
   * fixes race between ->open() and ->cleanup() (ide_unregister_subdriver()
     tests for drive->usage != 0 but there is no protection against new users)
   * struct kref and pointer to a drive are added to struct ide_cdrom_info
   * pointer to drive's struct ide_cdrom_info is stored in disk->private_data
   * ide_cd_{get,put}() is used to {get,put} reference to struct ide_cdrom_info
   * ide_cd_release() is a release method for struct ide_cdrom_info

<bzolnier@trik.(none)> (05/02/03 1.2051)
   [ide] make ide_generic_ioctl() take ide_drive_t * as an argument

   As a result disk->private_data can be used by device drivers now.

<bzolnier@trik.(none)> (05/02/03 1.2050)
   [ide] kill setup_driver_defaults()

   * move default_do_request() to ide-default.c
   * fix drivers to set ide_driver_t->{do_request,end_request,error,abort}
   * kill setup_driver_defaults()

<bzolnier@trik.(none)> (05/02/03 1.2049)
   [ide] kill ide_driver_t->capacity

   * add private /proc/ide/hd?/capacity handlers to ide-{cd,disk,floppy}.c
   * use generic proc_ide_read_capacity() for ide-{scsi,tape}.c
   * kill ->capacity, default_capacity() and generic_subdriver_entries[]

<bzolnier@trik.(none)> (05/01/21 1.1966.85.144)
   [ide] kill ide_driver_t->pre_reset

   Add ide_drive_t->post_reset flag and use it to signal post reset
   condition to the ide-tape driver (the only user of ->pre_reset).

<bzolnier@trik.(none)> (05/01/21 1.1966.85.143)
   [ide] fix some rare ide-default vs ide-disk races

   Some rare races between ide-default and ide-disk are possible, i.e.:
   * ide-default is used, I/O request is triggered (ie. /proc/ide/hd?/identify),
     drive->special is cleared silently (so CHS is not initialized properly),
     ide-disk is loaded and fails if drive uses CHS
   * ide-disk is used, drive is resetted, ide-disk is unloaded, ide-default
     takes control over drive and on the first I/O request silently clears
    drive->special without restoring settings

   Fix them by moving idedisk_{special,pre_reset}() and company to IDE core.

<bzolnier@trik.(none)> (05/01/21 1.1966.85.142)
   [ide] generic Power Management for IDE devices

   Move PM code from ide-cd.c and ide-disk.c to IDE core so:
   * PM is supported for other ATAPI devices (floppy, tape)
   * PM is supported even if specific driver is not loaded

<bzolnier@trik.(none)> (05/01/21 1.1966.85.141)
   [ide] fix drive->ready_stat for ATAPI

   ATAPI devices ignore DRDY bit so drive->ready_stat must be set to zero.
   It is currently done by device drivers (including ide-default fake driver)
   but for PMAC driver it is too late as wait_for_ready() may be called during
   probe: probe_hwif()->pmac_ide_dma_check()->pmac_ide_{mdma,udma}_enable()->
   ->pmac_ide_do_setfeature()->wait_for_ready().

   Fixup drive->ready_stat just after detecting ATAPI device.

<bzolnier@trik.(none)> (05/01/21 1.1966.85.140)
   [ide] ignore BIOS enable bits for Promise controllers

   Since there are no Promise binary drivers for 2.6.x kernels:
   * ignore BIOS enable bits completely
   * remove CONFIG_PDC202XX_FORCE
   * kill IDEPCI_FLAG_FORCE_PDC hack
