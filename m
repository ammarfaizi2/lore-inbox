Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291152AbSAaRHF>; Thu, 31 Jan 2002 12:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291155AbSAaRGu>; Thu, 31 Jan 2002 12:06:50 -0500
Received: from zero.tech9.net ([209.61.188.187]:59145 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291152AbSAaRGe>;
	Thu, 31 Jan 2002 12:06:34 -0500
Subject: [PATCH] 2.5: further llseek cleanup (3/3)
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 31 Jan 2002 12:11:59 -0500
Message-Id: <1012497140.3219.163.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

[ This is a resend.  It seems it never made it to the list. ]

The previous patch did not provide protection for device lseek methods
(drivers/* stuff).  This patch pushes the BKL into each of the remaining
lseek methods -- without them we have a race.

I'd much prefer to have a a better lock to push down than the BKL, but
that will have to wait.

Before you balk at the size, remember patch #2 in this series which
removed much code ;-)

Thanks to Al for assistance, especially a listing of affected files.

	Robert Love

diff -urN linux-2.5.3/arch/cris/drivers/eeprom.c
linux/arch/cris/drivers/eeprom.c
--- linux-2.5.3/arch/cris/drivers/eeprom.c	Wed Jan 30 16:12:06 2002
+++ linux/arch/cris/drivers/eeprom.c	Thu Jan 31 00:32:55 2002
@@ -74,6 +74,7 @@
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include "i2c.h"
 
@@ -448,36 +449,39 @@
  *  orig 1: relative from current position
  *  orig 2: position from last eeprom address
  */
-  
+  loff_t ret;
+
+  lock_kernel();
+
   switch (orig)
   {
    case 0:
-     file->f_pos = offset;
+     ret = file->f_pos = offset;
      break;
    case 1:
-     file->f_pos += offset;
+     ret = file->f_pos += offset;
      break;
    case 2:
-     file->f_pos = eeprom.size - offset;
+     ret = file->f_pos = eeprom.size - offset;
      break;
    default:
-     return -EINVAL;
+     ret = -EINVAL;
   }
 
   /* truncate position */
   if (file->f_pos < 0)
   {
     file->f_pos = 0;    
-    return(-EOVERFLOW);
+    ret = -EOVERFLOW;
   }
   
   if (file->f_pos >= eeprom.size)
   {
     file->f_pos = eeprom.size - 1;
-    return(-EOVERFLOW);
+    ret = -EOVERFLOW;
   }
 
-  return ( file->f_pos );
+  return ( ret );
 }
 
 /* Reads data from eeprom. */
diff -urN linux-2.5.3/arch/i386/kernel/cpuid.c
linux/arch/i386/kernel/cpuid.c
--- linux-2.5.3/arch/i386/kernel/cpuid.c	Wed Jan 30 16:12:05 2002
+++ linux/arch/i386/kernel/cpuid.c	Thu Jan 31 00:34:51 2002
@@ -35,6 +35,7 @@
 #include <linux/poll.h>
 #include <linux/smp.h>
 #include <linux/major.h>
+#include <linux/smp_lock.h>
 
 #include <asm/processor.h>
 #include <asm/msr.h>
@@ -82,16 +83,24 @@
 
 static loff_t cpuid_seek(struct file *file, loff_t offset, int orig)
 {
+  loff_t ret;
+
+  lock_kernel();
+
   switch (orig) {
   case 0:
     file->f_pos = offset;
-    return file->f_pos;
+    ret = file->f_pos;
+    break;
   case 1:
     file->f_pos += offset;
-    return file->f_pos;
+    ret = file->f_pos;
   default:
-    return -EINVAL;	/* SEEK_END not supported */
+    ret = -EINVAL;
   }
+
+  unlock_kernel();
+  return ret;
 }
 
 static ssize_t cpuid_read(struct file * file, char * buf,
diff -urN linux-2.5.3/arch/i386/kernel/msr.c
linux/arch/i386/kernel/msr.c
--- linux-2.5.3/arch/i386/kernel/msr.c	Wed Jan 30 16:12:05 2002
+++ linux/arch/i386/kernel/msr.c	Thu Jan 31 00:19:42 2002
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 #include <linux/poll.h>
 #include <linux/smp.h>
+#include <linux/smp_lock.h>
 #include <linux/major.h>
 
 #include <asm/processor.h>
@@ -162,16 +163,19 @@
 
 static loff_t msr_seek(struct file *file, loff_t offset, int orig)
 {
+  loff_t ret = -EINVAL;
+  lock_kernel();
   switch (orig) {
   case 0:
     file->f_pos = offset;
-    return file->f_pos;
+    ret = file->f_pos;
+    break;
   case 1:
     file->f_pos += offset;
-    return file->f_pos;
-  default:
-    return -EINVAL;	/* SEEK_END not supported */
+    ret = file->f_pos;
   }
+  unlock_kernel();
+  return ret;
 }
 
 static ssize_t msr_read(struct file * file, char * buf,
diff -urN linux-2.5.3/arch/ppc/kernel/ppc_htab.c
linux/arch/ppc/kernel/ppc_htab.c
--- linux-2.5.3/arch/ppc/kernel/ppc_htab.c	Wed Jan 30 16:12:05 2002
+++ linux/arch/ppc/kernel/ppc_htab.c	Thu Jan 31 00:19:42 2002
@@ -21,6 +21,7 @@
 #include <linux/sysctl.h>
 #include <linux/ctype.h>
 #include <linux/threads.h>
+#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -430,18 +431,20 @@
 static long long
 ppc_htab_lseek(struct file * file, loff_t offset, int orig)
 {
+    long long ret = -EINVAL;
+
+    lock_kernel();
     switch (orig) {
     case 0:
 	file->f_pos = offset;
-	return(file->f_pos);
+	ret = file->f_pos;
+	break;
     case 1:
 	file->f_pos += offset;
-	return(file->f_pos);
-    case 2:
-	return(-EINVAL);
-    default:
-	return(-EINVAL);
+	ret = file->f_pos;
     }
+    unlock_kernel();
+    return ret;
 }
 
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
diff -urN linux-2.5.3/drivers/char/mem.c linux/drivers/char/mem.c
--- linux-2.5.3/drivers/char/mem.c	Wed Jan 30 16:12:04 2002
+++ linux/drivers/char/mem.c	Thu Jan 31 00:19:42 2002
@@ -21,6 +21,7 @@
 #include <linux/raw.h>
 #include <linux/tty.h>
 #include <linux/capability.h>
+#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -466,16 +467,23 @@
  */
 static loff_t memory_lseek(struct file * file, loff_t offset, int orig)
 {
+	int ret;
+
+	lock_kernel();
 	switch (orig) {
 		case 0:
 			file->f_pos = offset;
-			return file->f_pos;
+			ret = file->f_pos;
+			break;
 		case 1:
 			file->f_pos += offset;
-			return file->f_pos;
+			ret = file->f_pos;
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
 	}
+	unlock_kernel();
+	return ret;
 }
 
 static int open_port(struct inode * inode, struct file * filp)
diff -urN linux-2.5.3/drivers/char/nvram.c linux/drivers/char/nvram.c
--- linux-2.5.3/drivers/char/nvram.c	Wed Jan 30 16:12:04 2002
+++ linux/drivers/char/nvram.c	Thu Jan 31 00:19:42 2002
@@ -216,6 +216,7 @@
 
 static long long nvram_llseek(struct file *file,loff_t offset, int
origin )
 {
+	lock_kernel();
 	switch( origin ) {
 	  case 0:
 		/* nothing to do */
@@ -227,6 +228,7 @@
 		offset += NVRAM_BYTES;
 		break;
 	}
+	unlock_kernel();
 	return( (offset >= 0) ? (file->f_pos = offset) : -EINVAL );
 }
 
diff -urN linux-2.5.3/drivers/char/nwflash.c
linux/drivers/char/nwflash.c
--- linux-2.5.3/drivers/char/nwflash.c	Wed Jan 30 16:12:04 2002
+++ linux/drivers/char/nwflash.c	Thu Jan 31 00:19:42 2002
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/rwsem.h>
 #include <linux/init.h>
+#include <linux/smp_lock.h>
 
 #include <asm/hardware/dec21285.h>
 #include <asm/io.h>
@@ -301,30 +302,45 @@
  */
 static long long flash_llseek(struct file *file, long long offset, int
orig)
 {
+	long long ret;
+
+	lock_kernel();
 	if (flashdebug)
 		printk(KERN_DEBUG "flash_llseek: offset=0x%X, orig=0x%X.\n",
 		       (unsigned int) offset, orig);
 
 	switch (orig) {
 	case 0:
-		if (offset < 0)
-			return -EINVAL;
+		if (offset < 0) {
+			ret = -EINVAL;
+			break;
+		}
 
-		if ((unsigned int) offset > gbFlashSize)
-			return -EINVAL;
+		if ((unsigned int) offset > gbFlashSize) {
+			ret = -EINVAL;
+			break;
+		}
 
 		file->f_pos = (unsigned int) offset;
-		return file->f_pos;
+		ret = file->f_pos;
+		break;
 	case 1:
-		if ((file->f_pos + offset) > gbFlashSize)
-			return -EINVAL;
-		if ((file->f_pos + offset) < 0)
-			return -EINVAL;
+		if ((file->f_pos + offset) > gbFlashSize) {
+			ret = -EINVAL;
+			break;
+		}
+		if ((file->f_pos + offset) < 0) {
+			ret = -EINVAL;
+			break;
+		}
 		file->f_pos += offset;
-		return file->f_pos;
+		ret = file->f_pos;
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+	unlock_kernel();
+	return ret;
 }
 

diff -urN linux-2.5.3/drivers/char/vc_screen.c
linux/drivers/char/vc_screen.c
--- linux-2.5.3/drivers/char/vc_screen.c	Wed Jan 30 16:12:04 2002
+++ linux/drivers/char/vc_screen.c	Thu Jan 31 00:19:42 2002
@@ -36,6 +36,7 @@
 #include <linux/selection.h>
 #include <linux/kbd_kern.h>
 #include <linux/console.h>
+#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
@@ -67,10 +68,13 @@
 
 static loff_t vcs_lseek(struct file *file, loff_t offset, int orig)
 {
-	int size = vcs_size(file->f_dentry->d_inode);
+	int size;
 
+	lock_kernel();
+	size = vcs_size(file->f_dentry->d_inode);
 	switch (orig) {
 		default:
+			unlock_kernel();
 			return -EINVAL;
 		case 2:
 			offset += size;
@@ -80,9 +84,12 @@
 		case 0:
 			break;
 	}
-	if (offset < 0 || offset > size)
+	if (offset < 0 || offset > size) {
+		unlock_kernel();
 		return -EINVAL;
+	}
 	file->f_pos = offset;
+	unlock_kernel();
 	return file->f_pos;
 }
 
diff -urN linux-2.5.3/drivers/ieee1394/pcilynx.c
linux/drivers/ieee1394/pcilynx.c
--- linux-2.5.3/drivers/ieee1394/pcilynx.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/ieee1394/pcilynx.c	Thu Jan 31 00:21:09 2002
@@ -29,6 +29,7 @@
 #include <linux/pci.h>
 #include <linux/fs.h>
 #include <linux/poll.h>
+#include <linux/smp_lock.h>
 #include <asm/byteorder.h>
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -732,8 +733,9 @@
 
 loff_t mem_llseek(struct file *file, loff_t offs, int orig)
 {
-        loff_t newoffs;
+        loff_t newoffs = -1;
 
+        lock_kernel();
         switch (orig) {
         case 0:
                 newoffs = offs;
@@ -743,12 +745,12 @@
                 break;
         case 2:
                 newoffs = PCILYNX_MAX_MEMORY + 1 + offs;
-                break;
-        default:
-                return -EINVAL;
         }
 
-        if (newoffs < 0 || newoffs > PCILYNX_MAX_MEMORY + 1) return
-EINVAL;
+        if (newoffs < 0 || newoffs > PCILYNX_MAX_MEMORY + 1) {
+                lock_kernel();
+                return -EINVAL;
+        }
 
         file->f_pos = newoffs;
         return newoffs;
diff -urN linux-2.5.3/drivers/macintosh/nvram.c
linux/drivers/macintosh/nvram.c
--- linux-2.5.3/drivers/macintosh/nvram.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/macintosh/nvram.c	Thu Jan 31 00:19:42 2002
@@ -13,6 +13,7 @@
 #include <linux/fcntl.h>
 #include <linux/nvram.h>
 #include <linux/init.h>
+#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include <asm/nvram.h>
 
@@ -20,6 +21,7 @@
 
 static loff_t nvram_llseek(struct file *file, loff_t offset, int
origin)
 {
+	lock_kernel();
 	switch (origin) {
 	case 1:
 		offset += file->f_pos;
@@ -28,9 +30,12 @@
 		offset += NVRAM_SIZE;
 		break;
 	}
-	if (offset < 0)
+	if (offset < 0) {
+		unlock_kernel();
 		return -EINVAL;
+	}
 	file->f_pos = offset;
+	unlock_kernel();
 	return file->f_pos;
 }
 
diff -urN linux-2.5.3/drivers/mtd/mtdchar.c linux/drivers/mtd/mtdchar.c
--- linux-2.5.3/drivers/mtd/mtdchar.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/mtd/mtdchar.c	Thu Jan 31 00:19:42 2002
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
+#include <linux/smp_lock.h>
 #include <linux/slab.h>
 
 #ifdef CONFIG_DEVFS_FS
@@ -31,6 +32,7 @@
 {
 	struct mtd_info *mtd=(struct mtd_info *)file->private_data;
 
+	lock_kernel();
 	switch (orig) {
 	case 0:
 		/* SEEK_SET */
@@ -45,6 +47,7 @@
 		file->f_pos =mtd->size + offset;
 		break;
 	default:
+		unlock_kernel();
 		return -EINVAL;
 	}
 
@@ -53,6 +56,7 @@
 	else if (file->f_pos >= mtd->size)
 		file->f_pos = mtd->size - 1;
 
+	unlock_kernel();
 	return file->f_pos;
 }
 
diff -urN linux-2.5.3/drivers/pci/proc.c linux/drivers/pci/proc.c
--- linux-2.5.3/drivers/pci/proc.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/pci/proc.c	Thu Jan 31 00:19:42 2002
@@ -12,6 +12,7 @@
 #include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
+#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -21,8 +22,9 @@
 static loff_t
 proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
 {
-	loff_t new;
+	loff_t new = -1;
 
+	lock_kernel();
 	switch (whence) {
 	case 0:
 		new = off;
@@ -33,9 +35,8 @@
 	case 2:
 		new = PCI_CFG_SPACE_SIZE + off;
 		break;
-	default:
-		return -EINVAL;
 	}
+	unlock_kernel();
 	if (new < 0 || new > PCI_CFG_SPACE_SIZE)
 		return -EINVAL;
 	return (file->f_pos = new);
diff -urN linux-2.5.3/drivers/pnp/isapnp_proc.c
linux/drivers/pnp/isapnp_proc.c
--- linux-2.5.3/drivers/pnp/isapnp_proc.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/pnp/isapnp_proc.c	Thu Jan 31 00:39:37 2002
@@ -84,18 +84,26 @@
 
 static loff_t isapnp_info_entry_lseek(struct file *file, loff_t offset,
int orig)
 {
+	loff_t ret;
+
+	lock_kernel();
+
 	switch (orig) {
 	case 0:	/* SEEK_SET */
 		file->f_pos = offset;
-		return file->f_pos;
+		ret = file->f_pos;
+		break;
 	case 1:	/* SEEK_CUR */
 		file->f_pos += offset;
-		return file->f_pos;
+		ret = file->f_pos;
+		break;
 	case 2:	/* SEEK_END */
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
-	return -ENXIO;
+
+	unlock_kernel();
+	return ret;
 }
 
 static ssize_t isapnp_info_entry_read(struct file *file, char *buffer,
@@ -211,8 +219,9 @@
 
 static loff_t isapnp_proc_bus_lseek(struct file *file, loff_t off, int
whence)
 {
-	loff_t new;
-	
+	loff_t new = -1;
+
+	lock_kernel();
 	switch (whence) {
 	case 0:
 		new = off;
@@ -223,11 +232,12 @@
 	case 2:
 		new = 256 + off;
 		break;
-	default:
-		return -EINVAL;
 	}
-	if (new < 0 || new > 256)
+	if (new < 0 || new > 256) {
+		unlock_kernel();
 		return -EINVAL;
+	}
+	unlock_kernel();
 	return (file->f_pos = new);
 }
 
diff -urN linux-2.5.3/drivers/sbus/char/flash.c
linux/drivers/sbus/char/flash.c
--- linux-2.5.3/drivers/sbus/char/flash.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/sbus/char/flash.c	Thu Jan 31 00:19:42 2002
@@ -83,6 +83,7 @@
 static long long
 flash_llseek(struct file *file, long long offset, int origin)
 {
+	lock_kernel();
 	switch (origin) {
 		case 0:
 			file->f_pos = offset;
@@ -96,8 +97,10 @@
 			file->f_pos = flash.read_size;
 			break;
 		default:
+			unlock_kernel();
 			return -EINVAL;
 	}
+	unlock_kernel();
 	return file->f_pos;
 }
 
diff -urN linux-2.5.3/drivers/sbus/char/jsflash.c
linux/drivers/sbus/char/jsflash.c
--- linux-2.5.3/drivers/sbus/char/jsflash.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/sbus/char/jsflash.c	Thu Jan 31 00:23:32 2002
@@ -259,16 +259,23 @@
  */
 static loff_t jsf_lseek(struct file * file, loff_t offset, int orig)
 {
+	loff_t ret;
+
+	lock_kernel();
 	switch (orig) {
 		case 0:
 			file->f_pos = offset;
-			return file->f_pos;
+			ret = file->f_pos;
+			break;
 		case 1:
 			file->f_pos += offset;
-			return file->f_pos;
+			ret = file->f_pos;
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
 	}
+	unlock_kernel();
+	return ret;
 }
 
 /*
diff -urN linux-2.5.3/drivers/usb/devices.c linux/drivers/usb/devices.c
--- linux-2.5.3/drivers/usb/devices.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/usb/devices.c	Thu Jan 31 00:24:33 2002
@@ -554,21 +554,26 @@
 
 static loff_t usb_device_lseek(struct file * file, loff_t offset, int
orig)
 {
+	loff_t ret;
+
+	lock_kernel();
+
 	switch (orig) {
 	case 0:
 		file->f_pos = offset;
-		return file->f_pos;
-
+		ret = file->f_pos;
+		break;
 	case 1:
 		file->f_pos += offset;
-		return file->f_pos;
-
+		ret = file->f_pos;
+		break;
 	case 2:
-		return -EINVAL;
-
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+	unlock_kernel();
+	return ret;
 }
 
 struct file_operations usbdevfs_devices_fops = {
diff -urN linux-2.5.3/drivers/usb/devio.c linux/drivers/usb/devio.c
--- linux-2.5.3/drivers/usb/devio.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/usb/devio.c	Thu Jan 31 00:25:20 2002
@@ -58,21 +58,26 @@
 
 static loff_t usbdev_lseek(struct file *file, loff_t offset, int orig)
 {
+	loff_t ret;
+
+	lock_kernel();
+
 	switch (orig) {
 	case 0:
 		file->f_pos = offset;
-		return file->f_pos;
-
+		ret = file->f_pos;
+		break;
 	case 1:
 		file->f_pos += offset;
-		return file->f_pos;
-
+		ret = file->f_pos;
+		break;
 	case 2:
-		return -EINVAL;
-
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+	unlock_kernel();
+	return ret;
 }
 
 static ssize_t usbdev_read(struct file *file, char * buf, size_t
nbytes, loff_t *ppos)
diff -urN linux-2.5.3/drivers/usb/drivers.c linux/drivers/usb/drivers.c
--- linux-2.5.3/drivers/usb/drivers.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/usb/drivers.c	Thu Jan 31 00:26:38 2002
@@ -38,6 +38,7 @@
 #include <linux/mm.h>
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
+#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 
 /*****************************************************************/
@@ -96,21 +97,24 @@
 
 static loff_t usb_driver_lseek(struct file * file, loff_t offset, int
orig)
 {
+	loff_t ret;
+
+	lock_kernel();
 	switch (orig) {
 	case 0:
 		file->f_pos = offset;
-		return file->f_pos;
-
+		ret = file->f_pos;
+		break;
 	case 1:
 		file->f_pos += offset;
-		return file->f_pos;
-
+		ret = file->f_pos;
+		break;
 	case 2:
-		return -EINVAL;
-
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+	unlock_kernel();
+	return ret;
 }
 
 struct file_operations usbdevfs_drivers_fops = {
diff -urN linux-2.5.3/drivers/usb/inode.c linux/drivers/usb/inode.c
--- linux-2.5.3/drivers/usb/inode.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/usb/inode.c	Thu Jan 31 00:19:42 2002
@@ -36,7 +36,7 @@
 #include <linux/proc_fs.h>
 #include <linux/usb.h>
 #include <linux/usbdevice_fs.h>
-
+#include <linux/smp_lock.h>
 
 static struct super_operations usbfs_ops;
 static struct address_space_operations usbfs_aops;
@@ -295,6 +295,7 @@
 {
 	loff_t retval = -EINVAL;
 
+	lock_kernel();
 	switch(orig) {
 	case 0:
 		if (offset > 0) {
@@ -311,6 +312,7 @@
 	default:
 		break;
 	}
+	unlock_kernel();
 	return retval;
 }
 
diff -urN linux-2.5.3/drivers/usb/uhci-debug.h
linux/drivers/usb/uhci-debug.h
--- linux-2.5.3/drivers/usb/uhci-debug.h	Wed Jan 30 16:12:05 2002
+++ linux/drivers/usb/uhci-debug.h	Thu Jan 31 00:19:42 2002
@@ -12,6 +12,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/proc_fs.h>
+#include <linux/smp_lock.h>
 #include <asm/io.h>
 
 #include "uhci.h"
@@ -507,8 +508,11 @@
 
 static loff_t uhci_proc_lseek(struct file *file, loff_t off, int
whence)
 {
-	struct uhci_proc *up = file->private_data;
-	loff_t new;
+	struct uhci_proc *up;
+	loff_t new = -1;
+
+	lock_kernel();
+	up = file->private_data;
 
 	switch (whence) {
 	case 0:
@@ -517,12 +521,12 @@
 	case 1:
 		new = file->f_pos + off;
 		break;
-	case 2:
-	default:
-		return -EINVAL;
 	}
-	if (new < 0 || new > up->size)
+	if (new < 0 || new > up->size) {
+		unlock_kernel();
 		return -EINVAL;
+	}
+	unlock_kernel();
 	return (file->f_pos = new);
 }
 
diff -urN linux-2.5.3/drivers/zorro/proc.c linux/drivers/zorro/proc.c
--- linux-2.5.3/drivers/zorro/proc.c	Wed Jan 30 16:12:05 2002
+++ linux/drivers/zorro/proc.c	Thu Jan 31 00:19:42 2002
@@ -14,6 +14,7 @@
 #include <linux/zorro.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
+#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include <asm/amigahw.h>
 #include <asm/setup.h>
@@ -21,7 +22,7 @@
 static loff_t
 proc_bus_zorro_lseek(struct file *file, loff_t off, int whence)
 {
-	loff_t new;
+	loff_t new = -1;
 
 	switch (whence) {
 	case 0:
@@ -33,11 +34,12 @@
 	case 2:
 		new = sizeof(struct ConfigDev) + off;
 		break;
-	default:
-		return -EINVAL;
 	}
-	if (new < 0 || new > sizeof(struct ConfigDev))
+	if (new < 0 || new > sizeof(struct ConfigDev)) {
+		unlock_kernel();
 		return -EINVAL;
+	}
+	unlock_kernel();
 	return (file->f_pos = new);
 }
 
diff -urN linux-2.5.3/fs/driverfs/inode.c linux/fs/driverfs/inode.c
--- linux-2.5.3/fs/driverfs/inode.c	Wed Jan 30 16:12:03 2002
+++ linux/fs/driverfs/inode.c	Thu Jan 31 00:19:42 2002
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 
@@ -341,6 +342,7 @@
 {
 	loff_t retval = -EINVAL;
 
+	lock_kernel();
 	switch(orig) {
 	case 0:
 		if (offset > 0) {
@@ -357,6 +359,7 @@
 	default:
 		break;
 	}
+	unlock_kernel();
 	return retval;
 }
 

