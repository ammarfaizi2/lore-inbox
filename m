Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbULJBJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbULJBJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 20:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbULJBJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 20:09:10 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:60970 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261704AbULJBIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 20:08:04 -0500
Message-ID: <41B8F6F1.4060406@google.com>
Date: Thu, 09 Dec 2004 17:08:01 -0800
From: Edward Falk <efalk@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041008
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] final polish on disk ioctl documentation
Content-Type: multipart/mixed;
 boundary="------------080605000209010601030004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080605000209010601030004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------080605000209010601030004
Content-Type: text/plain;
 name="patch-ioctl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ioctl"

diff -urpP linux-2.6.10-rc3-bk2/Documentation/ioctl/cdrom.txt linux-2.6.10-rc3-bk2-ioctl/Documentation/ioctl/cdrom.txt
--- linux-2.6.10-rc3-bk2/Documentation/ioctl/cdrom.txt	2004-12-07 16:15:29.000000000 -0800
+++ linux-2.6.10-rc3-bk2-ioctl/Documentation/ioctl/cdrom.txt	2004-12-09 16:59:15.000000000 -0800
@@ -34,7 +34,7 @@ are as follows:
 				  (struct cdrom_multisession)
 	CDROM_GET_MCN		Obtain the "Universal Product Code"
 				   if available (struct cdrom_mcn)
-	CDROM_GET_UPC		CDROM_GET_MCN  (deprecated)
+	CDROM_GET_UPC		Deprecated, use CDROM_GET_MCN instead.
 	CDROMRESET		hard-reset the drive
 	CDROMVOLREAD		Get the drive's volume setting
 					  (struct cdrom_volctrl)
@@ -44,8 +44,8 @@ are as follows:
 	CDROMSEEK		seek msf address
 	CDROMPLAYBLK		scsi-cd only, (struct cdrom_blk)
 	CDROMREADALL		read all 2646 bytes
-	CDROMGETSPINDOWN
-	CDROMSETSPINDOWN
+	CDROMGETSPINDOWN	return 4-bit spindown value
+	CDROMSETSPINDOWN	set 4-bit spindown value
 	CDROMCLOSETRAY		pendant of CDROMEJECT
 	CDROM_SET_OPTIONS	Set behavior options
 	CDROM_CLEAR_OPTIONS	Clear behavior options
@@ -79,10 +79,12 @@ code.  It is likely that some correction
 General:
 
 	Unless otherwise specified, all ioctl calls return 0 on success
-	and -1 with errno set to an appropriate value on error.
+	and -1 with errno set to an appropriate value on error.  (Some
+	ioctls return non-negative data values.)
 
-	Unless otherwise specified, all ioctl calls return EFAULT on a
-	failed attempt to copy data to or from user address space.
+	Unless otherwise specified, all ioctl calls return -1 and set
+	errno to EFAULT on a failed attempt to copy data to or from user
+	address space.
 
 	Individual drivers may return error codes not listed here.
 
@@ -136,6 +138,9 @@ CDROMPLAYMSF			Play Audio MSF (struct cd
 	  ENOSYS	cd drive not audio-capable.
 
 	notes:
+	  MSF stands for minutes-seconds-frames
+	  LBA stands for logical block address
+
 	  Segment is described as start and end times, where each time
 	  is described as minutes:seconds:frames.  A frame is 1/75 of
 	  a second.
@@ -196,8 +201,11 @@ CDROMREADTOCENTRY		Read TOC entry (struc
 	error return:
 	  ENOSYS	cd drive not audio-capable.
 	  EINVAL	entry.cdte_format not CDROM_MSF or CDROM_LBA
+	  EINVAL	requested track out of bounds
+	  EIO		I/O error reading TOC
 
 	notes:
+	  TOC stands for Table Of Contents
 	  MSF stands for minutes-seconds-frames
 	  LBA stands for logical block address
 
@@ -216,6 +224,10 @@ CDROMSTOP			Stop the cdrom drive
 	error return:
 	  ENOSYS	cd drive not audio-capable.
 
+	notes:
+	  Exact interpretation of this ioctl depends on the device,
+	  but most seem to spin the drive down.
+
 
 CDROMSTART			Start the cdrom drive
 
@@ -230,6 +242,11 @@ CDROMSTART			Start the cdrom drive
 	error return:
 	  ENOSYS	cd drive not audio-capable.
 
+	notes:
+	  Exact interpretation of this ioctl depends on the device,
+	  but most seem to spin the drive up and/or close the tray.
+	  Other devices ignore the ioctl completely.
+
 
 CDROMEJECT			Ejects the cdrom media
 
@@ -241,9 +258,12 @@ CDROMEJECT			Ejects the cdrom media
 
 	outputs:	none
 
-	error return:
+	error returns:
 	  ENOSYS	cd drive not capable of ejecting
-	  EBUSY		other processes have drive open or door is locked
+	  EBUSY		other processes are accessing drive, or door is locked
+
+	notes:
+	  See CDROM_LOCKDOOR, below.
 
 
 
@@ -257,9 +277,12 @@ CDROMCLOSETRAY			pendant of CDROMEJECT
 
 	outputs:	none
 
-	error return:
+	error returns:
 	  ENOSYS	cd drive not capable of ejecting
-	  EBUSY		other processes have drive open or door is locked
+	  EBUSY		other processes are accessing drive, or door is locked
+
+	notes:
+	  See CDROM_LOCKDOOR, below.
 
 
 
@@ -577,7 +600,7 @@ CDROM_SET_OPTIONS		Set behavior options
 
 	inputs:
 	  New values for drive options.  The logical 'or' of:
-	    CDO_AUTO_CLOSE	close tray on first open
+	    CDO_AUTO_CLOSE	close tray on first open(2)
 	    CDO_AUTO_EJECT	open tray on last release
 	    CDO_USE_FFLAGS	use O_NONBLOCK information on open
 	    CDO_LOCK		lock tray on open files
@@ -918,6 +941,10 @@ CDROM_NEXT_WRITABLE		get next writable b
 	outputs:
 	  The next writable block.
 
+	notes:
+	  If the device does not support this ioctl directly, the
+	  ioctl will return CDROM_LAST_WRITTEN + 7.
+
 
 
 CDROM_LAST_WRITTEN		get last block written on disc
@@ -925,11 +952,15 @@ CDROM_LAST_WRITTEN		get last block writt
 	usage:
 
 	  long last;
-	  ioctl(fd, CDROM_NEXT_WRITABLE, &last);
+	  ioctl(fd, CDROM_LAST_WRITTEN, &last);
 
 	inputs:		none
 
 	outputs:
 	  The last block written on disc
 
-
+	notes:
+	  If the device does not support this ioctl directly, the
+	  result is derived from the disc's table of contents.  If the
+	  table of contents can't be read, this ioctl returns an
+	  error.
diff -urpP linux-2.6.10-rc3-bk2/Documentation/ioctl/hdio.txt linux-2.6.10-rc3-bk2-ioctl/Documentation/ioctl/hdio.txt
--- linux-2.6.10-rc3-bk2/Documentation/ioctl/hdio.txt	2004-12-07 16:15:29.000000000 -0800
+++ linux-2.6.10-rc3-bk2-ioctl/Documentation/ioctl/hdio.txt	2004-12-09 17:03:06.000000000 -0800
@@ -28,7 +28,7 @@ are as follows:
 	HDIO_GET_IDENTITY	get IDE identification info
 	HDIO_GET_WCACHE		get write cache mode on|off
 	HDIO_GET_ACOUSTIC	get acoustic value
-	HDIO_GET_ADDRESS
+	HDIO_GET_ADDRESS	get sector addressing mode
 	HDIO_GET_BUSSTATE	get the bus state of the hwif
 	HDIO_TRISTATE_HWIF	execute a channel tristate
 	HDIO_DRIVE_RESET	execute a device reset
@@ -55,8 +55,8 @@ are as follows:
 	HDIO_SET_QDMA		change use-qdma flag
 	HDIO_SET_ADDRESS	change lba addressing modes
 
-	HDIO_SET_IDE_SCSI
-	HDIO_SET_SCSI_IDE
+	HDIO_SET_IDE_SCSI	Set scsi emulation mode on/off
+	HDIO_SET_SCSI_IDE	not implemented yet
 
 
 The information that follows was determined from reading kernel source
@@ -73,8 +73,9 @@ General:
 	Unless otherwise specified, all ioctl calls return 0 on success
 	and -1 with errno set to an appropriate value on error.
 
-	Unless otherwise specified, all ioctl calls return EFAULT on a
-	failed attempt to copy data to or from user address space.
+	Unless otherwise specified, all ioctl calls return -1 and set
+	errno to EFAULT on a failed attempt to copy data to or from user
+	address space.
 
 	Unless otherwise specified, all data structures and constants
 	are defined in <linux/hdreg.h>
@@ -145,7 +146,7 @@ HDIO_SET_UNMASKINTR		permit other irqs d
 
 	usage:
 
-	  long val;
+	  unsigned long val;
 	  ioctl(fd, HDIO_SET_UNMASKINTR, val);
 
 	inputs:
@@ -204,7 +205,7 @@ HDIO_SET_MULTCOUNT		change IDE blockmode
 
 	    This is tightly woven into the driver->do_special can not
 	    touch.  DON'T do it again until a total personality rewrite
-	    is committed."
+	    is committed.
 
 	  If blockmode has already been set, this ioctl will fail with
 	  EBUSY
@@ -371,14 +372,12 @@ HDIO_SET_NICE			set nice flags
 
 	usage:
 
-	  int nice;
+	  unsigned long nice;
 	  ...
 	  ioctl(fd, HDIO_SET_NICE, nice);
 
 	inputs:
-	  args[0]	io address to probe
-	  args[1]	control address to probe
-	  args[2]	irq number
+	  bitmask of nice flags.
 
 	outputs:	none
 
@@ -392,6 +391,9 @@ HDIO_SET_NICE			set nice flags
 	  This ioctl sets the DSC_OVERLAP and NICE_1 flags from values
 	  provided by the user.
 
+	  Nice flags are listed in <linux/hdreg.h>, starting with
+	  IDE_NICE_DSC_OVERLAP.  These values represent shifts.
+
 
 
 
@@ -509,7 +511,7 @@ HDIO_DRIVE_RESET		execute a device reset
 
 	notes:
 
-	  Aborts any current command, prevent anything else from being
+	  Abort any current command, prevent anything else from being
 	  queued, execute a reset on the device, and issue BLKRRPART
 	  ioctl on the block device.
 
@@ -523,6 +525,10 @@ HDIO_DRIVE_TASKFILE		execute raw taskfil
 	Note:  If you don't have a copy of the ANSI ATA specification
 	handy, you should probably ignore this ioctl.
 
+	Execute an ATA disk command directly by writing the "taskfile"
+	registers of the drive.  Requires ADMIN and RAWIO access
+	privileges.
+
 	usage:
 
 	  struct {
@@ -541,27 +547,27 @@ HDIO_DRIVE_TASKFILE		execute raw taskfil
 
 	  (See below for details on memory area passed to ioctl.)
 
-	  io_ports[]	values to be written to taskfile registers
-	  hob_ports[]	values to be written to taskfile registers
+	  io_ports[8]	values to be written to taskfile registers
+	  hob_ports[8]	high-order bytes, for extended commands.
 	  out_flags	flags indicating which registers are valid
 	  in_flags	flags indicating which registers should be returned
 	  data_phase	see below
 	  req_cmd	command type to be executed
 	  out_size	size of output buffer
 	  outbuf	buffer of data to be transmitted to disk
-	  inbuf		buffer of data to be received from disk
+	  inbuf		buffer of data to be received from disk (see [1])
 
 	outputs:
 
 	  io_ports[]	values returned in the taskfile registers
-	  hob_ports[]	values returned in the taskfile registers
-	  out_flags	flags indicating which registers are valid
+	  hob_ports[]	high-order bytes, for extended commands.
+	  out_flags	flags indicating which registers are valid (see [2])
 	  in_flags	flags indicating which registers should be returned
-	  outbuf	buffer of data to be transmitted to disk
+	  outbuf	buffer of data to be transmitted to disk (see [1])
 	  inbuf		buffer of data to be received from disk
 
 	error returns:
-	  EACCES	CAP_SYS_ADMIN or CAP_SYS_RAWIO privelege not set.
+	  EACCES	CAP_SYS_ADMIN or CAP_SYS_RAWIO privilege not set.
 	  ENOMSG	Device is not a disk drive.
 	  ENOMEM	Unable to allocate memory for task
 	  EFAULT	req_cmd == TASKFILE_IN_OUT (not implemented as of 2.6.8)
@@ -571,9 +577,14 @@ HDIO_DRIVE_TASKFILE		execute raw taskfil
 
 	notes:
 
-	  Execute an ATA disk command directly by writing the "taskfile"
-	  registers of the drive.  Requires ADMIN and RAWIO access
-	  privileges.
+	  [1] Currently (2.6.8), both the input and output buffers are
+	  copied from the user and written back to the user, even when
+	  not used.  This may be a bug.
+
+	  [2] The out_flags and in_flags are returned to the user after
+	  the ioctl completes.	Currently (2.6.8) these are the same
+	  as the input values, unchanged.  In the future, they may have
+	  more significance.
 
 	  Extreme caution should be used with using this ioctl.  A
 	  mistake can easily corrupt data or hang the system.
@@ -590,7 +601,7 @@ HDIO_DRIVE_TASKFILE		execute raw taskfil
 	    hob_ports[8]	high-order bytes, for extended commands
 	    out_flags		flags indicating which entries in the
 	    			io_ports[] and hob_ports[] arrays
-				contain valid values.
+				contain valid values.  Type ide_reg_valid_t.
 	    in_flags		flags indicating which entries in the
 	    			io_ports[] and hob_ports[] arrays
 				are expected to contain valid values
@@ -600,8 +611,11 @@ HDIO_DRIVE_TASKFILE		execute raw taskfil
 	    out_size		output (user->drive) buffer size, bytes
 	    in_size		input (drive->user) buffer size, bytes
 
-	  Unused fields of io_ports[] and hob_ports[] should be set to
-	  zero.
+	  This ioctl does not necessarily respect all flags in the
+	  out_flags and in_flags values -- some taskfile registers
+	  may be written or read even if not requested in the flags.
+	  Unused fields of io_ports[] and hob_ports[] should be set
+	  to zero.
 
 	  The data_phase field describes the data transfer to be
 	  performed.  Value is one of:
@@ -631,10 +645,6 @@ HDIO_DRIVE_TASKFILE		execute raw taskfil
 	    IDE_DRIVE_TASK_OUT
 	    IDE_DRIVE_TASK_RAW_WRITE
 
-	  Currently (2.6.8), both the input and output buffers are
-	  copied from the user and written back to the user, even when
-	  not used.
-
 
 
 
@@ -666,11 +676,17 @@ HDIO_DRIVE_CMD			execute a special drive
 	    args[0]	status
 	    args[1]	error
 	    args[2]	NSECTOR
+	    args[3]	undefined
+	    args[4+]	NSECTOR * 512 bytes of data returned by the command.
 
 	error returns:
 	  EACCES	Access denied:  requires CAP_SYS_RAWIO
 	  ENOMEM	Unable to allocate memory for task
 
+	notes:
+
+	  Taskfile registers IDE_LCYL, IDE_HCYL, and IDE_SELECT are
+	  set to zero before executing the command.
 
 
 

--------------080605000209010601030004--
