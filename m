Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbTD1VgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 17:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbTD1VgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 17:36:16 -0400
Received: from air-2.osdl.org ([65.172.181.6]:54503 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261315AbTD1VgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 17:36:08 -0400
Date: Mon, 28 Apr 2003 14:48:33 -0700
From: Dave Olien <dmo@osdl.org>
To: hch@verein.lst.de, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DAC960 patch to entry points with a new fix
Message-ID: <20030428214833.GA1450@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, Christoph,

Christoph submitted a patch to linus last week fixing up some DAC960 driver
entry points.  That patch will OOPS during boot on version 2 controller
types.  Christoph's version of the disk_size() function was dereferencing
a NULL pointer in it's "else" clause.

Christoph's patch hasn't appeared in linus's BK tree yet.  So, I'm
resending Christoph's orignal patch with my fix to disk_size() included.
This patch can be applied to the driver in Linus's BK tree from April 28.

Here's Christoph's original description of his patch:

Some grepping showed that DAC960's open routine was duplicating parts
of check_disk_change().  I went on fixing this by implementing a
media_changed method and making DAC960_Open use it.  While looking
at the surrounding code I noticed that

  (a) all methods weren't using the private data the upperlayer
      hands to it properly, but instead using kdev_t-based indexes
  (b) DAC960_Open/DAC960_Release was keeping never used counters
  (c) DAC960_Open was doing tons of checks the upperlayer already does
  (d) DAC960_Release was entirely superflous.

The patch below corrects that and rewrites the block entry points
into readable code - 100 LOC are gone and the same amount replaced
by readable code.

diff -ur linux-2.5.68_bk/drivers/block/DAC960.c linux-2.5.68_FDAC/drivers/block/DAC960.c
--- linux-2.5.68_bk/drivers/block/DAC960.c	Mon Apr 28 11:05:52 2003
+++ linux-2.5.68_FDAC/drivers/block/DAC960.c	Mon Apr 28 09:01:18 2003
@@ -46,43 +46,126 @@
 #include "DAC960.h"
 
 
-/*
-  DAC960_ControllerCount is the number of DAC960 Controllers detected.
-*/
+static DAC960_Controller_T *DAC960_Controllers[DAC960_MaxControllers];
+static int DAC960_ControllerCount;
+static PROC_DirectoryEntry_T *DAC960_ProcDirectoryEntry;
 
-static int
-  DAC960_ControllerCount =			0;
 
-/*
-  DAC960_Controllers is an array of pointers to the DAC960 Controller
-  structures.
-*/
+static long disk_size(DAC960_Controller_T *p, int drive_nr)
+{
+	if (p->FirmwareType == DAC960_V1_Controller) {
+		if (drive_nr >= p->LogicalDriveCount)
+			return 0;
+		return p->V1.LogicalDriveInformation[drive_nr].
+			LogicalDriveSize;
+	} else {
+		DAC960_V2_LogicalDeviceInfo_T *i =
+			p->V2.LogicalDeviceInformation[drive_nr];
+		if (i == NULL)
+			return 0;
+		return i->ConfigurableDeviceSize;
+	}
+}
 
-static DAC960_Controller_T
-  *DAC960_Controllers[DAC960_MaxControllers] =	{ NULL };
+static int DAC960_open(struct inode *inode, struct file *file)
+{
+	struct gendisk *disk = inode->i_bdev->bd_disk;
+	DAC960_Controller_T *p = disk->queue->queuedata;
+	int drive_nr = (int)disk->private_data;
 
+	/* bad hack for the "user" ioctls */
+	if (!p->ControllerNumber && !drive_nr && (file->f_flags & O_NONBLOCK))
+		return 0;
+
+	if (p->FirmwareType == DAC960_V1_Controller) {
+		if (p->V1.LogicalDriveInformation[drive_nr].
+		    LogicalDriveState == DAC960_V1_LogicalDrive_Offline)
+			return -ENXIO;
+	} else {
+		DAC960_V2_LogicalDeviceInfo_T *i =
+			p->V2.LogicalDeviceInformation[drive_nr];
+		if (i->LogicalDeviceState == DAC960_V2_LogicalDevice_Offline)
+			return -ENXIO;
+	}
 
-static int DAC960_revalidate(struct gendisk *);
-/*
-  DAC960_BlockDeviceOperations is the Block Device Operations structure for
-  DAC960 Logical Disk Devices.
-*/
+	check_disk_change(inode->i_bdev);
 
-static struct block_device_operations DAC960_BlockDeviceOperations = {
-	.owner		=THIS_MODULE,
-	.open		=DAC960_Open,
-	.release	=DAC960_Release,
-	.ioctl		=DAC960_IOCTL,
-	.revalidate_disk=DAC960_revalidate,
-};
+	if (!get_capacity(p->disks[drive_nr]))
+		return -ENXIO;
+	return 0;
+}
+
+static int DAC960_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	struct gendisk *disk = inode->i_bdev->bd_disk;
+	DAC960_Controller_T *p = disk->queue->queuedata;
+	int drive_nr = (int)disk->private_data;
+	struct hd_geometry g, *loc = (struct hd_geometry *)arg;
 
+	if (file->f_flags & O_NONBLOCK)
+		return DAC960_UserIOCTL(inode, file, cmd, arg);
 
-/*
-  DAC960_ProcDirectoryEntry is the DAC960 /proc/rd directory entry.
-*/
+	if (cmd != HDIO_GETGEO || !loc)
+		return -EINVAL;
+
+	if (p->FirmwareType == DAC960_V1_Controller) {
+		g.heads = p->V1.GeometryTranslationHeads;
+		g.sectors = p->V1.GeometryTranslationSectors;
+		g.cylinders = p->V1.LogicalDriveInformation[drive_nr].
+			LogicalDriveSize / (g.heads * g.sectors);
+	} else {
+		DAC960_V2_LogicalDeviceInfo_T *i =
+			p->V2.LogicalDeviceInformation[drive_nr];
+		switch (i->DriveGeometry) {
+		case DAC960_V2_Geometry_128_32:
+			g.heads = 128;
+			g.sectors = 32;
+			break;
+		case DAC960_V2_Geometry_255_63:
+			g.heads = 255;
+			g.sectors = 63;
+			break;
+		default:
+			DAC960_Error("Illegal Logical Device Geometry %d\n",
+					p, i->DriveGeometry);
+			return -EINVAL;
+		}
+
+		g.cylinders = i->ConfigurableDeviceSize / (g.heads * g.sectors);
+	}
+	
+	g.start = get_start_sect(inode->i_bdev);
 
-static PROC_DirectoryEntry_T
-  *DAC960_ProcDirectoryEntry;
+	return copy_to_user(loc, &g, sizeof g) ? -EFAULT : 0; 
+}
+
+static int DAC960_media_changed(struct gendisk *disk)
+{
+	DAC960_Controller_T *p = disk->queue->queuedata;
+	int drive_nr = (int)disk->private_data;
+
+	if (!p->LogicalDriveInitiallyAccessible[drive_nr])
+		return 1;
+	return 0;
+}
+
+static int DAC960_revalidate_disk(struct gendisk *disk)
+{
+	DAC960_Controller_T *p = disk->queue->queuedata;
+	int unit = (int)disk->private_data;
+
+	set_capacity(disk, disk_size(p, unit));
+	return 0;
+}
+
+static struct block_device_operations DAC960_BlockDeviceOperations = {
+	.owner			= THIS_MODULE,
+	.open			= DAC960_open,
+	.ioctl			= DAC960_ioctl,
+	.media_changed		= DAC960_media_changed,
+	.revalidate_disk	= DAC960_revalidate_disk,
+};
 
 
 /*
@@ -2433,21 +2516,6 @@
   blk_cleanup_queue(&Controller->RequestQueue);
 }
 
-static long disk_size(DAC960_Controller_T *Controller, int disk)
-{
-	if (Controller->FirmwareType == DAC960_V1_Controller) {
-		if (disk >= Controller->LogicalDriveCount)
-			return 0;
-		return Controller->V1.LogicalDriveInformation[disk].LogicalDriveSize;
-	} else {
-		DAC960_V2_LogicalDeviceInfo_T *LogicalDeviceInfo =
-			Controller->V2.LogicalDeviceInformation[disk];
-		if (LogicalDeviceInfo == NULL)
-			return 0;
-		return LogicalDeviceInfo->ConfigurableDeviceSize;
-	}
-}
-
 /*
   DAC960_ComputeGenericDiskInfo computes the values for the Generic Disk
   Information Partition Sector Counts and Block Sizes.
@@ -2460,14 +2528,6 @@
 		set_capacity(Controller->disks[disk], disk_size(Controller, disk));
 }
 
-static int DAC960_revalidate(struct gendisk *disk)
-{
-	DAC960_Controller_T *p = disk->queue->queuedata;
-	int unit = (int)disk->private_data;
-	set_capacity(disk, disk_size(p, unit));
-	return 0;
-}
-
 /*
   DAC960_ReportErrorStatus reports Controller BIOS Messages passed through
   the Error Status Register when the driver performs the BIOS handshaking.
@@ -5568,151 +5628,6 @@
     }
 }
 
-
-/*
-  DAC960_Open is the Device Open Function for the DAC960 Driver.
-*/
-
-static int DAC960_Open(Inode_T *Inode, File_T *File)
-{
-  int ControllerNumber = DAC960_ControllerNumber(Inode->i_rdev);
-  int LogicalDriveNumber = DAC960_LogicalDriveNumber(Inode->i_rdev);
-  DAC960_Controller_T *Controller;
-  if (ControllerNumber == 0 && LogicalDriveNumber == 0 &&
-      (File->f_flags & O_NONBLOCK))
-    goto ModuleOnly;
-  if (ControllerNumber < 0 || ControllerNumber > DAC960_ControllerCount - 1)
-    return -ENXIO;
-  Controller = DAC960_Controllers[ControllerNumber];
-  if (Controller == NULL) return -ENXIO;
-  if (Controller->FirmwareType == DAC960_V1_Controller)
-    {
-      if (LogicalDriveNumber > Controller->LogicalDriveCount - 1)
-	return -ENXIO;
-      if (Controller->V1.LogicalDriveInformation
-			 [LogicalDriveNumber].LogicalDriveState
-	  == DAC960_V1_LogicalDrive_Offline)
-	return -ENXIO;
-    }
-  else
-    {
-      DAC960_V2_LogicalDeviceInfo_T *LogicalDeviceInfo =
-	Controller->V2.LogicalDeviceInformation[LogicalDriveNumber];
-      if (LogicalDeviceInfo == NULL ||
-	  LogicalDeviceInfo->LogicalDeviceState
-	  == DAC960_V2_LogicalDevice_Offline)
-	return -ENXIO;
-    }
-  if (!Controller->LogicalDriveInitiallyAccessible[LogicalDriveNumber])
-    {
-      long size;
-      Controller->LogicalDriveInitiallyAccessible[LogicalDriveNumber] = true;
-      size = disk_size(Controller, LogicalDriveNumber);
-      set_capacity(Controller->disks[LogicalDriveNumber], size);
-      Inode->i_bdev->bd_invalidated = 1;
-    }
-  if (!get_capacity(Controller->disks[LogicalDriveNumber]))
-    return -ENXIO;
-  /*
-    Increment Controller and Logical Drive Usage Counts.
-  */
-  Controller->ControllerUsageCount++;
-  Controller->LogicalDriveUsageCount[LogicalDriveNumber]++;
- ModuleOnly:
-  return 0;
-}
-
-
-/*
-  DAC960_Release is the Device Release Function for the DAC960 Driver.
-*/
-
-static int DAC960_Release(Inode_T *Inode, File_T *File)
-{
-  int ControllerNumber = DAC960_ControllerNumber(Inode->i_rdev);
-  int LogicalDriveNumber = DAC960_LogicalDriveNumber(Inode->i_rdev);
-  DAC960_Controller_T *Controller = DAC960_Controllers[ControllerNumber];
-  if (ControllerNumber == 0 && LogicalDriveNumber == 0 &&
-      File != NULL && (File->f_flags & O_NONBLOCK))
-    goto ModuleOnly;
-  /*
-    Decrement the Logical Drive and Controller Usage Counts.
-  */
-  Controller->LogicalDriveUsageCount[LogicalDriveNumber]--;
-  Controller->ControllerUsageCount--;
- ModuleOnly:
-  return 0;
-}
-
-
-/*
-  DAC960_IOCTL is the Device IOCTL Function for the DAC960 Driver.
-*/
-
-static int DAC960_IOCTL(Inode_T *Inode, File_T *File,
-			unsigned int Request, unsigned long Argument)
-{
-  int ControllerNumber = DAC960_ControllerNumber(Inode->i_rdev);
-  int LogicalDriveNumber = DAC960_LogicalDriveNumber(Inode->i_rdev);
-  DiskGeometry_T Geometry, *UserGeometry;
-  DAC960_Controller_T *Controller;
-
-  if (File != NULL && (File->f_flags & O_NONBLOCK))
-    return DAC960_UserIOCTL(Inode, File, Request, Argument);
-  if (ControllerNumber < 0 || ControllerNumber > DAC960_ControllerCount - 1)
-    return -ENXIO;
-  Controller = DAC960_Controllers[ControllerNumber];
-  if (Controller == NULL) return -ENXIO;
-  switch (Request)
-    {
-    case HDIO_GETGEO:
-      /* Get BIOS Disk Geometry. */
-      UserGeometry = (DiskGeometry_T *) Argument;
-      if (UserGeometry == NULL) return -EINVAL;
-      if (Controller->FirmwareType == DAC960_V1_Controller)
-	{
-	  if (LogicalDriveNumber > Controller->LogicalDriveCount - 1)
-	    return -ENXIO;
-	  Geometry.heads = Controller->V1.GeometryTranslationHeads;
-	  Geometry.sectors = Controller->V1.GeometryTranslationSectors;
-	  Geometry.cylinders =
-	    Controller->V1.LogicalDriveInformation[LogicalDriveNumber]
-						  .LogicalDriveSize
-	    / (Geometry.heads * Geometry.sectors);
-	}
-      else
-	{
-	  DAC960_V2_LogicalDeviceInfo_T *LogicalDeviceInfo =
-	    Controller->V2.LogicalDeviceInformation[LogicalDriveNumber];
-	  if (LogicalDeviceInfo == NULL)
-	    return -EINVAL;
-	  switch (LogicalDeviceInfo->DriveGeometry)
-	    {
-	    case DAC960_V2_Geometry_128_32:
-	      Geometry.heads = 128;
-	      Geometry.sectors = 32;
-	      break;
-	    case DAC960_V2_Geometry_255_63:
-	      Geometry.heads = 255;
-	      Geometry.sectors = 63;
-	      break;
-	    default:
-	      DAC960_Error("Illegal Logical Device Geometry %d\n",
-			   Controller, LogicalDeviceInfo->DriveGeometry);
-	      return -EINVAL;
-	    }
-	  Geometry.cylinders =
-	    LogicalDeviceInfo->ConfigurableDeviceSize
-	    / (Geometry.heads * Geometry.sectors);
-	}
-      Geometry.start = get_start_sect(Inode->i_bdev);
-      return (copy_to_user(UserGeometry, &Geometry,
-			   sizeof(DiskGeometry_T)) ? -EFAULT : 0);
-    }
-  return -EINVAL;
-}
-
-
 /*
   DAC960_UserIOCTL is the User IOCTL Function for the DAC960 Driver.
 */
diff -ur linux-2.5.68_bk/drivers/block/DAC960.h linux-2.5.68_FDAC/drivers/block/DAC960.h
--- linux-2.5.68_bk/drivers/block/DAC960.h	Mon Apr 28 11:05:52 2003
+++ linux-2.5.68_FDAC/drivers/block/DAC960.h	Mon Apr 28 07:49:34 2003
@@ -2364,7 +2364,6 @@
   unsigned short MaxBlocksPerCommand;
   unsigned short ControllerScatterGatherLimit;
   unsigned short DriverScatterGatherLimit;
-  unsigned int ControllerUsageCount;
   u64		BounceBufferLimit;
   unsigned int CombinedStatusBufferLength;
   unsigned int InitialStatusLength;
@@ -2397,7 +2396,6 @@
   DAC960_Command_T InitialCommand;
   DAC960_Command_T *Commands[DAC960_MaxDriverQueueDepth];
   PROC_DirectoryEntry_T *ControllerProcEntry;
-  unsigned int LogicalDriveUsageCount[DAC960_MaxLogicalDrives];
   boolean LogicalDriveInitiallyAccessible[DAC960_MaxLogicalDrives];
   void (*QueueCommand)(DAC960_Command_T *Command);
   boolean (*ReadControllerConfiguration)(struct DAC960_Controller *);
@@ -4242,9 +4240,6 @@
 static void DAC960_V1_QueueMonitoringCommand(DAC960_Command_T *);
 static void DAC960_V2_QueueMonitoringCommand(DAC960_Command_T *);
 static void DAC960_MonitoringTimerFunction(unsigned long);
-static int DAC960_Open(Inode_T *, File_T *);
-static int DAC960_Release(Inode_T *, File_T *);
-static int DAC960_IOCTL(Inode_T *, File_T *, unsigned int, unsigned long);
 static int DAC960_UserIOCTL(Inode_T *, File_T *, unsigned int, unsigned long);
 static void DAC960_Message(DAC960_MessageLevel_T, unsigned char *,
 			   DAC960_Controller_T *, ...);
