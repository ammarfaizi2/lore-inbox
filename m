Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVCKGaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVCKGaD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 01:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbVCKGaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 01:30:03 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:4254 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262564AbVCKG3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 01:29:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=meg0AH1ZThV3q0fytA+mIhc0SnatAgKCmFkHGya/dXs5gK+KqzjqyFpY15MinUdlHkZKXZTtRu7EqGHy1uS6IkjmXqXXSgcHoqBxYCRqjd4sa1U9JEiqYQ12P1d/sNYVWwwCJ0lsboESesqMyR7ALvCMJp/VsRpT5aNwWO6Vai4=
Date: Fri, 11 Mar 2005 15:29:08 +0900
From: Tejun Heo <htejun@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ide: hdio.txt update
Message-ID: <20050311062908.GA11552@htj.dyndns.org>
References: <20050302235457.GA21352@htj.dyndns.org> <20050303021638.GA24150@htj.dyndns.org> <58cb370e05031008307a0163c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e05031008307a0163c1@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Greetings Bartlomiej,

 I've updated the following

 * in_flags modification when out_flags != 0 && in_flags == 0
 * more than one -> one or more than one
 * tf_{in|out}_flags -> {in|out}_flags as tf_* are in-kernel names

 I'll update the taskfile patch series after receiving your comments
about the patches.  Also, if you have a big picture for the IDE
driver, do you care to spill?  What I have in mind now are

 1. Completion-based taskfile (no direct ending/error handling of
    requests), so that we can use it for specials/rw_disk/eh/etc...
 2. Make specials (set_geometry, set_multmode...) more regular.
 3. Do error-handling/resetting in a exception handler thread.
    Maybe this and #2 should happen together.

 So, please let me know what you think.  Updated patch for hdio.txt
follows.


 This patch updates Documentation/ioctl/hdio.txt to include more
detailed descriptions about HDIO_DRIVE_{CMD|TASK|TASKFILE} ioctls.

 Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: linux-taskfile-ng/Documentation/ioctl/hdio.txt
===================================================================
--- linux-taskfile-ng.orig/Documentation/ioctl/hdio.txt	2005-03-11 15:10:59.068016786 +0900
+++ linux-taskfile-ng/Documentation/ioctl/hdio.txt	2005-03-11 15:27:32.718915939 +0900
@@ -573,26 +573,43 @@ HDIO_DRIVE_TASKFILE		execute raw taskfil
 	  EFAULT	req_cmd == TASKFILE_IN_OUT (not implemented as of 2.6.8)
 	  EPERM		req_cmd == TASKFILE_MULTI_OUT and drive
 	  		multi-count not yet set.
-
+	  EIO		Drive failed the command.
 
 	notes:
 
-	  [1] Currently (2.6.8), both the input and output buffers are
-	  copied from the user and written back to the user, even when
-	  not used.  This may be a bug.
-
-	  [2] The out_flags and in_flags are returned to the user after
-	  the ioctl completes.	Currently (2.6.8) these are the same
-	  as the input values, unchanged.  In the future, they may have
-	  more significance.
-
-	  Extreme caution should be used with using this ioctl.  A
-	  mistake can easily corrupt data or hang the system.
-
-	  The argument to the ioctl is a pointer to a region of memory
-	  containing a ide_task_request_t structure, followed by an
-	  optional buffer of data to be transmitted to the drive,
-	  followed by an optional buffer to receive data from the drive.
+	  [1] READ THE FOLLOWING NOTES *CAREFULLY*.  THIS IOCTL IS
+	  FULL OF GOTCHAS.  Extreme caution should be used with using
+	  this ioctl.  A mistake can easily corrupt data or hang the
+	  system.
+
+	  [2] Both the input and output buffers are copied from the
+	  user and written back to the user, even when not used.
+
+	  [3] If one or more bits are set in out_flags and in_flags is
+	  zero, the following values are used for in_flags.all and
+	  written back into in_flags on completion.
+
+	   * IDE_TASKFILE_STD_IN_FLAGS | (IDE_HOB_STD_IN_FLAGS << 8)
+	     if LBA48 addressing is enabled for the drive
+	   * IDE_TASKFILE_STD_IN_FLAGS
+	     if CHS/LBA28
+
+	  The association between in_flags.all and each enable
+	  bitfield flips depending on endianess; fortunately, TASKFILE
+	  only uses inflags.b.data bit and ignores all other bits.
+	  The end result is that, on any endian machines, it has no
+	  effect other than modifying in_flags on completion.
+
+	  [4] The default value of SELECT is (0xa0|DEV_bit|LBA_bit)
+	  except for four drives per port chipsets.  For four drives
+	  per port chipsets, it's (0xa0|DEV_bit|LBA_bit) for the first
+	  pair and (0x80|DEV_bit|LBA_bit) for the second pair.
+
+	  [5] The argument to the ioctl is a pointer to a region of
+	  memory containing a ide_task_request_t structure, followed
+	  by an optional buffer of data to be transmitted to the
+	  drive, followed by an optional buffer to receive data from
+	  the drive.
 
 	  Command is passed to the disk drive via the ide_task_request_t
 	  structure, which contains these fields:
@@ -611,11 +628,66 @@ HDIO_DRIVE_TASKFILE		execute raw taskfil
 	    out_size		output (user->drive) buffer size, bytes
 	    in_size		input (drive->user) buffer size, bytes
 
-	  This ioctl does not necessarily respect all flags in the
-	  out_flags and in_flags values -- some taskfile registers
-	  may be written or read even if not requested in the flags.
-	  Unused fields of io_ports[] and hob_ports[] should be set
-	  to zero.
+	  When out_flags is zero, the following registers are loaded.
+
+	    HOB_FEATURE		If the drive supports LBA48
+	    HOB_NSECTOR		If the drive supports LBA48
+	    HOB_SECTOR		If the drive supports LBA48
+	    HOB_LCYL		If the drive supports LBA48
+	    HOB_HCYL		If the drive supports LBA48
+	    FEATURE
+	    NSECTOR
+	    SECTOR
+	    LCYL
+	    HCYL
+	    SELECT		First, masked with 0xE0 if LBA48, 0xEF
+				otherwise; then, or'ed with the default
+				value of SELECT.
+
+	  If any bit in out_flags is set, the following registers are loaded.
+
+	    HOB_DATA		If out_flags.b.data is set.  HOB_DATA will
+				travel on DD8-DD15 on little endian machines
+				and on DD0-DD7 on big endian machines.
+	    DATA		If out_flags.b.data is set.  DATA will
+				travel on DD0-DD7 on little endian machines
+				and on DD8-DD15 on big endian machines.
+	    HOB_NSECTOR		If out_flags.b.nsector_hob is set
+	    HOB_SECTOR		If out_flags.b.sector_hob is set
+	    HOB_LCYL		If out_flags.b.lcyl_hob is set
+	    HOB_HCYL		If out_flags.b.hcyl_hob is set
+	    FEATURE		If out_flags.b.feature is set
+	    NSECTOR		If out_flags.b.nsector is set
+	    SECTOR		If out_flags.b.sector is set
+	    LCYL		If out_flags.b.lcyl is set
+	    HCYL		If out_flags.b.hcyl is set
+	    SELECT		Or'ed with the default value of SELECT and
+				loaded regardless of out_flags.b.select.
+
+	  Taskfile registers are read back from the drive into
+	  {io|hob}_ports[] after the command completes iff one of the
+	  following conditions is met; otherwise, the original values
+	  will be written back, unchanged.
+
+	    1. The drive fails the command (EIO).
+	    2. One or more than one bits are set in out_flags.
+	    3. The requested data_phase is TASKFILE_NO_DATA.
+
+	    HOB_DATA		If in_flags.b.data is set.  It will contain
+				DD8-DD15 on little endian machines and
+				DD0-DD7 on big endian machines.
+	    DATA		If in_flags.b.data is set.  It will contain
+				DD0-DD7 on little endian machines and
+				DD8-DD15 on big endian machines.
+	    HOB_FEATURE		If the drive supports LBA48
+	    HOB_NSECTOR		If the drive supports LBA48
+	    HOB_SECTOR		If the drive supports LBA48
+	    HOB_LCYL		If the drive supports LBA48
+	    HOB_HCYL		If the drive supports LBA48
+	    NSECTOR
+	    SECTOR
+	    LCYL
+	    HCYL
 
 	  The data_phase field describes the data transfer to be
 	  performed.  Value is one of:
@@ -626,27 +698,30 @@ HDIO_DRIVE_TASKFILE		execute raw taskfil
 	    TASKFILE_MULTI_OUT
 	    TASKFILE_IN_OUT
 	    TASKFILE_IN_DMA
-	    TASKFILE_IN_DMAQ
+	    TASKFILE_IN_DMAQ		== IN_DMA (queueing not supported)
 	    TASKFILE_OUT_DMA
-	    TASKFILE_OUT_DMAQ
-	    TASKFILE_P_IN
-	    TASKFILE_P_IN_DMA
-	    TASKFILE_P_IN_DMAQ
-	    TASKFILE_P_OUT
-	    TASKFILE_P_OUT_DMA
-	    TASKFILE_P_OUT_DMAQ
+	    TASKFILE_OUT_DMAQ		== OUT_DMA (queueing not supported)
+	    TASKFILE_P_IN		unimplemented
+	    TASKFILE_P_IN_DMA		unimplemented
+	    TASKFILE_P_IN_DMAQ		unimplemented
+	    TASKFILE_P_OUT		unimplemented
+	    TASKFILE_P_OUT_DMA		unimplemented
+	    TASKFILE_P_OUT_DMAQ		unimplemented
 
 	  The req_cmd field classifies the command type.  It may be
 	  one of:
 
 	    IDE_DRIVE_TASK_NO_DATA
-	    IDE_DRIVE_TASK_SET_XFER
+	    IDE_DRIVE_TASK_SET_XFER	unimplemented
 	    IDE_DRIVE_TASK_IN
-	    IDE_DRIVE_TASK_OUT
+	    IDE_DRIVE_TASK_OUT		unimplemented
 	    IDE_DRIVE_TASK_RAW_WRITE
 
-
-
+	  [6] Do not access {in|out}_flags->all except for resetting
+	  all the bits.  Always access individual bit fields.  ->all
+	  value will flip depending on endianess.  For the same
+	  reason, do not use IDE_{TASKFILE|HOB}_STD_{OUT|IN}_FLAGS
+	  constants defined in hdreg.h.
 
 
 
@@ -663,7 +738,13 @@ HDIO_DRIVE_CMD			execute a special drive
 
 	inputs:
 
-	  Taskfile register values:
+	  Commands other than WIN_SMART
+	    args[0]	COMMAND
+	    args[1]	NSECTOR
+	    args[2]	FEATURE
+	    args[3]	NSECTOR
+
+	  WIN_SMART
 	    args[0]	COMMAND
 	    args[1]	SECTOR
 	    args[2]	FEATURE
@@ -682,11 +763,28 @@ HDIO_DRIVE_CMD			execute a special drive
 	error returns:
 	  EACCES	Access denied:  requires CAP_SYS_RAWIO
 	  ENOMEM	Unable to allocate memory for task
+	  EIO		Drive reports error
 
 	notes:
 
-	  Taskfile registers IDE_LCYL, IDE_HCYL, and IDE_SELECT are
-	  set to zero before executing the command.
+	  [1] For commands other than WIN_SMART, args[1] should equal
+	  args[3].  SECTOR, LCYL and HCYL are undefined.  For
+	  WIN_SMART, 0x4f and 0xc2 are loaded into LCYL and HCYL
+	  respectively.  In both cases SELECT will contain the default
+	  value for the drive.  Please refer to HDIO_DRIVE_TASKFILE
+	  notes for the default value of SELECT.
+
+	  [2] If NSECTOR value is greater than zero and the drive sets
+	  DRQ when interrupting for the command, NSECTOR * 512 bytes
+	  are read from the device into the area following NSECTOR.
+	  In the above example, the area would be
+	  args[4..4+XFER_SIZE].  16bit PIO is used regardless of
+	  HDIO_SET_32BIT setting.
+
+	  [3] If COMMAND == WIN_SETFEATURES && FEATURE == SETFEATURES_XFER
+	  && NSECTOR >= XFER_SW_DMA_0 && the drive supports any DMA
+	  mode, IDE driver will try to tune the transfer mode of the
+	  drive accordingly.
 
 
 
@@ -726,7 +824,14 @@ HDIO_DRIVE_TASK			execute task and speci
 	error returns:
 	  EACCES	Access denied:  requires CAP_SYS_RAWIO
 	  ENOMEM	Unable to allocate memory for task
+	  ENOMSG	Device is not a disk drive.
+	  EIO		Drive failed the command.
+
+	notes:
 
+	  [1] DEV bit (0x10) of SELECT register is ignored and the
+	  appropriate value for the drive is used.  All other bits
+	  are used unaltered.
 
 
 
