Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275983AbRJPKnF>; Tue, 16 Oct 2001 06:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275981AbRJPKm4>; Tue, 16 Oct 2001 06:42:56 -0400
Received: from CPE-61-9-149-34.vic.bigpond.net.au ([61.9.149.34]:56823 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S275983AbRJPKmg>; Tue, 16 Oct 2001 06:42:36 -0400
Message-ID: <3BCC0BFE.2DF7AE95@eyal.emu.id.au>
Date: Tue, 16 Oct 2001 20:29:18 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.13-pre3: problems and patches
Content-Type: multipart/mixed;
 boundary="------------FC81D21D5F7E6276ACD21D08"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FC81D21D5F7E6276ACD21D08
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

pre3:
 - prepare-for-Alan: move drivers/i2o into drivers/message/i2o

Well, moving it is not enough, some relative references need to be
fixed. Attached is the trivial patch. [i2o_scsi.patch]

Other fun bits:

fs/udf has a function type dissagreement. It is not critical for me
(int vs long) so I selected 'long' and fixed the header. [udfdecl.patch]

Of course, one still needs the old patch for the struct field name
changes. [i2o.patch]

To build a full pre3 one also needs other patches off the list
	sonypi
	cpqfcTSinit
These may not be the "proper" patches but they do the job for now.

And that is all folks.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
--------------FC81D21D5F7E6276ACD21D08
Content-Type: text/plain; charset=us-ascii;
 name="2.4.13-pre3-i2o.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.13-pre3-i2o.patch"

--- linux/drivers/message/i2o/i2o_pci.c.orig	Sun Aug 12 14:16:18 2001
+++ linux/drivers/message/i2o/i2o_pci.c	Sat Oct 13 04:02:57 2001
@@ -162,7 +162,7 @@
 	c->bus.pci.queue_buggy = 0;
 	c->bus.pci.dpt = 0;
 	c->bus.pci.short_req = 0;
-	c->bus.pci.pdev = dev;
+	c->pdev = dev;
 
 	c->irq_mask = (volatile u32 *)(mem+0x34);
 	c->post_port = (volatile u32 *)(mem+0x40);
--- linux/drivers/message/i2o/i2o_core.c.orig	Thu Aug 16 12:50:24 2001
+++ linux/drivers/message/i2o/i2o_core.c	Sat Oct 13 04:06:08 2001
@@ -1924,12 +1924,12 @@
 		if(iop->status_block->current_mem_size < iop->status_block->desired_mem_size)
 		{
 			struct resource *res = &iop->mem_resource;
-			res->name = iop->bus.pci.pdev->bus->name;
+			res->name = iop->pdev->bus->name;
 			res->flags = IORESOURCE_MEM;
 			res->start = 0;
 			res->end = 0;
 			printk("%s: requires private memory resources.\n", iop->name);
-			root = pci_find_parent_resource(iop->bus.pci.pdev, res);
+			root = pci_find_parent_resource(iop->pdev, res);
 			if(root==NULL)
 				printk("Can't find parent resource!\n");
 			if(root && allocate_resource(root, res, 
@@ -1950,12 +1950,12 @@
 		if(iop->status_block->current_io_size < iop->status_block->desired_io_size)
 		{
 			struct resource *res = &iop->io_resource;
-			res->name = iop->bus.pci.pdev->bus->name;
+			res->name = iop->pdev->bus->name;
 			res->flags = IORESOURCE_IO;
 			res->start = 0;
 			res->end = 0;
 			printk("%s: requires private memory resources.\n", iop->name);
-			root = pci_find_parent_resource(iop->bus.pci.pdev, res);
+			root = pci_find_parent_resource(iop->pdev, res);
 			if(root==NULL)
 				printk("Can't find parent resource!\n");
 			if(root &&  allocate_resource(root, res, 
--- linux/include/linux/i2o.h.orig	Sat Oct 13 03:40:03 2001
+++ linux/include/linux/i2o.h	Sat Oct 13 04:13:23 2001
@@ -30,6 +30,7 @@
 
 #include <asm/semaphore.h>	/* Needed for MUTEX init macros */
 #include <linux/config.h>
+#include <linux/ioport.h>
 #include <linux/notifier.h>
 #include <asm/atomic.h>
 
--- linux/drivers/message/i2o/i2o_block.c.orig	Mon Sep 10 15:42:31 2001
+++ linux/drivers/message/i2o/i2o_block.c	Sat Oct 13 04:15:18 2001
@@ -1989,7 +1989,6 @@
 
 void cleanup_module(void)
 {
-	struct gendisk *gdp;
 	int i;
 	
 	if(evt_running) {

--------------FC81D21D5F7E6276ACD21D08
Content-Type: text/plain; charset=us-ascii;
 name="2.4.13-pre3-i2o_scsi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.13-pre3-i2o_scsi.patch"

--- linux-2.4-pre/drivers/message/i2o/i2o_scsi.c.orig	Tue Oct 16 20:07:54 2001
+++ linux-2.4-pre/drivers/message/i2o/i2o_scsi.c	Tue Oct 16 20:09:57 2001
@@ -48,9 +48,9 @@
 #include <linux/blk.h>
 #include <linux/version.h>
 #include <linux/i2o.h>
-#include "../scsi/scsi.h"
-#include "../scsi/hosts.h"
-#include "../scsi/sd.h"
+#include "../../scsi/scsi.h"
+#include "../../scsi/hosts.h"
+#include "../../scsi/sd.h"
 #include "i2o_scsi.h"
 
 #define VERSION_STRING        "Version 0.0.1"
@@ -909,4 +909,4 @@
 
 static Scsi_Host_Template driver_template = I2OSCSI;
 
-#include "../scsi/scsi_module.c"
+#include "../../scsi/scsi_module.c"

--------------FC81D21D5F7E6276ACD21D08
Content-Type: text/plain; charset=us-ascii;
 name="2.4.13-pre3-sonypi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.13-pre3-sonypi.patch"

--- linux/drivers/char/sonypi.c.orig	Fri Oct 12 20:50:58 2001
+++ linux/drivers/char/sonypi.c	Fri Oct 12 20:51:18 2001
@@ -43,6 +43,7 @@
 
 #include "sonypi.h"
 #include <linux/sonypi.h>
+extern int is_sony_vaio_laptop; /* set in DMI table parse routines */
 
 static struct sonypi_device sonypi_device;
 static int minor = -1;

--------------FC81D21D5F7E6276ACD21D08
Content-Type: text/plain; charset=us-ascii;
 name="2.4.13-pre3-cpqfc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.13-pre3-cpqfc.patch"

--- linux-2.4.10-pre7/include/scsi/scsi.h	Fri Apr 27 13:59:19 2001
+++ linux/include/scsi/scsi.h	Mon Sep 10 03:53:58 2001
@@ -214,6 +214,12 @@
 /* Used to get the PCI location of a device */
 #define SCSI_IOCTL_GET_PCI 0x5387
 
+/* Used to invoke Target Defice Reset for Fibre Channel */
+#define SCSI_IOCTL_FC_TDR 0x5388
+
+/* Used to get Fibre Channel WWN and port_id from device */
+#define SCSI_IOCTL_FC_TARGET_ADDRESS 0x5389
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
--- linux-2.4.10-pre7/drivers/scsi/cpqfcTSinit.c	Sun Aug 12 10:51:41 2001
+++ linux/drivers/scsi/cpqfcTSinit.c	Mon Sep 10 03:54:23 2001
@@ -63,6 +63,7 @@
 
 #include <linux/config.h>  
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/version.h> 
 
 /* Embedded module documentation macros - see module.h */

--------------FC81D21D5F7E6276ACD21D08
Content-Type: text/plain; charset=us-ascii;
 name="2.4.13-pre3-udfdecl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.13-pre3-udfdecl.patch"

--- linux/fs/udf/udfdecl.h.orig	Tue Oct 16 20:24:01 2001
+++ linux/fs/udf/udfdecl.h	Tue Oct 16 20:24:42 2001
@@ -150,7 +150,7 @@
 
 /* lowlevel.c */
 extern unsigned int udf_get_last_session(struct super_block *);
-extern unsigned int udf_get_last_block(struct super_block *);
+extern unsigned long udf_get_last_block(struct super_block *);
 
 /* partition.c */
 extern Uint32 udf_get_pblock(struct super_block *, Uint32, Uint16, Uint32);

--------------FC81D21D5F7E6276ACD21D08--

