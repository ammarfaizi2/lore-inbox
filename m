Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWEPWRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWEPWRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWEPWRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:17:17 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8716 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932196AbWEPWRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:17:16 -0400
Date: Wed, 17 May 2006 00:17:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/advansys.c: cleanups
Message-ID: <20060516221714.GU10077@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- remove the unneeded advansys.h
- remove the unused advansys_setup()
- make needlessly global functions static

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/advansys.c |  101 +++-------------------------------------
 drivers/scsi/advansys.h |   36 --------------
 2 files changed, 8 insertions(+), 129 deletions(-)

--- linux-2.6.17-rc2-mm1-full/drivers/scsi/advansys.h	2006-04-27 17:41:44.000000000 +0200
+++ /dev/null	2006-04-23 00:42:46.000000000 +0200
@@ -1,36 +0,0 @@
-/*
- * advansys.h - Linux Host Driver for AdvanSys SCSI Adapters
- * 
- * Copyright (c) 1995-2000 Advanced System Products, Inc.
- * Copyright (c) 2000-2001 ConnectCom Solutions, Inc.
- * All Rights Reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that redistributions of source
- * code retain the above copyright notice and this comment without
- * modification.
- *
- * As of March 8, 2000 Advanced System Products, Inc. (AdvanSys)
- * changed its name to ConnectCom Solutions, Inc.
- *
- */
-
-#ifndef _ADVANSYS_H
-#define _ADVANSYS_H
-
-/*
- * struct scsi_host_template function prototypes.
- */
-int advansys_detect(struct scsi_host_template *);
-int advansys_release(struct Scsi_Host *);
-const char *advansys_info(struct Scsi_Host *);
-int advansys_queuecommand(struct scsi_cmnd *, void (* done)(struct scsi_cmnd *));
-int advansys_reset(struct scsi_cmnd *);
-int advansys_biosparam(struct scsi_device *, struct block_device *,
-		sector_t, int[]);
-static int advansys_slave_configure(struct scsi_device *);
-
-/* init/main.c setup function */
-void advansys_setup(char *, int *);
-
-#endif /* _ADVANSYS_H */
--- linux-2.6.17-rc4-mm1-full/drivers/scsi/advansys.c.old	2006-05-16 21:09:59.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/drivers/scsi/advansys.c	2006-05-16 21:10:45.000000000 +0200
@@ -799,7 +799,6 @@
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
-#include "advansys.h"
 #ifdef CONFIG_PCI
 #include <linux/pci.h>
 #endif /* CONFIG_PCI */
@@ -2013,7 +2012,7 @@
 STATIC void      AscEnableIsaDma(uchar);
 #endif /* CONFIG_ISA */
 STATIC ASC_DCNT  AscGetMaxDmaCount(ushort);
-
+static const char *advansys_info(struct Scsi_Host *shp);
 
 /*
  * --- Adv Library Constants and Macros
@@ -3982,10 +3981,6 @@
     ASC_IS_PCI,
 };
 
-/*
- * Used with the LILO 'advansys' option to eliminate or
- * limit I/O port probing at boot time, cf. advansys_setup().
- */
 STATIC int asc_iopflag = ASC_FALSE;
 STATIC int asc_ioport[ASC_NUM_IOPORT_PROBE] = { 0, 0, 0, 0 };
 
@@ -4067,10 +4062,6 @@
 #endif /* ADVANSYS_DEBUG */
 
 
-/*
- * --- Linux 'struct scsi_host_template' and advansys_setup() Functions
- */
-
 #ifdef CONFIG_PROC_FS
 /*
  * advansys_proc_info() - /proc/scsi/advansys/[0-(ASC_NUM_BOARD_SUPPORTED-1)]
@@ -4092,7 +4083,7 @@
  * if 'prtbuf' is too small it will not be overwritten. Instead the
  * user just won't get all the available statistics.
  */
-int
+static int
 advansys_proc_info(struct Scsi_Host *shost, char *buffer, char **start,
 		off_t offset, int length, int inout)
 {
@@ -4308,7 +4299,7 @@
  * it must not call SCSI mid-level functions including scsi_malloc()
  * and scsi_free().
  */
-int __init
+static int __init
 advansys_detect(struct scsi_host_template *tpnt)
 {
     static int          detect_called = ASC_FALSE;
@@ -5440,7 +5431,7 @@
  *
  * Release resources allocated for a single AdvanSys adapter.
  */
-int
+static int
 advansys_release(struct Scsi_Host *shp)
 {
     asc_board_t    *boardp;
@@ -5487,7 +5478,7 @@
  * Note: The information line should not exceed ASC_INFO_SIZE bytes,
  * otherwise the static 'info' array will be overrun.
  */
-const char *
+static const char *
 advansys_info(struct Scsi_Host *shp)
 {
     static char     info[ASC_INFO_SIZE];
@@ -5580,7 +5571,7 @@
  * This function always returns 0. Command return status is saved
  * in the 'scp' result field.
  */
-int
+static int
 advansys_queuecommand(struct scsi_cmnd *scp, void (*done)(struct scsi_cmnd *))
 {
     struct Scsi_Host    *shp;
@@ -5668,7 +5659,7 @@
  * sleeping is allowed and no locking other than for host structures is
  * required. Returns SUCCESS or FAILED.
  */
-int
+static int
 advansys_reset(struct scsi_cmnd *scp)
 {
     struct Scsi_Host     *shp;
@@ -5853,7 +5844,7 @@
  * ip[1]: sectors
  * ip[2]: cylinders
  */
-int
+static int
 advansys_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 		sector_t capacity, int ip[])
 {
@@ -5887,82 +5878,6 @@
 }
 
 /*
- * advansys_setup()
- *
- * This function is called from init/main.c at boot time.
- * It it passed LILO parameters that can be set from the
- * LILO command line or in /etc/lilo.conf.
- *
- * It is used by the AdvanSys driver to either disable I/O
- * port scanning or to limit scanning to 1 - 4 I/O ports.
- * Regardless of the option setting EISA and PCI boards
- * will still be searched for and detected. This option
- * only affects searching for ISA and VL boards.
- *
- * If ADVANSYS_DEBUG is defined the driver debug level may
- * be set using the 5th (ASC_NUM_IOPORT_PROBE + 1) I/O Port.
- *
- * Examples:
- * 1. Eliminate I/O port scanning:
- *         boot: linux advansys=
- *       or
- *         boot: linux advansys=0x0
- * 2. Limit I/O port scanning to one I/O port:
- *        boot: linux advansys=0x110
- * 3. Limit I/O port scanning to four I/O ports:
- *        boot: linux advansys=0x110,0x210,0x230,0x330
- * 4. If ADVANSYS_DEBUG, limit I/O port scanning to four I/O ports and
- *    set the driver debug level to 2.
- *        boot: linux advansys=0x110,0x210,0x230,0x330,0xdeb2
- *
- * ints[0] - number of arguments
- * ints[1] - first argument
- * ints[2] - second argument
- * ...
- */
-void __init
-advansys_setup(char *str, int *ints)
-{
-    int    i;
-
-    if (asc_iopflag == ASC_TRUE) {
-        printk("AdvanSys SCSI: 'advansys' LILO option may appear only once\n");
-        return;
-    }
-
-    asc_iopflag = ASC_TRUE;
-
-    if (ints[0] > ASC_NUM_IOPORT_PROBE) {
-#ifdef ADVANSYS_DEBUG
-        if ((ints[0] == ASC_NUM_IOPORT_PROBE + 1) &&
-            (ints[ASC_NUM_IOPORT_PROBE + 1] >> 4 == 0xdeb)) {
-            asc_dbglvl = ints[ASC_NUM_IOPORT_PROBE + 1] & 0xf;
-        } else {
-#endif /* ADVANSYS_DEBUG */
-            printk("AdvanSys SCSI: only %d I/O ports accepted\n",
-                ASC_NUM_IOPORT_PROBE);
-#ifdef ADVANSYS_DEBUG
-        }
-#endif /* ADVANSYS_DEBUG */
-    }
-
-#ifdef ADVANSYS_DEBUG
-    ASC_DBG1(1, "advansys_setup: ints[0] %d\n", ints[0]);
-    for (i = 1; i < ints[0]; i++) {
-        ASC_DBG2(1, " ints[%d] 0x%x", i, ints[i]);
-    }
-    ASC_DBG(1, "\n");
-#endif /* ADVANSYS_DEBUG */
-
-    for (i = 1; i <= ints[0] && i <= ASC_NUM_IOPORT_PROBE; i++) {
-        asc_ioport[i-1] = ints[i];
-        ASC_DBG2(1, "advansys_setup: asc_ioport[%d] 0x%x\n",
-            i - 1, asc_ioport[i-1]);
-    }
-}
-
-
-/*
  * --- Loadable Driver Support
  */
 
