Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbSLFSuD>; Fri, 6 Dec 2002 13:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbSLFSuD>; Fri, 6 Dec 2002 13:50:03 -0500
Received: from [66.54.199.246] ([66.54.199.246]:60933 "HELO
	southernohiocomputerservices.com") by vger.kernel.org with SMTP
	id <S265369AbSLFSt7>; Fri, 6 Dec 2002 13:49:59 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Aaron Baxter <abaxter@southernohio.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Initio 9100-U SCSI Driver. ini9100u.c ini9100u.h [KERNEL 2.5.50]
Date: Fri, 6 Dec 2002 13:55:33 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212061355.33462.abaxter@southernohio.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upon receiving compile errors when using the Initio 9100-U drivers I was able 
to modify and apply 2 patches from the list as well as added a few extra 
lines. I sent this to linux-scsi several days ago and received not complaints 
or comments.

This patch works great with my system, however I do get one odd compile 
warning during make install. It is as follows: No module initio found for 
kernel 2.5.50 This only occurs when the driver is built-in to the kernel. I 
know it's occurring during the mke2fs command, but I was unable to track down 
problem.

I'm unsure who is responsible for maintain this driver but I've seldom seen 
manufactures support beta OSes. If someone could look into this it would be 
great (or maybe someone already fixed it). I would appreciate any feedback I 
could get as I would like to have this contributed to the kernel package (if 
needed).

Aaron Baxter

--- linux/drivers/scsi/ini9100u.h.org   2002-12-05 04:34:14.000000000 -0500
+++ linux/drivers/scsi/ini9100u.h       2002-12-05 04:34:42.000000000 -0500
@@ -80,17 +80,16 @@
 extern int i91u_release(struct Scsi_Host *);
 extern int i91u_command(Scsi_Cmnd *);
 extern int i91u_queue(Scsi_Cmnd *, void (*done) (Scsi_Cmnd *));
+#if 0
 extern int i91u_abort(Scsi_Cmnd *);
 extern int i91u_reset(Scsi_Cmnd *, unsigned int);
-extern int i91u_biosparam(struct scsi_device *, struct block_device *,
-               sector_t, int *);
+#endif
+static int i91u_eh_bus_reset(Scsi_Cmnd * SCpnt);
+extern int i91u_biosparam(struct scsi_device *, struct block_device *, 
sector_t, int *);
 
 #define i91u_REVID "Initio INI-9X00U/UW SCSI device driver; Revision: 1.03g"
 
 #define INI9100U       { \
-       next:           NULL,                                           \
-       module:         NULL,                                           \
-       proc_name:      "INI9100U", \
        proc_info:      NULL,                           \
        name:           i91u_REVID, \
        detect:         i91u_detect, \
@@ -101,10 +100,8 @@
        eh_strategy_handler: NULL, \
        eh_abort_handler: NULL, \
        eh_device_reset_handler: NULL, \
-       eh_bus_reset_handler: NULL, \
+       eh_bus_reset_handler: i91u_eh_bus_reset, \
        eh_host_reset_handler: NULL, \
-       abort:          i91u_abort, \
-       reset:          i91u_reset, \
        bios_param:     i91u_biosparam, \
        can_queue:      1, \
        this_id:        1, \


--- linux/drivers/scsi/ini9100u.c.old   2002-12-05 04:34:24.000000000 -0500
+++ linux/driver/scsi/ini9100u.c        2002-12-05 04:38:55.000000000 -0500
@@ -108,7 +108,7 @@
 
 #define CVT_LINUX_VERSION(V,P,S)        (V * 65536 + P * 256 + S)
 
-#error Please convert me to Documentation/DMA-mapping.txt
+// #error Please convert me to Documentation/DMA-mapping.txt
 
 #ifndef LINUX_VERSION_CODE
 #include <linux/version.h>
@@ -138,6 +138,8 @@
 #include <linux/slab.h>
 #include "ini9100u.h"
 
+#include <linux/interrupt.h>
+
 #ifdef DEBUG_i91u
 unsigned int i91u_debug = DEBUG_DEFAULT;
 #endif
@@ -490,7 +492,9 @@
        if (SCpnt->use_sg) {
                pSrbSG = (struct scatterlist *) SCpnt->request_buffer;
                if (SCpnt->use_sg == 1) {       /* If only one entry in the 
list *//*      treat 
it as regular I/O */
-                       pSCB->SCB_BufPtr = (U32) VIRT_TO_BUS(pSrbSG->address);
+                       pSCB->SCB_BufPtr = (U32) VIRT_TO_BUS(
+                                       (unsigned char 
*)page_address(pSrbSG->page) +
+                                       pSrbSG->offset);
                        TotalLen = pSrbSG->length;
                        pSCB->SCB_SGLen = 0;
                } else {        /* Assign SG physical address   */
@@ -499,7 +503,9 @@
                        for (i = 0, TotalLen = 0, pSG = &pSCB->SCB_SGList[0];   
/* 1.01g */
                             i < SCpnt->use_sg;
                             i++, pSG++, pSrbSG++) {
-                               pSG->SG_Ptr = (U32) 
VIRT_TO_BUS(pSrbSG->address);
+                               pSG->SG_Ptr = (U32) VIRT_TO_BUS(
+                                               (unsigned char 
*)page_address(pSrbSG->page) +
+                                               pSrbSG->offset);
                                TotalLen += pSG->SG_Len = pSrbSG->length;
                        }
                        pSCB->SCB_SGLen = i;
@@ -551,6 +557,7 @@
        return -1;
 }
 
+#if 0
 /*
  *  Abort a queued command
  *  (commands that are on the bus can't be aborted easily)
@@ -578,6 +585,16 @@
        else
                return tul_device_reset(pHCB, (ULONG) SCpnt, SCpnt->target, 
reset_flags);
 }
+#endif
+
+static int i91u_eh_bus_reset(Scsi_Cmnd * SCpnt)
+{
+       HCS *pHCB;
+
+       pHCB = (HCS *) SCpnt->host->base;
+       tul_reset_scsi_bus(pHCB);
+       return SUCCESS;
+}
 
 /*
  * Return the "logical geometry"

