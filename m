Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbTKWRRf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 12:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTKWRRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 12:17:35 -0500
Received: from intra.cyclades.com ([64.186.161.6]:31390 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262766AbTKWRRb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 12:17:31 -0500
Date: Sun, 23 Nov 2003 15:08:06 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: modular IDE in 2.4.23
In-Reply-To: <200311231310.38793.arekm@pld-linux.org>
Message-ID: <Pine.LNX.4.44.0311231502530.1292-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Sun, 23 Nov 2003, Arkadiusz Miskiewicz wrote:

> On Sunday 23 of November 2003 01:54, Arkadiusz Miskiewicz wrote:
> > Could you give more specific hints how to fix ,,other stuff''?
> Did this in not the right way probably but it works fine for me (just modular 
> ide tested):
> 
> http://cvs.pld-linux.org/cgi-bin/cvsweb/SOURCES/linux-2.4.23-modular-ide.patch?rev=1.9
> 
> [misiek@arm ~]$ lsmod | grep ide
> ide-scsi                9904   0
> scsi_mod               93888   2 [sg ide-scsi]
> ide-cd                 30944   0
> cdrom                  29248   0 [ide-cd]
> ide-disk               16076  13
> ide-core              104504  13 [ide-scsi ide-cd ide-disk pdc202xx_new 
> via82cxxx]
> 
> Thanks for hint (now only cmd640 isse left for me).
> 
> > > Alan

Arkadiusz, 

I agree with you that modular IDE (I dont care that much about the 
cmd640 really) should work on 2.4.23.

I dont think the "ide-probe-mini" is required though. Just calling 
the ide-probe.o init functions from IDE init should work right?

Does the attached patch work for you (it moves ide-probe into ide-core, 
as Alan mentioned) ? 

diff -Naur -X /home/marcelo/lib/dontdiff linux-2.4.23-rc4/drivers/ide/Makefile linux-2.4.23-rc3/drivers/ide/Makefile
--- linux-2.4.23-rc4/drivers/ide/Makefile	2003-11-23 16:45:41.000000000 +0000
+++ linux-2.4.23-rc3/drivers/ide/Makefile	2003-11-23 16:29:04.000000000 +0000
@@ -9,7 +9,7 @@
 #
 
 
-export-objs := ide-iops.o ide-taskfile.o ide-proc.o ide.o ide-probe.o ide-dma.o ide-lib.o setup-pci.o ide-io.o ide-disk.o
+export-objs := ide-iops.o ide-taskfile.o ide-proc.o ide.o ide-dma.o ide-lib.o setup-pci.o ide-io.o ide-disk.o ide-probe.o
 
 all-subdirs	:= arm legacy pci ppc raid
 mod-subdirs	:= arm legacy pci ppc raid
@@ -28,8 +28,8 @@
 
 # Core IDE code - must come before legacy
 
-ide-core-objs	:= ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-io.o ide-default.o ide-proc.o
-ide-detect-objs	:= ide-probe.o ide-geometry.o
+ide-core-objs	:= ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-io.o ide-default.o ide-proc.o ide-probe.o
+ide-detect-objs	:= ide-geometry.o 
 
 
 ifeq ($(CONFIG_BLK_DEV_IDEPCI),y)
diff -Naur -X /home/marcelo/lib/dontdiff linux-2.4.23-rc4/drivers/ide/ide-probe.c linux-2.4.23-rc3/drivers/ide/ide-probe.c
--- linux-2.4.23-rc4/drivers/ide/ide-probe.c	2003-11-23 16:42:08.000000000 +0000
+++ linux-2.4.23-rc3/drivers/ide/ide-probe.c	2003-11-23 16:27:53.000000000 +0000
@@ -1416,7 +1416,7 @@
 #ifdef MODULE
 extern int (*ide_xlate_1024_hook)(kdev_t, int, int, const char *);
 
-int init_module (void)
+int ideprobe_init_module(void)
 {
 	unsigned int index;
 	
@@ -1428,10 +1428,14 @@
 	return 0;
 }
 
-void cleanup_module (void)
+void ideprobe_cleanup_module (void)
 {
 	ide_probe = NULL;
 	ide_xlate_1024_hook = 0;
 }
+
+EXPORT_SYMBOL(ideprobe_init_module);
+EXPORT_SYMBOL(ideprobe_cleanup_module);
 MODULE_LICENSE("GPL");
+
 #endif /* MODULE */
diff -Naur -X /home/marcelo/lib/dontdiff linux-2.4.23-rc4/drivers/ide/ide.c linux-2.4.23-rc3/drivers/ide/ide.c
--- linux-2.4.23-rc4/drivers/ide/ide.c	2003-11-23 16:46:51.000000000 +0000
+++ linux-2.4.23-rc3/drivers/ide/ide.c	2003-11-23 16:50:39.000000000 +0000
@@ -3059,6 +3059,7 @@
 
 int init_module (void)
 {
+	ideprobe_init_module();
 	parse_options(options);
 	return ide_init();
 }
@@ -3080,6 +3081,7 @@
 	proc_ide_destroy();
 #endif
 	devfs_unregister (ide_devfs_handle);
+	ideprobe_cleanup_module();
 }
 
 #else /* !MODULE */
diff -Naur -X /home/marcelo/lib/dontdiff linux-2.4.23-rc4/include/linux/ide.h linux-2.4.23-rc3/include/linux/ide.h
--- linux-2.4.23-rc4/include/linux/ide.h	2003-11-23 16:43:17.000000000 +0000
+++ linux-2.4.23-rc3/include/linux/ide.h	2003-11-23 16:29:30.000000000 +0000
@@ -1615,6 +1615,9 @@
 extern int idescsi_attach(ide_drive_t *);
 extern int idescsi_init(void);
 
+extern int ideprobe_init_module(void);
+extern void ideprobe_cleanup_module(void);
+
 extern void ide_scan_pcibus(int scan_direction) __init;
 extern int ide_pci_register_driver(struct pci_driver *driver);
 extern void ide_pci_unregister_driver(struct pci_driver *driver);


