Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVDBPXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVDBPXw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 10:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVDBPXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 10:23:52 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:8700 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261559AbVDBPXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 10:23:37 -0500
Date: Sat, 2 Apr 2005 17:22:19 +0200 (CEST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] ide-2.6 update
Message-ID: <Pine.GSO.4.62.0504021718270.24415@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

short ChangeLog:
* ide-default pseudo-driver is gone
* VIA resume failure is fixed

Bartlomiej

Please do a

 	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

  drivers/ide/ide-default.c   |   76 ---------------------------
  drivers/ide/Makefile        |    3 -
  drivers/ide/ide-cd.c        |   71 ++++++++++++++++---------
  drivers/ide/ide-cd.h        |    2
  drivers/ide/ide-disk.c      |   30 ++++++++--
  drivers/ide/ide-dma.c       |    8 ++
  drivers/ide/ide-floppy.c    |   48 ++++++++++++-----
  drivers/ide/ide-io.c        |   46 ++++++++++++----
  drivers/ide/ide-probe.c     |  122 +++++++++++++++++++++++---------------------
  drivers/ide/ide-proc.c      |   12 +---
  drivers/ide/ide-tape.c      |   41 ++++++++++++--
  drivers/ide/ide-taskfile.c  |   11 ++-
  drivers/ide/ide.c           |   86 ++++++++++++-------------------
  drivers/ide/pci/via82cxxx.c |    7 --
  drivers/scsi/ide-scsi.c     |   44 ++++++++++++---
  include/linux/ide.h         |    6 +-
  16 files changed, 338 insertions(+), 275 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (05/04/02 1.2351)
    [ide] fix via82cxxx resume failure

    With David Woodhouse <dwmw2@infradead.org>.

    On resume from sleep, via_set_speed() doesn't reinstate the correct
    mode, because it thinks the drive is already configured correctly.

    Also kill redundant printk, ide_config_drive_speed() warns about errors.

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/04/02 1.2350)
    [ide] kill ide-default

    * add ide_drives list to list devices without a driver
    * add __ide_add_setting() and use it for adding no auto remove entries
    * kill ide-default pseudo-driver

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/04/02 1.2349)
    [ide] get driver from rq->rq_disk->private_data

    * add ide_driver_t * to device drivers objects
    * set it to point at driver's ide_driver_t
    * store address of this entry in disk->private_data
    * fix ide_{cd,disk,floppy,tape,scsi}_g accordingly
    * use rq->rq_disk->private_data instead of drive->driver
      to obtain driver (this allows us to kill ide-default)

    ide_dma_intr() OOPS fixed by Tejun Heo <htejun@gmail.com>.

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/04/02 1.2348)
    [ide] kill ide_drive_t->disk

    * move ->disk from ide_drive_t to driver specific objects
    * make drivers allocate struct gendisk and setup rq->rq_disk
      (there is no need to do this for REQ_DRIVE_TASKFILE requests)
    * add ide_init_disk() helper and kill alloc_disks() in ide-probe.c
    * kill no longer needed ide_open() and ide_fops[] in ide.c

    ide_init_disk() fixed by Andrew Morton <akpm@osdl.org>.

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/04/02 1.2347)
    [ide] add ide_{un}register_region()

    Add ide_{un}register_region() and fix ide-{tape,scsi}.c to register
    block device number ranges.  In ata_probe() only probe for modules.

    Behavior is unchanged because:
    * if driver is already loaded and attached to drive ata_probe()
      is not called et all
    * if driver is loaded by ata_probe() it will register new number range
      for a drive and this range will be found by kobj_lookup()

    If this is not clear please read http://lwn.net/Articles/25711/
    and see drivers/base/map.c.

    This patch makes it possible to move drive->disk allocation from
    ide-probe.c to device drivers.

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/04/02 1.2346)
    [ide] destroy_proc_ide_device() cleanup

    When this function is called device is already unbinded from a
    driver so there are no driver /proc entries to remove.

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/04/02 1.2345)
    [ide] drive->dsc_overlap fix

    drive->dsc_overlap is supported only by ide-{cd,tape} drivers.
    Add missing clearing of ->dsc_overlap to ide_{cd,tape}_release()
    and move ->dsc_overlap setup from ide_register_subdriver() to
    ide_cdrom_setup() (ide-tape enables it unconditionally).

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/04/02 1.2344)
    [ide] drive->nice1 fix

    It is drive's property independent of the driver being used so move
    drive->nice1 setup from ide_register_subdriver() to probe_hwif() in
    ide-probe.c.  As a result changing a driver which controls the drive
    no longer affects this flag.

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

