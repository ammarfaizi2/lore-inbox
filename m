Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbVCJSCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbVCJSCC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 13:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbVCJR6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:58:12 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:37851 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262768AbVCJRrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:47:49 -0500
Date: Thu, 10 Mar 2005 18:45:55 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] ide-2.6 update
Message-ID: <Pine.GSO.4.62.0503101842190.594@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please do a

 	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

  drivers/ide/Kconfig        |    1
  drivers/ide/ide-cd.c       |   58 ++++--------
  drivers/ide/ide-default.c  |   17 ++-
  drivers/ide/ide-disk.c     |  213 +++------------------------------------------
  drivers/ide/ide-floppy.c   |   15 ++-
  drivers/ide/ide-io.c       |  169 ++++++++++++++++++++++++++++++++++-
  drivers/ide/ide-iops.c     |   20 ++++
  drivers/ide/ide-probe.c    |   62 ++++++++++++-
  drivers/ide/ide-proc.c     |    8 -
  drivers/ide/ide-tape.c     |   21 +---
  drivers/ide/ide-taskfile.c |    6 -
  drivers/ide/ide.c          |   80 ----------------
  drivers/scsi/ide-scsi.c    |   11 ++
  include/linux/ide.h        |    6 -
  14 files changed, 329 insertions(+), 358 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (05/03/10 1.2016)
    [ide] kill setup_driver_defaults()

    * move default_do_request() to ide-default.c
    * fix drivers to set ide_driver_t->{do_request,end_request,error,abort}
    * kill setup_driver_defaults()

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/03/10 1.2015)
    [ide] kill ide_driver_t->capacity

    * add private /proc/ide/hd?/capacity handlers to ide-{cd,disk,floppy}.c
    * use generic proc_ide_read_capacity() for ide-{scsi,tape}.c
    * kill ->capacity, default_capacity() and generic_subdriver_entries[]

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/03/10 1.2014)
    [ide] kill ide_driver_t->pre_reset

    Add ide_drive_t->post_reset flag and use it to signal post reset
    condition to the ide-tape driver (the only user of ->pre_reset).

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/03/10 1.2013)
    [ide] fix some rare ide-default vs ide-disk races

    Some rare races between ide-default and ide-disk are possible, i.e.:
    * ide-default is used, I/O request is triggered (ie. /proc/ide/hd?/identify),
      drive->special is cleared silently (so CHS is not initialized properly),
      ide-disk is loaded and fails if drive uses CHS
    * ide-disk is used, drive is resetted, ide-disk is unloaded, ide-default
      takes control over drive and on the first I/O request silently clears
      drive->special without restoring settings

    Fix them by moving idedisk_{special,pre_reset}() and company to IDE core.

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/03/10 1.2012)
    [ide] generic Power Management for IDE devices

    Move PM code from ide-cd.c and ide-disk.c to IDE core so:
    * PM is supported for other ATAPI devices (floppy, tape)
    * PM is supported even if specific driver is not loaded

    Also s/HWIF(drive)/drive->hwif/ while at it.

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/03/10 1.2011)
    [ide] fix drive->ready_stat for ATAPI

    ATAPI devices ignore DRDY bit so drive->ready_stat must be set to zero.
    It is currently done by device drivers (including ide-default fake driver)
    but for PMAC driver it is too late as wait_for_ready() may be called during
    probe: probe_hwif()->pmac_ide_dma_check()->pmac_ide_{mdma,udma}_enable()->
    ->pmac_ide_do_setfeature()->wait_for_ready().

    Fixup drive->ready_stat just after detecting ATAPI device.

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bram.verweij@wanadoo.nl> (05/03/10 1.2010)
    [ide] fix DMA support for LBA48 disks on ALi15x3 (revs < 0xC5)

    From: Bram Verweij <bram.verweij@wanadoo.nl>

    The problem seems to be that ide-disk.c tries to use PIO mode for
    blocks > 137 GB (which is good), and LBA48 + DMA for blocks <= 137GB
    (which is known to be a problem, i.e., this is why the no_lba48_dma
    field was introduced in the first place).  Attached is a small patch
    that makes ide-disk.c use PIO mode for blocks > 137 GB, and LBA28 DMA
    (instead of LBA48 DMA) for blocks <= 137 GB.

    bart: argh, I forgot about 'lba48' flag; patch slightly modified by me

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

