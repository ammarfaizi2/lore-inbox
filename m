Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316195AbSFJUiN>; Mon, 10 Jun 2002 16:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316192AbSFJUgp>; Mon, 10 Jun 2002 16:36:45 -0400
Received: from psmtp1.dnsg.net ([193.168.128.41]:29866 "HELO psmtp1.dnsg.net")
	by vger.kernel.org with SMTP id <S316163AbSFJUgc>;
	Mon, 10 Jun 2002 16:36:32 -0400
Subject: 2.5.21 s390 patch.
To: linux-kernel@vger.kernel.org
Date: Tue, 11 Jun 2002 00:23:06 +0200 (CEST)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17HXZ4-0000Xf-00@skybase>
From: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
after the big s/390 patch has gone into 2.5.21 (thanks Linus) the diff between
our internal CVS and the official source tree is a mere 1500 lines now...
To get something compiled for s/390 you need some more patches.
This one adds some missing includes, removes the scsi subdirectory from the
drivers/s390 Makefile and removes any reference to the label array in the
dasd driver. The scsi stuff and the automatic label generation for the devfs
is for later. 

blue skies,
  Martin.

diff -urN linux-2.5.21/arch/s390/mm/ioremap.c linux-2.5.21-s390/arch/s390/mm/ioremap.c
--- linux-2.5.21/arch/s390/mm/ioremap.c	Sun Jun  9 07:27:32 2002
+++ linux-2.5.21-s390/arch/s390/mm/ioremap.c	Mon Jun 10 18:08:16 2002
@@ -14,6 +14,7 @@
  */
 
 #include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
diff -urN linux-2.5.21/arch/s390x/mm/ioremap.c linux-2.5.21-s390/arch/s390x/mm/ioremap.c
--- linux-2.5.21/arch/s390x/mm/ioremap.c	Sun Jun  9 07:29:55 2002
+++ linux-2.5.21-s390/arch/s390x/mm/ioremap.c	Mon Jun 10 18:08:16 2002
@@ -14,6 +14,7 @@
  */
 
 #include <linux/vmalloc.h>
+#include <linux/mm.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
diff -urN linux-2.5.21/drivers/s390/Makefile linux-2.5.21-s390/drivers/s390/Makefile
--- linux-2.5.21/drivers/s390/Makefile	Sun Jun  9 07:30:02 2002
+++ linux-2.5.21-s390/drivers/s390/Makefile	Mon Jun 10 18:18:39 2002
@@ -2,7 +2,7 @@
 # Makefile for the S/390 specific device drivers
 #
 
-mod-subdirs := block char misc net scsi cio
+mod-subdirs := block char misc net cio
 
 export-objs += s390dyn.o
 
@@ -10,6 +10,6 @@
 export-objs += qdio.o
 
 obj-y += s390mach.o s390dyn.o sysinfo.o
-obj-y += block/ char/ misc/ net/ scsi/ cio/
+obj-y += block/ char/ misc/ net/ cio/
 
 include $(TOPDIR)/Rules.make
diff -urN linux-2.5.21/drivers/s390/block/dasd_genhd.c linux-2.5.21-s390/drivers/s390/block/dasd_genhd.c
--- linux-2.5.21/drivers/s390/block/dasd_genhd.c	Sun Jun  9 07:31:15 2002
+++ linux-2.5.21-s390/drivers/s390/block/dasd_genhd.c	Mon Jun 10 18:10:11 2002
@@ -65,7 +65,7 @@
 {
 	struct major_info *mi;
 	struct hd_struct *gd_part;
-	devfs_handle_t *gd_de_arr, *gd_label_arr;
+	devfs_handle_t *gd_de_arr;
 	int *gd_sizes;
 	char *gd_flags;
 	int new_major, rc;
@@ -78,14 +78,12 @@
 	gd_de_arr = kmalloc(DASD_PER_MAJOR * sizeof(devfs_handle_t),
 			    GFP_KERNEL);
 	gd_flags = kmalloc(DASD_PER_MAJOR * sizeof(char), GFP_KERNEL);
-	gd_label_arr = kmalloc(DASD_PER_MAJOR * sizeof(devfs_handle_t),
-			       GFP_KERNEL);
 	gd_part = kmalloc(sizeof (struct hd_struct) << MINORBITS, GFP_ATOMIC);
 	gd_sizes = kmalloc(sizeof(int) << MINORBITS, GFP_ATOMIC);
 
 	/* Check if one of the allocations failed. */
 	if (mi == NULL || gd_de_arr == NULL || gd_flags == NULL ||
-	    gd_label_arr == NULL || gd_part == NULL || gd_sizes == NULL) {
+	    gd_part == NULL || gd_sizes == NULL) {
 		MESSAGE(KERN_WARNING, "%s",
 			"Cannot get memory to allocate another "
 			"major number");
@@ -114,14 +112,12 @@
 	mi->gendisk.fops = &dasd_device_operations;
 	mi->gendisk.de_arr = gd_de_arr;
 	mi->gendisk.flags = gd_flags;
-	mi->gendisk.label_arr = gd_label_arr;
 	mi->gendisk.part = gd_part;
 	mi->gendisk.sizes = gd_sizes;
 
 	/* Initialize the gendisk arrays. */
 	memset(gd_de_arr, 0, DASD_PER_MAJOR * sizeof(devfs_handle_t));
 	memset(gd_flags, 0, DASD_PER_MAJOR * sizeof (char));
-	memset(gd_label_arr, 0, DASD_PER_MAJOR * sizeof(devfs_handle_t));
 	memset(gd_part, 0, sizeof (struct hd_struct) << MINORBITS);
 	memset(gd_sizes, 0, sizeof(int) << MINORBITS);
 
@@ -143,7 +139,6 @@
 	/* We rely on kfree to do the != NULL check. */
 	kfree(gd_sizes);
 	kfree(gd_part);
-	kfree(gd_label_arr);
 	kfree(gd_flags);
 	kfree(gd_de_arr);
 	kfree(mi);
@@ -182,7 +177,6 @@
 	/* Free memory. */
 	kfree(bs);
 	kfree(mi->gendisk.part);
-	kfree(mi->gendisk.label_arr);
 	kfree(mi->gendisk.flags);
 	kfree(mi->gendisk.de_arr);
 	kfree(mi);
diff -urN linux-2.5.21/drivers/s390/net/iucv.c linux-2.5.21-s390/drivers/s390/net/iucv.c
--- linux-2.5.21/drivers/s390/net/iucv.c	Sun Jun  9 07:27:15 2002
+++ linux-2.5.21-s390/drivers/s390/net/iucv.c	Mon Jun 10 18:08:16 2002
@@ -44,6 +44,7 @@
 #include <linux/tqueue.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/errno.h>
 #include <asm/atomic.h>
 #include "iucv.h"
 #include <asm/io.h>
@@ -302,7 +303,7 @@
 	if (debuglevel < 3)
 		return;
 
-	printk(KERN_DEBUG __FUNCTION__ ": %s\n", title);
+	printk(KERN_DEBUG "%s\n", title);
 	printk("  ");
 	for (i = 0; i < len; i++) {
 		if (!(i % 16) && i != 0)
@@ -318,7 +319,7 @@
 #define iucv_debug(lvl, fmt, args...) \
 do { \
 	if (debuglevel >= lvl) \
-		printk(KERN_DEBUG __FUNCTION__ ": " fmt "\n" , ## args); \
+		printk(KERN_DEBUG "%s: " fmt "\n", __FUNCTION__ , ## args); \
 } while (0)
 
 #else
diff -urN linux-2.5.21/include/asm-s390/pgalloc.h linux-2.5.21-s390/include/asm-s390/pgalloc.h
--- linux-2.5.21/include/asm-s390/pgalloc.h	Sun Jun  9 07:30:36 2002
+++ linux-2.5.21-s390/include/asm-s390/pgalloc.h	Mon Jun 10 18:08:16 2002
@@ -16,6 +16,7 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/gfp.h>
 
 #define check_pgt_cache()	do {} while (0)
 
diff -urN linux-2.5.21/include/asm-s390x/pgalloc.h linux-2.5.21-s390/include/asm-s390x/pgalloc.h
--- linux-2.5.21/include/asm-s390x/pgalloc.h	Sun Jun  9 07:27:32 2002
+++ linux-2.5.21-s390/include/asm-s390x/pgalloc.h	Mon Jun 10 18:08:16 2002
@@ -16,6 +16,7 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/gfp.h>
 
 #define check_pgt_cache()	do { } while (0)
 
