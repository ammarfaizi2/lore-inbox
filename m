Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbULJTsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbULJTsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 14:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbULJTsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 14:48:04 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:33438 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261808AbULJTqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 14:46:37 -0500
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [BK PATCHES] ide-2.6 update
Date: Fri, 10 Dec 2004 20:40:25 +0100
User-Agent: KMail/1.7.1
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412102040.25133.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Just a bunch of bugfixes.

Please do a

 bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 Documentation/ioctl/cdrom.txt  |   57 ++++++++++++++++++++++++-------
 Documentation/ioctl/hdio.txt   |   74 ++++++++++++++++++++++++-----------------
 drivers/ide/ide-cd.c           |    8 +++-
 drivers/ide/ide-dma.c          |    2 -
 drivers/ide/ide-probe.c        |    3 -
 drivers/ide/legacy/ali14xx.c   |    2 +
 drivers/ide/legacy/dtc2278.c   |    2 +
 drivers/ide/legacy/ht6560b.c   |    2 +
 drivers/ide/legacy/qd65xx.c    |    7 +++
 drivers/ide/legacy/umc8672.c   |    2 +
 drivers/ide/pci/alim15x3.c     |    7 ++-
 drivers/ide/pci/atiixp.c       |    1 
 drivers/ide/pci/pdc202xx_old.c |    2 -
 include/linux/pci_ids.h        |    2 +
 14 files changed, 120 insertions(+), 51 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/12/10 1.2189)
   [ide] remove obsolete comment from ide-probe.c
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/10 1.2188)
   [ide] fix creating of /proc/ide/ entries for legacy VLB modules
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/10 1.2187)
   [ide] final polish on disk ioctl documentation
   
   From: Edward Falk <efalk@google.com>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/10 1.2186)
   [ide] ide-cd: fix possible race in PIO mode
   
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   
   When we issue an ide command the status bits don't become valid for
   400nS. In the DMA case ide_execute_command handles this but in the PIO
   case we don't do the needed locking, use OUTBSYNC to avoid posting or
   delay. This means that in some situations we can execute the command
   handler in PIO mode before the command status bits are valid and the
   handler may read and act wrongly.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/10 1.2185)
   [ide] alim15x3: add support for ULi M5228
   
   From: Clear Zhang <Clear.Zhang@uli.com.tw>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/10 1.2184)
   [ide] atiixp: add new PCI identifier
   
   From: Pascal Lengard <lklm@lengard.net>
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/10 1.2183)
   [ide] pdc202xx_old: fix cable detection
   
   pdc202xx_old_cable_detect() always returns '0' (which means 80c cable)
   due to a sloppy coding - result of CIS & mask is truncated to 8 bits
   although CIS holds cable info in bits 10-11.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/10 1.2182)
   [ide] remove SAMSUNG CD-ROM SC-148F from the DMA blacklist
   
   Reported to work OK by Alexander E. Patrakov <patrakov@ums.usu.ru>.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (04/12/10 1.2181)
   [ide] remove PLEXTOR CD-R PX-W8432T from the DMA blacklist
   
   Reported to work OK by Junio C Hamano <junkio@cox.net>,
   DervishD <lkml@dervishd.net> and Anton <_xman_@mail.ru>.
   
   Fixes bugzilla bug #3730.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/Documentation/ioctl/cdrom.txt b/Documentation/ioctl/cdrom.txt
--- a/Documentation/ioctl/cdrom.txt 2004-12-10 20:16:48 +01:00
+++ b/Documentation/ioctl/cdrom.txt 2004-12-10 20:16:48 +01:00
@@ -34,7 +34,7 @@
       (struct cdrom_multisession)
  CDROM_GET_MCN  Obtain the "Universal Product Code"
        if available (struct cdrom_mcn)
- CDROM_GET_UPC  CDROM_GET_MCN  (deprecated)
+ CDROM_GET_UPC  Deprecated, use CDROM_GET_MCN instead.
  CDROMRESET  hard-reset the drive
  CDROMVOLREAD  Get the drive's volume setting
        (struct cdrom_volctrl)
@@ -44,8 +44,8 @@
  CDROMSEEK  seek msf address
  CDROMPLAYBLK  scsi-cd only, (struct cdrom_blk)
  CDROMREADALL  read all 2646 bytes
- CDROMGETSPINDOWN
- CDROMSETSPINDOWN
+ CDROMGETSPINDOWN return 4-bit spindown value
+ CDROMSETSPINDOWN set 4-bit spindown value
  CDROMCLOSETRAY  pendant of CDROMEJECT
  CDROM_SET_OPTIONS Set behavior options
  CDROM_CLEAR_OPTIONS Clear behavior options
@@ -79,10 +79,12 @@
 General:
 
  Unless otherwise specified, all ioctl calls return 0 on success
- and -1 with errno set to an appropriate value on error.
+ and -1 with errno set to an appropriate value on error.  (Some
+ ioctls return non-negative data values.)
 
- Unless otherwise specified, all ioctl calls return EFAULT on a
- failed attempt to copy data to or from user address space.
+ Unless otherwise specified, all ioctl calls return -1 and set
+ errno to EFAULT on a failed attempt to copy data to or from user
+ address space.
 
  Individual drivers may return error codes not listed here.
 
@@ -136,6 +138,9 @@
    ENOSYS cd drive not audio-capable.
 
  notes:
+   MSF stands for minutes-seconds-frames
+   LBA stands for logical block address
+
    Segment is described as start and end times, where each time
    is described as minutes:seconds:frames.  A frame is 1/75 of
    a second.
@@ -196,8 +201,11 @@
  error return:
    ENOSYS cd drive not audio-capable.
    EINVAL entry.cdte_format not CDROM_MSF or CDROM_LBA
+   EINVAL requested track out of bounds
+   EIO  I/O error reading TOC
 
  notes:
+   TOC stands for Table Of Contents
    MSF stands for minutes-seconds-frames
    LBA stands for logical block address
 
@@ -216,6 +224,10 @@
  error return:
    ENOSYS cd drive not audio-capable.
 
+ notes:
+   Exact interpretation of this ioctl depends on the device,
+   but most seem to spin the drive down.
+
 
 CDROMSTART   Start the cdrom drive
 
@@ -230,6 +242,11 @@
  error return:
    ENOSYS cd drive not audio-capable.
 
+ notes:
+   Exact interpretation of this ioctl depends on the device,
+   but most seem to spin the drive up and/or close the tray.
+   Other devices ignore the ioctl completely.
+
 
 CDROMEJECT   Ejects the cdrom media
 
@@ -241,9 +258,12 @@
 
  outputs: none
 
- error return:
+ error returns:
    ENOSYS cd drive not capable of ejecting
-   EBUSY  other processes have drive open or door is locked
+   EBUSY  other processes are accessing drive, or door is locked
+
+ notes:
+   See CDROM_LOCKDOOR, below.
 
 
 
@@ -257,9 +277,12 @@
 
  outputs: none
 
- error return:
+ error returns:
    ENOSYS cd drive not capable of ejecting
-   EBUSY  other processes have drive open or door is locked
+   EBUSY  other processes are accessing drive, or door is locked
+
+ notes:
+   See CDROM_LOCKDOOR, below.
 
 
 
@@ -577,7 +600,7 @@
 
  inputs:
    New values for drive options.  The logical 'or' of:
-     CDO_AUTO_CLOSE close tray on first open
+     CDO_AUTO_CLOSE close tray on first open(2)
      CDO_AUTO_EJECT open tray on last release
      CDO_USE_FFLAGS use O_NONBLOCK information on open
      CDO_LOCK  lock tray on open files
@@ -918,6 +941,10 @@
  outputs:
    The next writable block.
 
+ notes:
+   If the device does not support this ioctl directly, the
+   ioctl will return CDROM_LAST_WRITTEN + 7.
+
 
 
 CDROM_LAST_WRITTEN		get last block written on disc
@@ -925,11 +952,15 @@
 	usage:
 
 	  long last;
-	  ioctl(fd, CDROM_NEXT_WRITABLE, &last);
+	  ioctl(fd, CDROM_LAST_WRITTEN, &last);
 
 	inputs:		none
 
 	outputs:
 	  The last block written on disc
 
-
+ notes:
+   If the device does not support this ioctl directly, the
+   result is derived from the disc's table of contents.  If the
+   table of contents can't be read, this ioctl returns an
+   error.
diff -Nru a/Documentation/ioctl/hdio.txt b/Documentation/ioctl/hdio.txt
--- a/Documentation/ioctl/hdio.txt 2004-12-10 20:16:48 +01:00
+++ b/Documentation/ioctl/hdio.txt 2004-12-10 20:16:48 +01:00
@@ -28,7 +28,7 @@
  HDIO_GET_IDENTITY get IDE identification info
  HDIO_GET_WCACHE  get write cache mode on|off
  HDIO_GET_ACOUSTIC get acoustic value
- HDIO_GET_ADDRESS
+ HDIO_GET_ADDRESS get sector addressing mode
  HDIO_GET_BUSSTATE get the bus state of the hwif
  HDIO_TRISTATE_HWIF execute a channel tristate
  HDIO_DRIVE_RESET execute a device reset
@@ -55,8 +55,8 @@
  HDIO_SET_QDMA  change use-qdma flag
  HDIO_SET_ADDRESS change lba addressing modes
 
- HDIO_SET_IDE_SCSI
- HDIO_SET_SCSI_IDE
+ HDIO_SET_IDE_SCSI Set scsi emulation mode on/off
+ HDIO_SET_SCSI_IDE not implemented yet
 
 
 The information that follows was determined from reading kernel source
@@ -73,8 +73,9 @@
  Unless otherwise specified, all ioctl calls return 0 on success
  and -1 with errno set to an appropriate value on error.
 
- Unless otherwise specified, all ioctl calls return EFAULT on a
- failed attempt to copy data to or from user address space.
+ Unless otherwise specified, all ioctl calls return -1 and set
+ errno to EFAULT on a failed attempt to copy data to or from user
+ address space.
 
  Unless otherwise specified, all data structures and constants
 	are defined in <linux/hdreg.h>
@@ -145,7 +146,7 @@
 
 	usage:
 
-	  long val;
+	  unsigned long val;
 	  ioctl(fd, HDIO_SET_UNMASKINTR, val);
 
 	inputs:
@@ -204,7 +205,7 @@
 
 	    This is tightly woven into the driver->do_special can not
 	    touch.  DON'T do it again until a total personality rewrite
-	    is committed."
+	    is committed.
 
 	  If blockmode has already been set, this ioctl will fail with
 	  EBUSY
@@ -371,14 +372,12 @@
 
 	usage:
 
-   int nice;
+   unsigned long nice;
    ...
    ioctl(fd, HDIO_SET_NICE, nice);
 
  inputs:
-   args[0] io address to probe
-   args[1] control address to probe
-   args[2] irq number
+   bitmask of nice flags.
 
  outputs: none
 
@@ -392,6 +391,9 @@
    This ioctl sets the DSC_OVERLAP and NICE_1 flags from values
    provided by the user.
 
+   Nice flags are listed in <linux/hdreg.h>, starting with
+   IDE_NICE_DSC_OVERLAP.  These values represent shifts.
+
 
 
 
@@ -509,7 +511,7 @@
 
 	notes:
 
-	  Aborts any current command, prevent anything else from being
+	  Abort any current command, prevent anything else from being
    queued, execute a reset on the device, and issue BLKRRPART
    ioctl on the block device.
 
@@ -523,6 +525,10 @@
  Note:  If you don't have a copy of the ANSI ATA specification
  handy, you should probably ignore this ioctl.
 
+ Execute an ATA disk command directly by writing the "taskfile"
+ registers of the drive.  Requires ADMIN and RAWIO access
+ privileges.
+
  usage:
 
    struct {
@@ -541,27 +547,27 @@
 
    (See below for details on memory area passed to ioctl.)
 
-   io_ports[] values to be written to taskfile registers
-   hob_ports[] values to be written to taskfile registers
+   io_ports[8] values to be written to taskfile registers
+   hob_ports[8] high-order bytes, for extended commands.
    out_flags flags indicating which registers are valid
    in_flags flags indicating which registers should be returned
    data_phase see below
    req_cmd command type to be executed
    out_size size of output buffer
    outbuf buffer of data to be transmitted to disk
-   inbuf  buffer of data to be received from disk
+   inbuf  buffer of data to be received from disk (see [1])
 
  outputs:
 
    io_ports[] values returned in the taskfile registers
-   hob_ports[] values returned in the taskfile registers
-   out_flags flags indicating which registers are valid
+   hob_ports[] high-order bytes, for extended commands.
+   out_flags flags indicating which registers are valid (see [2])
    in_flags flags indicating which registers should be returned
-   outbuf buffer of data to be transmitted to disk
+   outbuf buffer of data to be transmitted to disk (see [1])
    inbuf  buffer of data to be received from disk
 
  error returns:
-   EACCES CAP_SYS_ADMIN or CAP_SYS_RAWIO privelege not set.
+   EACCES CAP_SYS_ADMIN or CAP_SYS_RAWIO privilege not set.
    ENOMSG Device is not a disk drive.
    ENOMEM Unable to allocate memory for task
    EFAULT req_cmd == TASKFILE_IN_OUT (not implemented as of 2.6.8)
@@ -571,9 +577,14 @@
 
  notes:
 
-   Execute an ATA disk command directly by writing the "taskfile"
-   registers of the drive.  Requires ADMIN and RAWIO access
-   privileges.
+   [1] Currently (2.6.8), both the input and output buffers are
+   copied from the user and written back to the user, even when
+   not used.  This may be a bug.
+
+   [2] The out_flags and in_flags are returned to the user after
+   the ioctl completes. Currently (2.6.8) these are the same
+   as the input values, unchanged.  In the future, they may have
+   more significance.
 
    Extreme caution should be used with using this ioctl.  A
    mistake can easily corrupt data or hang the system.
@@ -590,7 +601,7 @@
      hob_ports[8] high-order bytes, for extended commands
      out_flags  flags indicating which entries in the
         io_ports[] and hob_ports[] arrays
-    contain valid values.
+    contain valid values.  Type ide_reg_valid_t.
      in_flags  flags indicating which entries in the
         io_ports[] and hob_ports[] arrays
     are expected to contain valid values
@@ -600,8 +611,11 @@
      out_size  output (user->drive) buffer size, bytes
      in_size  input (drive->user) buffer size, bytes
 
-   Unused fields of io_ports[] and hob_ports[] should be set to
-   zero.
+   This ioctl does not necessarily respect all flags in the
+   out_flags and in_flags values -- some taskfile registers
+   may be written or read even if not requested in the flags.
+   Unused fields of io_ports[] and hob_ports[] should be set
+   to zero.
 
    The data_phase field describes the data transfer to be
    performed.  Value is one of:
@@ -631,10 +645,6 @@
      IDE_DRIVE_TASK_OUT
      IDE_DRIVE_TASK_RAW_WRITE
 
-   Currently (2.6.8), both the input and output buffers are
-   copied from the user and written back to the user, even when
-   not used.
-
 
 
 
@@ -666,11 +676,17 @@
      args[0] status
      args[1] error
      args[2] NSECTOR
+     args[3] undefined
+     args[4+] NSECTOR * 512 bytes of data returned by the command.
 
  error returns:
    EACCES Access denied:  requires CAP_SYS_RAWIO
    ENOMEM Unable to allocate memory for task
 
+ notes:
+
+   Taskfile registers IDE_LCYL, IDE_HCYL, and IDE_SELECT are
+   set to zero before executing the command.
 
 
 
diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c 2004-12-10 20:16:48 +01:00
+++ b/drivers/ide/ide-cd.c 2004-12-10 20:16:48 +01:00
@@ -890,8 +890,14 @@
   ide_execute_command(drive, WIN_PACKETCMD, handler, ATAPI_WAIT_PC, cdrom_timer_expiry);
   return ide_started;
  } else {
+  unsigned long flags;
+
   /* packet command */
-  HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
+  spin_lock_irqsave(&ide_lock, flags);
+  hwif->OUTBSYNC(drive, WIN_PACKETCMD, IDE_COMMAND_REG);
+  ndelay(400);
+  spin_unlock_irqrestore(&ide_lock, flags);
+
   return (*handler) (drive);
  }
 }
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c 2004-12-10 20:16:48 +01:00
+++ b/drivers/ide/ide-dma.c 2004-12-10 20:16:48 +01:00
@@ -131,11 +131,9 @@
  { "CD-ROM Drive/F5A", "ALL"  },
  { "WPI CDD-820",  "ALL"  },
  { "SAMSUNG CD-ROM SC-148C", "ALL"  },
- { "SAMSUNG CD-ROM SC-148F", "ALL"  },
  { "SAMSUNG CD-ROM SC", "ALL"  },
  { "SanDisk SDP3B-64" , "ALL"  },
  { "SAMSUNG CD-ROM SN-124", "ALL"  },
- { "PLEXTOR CD-R PX-W8432T", "ALL"  },
  { "ATAPI CD-ROM DRIVE 40X MAXIMUM", "ALL"  },
  { "_NEC DV5800A",               "ALL"           },  
  { NULL   , NULL  }
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c 2004-12-10 20:16:48 +01:00
+++ b/drivers/ide/ide-probe.c 2004-12-10 20:16:48 +01:00
@@ -1327,9 +1327,6 @@
  for (index = 0; index < MAX_HWIFS; ++index)
   probe[index] = !ide_hwifs[index].present;
 
- /*
-  * Probe for drives in the usual way.. CMOS/BIOS, then poke at ports
-  */
  for (index = 0; index < MAX_HWIFS; ++index)
   if (probe[index])
    probe_hwif(&ide_hwifs[index]);
diff -Nru a/drivers/ide/legacy/ali14xx.c b/drivers/ide/legacy/ali14xx.c
--- a/drivers/ide/legacy/ali14xx.c 2004-12-10 20:16:48 +01:00
+++ b/drivers/ide/legacy/ali14xx.c 2004-12-10 20:16:48 +01:00
@@ -226,6 +226,8 @@
  probe_hwif_init(hwif);
  probe_hwif_init(mate);
 
+ create_proc_ide_interfaces();
+
  return 0;
 }
 
diff -Nru a/drivers/ide/legacy/dtc2278.c b/drivers/ide/legacy/dtc2278.c
--- a/drivers/ide/legacy/dtc2278.c 2004-12-10 20:16:48 +01:00
+++ b/drivers/ide/legacy/dtc2278.c 2004-12-10 20:16:48 +01:00
@@ -141,6 +141,8 @@
  probe_hwif_init(hwif);
  probe_hwif_init(mate);
 
+ create_proc_ide_interfaces();
+
  return 0;
 }
 
diff -Nru a/drivers/ide/legacy/ht6560b.c b/drivers/ide/legacy/ht6560b.c
--- a/drivers/ide/legacy/ht6560b.c 2004-12-10 20:16:48 +01:00
+++ b/drivers/ide/legacy/ht6560b.c 2004-12-10 20:16:48 +01:00
@@ -352,6 +352,8 @@
  probe_hwif_init(hwif);
  probe_hwif_init(mate);
 
+ create_proc_ide_interfaces();
+
  return 0;
 
 release_region:
diff -Nru a/drivers/ide/legacy/qd65xx.c b/drivers/ide/legacy/qd65xx.c
--- a/drivers/ide/legacy/qd65xx.c 2004-12-10 20:16:48 +01:00
+++ b/drivers/ide/legacy/qd65xx.c 2004-12-10 20:16:48 +01:00
@@ -429,6 +429,9 @@
 
   qd_setup(hwif, base, config, QD6500_DEF_DATA, QD6500_DEF_DATA,
     &qd6500_tune_drive);
+
+  create_proc_ide_interfaces();
+
   return 1;
  }
 
@@ -459,6 +462,8 @@
      &qd6580_tune_drive);
    qd_write_reg(QD_DEF_CONTR,QD_CONTROL_PORT);
 
+   create_proc_ide_interfaces();
+
    return 1;
   } else {
    ide_hwif_t *mate;
@@ -476,6 +481,8 @@
      QD6580_DEF_DATA2, QD6580_DEF_DATA2,
      &qd6580_tune_drive);
    qd_write_reg(QD_DEF_CONTR,QD_CONTROL_PORT);
+
+   create_proc_ide_interfaces();
 
    return 0; /* no other qd65xx possible */
   }
diff -Nru a/drivers/ide/legacy/umc8672.c b/drivers/ide/legacy/umc8672.c
--- a/drivers/ide/legacy/umc8672.c 2004-12-10 20:16:48 +01:00
+++ b/drivers/ide/legacy/umc8672.c 2004-12-10 20:16:48 +01:00
@@ -161,6 +161,8 @@
  probe_hwif_init(hwif);
  probe_hwif_init(mate);
 
+ create_proc_ide_interfaces();
+
  return 0;
 }
 
diff -Nru a/drivers/ide/pci/alim15x3.c b/drivers/ide/pci/alim15x3.c
--- a/drivers/ide/pci/alim15x3.c 2004-12-10 20:16:48 +01:00
+++ b/drivers/ide/pci/alim15x3.c 2004-12-10 20:16:48 +01:00
@@ -8,6 +8,7 @@
  *  Copyright (C) 1998-2000 Andre Hedrick (andre@linux-ide.org)
  *  May be copied or modified under the terms of the GNU General Public License
  *  Copyright (C) 2002 Alan Cox <alan@redhat.com>
+ *  ALi (now ULi M5228) support by Clear Zhang <Clear.Zhang@ali.com.tw>
  *
  *  (U)DMA capable version of ali 1533/1543(C), 1535(D)
  *
@@ -799,8 +800,9 @@
  s8 irq_routing_table[] = { -1,  9, 3, 10, 4,  5, 7,  6,
           1, 11, 0, 12, 0, 14, 0, 15 };
  int irq = -1;
- 
- hwif->irq = hwif->channel ? 15 : 14;
+
+ if (hwif->pci_dev->device == PCI_DEVICE_ID_AL_M5229)
+  hwif->irq = hwif->channel ? 15 : 14;
 
  if (isa_dev) {
   /*
@@ -889,6 +891,7 @@
 
 static struct pci_device_id alim15x3_pci_tbl[] = {
  { PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5229, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+ { PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5228, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
  { 0, },
 };
 MODULE_DEVICE_TABLE(pci, alim15x3_pci_tbl);
diff -Nru a/drivers/ide/pci/atiixp.c b/drivers/ide/pci/atiixp.c
--- a/drivers/ide/pci/atiixp.c 2004-12-10 20:16:48 +01:00
+++ b/drivers/ide/pci/atiixp.c 2004-12-10 20:16:48 +01:00
@@ -347,6 +347,7 @@
 
 static struct pci_device_id atiixp_pci_tbl[] = {
  { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+ { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP2_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
  { 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
diff -Nru a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
--- a/drivers/ide/pci/pdc202xx_old.c 2004-12-10 20:16:48 +01:00
+++ b/drivers/ide/pci/pdc202xx_old.c 2004-12-10 20:16:48 +01:00
@@ -230,7 +230,7 @@
 {
  u16 CIS = 0, mask = (hwif->channel) ? (1<<11) : (1<<10);
  pci_read_config_word(hwif->pci_dev, 0x50, &CIS);
- return ((u8)(CIS & mask));
+ return (CIS & mask) ? 1 : 0;
 }
 
 /*
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h 2004-12-10 20:16:48 +01:00
+++ b/include/linux/pci_ids.h 2004-12-10 20:16:48 +01:00
@@ -344,6 +344,7 @@
 #define PCI_DEVICE_ID_ATI_RS300_200 0x5833
 /* ATI IXP Chipset */
 #define PCI_DEVICE_ID_ATI_IXP_IDE 0x4349
+#define PCI_DEVICE_ID_ATI_IXP2_IDE 0x4369 /* True name not yet sure */
 
 #define PCI_VENDOR_ID_VLSI  0x1004
 #define PCI_DEVICE_ID_VLSI_82C592 0x0005
@@ -1029,6 +1030,7 @@
 #define PCI_DEVICE_ID_AL_M3307  0x3307
 #define PCI_DEVICE_ID_AL_M4803  0x5215
 #define PCI_DEVICE_ID_AL_M5219  0x5219
+#define PCI_DEVICE_ID_AL_M5228  0x5228
 #define PCI_DEVICE_ID_AL_M5229  0x5229
 #define PCI_DEVICE_ID_AL_M5237  0x5237
 #define PCI_DEVICE_ID_AL_M5243  0x5243
