Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131060AbQKRW2h>; Sat, 18 Nov 2000 17:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131356AbQKRW22>; Sat, 18 Nov 2000 17:28:28 -0500
Received: from magrathea.systime-solutions.de ([212.66.133.138]:36870 "HELO
	magrathea.systime-solutions.de") by vger.kernel.org with SMTP
	id <S131060AbQKRW2N>; Sat, 18 Nov 2000 17:28:13 -0500
Message-ID: <3A170A06.934405FC@evision-ventures.com>
Date: Sun, 19 Nov 2000 00:00:23 +0100
From: dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision-ventures.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] megaraid driver update for 2.4.0-test10
Content-Type: multipart/mixed;
 boundary="------------1D1340A2870F2A0A12361FFE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1D1340A2870F2A0A12361FFE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch does the following:

1. Merge the most current version (aka: 1.08) of the
   MegaRAID driver from AMI in to the most current kernel
   (2.4.0-test10 and friends).

2. Try to be clever about HP NetRaid controllers used in
   HP LHR4 and LHR3 boxes. The current driver does initialize
   the bios version fields of the drivers main controll structure
   with entierly bogous values.

3. Fix the virt_to_phys mapping for scatter-gather transfers
   as well as some other minor tidups here and there.

This update does cause a *tremendeuos* performance increase for
this device under linux. So please apply it.

Thank's in advance!
--------------1D1340A2870F2A0A12361FFE
Content-Type: text/plain; charset=us-ascii;
 name="megaraid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="megaraid.patch"

diff -ur linux-old/drivers/scsi/megaraid.c linux/drivers/scsi/megaraid.c
--- linux-old/drivers/scsi/megaraid.c	Wed Oct  4 01:40:00 2000
+++ linux/drivers/scsi/megaraid.c	Sat Nov 18 23:14:38 2000
@@ -2,19 +2,19 @@
  *
  *                    Linux MegaRAID device driver
  *
- * Copyright 1999 American Megatrends Inc.
+ * Copyright 2000  American Megatrends Inc.
  *
  *              This program is free software; you can redistribute it and/or
  *              modify it under the terms of the GNU General Public License
  *              as published by the Free Software Foundation; either version
  *              2 of the License, or (at your option) any later version.
  *
- * Version : 1.07b
- * 
+ * Version : 1.09
+ *
  * Description: Linux device driver for AMI MegaRAID controller
  *
- * Supported controllers: MegaRAID 418, 428, 438, 466, 762, 467, 490
- * 
+ * Supported controllers: MegaRAID 418, 428, 438, 466, 762, 467, 471, 490
+ *					493.
  * History:
  *
  * Version 0.90:
@@ -42,7 +42,7 @@
  *     8 Oct 98        Alan Cox <alan.cox@linux.org>
  *
  *     Merged with 2.1.131 source tree.
- *     12 Dec 98       K. Baranowski <kgb@knm.org.pl>                          
+ *     12 Dec 98       K. Baranowski <kgb@knm.org.pl>
  *
  * Version 0.93:
  *     Added support for vendor specific ioctl commands (0x80+xxh)
@@ -76,7 +76,7 @@
  *     Changed megaraid_command to use wait_queue.
  *     Fixed bug of undesirably detecting HP onboard controllers which
  *       are disabled.
- *     
+ *
  * Version 1.00:
  *     Checks to see if an irq ocurred while in isr, and runs through
  *       routine again.
@@ -89,13 +89,13 @@
  *
  * Version 1.01:
  *     Fixed bug in mega_cmd_done() for megamgr control commands,
- *       the host_byte in the result code from the scsi request to 
- *       scsi midlayer is set to DID_BAD_TARGET when adapter's 
- *       returned codes are 0xF0 and 0xF4.  
+ *       the host_byte in the result code from the scsi request to
+ *       scsi midlayer is set to DID_BAD_TARGET when adapter's
+ *       returned codes are 0xF0 and 0xF4.
  *
  * Version 1.02:
  *     Fixed the tape drive bug by extending the adapter timeout value
- *       for passthrough command to 60 seconds in mega_build_cmd(). 
+ *       for passthrough command to 60 seconds in mega_build_cmd().
  *
  * Version 1.03:
  *    Fixed Madrona support.
@@ -104,7 +104,7 @@
  *    Added driver version printout at driver loadup time
  *
  * Version 1.04
- *    Added code for 40 ld FW support. 
+ *    Added code for 40 ld FW support.
  *    Added new ioctl command 0x81 to support NEW_READ/WRITE_CONFIG with
  *      data area greater than 4 KB, which is the upper bound for data
  *      tranfer through scsi_ioctl interface.
@@ -119,15 +119,48 @@
  *    Fixed the problem of unnecessary aborts in the abort entry point, which
  *      also enables the driver to handle large amount of I/O requests for
  *      long duration of time.
- *
+ * Version 1.06
+ *	Intel Release
  * Version 1.07
  *    Removed the usage of uaccess.h file for kernel versions less than
  *    2.0.36, as this file is not present in those versions.
  *
- * Version 1.07b
- *    The MegaRAID 466 cards with 3.00 firmware lockup and seem to very
- *    occasionally hang. We check such cards and report them. You can
- *    get firmware upgrades to flash the board to 3.10 for free.
+ * Version 108
+ *    Modified mega_ioctl so that 40LD megamanager would run
+ *    Made some changes for 2.3.XX compilation , esp wait structures
+ *    Code merge between 1.05 and 1.06 .
+ *    Bug fixed problem with ioctl interface for concurrency between
+ *    8ld and 40ld firwmare
+ *    Removed the flawed semaphore logic for handling new config command
+ *    Added support for building own scatter / gather list for big user
+ *    mode buffers
+ *    Added /proc file system support ,so that information is available in
+ *    human readable format
+ *
+ * Version 1a08
+ *    Changes for IA64 kernels. Checked for CONFIG_PROC_FS flag
+ *
+ * Version 1b08
+ *    Include file changes.
+ *
+ * Version 1c08
+ *    Firmware flashing option
+ *
+ * Version 1c08
+ *    Hard coded constants in the PCI device search function replaced with
+ *    following macros
+ *    PCI_VENDOR_ID_AMI, PCI_VENDOR_ID_AMI,
+ *    PCI_DEVICE_ID_AMI_MEGARAID, PCI_DEVICE_ID_AMI_MEGARAID2,
+ *    PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_80960_RP,
+ *
+ * Version 1e08
+ *  Modified to support a new VID information
+ *  PCI_DEVICE_ID_AMI_MEGARAID3 added
+ *
+ * Version 1.09
+ *	Nov 18 20:38:56 CET 2000 <dalecki@evision-ventures.com>
+ *	Merged the latest from AMI with 2.4.0-test10.
+ *	Try to be clever about HP NetRaid detection.
  *
  * BUGS:
  *     Some older 2.1 kernels (eg. 2.1.90) have a bug in pci.c that
@@ -135,7 +168,7 @@
  *
  *     Timeout period for upper scsi layer, i.e. SD_TIMEOUT in
  *     /drivers/scsi/sd.c, is too short for this controller. SD_TIMEOUT
- *     value must be increased to (30 * HZ) otherwise false timeouts 
+ *     value must be increased to (30 * HZ) otherwise false timeouts
  *     will occur in the upper layer.
  *
  *===================================================================*/
@@ -143,9 +176,11 @@
 #define CRLFSTR "\n"
 #define IOCTL_CMD_NEW  0x81
 
-#define MEGARAID_VERSION "v107 (December 22, 1999)"
-
+#define MEGARAID_VERSION "v1.09 (Nov 18, 2000)"
+#define MEGARAID_IOCTL_VERSION 108
 
+#include <linux/smp.h>
+#include <linux/config.h>
 #include <linux/version.h>
 
 #ifdef MODULE
@@ -161,6 +196,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
@@ -171,15 +207,18 @@
 #include <linux/wait.h>
 #include <linux/tqueue.h>
 #include <linux/interrupt.h>
+#include <linux/mm.h>
+#include <asm/pgtable.h>
 
+#include <linux/sched.h>
 #include <linux/stat.h>
+#include <linux/malloc.h>	/* for kmalloc() */
+#include <linux/config.h>	/* for CONFIG_PCI */
 #include <linux/spinlock.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
-#if LINUX_VERSION_CODE > 0x020024
 #include <asm/uaccess.h>
-#endif
 
 #include "sd.h"
 #include "scsi.h"
@@ -201,22 +240,22 @@
 #define COM_BASE 0x2f8
 
 
-u32 RDINDOOR (mega_host_config * megaCfg)
+ulong RDINDOOR (mega_host_config * megaCfg)
 {
   return readl (megaCfg->base + 0x20);
 }
 
-void WRINDOOR (mega_host_config * megaCfg, u32 value)
+void WRINDOOR (mega_host_config * megaCfg, ulong value)
 {
   writel (value, megaCfg->base + 0x20);
 }
 
-u32 RDOUTDOOR (mega_host_config * megaCfg)
+ulong RDOUTDOOR (mega_host_config * megaCfg)
 {
   return readl (megaCfg->base + 0x2C);
 }
 
-void WROUTDOOR (mega_host_config * megaCfg, u32 value)
+void WROUTDOOR (mega_host_config * megaCfg, ulong value)
 {
   writel (value, megaCfg->base + 0x2C);
 }
@@ -227,6 +266,7 @@
  *
  *================================================================
  */
+
 static int __init megaraid_setup(char *);
 
 static int megaIssueCmd (mega_host_config * megaCfg,
@@ -246,19 +286,14 @@
                                     mega_Enquiry3 *enquiry3,
                                     megaRaidProductInfo *productInfo );
 
-
-#include <linux/smp.h>
-
-
-#define cpuid smp_processor_id()
-#define DRIVER_LOCK_T
-#define DRIVER_LOCK_INIT(p)
-#define DRIVER_LOCK(p)
-#define DRIVER_UNLOCK(p)
-#define IO_LOCK_T unsigned long io_flags = 0;
+#define IO_LOCK_T unsigned long io_flags;
 #define IO_LOCK spin_lock_irqsave(&io_request_lock,io_flags);
 #define IO_UNLOCK spin_unlock_irqrestore(&io_request_lock,io_flags);
 
+#ifndef PCI_DEVICE_ID_INTEL_80960_RP
+#define PCI_DEVICE_ID_INTEL_80960_RP 0x1960
+#endif
+
 /* set SERDEBUG to 1 to enable serial debugging */
 #define SERDEBUG 0
 #if SERDEBUG
@@ -268,6 +303,19 @@
 static int ser_printk (const char *fmt,...);
 #endif
 
+#ifdef CONFIG_PROC_FS
+#define COPY_BACK if (offset > megaCfg->procidx) { \
+        *eof = TRUE; \
+        megaCfg->procidx = 0; \
+        megaCfg->procbuf[0] = 0; \
+	return 0;} \
+  if ((count + offset) > megaCfg->procidx) { \
+      count = megaCfg->procidx - offset; \
+      *eof = TRUE; } \
+      memcpy(page, &megaCfg->procbuf[offset], count); \
+      megaCfg->procidx = 0; \
+      megaCfg->procbuf[0] = 0; 
+#endif
 /*================================================================
  *
  *                    Global variables
@@ -278,14 +326,16 @@
 /*  Use "megaraid=skipXX" as LILO option to prohibit driver from scanning
     XX scsi id on each channel.  Used for Madrona motherboard, where SAF_TE
     processor id cannot be scanned */
+
+static char *megaraid;
 #ifdef MODULE
-static char *megaraid = NULL;
 MODULE_PARM(megaraid, "s");
 #endif
 static int skip_id;
 
 static int numCtlrs = 0;
 static mega_host_config *megaCtlrs[FC_MAX_CHANNELS] = {0};
+struct proc_dir_entry *mega_proc_dir_entry; 
 
 #if DEBUG
 static u32 maxCmdTime = 0;
@@ -295,7 +345,12 @@
 
 
 #if SERDEBUG
-static spinlock_t serial_lock = SPIN_LOCK_UNLOCKED;
+volatile static spinlock_t serial_lock;
+#endif
+
+struct proc_dir_entry *proc_scsi_megaraid;
+#ifdef CONFIG_PROC_FS
+extern struct proc_dir_entry proc_root;
 #endif
 
 #if SERDEBUG
@@ -403,10 +458,10 @@
           megaCfg->qPendingT = pScbtmp;
         }
         megaCfg->qPcnt--;
-	break;
+        break;
+      }
     }
   }
-  }
 
   /* Link back into free list */
   pScb->state = SCB_FREE;
@@ -484,7 +539,7 @@
   return 0;
 }
 
-/* Run through the list of completed requests */
+/* Run through the list of completed requests  and finish it*/
 static void mega_rundoneq (mega_host_config *megaCfg)
 {
   Scsi_Cmnd *SCpnt;
@@ -527,11 +582,13 @@
   mega_passthru *pthru;
   mega_mailbox *mbox;
 
+
+
   if (pScb == NULL) {
 	TRACE(("NULL pScb in mega_cmd_done!"));
 	printk("NULL pScb in mega_cmd_done!");
   }
-
+ 
   SCpnt = pScb->SCpnt;
   pthru = &pScb->pthru;
   mbox = (mega_mailbox *) &pScb->mboxData;
@@ -558,6 +615,7 @@
 
 if ((SCpnt->cmnd[0] & 0x80) ) {/* i.e. ioctl cmd such as 0x80, 0x81 of megamgr*/
     switch (status) {
+      case 2:
       case 0xF0:
       case 0xF4:
 	SCpnt->result=(DID_BAD_TARGET<<16)|status;
@@ -592,12 +650,7 @@
     break;
   }
  }
-  if ( SCpnt->cmnd[0]!=IOCTL_CMD_NEW ) 
-  /* not IOCTL_CMD_NEW SCB, freeSCB()*/
-  /* For IOCTL_CMD_NEW SCB, delay freeSCB() in megaraid_queue()
-   * after copy data back to user space*/
-     mega_freeSCB(megaCfg, pScb);
-
+ mega_freeSCB(megaCfg, pScb); 
   /* Add Scsi_Command to end of completed queue */
     if( megaCfg->qCompletedH == NULL ) {
       megaCfg->qCompletedH = megaCfg->qCompletedT = SCpnt;
@@ -628,8 +681,8 @@
   char islogical;
   char lun = SCpnt->lun;
 
-  if ((SCpnt->cmnd[0] == 0x80)  || (SCpnt->cmnd[0] == IOCTL_CMD_NEW) )  /* ioctl */
-    return mega_ioctl (megaCfg, SCpnt);
+  if ((SCpnt->cmnd[0] == 0x80)  || (SCpnt->cmnd[0] == IOCTL_CMD_NEW) )  
+    return mega_ioctl (megaCfg, SCpnt); /* Handle IOCTL command */
  
   islogical = (SCpnt->channel == megaCfg->host->max_channel);
 
@@ -645,7 +698,7 @@
 	return NULL;
   }
 
-  if ( islogical ) {
+  if (islogical) {
 	lun = (SCpnt->target * 8) + lun;
         if ( lun > FC_MAX_LOGICAL_DRIVES ){
             SCpnt->result = (DID_BAD_TARGET << 16);
@@ -727,6 +780,15 @@
 	  ((u32) SCpnt->cmnd[2] << 8) |
 	  (u32) SCpnt->cmnd[3];
 	mbox->lba &= 0x1FFFFF;
+
+        if (*SCpnt->cmnd == READ_6) { 
+		megaCfg->nReads[(int)lun]++;
+                megaCfg->nReadBlocks[(int)lun] += mbox->numsectors;
+        }
+        else {
+		megaCfg->nWrites[(int)lun]++;
+                megaCfg->nWriteBlocks[(int)lun] += mbox->numsectors;
+       }
       }
 
       /* 10-byte */
@@ -739,6 +801,15 @@
 	  ((u32) SCpnt->cmnd[3] << 16) |
 	  ((u32) SCpnt->cmnd[4] << 8) |
 	  (u32) SCpnt->cmnd[5];
+
+        if (*SCpnt->cmnd == READ_10) { 
+		megaCfg->nReads[(int)lun]++;
+                megaCfg->nReadBlocks[(int)lun] += mbox->numsectors;
+        }
+        else {
+		megaCfg->nWrites[(int)lun]++;
+                megaCfg->nWriteBlocks[(int)lun] += mbox->numsectors;
+        }
       }
 
       /* Calculate Scatter-Gather info */
@@ -795,6 +866,40 @@
   return NULL;
 }
 
+/* Handle Driver Level IOCTLs 
+ * Return value of 0 indicates this function could not handle , so continue
+ * processing 
+*/
+
+static int mega_driver_ioctl (mega_host_config * megaCfg, Scsi_Cmnd * SCpnt)
+{
+  unsigned char *data = (unsigned char *)SCpnt->request_buffer;
+  mega_driver_info driver_info;
+
+  /* If this is not our command dont do anything */
+  if (SCpnt->cmnd[0] != DRIVER_IOCTL_INTERFACE)
+	return 0;
+
+  switch(SCpnt->cmnd[1]) {
+  case GET_DRIVER_INFO:
+                if (SCpnt->request_bufflen < sizeof(driver_info)) {
+			SCpnt->result = DID_BAD_TARGET << 16 ;
+			callDone(SCpnt);
+			return 1;
+		}
+		
+		driver_info.size = sizeof(driver_info) - sizeof(int);
+		driver_info.version = MEGARAID_IOCTL_VERSION;
+		memcpy( data, &driver_info, sizeof(driver_info));
+		break;
+   default:
+		SCpnt->result = DID_BAD_TARGET << 16;
+  }
+
+ callDone(SCpnt);
+ return 1;
+}
+
 /*--------------------------------------------------------------------
  * build RAID commands for controller, passed down through ioctl()
  *--------------------------------------------------------------------*/
@@ -805,9 +910,9 @@
   mega_mailbox *mailbox;
   mega_passthru *pthru;
   u8 *mboxdata;
-  long seg;
+  long seg, i;
   unsigned char *data = (unsigned char *)SCpnt->request_buffer;
-  int i;
+  char *user_area = NULL;
 
   if ((pScb = mega_allocateSCB (megaCfg, SCpnt)) == NULL) {
     SCpnt->result = (DID_ERROR << 16);
@@ -820,7 +925,7 @@
   mailbox = (mega_mailbox *) & pScb->mboxData;
   memset (mailbox, 0, sizeof (pScb->mboxData));
 
-  if (data[0] == 0x03) {	/* passthrough command */
+ if (data[0] == 0x03) {	/* passthrough command */
     unsigned char cdblen = data[2];
     pthru = &pScb->pthru;
     memset (pthru, 0, sizeof (mega_passthru));
@@ -841,15 +946,14 @@
 					 (u32 *) & pthru->dataxferaddr,
 					 (u32 *) & pthru->dataxferlen);
 
-    for (i=0;i<(SCpnt->request_bufflen-cdblen-7);i++) {
-       data[i] = data[i+cdblen+7];
+    for (i = 0 ; i < (SCpnt->request_bufflen - cdblen - 7) ; i++) {
+       data[i] = data[i + cdblen + 7];
     }
 
     return pScb;
   }
   /* else normal (nonpassthru) command */
 
-#if LINUX_VERSION_CODE > 0x020024
 /*
  * usage of the function copy from user is used in case of data more than
  * 4KB.  This is used only with adapters which supports more than 8 logical
@@ -857,32 +961,38 @@
  * as the uaccess.h file is not available with those kernels.
  */
 
-  if (SCpnt->cmnd[0] == IOCTL_CMD_NEW) { 
+  if (SCpnt->cmnd[0] == IOCTL_CMD_NEW) {
             /* use external data area for large xfers  */
      /* If cmnd[0] is set to IOCTL_CMD_NEW then *
       *   cmnd[4..7] = external user buffer     *
       *   cmnd[8..11] = length of buffer        *
       *                                         */
-      char *kern_area;
-      char *user_area = *((char **)&SCpnt->cmnd[4]);
       u32 xfer_size = *((u32 *)&SCpnt->cmnd[8]);
+      user_area = *((char **)&SCpnt->cmnd[4]);
       if (verify_area(VERIFY_READ, user_area, xfer_size)) {
           printk("megaraid: Got bad user address.\n");
           SCpnt->result = (DID_ERROR << 16);
           callDone (SCpnt);
           return NULL;
       }
-      kern_area = kmalloc(xfer_size, GFP_ATOMIC | GFP_DMA);
-      if (kern_area == NULL) {
-          printk("megaraid: Couldn't allocate kernel mem.\n");
-	  SCpnt->result = (DID_ERROR << 16);
-	  callDone (SCpnt);
-	  return NULL;
+      switch (data[0])
+      {
+	case FW_FIRE_WRITE:
+	case FW_FIRE_FLASH:
+	 printk("megaraid:Write/ Flash called\n");
+	 if ((ulong)user_area & (PAGE_SIZE - 1)) {
+          printk("megaraid:user address not aligned on 4K boundary.Error.\n");
+          SCpnt->result = (DID_ERROR << 16);
+          callDone (SCpnt);
+          return NULL;
+	 }
+	 break;
+	case DCMD_FC_CMD:
+	 mega_build_user_sg(user_area, xfer_size, pScb, mbox);
+	 break;
       }
-      copy_from_user(kern_area,user_area,xfer_size);
-      pScb->kern_area = kern_area;
+
   }
-#endif
 
   mbox->cmd = data[0];
   mbox->channel = data[1];
@@ -890,20 +1000,32 @@
   mbox->pad[0] = data[3];
   mbox->logdrv = data[4];
 
-  if(SCpnt->cmnd[0] == IOCTL_CMD_NEW) {
-      if(data[0]==DCMD_FC_CMD){ /*i.e. 0xA1, then override some mbox data */
+  if (SCpnt->cmnd[0] == IOCTL_CMD_NEW) {
+      switch (data[0]) {
+        case FW_FIRE_WRITE:
+	      mbox->cmd = FW_FIRE_WRITE;
+	      mbox->channel = data[1]; /* Current Block Number */
+	      mbox->xferaddr = virt_to_phys(user_area);
+	      mbox->numsgelements = 0;
+	      printk("megaraid: Fire Write Filled\n");
+	      break;
+	case FW_FIRE_FLASH:
+	      mbox->cmd = FW_FIRE_FLASH;
+	      mbox->channel = data[1] | 0x80 ; /* Origin */
+	      mbox->xferaddr = virt_to_phys(user_area);
+	      mbox->numsgelements = 0;
+	      printk("megaraid: Fire Flash Filled\n");
+	      break;
+        case DCMD_FC_CMD:  /*i.e. 0xA1, then override some mbox data */
           *(mboxdata+0) = data[0]; /*mailbox byte 0: DCMD_FC_CMD*/
-          *(mboxdata+2) = data[2]; /*sub command*/
-          *(mboxdata+3) = 0;       /*number of elements in SG list*/
-          mbox->xferaddr           /*i.e. mboxdata byte 0x8 to 0xb*/
-                        = virt_to_bus(pScb->kern_area);
-      }
-      else{
-         mbox->xferaddr = virt_to_bus(pScb->kern_area);
-         mbox->numsgelements = 0;
+          *(mboxdata+2) = data[1]; /*sub command*/
+          *(mboxdata+3) = mbox->numsgelements;       /*number of elements in SG list*/
+	  break;
+	default:
+          mbox->xferaddr = virt_to_bus(user_area);
+          mbox->numsgelements = 0;
       }
-  } 
-  else {
+  } else {
 
       mbox->numsgelements = mega_build_sglist (megaCfg, pScb,
 				      (u32 *) & mbox->xferaddr,
@@ -917,6 +1039,43 @@
   return (pScb);
 }
 
+/* Builds a Scatter / Gather List for the given User Mode Buffer
+ * Is not optimized for handling contigous physical address though
+ * easy to implement
+*/
+void mega_build_user_sg(char *uarea, ulong xfersize, mega_scb *pScb,
+			 mega_ioctl_mbox *mbox)
+{
+    ulong i, user_area, len, end, end_page, x, idx = 0;
+
+    user_area = (ulong)uarea;
+
+    i = user_area;
+    end = user_area + xfersize;
+    end_page = (end) & ~(PAGE_SIZE - 1);
+
+    do
+    {
+	len =  PAGE_SIZE - (i % PAGE_SIZE);
+	x = pScb->sgList[idx].address = virt_to_phys((void *) i);
+	pScb->sgList[idx].length = len;
+        i += len;
+        idx++;
+    } while (i < end_page);
+ 
+
+   if (end - i) 
+   {
+    	pScb->sgList[idx].address = virt_to_phys((void *) i);
+    	pScb->sgList[idx].length = end - i;
+   }
+   idx++; 
+   mbox->xferaddr = virt_to_bus(pScb->sgList);
+   mbox->numsgelements = idx;
+
+}
+
+	
 #if DEBUG
 static void showMbox(mega_scb *pScb)
 {
@@ -934,8 +1093,8 @@
 #endif
 
 #if DEBUG
-static unsigned int cum_time = 0;
-static unsigned int cum_time_cnt = 0;
+static unsigned int cum_time;
+static unsigned int cum_time_cnt;
 #endif
 
 /*--------------------------------------------------------------------
@@ -943,10 +1102,7 @@
  *--------------------------------------------------------------------*/
 static void megaraid_isr (int irq, void *devp, struct pt_regs *regs)
 {
-#if LINUX_VERSION_CODE >= 0x20100
-  IO_LOCK_T
-#endif
-  mega_host_config    *megaCfg;
+  IO_LOCK_T mega_host_config* megaCfg;
   u_char byte, idx, sIdx, tmpBox[MAILBOX_SIZE];
   u32 dword=0;
   mega_mailbox *mbox;
@@ -959,8 +1115,10 @@
   mbox = (mega_mailbox *)tmpBox;
 
   if (megaCfg->host->irq == irq) {
+
     if (megaCfg->flag & IN_ISR) {
-      printk(KERN_ERR "ISR called reentrantly!!\n");
+      TRACE (("ISR called reentrantly!!\n"));
+      printk ("ISR called reentrantly!!\n");
     }
 
     megaCfg->flag |= IN_ISR;
@@ -989,9 +1147,9 @@
     }
 
     for(idx=0;idx<MAX_FIRMWARE_STATUS;idx++ ) completed[idx] = 0;
-
+    
     IO_LOCK;
-
+    megaCfg->nInterrupts++;
     qCnt = 0xff;
     while ((qCnt = megaCfg->mbox->numstatus) == 0xFF) 
       ;
@@ -1059,32 +1217,25 @@
           megaCfg->qCompletedT->host_scribble = (unsigned char *) NULL;
           megaCfg->qCcnt++;
           continue;
-	}
-
-        if (*(pScb->SCpnt->cmnd)==IOCTL_CMD_NEW) 
-        {    /* external user buffer */
-           up(&pScb->sem);
         }
+
 	/* Mark command as completed */
 	mega_cmd_done(megaCfg, pScb, qStatus);
 
       }
       else {
-        printk(KERN_ERR "megaraid: wrong cmd id completed from firmware:id=%x\n",sIdx);
+        printk("megaraid: wrong cmd id completed from firmware:id=%x\n",sIdx);
       }
     }
 
     mega_rundoneq(megaCfg);
 
     megaCfg->flag &= ~IN_ISR;
-
     /* Loop through any pending requests */
     mega_runpendq(megaCfg);
-#if LINUX_VERSION_CODE >= 0x20100
     IO_UNLOCK;
-#endif
-
   }
+
 }
 
 /*==================================================*/
@@ -1125,19 +1276,23 @@
 	      mega_scb * pScb,
 	      int intr)
 {
-  mega_mailbox *mbox = (mega_mailbox *) megaCfg->mbox;
+  volatile mega_mailbox *mbox = (mega_mailbox *) megaCfg->mbox;
   u_char byte;
-  u32 cmdDone;
+
+#ifdef __LP64__
+  u64 phys_mbox;
+#else
   u32 phys_mbox;
+#endif
   u8 retval=-1;
 
-  mboxData[0x1] = (pScb ? pScb->idx + 1: 0x0);   /* Set cmdid */
+  mboxData[0x1] = (pScb ? pScb->idx + 1: 0xFE);   /* Set cmdid */
   mboxData[0xF] = 1;		/* Set busy */
 
   phys_mbox = virt_to_bus (megaCfg->mbox);
 
 #if DEBUG
-  showMbox(pScb);
+  ShowMbox(pScb);
 #endif
 
   /* Wait until mailbox is free */
@@ -1162,7 +1317,7 @@
 
   /* Copy mailbox data into host structure */
   megaCfg->mbox64->xferSegment = 0;
-  memcpy (mbox, mboxData, 16);
+  memcpy ((char *)mbox, mboxData, 16);
 
   /* Kick IO */
   if (intr) {
@@ -1186,10 +1341,18 @@
     if (megaCfg->flag & BOARD_QUARTZ) {
       mbox->mraid_poll = 0;
       mbox->mraid_ack = 0;
+      mbox->numstatus = 0xFF;
+      mbox->status = 0xFF;
       WRINDOOR (megaCfg, phys_mbox | 0x1);
-
-      while ((cmdDone = RDOUTDOOR (megaCfg)) != 0x10001234);
-      WROUTDOOR (megaCfg, cmdDone);
+     
+     while (mbox->numstatus == 0xFF);
+     while (mbox->status == 0xFF);
+     while (mbox->mraid_poll != 0x77);
+     mbox->mraid_poll = 0;
+     mbox->mraid_ack = 0x77;
+ 
+    /* while ((cmdDone = RDOUTDOOR (megaCfg)) != 0x10001234);
+      WROUTDOOR (megaCfg, cmdDone);*/
 
       if (pScb) {
 	mega_cmd_done (megaCfg, pScb, mbox->status);
@@ -1286,9 +1449,15 @@
 {
   /* align on 16-byte boundry */
   megaCfg->mbox = &megaCfg->mailbox64.mailbox;
-  megaCfg->mbox = (mega_mailbox *) ((((u32) megaCfg->mbox) + 16) & 0xfffffff0);
+#ifdef __LP64__
+  megaCfg->mbox = (mega_mailbox *) ((((u64) megaCfg->mbox) + 16) & ( (ulong)(-1) ^ 0x0F)  );
   megaCfg->mbox64 = (mega_mailbox64 *) (megaCfg->mbox - 4);
-  paddr = (paddr + 4 + 16) & 0xfffffff0;
+  paddr = (paddr + 4 + 16) & ( (u64)(-1) ^ 0x0F );
+#else
+  megaCfg->mbox = (mega_mailbox *) ((((u32) megaCfg->mbox) + 16) & 0xFFFFFFF0);
+  megaCfg->mbox64 = (mega_mailbox64 *) (megaCfg->mbox - 4);
+  paddr = (paddr + 4 + 16) & 0xFFFFFFF0;
+#endif
 
   /* Register mailbox area with the firmware */
   if (!(megaCfg->flag & BOARD_QUARTZ)) {
@@ -1420,33 +1589,38 @@
     megaCfg->host->can_queue = MAX_COMMANDS-1;
   }
 
-#ifdef HP			/* use HP firmware and bios version encoding */
-  sprintf (megaCfg->fwVer, "%c%d%d.%d%d",
+  if (megaCfg->productInfo.BiosVer[0] == 4) {
+
+	/* HACK ALLERT: Try to use HP firmware and bios version encoding.  If
+	 * we don't then OEM versions of this controller distributed by HP as
+	 * NetRaid will have the corresponding fields set to complete trash.
+	 */
+
+	sprintf (megaCfg->fwVer, "%c%d%d.%d%d",
 	   megaCfg->productInfo.FwVer[2],
 	   megaCfg->productInfo.FwVer[1] >> 8,
 	   megaCfg->productInfo.FwVer[1] & 0x0f,
 	   megaCfg->productInfo.FwVer[2] >> 8,
 	   megaCfg->productInfo.FwVer[2] & 0x0f);
-  sprintf (megaCfg->biosVer, "%c%d%d.%d%d",
+	sprintf (megaCfg->biosVer, "%c%d%d.%d%d",
 	   megaCfg->productInfo.BiosVer[2],
 	   megaCfg->productInfo.BiosVer[1] >> 8,
 	   megaCfg->productInfo.BiosVer[1] & 0x0f,
 	   megaCfg->productInfo.BiosVer[2] >> 8,
 	   megaCfg->productInfo.BiosVer[2] & 0x0f);
-#else
-	memcpy (megaCfg->fwVer, (void *)megaCfg->productInfo.FwVer, 4);
-	megaCfg->fwVer[4] = 0;
+  } else {
+	memcpy (megaCfg->fwVer, (char *)megaCfg->productInfo.FwVer, 4);
+	megaCfg->fwVer[4] = '\0';
+
+	memcpy (megaCfg->biosVer, (char *)megaCfg->productInfo.BiosVer, 4);
+	megaCfg->biosVer[4] = '\0';
+  }
+  printk ("megaraid: [%s:%s] detected %d logical drives" CRLFSTR,
+          megaCfg->fwVer,
+	  megaCfg->biosVer,
+	  megaCfg->numldrv);
 
-	memcpy (megaCfg->biosVer, (void *)megaCfg->productInfo.BiosVer, 4);
-	megaCfg->biosVer[4] = 0;
-#endif
-
-	printk ("megaraid: [%s:%s] detected %d logical drives" CRLFSTR,
-        	megaCfg->fwVer,
-		megaCfg->biosVer,
-		megaCfg->numldrv);
-
-	return 0;
+  return 0;
 }
 
 /*-------------------------------------------------------------------------
@@ -1462,6 +1636,7 @@
 		    int length, int host_no, int inout)
 {
   *start = buffer;
+  
   return 0;
 }
 
@@ -1469,47 +1644,76 @@
 	  u16 pciVendor, u16 pciDev,
 	  long flag)
 {
-  mega_host_config *megaCfg;
-  struct Scsi_Host *host;
-  u_char megaIrq;
+  mega_host_config *megaCfg = NULL;
+  struct Scsi_Host *host = NULL;
+  u_char pciBus, pciDevFun, megaIrq;
+
+#ifdef __LP64__
+  u64 megaBase;
+#else
   u32 megaBase;
-  u16 numFound = 0;
+#endif
 
+  u16 pciIdx = 0;
+  u16 numFound = 0;
   struct pci_dev *pdev = NULL;
-  
+
   while ((pdev = pci_find_device (pciVendor, pciDev, pdev))) {
-    if (pci_enable_device(pdev))
-    	continue;
+    pciBus = pdev->bus->number;
+    pciDevFun = pdev->devfn;
     if ((flag & BOARD_QUARTZ) && (skip_id == -1)) {
       u16 magic;
-      pci_read_config_word(pdev, PCI_CONF_AMISIG, &magic);
-      if ((magic != AMI_SIGNATURE) && (magic != AMI_SIGNATURE_471))
+      pcibios_read_config_word (pciBus, pciDevFun,
+				PCI_CONF_AMISIG,
+				&magic);
+      if ((magic != AMI_SIGNATURE) && (magic != AMI_SIGNATURE_471) ){
+        pciIdx++;
 	continue;		/* not an AMI board */
+      }
     }
-    printk (KERN_INFO "megaraid: found 0x%4.04x:0x%4.04x: in %s\n",
+
+	/* Hmmm...Should we not make this more modularized so that in future we
+	 * dont add for each firmware */
+
+	if (flag & BOARD_QUARTZ) {
+      /* Check to see if this is a Dell PERC RAID controller model 466 */
+			u16 subsysid, subsysvid;
+			pci_read_config_word (pdev,
+						 PCI_SUBSYSTEM_VENDOR_ID,
+						 &subsysvid);
+			pci_read_config_word (pdev, 
+						PCI_SUBSYSTEM_ID,
+						 &subsysid);
+			if ( (subsysid == 0x1111) && (subsysvid == 0x1111) &&
+				(!strcmp(megaCfg->fwVer,"3.00") || 						!strcmp(megaCfg->fwVer,"3.01"))) {
+				printk(KERN_WARNING
+				"megaraid: Your card is a Dell PERC 2/SC RAID controller with firmware\n"
+				"megaraid: 3.00 or 3.01.  This driver is known to have corruption issues\n"
+				"megaraid: with those firmware versions on this specific card.  In order\n"
+				"megaraid: to protect your data, please upgrade your firmware to version\n"
+				"megaraid: 3.10 or later, available from the Dell Technical Support web\n"
+				"megaraid: site at\n"
+				"http://support.dell.com/us/en/filelib/download/index.asp?fileid=2940\n");
+			continue;
+			}
+		}
+
+	if (pci_enable_device(pdev))
+		continue;
+
+    printk (KERN_INFO "megaraid: found 0x%4.04x:0x%4.04x:idx %d:bus %d:slot %d:func %d\n",
 	    pciVendor,
 	    pciDev,
-	    pdev->slot_name);
-
-    /*
-     *	Dont crash on boot with AMI cards configured for I2O. 
-     *  (our I2O code will find them then they will fail oddly until
-     *   we figure why they upset our I2O code). This driver will die
-     *   if it tries to boot an I2O mode board and we dont stop it now.
-     *     - Alan Cox , Red Hat Software, Jan 2000
-     */
-     	    
-    if((pdev->class >> 8) == PCI_CLASS_INTELLIGENT_I2O)
-    {
-    	printk( KERN_INFO "megaraid: Board configured for I2O, ignoring this card. Reconfigure the card\n"
-		KERN_INFO "megaraid: in the BIOS for \"mass storage\" to use it with this driver.\n");
-	continue;
-    }		
+	    pciIdx, pciBus,
+	    PCI_SLOT (pciDevFun),
+	    PCI_FUNC (pciDevFun));
 
     /* Read the base port and IRQ from PCI */
-    megaBase = pci_resource_start (pdev, 0);
+    megaBase = pci_resource_start(pdev, 0);
     megaIrq  = pdev->irq;
 
+    pciIdx++;
+
     if (flag & BOARD_QUARTZ)
       megaBase = (long) ioremap (megaBase, 128);
     else
@@ -1539,8 +1743,9 @@
     megaCfg->host->irq = megaIrq;
     megaCfg->host->io_port = megaBase;
     megaCfg->host->n_io_port = 16;
-    megaCfg->host->unique_id = (pdev->bus->number << 8) | pdev->devfn;
+    megaCfg->host->unique_id = (pciBus << 8) | pciDevFun;
     megaCtlrs[numCtlrs++] = megaCfg; 
+
     if (flag != BOARD_QUARTZ) {
       /* Request our IO Range */
       if (check_region (megaBase, 16)) {
@@ -1562,43 +1767,10 @@
 
     mega_register_mailbox (megaCfg, virt_to_bus ((void *) &megaCfg->mailbox64));
     mega_i_query_adapter (megaCfg);
-   
-    if (flag == BOARD_QUARTZ) {
-      /* Check to see if this is a Dell PERC RAID controller model 466 */
-      u16 subsysid, subsysvid;
-#if LINUX_VERSION_CODE < 0x20100
-      pcibios_read_config_word (pciBus, pciDevFun,
-				PCI_SUBSYSTEM_VENDOR_ID,
-				&subsysvid);
-      pcibios_read_config_word (pciBus, pciDevFun,
-				PCI_SUBSYSTEM_ID,
-				&subsysid);
-#else
-      pci_read_config_word (pdev, PCI_SUBSYSTEM_VENDOR_ID, &subsysvid);
-      pci_read_config_word (pdev, PCI_SUBSYSTEM_ID, &subsysid);
-#endif
-      if ( (subsysid == 0x1111) && (subsysvid == 0x1111) &&
-           (!strcmp(megaCfg->fwVer,"3.00") || !strcmp(megaCfg->fwVer,"3.01"))) {
-	printk(KERN_WARNING
-"megaraid: Your card is a Dell PERC 2/SC RAID controller with firmware\n"
-"megaraid: 3.00 or 3.01.  This driver is known to have corruption issues\n"
-"megaraid: with those firmware versions on this specific card.  In order\n"
-"megaraid: to protect your data, please upgrade your firmware to version\n"
-"megaraid: 3.10 or later, available from the Dell Technical Support web\n"
-"megaraid: site at\n"
-"http://support.dell.com/us/en/filelib/download/index.asp?fileid=2940\n");
-	megaraid_release (host);
-#ifdef MODULE	
-	continue;
-#else
-	while(1) schedule_timeout(1 * HZ);
-#endif	
-      }
-    }
-
+    
     /* Initialize SCBs */
     if (mega_initSCB (megaCfg)) {
-      megaraid_release (host);
+      megaraid_release(host);
       continue;
     }
 
@@ -1612,20 +1784,38 @@
  *---------------------------------------------------------*/
 int megaraid_detect (Scsi_Host_Template * pHostTmpl)
 {
-  int count = 0;
-
-#ifdef MODULE
-  if (megaraid)
-      megaraid_setup(megaraid);
-#endif
+  int ctlridx = 0, count = 0;
 
   pHostTmpl->proc_name = "megaraid";
 
+  skip_id = -1;
+  if (megaraid && !strncmp(megaraid,"skip",strlen("skip"))) {
+      if (megaraid[4] != '\0') {
+          skip_id = megaraid[4] - '0';
+          if (megaraid[5] != '\0') {
+              skip_id = (skip_id * 10) + (megaraid[5] - '0');
+          }
+      }
+      skip_id = (skip_id > 15) ? -1 : skip_id;
+  }
+
   printk ("megaraid: " MEGARAID_VERSION CRLFSTR);
 
-  count += mega_findCard (pHostTmpl, 0x101E, 0x9010, 0);
-  count += mega_findCard (pHostTmpl, 0x101E, 0x9060, 0);
-  count += mega_findCard (pHostTmpl, 0x8086, 0x1960, BOARD_QUARTZ);
+  count += mega_findCard (pHostTmpl, PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID, 0);
+  count += mega_findCard (pHostTmpl, PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID2, 0);
+  count += mega_findCard (pHostTmpl, PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID3, BOARD_QUARTZ);
+  count += mega_findCard (pHostTmpl, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_80960_RP, BOARD_QUARTZ);
+
+#ifdef CONFIG_PROC_FS
+  if (count) {
+        mega_proc_dir_entry = proc_mkdir("megaraid", &proc_root);
+        if (!mega_proc_dir_entry)
+		printk("megaraid: failed to create megaraid root\n");
+        else
+		for (ctlridx = 0; ctlridx < count ; ctlridx++)
+			mega_create_proc_entry(ctlridx, mega_proc_dir_entry);
+  }
+#endif
 
   return count;
 }
@@ -1638,6 +1828,7 @@
   mega_host_config *megaCfg;
   mega_mailbox *mbox;
   u_char mboxData[16];
+  int i;
 
   megaCfg = (mega_host_config *) pSHost->hostdata;
   mbox = (mega_mailbox *) mboxData;
@@ -1663,6 +1854,21 @@
   mega_freeSgList(megaCfg);
   scsi_unregister (pSHost);
 
+#ifdef CONFIG_PROC_FS
+  if (megaCfg->controller_proc_dir_entry) {
+	  remove_proc_entry("stat",megaCfg->controller_proc_dir_entry);
+	  remove_proc_entry("status", megaCfg->controller_proc_dir_entry);
+	  remove_proc_entry("config", megaCfg->controller_proc_dir_entry);
+	  remove_proc_entry("mailbox", megaCfg->controller_proc_dir_entry);
+          for (i = 0; i < numCtlrs; i++) {
+                char buf[12] ={0};
+		sprintf(buf,"%d",i);
+          	remove_proc_entry(buf,mega_proc_dir_entry);
+	 }
+         remove_proc_entry("megaraid", &proc_root);
+  }  
+#endif
+
   return 0;
 }
 
@@ -1712,12 +1918,10 @@
  *-----------------------------------------------------------------*/
 int megaraid_queue (Scsi_Cmnd * SCpnt, void (*pktComp) (Scsi_Cmnd *))
 {
-  DRIVER_LOCK_T
   mega_host_config *megaCfg;
   mega_scb *pScb;
 
   megaCfg = (mega_host_config *) SCpnt->host->hostdata;
-  DRIVER_LOCK(megaCfg);
 
   if (!(megaCfg->flag & (1L << SCpnt->channel))) {
     if (SCpnt->channel < SCpnt->host->max_channel)
@@ -1731,6 +1935,9 @@
   }
 
   SCpnt->scsi_done = pktComp;
+  
+  if (mega_driver_ioctl(megaCfg, SCpnt))
+	return 0;
 
   /* If driver in abort or reset.. cancel this command */
   if (megaCfg->flag & IN_ABORT) {
@@ -1746,7 +1953,6 @@
     megaCfg->qCompletedT->host_scribble = (unsigned char *) NULL;
     megaCfg->qCcnt++;
 
-    DRIVER_UNLOCK(megaCfg);
     return 0;
   }
   else if (megaCfg->flag & IN_RESET) {
@@ -1762,7 +1968,6 @@
     megaCfg->qCompletedT->host_scribble = (unsigned char *) NULL;
     megaCfg->qCcnt++;
 
-    DRIVER_UNLOCK(megaCfg);
     return 0;
   }
 
@@ -1784,38 +1989,18 @@
 
       mega_runpendq(megaCfg);
 
-#if LINUX_VERSION_CODE > 0x020024
-    if ( SCpnt->cmnd[0]==IOCTL_CMD_NEW )
-    {  /* user data from external user buffer */
-          char *user_area;
-          u32  xfer_size;
-
-          init_MUTEX_LOCKED(&pScb->sem);
-          down(&pScb->sem);
-
-          user_area = *((char **)&pScb->SCpnt->cmnd[4]);
-          xfer_size = *((u32 *)&pScb->SCpnt->cmnd[8]);
-
-          copy_to_user(user_area,pScb->kern_area,xfer_size);
-
-          kfree(pScb->kern_area);
+  megaCfg->flag &= ~IN_QUEUE;
 
-          mega_freeSCB(megaCfg, pScb);
-    }
-#endif
   }
 
-  megaCfg->flag &= ~IN_QUEUE;
-  DRIVER_UNLOCK(megaCfg);
-
   return 0;
 }
 
 /*----------------------------------------------------------------------
  * Issue a blocking command to the controller
  *----------------------------------------------------------------------*/
-volatile static int internal_done_flag = 0;
-volatile static int internal_done_errcode = 0;
+volatile static int internal_done_flag;
+volatile static int internal_done_errcode;
 static DECLARE_WAIT_QUEUE_HEAD(internal_wait);
 
 static void internal_done (Scsi_Cmnd * SCpnt)
@@ -1914,7 +2099,7 @@
 if(megaCfg->flag & IN_QUEUE)  printk("ma:flag is in queue\n");
 if(megaCfg->qCompletedH == NULL) printk("ma:qchead == null\n");
 #endif
-  
+
 /*
  * This is required here to complete any completed requests to be communicated
  * over to the mid layer.
@@ -1976,6 +2161,178 @@
   mega_rundoneq(megaCfg);
   return rc;
 }
+
+
+#ifdef CONFIG_PROC_FS
+/* Following code handles /proc fs  */
+static int proc_printf (mega_host_config *megaCfg, const char *fmt,...)
+{
+  va_list args;
+  int i;
+  
+  if (megaCfg->procidx > PROCBUFSIZE)
+     return 0;
+
+  va_start (args, fmt);
+  i = vsprintf ((megaCfg->procbuf + megaCfg->procidx), fmt, args);
+  va_end (args);
+  
+  megaCfg->procidx += i;
+  return i;
+}
+
+
+static int proc_read_config(char *page, char **start, off_t offset,
+				int count, int *eof, void *data) 
+{
+
+   mega_host_config *megaCfg = (mega_host_config *)data; 
+  
+   *start = page;
+
+   if (megaCfg->productInfo.ProductName[0] != 0)
+  	 proc_printf(megaCfg,"%s\n",megaCfg->productInfo.ProductName);
+	
+   proc_printf(megaCfg,"Controller Type: ");
+
+   if (megaCfg->flag & BOARD_QUARTZ)
+ 	proc_printf(megaCfg,"438/466/467/471/493\n");
+   else
+	proc_printf(megaCfg,"418/428/434\n");
+
+   if (megaCfg->flag & BOARD_40LD)
+       proc_printf(megaCfg,"Controller Supports 40 Logical Drives\n");
+
+   proc_printf(megaCfg,"Base = %08x, Irq = %d, ",megaCfg->base,
+						 megaCfg->host->irq);
+
+   proc_printf(megaCfg, "Logical Drives = %d, Channels = %d\n",
+			megaCfg->numldrv, megaCfg->productInfo.SCSIChanPresent);
+
+   proc_printf(megaCfg, "Version =%s:%s, DRAM = %dMb\n",
+			megaCfg->fwVer,megaCfg->biosVer, 
+			megaCfg->productInfo.DramSize);
+
+   proc_printf(megaCfg,"Controller Queue Depth = %d, Driver Queue Depth = %d\n",
+		megaCfg->productInfo.MaxConcCmds, megaCfg->max_cmds);   
+   COPY_BACK;
+   return count;
+}
+
+
+
+static int proc_read_stat(char *page, char **start, off_t offset,
+				int count, int *eof, void *data) 
+{
+   int i;
+   mega_host_config *megaCfg = (mega_host_config *)data; 
+
+   *start = page;
+
+   proc_printf(megaCfg,"Statistical Information for this controller\n");
+   proc_printf(megaCfg,"Interrupts Collected = %d\n", megaCfg->nInterrupts);
+
+   for (i = 0; i < megaCfg->numldrv; i++) {
+	proc_printf(megaCfg,"Logical Drive %d:\n", i);
+        proc_printf(megaCfg,"\tReads Issued = %10d, Writes Issued = %10d\n",
+			megaCfg->nReads[i], megaCfg->nWrites[i]);
+        
+        proc_printf(megaCfg,"\tSectors Read = %10d, Sectors Written = %10d\n\n",				megaCfg->nReadBlocks[i],
+				megaCfg->nWriteBlocks[i]);
+   }
+
+   COPY_BACK;
+   return count;
+}
+
+        
+
+static int proc_read_status(char *page, char **start, off_t offset,
+				int count, int *eof, void *data) 
+{
+ mega_host_config *megaCfg = (mega_host_config *)data;
+ *start = page;
+
+ proc_printf(megaCfg,"TBD\n");
+ COPY_BACK;
+ return count;
+}
+
+
+static int proc_read_mbox(char *page, char **start, off_t offset,
+				int count, int *eof, void *data) 
+{
+// int i;
+// char *dta = NULL;
+ mega_host_config *megaCfg = (mega_host_config *)data;
+ volatile mega_mailbox *mbox = megaCfg->mbox;
+
+ *start = page;
+
+ proc_printf(megaCfg,"Contents of Mail Box Structure\n");
+ proc_printf(megaCfg,"  Fw Command   = 0x%02x\n", mbox->cmd);
+ proc_printf(megaCfg,"  Cmd Sequence = 0x%02x\n", mbox->cmdid);
+ proc_printf(megaCfg,"  No of Sectors= %04d\n", mbox->numsectors);
+ proc_printf(megaCfg,"  LBA          = 0x%02x\n", mbox->lba);
+ proc_printf(megaCfg,"  DTA          = 0x%08x\n", mbox->xferaddr);
+ proc_printf(megaCfg,"  Logical Drive= 0x%02x\n", mbox->logdrv);
+ proc_printf(megaCfg,"  No of SG Elmt= 0x%02x\n", mbox->numsgelements);
+ proc_printf(megaCfg,"  Busy         = %01x\n", mbox->busy); 
+ proc_printf(megaCfg,"  Status       = 0x%02x\n", mbox->status);
+
+/* proc_printf(megaCfg, "Dump of MailBox\n");
+ for (i = 0; i < 16; i++)
+	proc_printf(megaCfg, "%02x ",*(mbox + i));
+
+proc_printf(megaCfg, "\n\nNumber of Status = %02d\n",mbox->numstatus);
+
+ for (i = 0; i < 46; i++) {
+	proc_printf(megaCfg,"%02d ",*(mbox + 16 + i));
+        if (i%16)
+		proc_printf(megaCfg,"\n");
+}
+
+if (!mbox->numsgelements) { 
+	dta = phys_to_virt(mbox->xferaddr);
+	for (i = 0; i < mbox->numsgelements; i++) 
+		if (dta) {
+			proc_printf(megaCfg,"Addr = %08x\n", (ulong)*(dta + i));			proc_printf(megaCfg,"Length = %08x\n", 
+				(ulong)*(dta + i + 4));
+		}
+}*/
+ COPY_BACK;
+ return count;
+}
+
+#define CREATE_READ_PROC(string, fxn) create_proc_read_entry(string, \
+					 S_IRUSR | S_IFREG,\
+					 controller_proc_dir_entry,\
+					 fxn, megaCfg)
+
+void mega_create_proc_entry(int index, struct proc_dir_entry *parent)
+{
+    u_char string[64] = {0};
+    mega_host_config *megaCfg = megaCtlrs[index];
+    struct proc_dir_entry *controller_proc_dir_entry = NULL;
+
+    sprintf(string,"%d", index);
+
+    controller_proc_dir_entry =
+    megaCfg->controller_proc_dir_entry =
+		proc_mkdir(string, parent);
+
+    if (!controller_proc_dir_entry)
+	printk("\nmegaraid: proc_mkdir failed\n");
+    else
+    {
+	megaCfg->proc_read = CREATE_READ_PROC("config", proc_read_config);
+	megaCfg->proc_status = CREATE_READ_PROC("status", proc_read_status);
+	megaCfg->proc_stat = CREATE_READ_PROC("stat", proc_read_stat);
+	megaCfg->proc_mbox = CREATE_READ_PROC("mailbox", proc_read_mbox);
+    }
+}
+#endif /* CONFIG_PROC_FS */
+
 
 /*-------------------------------------------------------------
  * Return the disk geometry for a particular disk
diff -ur linux-old/drivers/scsi/megaraid.h linux/drivers/scsi/megaraid.h
--- linux-old/drivers/scsi/megaraid.h	Wed Oct  4 01:46:17 2000
+++ linux/drivers/scsi/megaraid.h	Sat Nov 18 23:02:47 2000
@@ -1,10 +1,6 @@
 #ifndef __MEGARAID_H__
 #define __MEGARAID_H__
 
-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif
-
 #define IN_ISR                  0x80000000L
 #define IN_ABORT                0x40000000L
 #define IN_RESET                0x20000000L
@@ -12,7 +8,6 @@
 #define BOARD_QUARTZ            0x08000000L
 #define BOARD_40LD              0x04000000L
 
-#ifndef HOSTS_C
 #define SCB_FREE     0x0
 #define SCB_ACTIVE   0x1
 #define SCB_WAITQ    0x2
@@ -20,7 +15,11 @@
 #define SCB_COMPLETE 0x4
 #define SCB_ABORTED  0x5
 #define SCB_RESET    0x6
-#endif
+
+/* IOCTL DRIVER INFO */
+#define DRIVER_IOCTL_INTERFACE 0x82
+/* Methods */
+#define GET_DRIVER_INFO 1
 
 #define MEGA_CMD_TIMEOUT        10
 
@@ -96,13 +95,20 @@
 #define ENABLE_INTR(base)     WRITE_PORT(base,I_TOGGLE_PORT,ENABLE_INTR_BYTE)
 #define DISABLE_INTR(base)    WRITE_PORT(base,I_TOGGLE_PORT,DISABLE_INTR_BYTE)
 
+/* Special Adapter Commands */
+#define FW_FIRE_WRITE 	0x2C
+#define FW_FIRE_FLASH  	0x2D
+
 /* Define AMI's PCI codes */
 #undef PCI_VENDOR_ID_AMI
 #undef PCI_DEVICE_ID_AMI_MEGARAID
+#undef PCI_DEVICE_ID_AMI_MEGARAID2
 
 #ifndef PCI_VENDOR_ID_AMI
 #define PCI_VENDOR_ID_AMI          0x101E
 #define PCI_DEVICE_ID_AMI_MEGARAID 0x9010
+#define PCI_DEVICE_ID_AMI_MEGARAID2 0x9060
+#define PCI_DEVICE_ID_AMI_MEGARAID3 0x1960
 #endif
 
 #define PCI_CONF_BASE_ADDR_OFFSET  0x10
@@ -111,31 +117,6 @@
 #define AMI_SIGNATURE              0x3344
 #define AMI_SIGNATURE_471          0xCCCC
 
-#if LINUX_VERSION_CODE < 0x20100
-#define MEGARAID \
-  { NULL,                               /* Next                      */\
-    NULL,                               /* Usage Count Pointer       */\
-    NULL,                               /* /proc Directory Entry     */\
-    megaraid_proc_info,                 /* /proc Info Function       */\
-    "MegaRAID",                         /* Driver Name               */\
-    megaraid_detect,                    /* Detect Host Adapter       */\
-    megaraid_release,                   /* Release Host Adapter      */\
-    megaraid_info,                      /* Driver Info Function      */\
-    megaraid_command,                   /* Command Function          */\
-    megaraid_queue,                     /* Queue Command Function    */\
-    megaraid_abort,                     /* Abort Command Function    */\
-    megaraid_reset,                     /* Reset Command Function    */\
-    NULL,                               /* Slave Attach Function     */\
-    megaraid_biosparam,                 /* Disk BIOS Parameters      */\
-    MAX_COMMANDS,                       /* # of cmds that can be\
-                                           outstanding at any time */\
-    7,                                  /* HBA Target ID             */\
-    MAX_SGLIST,                         /* Scatter/Gather Table Size */\
-    MAX_CMD_PER_LUN,                    /* SCSI Commands per LUN     */\
-    0,                                  /* Present                   */\
-    0,                                  /* Default Unchecked ISA DMA */\
-    ENABLE_CLUSTERING }		/* Enable Clustering         */
-#else
 #define MEGARAID \
   {\
     name:            "MegaRAID",               /* Driver Name               */\
@@ -154,9 +135,8 @@
     cmd_per_lun:      MAX_CMD_PER_LUN,         /* SCSI Commands per LUN     */\
     present:          0,                       /* Present                   */\
     unchecked_isa_dma:0,                       /* Default Unchecked ISA DMA */\
-    use_clustering:   ENABLE_CLUSTERING        /* Enable Clustering         */\
+    use_clustering:   ENABLE_CLUSTERING       /* Enable Clustering         */\
   }
-#endif
 
 
 /***********************************************************************
@@ -528,8 +508,8 @@
     /* 0x10 */ u8 numstatus;
     /* 0x11 */ u8 status;
     /* 0x12 */ u8 completed[46];
-    u8 mraid_poll;
-    u8 mraid_ack;
+    volatile u8 mraid_poll;
+    volatile u8 mraid_ack;
     u8 pad[16]; /* for alignment purposes */
 }__attribute__((packed));
 typedef struct _mega_mailbox mega_mailbox;
@@ -574,9 +554,7 @@
     mega_passthru  pthru;
     Scsi_Cmnd     *SCpnt;
     mega_sglist   *sgList;
-    char          *kern_area;  /* Only used for large ioctl xfers */
     struct wait_queue  *ioctl_wait;
-    struct semaphore   sem;
     mega_scb      *next;
 };
 
@@ -584,7 +562,12 @@
 typedef struct _mega_host_config {
     u8 numldrv;
     u32 flag;
+
+#ifdef __LP64__
+    u64 base;
+#else
     u32 base;
+#endif
  
     mega_scb *qFreeH;
     mega_scb *qFreeT;
@@ -598,8 +581,10 @@
     u32 qCcnt;
 
     u32 nReads[FC_MAX_LOGICAL_DRIVES];
+    u32 nReadBlocks[FC_MAX_LOGICAL_DRIVES];
     u32 nWrites[FC_MAX_LOGICAL_DRIVES];
-
+    u32 nWriteBlocks[FC_MAX_LOGICAL_DRIVES];
+    u32 nInterrupts;
     /* Host adapter parameters */
     u8 fwVer[7];
     u8 biosVer[7];
@@ -622,8 +607,19 @@
 
     u8 max_cmds;
     mega_scb scbList[MAX_COMMANDS];
+#define PROCBUFSIZE 4096
+    char procbuf[PROCBUFSIZE];
+    int   procidx;
+    struct proc_dir_entry *controller_proc_dir_entry;
+    struct proc_dir_entry *proc_read, *proc_stat, *proc_status, *proc_mbox;
 } mega_host_config;
 
+typedef struct _driver_info {
+	int size;
+	ulong version;
+} mega_driver_info;
+
+
 const char *megaraid_info(struct Scsi_Host *);
 int megaraid_detect(Scsi_Host_Template *);
 int megaraid_release(struct Scsi_Host *);
@@ -635,4 +631,6 @@
 int megaraid_proc_info(char *buffer, char **start, off_t offset,
 		       int length, int hostno, int inout);
 
+void mega_build_user_sg(char *, ulong , mega_scb *, mega_ioctl_mbox *); 
+void mega_create_proc_entry(int index, struct proc_dir_entry *);
 #endif

--------------1D1340A2870F2A0A12361FFE--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
