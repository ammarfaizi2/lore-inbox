Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVCHOM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVCHOM1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 09:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVCHOM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 09:12:27 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:5344 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261324AbVCHOLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 09:11:35 -0500
Date: Tue, 8 Mar 2005 15:04:30 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [BK PATCHES] ide-dev-2.6 update
Message-ID: <Pine.GSO.4.58.0503081455160.12783@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

ChangeLog:

* sync with linux-2.6 tree
* ide_init_disk() fix (Andrew Morton)
* ide_dma_intr() OOPS fix (Tejun Heo)
* sanitize usage of LBA bit in Device register
* remove REQ_DRIVE_TASK (Tejun Heo)
* some cleanups (Tejun Heo and me)
* convert device drivers to driver model

Bartlomiej

BK users:

	bk pull bk://bart.bkbits.net/ide-dev-2.6

This will update the following files:

 drivers/ide/ide-default.c      |   73 -----
 drivers/block/ll_rw_blk.c      |    1
 drivers/ide/Kconfig            |    8
 drivers/ide/Makefile           |    3
 drivers/ide/ide-cd.c           |  259 ++++++++++--------
 drivers/ide/ide-cd.h           |    4
 drivers/ide/ide-disk.c         |  584 +++++++++++++++--------------------------
 drivers/ide/ide-dma.c          |    8
 drivers/ide/ide-floppy.c       |  208 ++++++++++----
 drivers/ide/ide-io.c           |  399 +++++++++++++++++++---------
 drivers/ide/ide-iops.c         |   32 +-
 drivers/ide/ide-lib.c          |    5
 drivers/ide/ide-probe.c        |  231 +++++++++++-----
 drivers/ide/ide-proc.c         |   68 +++-
 drivers/ide/ide-tape.c         |  270 ++++++++++++------
 drivers/ide/ide-taskfile.c     |  225 +++++++++------
 drivers/ide/ide.c              |  451 +++----------------------------
 drivers/ide/pci/pdc202xx_new.c |    6
 drivers/ide/pci/pdc202xx_old.c |   17 -
 drivers/ide/pci/via82cxxx.c    |   37 +-
 drivers/ide/setup-pci.c        |   15 -
 drivers/scsi/ide-scsi.c        |  161 ++++++++---
 include/linux/ata.h            |   12
 include/linux/blkdev.h         |    2
 include/linux/hdreg.h          |    4
 include/linux/ide.h            |   84 ++---
 include/linux/pci_ids.h        |    1
 27 files changed, 1622 insertions(+), 1546 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (05/03/08 1.2033)
   [ide] fix driver->probe return codes

<bzolnier@trik.(none)> (05/03/08 1.2032)
   [ide] convert device drivers to driver-model

   * add ide_bus_match() and export ide_bus_type
   * split ide_remove_driver_from_hwgroup() out of ide_unregister()
   * move device cleanup from ide_unregister() to drive_release_dev()
   * convert ide_driver_t->name to driver->name
   * convert ide_driver_t->{attach,cleanup} to driver->{probe,remove}
   * remove ide_driver_t->busy as ide_bus_type->subsys.rwsem
     protects against concurrent ->{probe,remove} calls
   * make ide_{un}register_driver() void as it cannot fail now
   * use driver_{un}register() directly, remove ide_{un}register_driver()
   * use device_register() instead of ata_attach(), remove ata_attach()
   * add proc_print_driver() and ide_drivers_show(), remove ide_drivers_op
   * fix ide_replace_subdriver() and move it to ide-proc.c
   * remove ide_driver_t->drives, ide_drives and drives_lock
   * remove ide_driver_t->drivers, drivers and drivers_lock
   * remove ide_drive_t->driver and DRIVER() macro

<htejun@gmail.com> (05/03/08 1.2031)
   [ide] remove unused REQ_DRIVE_TASK handling

   Signed-off-by: Tejun Heo <htejun@gmail.com>

<htejun@gmail.com> (05/03/08 1.2030)
   [ide] make ide_task_ioctl() use REQ_DRIVE_TASKFILE

   ide_task_ioctl() rewritten to use taskfile transport.
   This is the last user of REQ_DRIVE_TASK.

   bart: ported to recent IDE changes by me

   Signed-off-by: Tejun Heo <htejun@gmail.com>

<bzolnier@trik.(none)> (05/03/08 1.2029)
   [ide] convert disk flush functions to use REQ_DRIVE_TASKFILE

   Original patch from Tejun Heo <htejun@gmail.com>,
   ported over recent IDE changes by me.

   * teach ide_tf_get_address() about CHS
   * use ide_tf_get_address() and remove ide_get_error_location()
   * use ide_task_init_flush() and remove ide_fill_flush_cmd()
   * convert idedisk_issue_flush() to use REQ_DRIVE_TASKFILE.
     This and switching to ide_tf_get_address() removes
     a possible race condition between getting the failed
     sector number and other requests.
   * convert ide_queue_flush_cmd() to use REQ_DRIVE_TASKFILE

   By this change, when WIN_FLUSH_CACHE_EXT is used, full HOB
   registers are written and read.  This isn't optimal but
   shouldn't be noticeable either.

<bzolnier@trik.(none)> (05/03/08 1.2028)
   [ide] check capacity in ide_task_init_flush()

   Use WIN_FLUSH_CACHE_EXT only if disk requires LBA48.

<bzolnier@trik.(none)> (05/03/08 1.2027)
   [ide] fix setting LBA bit in Device register for REQ_DRIVE_TASKFILE

   * Power Management requests
     (WIN_STANDBYNOW1, WIN_IDLEIMMEDIATE commands)
   * special commands (WIN_SPECIFY, WIN_RESTORE, WIN_SETMULT)
   * /proc/ide/ SMART support (WIN_SMART with SMART_ENABLE,
     SMART_READ_VALUES and SMART_READ_THRESHOLDS subcommands)
   * write cache enabling/disabling in ide-disk
     (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_WCACHE)
   * acoustic management in ide-disk
     (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_AAM)
   * door (un)locking in ide-disk (WIN_DOORLOCK, WIN_DOORUNLOCK)
   * /proc/ide/hd?/identify support (WIN_IDENTIFY)

<bzolnier@trik.(none)> (05/03/08 1.2026)
   [ide] add ide_task_init_flush() helper

   * add ide_task_init_flush() helper
   * use it in do_idedisk_cacheflush() and ide_start_power_step()
   * inline do_idedisk_cacheflush() into ide_cacheflush_p()

<bzolnier@trik.(none)> (05/03/08 1.2025)
   [ide] merge LBA28 and LBA48 Host Protected Area support code

   * merge idedisk_read_native_max_address()
     and idedisk_read_native_max_address_ext()
   * merge idedisk_set_max_address()
     and idedisk_set_max_address_ext()

<bzolnier@trik.(none)> (05/03/08 1.2024)
   [ide] add ide_tf_get_address() helper

   * add ide_tf_get_address() helper
   * use it in idedisk_read_native_max_address[_ext]()
     and idedisk_set_max_address[_ext]()

<bzolnier@trik.(none)> (05/03/08 1.2023)
   [ide] use struct ata_taskfile in ide_task_t

   * use struct ata_taskfile instead of .flags,
     .tfRegister[] and .hobRegister[] in ide_task_t
   * add #ifndef __KERNEL__ around definitions of {task,hob}_struct_t
   * don't set write-only .hobRegister[6] and .hobRegister[7]
     in idedisk_set_max_address_ext()
   * remove no longer needed IDE_CONTROL_OFFSET_HOB define
   * use ATA_LBA define in ide-disk.c (suggested by Tejun Heo)

<htejun@gmail.com> (05/03/08 1.2022)
   [ide] ide_dma_intr() OOPS fix

   This patch fixes ide_dma_intr() OOPS which occurs
   for HDIO_DRIVE_TASKFILE ioctl using DMA dataphases.

   Signed-off-by: Tejun Heo <htejun@gmail.com>

<akpm@osdl.org> (05/03/08 1.1982.131.2)
   [ide] ide_init_disk() fix

   Signed-off-by: Andrew Morton <akpm@osdl.org>

<bzolnier@trik.(none)> (05/02/11 1.1982.34.52)
   [ide] fix io_32bit race in ide_taskfile_ioctl()

   In ide_taskfile_ioctl(), there was a race condition involving
   drive->io_32bit.  It was cleared and restored during ioctl
   requests but there was no synchronization with other requests.
   So, other requests could execute with the altered io_32bit
   setting or updated drive->io_32bit could be overwritten by
   ide_taskfile_ioctl().

   This patch adds ATA_TFLAG_IO_16BIT flag to indicate to
   ide_pio_datablock() that 16bit IO is needed regardless of
   drive->io_32bit settting.

   Signed-off-by: Tejun Heo <htejun@gmail.com>

<bzolnier@trik.(none)> (05/02/11 1.1982.34.51)
   [ide] fix unneeded LBA48 taskfile registers access

   This small patch fixes unneeded writes/reads to LBA48 taskfile registers
   on LBA48 capable disks for following cases:

   * Power Management requests
     (WIN_FLUSH_CACHE, WIN_STANDBYNOW1, WIN_IDLEIMMEDIATE commands)
   * special commands (WIN_SPECIFY, WIN_RESTORE, WIN_SETMULT)
   * Host Protected Area support (WIN_READ_NATIVE_MAX, WIN_SET_MAX)
   * /proc/ide/ SMART support (WIN_SMART with SMART_ENABLE,
     SMART_READ_VALUES and SMART_READ_THRESHOLDS subcommands)
   * write cache enabling/disabling in ide-disk
    (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_WCACHE)
   * write cache flushing in ide-disk (WIN_FLUSH_CACHE)
   * acoustic management in ide-disk
     (WIN_SETFEATURES with SETFEATURES_{EN,DIS}_AAM)
   * door (un)locking in ide-disk (WIN_DOORLOCK, WIN_DOORUNLOCK)
   * /proc/ide/hd?/identify support (WIN_IDENTIFY)

   Patch adds 'unsinged long flags' to ide_task_t and uses ATA_TFLAG_LBA48
   flag (from <linux/ata.h>) to indicate need of access to LBA48 taskfile
   registers.

<bzolnier@trik.(none)> (05/02/11 1.1982.34.50)
   [ide via82cxxx] add VIA VT6410 support

   From: Mathias Kretschmer <posting@blx4.net>

<bzolnier@trik.(none)> (05/02/11 1.1982.34.49)
   [ide] fix OOPS in task_end_request()

   Requests generated by /proc/ide/hd?/identify
   and /proc/ide/hd?/smart_{thresholds,values}
   don't have valid rq->rq_disk set.

   Use ide_end_request() instead of ->end_request().

<bzolnier@trik.(none)> (05/02/06 1.1982.34.48)
   [ide] fix ATAPI Power Management

   I've introduced bug in ATAPI Power Management handling,
   idedisk_pm_idle shouldn't be done for ATAPI devices.

<bzolnier@trik.(none)> (05/02/06 1.1982.34.47)
   [ide] fix pdc202xx_{new,old}.c after linux-2.6 merge

<bzolnier@trik.(none)> (05/02/04 1.1982.33.18)
   [ide] kill ide-default

   * add ide_drives list to list devices without a driver
   * add __ide_add_setting() and use it for adding no auto remove entries
   * kill ide-default pseudo-driver

<bzolnier@trik.(none)> (05/02/04 1.1982.33.17)
   [ide] get driver from rq->rq_disk->private_data

   * add ide_driver_t * to device drivers objects
   * set it to point at driver's ide_driver_t
   * store address of this entry in disk->private_data
   * fix ide_{cd,disk,floppy,tape,scsi}_g accordingly
   * use rq->rq_disk->private_data instead of drive->driver
     to obtain driver (this allows us to kill ide-default)

<bzolnier@trik.(none)> (05/02/04 1.1982.33.16)
   [ide] kill ide_drive_t->disk

   * move ->disk from ide_drive_t to driver specific objects
   * make drivers allocate struct gendisk and setup rq->rq_disk
     (there is no need to do this for REQ_DRIVE_TASKFILE requests)
   * add ide_init_disk() helper and kill alloc_disks() in ide-probe.c
   * kill no longer needed ide_open() and ide_fops[] in ide.c

<bzolnier@trik.(none)> (05/02/04 1.1982.33.15)
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

<bzolnier@trik.(none)> (05/02/04 1.1982.33.14)
   [ide] destroy_proc_ide_device() cleanup

   When this function is called device is already unbinded from a
   driver so there are no driver /proc entries to remove.

<bzolnier@trik.(none)> (05/02/04 1.1982.33.13)
   [ide] drive->dsc_overlap fix

   drive->dsc_overlap is supported only by ide-{cd,tape} drivers.
   Add missing clearing of ->dsc_overlap to ide_{cd,tape}_release()
   and move ->dsc_overlap setup from ide_register_subdriver() to
   ide_cdrom_setup() (ide-tape enables it unconditionally).

<bzolnier@trik.(none)> (05/02/04 1.1982.33.12)
   [ide] drive->nice1 fix

   It is drive's property independent of the driver being used so move
   drive->nice1 setup from ide_register_subdriver() to probe_hwif() in
   ide-probe.c.  As a result changing a driver which controls the drive
   no longer affects this flag.

<bzolnier@trik.(none)> (05/02/04 1.1982.33.11)
   [ide] ide-tape: fix character device ->open() vs ->cleanup() race

   Similar to the same race but for the block device.

   * store pointer to struct ide_tape_obj in idetape_chrdevs[]
   * rename idetape_chrdevs[] to idetape_devs[] and kill idetape_chrdev_t
   * add ide_tape_chrdev_get() for getting reference to the tape
   * store tape pointer in file->private_data and fix all users of it
   * fix idetape_chrdev_{open,release}() to get/put reference to the tape

<bzolnier@trik.(none)> (05/02/03 1.1982.33.10)
   [ide] fix via82cxxx resume failure

   With David Woodhouse <dwmw2@infradead.org>.

   On resume from sleep, via_set_speed() doesn't reinstate the correct
   mode, because it thinks the drive is already configured correctly.

   Also kill redundant printk, ide_config_drive_speed() warns about errors.

<bzolnier@trik.(none)> (05/02/03 1.1982.33.9)
   [ide] ide-scsi: add basic refcounting

   * pointers to a SCSI host and a drive are added to idescsi_scsi_t
   * pointer to the SCSI host is stored in disk->private_data
   * ide_scsi_{get,put}() is used to {get,put} reference to the SCSI host

<bzolnier@trik.(none)> (05/02/03 1.1982.33.8)
   [ide] ide-tape: add basic refcounting

   Similar changes as for ide-cd.c.

<bzolnier@trik.(none)> (05/02/03 1.1982.33.7)
   [ide] ide-floppy: add basic refcounting

   Similar changes as for ide-cd.c.

<bzolnier@trik.(none)> (05/02/03 1.1982.33.6)
   [ide] ide-disk: add basic refcounting

   Similar changes as for ide-cd.c (except that struct ide_disk_obj is added).

<bzolnier@trik.(none)> (05/02/03 1.1982.33.5)
   [ide] ide-cd: add basic refcounting

   * based on reference counting in drivers/scsi/{sd,sr}.c
   * fixes race between ->open() and ->cleanup() (ide_unregister_subdriver()
     tests for drive->usage != 0 but there is no protection against new users)
   * struct kref and pointer to a drive are added to struct ide_cdrom_info
   * pointer to drive's struct ide_cdrom_info is stored in disk->private_data
   * ide_cd_{get,put}() is used to {get,put} reference to struct ide_cdrom_info
   * ide_cd_release() is a release method for struct ide_cdrom_info

<bzolnier@trik.(none)> (05/02/03 1.1982.33.4)
   [ide] make ide_generic_ioctl() take ide_drive_t * as an argument

   As a result disk->private_data can be used by device drivers now.

<bzolnier@trik.(none)> (05/02/03 1.1982.33.3)
   [ide] kill setup_driver_defaults()

   * move default_do_request() to ide-default.c
   * fix drivers to set ide_driver_t->{do_request,end_request,error,abort}
   * kill setup_driver_defaults()

<bzolnier@trik.(none)> (05/02/03 1.1982.33.2)
   [ide] kill ide_driver_t->capacity

   * add private /proc/ide/hd?/capacity handlers to ide-{cd,disk,floppy}.c
   * use generic proc_ide_read_capacity() for ide-{scsi,tape}.c
   * kill ->capacity, default_capacity() and generic_subdriver_entries[]

<bzolnier@trik.(none)> (05/01/21 1.1966.91.144)
   [ide] kill ide_driver_t->pre_reset

   Add ide_drive_t->post_reset flag and use it to signal post reset
   condition to the ide-tape driver (the only user of ->pre_reset).

<bzolnier@trik.(none)> (05/01/21 1.1966.91.143)
   [ide] fix some rare ide-default vs ide-disk races

   Some rare races between ide-default and ide-disk are possible, i.e.:
   * ide-default is used, I/O request is triggered (ie. /proc/ide/hd?/identify),
     drive->special is cleared silently (so CHS is not initialized properly),
     ide-disk is loaded and fails if drive uses CHS
   * ide-disk is used, drive is resetted, ide-disk is unloaded, ide-default
     takes control over drive and on the first I/O request silently clears
    drive->special without restoring settings

   Fix them by moving idedisk_{special,pre_reset}() and company to IDE core.

<bzolnier@trik.(none)> (05/01/21 1.1966.91.142)
   [ide] generic Power Management for IDE devices

   Move PM code from ide-cd.c and ide-disk.c to IDE core so:
   * PM is supported for other ATAPI devices (floppy, tape)
   * PM is supported even if specific driver is not loaded

<bzolnier@trik.(none)> (05/01/21 1.1966.91.141)
   [ide] fix drive->ready_stat for ATAPI

   ATAPI devices ignore DRDY bit so drive->ready_stat must be set to zero.
   It is currently done by device drivers (including ide-default fake driver)
   but for PMAC driver it is too late as wait_for_ready() may be called during
   probe: probe_hwif()->pmac_ide_dma_check()->pmac_ide_{mdma,udma}_enable()->
   ->pmac_ide_do_setfeature()->wait_for_ready().

   Fixup drive->ready_stat just after detecting ATAPI device.

<bzolnier@trik.(none)> (05/01/21 1.1966.91.140)
   [ide] ignore BIOS enable bits for Promise controllers

   Since there are no Promise binary drivers for 2.6.x kernels:
   * ignore BIOS enable bits completely
   * remove CONFIG_PDC202XX_FORCE
   * kill IDEPCI_FLAG_FORCE_PDC hack

