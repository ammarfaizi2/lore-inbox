Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282948AbRLMAjy>; Wed, 12 Dec 2001 19:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282955AbRLMAjq>; Wed, 12 Dec 2001 19:39:46 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:35033 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S282948AbRLMAjJ>; Wed, 12 Dec 2001 19:39:09 -0500
Message-ID: <3C17F8B2.6080700@us.ibm.com>
Date: Wed, 12 Dec 2001 16:39:14 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011209
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] Change locking in block_dev.c:do_open()
Content-Type: multipart/mixed;
 boundary="------------020708060604030502040200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020708060604030502040200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've been looking at how the BKL is used throughout the kernel.  My end
goal is to eliminate the BKL, but I don't have any fanciful ideas that I
can get rid of it myself, or do it in a short period of time.  Right
now, I'm looking for interesting BKL uses and examining alternatives.

Lately, I've been examining do_open() in block_dev.c.  This particular
nugget of code uses the BKL for a couple of things.  First,
get_blkfops() can call request_module(), which requires the BKL.
Secondly, there needs to be protection so that the module isn't removed
between the get_blkfops() and the __MOD_INC_USE_COUNT().  Lastly, the
bd_op->open() calls expect the BKL to be held while they are called.  Is
this it?  Anybody know of more reasons?

Let's assume that the BKL is not held here, at least over the whole
thing.  First, what do we need to do to keep the module from getting
unloaded after the request_module() in get_blkfops()?

We can add a semaphore which must be acquired before a module can be
unloaded, and hold it over the area where the module must not be
unloaded.  We could replace the unload_lock spinlock with a semaphore,
which I'll call it unload_sem here.  It would look something like this:

         down( &unload_sem );
         if (!bdev->bd_op)
                 bdev->bd_op = get_blkfops(MAJOR(dev));
         if (bdev->bd_op) {
                 ret = 0;
                 if (bdev->bd_op->owner)
                         __MOD_INC_USE_COUNT(bdev->bd_op->owner);
                 up( &unload_sem );
         ...
     } else {
             up( &unload_sem );
     }

Once the __MOD_INC_USE_COUNT() has been done, the module is protected
from being unloaded by its usecount.  Until that point the unload_sem
would protect it.  However, this isn't very clean, it forces the block
device code to know something about the module locking scheme.  In
addition, we will need to move the BKL into the get_blkfops() function 
for protection of blkdevs[] and request_module().

Now, what do we do about the need for the drivers to have the BKL in
their opens?  I suggest for now that we move the BKL into the open()
functions.  It will be messy, but I've done 95% of it already.  We can
slowly remove them as we deem them safe (we meaning me).  A similar 
approach was used for release() very early in 2.4 development.

I've attached a patch which does these things.  I don't expect anyone to
apply it, it's just there for you to see exactly what I'm trying to do.

--
Dave Hansen
haveblue@us.ibm.com



--------------020708060604030502040200
Content-Type: text/plain;
 name="bkl-opens-addition.patch-pre10.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bkl-opens-addition.patch-pre10.2"

diff -ur linux-2.5.1-pre10/arch/m68k/atari/stram.c linux/arch/m68k/atari/stram.c
--- linux-2.5.1-pre10/arch/m68k/atari/stram.c	Fri Feb  9 11:29:44 2001
+++ linux/arch/m68k/atari/stram.c	Wed Dec 12 21:25:43 2001
@@ -1018,15 +1018,23 @@
 
 static int stram_open( struct inode *inode, struct file *filp )
 {
+	lock_kernel();
+
 	if (filp != MAGIC_FILE_P) {
 		printk( KERN_NOTICE "Only kernel can open ST-RAM device\n" );
+		unlock_kernel();
 		return( -EPERM );
 	}
-	if (MINOR(inode->i_rdev) != STRAM_MINOR)
+	if (MINOR(inode->i_rdev) != STRAM_MINOR) {
+		unlock_kernel();
 		return( -ENXIO );
-	if (refcnt)
+	}
+	if (refcnt) {
+		unlock_kernel();
 		return( -EBUSY );
+	}
 	++refcnt;
+	unlock_kernel();
 	return( 0 );
 }
 
diff -ur linux-2.5.1-pre10/drivers/acorn/block/fd1772.c linux/drivers/acorn/block/fd1772.c
--- linux-2.5.1-pre10/drivers/acorn/block/fd1772.c	Sun Aug 12 10:38:48 2001
+++ linux/drivers/acorn/block/fd1772.c	Wed Dec 12 21:25:43 2001
@@ -1497,23 +1497,32 @@
 {
 	int drive;
 	int old_dev;
+	int ret = 0;
+
+	lock_kernel();
 
 	if (!filp) {
 		DPRINT(("Weird, open called with filp=0\n"));
-		return -EIO;
+		ret = -EIO;	
+		goto out;
 	}
 	drive = MINOR(inode->i_rdev) & 3;
-	if ((MINOR(inode->i_rdev) >> 2) > NUM_DISK_TYPES)
-		return -ENXIO;
-
+	if ((MINOR(inode->i_rdev) >> 2) > NUM_DISK_TYPES) {
+		ret = -ENXIO;
+		goto out;
+	}
 	old_dev = fd_device[drive];
 
 	if (fd_ref[drive])
-		if (old_dev != inode->i_rdev)
-			return -EBUSY;
+		if (old_dev != inode->i_rdev) {
+			ret = -EBUSY;
+			goto out;
+		}
 
-	if (fd_ref[drive] == -1 || (fd_ref[drive] && filp->f_flags & O_EXCL))
-		return -EBUSY;
+	if (fd_ref[drive] == -1 || (fd_ref[drive] && filp->f_flags & O_EXCL)) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	if (filp->f_flags & O_EXCL)
 		fd_ref[drive] = -1;
@@ -1525,19 +1534,23 @@
 	if (old_dev && old_dev != inode->i_rdev)
 		invalidate_buffers(old_dev);
 
-	if (filp->f_flags & O_NDELAY)
-		return 0;
+	if (filp->f_flags & O_NDELAY) {
+		ret = 0;
+		goto out;
+	}
 
 	if (filp->f_mode & 3) {
 		check_disk_change(inode->i_rdev);
 		if (filp->f_mode & 2) {
 			if (unit[drive].wpstat) {
 				floppy_release(inode, filp);
-				return -EROFS;
+				ret = -EROFS;
 			}
 		}
 	}
-	return 0;
+	
+out:	unlock_kernel();
+	return ret;
 }
 
 
diff -ur linux-2.5.1-pre10/drivers/acorn/block/mfmhd.c linux/drivers/acorn/block/mfmhd.c
--- linux-2.5.1-pre10/drivers/acorn/block/mfmhd.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/acorn/block/mfmhd.c	Wed Dec 12 21:25:43 2001
@@ -1243,14 +1243,18 @@
 static int mfm_open(struct inode *inode, struct file *file)
 {
 	int dev = DEVICE_NR(MINOR(inode->i_rdev));
-
-	if (dev >= mfm_drives)
+	
+	lock_kernel();
+	if (dev >= mfm_drives) {
+		unlock_kernel();
 		return -ENODEV;
+	}
 
 	while (mfm_info[dev].busy)
 		sleep_on (&mfm_wait_open);
 
 	mfm_info[dev].access_count++;
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre10/drivers/block/DAC960.c linux/drivers/block/DAC960.c
--- linux-2.5.1-pre10/drivers/block/DAC960.c	Wed Dec 12 21:51:04 2001
+++ linux/drivers/block/DAC960.c	Wed Dec 12 21:25:43 2001
@@ -5269,21 +5269,33 @@
   int ControllerNumber = DAC960_ControllerNumber(Inode->i_rdev);
   int LogicalDriveNumber = DAC960_LogicalDriveNumber(Inode->i_rdev);
   DAC960_Controller_T *Controller;
+
+  lock_kernel();
+
   if (ControllerNumber == 0 && LogicalDriveNumber == 0 &&
       (File->f_flags & O_NONBLOCK))
     goto ModuleOnly;
-  if (ControllerNumber < 0 || ControllerNumber > DAC960_ControllerCount - 1)
+  if (ControllerNumber < 0 || ControllerNumber > DAC960_ControllerCount - 1) {
+    unlock_kernel();
     return -ENXIO;
+  }
   Controller = DAC960_Controllers[ControllerNumber];
-  if (Controller == NULL) return -ENXIO;
+  if (Controller == NULL) {  
+    unlock_kernel();
+    return -ENXIO;
+  }
   if (Controller->FirmwareType == DAC960_V1_Controller)
     {
-      if (LogicalDriveNumber > Controller->LogicalDriveCount - 1)
+      if (LogicalDriveNumber > Controller->LogicalDriveCount - 1) {
+	unlock_kernel();
 	return -ENXIO;
+      }
       if (Controller->V1.LogicalDriveInformation
 			 [LogicalDriveNumber].LogicalDriveState
-	  == DAC960_V1_LogicalDrive_Offline)
+	  == DAC960_V1_LogicalDrive_Offline) {
+	unlock_kernel();
 	return -ENXIO;
+      }
     }
   else
     {
@@ -5291,8 +5303,10 @@
 	Controller->V2.LogicalDeviceInformation[LogicalDriveNumber];
       if (LogicalDeviceInfo == NULL ||
 	  LogicalDeviceInfo->LogicalDeviceState
-	  == DAC960_V2_LogicalDevice_Offline)
+	  == DAC960_V2_LogicalDevice_Offline) {
+	unlock_kernel();
 	return -ENXIO;
+      }
     }
   if (!Controller->LogicalDriveInitiallyAccessible[LogicalDriveNumber])
     {
@@ -5300,14 +5314,17 @@
       DAC960_ComputeGenericDiskInfo(&Controller->GenericDiskInfo);
       DAC960_RegisterDisk(Controller, LogicalDriveNumber);
     }
-  if (Controller->GenericDiskInfo.sizes[MINOR(Inode->i_rdev)] == 0)
+  if (Controller->GenericDiskInfo.sizes[MINOR(Inode->i_rdev)] == 0) {
+    unlock_kernel();
     return -ENXIO;
+  }
   /*
     Increment Controller and Logical Drive Usage Counts.
   */
   Controller->ControllerUsageCount++;
   Controller->LogicalDriveUsageCount[LogicalDriveNumber]++;
  ModuleOnly:
+  unlock_kernel();
   return 0;
 }
 
diff -ur linux-2.5.1-pre10/drivers/block/acsi.c linux/drivers/block/acsi.c
--- linux-2.5.1-pre10/drivers/block/acsi.c	Wed Dec 12 21:51:04 2001
+++ linux/drivers/block/acsi.c	Wed Dec 12 21:25:43 2001
@@ -1171,10 +1171,13 @@
 {
 	int  device;
 	struct acsi_info_struct *aip;
-
+	
+	lock_kernel();
 	device = DEVICE_NR(MINOR(inode->i_rdev));
-	if (device >= NDevices)
+	if (device >= NDevices) {
+		unlock_kernel();
 		return -ENXIO;
+	}
 	aip = &acsi_info[device];
 	while (busy[device])
 		sleep_on(&busy_wait);
@@ -1184,8 +1187,10 @@
 		aip->changed = 1;	/* safety first */
 #endif
 		check_disk_change( inode->i_rdev );
-		if (aip->changed)	/* revalidate was not successful (no medium) */
+		if (aip->changed) {	/* revalidate was not successful (no medium) */
+			unlock_kernel();
 			return -ENXIO;
+		}
 		acsi_prevent_removal(device, 1);
 	}
 	access_count[device]++;
@@ -1195,11 +1200,12 @@
 		if (filp->f_mode & 2) {
 			if (aip->read_only) {
 				acsi_release( inode, filp );
+				unlock_kernel();
 				return -EROFS;
 			}
 		}
 	}
-
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre10/drivers/block/amiflop.c linux/drivers/block/amiflop.c
--- linux-2.5.1-pre10/drivers/block/amiflop.c	Wed Dec 12 21:51:04 2001
+++ linux/drivers/block/amiflop.c	Wed Dec 12 21:25:43 2001
@@ -1624,16 +1624,23 @@
 	int old_dev;
 	int system;
 	unsigned long flags;
+	int ret = 0;
 
+	lock_kernel();
+	
 	drive = MINOR(inode->i_rdev) & 3;
 	old_dev = fd_device[drive];
 
 	if (fd_ref[drive])
-		if (old_dev != inode->i_rdev)
-			return -EBUSY;
+		if (old_dev != inode->i_rdev) {
+			ret = -EBUSY;
+			goto out;
+		}
 
-	if (unit[drive].type->code == FD_NODRIVE)
-		return -ENODEV;
+	if (unit[drive].type->code == FD_NODRIVE) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	if (filp && filp->f_mode & 3) {
 		check_disk_change(inode->i_rdev);
@@ -1646,8 +1653,10 @@
 			fd_deselect (drive);
 			rel_fdc();
 
-			if (wrprot)
-				return -EROFS;
+			if (wrprot) {
+				ret = -EROFS;
+				goto out;
+			}
 		}
 	}
 
@@ -1672,8 +1681,8 @@
 
 	printk(KERN_INFO "fd%d: accessing %s-disk with %s-layout\n",drive,
 	       unit[drive].type->name, data_types[system].name);
-
-	return 0;
+out:	unlock_kernel();
+	return ret;
 }
 
 static int floppy_release(struct inode * inode, struct file * filp)
diff -ur linux-2.5.1-pre10/drivers/block/ataflop.c linux/drivers/block/ataflop.c
--- linux-2.5.1-pre10/drivers/block/ataflop.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/block/ataflop.c	Wed Dec 12 21:25:43 2001
@@ -1890,25 +1890,35 @@
 {
 	int drive, type;
 	int old_dev;
+	int ret = 0;
+
+	lock_kernel();
 
 	if (!filp) {
 		DPRINT (("Weird, open called with filp=0\n"));
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 
 	drive = MINOR(inode->i_rdev) & 3;
 	type  = MINOR(inode->i_rdev) >> 2;
 	DPRINT(("fd_open: type=%d\n",type));
-	if (drive >= FD_MAX_UNITS || type > NUM_DISK_MINORS)
-		return -ENXIO;
+	if (drive >= FD_MAX_UNITS || type > NUM_DISK_MINORS) {
+		ret = -ENXIO;
+		goto out;	
+	}
 
 	old_dev = fd_device[drive];
 
-	if (fd_ref[drive] && old_dev != MINOR(inode->i_rdev))
-		return -EBUSY;
+	if (fd_ref[drive] && old_dev != MINOR(inode->i_rdev)) {
+		ret = -EBUSY;
+		goto out;
+	}
 
-	if (fd_ref[drive] == -1 || (fd_ref[drive] && filp->f_flags & O_EXCL))
-		return -EBUSY;
+	if (fd_ref[drive] == -1 || (fd_ref[drive] && filp->f_flags & O_EXCL)) {
+                ret = -EBUSY;
+                goto out;
+        }
 
 	if (filp->f_flags & O_EXCL)
 		fd_ref[drive] = -1;
@@ -1920,20 +1930,24 @@
 	if (old_dev && old_dev != MINOR(inode->i_rdev))
 		invalidate_buffers(MKDEV(FLOPPY_MAJOR, old_dev));
 
-	if (filp->f_flags & O_NDELAY)
-		return 0;
+	if (filp->f_flags & O_NDELAY) {
+		ret = 0;
+		goto out;
+	}
 
 	if (filp->f_mode & 3) {
 		check_disk_change(inode->i_rdev);
 		if (filp->f_mode & 2) {
 			if (UD.wpstat) {
 				floppy_release(inode, filp);
-				return -EROFS;
+				ret = -EROFS;	
+				goto out:
 			}
 		}
 	}
 
-	return 0;
+out:	unlock_kernel()
+	return ret;
 }
 
 
diff -ur linux-2.5.1-pre10/drivers/block/cciss.c linux/drivers/block/cciss.c
--- linux-2.5.1-pre10/drivers/block/cciss.c	Wed Dec 12 21:51:04 2001
+++ linux/drivers/block/cciss.c	Wed Dec 12 21:25:43 2001
@@ -320,15 +320,21 @@
 	int ctlr = MAJOR(inode->i_rdev) - MAJOR_NR;
 	int dsk  = MINOR(inode->i_rdev) >> NWD_SHIFT;
 
+	lock_kernel();
+
 #ifdef CCISS_DEBUG
 	printk(KERN_DEBUG "cciss_open %x (%x:%x)\n", inode->i_rdev, ctlr, dsk);
 #endif /* CCISS_DEBUG */ 
 
-	if (ctlr > MAX_CTLR || hba[ctlr] == NULL)
+	if (ctlr > MAX_CTLR || hba[ctlr] == NULL) {
+		unlock_kernel();
 		return -ENXIO;
+	}
 
-	if (!suser() && hba[ctlr]->sizes[ MINOR(inode->i_rdev)] == 0)
+	if (!suser() && hba[ctlr]->sizes[ MINOR(inode->i_rdev)] == 0) {
+                unlock_kernel();
 		return -ENXIO;
+	}
 
 	/*
 	 * Root is allowed to open raw volume zero even if its not configured
@@ -338,11 +344,15 @@
 	 */
 	if (suser()
 		&& (hba[ctlr]->sizes[MINOR(inode->i_rdev)] == 0) 
-		&& (MINOR(inode->i_rdev)!= 0))
+		&& (MINOR(inode->i_rdev)!= 0)) {
+                unlock_kernel();
 		return -ENXIO;
+	}
 
 	hba[ctlr]->drv[dsk].usage_count++;
 	hba[ctlr]->usage_count++;
+
+        unlock_kernel();
 	return 0;
 }
 /*
diff -ur linux-2.5.1-pre10/drivers/block/cpqarray.c linux/drivers/block/cpqarray.c
--- linux-2.5.1-pre10/drivers/block/cpqarray.c	Wed Dec 12 21:51:04 2001
+++ linux/drivers/block/cpqarray.c	Wed Dec 12 21:25:43 2001
@@ -772,14 +772,19 @@
 {
 	int ctlr = MAJOR(inode->i_rdev) - MAJOR_NR;
 	int dsk  = MINOR(inode->i_rdev) >> NWD_SHIFT;
+	int ret = 0;
+	lock_kernel();
 
 	DBGINFO(printk("ida_open %x (%x:%x)\n", inode->i_rdev, ctlr, dsk) );
-	if (ctlr > MAX_CTLR || hba[ctlr] == NULL)
-		return -ENXIO;
-
+	if (ctlr > MAX_CTLR || hba[ctlr] == NULL) {
+		ret = -ENXIO;
+		goto out;
+	}
 	if (!suser() && ida_sizes[(ctlr << CTLR_SHIFT) +
-						MINOR(inode->i_rdev)] == 0)
-		return -ENXIO;
+						MINOR(inode->i_rdev)] == 0) {
+		ret = -ENXIO;
+		goto out;
+	}
 
 	/*
 	 * Root is allowed to open raw volume zero even if its not configured
@@ -789,12 +794,15 @@
 	 */
 	if (suser()
 		&& ida_sizes[(ctlr << CTLR_SHIFT) + MINOR(inode->i_rdev)] == 0 
-		&& MINOR(inode->i_rdev) != 0)
-		return -ENXIO;
+		&& MINOR(inode->i_rdev) != 0) {
+		ret = -ENXIO;
+		goto out;
+	}
 
 	hba[ctlr]->drv[dsk].usage_count++;
 	hba[ctlr]->usage_count++;
-	return 0;
+out:	unlock_kernel();
+	return ret;
 }
 
 /*
diff -ur linux-2.5.1-pre10/drivers/block/floppy.c linux/drivers/block/floppy.c
--- linux-2.5.1-pre10/drivers/block/floppy.c	Wed Dec 12 21:51:04 2001
+++ linux/drivers/block/floppy.c	Wed Dec 12 21:25:43 2001
@@ -145,6 +145,7 @@
 #include <linux/kernel.h>
 #include <linux/timer.h>
 #include <linux/tqueue.h>
+#include <linux/smp_lock.h>
 #define FDPATCHES
 #include <linux/fdreg.h>
 
@@ -3691,7 +3692,7 @@
  * /dev/PS0 etc), and disallows simultaneous access to the same
  * drive with different device numbers.
  */
-#define RETERR(x) do{floppy_release(inode,filp); return -(x);}while(0)
+#define RETERR(x) do{floppy_release(inode,filp); unlock_kernel(); ret = -(x); goto out;}while(0)
 
 static int floppy_open(struct inode * inode, struct file * filp)
 {
@@ -3699,10 +3700,14 @@
 	int old_dev;
 	int try;
 	char *tmp;
+	int ret = 0;
+
+	lock_kernel();
 
 	if (!filp) {
 		DPRINT("Weird, open called with filp=0\n");
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 
 	filp->private_data = (void*) 0;
@@ -3710,14 +3715,20 @@
 	drive = DRIVE(inode->i_rdev);
 	if (drive >= N_DRIVE ||
 	    !(allowed_drive_mask & (1 << drive)) ||
-	    fdc_state[FDC(drive)].version == FDC_NONE)
-		return -ENXIO;
+	    fdc_state[FDC(drive)].version == FDC_NONE) {
+		ret = -ENXIO;
+		goto out;
+	}
 
-	if (TYPE(inode->i_rdev) >= NUMBER(floppy_type))
-		return -ENXIO;
+	if (TYPE(inode->i_rdev) >= NUMBER(floppy_type)){
+                ret = -ENXIO;
+                goto out;
+        }
 	old_dev = UDRS->fd_device;
-	if (UDRS->fd_ref && old_dev != MINOR(inode->i_rdev))
-		return -EBUSY;
+	if (UDRS->fd_ref && old_dev != MINOR(inode->i_rdev)) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	if (!UDRS->fd_ref && (UDP->flags & FD_BROKEN_DCL)){
 		USETF(FD_DISK_CHANGED);
@@ -3725,11 +3736,15 @@
 	}
 
 	if (UDRS->fd_ref == -1 ||
-	   (UDRS->fd_ref && (filp->f_flags & O_EXCL)))
-		return -EBUSY;
-
-	if (floppy_grab_irq_and_dma())
-		return -EBUSY;
+	   (UDRS->fd_ref && (filp->f_flags & O_EXCL))) {
+                ret = -EBUSY;
+                goto out;
+        }
+
+	if (floppy_grab_irq_and_dma()) {
+                ret = -EBUSY;
+                goto out;
+        }
 
 	if (filp->f_flags & O_EXCL)
 		UDRS->fd_ref = -1;
@@ -3785,7 +3800,10 @@
 		UFDCS->rawcmd = 2;
 
 	if (filp->f_flags & O_NDELAY)
-		return 0;
+	{
+		ret = 0;
+		goto out;
+	}
 	if (filp->f_mode & 3) {
 		UDRS->last_checked = 0;
 		check_disk_change(inode->i_rdev);
@@ -3794,7 +3812,8 @@
 	}
 	if ((filp->f_mode & 2) && !(UTESTF(FD_DISK_WRITABLE)))
 		RETERR(EROFS);
-	return 0;
+	out:
+	return ret;
 #undef RETERR
 }
 
diff -ur linux-2.5.1-pre10/drivers/block/loop.c linux/drivers/block/loop.c
--- linux-2.5.1-pre10/drivers/block/loop.c	Wed Dec 12 21:51:04 2001
+++ linux/drivers/block/loop.c	Wed Dec 12 21:25:43 2001
@@ -878,16 +878,24 @@
 {
 	struct loop_device *lo;
 	int	dev, type;
+	int 	ret = 0;
 
-	if (!inode)
-		return -EINVAL;
+	lock_kernel();
+
+	if (!inode) {
+		ret = -EINVAL;
+		goto out;
+ 	}
 	if (MAJOR(inode->i_rdev) != MAJOR_NR) {
 		printk(KERN_WARNING "lo_open: pseudo-major != %d\n", MAJOR_NR);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 	dev = MINOR(inode->i_rdev);
-	if (dev >= max_loop)
-		return -ENODEV;
+	if (dev >= max_loop) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	lo = &loop_dev[dev];
 	MOD_INC_USE_COUNT;
@@ -898,7 +906,9 @@
 		xfer_funcs[type]->lock(lo);
 	lo->lo_refcnt++;
 	up(&lo->lo_ctl_mutex);
-	return 0;
+
+out:	unlock_kernel();
+	return ret;
 }
 
 static int lo_release(struct inode *inode, struct file *file)
diff -ur linux-2.5.1-pre10/drivers/block/nbd.c linux/drivers/block/nbd.c
--- linux-2.5.1-pre10/drivers/block/nbd.c	Wed Dec 12 21:51:04 2001
+++ linux/drivers/block/nbd.c	Wed Dec 12 21:25:43 2001
@@ -74,14 +74,21 @@
 static int nbd_open(struct inode *inode, struct file *file)
 {
 	int dev;
+		
+	lock_kernel();
 
-	if (!inode)
+	if (!inode) {
+		unlock_kernel();
 		return -EINVAL;
+	}
 	dev = MINOR(inode->i_rdev);
-	if (dev >= MAX_NBD)
+	if (dev >= MAX_NBD) {
+                unlock_kernel();
 		return -ENODEV;
+	}
 
 	nbd_dev[dev].refcnt++;
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre10/drivers/block/paride/pd.c linux/drivers/block/paride/pd.c
--- linux-2.5.1-pre10/drivers/block/paride/pd.c	Wed Dec 12 21:51:04 2001
+++ linux/drivers/block/paride/pd.c	Wed Dec 12 21:25:43 2001
@@ -425,7 +425,12 @@
 
 {       int unit = DEVICE_NR(inode->i_rdev);
 
-        if ((unit >= PD_UNITS) || (!PD.present)) return -ENODEV;
+	lock_kernel();
+
+        if ((unit >= PD_UNITS) || (!PD.present)) {
+		unlock_kernel();
+		return -ENODEV;
+	}
 
 	wait_event (pd_wait_open, pd_valid);
 
@@ -435,6 +440,7 @@
 		pd_media_check(unit);
 		pd_doorlock(unit,IDE_DOORLOCK);
 	}
+	unlock_kernel();
         return 0;
 }
 
diff -ur linux-2.5.1-pre10/drivers/block/paride/pf.c linux/drivers/block/paride/pf.c
--- linux-2.5.1-pre10/drivers/block/paride/pf.c	Wed Dec 12 21:51:04 2001
+++ linux/drivers/block/paride/pf.c	Wed Dec 12 21:25:43 2001
@@ -374,19 +374,29 @@
 
 {       int	unit = DEVICE_NR(inode->i_rdev);
 
-        if ((unit >= PF_UNITS) || (!PF.present)) return -ENODEV;
+	lock_kernel();
+
+        if ((unit >= PF_UNITS) || (!PF.present)) {
+		unlock_kernel();
+		return -ENODEV;
+	}
 
 	pf_identify(unit);
 
-	if (PF.media_status == PF_NM)
+	if (PF.media_status == PF_NM) {
+                unlock_kernel();
 		return -ENODEV;
+	}
 
-	if ((PF.media_status == PF_RO) && (file ->f_mode & 2))
+	if ((PF.media_status == PF_RO) && (file ->f_mode & 2)){
+                unlock_kernel();
 		return -EROFS;
+	}
 
         PF.access++;
         if (PF.removable) pf_lock(unit,1);
 
+	unlock_kernel();
         return 0;
 }
 
diff -ur linux-2.5.1-pre10/drivers/block/rd.c linux/drivers/block/rd.c
--- linux-2.5.1-pre10/drivers/block/rd.c	Wed Dec 12 21:51:04 2001
+++ linux/drivers/block/rd.c	Wed Dec 12 21:34:41 2001
@@ -452,6 +452,8 @@
 {
 	int unit = DEVICE_NR(inode->i_rdev);
 
+	lock_kernel();
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (unit == INITRD_MINOR) {
 		spin_lock(&initrd_users_lock);
@@ -460,12 +462,15 @@
 		if (!initrd_start) 
 			return -ENODEV;
 		filp->f_op = &initrd_fops;
+		unlock_kernel();
 		return 0;
 	}
 #endif
 
-	if (unit >= NUM_RAMDISKS)
+	if (unit >= NUM_RAMDISKS) {
+		unlock_kernel();
 		return -ENXIO;
+	}
 
 	/*
 	 * Immunize device against invalidate_buffers() and prune_icache().
@@ -476,6 +481,7 @@
 		rd_bdev[unit]->bd_inode->i_mapping->a_ops = &ramdisk_aops;
 	}
 
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre10/drivers/block/swim3.c linux/drivers/block/swim3.c
--- linux-2.5.1-pre10/drivers/block/swim3.c	Wed Jun 27 13:37:35 2001
+++ linux/drivers/block/swim3.c	Wed Dec 12 21:25:43 2001
@@ -857,19 +857,29 @@
 	struct floppy_state *fs;
 	volatile struct swim3 *sw;
 	int n, err;
-	int devnum = MINOR(inode->i_rdev);
+	int devnum = MINOR(inode->i_rdev)
+	int ret = 0 
 
-	if (devnum >= floppy_count)
-		return -ENODEV;
-	if (filp == 0)
-		return -EIO;
+	lock_kernel();
+
+	if (devnum >= floppy_count) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (filp == 0) {
+		ret = -EIO;
+		goto out;
+	}
 		
 	fs = &floppy_states[devnum];
 	sw = fs->swim3;
 	err = 0;
 	if (fs->ref_count == 0) {
-		if (fs->media_bay && check_media_bay(fs->media_bay, MB_FD))
-			return -ENXIO;
+		if (fs->media_bay && check_media_bay(fs->media_bay, MB_FD)) {
+			ret = -ENXIO;
+			goto out;
+		}
 		out_8(&sw->mode, 0x95);
 		out_8(&sw->control_bic, 0xff);
 		out_8(&sw->setup, S_IBM_DRIVE | S_FCLK_DIV2);
@@ -894,8 +904,10 @@
 			err = -ENXIO;
 		swim3_action(fs, 9);
 
-	} else if (fs->ref_count == -1 || filp->f_flags & O_EXCL)
-		return -EBUSY;
+	} else if (fs->ref_count == -1 || filp->f_flags & O_EXCL) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	if (err == 0 && (filp->f_flags & O_NDELAY) == 0
 	    && (filp->f_mode & 3)) {
@@ -916,7 +928,8 @@
 			swim3_action(fs, MOTOR_OFF);
 			out_8(&sw->control_bic, DRIVE_ENABLE | INTR_ENABLE);
 		}
-		return err;
+		ret = err;
+		goto out;
 	}
 
 	if (filp->f_flags & O_EXCL)
@@ -924,7 +937,8 @@
 	else
 		++fs->ref_count;
 
-	return 0;
+out:	unlock_kernel();
+	return ret;
 }
 
 static int floppy_release(struct inode *inode, struct file *filp)
diff -ur linux-2.5.1-pre10/drivers/block/swim_iop.c linux/drivers/block/swim_iop.c
--- linux-2.5.1-pre10/drivers/block/swim_iop.c	Sat May 19 17:43:05 2001
+++ linux/drivers/block/swim_iop.c	Wed Dec 12 21:25:43 2001
@@ -371,15 +371,25 @@
 	struct floppy_state *fs;
 	int err;
 	int devnum = MINOR(inode->i_rdev);
+	int ret = 0;
 
-	if (devnum >= floppy_count)
-		return -ENODEV;
-	if (filp == 0)
-		return -EIO;
+	lock_kernel();
+
+	if (devnum >= floppy_count) {
+		ret = -ENODEV;
+		goto out;
+	}
+	if (filp == 0) {
+		ret = -EIO;
+		goto out;
+	}
 		
 	fs = &floppy_states[devnum];
 	err = 0;
-	if (fs->ref_count == -1 || filp->f_flags & O_EXCL) return -EBUSY;
+	if (fs->ref_count == -1 || filp->f_flags & O_EXCL) {
+		ret -EBUSY;
+		goto out;
+	}
 
 	if (err == 0 && (filp->f_flags & O_NDELAY) == 0
 	    && (filp->f_mode & 3)) {
@@ -393,14 +403,18 @@
 			err = -EROFS;
 	}
 
-	if (err) return err;
+	if (err) { 
+		ret = err;
+		goto out;
+	}
 
 	if (filp->f_flags & O_EXCL)
 		fs->ref_count = -1;
 	else
 		++fs->ref_count;
 
-	return 0;
+out:	unlock_kernel();
+	return ret;
 }
 
 static int floppy_release(struct inode *inode, struct file *filp)
diff -ur linux-2.5.1-pre10/drivers/block/xd.c linux/drivers/block/xd.c
--- linux-2.5.1-pre10/drivers/block/xd.c	Wed Dec 12 21:51:04 2001
+++ linux/drivers/block/xd.c	Wed Dec 12 21:25:43 2001
@@ -261,16 +261,16 @@
 static int xd_open (struct inode *inode,struct file *file)
 {
 	int dev = DEVICE_NR(inode->i_rdev);
-
+ 	lock_kernel();
 	if (dev < xd_drives) {
 		while (!xd_valid[dev])
 			sleep_on(&xd_wait_open);
 
 		xd_access[dev]++;
-
+		unlock_kernel();
 		return (0);
 	}
-
+	unlock_kernel();
 	return -ENXIO;
 }
 
diff -ur linux-2.5.1-pre10/drivers/block/z2ram.c linux/drivers/block/z2ram.c
--- linux-2.5.1-pre10/drivers/block/z2ram.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/block/z2ram.c	Wed Dec 12 21:25:43 2001
@@ -168,6 +168,8 @@
 	sizeof( z2ram_map[0] );
     int rc = -ENOMEM;
 
+    lock_kernel();
+
     device = DEVICE_NR( inode->i_rdev );
 
     if ( current_device != -1 && current_device != device )
@@ -312,11 +314,15 @@
 	blk_size[ MAJOR_NR ] = z2_sizes;
     }
 
+    unlock_kernel();
     return 0;
 
 err_out_kfree:
+    unlock_kernel();
     kfree( z2ram_map );
+    return rc;
 err_out:
+    unlock_kernel();
     return rc;
 }
 
diff -ur linux-2.5.1-pre10/drivers/cdrom/aztcd.c linux/drivers/cdrom/aztcd.c
--- linux-2.5.1-pre10/drivers/cdrom/aztcd.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/cdrom/aztcd.c	Wed Dec 12 21:25:43 2001
@@ -1652,12 +1652,15 @@
 {
 	int st;
 
+	lock_kernel();
 #ifdef AZT_DEBUG
 	printk("aztcd: starting aztcd_open\n");
 #endif
 
-	if (aztPresent == 0)
+	if (aztPresent == 0) {
+		unlock_kernel();
 		return -ENXIO;	/* no hardware */
+	}
 
 	if (!azt_open_count && azt_state == AZT_S_IDLE) {
 		azt_invalidate_buffers();
@@ -1687,9 +1690,11 @@
 #ifdef AZT_DEBUG
 	printk("aztcd: exiting aztcd_open\n");
 #endif
+	unlock_kernel();
 	return 0;
 
       err_out:
+	unlock_kernel();
 	return -EIO;
 }
 
diff -ur linux-2.5.1-pre10/drivers/cdrom/cdrom.c linux/drivers/cdrom/cdrom.c
--- linux-2.5.1-pre10/drivers/cdrom/cdrom.c	Wed Dec 12 21:51:04 2001
+++ linux/drivers/cdrom/cdrom.c	Wed Dec 12 21:25:43 2001
@@ -461,12 +461,18 @@
 	kdev_t dev = ip->i_rdev;
 	int ret;
 
+	lock_kernel();
+
 	cdinfo(CD_OPEN, "entering cdrom_open\n"); 
-	if ((cdi = cdrom_find_device(dev)) == NULL)
+	if ((cdi = cdrom_find_device(dev)) == NULL) {
+		unlock_kernel();
 		return -ENODEV;
+	}
 
-	if ((fp->f_mode & FMODE_WRITE) && !CDROM_CAN(CDC_DVD_RAM))
+	if ((fp->f_mode & FMODE_WRITE) && !CDROM_CAN(CDC_DVD_RAM)) {
+		unlock_kernel();
 		return -EROFS;
+	}
 
 	/* if this was a O_NONBLOCK open and we should honor the flags,
 	 * do a quick open without drive/disc integrity checks. */
@@ -481,6 +487,7 @@
 	/* Do this on open.  Don't wait for mount, because they might
 	    not be mounting, but opening with O_NONBLOCK */
 	check_disk_change(dev);
+	unlock_kernel();
 	return ret;
 }
 
diff -ur linux-2.5.1-pre10/drivers/cdrom/gscd.c linux/drivers/cdrom/gscd.c
--- linux-2.5.1-pre10/drivers/cdrom/gscd.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/cdrom/gscd.c	Wed Dec 12 21:25:43 2001
@@ -374,26 +374,29 @@
 static int gscd_open(struct inode *ip, struct file *fp)
 {
 	int st;
-
+	int ret;
 #ifdef GSCD_DEBUG
 	printk("GSCD: open\n");
 #endif
 
-	if (gscdPresent == 0)
-		return -ENXIO;	/* no hardware */
+	if (gscdPresent == 0) {
+		ret = -ENXIO;	/* no hardware */
+		goto out;
+	}
 
 	get_status();
 	st = disk_state & (ST_NO_DISK | ST_DOOR_OPEN);
 	if (st) {
 		printk("GSCD: no disk or door open\n");
-		return -ENXIO;
+		ret = -ENXIO;
+		goto out;
 	}
 
 /*	if (updateToc() < 0)
 		return -EIO;
 */
 
-	return 0;
+	return ret;
 }
 
 
diff -ur linux-2.5.1-pre10/drivers/cdrom/optcd.c linux/drivers/cdrom/optcd.c
--- linux-2.5.1-pre10/drivers/cdrom/optcd.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/cdrom/optcd.c	Wed Dec 12 21:25:43 2001
@@ -1871,6 +1871,8 @@
 {
 	DEBUG((DEBUG_VFS, "starting opt_open"));
 
+	lock_kernel();
+
 	if (!open_count && state == S_IDLE) {
 		int status;
 
@@ -1911,9 +1913,11 @@
 
 	DEBUG((DEBUG_VFS, "exiting opt_open"));
 
+	unlock_kernel();
 	return 0;
 
 err_out:
+	unlock_kernel();
 	return -EIO;
 }
 
diff -ur linux-2.5.1-pre10/drivers/cdrom/sjcd.c linux/drivers/cdrom/sjcd.c
--- linux-2.5.1-pre10/drivers/cdrom/sjcd.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/cdrom/sjcd.c	Wed Dec 12 21:25:43 2001
@@ -1539,17 +1539,21 @@
  */
 int sjcd_open(struct inode *ip, struct file *fp)
 {
+	lock_kernel();
 	/*
 	 * Check the presence of device.
 	 */
-	if (!sjcd_present)
+	if (!sjcd_present) {
+		unlock_kernel();
 		return (-ENXIO);
-
+	}
 	/*
 	 * Only read operations are allowed. Really? (:-)
 	 */
-	if (fp->f_mode & 2)
+	if (fp->f_mode & 2){
+                unlock_kernel();
 		return (-EROFS);
+	}
 
 	if (sjcd_open_count == 0) {
 		int s, sjcd_open_tries;
@@ -1613,9 +1617,11 @@
 	}
 
 	++sjcd_open_count;
+	unlock_kernel();
 	return (0);
 
       err_out:
+	unlock_kernel();
 	return (-EIO);
 }
 
diff -ur linux-2.5.1-pre10/drivers/cdrom/sonycd535.c linux/drivers/cdrom/sonycd535.c
--- linux-2.5.1-pre10/drivers/cdrom/sonycd535.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/cdrom/sonycd535.c	Wed Dec 12 21:25:43 2001
@@ -1394,16 +1394,23 @@
 {
 	Byte status[2], cmd_buff[2];
 
-	if (sony_inuse)
+	lock_kernel();
+
+	if (sony_inuse) {
+		unlock_kernel();
 		return -EBUSY;
-	if (check_drive_status() != 0)
+	}
+	if (check_drive_status() != 0) {
+                unlock_kernel();
 		return -EIO;
+	}
 	sony_inuse = 1;
 
 	if (spin_up_drive(status) != 0) {
 		printk(CDU535_MESSAGE_NAME " error 0x%.2x (cdu_open, spin up)\n",
 				status[0]);
 		sony_inuse = 0;
+		unlock_kernel();
 		return -EIO;
 	}
 	sony_get_toc();
@@ -1411,6 +1418,7 @@
 		cmd_buff[0] = SONY535_SPIN_DOWN;
 		do_sony_cmd(cmd_buff, 1, status, NULL, 0, 0);
 		sony_inuse = 0;
+		unlock_kernel();
 		return -EIO;
 	}
 	if (inode) {
@@ -1423,7 +1431,7 @@
 	cmd_buff[0] = SONY535_DISABLE_EJECT_BUTTON;
 	do_sony_cmd(cmd_buff, 1, status, NULL, 0, 0);
 #endif
-
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre10/drivers/ide/ataraid.c linux/drivers/ide/ataraid.c
--- linux-2.5.1-pre10/drivers/ide/ataraid.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/ide/ataraid.c	Wed Dec 12 21:25:43 2001
@@ -80,10 +80,15 @@
 static int ataraid_open(struct inode * inode, struct file * filp)
 {
 	int minor;
+	
+	lock_kernel();
 	minor = MINOR(inode->i_rdev)>>SHIFT;
 
-	if ((ataraid_ops[minor])&&(ataraid_ops[minor]->open))
+	if ((ataraid_ops[minor])&&(ataraid_ops[minor]->open)) {
+		unlock_kernel();
 		return (ataraid_ops[minor]->open)(inode,filp);
+	}
+	unlock_kernel();
 	return -EINVAL;
 }
 
diff -ur linux-2.5.1-pre10/drivers/ide/hd.c linux/drivers/ide/hd.c
--- linux-2.5.1-pre10/drivers/ide/hd.c	Wed Dec 12 21:51:05 2001
+++ linux/drivers/ide/hd.c	Wed Dec 12 21:25:43 2001
@@ -661,11 +661,16 @@
 	int target;
 	target =  DEVICE_NR(inode->i_rdev);
 
-	if (target >= NR_HD)
+	lock_kernel();
+
+	if (target >= NR_HD) {
+		unlock_kernel();
 		return -ENODEV;
+	}
 	while (busy[target])
 		sleep_on(&busy_wait);
 	access_count[target]++;
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre10/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.1-pre10/drivers/ide/ide.c	Wed Dec 12 21:51:05 2001
+++ linux/drivers/ide/ide.c	Wed Dec 12 21:25:43 2001
@@ -1999,9 +1999,12 @@
 static int ide_open (struct inode * inode, struct file * filp)
 {
 	ide_drive_t *drive;
+	int ret = -ENXIO;
 
-	if ((drive = get_info_ptr(inode->i_rdev)) == NULL)
-		return -ENXIO;
+	if ((drive = get_info_ptr(inode->i_rdev)) == NULL) {
+		ret = -ENXIO;
+		goto out;
+	}
 	if (drive->driver == NULL)
 		ide_driver_module();
 #ifdef CONFIG_KMOD
@@ -2019,11 +2022,14 @@
 	while (drive->busy)
 		sleep_on(&drive->wqueue);
 	drive->usage++;
-	if (drive->driver != NULL)
-		return DRIVER(drive)->open(inode, filp, drive);
+	if (drive->driver != NULL) {
+		ret = DRIVER(drive)->open(inode, filp, drive);
+		goto out;
+	}
 	printk ("%s: driver not present\n", drive->name);
 	drive->usage--;
-	return -ENXIO;
+out:	unlock_kernel();
+	return ret;
 }
 
 /*
diff -ur linux-2.5.1-pre10/drivers/md/lvm.c linux/drivers/md/lvm.c
--- linux-2.5.1-pre10/drivers/md/lvm.c	Wed Dec 12 21:51:05 2001
+++ linux/drivers/md/lvm.c	Wed Dec 12 21:25:43 2001
@@ -794,13 +794,15 @@
 	int minor = MINOR(inode->i_rdev);
 	lv_t *lv_ptr;
 	vg_t *vg_ptr = vg[VG_BLK(minor)];
-
+	lock_kernel();
 	P_DEV("blk_open MINOR: %d  VG#: %d  LV#: %d  mode: %s%s\n",
 	      minor, VG_BLK(minor), LV_BLK(minor), MODE_TO_STR(file->f_mode));
 
 #ifdef LVM_TOTAL_RESET
-	if (lvm_reset_spindown > 0)
+	if (lvm_reset_spindown > 0) {
+		unlock_kernel();
 		return -EPERM;
+	}
 #endif
 
 	if (vg_ptr != NULL &&
@@ -810,18 +812,25 @@
 	    LV_BLK(minor) < vg_ptr->lv_max) {
 
 		/* Check parallel LV spindown (LV remove) */
-		if (lv_ptr->lv_status & LV_SPINDOWN) return -EPERM;
+		if (lv_ptr->lv_status & LV_SPINDOWN) {
+			unlock_kernel();
+			return -EPERM;
+		}
 
 		/* Check inactive LV and open for read/write */
 		/* We need to be able to "read" an inactive LV
 		   to re-activate it again */
 		if ((file->f_mode & FMODE_WRITE) &&
-		    (!(lv_ptr->lv_status & LV_ACTIVE)))
+		    (!(lv_ptr->lv_status & LV_ACTIVE))) {
+		    unlock_kernel();
 		    return -EPERM;
+		}
 
 		if (!(lv_ptr->lv_access & LV_WRITE) &&
-		    (file->f_mode & FMODE_WRITE))
+		    (file->f_mode & FMODE_WRITE)) {
+			unlock_kernel();
 			return -EACCES;
+		}
 
 
                 /* be sure to increment VG counter */
@@ -832,8 +841,10 @@
 
 		P_DEV("blk_open OK, LV size %d\n", lv_ptr->lv_size);
 
+		unlock_kernel();
 		return 0;
 	}
+	unlock_kernel();
 	return -ENXIO;
 } /* lvm_blk_open() */
 
diff -ur linux-2.5.1-pre10/drivers/md/md.c linux/drivers/md/md.c
--- linux-2.5.1-pre10/drivers/md/md.c	Wed Dec 12 21:51:05 2001
+++ linux/drivers/md/md.c	Wed Dec 12 21:25:43 2001
@@ -2873,9 +2873,12 @@
 	/*
 	 * Always succeed, but increment the usage count
 	 */
-	mddev_t *mddev = kdev_to_mddev(inode->i_rdev);
+	mddev_t *mddev;
+	lock_kernel();
+	mddev = kdev_to_mddev(inode->i_rdev);
 	if (mddev)
 		atomic_inc(&mddev->active);
+	unlock_kernel();
 	return (0);
 }
 
diff -ur linux-2.5.1-pre10/drivers/message/i2o/i2o_block.c linux/drivers/message/i2o/i2o_block.c
--- linux-2.5.1-pre10/drivers/message/i2o/i2o_block.c	Wed Dec 12 21:51:05 2001
+++ linux/drivers/message/i2o/i2o_block.c	Wed Dec 12 21:25:43 2001
@@ -1190,16 +1190,25 @@
 {
 	int minor;
 	struct i2ob_device *dev;
+	int ret = 0;
+
+	lock_kernel();
 	
-	if (!inode)
-		return -EINVAL;
+	if (!inode) {
+		ret = -EINVAL;
+		goto out;
+	}
 	minor = MINOR(inode->i_rdev);
-	if (minor >= MAX_I2OB<<4)
-		return -ENODEV;
+	if (minor >= MAX_I2OB<<4) {
+		ret = -ENODEV;
+		goto out;
+	}
 	dev=&i2ob_dev[(minor&0xF0)];
 
-	if(!dev->i2odev)	
-		return -ENODEV;
+	if(!dev->i2odev) {
+		ret = -ENODEV;
+		goto out;
+	}
 	
 	if(dev->refcnt++==0)
 	{ 
@@ -1210,7 +1219,8 @@
 		{
 			dev->refcnt--;
 			printk(KERN_INFO "I2O Block: Could not open device\n");
-			return -EBUSY;
+			ret = -EBUSY;
+			goto out;
 		}
 		DEBUG("Claimed ");
 		
@@ -1236,8 +1246,9 @@
 		DEBUG("Lock ");
 		i2o_post_wait(dev->controller, msg, 20, 2);
 		DEBUG("Ready.\n");
-	}		
-	return 0;
+	}
+	unlock_kernel();
+	return ret;
 }
 
 /*
diff -ur linux-2.5.1-pre10/drivers/mtd/ftl.c linux/drivers/mtd/ftl.c
--- linux-2.5.1-pre10/drivers/mtd/ftl.c	Wed Dec 12 21:51:05 2001
+++ linux/drivers/mtd/ftl.c	Wed Dec 12 21:25:43 2001
@@ -880,34 +880,48 @@
 {
     int minor = MINOR(inode->i_rdev);
     partition_t *partition;
+    int ret = 0;
 
-    if (minor>>4 >= MAX_MTD_DEVICES)
-	return -ENODEV;
+    lock_kernel();
 
-    partition = myparts[minor>>4];
+    if (minor>>4 >= MAX_MTD_DEVICES) {
+	ret = -ENODEV;
+	goto out;
+    }
 
-    if (!partition)
-	return -ENODEV;
+    partition = myparts[minor>>4];
 
-    if (partition->state != FTL_FORMATTED)
-	return -ENXIO;
+    if (!partition) {
+	ret = -ENODEV;
+        goto out;
+    }    
+
+    if (partition->state != FTL_FORMATTED) {
+	ret = -ENXIO;
+        goto out;
+    }    
     
-    if (ftl_gendisk.part[minor].nr_sects == 0)
-	return -ENXIO;
+    if (ftl_gendisk.part[minor].nr_sects == 0) {
+	ret = -ENXIO;
+        goto out;
+    }    
 
-    if (!get_mtd_device(partition->mtd, -1))
-	    return /* -E'SBUGGEREDOFF */ -ENXIO;
+    if (!get_mtd_device(partition->mtd, -1)) {
+	    ret = /* -E'SBUGGEREDOFF */ -ENXIO;
 
     if ((file->f_mode & 2) && !(partition->mtd->flags & MTD_CLEAR_BITS) ) {
 	    put_mtd_device(partition->mtd);
-            return -EROFS;
-    }
+            ret = -EROFS;
+        goto out;
+    }    
     
     DEBUG(0, "ftl_cs: ftl_open(%d)\n", minor);
 
     atomic_inc(&partition->open);
 
-    return 0;
+out:
+    unlock_kernel();
+    return ret;
 }
 
 /*====================================================================*/
diff -ur linux-2.5.1-pre10/drivers/mtd/mtdblock.c linux/drivers/mtd/mtdblock.c
--- linux-2.5.1-pre10/drivers/mtd/mtdblock.c	Wed Dec 12 21:51:05 2001
+++ linux/drivers/mtd/mtdblock.c	Wed Dec 12 21:25:43 2001
@@ -277,22 +277,30 @@
 	struct mtdblk_dev *mtdblk;
 	struct mtd_info *mtd;
 	int dev;
+	int ret;
 
 	DEBUG(MTD_DEBUG_LEVEL1,"mtdblock_open\n");
 	
-	if (!inode)
-		return -EINVAL;
+	if (!inode) {
+		ret = -EINVAL;
+ 		goto out;
+	}
 	
 	dev = MINOR(inode->i_rdev);
-	if (dev >= MAX_MTD_DEVICES)
-		return -EINVAL;
+	if (dev >= MAX_MTD_DEVICES){
+                ret = -EINVAL;
+		goto out:
+	}
 
 	mtd = get_mtd_device(NULL, dev);
-	if (!mtd)
-		return -ENODEV;
+	if (!mtd) {
+		ret = -ENODEV;
+		goto out;
+	}
 	if (MTD_ABSENT == mtd->type) {
 		put_mtd_device(mtd);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 	
 	spin_lock(&mtdblks_lock);
@@ -301,7 +309,8 @@
 	if (mtdblks[dev]) {
 		mtdblks[dev]->count++;
 		spin_unlock(&mtdblks_lock);
-		return 0;
+		ret = 0;
+		goto out;
 	}
 	
 	/* OK, it's not open. Try to find it */
@@ -314,7 +323,8 @@
 	mtdblk = kmalloc(sizeof(struct mtdblk_dev), GFP_KERNEL);
 	if (!mtdblk) {
 		put_mtd_device(mtd);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 	memset(mtdblk, 0, sizeof(*mtdblk));
 	mtdblk->count = 1;
@@ -329,7 +339,8 @@
 		if (!mtdblk->cache_data) {
 			put_mtd_device(mtdblk->mtd);
 			kfree(mtdblk);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out;
 		}
 	}
 
@@ -344,7 +355,8 @@
 		put_mtd_device(mtdblk->mtd);
 		vfree(mtdblk->cache_data);
 		kfree(mtdblk);
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	mtdblks[dev] = mtdblk;
@@ -359,7 +371,8 @@
 	
 	DEBUG(MTD_DEBUG_LEVEL1, "ok\n");
 
-	return 0;
+out:	unlock_kernel()
+	return ret;
 }
 
 static release_t mtdblock_release(struct inode *inode, struct file *file)
diff -ur linux-2.5.1-pre10/drivers/mtd/mtdblock_ro.c linux/drivers/mtd/mtdblock_ro.c
--- linux-2.5.1-pre10/drivers/mtd/mtdblock_ro.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/mtd/mtdblock_ro.c	Wed Dec 12 21:25:43 2001
@@ -49,16 +49,21 @@
 
 	DEBUG(1,"mtdblock_open\n");
 	
-	if (inode == 0)
+	if (inode == 0) {
+		unlock_kernel()
 		return -EINVAL;
+	}
 	
 	dev = MINOR(inode->i_rdev);
 	
 	mtd = get_mtd_device(NULL, dev);
-	if (!mtd)
+	if (!mtd) {
+		unlock_kernel;
 		return -EINVAL;
+	}
 	if (MTD_ABSENT == mtd->type) {
 		put_mtd_device(mtd);
+		unlock_kernel();
 		return -EINVAL;
 	}
 
diff -ur linux-2.5.1-pre10/drivers/mtd/nftlcore.c linux/drivers/mtd/nftlcore.c
--- linux-2.5.1-pre10/drivers/mtd/nftlcore.c	Wed Dec 12 21:51:05 2001
+++ linux/drivers/mtd/nftlcore.c	Wed Dec 12 21:25:43 2001
@@ -940,6 +940,9 @@
 {
 	int nftlnum = MINOR(ip->i_rdev) >> NFTL_PARTN_BITS;
 	struct NFTLrecord *thisNFTL;
+
+	lock_kernel();
+
 	thisNFTL = NFTLs[nftlnum];
 
 	DEBUG(MTD_DEBUG_LEVEL2,"NFTL_open\n");
@@ -953,18 +956,24 @@
 	if (!thisNFTL) {
 		DEBUG(MTD_DEBUG_LEVEL2,"ENODEV: thisNFTL = %d, minor = %d, ip = %p, fp = %p\n", 
 		      nftlnum, ip->i_rdev, ip, fp);
+		unlock_kernel();
 		return -ENODEV;
 	}
 
 #ifndef CONFIG_NFTL_RW
-	if (fp->f_mode & FMODE_WRITE)
+	if (fp->f_mode & FMODE_WRITE) {
+		unlock_kernel();
 		return -EROFS;
+	}
 #endif /* !CONFIG_NFTL_RW */
 
 	thisNFTL->usecount++;
-	if (!get_mtd_device(thisNFTL->mtd, -1))
+	if (!get_mtd_device(thisNFTL->mtd, -1)) {
+		unlock_kernel();
 		return /* -E'SBUGGEREDOFF */ -ENXIO;
+	}
 
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre10/drivers/s390/block/dasd.c linux/drivers/s390/block/dasd.c
--- linux-2.5.1-pre10/drivers/s390/block/dasd.c	Wed Dec 12 21:51:05 2001
+++ linux/drivers/s390/block/dasd.c	Wed Dec 12 21:25:43 2001
@@ -2548,6 +2548,8 @@
         unsigned long flags;
 	dasd_device_t *device;
 
+	lock_kernel();
+
 	if ((!inp) || !(inp->i_rdev)) {
 		rc = -EINVAL;
                 goto fail;
@@ -2583,6 +2585,7 @@
  unlock:
         spin_unlock_irqrestore(&discipline_lock,flags);
  fail:
+	unlock_kernel();
 	return rc;
 }
 
diff -ur linux-2.5.1-pre10/drivers/s390/block/xpram.c linux/drivers/s390/block/xpram.c
--- linux-2.5.1-pre10/drivers/s390/block/xpram.c	Wed Dec 12 21:51:05 2001
+++ linux/drivers/s390/block/xpram.c	Wed Dec 12 21:25:43 2001
@@ -599,6 +599,7 @@
 	Xpram_Dev *dev; /* device information */
 	int num = MINOR(inode->i_rdev);
 
+	lock_kernel();
 
 	if (num >= xpram_devs) return -ENODEV;
 	dev = xpram_devices + num;
@@ -608,6 +609,7 @@
                      dev->size,dev->device_name, atomic_read(&(dev->usage)));
 
 	atomic_inc(&(dev->usage));
+	unlock_kernel();
 	return 0;          /* success */
 }
 
diff -ur linux-2.5.1-pre10/drivers/sbus/char/jsflash.c linux/drivers/sbus/char/jsflash.c
--- linux-2.5.1-pre10/drivers/sbus/char/jsflash.c	Wed Dec 12 21:51:05 2001
+++ linux/drivers/sbus/char/jsflash.c	Wed Dec 12 21:25:43 2001
@@ -490,17 +490,23 @@
 	struct jsfd_part *jdp;
 	int dev;
 
-	if (!inode)
+	lock_kernel();
+
+	if (!inode) {
+		unlock_kernel();
 		return -EINVAL;
+	}
 	dev = MINOR(inode->i_rdev);
 	if (dev >= JSF_MAX || (dev & JSF_PART_MASK) >= JSF_NPART) {
 		printk(KERN_ALERT "jsfd_open: illegal minor %d\n", dev);
+		unlock_kernel();
 		return -ENODEV;
 	}
 
 	jdp = &jsf0.dv[dev];
 	jdp->refcnt++;
 
+	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre10/drivers/scsi/sd.c linux/drivers/scsi/sd.c
--- linux-2.5.1-pre10/drivers/scsi/sd.c	Wed Dec 12 21:51:05 2001
+++ linux/drivers/scsi/sd.c	Wed Dec 12 21:25:43 2001
@@ -434,16 +434,20 @@
 	Scsi_Device * SDev;
 	target = DEVICE_NR(inode->i_rdev);
 
+	lock_kernel();
+
 	SCSI_LOG_HLQUEUE(1, printk("target=%d, max=%d\n", target, sd_template.dev_max));
 
-	if (target >= sd_template.dev_max || !rscsi_disks[target].device)
+	if (target >= sd_template.dev_max || !rscsi_disks[target].device) {
+		unlock_kernel();
 		return -ENXIO;	/* No such device */
-
+	}
 	/*
 	 * If the device is in error recovery, wait until it is done.
 	 * If the device is offline, then disallow any access to it.
 	 */
 	if (!scsi_block_when_processing_errors(rscsi_disks[target].device)) {
+		unlock_kernel();
 		return -ENXIO;
 	}
 	/*
@@ -512,7 +516,7 @@
 			if (scsi_block_when_processing_errors(SDev))
 				scsi_ioctl(SDev, SCSI_IOCTL_DOORLOCK, NULL);
 
-	
+	unlock_kernel();
 	return 0;
 
 error_out:
@@ -521,6 +525,7 @@
 		__MOD_DEC_USE_COUNT(SDev->host->hostt->module);
 	if (sd_template.module)
 		__MOD_DEC_USE_COUNT(sd_template.module);
+	unlock_kernel();
 	return retval;	
 }
 
diff -ur linux-2.5.1-pre10/fs/block_dev.c linux/fs/block_dev.c
--- linux-2.5.1-pre10/fs/block_dev.c	Wed Dec 12 21:51:06 2001
+++ linux/fs/block_dev.c	Wed Dec 12 21:42:22 2001
@@ -428,6 +428,7 @@
 {
 	const struct block_device_operations *ret = NULL;
 
+	lock_kernel();
 	/* major 0 is used for non-device mounts */
 	if (major && major < MAX_BLKDEV) {
 #ifdef CONFIG_KMOD
@@ -439,6 +440,7 @@
 #endif
 		ret = blkdevs[major].bdops;
 	}
+	unlock_kernel();
 	return ret;
 }
 
@@ -531,19 +533,21 @@
 	return res;
 }
 
+extern struct semaphore unload_sem;
 static int do_open(struct block_device *bdev, struct inode *inode, struct file *file)
 {
 	int ret = -ENXIO;
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
 
 	down(&bdev->bd_sem);
-	lock_kernel();
+	down(&unload_sem);
 	if (!bdev->bd_op)
 		bdev->bd_op = get_blkfops(MAJOR(dev));
 	if (bdev->bd_op) {
 		ret = 0;
 		if (bdev->bd_op->owner)
 			__MOD_INC_USE_COUNT(bdev->bd_op->owner);
+		up(&unload_sem);
 		if (bdev->bd_op->open)
 			ret = bdev->bd_op->open(inode, file);
 		if (!ret) {
@@ -556,8 +560,9 @@
 			if (!bdev->bd_openers)
 				bdev->bd_op = NULL;
 		}
+	} else {
+		up(&unload_sem);
 	}
-	unlock_kernel();
 	up(&bdev->bd_sem);
 	if (ret)
 		bdput(bdev);
diff -ur linux-2.5.1-pre10/kernel/module.c linux/kernel/module.c
--- linux-2.5.1-pre10/kernel/module.c	Sun Nov 11 11:23:14 2001
+++ linux/kernel/module.c	Wed Dec 12 21:25:43 2001
@@ -576,17 +576,17 @@
 	return error;
 }
 
-static spinlock_t unload_lock = SPIN_LOCK_UNLOCKED;
+DECLARE_MUTEX( unload_sem );
 int try_inc_mod_count(struct module *mod)
 {
 	int res = 1;
 	if (mod) {
-		spin_lock(&unload_lock);
+		down(&unload_sem);
 		if (mod->flags & MOD_DELETED)
 			res = 0;
 		else
 			__MOD_INC_USE_COUNT(mod);
-		spin_unlock(&unload_lock);
+		up(&unload_sem);
 	}
 	return res;
 }
@@ -616,14 +616,14 @@
 		if (mod->refs != NULL)
 			goto out;
 
-		spin_lock(&unload_lock);
+		down(&unload_sem);
 		if (!__MOD_IN_USE(mod)) {
 			mod->flags |= MOD_DELETED;
-			spin_unlock(&unload_lock);
+			up(&unload_sem);
 			free_module(mod, 0);
 			error = 0;
 		} else {
-			spin_unlock(&unload_lock);
+			up(&unload_sem);
 		}
 		goto out;
 	}
@@ -634,7 +634,8 @@
 	
 	for (mod = module_list; mod != &kernel_module; mod = next) {
 		next = mod->next;
-		spin_lock(&unload_lock);
+		down(&unload_sem);
+
 		if (mod->refs == NULL
 		    && (mod->flags & MOD_AUTOCLEAN)
 		    && (mod->flags & MOD_RUNNING)
@@ -643,16 +644,16 @@
 		    && !__MOD_IN_USE(mod)) {
 			if ((mod->flags & MOD_VISITED)
 			    && !(mod->flags & MOD_JUST_FREED)) {
-				spin_unlock(&unload_lock);
+			        up(&unload_sem);
 				mod->flags &= ~MOD_VISITED;
 			} else {
 				mod->flags |= MOD_DELETED;
-				spin_unlock(&unload_lock);
+				up(&unload_sem);
 				free_module(mod, 1);
 				something_changed = 1;
 			}
 		} else {
-			spin_unlock(&unload_lock);
+			up(&unload_sem);
 		}
 	}
 	

--------------020708060604030502040200--

