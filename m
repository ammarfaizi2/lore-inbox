Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315624AbSECKQZ>; Fri, 3 May 2002 06:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315625AbSECKQY>; Fri, 3 May 2002 06:16:24 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:42756 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315624AbSECKQX>; Fri, 3 May 2002 06:16:23 -0400
Date: Fri, 3 May 2002 11:16:17 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: 2.5.13: link failure
Message-ID: <20020503111617.B4319@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.13 with root nfs enabled doesn't link:

fs/fs.o: In function `root_nfs_getport':
fs/fs.o(.text.init+0x187c): undefined reference to `in_ntoa'

I haven't looked into this one yet.

2.5.13 with SCSI enabled:

drivers/scsi/scsidrv.o: In function `sd_init':
drivers/scsi/scsidrv.o(.text+0x128c8): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x128fc): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x12934): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x12948): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x1296c): undefined reference to `vmalloc'
drivers/scsi/scsidrv.o(.text+0x12980): more undefined references to `vmalloc' follow

The following patch fixes this, and also fixes the similar problem in
scsi_debug.c:

diff -u orig/drivers/scsi/scsi_debug.c linux/drivers/scsi/scsi_debug.c
--- orig/drivers/scsi/scsi_debug.c	Sun Apr 28 17:17:12 2002
+++ linux/drivers/scsi/scsi_debug.c	Fri May  3 11:08:53 2002
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/vmalloc.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -40,7 +41,7 @@
 #include "scsi.h"
 #include "hosts.h"
 
-#include<linux/stat.h>
+#include <linux/stat.h>
 
 #ifndef LINUX_VERSION_CODE
 #include <linux/version.h>
diff -u orig/drivers/scsi/sd.c linux/drivers/scsi/sd.c
--- orig/drivers/scsi/sd.c	Fri May  3 11:13:39 2002
+++ linux/drivers/scsi/sd.c	Fri May  3 11:08:20 2002
@@ -41,7 +41,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
-
+#include <linux/vmalloc.h>
 #include <linux/smp.h>
 
 #include <asm/uaccess.h>


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

