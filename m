Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUIUP1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUIUP1k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 11:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUIUP1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 11:27:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:18392 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267737AbUIUP1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 11:27:25 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mmtimer cleanups
Date: Tue, 21 Sep 2004 11:26:32 -0400
User-Agent: KMail/1.7
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200409171313.12302.jbarnes@engr.sgi.com> <20040917212843.A17201@infradead.org>
In-Reply-To: <20040917212843.A17201@infradead.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ogEUBeBa/+b4D7Y"
Message-Id: <200409211126.32965.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ogEUBeBa/+b4D7Y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, September 17, 2004 4:28 pm, Christoph Hellwig wrote:
> On Fri, Sep 17, 2004 at 01:13:12PM -0700, Jesse Barnes wrote:
> > A few cleanups that probably should have been done a long time ago:
> >
> >   o remove test program from mmtimer.h
> >   o move name, desc., etc. #defines from mmtimer.h to mmtimer.c
> >   o document what mmtimer.c is a little better
> >   o some whitespace cleanups for linewrapping and such
> >
> > Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
> >
> > Thanks,
> > Jesse
> >
> > +#define MMTIMER_FULLNAME "/dev/mmtimer"
>
> Shouldn't be needed ;-)

Updated patch that drops MMTIMER_FULLNAME.

Jesse

A few cleanups that probably should have been done a long time ago:

  o remove test program from mmtimer.h
  o move name, desc., etc. #defines from mmtimer.h to mmtimer.c
  o document what mmtimer.c is a little better
  o some whitespace cleanups for linewrapping and such

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>


--Boundary-00=_ogEUBeBa/+b4D7Y
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mmtimer-cleanups-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mmtimer-cleanups-2.patch"

===== drivers/char/mmtimer.c 1.1 vs edited =====
--- 1.1/drivers/char/mmtimer.c	2004-09-17 00:07:01 -07:00
+++ edited/drivers/char/mmtimer.c	2004-09-21 08:24:44 -07:00
@@ -5,10 +5,11 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 2001-2003 Silicon Graphics, Inc.  All rights reserved.
+ * Copyright (c) 2001-2004 Silicon Graphics, Inc.  All rights reserved.
  *
- * This driver implements a subset of the interface required by the
- * IA-PC Multimedia Timers Draft Specification (rev. 0.97) from Intel.
+ * This driver exports an API that should be supportable by any HPET or IA-PC
+ * multimedia timer.  The code below is currently specific to the SGI Altix
+ * SHub RTC, however.
  *
  * 11/01/01 - jbarnes - initial revision
  * 9/10/04 - Christoph Lameter - remove interrupt support for kernel inclusion
@@ -32,9 +33,15 @@
 MODULE_DESCRIPTION("Multimedia timer support");
 MODULE_LICENSE("GPL");
 
+/* name of the device, usually in /dev */
+#define MMTIMER_NAME "mmtimer"
+#define MMTIMER_DESC "IA-PC Multimedia Timer"
+#define MMTIMER_VERSION "1.0"
+
 #define RTC_BITS 55 /* 55 bits for this implementation */
 
-static int mmtimer_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
+static int mmtimer_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long arg);
 static int mmtimer_mmap(struct file *file, struct vm_area_struct *vma);
 
 /*
@@ -55,8 +62,10 @@
  * @cmd: command to execute
  * @arg: optional argument to command
  *
- * Executes the command specified by @cmd.  Returns 0 for success, <0 for failure.
- * Valid commands are
+ * Executes the command specified by @cmd.  Returns 0 for success, < 0 for
+ * failure.
+ *
+ * Valid commands:
  *
  * %MMTIMER_GETOFFSET - Should return the offset (relative to the start
  * of the page where the registers are mapped) for the counter in question.
@@ -74,8 +83,8 @@
  * %MMTIMER_GETCOUNTER - Gets the current value in the counter and places it
  * in the address specified by @arg.
  */
-static int
-mmtimer_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+static int mmtimer_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long arg)
 {
 	int ret = 0;
 
@@ -91,12 +100,15 @@
 		break;
 
 	case MMTIMER_GETRES: /* resolution of the clock in 10^-15 s */
-		if(copy_to_user((unsigned long *)arg, &mmtimer_femtoperiod, sizeof(unsigned long)))
+		if(copy_to_user((unsigned long *)arg, &mmtimer_femtoperiod,
+				sizeof(unsigned long)))
 			return -EFAULT;
 		break;
 
 	case MMTIMER_GETFREQ: /* frequency in Hz */
-		if(copy_to_user((unsigned long *)arg, &sn_rtc_cycles_per_second, sizeof(unsigned long)))
+		if(copy_to_user((unsigned long *)arg,
+				&sn_rtc_cycles_per_second,
+				sizeof(unsigned long)))
 			return -EFAULT;
 		ret = 0;
 		break;
@@ -110,7 +122,8 @@
 		break;
 
 	case MMTIMER_GETCOUNTER:
-		if(copy_to_user((unsigned long *)arg, RTC_COUNTER_ADDR, sizeof(unsigned long)))
+		if(copy_to_user((unsigned long *)arg, RTC_COUNTER_ADDR,
+				sizeof(unsigned long)))
 			return -EFAULT;
 		break;
 	default:
@@ -129,8 +142,7 @@
  * Calls remap_page_range() to map the clock's registers into
  * the calling process' address space.
  */
-static int
-mmtimer_mmap(struct file *file, struct vm_area_struct *vma)
+static int mmtimer_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	unsigned long mmtimer_addr;
 
@@ -150,7 +162,8 @@
 	mmtimer_addr &= ~(PAGE_SIZE - 1);
 	mmtimer_addr &= 0xfffffffffffffffUL;
 
-	if (remap_page_range(vma, vma->vm_start, mmtimer_addr, PAGE_SIZE, vma->vm_page_prot)) {
+	if (remap_page_range(vma, vma->vm_start, mmtimer_addr, PAGE_SIZE,
+			     vma->vm_page_prot)) {
 		printk(KERN_ERR "remap_page_range failed in mmtimer.c\n");
 		return -EAGAIN;
 	}
@@ -169,27 +182,29 @@
  *
  * Does initial setup for the mmtimer device.
  */
-static int __init
-mmtimer_init(void)
+static int __init mmtimer_init(void)
 {
 	/*
 	 * Sanity check the cycles/sec variable
 	 */
 	if (sn_rtc_cycles_per_second < 100000) {
-		printk(KERN_ERR "%s: unable to determine clock frequency\n", MMTIMER_NAME);
+		printk(KERN_ERR "%s: unable to determine clock frequency\n",
+		       MMTIMER_NAME);
 		return -1;
 	}
 
-	mmtimer_femtoperiod = ((unsigned long)1E15 + sn_rtc_cycles_per_second / 2) /
-		sn_rtc_cycles_per_second;
+	mmtimer_femtoperiod = ((unsigned long)1E15 + sn_rtc_cycles_per_second /
+			       2) / sn_rtc_cycles_per_second;
 
 	strcpy(mmtimer_miscdev.devfs_name, MMTIMER_NAME);
 	if (misc_register(&mmtimer_miscdev)) {
-		printk(KERN_ERR "%s: failed to register device\n", MMTIMER_NAME);
+		printk(KERN_ERR "%s: failed to register device\n",
+		       MMTIMER_NAME);
 		return -1;
 	}
 
-	printk(KERN_INFO "%s: v%s, %ld MHz\n", MMTIMER_DESC, MMTIMER_VERSION, sn_rtc_cycles_per_second/(unsigned long)1E6);
+	printk(KERN_INFO "%s: v%s, %ld MHz\n", MMTIMER_DESC, MMTIMER_VERSION,
+	       sn_rtc_cycles_per_second/(unsigned long)1E6);
 
 	return 0;
 }
===== include/linux/mmtimer.h 1.1 vs edited =====
--- 1.1/include/linux/mmtimer.h	2004-09-17 00:07:01 -07:00
+++ edited/include/linux/mmtimer.h	2004-09-17 13:03:44 -07:00
@@ -5,7 +5,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 2001-2003 Silicon Graphics, Inc.  All rights reserved.
+ * Copyright (c) 2001-2004 Silicon Graphics, Inc.  All rights reserved.
  *
  * This file should define an interface compatible with the IA-PC Multimedia
  * Timers Draft Specification (rev. 0.97) from Intel.  Note that some
@@ -14,17 +14,12 @@
  *
  * 11/01/01 - jbarnes - initial revision
  * 9/10/04 - Christoph Lameter - remove interrupt support
+ * 9/17/04 - jbarnes - remove test program, move some #defines to the driver
  */
 
 #ifndef _LINUX_MMTIMER_H
 #define _LINUX_MMTIMER_H
 
-/* name of the device, usually in /dev */
-#define MMTIMER_NAME "mmtimer"
-#define MMTIMER_FULLNAME "/dev/mmtimer"
-#define MMTIMER_DESC "IA-PC Multimedia Timer"
-#define MMTIMER_VERSION "1.0"
-
 /*
  * Breakdown of the ioctl's available.  An 'optional' next to the command
  * indicates that supporting this command is optional, while 'required'
@@ -57,84 +52,5 @@
 #define MMTIMER_GETBITS _IO(MMTIMER_IOCTL_BASE, 4)
 #define MMTIMER_MMAPAVAIL _IO(MMTIMER_IOCTL_BASE, 6)
 #define MMTIMER_GETCOUNTER _IOR(MMTIMER_IOCTL_BASE, 9, unsigned long)
-
-/*
- * An mmtimer verification program.  WARNINGs are ok, but ERRORs indicate
- * that the device doesn't fully support the interface defined here.
- */
-#ifdef _MMTIMER_TEST_PROGRAM
-
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-
-#include <sys/ioctl.h>
-
-#include "mmtimer.h"
-
-int main(int argc, char *argv[])
-{
-	int result, fd;
-	unsigned long val = 0;
-	unsigned long i;
-
-	if((fd = open("/dev/"MMTIMER_NAME, O_RDONLY)) == -1) {
-		printf("failed to open /dev/%s", MMTIMER_NAME);
-		return 1;
-	}
-
-        /*
-         * Can we mmap in the counter?
-         */
-        if((result = ioctl(fd, MMTIMER_MMAPAVAIL, 0)) == 1) {
-                printf("mmap available\n");
-	        /* ... so try getting the offset for each clock */
-	        if((result = ioctl(fd, MMTIMER_GETOFFSET, 0)) != -ENOSYS)
-	                printf("offset: %d\n", result);
-	        else
-	                printf("WARNING: offset unavailable for clock\n");
-	}
-        else
-                printf("WARNING: mmap unavailable\n");
-
-	/*
-	 * Get the resolution in femtoseconds
-	 */
-        if((result = ioctl(fd, MMTIMER_GETRES, &val)) != -ENOSYS)
-                printf("resolution: %ld femtoseconds\n", val);
-        else
-                printf("ERROR: failed to get resolution\n");
-
-	/*
-	 * Get the frequency in Hz
-	 */
-        if((result = ioctl(fd, MMTIMER_GETFREQ, &val)) != -ENOSYS)
-		if(val < 10000000) /* less than 10 MHz? */
-			printf("ERROR: frequency only %ld MHz, should be >= 10 MHz\n", val/1000000);
-		else
-			printf("frequency: %ld MHz\n", val/1000000);
-        else
-                printf("ERROR: failed to get frequency\n");
-
-	/*
-	 * How many bits in the counter?
-	 */
-        if((result = ioctl(fd, MMTIMER_GETBITS, 0)) != -ENOSYS)
-                printf("bits in counter: %d\n", result);
-        else
-                printf("ERROR: can't get number of bits in counter\n");
-
-	if((result = ioctl(fd, MMTIMER_GETCOUNTER, &val)) != -ENOSYS)
-		printf("counter value: %ld\n", val);
-	else
-		printf("ERROR: can't get counter value\n");
-
-	return 0;
-}
-
-#endif /* _MMTIMER_TEST_PROGRM */
 
 #endif /* _LINUX_MMTIMER_H */

--Boundary-00=_ogEUBeBa/+b4D7Y--
