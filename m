Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVEZQQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVEZQQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 12:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVEZQQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 12:16:06 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:27597 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261594AbVEZQPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 12:15:52 -0400
Date: Thu, 26 May 2005 17:47:55 +0200 (CEST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] IDE update for 2.6.12-rc5
Message-ID: <Pine.GSO.4.62.0505261736540.8626@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

First git based update, I hope I got it right.
Also there should be no more looong delays...

Bartlomiej

Please pull from:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/bart/ide-2.6.git

diffstat and changelog below:

  drivers/ide/ide-cd.c     |   47 ++-----
  drivers/ide/ide-disk.c   |   41 ++----
  drivers/ide/ide-floppy.c |   42 ++----
  drivers/ide/ide-probe.c  |   51 +++++++
  drivers/ide/ide-proc.c   |   52 +++++++
  drivers/ide/ide-tape.c   |   51 ++-----
  drivers/ide/ide.c        |  307 
+++--------------------------------------------
  drivers/scsi/ide-scsi.c  |   86 +++++++------
  include/linux/ide.h      |   20 ---
  9 files changed, 242 insertions(+), 455 deletions(-)


commit 284e423811495f632a7a334b2b93caba07d4f778
tree 1cf1ad8edfa13f7ea1e97ac11dbb023de45b10b6
parent 41bb4c43b34bcde7eb62cf19acdcf9f2eb13801d
author Marcello Maggioni <hayarms@gmail.com> Thu, 26 May 2005 15:47:35 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Thu, 26 May 2005 15:47:35 +0200

[PATCH] timeout at boottime with NEC3500A (and possibly others) when inserted a CD in it

From: Marcello Maggioni <hayarms@gmail.com>

Problem: Some drives (NEC 3500, TDK 1616N, Mad-dog MD-16XDVD9, RICOH
MP5163DA, Memorex DVD9 drive and IO-DATA's too for sure), if a
CD/DVD is inserted into the tray when the system is booted and if
before the OS bootup the BIOS checked for the presence of a bootable
CD/DVD into the drive, during the IDE probe phase the drive may
result busy and remain so for the next 25/30 seconds . This cause the
drive to be skipped during the booting phase and not begin usable
until the next reboot (if the reboot goes well and the drive doesn't
timeout again).

Solution: Rising the timeout time from 10 seconds to 35 seconds
(during these 35 seconds every drive should wake up for sure
according to the tests I've done).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit 41bb4c43b34bcde7eb62cf19acdcf9f2eb13801d
tree cfaeeca6836443ee680e38273cb4f7ae94c023b2
parent 8604affde9d4f52f04342d6a37c77d95fa167e7a
author Stuart Hayes <Stuart_Hayes@dell.com> Thu, 26 May 2005 15:38:45 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Thu, 26 May 2005 15:38:45 +0200

[PATCH] ide-scsi: kmap scatter/gather before doing PIO

From: Stuart Hayes <Stuart_Hayes@dell.com>

The system can panic with a null pointer dereference using ide-scsi if
PIO is being done on scatter gather pages that are in high memory,
because page_address() returns 0.  We are actually seeing this using a
tape drive.  This patch will kmap_atomic() the pages before performing
PIO.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
commit 8604affde9d4f52f04342d6a37c77d95fa167e7a
tree 12143c1be244c69c7c2b488a34856f60d0625e03
parent bef9c558841604116704e10b3d9ff3dbf4939423
author Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Thu, 26 May 2005 14:55:34 +0200
committer Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> Thu, 26 May 2005 14:55:34 +0200

[PATCH] convert IDE device drivers to driver-model

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

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
--------------------------
