Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbRBWO5i>; Fri, 23 Feb 2001 09:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129405AbRBWO53>; Fri, 23 Feb 2001 09:57:29 -0500
Received: from hq.alert.sk ([147.175.66.131]:3336 "HELO hq.alert.sk")
	by vger.kernel.org with SMTP id <S129272AbRBWO5R>;
	Fri, 23 Feb 2001 09:57:17 -0500
Date: Fri, 23 Feb 2001 15:57:13 +0100
From: Robert Varga <nite@hq.alert.sk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] megaraid port from 2.2.19pre14 to 2.4.2
Message-ID: <20010223155713.A11058@hq.alert.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

Attached is a patch to port of the megaraid driver from 2.2.19pre14 kernel
to 2.4.2. It seems to be stable, but I have only one (production) machine
for testing. The machine runs now about 4 hours with no glitches.

Alan: could you please integrate this one into your tree?
Anyone: could you confirm this works on something other than Elite 1600 ?


Kind regards,
Robert 'Nite' Varga

P.S. The patch doesn't contain full path... sorry about that

---------------------------------------------------------------------------=
---
n@hq.sk                                          http://hq.sk/~nite/gpgkey.=
txt
=20

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="final.diff"
Content-Transfer-Encoding: quoted-printable

--- megaraid.c	Tue Jan  9 19:40:43 2001
+++ megaraid.c	Fri Feb 23 15:46:40 2001
@@ -2,19 +2,19 @@
  *
  *                    Linux MegaRAID device driver
  *
- * Copyright 1999 American Megatrends Inc.
+ * Copyright 2000 American Megatrends Inc.
  *
  *              This program is free software; you can redistribute it and=
/or
  *              modify it under the terms of the GNU General Public License
  *              as published by the Free Software Foundation; either versi=
on
  *              2 of the License, or (at your option) any later version.
  *
- * Version : 1.07b
+ * Version : 1b08b
  *=20
  * Description: Linux device driver for AMI MegaRAID controller
  *
- * Supported controllers: MegaRAID 418, 428, 438, 466, 762, 467, 490
- *=20
+ * Supported controllers: MegaRAID 418, 428, 438, 466, 762, 467, 471, 490
+ * 						493.
  * History:
  *
  * Version 0.90:
@@ -119,15 +119,66 @@
  *    Fixed the problem of unnecessary aborts in the abort entry point, wh=
ich
  *      also enables the driver to handle large amount of I/O requests for
  *      long duration of time.
- *
+ * Version 1.06
+ *         Intel Release
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
+ * Version 1b08b
+ *    Change PCI ID value for the 471 card, use #defines when searching
+ *    for megaraid cards.
+ *
+ * Version 1.10
+ *
+ * I) Changes made to make following ioctl commands work in 0x81 interface
+ *     a)DCMD_DELETE_LOGDRV
+ *     b)DCMD_GET_DISK_CONFIG
+ *     c)DCMD_DELETE_DRIVEGROUP
+ *     d)NC_SUBOP_ENQUIRY3
+ *     e)DCMD_CHANGE_LDNO
+ *     f)DCMD_CHANGE_LOOPID
+ *     g)DCMD_FC_READ_NVRAM_CONFIG
+ *     h)DCMD_WRITE_CONFIG
+ *     II) Added mega_build_kernel_sg function
+ *  III)Firmware flashing option added
+ *
+ * Version 1.10a
+ *
+ * I)Dell updates included in the source code.
+ *         Note:   This change is not tested due to the unavailability of =
IA64 kernel
+ * and it is in the #ifdef DELL_MODIFICATION macro which is not defined
+ *
+ * Version 1.10b
+ *
+ * I)In IOCTL_CMD_NEW command the wrong way of copying the data
+ *    to the user address corrected
+ *
+ * Version 1.10c
+ *
+ * I) DCMD_GET_DISK_CONFIG opcode updated for the firmware changes.
+ *
+ * Version 1.11
+ * I)  Version number changed from 1.10c to 1.11
+ *  II)    DCMD_WRITE_CONFIG(0x0D) command in the driver changed from
+ *     scatter/gather list mode to direct pointer mode..
  *
  * BUGS:
  *     Some older 2.1 kernels (eg. 2.1.90) have a bug in pci.c that
@@ -143,23 +194,26 @@
 #define CRLFSTR "\n"
 #define IOCTL_CMD_NEW  0x81
=20
-#define MEGARAID_VERSION "v107 (December 22, 1999)"
-
+#define MEGARAID_VERSION "v1.11 (Aug 23, 2000)"
+#define MEGARAID_IOCTL_VERSION 108
=20
 #include <linux/version.h>
=20
 #ifdef MODULE
 #include <linux/module.h>
=20
+#if LINUX_VERSION_CODE >=3D 0x20100
 char kernel_version[] =3D UTS_RELEASE;
=20
 MODULE_AUTHOR ("American Megatrends Inc.");
 MODULE_DESCRIPTION ("AMI MegaRAID driver");
 #endif
+#endif
=20
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
@@ -170,9 +224,19 @@
 #include <linux/wait.h>
 #include <linux/tqueue.h>
 #include <linux/interrupt.h>
+#include <linux/mm.h>
+#include <asm/pgtable.h>
=20
 #include <linux/stat.h>
-#include <linux/spinlock.h>
+#if LINUX_VERSION_CODE < 0x20100
+#include <linux/bios32.h>
+#else
+#if LINUX_VERSION_CODE < 0x20300
+# include <asm/spinlock.h>
+#else
+# include <linux/spinlock.h>
+#endif
+#endif
=20
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -193,26 +257,48 @@
  *=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  */
=20
+#if LINUX_VERSION_CODE < 0x020100
+#define ioremap vremap
+#define iounmap vfree
+
+/* simulate spin locks */
+typedef struct {
+		volatile char lock;
+} spinlock_t;
+
+#define spin_lock_init(x) { (x)->lock =3D 0;}
+#define spin_lock_irqsave(x,flags) { while ((x)->lock) barrier();\
+										(x)->lock=3D1; save_flags(flags);\
+										cli();}
+#define spin_unlock_irqrestore(x,flags) { (x)->lock=3D0; restore_flags(fla=
gs);}
+
+#endif
+
+#if LINUX_VERSION_CODE >=3D 0x020100
+#define queue_task_irq(a,b)     queue_task(a,b)
+#define queue_task_irq_off(a,b) queue_task(a,b)
+#endif
+
 #define MAX_SERBUF 160
 #define COM_BASE 0x2f8
=20
=20
-u32 RDINDOOR (mega_host_config * megaCfg)
+ulong RDINDOOR (mega_host_config * megaCfg)
 {
   return readl (megaCfg->base + 0x20);
 }
=20
-void WRINDOOR (mega_host_config * megaCfg, u32 value)
+void WRINDOOR (mega_host_config * megaCfg, ulong value)
 {
   writel (value, megaCfg->base + 0x20);
 }
=20
-u32 RDOUTDOOR (mega_host_config * megaCfg)
+ulong RDOUTDOOR (mega_host_config * megaCfg)
 {
   return readl (megaCfg->base + 0x2C);
 }
=20
-void WROUTDOOR (mega_host_config * megaCfg, u32 value)
+void WROUTDOOR (mega_host_config * megaCfg, ulong value)
 {
   writel (value, megaCfg->base + 0x2C);
 }
@@ -264,6 +350,19 @@
 static int ser_printk (const char *fmt,...);
 #endif
=20
+#ifdef CONFIG_PROC_FS
+#define COPY_BACK if (offset > megaCfg->procidx) { \
+        *eof =3D TRUE; \
+        megaCfg->procidx =3D 0; \
+        megaCfg->procbuf[0] =3D 0; \
+   return 0;} \
+  if ((count + offset) > megaCfg->procidx) { \
+      count =3D megaCfg->procidx - offset; \
+      *eof =3D TRUE; } \
+      memcpy(page, &megaCfg->procbuf[offset], count); \
+      megaCfg->procidx =3D 0; \
+      megaCfg->procbuf[0] =3D 0;
+#endif
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  *
  *                    Global variables
@@ -274,14 +373,20 @@
 /*  Use "megaraid=3DskipXX" as LILO option to prohibit driver from scanning
     XX scsi id on each channel.  Used for Madrona motherboard, where SAF_TE
     processor id cannot be scanned */
-#ifdef MODULE
+
+
+
 static char *megaraid =3D NULL;
+#if LINUX_VERSION_CODE > 0x20100
+#ifdef MODULE
 MODULE_PARM(megaraid, "s");
 #endif
+#endif
 static int skip_id;
=20
 static int numCtlrs =3D 0;
 static mega_host_config *megaCtlrs[FC_MAX_CHANNELS] =3D {0};
+struct proc_dir_entry *mega_proc_dir_entry;
=20
 #if DEBUG
 static u32 maxCmdTime =3D 0;
@@ -294,6 +399,21 @@
 static spinlock_t serial_lock =3D SPIN_LOCK_UNLOCKED;
 #endif
=20
+
+#if LINUX_VERSION_CODE < 0x20300
+struct proc_dir_entry proc_scsi_megaraid =3D
+{
+		PROC_SCSI_MEGARAID, 8, "megaraid",
+		S_IFDIR | S_IRUGO | S_IXUGO, 2
+};
+#else
+struct proc_dir_entry *proc_scsi_megaraid;
+#endif
+
+#ifdef CONFIG_PROC_FS
+extern struct proc_dir_entry proc_root;
+#endif
+
 #if SERDEBUG
 static char strbuf[MAX_SERBUF + 1];
=20
@@ -480,7 +600,7 @@
   return 0;
 }
=20
-/* Run through the list of completed requests */
+/* Run through the list of completed requests  and finish it*/
 static void mega_rundoneq (mega_host_config *megaCfg)
 {
   Scsi_Cmnd *SCpnt;
@@ -523,6 +643,8 @@
   mega_passthru *pthru;
   mega_mailbox *mbox;
=20
+
+
   if (pScb =3D=3D NULL) {
 	TRACE(("NULL pScb in mega_cmd_done!"));
 	printk("NULL pScb in mega_cmd_done!");
@@ -554,6 +676,7 @@
=20
 if ((SCpnt->cmnd[0] & 0x80) ) {/* i.e. ioctl cmd such as 0x80, 0x81 of meg=
amgr*/
     switch (status) {
+	  case 2:
       case 0xF0:
       case 0xF4:
 	SCpnt->result=3D(DID_BAD_TARGET<<16)|status;
@@ -588,12 +711,7 @@
     break;
   }
  }
-  if ( SCpnt->cmnd[0]!=3DIOCTL_CMD_NEW )=20
-  /* not IOCTL_CMD_NEW SCB, freeSCB()*/
-  /* For IOCTL_CMD_NEW SCB, delay freeSCB() in megaraid_queue()
-   * after copy data back to user space*/
      mega_freeSCB(megaCfg, pScb);
-
   /* Add Scsi_Command to end of completed queue */
     if( megaCfg->qCompletedH =3D=3D NULL ) {
       megaCfg->qCompletedH =3D megaCfg->qCompletedT =3D SCpnt;
@@ -624,8 +742,8 @@
   char islogical;
   char lun =3D SCpnt->lun;
=20
-  if ((SCpnt->cmnd[0] =3D=3D 0x80)  || (SCpnt->cmnd[0] =3D=3D IOCTL_CMD_NE=
W) )  /* ioctl */
-    return mega_ioctl (megaCfg, SCpnt);
+  if ((SCpnt->cmnd[0] =3D=3D 0x80)  || (SCpnt->cmnd[0] =3D=3D IOCTL_CMD_NE=
W) )
+    return mega_ioctl (megaCfg, SCpnt); /* Handle IOCTL command */
 =20
   islogical =3D (SCpnt->channel =3D=3D megaCfg->host->max_channel);
=20
@@ -641,7 +759,7 @@
 	return NULL;
   }
=20
-  if ( islogical ) {
+  if (islogical) {
 	lun =3D (SCpnt->target * 8) + lun;
         if ( lun > FC_MAX_LOGICAL_DRIVES ){
             SCpnt->result =3D (DID_BAD_TARGET << 16);
@@ -723,6 +841,15 @@
 	  ((u32) SCpnt->cmnd[2] << 8) |
 	  (u32) SCpnt->cmnd[3];
 	mbox->lba &=3D 0x1FFFFF;
+
+        if (*SCpnt->cmnd =3D=3D READ_6) {
+       			megaCfg->nReads[(int)lun]++;
+		        megaCfg->nReadBlocks[(int)lun] +=3D mbox->numsectors;
+		}
+		else {
+				megaCfg->nWrites[(int)lun]++;
+				megaCfg->nWriteBlocks[(int)lun] +=3D mbox->numsectors;
+		}
       }
=20
       /* 10-byte */
@@ -735,6 +862,15 @@
 	  ((u32) SCpnt->cmnd[3] << 16) |
 	  ((u32) SCpnt->cmnd[4] << 8) |
 	  (u32) SCpnt->cmnd[5];
+
+	if (*SCpnt->cmnd =3D=3D READ_10) {
+			megaCfg->nReads[(int)lun]++;
+			megaCfg->nReadBlocks[(int)lun] +=3D mbox->numsectors;
+		}
+		else {
+				megaCfg->nWrites[(int)lun]++;
+				megaCfg->nWriteBlocks[(int)lun] +=3D mbox->numsectors;
+		}
       }
=20
       /* Calculate Scatter-Gather info */
@@ -791,6 +927,42 @@
   return NULL;
 }
=20
+/* Handle Driver Level IOCTLs
+ * Return value of 0 indicates this function could not handle , so continue
+ * processing
+*/
+
+static int mega_driver_ioctl (mega_host_config * megaCfg, Scsi_Cmnd * SCpn=
t)
+{
+  unsigned char *data =3D (unsigned char *)SCpnt->request_buffer;
+  mega_driver_info driver_info;
+
+  /* If this is not our command dont do anything */
+  if (SCpnt->cmnd[0] !=3D DRIVER_IOCTL_INTERFACE)
+   return 0;
+
+  switch(SCpnt->cmnd[1]) {
+  case GET_DRIVER_INFO:
+                if (SCpnt->request_bufflen < sizeof(driver_info)) {
+           SCpnt->result =3D DID_BAD_TARGET << 16 ;
+           callDone(SCpnt);
+           return 1;
+       }
+
+       driver_info.size =3D sizeof(driver_info) - sizeof(int);
+       driver_info.version =3D MEGARAID_IOCTL_VERSION;
+       memcpy( data, &driver_info, sizeof(driver_info));
+       break;
+   default:
+       SCpnt->result =3D DID_BAD_TARGET << 16;
+  }
+
+ callDone(SCpnt);
+ return 1;
+}
+
+
+					=09
 /*--------------------------------------------------------------------
  * build RAID commands for controller, passed down through ioctl()
  *--------------------------------------------------------------------*/
@@ -801,9 +973,9 @@
   mega_mailbox *mailbox;
   mega_passthru *pthru;
   u8 *mboxdata;
-  long seg;
+  long seg, i;
   unsigned char *data =3D (unsigned char *)SCpnt->request_buffer;
-  int i;
+
=20
   if ((pScb =3D mega_allocateSCB (megaCfg, SCpnt)) =3D=3D NULL) {
     SCpnt->result =3D (DID_ERROR << 16);
@@ -837,8 +1009,8 @@
 					 (u32 *) & pthru->dataxferaddr,
 					 (u32 *) & pthru->dataxferlen);
=20
-    for (i=3D0;i<(SCpnt->request_bufflen-cdblen-7);i++) {
-       data[i] =3D data[i+cdblen+7];
+    for (i =3D 0 ; i < (SCpnt->request_bufflen - cdblen - 7) ; i++) {
+       data[i] =3D data[i + cdblen + 7];
     }
=20
     return pScb;
@@ -859,24 +1031,56 @@
       *   cmnd[4..7] =3D external user buffer     *
       *   cmnd[8..11] =3D length of buffer        *
       *                                         */
-      char *kern_area;
       char *user_area =3D *((char **)&SCpnt->cmnd[4]);
       u32 xfer_size =3D *((u32 *)&SCpnt->cmnd[8]);
-      if (verify_area(VERIFY_READ, user_area, xfer_size)) {
-          printk("megaraid: Got bad user address.\n");
+	  switch (data[0])
+	  {
+       case FW_FIRE_WRITE:
+       case FW_FIRE_FLASH:
+        if ((ulong)user_area & (PAGE_SIZE - 1)) {
+          printk("megaraid:user address not aligned on 4K boundary.Error.\=
n");
           SCpnt->result =3D (DID_ERROR << 16);
           callDone (SCpnt);
           return NULL;
       }
-      kern_area =3D kmalloc(xfer_size, GFP_ATOMIC | GFP_DMA);
-      if (kern_area =3D=3D NULL) {
-          printk("megaraid: Couldn't allocate kernel mem.\n");
+        break;
+       default:
+        break;
+     }
+      if(!(pScb->buff_ptr =3D kmalloc(xfer_size, GFP_KERNEL))) {
+          printk("megaraid: Insufficient mem for IOCTL_CMD_NEW.\n");
 	  SCpnt->result =3D (DID_ERROR << 16);
 	  callDone (SCpnt);
 	  return NULL;
       }
-      copy_from_user(kern_area,user_area,xfer_size);
-      pScb->kern_area =3D kern_area;
+ =20
+      copy_from_user(pScb->buff_ptr,user_area,xfer_size);
+      pScb->sgList[0].address =3D virt_to_bus(pScb->buff_ptr);
+      pScb->sgList[0].length =3D xfer_size;
+	  pScb->iDataSize =3D xfer_size;
+      mbox->xferaddr =3D virt_to_bus(pScb->sgList);
+      mbox->numsgelements =3D 1;
+
+    switch (data[0]) {
+	case DCMD_FC_CMD:
+		switch (data[1]) {
+		case DCMD_FC_READ_NVRAM_CONFIG:
+		case DCMD_GET_DISK_CONFIG:
+			if ((ulong) pScb->buff_ptr & (PAGE_SIZE - 1)) {
+				printk("megaraid:user address not sufficient Error.\n");
+				SCpnt->result =3D (DID_ERROR << 16);
+				callDone (SCpnt);
+				return NULL;
+			}
+			//building SG list
+			mega_build_kernel_sg(pScb->buff_ptr, xfer_size, pScb, mbox);
+			break;
+		default:
+			break;
+		}//switch (data[1])
+		break;
+	}
+
   }
 #endif
=20
@@ -887,16 +1091,58 @@
   mbox->logdrv =3D data[4];
=20
   if(SCpnt->cmnd[0] =3D=3D IOCTL_CMD_NEW) {
-      if(data[0]=3D=3DDCMD_FC_CMD){ /*i.e. 0xA1, then override some mbox d=
ata */
+		 switch (data[0]) {
+				 case FW_FIRE_WRITE:
+						 mbox->cmd =3D FW_FIRE_WRITE;
+						 mbox->channel =3D data[1]; /* Current Block Number */
+						 mbox->xferaddr =3D virt_to_bus(pScb->buff_ptr);
+						 mbox->numsgelements =3D 0;
+						 break;
+				 case FW_FIRE_FLASH:
+						 mbox->cmd =3D FW_FIRE_FLASH;
+						 mbox->channel =3D data[1] | 0x80 ; /* Origin */
+						 mbox->xferaddr =3D virt_to_bus(pScb->buff_ptr);
+						 mbox->numsgelements =3D 0;
+						 break;
+				 case DCMD_FC_CMD:
           *(mboxdata+0) =3D data[0]; /*mailbox byte 0: DCMD_FC_CMD*/
-          *(mboxdata+2) =3D data[2]; /*sub command*/
-          *(mboxdata+3) =3D 0;       /*number of elements in SG list*/
-          mbox->xferaddr           /*i.e. mboxdata byte 0x8 to 0xb*/
-                        =3D virt_to_bus(pScb->kern_area);
-      }
-      else{
-         mbox->xferaddr =3D virt_to_bus(pScb->kern_area);
+		  *(mboxdata+2) =3D data[1]; /*sub command*/
+		  switch (data[1]) {
+				  case DCMD_FC_READ_NVRAM_CONFIG:
+						  *(mboxdata+3) =3D mbox->numsgelements;       /*number of elements =
in SG list*/
+						  break;
+				  case DCMD_WRITE_CONFIG:
+						  mbox->xferaddr =3D virt_to_bus(pScb->buff_ptr);
+						  mbox->numsgelements =3D 0;
+						  break;
+				  case DCMD_GET_DISK_CONFIG:
+						  *(mboxdata+3) =3D data[2];       /*number of elements in SG list*/
+						  *(mboxdata+4) =3D mbox->numsgelements;       /*number of elements =
in SG list*/
+						  break;
+				  case DCMD_DELETE_LOGDRV:
+				  case DCMD_DELETE_DRIVEGROUP:
+				  case NC_SUBOP_ENQUIRY3:
+						  *(mboxdata+3) =3D data[2];
+						  mbox->xferaddr =3D virt_to_bus(pScb->buff_ptr);
+						  mbox->numsgelements =3D 0;
+						  break;
+				  case DCMD_CHANGE_LDNO:
+				  case DCMD_CHANGE_LOOPID:
+						  *(mboxdata+3) =3D data[2];
+						  *(mboxdata+4) =3D data[3];
+						  mbox->xferaddr =3D virt_to_bus(pScb->buff_ptr);
          mbox->numsgelements =3D 0;
+						  break;
+				  default:
+						  mbox->xferaddr =3D virt_to_bus(pScb->buff_ptr);
+						  mbox->numsgelements =3D 0;
+						  break;
+		  }//switch
+		  break;
+				 default:
+		  mbox->xferaddr =3D virt_to_bus(pScb->buff_ptr);
+		  mbox->numsgelements =3D 0;
+		  break;
       }
   }=20
   else {
@@ -913,6 +1159,37 @@
   return (pScb);
 }
=20
+void mega_build_kernel_sg(char *barea, ulong xfersize, mega_scb *pScb,
+				mega_ioctl_mbox *mbox)
+{
+		ulong i, buffer_area, len, end, end_page, x, idx =3D 0;
+
+		buffer_area =3D (ulong)barea;
+		i =3D buffer_area;
+		end =3D buffer_area + xfersize;
+		end_page =3D (end) & ~(PAGE_SIZE - 1);
+
+		do {
+				len =3D  PAGE_SIZE - (i % PAGE_SIZE);
+				x =3D pScb->sgList[idx].address =3D virt_to_bus((volatile void *)i);
+				pScb->sgList[idx].length =3D len;
+				i +=3D len;
+				idx++;
+		} while (i < end_page);
+
+		if ((end - i)< 0) {
+				printk("megaraid:Error in user address\n");
+		}
+	=09
+		if (end - i) {
+				pScb->sgList[idx].address =3D virt_to_bus((volatile void *)i);
+				pScb->sgList[idx].length =3D end - i;
+				idx++;
+		}
+		mbox->xferaddr =3D virt_to_bus(pScb->sgList);
+		mbox->numsgelements =3D idx;
+}
+
 #if DEBUG
 static void showMbox(mega_scb *pScb)
 {
@@ -955,6 +1232,7 @@
   mbox =3D (mega_mailbox *)tmpBox;
=20
   if (megaCfg->host->irq =3D=3D irq) {
+
     if (megaCfg->flag & IN_ISR) {
       printk(KERN_ERR "ISR called reentrantly!!\n");
     }
@@ -986,8 +1264,10 @@
=20
     for(idx=3D0;idx<MAX_FIRMWARE_STATUS;idx++ ) completed[idx] =3D 0;
=20
+#if LINUX_VERSION_CODE >=3D 0x20100
     IO_LOCK;
-
+#endif
+	megaCfg->nInterrupts++;
     qCnt =3D 0xff;
     while ((qCnt =3D megaCfg->mbox->numstatus) =3D=3D 0xFF)=20
       ;
@@ -1057,13 +1337,18 @@
           continue;
 	}
=20
-        if (*(pScb->SCpnt->cmnd)=3D=3DIOCTL_CMD_NEW)=20
-        {    /* external user buffer */
-           up(&pScb->sem);
-        }
+	/* We don't want the ISR routine to touch IOCTL_CMD_NEW commands, so
+	 * don't mark them as complete, instead we pop their semaphore so
+	 * that the queue routine can finish them off
+	 */
+	if(pScb->SCpnt->cmnd[0] =3D=3D IOCTL_CMD_NEW) {
+			/* save the status byte for the queue routine to use */
+			pScb->SCpnt->result =3D qStatus;
+			up(&pScb->ioctl_sem);
+	} else {
 	/* Mark command as completed */
 	mega_cmd_done(megaCfg, pScb, qStatus);
-
+	}
       }
       else {
         printk(KERN_ERR "megaraid: wrong cmd id completed from firmware:id=
=3D%x\n",sIdx);
@@ -1073,7 +1358,6 @@
     mega_rundoneq(megaCfg);
=20
     megaCfg->flag &=3D ~IN_ISR;
-
     /* Loop through any pending requests */
     mega_runpendq(megaCfg);
 #if LINUX_VERSION_CODE >=3D 0x20100
@@ -1081,6 +1365,7 @@
 #endif
=20
   }
+
 }
=20
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D*/
@@ -1121,19 +1406,23 @@
 	      mega_scb * pScb,
 	      int intr)
 {
-  mega_mailbox *mbox =3D (mega_mailbox *) megaCfg->mbox;
+  volatile mega_mailbox *mbox =3D (mega_mailbox *) megaCfg->mbox;
   u_char byte;
-  u32 cmdDone;
+
+#ifdef __LP64__
+  u64 phys_mbox;
+#else
   u32 phys_mbox;
+#endif
   u8 retval=3D-1;
=20
-  mboxData[0x1] =3D (pScb ? pScb->idx + 1: 0x0);   /* Set cmdid */
+  mboxData[0x1] =3D (pScb ? pScb->idx + 1: 0xFE);   /* Set cmdid */
   mboxData[0xF] =3D 1;		/* Set busy */
=20
   phys_mbox =3D virt_to_bus (megaCfg->mbox);
=20
 #if DEBUG
-  showMbox(pScb);
+  ShowMbox(pScb);
 #endif
=20
   /* Wait until mailbox is free */
@@ -1158,7 +1447,7 @@
=20
   /* Copy mailbox data into host structure */
   megaCfg->mbox64->xferSegment =3D 0;
-  memcpy (mbox, mboxData, 16);
+  memcpy ((char *)mbox, mboxData, 16);
=20
   /* Kick IO */
   if (intr) {
@@ -1182,10 +1471,18 @@
     if (megaCfg->flag & BOARD_QUARTZ) {
       mbox->mraid_poll =3D 0;
       mbox->mraid_ack =3D 0;
+	  mbox->numstatus =3D 0xFF;
+	  mbox->status =3D 0xFF;
       WRINDOOR (megaCfg, phys_mbox | 0x1);
=20
-      while ((cmdDone =3D RDOUTDOOR (megaCfg)) !=3D 0x10001234);
-      WROUTDOOR (megaCfg, cmdDone);
+	  while (mbox->numstatus =3D=3D 0xFF);
+	  while (mbox->status =3D=3D 0xFF);
+	  while (mbox->mraid_poll !=3D 0x77);
+	  mbox->mraid_poll =3D 0;
+	  mbox->mraid_ack =3D 0x77;
+
+	  /* while ((cmdDone =3D RDOUTDOOR (megaCfg)) !=3D 0x10001234);
+	     WROUTDOOR (megaCfg, cmdDone);*/
=20
       if (pScb) {
 	mega_cmd_done (megaCfg, pScb, mbox->status);
@@ -1282,9 +1579,15 @@
 {
   /* align on 16-byte boundry */
   megaCfg->mbox =3D &megaCfg->mailbox64.mailbox;
-  megaCfg->mbox =3D (mega_mailbox *) ((((u32) megaCfg->mbox) + 16) & 0xfff=
ffff0);
+#ifdef __LP64__
+  megaCfg->mbox =3D (mega_mailbox *) ((((u64) megaCfg->mbox) + 16) & ( (ul=
ong)(-1) ^ 0x0F)  );
+  megaCfg->mbox64 =3D (mega_mailbox64 *) (megaCfg->mbox - 4);
+  paddr =3D (paddr + 4 + 16) & ( (u64)(-1) ^ 0x0F );
+#else
+  megaCfg->mbox =3D (mega_mailbox *) ((((u32) megaCfg->mbox) + 16) & 0xFFF=
FFFF0);
   megaCfg->mbox64 =3D (mega_mailbox64 *) (megaCfg->mbox - 4);
-  paddr =3D (paddr + 4 + 16) & 0xfffffff0;
+  paddr =3D (paddr + 4 + 16) & 0xFFFFFFF0;
+#endif
=20
   /* Register mailbox area with the firmware */
   if (!(megaCfg->flag & BOARD_QUARTZ)) {
@@ -1430,10 +1733,10 @@
 	   megaCfg->productInfo.BiosVer[2] >> 8,
 	   megaCfg->productInfo.BiosVer[2] & 0x0f);
 #else
-	memcpy (megaCfg->fwVer, (void *)megaCfg->productInfo.FwVer, 4);
+	memcpy (megaCfg->fwVer, (char *)megaCfg->productInfo.FwVer, 4);
 	megaCfg->fwVer[4] =3D 0;
=20
-	memcpy (megaCfg->biosVer, (void *)megaCfg->productInfo.BiosVer, 4);
+	memcpy (megaCfg->biosVer, (char *)megaCfg->productInfo.BiosVer, 4);
 	megaCfg->biosVer[4] =3D 0;
 #endif
=20
@@ -1458,6 +1761,7 @@
 		    int length, int host_no, int inout)
 {
   *start =3D buffer;
+
   return 0;
 }
=20
@@ -1465,32 +1769,106 @@
 	  u16 pciVendor, u16 pciDev,
 	  long flag)
 {
-  mega_host_config *megaCfg;
-  struct Scsi_Host *host;
-  u_char megaIrq;
+  mega_host_config *megaCfg =3D NULL;
+  struct Scsi_Host *host =3D NULL;
+  u_char pciBus, pciDevFun, megaIrq;
+
+#ifdef __LP64__
+  u64 megaBase;
+#else
   u32 megaBase;
+#endif
+
+  u16 pciIdx =3D 0;
   u16 numFound =3D 0;
=20
+#if LINUX_VERSION_CODE < 0x20100
+  while (!pcibios_find_device (pciVendor, pciDev, pciIdx, &pciBus, &pciDev=
Fun)) {
+#else
+#if LINUX_VERSION_CODE > 0x20300
   struct pci_dev *pdev =3D NULL;
+#else
+  struct pci_dev *pdev =3D pci_devices;
+#endif
+  skip_id =3D -1;
+  if (megaraid && !strncmp(megaraid,"skip",strlen("skip"))) {
+      if (megaraid[4] !=3D '\0') {
+          skip_id =3D megaraid[4] - '0';
+          if (megaraid[5] !=3D '\0') {
+              skip_id =3D (skip_id * 10) + (megaraid[5] - '0');
+          }
+      }
+      skip_id =3D (skip_id > 15) ? -1 : skip_id;
+  }
  =20
   while ((pdev =3D pci_find_device (pciVendor, pciDev, pdev))) {
+
+#ifdef DELL_MODIFICATION
     if (pci_enable_device(pdev))
     	continue;
+#endif
+	pciBus =3D pdev->bus->number;
+	pciDevFun =3D pdev->devfn;
+#endif
     if ((flag & BOARD_QUARTZ) && (skip_id =3D=3D -1)) {
       u16 magic;
-      pci_read_config_word(pdev, PCI_CONF_AMISIG, &magic);
-      if ((magic !=3D AMI_SIGNATURE) && (magic !=3D AMI_SIGNATURE_471))
+		pcibios_read_config_word (pciBus, pciDevFun,
+				PCI_CONF_AMISIG,
+				&magic);
+		if ((magic !=3D AMI_SIGNATURE) && (magic !=3D AMI_SIGNATURE_471) ){
+			pciIdx++;
 	continue;		/* not an AMI board */
     }
-    printk (KERN_INFO "megaraid: found 0x%4.04x:0x%4.04x: in %s\n",
+	}
+
+/* Hmmm...Should we not make this more modularized so that in future we do=
nt add
+   for each firmware */
+=09
+	if (flag & BOARD_QUARTZ) {
+			/* Check to see if this is a Dell PERC RAID controller model 466 */
+			u16 subsysid, subsysvid;
+#if LINUX_VERSION_CODE < 0x20100
+			pcibios_read_config_word (pciBus, pciDevFun,
+							PCI_SUBSYSTEM_VENDOR_ID,
+							&subsysvid);
+			pcibios_read_config_word (pciBus, pciDevFun,
+							PCI_SUBSYSTEM_ID,
+							&subsysid);
+#else
+			pci_read_config_word (pdev,
+							PCI_SUBSYSTEM_VENDOR_ID,
+							&subsysvid);
+			pci_read_config_word (pdev,
+							PCI_SUBSYSTEM_ID,
+							&subsysid);
+#endif
+			if ( (subsysid =3D=3D 0x1111) && (subsysvid =3D=3D 0x1111) &&
+							(!strcmp(megaCfg->fwVer,"3.00") ||                      !strcmp(meg=
aCfg->fwVer,"3.01"))) {
+					printk(KERN_WARNING
+									"megaraid: Your card is a Dell PERC 2/SC RAID controller with fir=
mware\n"
+									"megaraid: 3.00 or 3.01.  This driver is known to have corruption=
 issues\n"
+									"megaraid: with those firmware versions on this specific card.  I=
n order\n"
+									"megaraid: to protect your data, please upgrade your firmware to =
version\n"
+									"megaraid: 3.10 or later, available from the Dell Technical Suppo=
rt web\n"
+									"megaraid: site at\n"
+									"http://support.dell.com/us/en/filelib/download/index.asp?fileid=
=3D2940\n");
+							continue;
+			}
+	}
+
+	printk (KERN_INFO "megaraid: found 0x%4.04x:0x%4.04x:idx %d:bus %d:slot %=
d:func %d\n",
 	    pciVendor,
 	    pciDev,
-	    pdev->slot_name);
+		pciIdx, pciBus,
+		PCI_SLOT (pciDevFun),
+		PCI_FUNC (pciDevFun));
=20
     /* Read the base port and IRQ from PCI */
     megaBase =3D pci_resource_start (pdev, 0);
     megaIrq  =3D pdev->irq;
=20
+	pciIdx++;
+=09
     if (flag & BOARD_QUARTZ)
       megaBase =3D (long) ioremap (megaBase, 128);
     else
@@ -1524,6 +1902,7 @@
     megaCfg->host->n_io_port =3D 16;
     megaCfg->host->unique_id =3D (pdev->bus->number << 8) | pdev->devfn;
     megaCtlrs[numCtlrs++] =3D megaCfg;=20
+
     if (flag !=3D BOARD_QUARTZ) {
       /* Request our IO Range */
       if (request_region (megaBase, 16, "megaraid")) {
@@ -1545,42 +1924,9 @@
     mega_register_mailbox (megaCfg, virt_to_bus ((void *) &megaCfg->mailbo=
x64));
     mega_i_query_adapter (megaCfg);
   =20
-    if (flag =3D=3D BOARD_QUARTZ) {
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
-      if ( (subsysid =3D=3D 0x1111) && (subsysvid =3D=3D 0x1111) &&
-           (!strcmp(megaCfg->fwVer,"3.00") || !strcmp(megaCfg->fwVer,"3.01=
"))) {
-	printk(KERN_WARNING
-"megaraid: Your card is a Dell PERC 2/SC RAID controller with firmware\n"
-"megaraid: 3.00 or 3.01.  This driver is known to have corruption issues\n"
-"megaraid: with those firmware versions on this specific card.  In order\n"
-"megaraid: to protect your data, please upgrade your firmware to version\n"
-"megaraid: 3.10 or later, available from the Dell Technical Support web\n"
-"megaraid: site at\n"
-"http://support.dell.com/us/en/filelib/download/index.asp?fileid=3D2940\n"=
);
-	megaraid_release (host);
-#ifdef MODULE=09
-	continue;
-#else
-	while(1) schedule_timeout(1 * HZ);
-#endif=09
-      }
-    }
-
     /* Initialize SCBs */
     if (mega_initSCB (megaCfg)) {
-      megaraid_release (host);
+      scsi_unregister (host);
       continue;
     }
=20
@@ -1594,20 +1940,53 @@
  *---------------------------------------------------------*/
 int megaraid_detect (Scsi_Host_Template * pHostTmpl)
 {
-  int count =3D 0;
+  int ctlridx =3D 0, count =3D 0;
=20
 #ifdef MODULE
   if (megaraid)
       megaraid_setup(megaraid);
 #endif
=20
+#if LINUX_VERSION_CODE < 0x20300
+  pHostTmpl->proc_dir =3D &proc_scsi_megaraid;
+#else
   pHostTmpl->proc_name =3D "megaraid";
+#endif
+
+#if LINUX_VERSION_CODE < 0x20100
+  if (!pcibios_present ()) {
+		  printk (KERN_WARNING "megaraid: PCI bios not present." CRLFSTR);
+		  return 0;
+  }
+#endif
=20
   printk ("megaraid: " MEGARAID_VERSION CRLFSTR);
=20
-  count +=3D mega_findCard (pHostTmpl, 0x101E, 0x9010, 0);
-  count +=3D mega_findCard (pHostTmpl, 0x101E, 0x9060, 0);
-  count +=3D mega_findCard (pHostTmpl, 0x8086, 0x1960, BOARD_QUARTZ);
+  count +=3D mega_findCard (pHostTmpl, PCI_VENDOR_ID_AMI,
+				  PCI_DEVICE_ID_AMI_MEGARAID, 0);
+  count +=3D mega_findCard (pHostTmpl, PCI_VENDOR_ID_AMI,
+				  PCI_DEVICE_ID_AMI_MEGARAID2, 0);
+  count +=3D mega_findCard (pHostTmpl, 0x8086,
+				  PCI_DEVICE_ID_AMI_MEGARAID3, BOARD_QUARTZ);
+  count +=3D mega_findCard (pHostTmpl, PCI_VENDOR_ID_AMI,
+				  PCI_DEVICE_ID_AMI_MEGARAID3, BOARD_QUARTZ);
+
+#ifdef CONFIG_PROC_FS
+  if (count) {
+#if LINUX_VERSION_CODE > 0x20300
+		  mega_proc_dir_entry =3D proc_mkdir("megaraid", &proc_root);
+#else
+		  mega_proc_dir_entry =3D create_proc_entry("megaraid",
+						  S_IFDIR | S_IRUGO | S_IXUGO,
+						  &proc_root);
+#endif
+		  if (!mega_proc_dir_entry)
+				  printk("megaraid: failed to create megaraid root\n");
+		  else
+				  for (ctlridx =3D 0; ctlridx < count ; ctlridx++)
+						  mega_create_proc_entry(ctlridx, mega_proc_dir_entry);
+  }
+#endif
=20
   return count;
 }
@@ -1620,6 +1999,7 @@
   mega_host_config *megaCfg;
   mega_mailbox *mbox;
   u_char mboxData[16];
+  int i;
=20
   megaCfg =3D (mega_host_config *) pSHost->hostdata;
   mbox =3D (mega_mailbox *) mboxData;
@@ -1645,6 +2025,22 @@
   mega_freeSgList(megaCfg);
   scsi_unregister (pSHost);
=20
+#ifdef CONFIG_PROC_FS
+  if (megaCfg->controller_proc_dir_entry) {
+		  remove_proc_entry("stat",megaCfg->controller_proc_dir_entry);
+		  remove_proc_entry("status", megaCfg->controller_proc_dir_entry);
+		  remove_proc_entry("config", megaCfg->controller_proc_dir_entry);
+		  remove_proc_entry("mailbox", megaCfg->controller_proc_dir_entry);
+		  for (i =3D 0; i < numCtlrs; i++) {
+				  char buf[12];
+				  memset(buf,0,12);
+				  sprintf(buf,"%d",i);
+				  remove_proc_entry(buf,mega_proc_dir_entry);
+		  }
+		  remove_proc_entry("megaraid", &proc_root);
+  }
+#endif
+
   return 0;
 }
=20
@@ -1697,6 +2093,7 @@
   DRIVER_LOCK_T
   mega_host_config *megaCfg;
   mega_scb *pScb;
+  char *user_area =3D NULL;
=20
   megaCfg =3D (mega_host_config *) SCpnt->host->hostdata;
   DRIVER_LOCK(megaCfg);
@@ -1714,6 +2111,9 @@
=20
   SCpnt->scsi_done =3D pktComp;
=20
+  if (mega_driver_ioctl(megaCfg, SCpnt))
+		  return 0;
+ =20
   /* If driver in abort or reset.. cancel this command */
   if (megaCfg->flag & IN_ABORT) {
     SCpnt->result =3D (DID_ABORT << 16);
@@ -1765,31 +2165,31 @@
     megaCfg->qPcnt++;
=20
       mega_runpendq(megaCfg);
-
-#if LINUX_VERSION_CODE > 0x020024
-    if ( SCpnt->cmnd[0]=3D=3DIOCTL_CMD_NEW )
-    {  /* user data from external user buffer */
-          char *user_area;
-          u32  xfer_size;
-
-          init_MUTEX_LOCKED(&pScb->sem);
-          down(&pScb->sem);
-
+  if(pScb->SCpnt->cmnd[0] =3D=3D IOCTL_CMD_NEW) {
+		init_MUTEX_LOCKED(&pScb->ioctl_sem);
+		spin_unlock_irq(&io_request_lock);
+		down(&pScb->ioctl_sem);
           user_area =3D *((char **)&pScb->SCpnt->cmnd[4]);
-          xfer_size =3D *((u32 *)&pScb->SCpnt->cmnd[8]);
-
-          copy_to_user(user_area,pScb->kern_area,xfer_size);
-
-          kfree(pScb->kern_area);
-
-          mega_freeSCB(megaCfg, pScb);
+		if(copy_to_user(user_area,pScb->buff_ptr,pScb->iDataSize)) {
+				printk("megaraid: Error copying ioctl return value to user buffer.\n");
+				pScb->SCpnt->result =3D (DID_ERROR << 16);
     }
-#endif
+		spin_lock_irq(&io_request_lock);
+		DRIVER_LOCK(megaCfg);
+		kfree(pScb->buff_ptr);
+		pScb->buff_ptr =3D NULL;
+		mega_cmd_done(megaCfg, pScb, pScb->SCpnt->result);
+		mega_rundoneq(megaCfg);
+		mega_runpendq(megaCfg);
+		DRIVER_UNLOCK(megaCfg);
   }
=20
   megaCfg->flag &=3D ~IN_QUEUE;
-  DRIVER_UNLOCK(megaCfg);
=20
+  }
+
+
+  DRIVER_UNLOCK(megaCfg);
   return 0;
 }
=20
@@ -1798,7 +2198,13 @@
  *----------------------------------------------------------------------*/
 volatile static int internal_done_flag =3D 0;
 volatile static int internal_done_errcode =3D 0;
-static DECLARE_WAIT_QUEUE_HEAD(internal_wait);
+
+#if LINUX_VERSION_CODE < 0x20300
+	static struct wait_queue *internal_wait =3D NULL;
+#else
+	static DECLARE_WAIT_QUEUE_HEAD(internal_wait);
+#endif
+
=20
 static void internal_done (Scsi_Cmnd * SCpnt)
 {
@@ -1958,6 +2364,221 @@
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
+ =20
+  if (megaCfg->procidx > PROCBUFSIZE)
+     return 0;
+
+  va_start (args, fmt);
+  i =3D vsprintf ((megaCfg->procbuf + megaCfg->procidx), fmt, args);
+  va_end (args);
+ =20
+  megaCfg->procidx +=3D i;
+  return i;
+}
+
+
+static int proc_read_config(char *page, char **start, off_t offset,
+				int count, int *eof, void *data)=20
+{
+
+   mega_host_config *megaCfg =3D (mega_host_config *)data;=20
+ =20
+   *start =3D page;
+
+   if (megaCfg->productInfo.ProductName[0] !=3D 0)
+  	 proc_printf(megaCfg,"%s\n",megaCfg->productInfo.ProductName);
+=09
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
+   proc_printf(megaCfg,"Base =3D %08x, Irq =3D %d, ",megaCfg->base,
+						 megaCfg->host->irq);
+
+   proc_printf(megaCfg, "Logical Drives =3D %d, Channels =3D %d\n",
+			megaCfg->numldrv, megaCfg->productInfo.SCSIChanPresent);
+
+   proc_printf(megaCfg, "Version =3D%s:%s, DRAM =3D %dMb\n",
+			megaCfg->fwVer,megaCfg->biosVer,=20
+			megaCfg->productInfo.DramSize);
+
+   proc_printf(megaCfg,"Controller Queue Depth =3D %d, Driver Queue Depth =
=3D %d\n",
+		megaCfg->productInfo.MaxConcCmds, megaCfg->max_cmds);  =20
+   COPY_BACK;
+   return count;
+}
+
+
+
+static int proc_read_stat(char *page, char **start, off_t offset,
+				int count, int *eof, void *data)=20
+{
+   int i;
+   mega_host_config *megaCfg =3D (mega_host_config *)data;=20
+
+   *start =3D page;
+
+   proc_printf(megaCfg,"Statistical Information for this controller\n");
+   proc_printf(megaCfg,"Interrupts Collected =3D %d\n", megaCfg->nInterrup=
ts);
+
+   for (i =3D 0; i < megaCfg->numldrv; i++) {
+	proc_printf(megaCfg,"Logical Drive %d:\n", i);
+        proc_printf(megaCfg,"\tReads Issued =3D %10d, Writes Issued =3D %1=
0d\n",
+			megaCfg->nReads[i], megaCfg->nWrites[i]);
+       =20
+        proc_printf(megaCfg,"\tSectors Read =3D %10d, Sectors Written =3D =
%10d\n\n",				megaCfg->nReadBlocks[i],
+				megaCfg->nWriteBlocks[i]);
+   }
+
+   COPY_BACK;
+   return count;
+}
+
+       =20
+
+static int proc_read_status(char *page, char **start, off_t offset,
+				int count, int *eof, void *data)=20
+{
+ mega_host_config *megaCfg =3D (mega_host_config *)data;
+ *start =3D page;
+
+ proc_printf(megaCfg,"TBD\n");
+ COPY_BACK;
+ return count;
+}
+
+
+static int proc_read_mbox(char *page, char **start, off_t offset,
+				int count, int *eof, void *data)=20
+{
+// int i;
+// char *dta =3D NULL;
+ mega_host_config *megaCfg =3D (mega_host_config *)data;
+ volatile mega_mailbox *mbox =3D megaCfg->mbox;
+
+ *start =3D page;
+
+ proc_printf(megaCfg,"Contents of Mail Box Structure\n");
+ proc_printf(megaCfg,"  Fw Command   =3D 0x%02x\n", mbox->cmd);
+ proc_printf(megaCfg,"  Cmd Sequence =3D 0x%02x\n", mbox->cmdid);
+ proc_printf(megaCfg,"  No of Sectors=3D %04d\n", mbox->numsectors);
+ proc_printf(megaCfg,"  LBA          =3D 0x%02x\n", mbox->lba);
+ proc_printf(megaCfg,"  DTA          =3D 0x%08x\n", mbox->xferaddr);
+ proc_printf(megaCfg,"  Logical Drive=3D 0x%02x\n", mbox->logdrv);
+ proc_printf(megaCfg,"  No of SG Elmt=3D 0x%02x\n", mbox->numsgelements);
+ proc_printf(megaCfg,"  Busy         =3D %01x\n", mbox->busy);=20
+ proc_printf(megaCfg,"  Status       =3D 0x%02x\n", mbox->status);
+
+/* proc_printf(megaCfg, "Dump of MailBox\n");
+ for (i =3D 0; i < 16; i++)
+	proc_printf(megaCfg, "%02x ",*(mbox + i));
+
+proc_printf(megaCfg, "\n\nNumber of Status =3D %02d\n",mbox->numstatus);
+
+ for (i =3D 0; i < 46; i++) {
+	proc_printf(megaCfg,"%02d ",*(mbox + 16 + i));
+        if (i%16)
+		proc_printf(megaCfg,"\n");
+}
+
+if (!mbox->numsgelements) {=20
+	dta =3D phys_to_virt(mbox->xferaddr);
+	for (i =3D 0; i < mbox->numsgelements; i++)=20
+		if (dta) {
+			proc_printf(megaCfg,"Addr =3D %08x\n", (ulong)*(dta + i));			proc_print=
f(megaCfg,"Length =3D %08x\n",=20
+				(ulong)*(dta + i + 4));
+		}
+}*/
+ COPY_BACK;
+ return count;
+}
+
+
+#if LINUX_VERSION_CODE > 0x20300
+#define CREATE_READ_PROC(string, fxn) create_proc_read_entry(string, \
+					 S_IRUSR | S_IFREG,\
+					 controller_proc_dir_entry,\
+					 fxn, megaCfg)
+#else=20
+#define CREATE_READ_PROC(string, fxn) create_proc_read_entry(string,S_IRUS=
R | S_IFREG, controller_proc_dir_entry, fxn, megaCfg)
+
+struct proc_dir_entry *create_proc_read_entry(const char *string,
+			int mode,
+			struct proc_dir_entry *parent,
+ 			read_proc_t *fxn,=20
+			mega_host_config *megaCfg)=20
+{
+	struct proc_dir_entry *temp =3D NULL;
+=09
+        temp =3D kmalloc(sizeof(struct proc_dir_entry),
+			GFP_KERNEL);
+        if (!temp)
+		return NULL;
+	memset(temp, 0, sizeof(struct proc_dir_entry));
+
+        if ( (temp->name =3D kmalloc(strlen(string) + 1, GFP_KERNEL)) =3D=
=3D NULL) {
+		kfree(temp);
+		return NULL;
+	}
+
+	strcpy((char *)temp->name, string);
+	temp->namelen =3D strlen(string);
+        temp->mode =3D mode ; /*S_IFREG | S_IRUSR*/;
+	temp->data =3D (void *)megaCfg;
+        temp->read_proc =3D fxn;
+	proc_register(parent, temp);
+        return temp;
+}
+#endif
+
+	=09
+	=20
+void mega_create_proc_entry(int index, struct proc_dir_entry *parent)
+{
+    u_char string[64] =3D {0};
+    mega_host_config *megaCfg =3D megaCtlrs[index];
+    struct proc_dir_entry *controller_proc_dir_entry =3D NULL;
+
+    sprintf(string,"%d", index);
+
+#if LINUX_VERSION_CODE > 0x20300
+    controller_proc_dir_entry =3D=20
+    megaCfg->controller_proc_dir_entry =3D=20
+		proc_mkdir(string, parent);
+#else
+    controller_proc_dir_entry =3D=20
+    megaCfg->controller_proc_dir_entry =3D=20
+        create_proc_entry(string,S_IFDIR | S_IRUGO | S_IXUGO, parent);
+#endif   =20
+
+    if (!controller_proc_dir_entry)
+   	printk("\nmegaraid: proc_mkdir failed\n");
+    else=20
+    { =09
+	megaCfg->proc_read =3D CREATE_READ_PROC("config", proc_read_config);
+    	megaCfg->proc_status =3D CREATE_READ_PROC("status", proc_read_status);
+    	megaCfg->proc_stat =3D CREATE_READ_PROC("stat", proc_read_stat);
+    	megaCfg->proc_mbox =3D CREATE_READ_PROC("mailbox", proc_read_mbox);
+    }
+  =20
+}
+#endif /* CONFIG_PROC_FS */
+=20
+=09
=20
 /*-------------------------------------------------------------
  * Return the disk geometry for a particular disk
--- megaraid.h	Mon Dec 11 22:19:40 2000
+++ megaraid.h	Fri Feb 23 15:46:36 2001
@@ -22,6 +22,11 @@
 #define SCB_RESET    0x6
 #endif
=20
+/* IOCTL DRIVER INFO */
+#define DRIVER_IOCTL_INTERFACE 0x82
+/* Methods */
+#define GET_DRIVER_INFO 1
+
 #define MEGA_CMD_TIMEOUT        10
=20
 /* Feel free to fiddle with these.. max values are:
@@ -96,13 +101,42 @@
 #define ENABLE_INTR(base)     WRITE_PORT(base,I_TOGGLE_PORT,ENABLE_INTR_BY=
TE)
 #define DISABLE_INTR(base)    WRITE_PORT(base,I_TOGGLE_PORT,DISABLE_INTR_B=
YTE)
=20
+/* Special Adapter Commands */
+#define FW_FIRE_WRITE  0x2C
+#define FW_FIRE_FLASH      0x2D
+
+#define FC_NEW_CONFIG               0xA1
+#define DCMD_FC_CMD                 0xA1
+	#define DCMD_FC_PROCEED        0x02
+	#define DCMD_DELETE_LOGDRV     0x03
+    #define DCMD_FC_READ_NVRAM_CONFIG  0x04
+    #define DCMD_FC_READ_FINAL_CONFIG  0x05
+    #define DCMD_GET_DISK_CONFIG   0x06
+    #define DCMD_CHANGE_LDNO       0x07
+    #define DCMD_COMPACT_CONFIG        0x08
+    #define DCMD_DELETE_DRIVEGROUP 0x09
+    #define DCMD_GET_LOOPID_INFO   0x0A
+    #define DCMD_CHANGE_LOOPID     0x0B
+    #define DCMD_GET_NUM_SCSI_CHANS    0x0C
+    #define DCMD_WRITE_CONFIG      0x0D /* writes 40-ld config */
+	#define NC_SUBOP_PRODUCT_INFO       0x0E
+	#define NC_SUBOP_ENQUIRY3           0x0F
+	#define ENQ3_GET_SOLICITED_NOTIFY_ONLY  0x01
+	#define ENQ3_GET_SOLICITED_FULL         0x02
+	#define ENQ3_GET_UNSOLICITED            0x03
+
+
 /* Define AMI's PCI codes */
 #undef PCI_VENDOR_ID_AMI
 #undef PCI_DEVICE_ID_AMI_MEGARAID
+#undef PCI_DEVICE_ID_AMI_MEGARAID2
+#undef PCI_DEVICE_ID_AMI_MEGARAID3
=20
 #ifndef PCI_VENDOR_ID_AMI
 #define PCI_VENDOR_ID_AMI          0x101E
 #define PCI_DEVICE_ID_AMI_MEGARAID 0x9010
+#define PCI_DEVICE_ID_AMI_MEGARAID2 0x9060
+#define PCI_DEVICE_ID_AMI_MEGARAID3 0x1960
 #endif
=20
 #define PCI_CONF_BASE_ADDR_OFFSET  0x10
@@ -528,8 +562,8 @@
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
@@ -574,9 +608,9 @@
     mega_passthru  pthru;
     Scsi_Cmnd     *SCpnt;
     mega_sglist   *sgList;
-    char          *kern_area;  /* Only used for large ioctl xfers */
-    struct wait_queue  *ioctl_wait;
-    struct semaphore   sem;
+    struct semaphore	ioctl_sem;
+    void		*buff_ptr;
+	u32			iDataSize;
     mega_scb      *next;
 };
=20
@@ -584,7 +618,12 @@
 typedef struct _mega_host_config {
     u8 numldrv;
     u32 flag;
+
+#ifdef __LP64__
+    u64 base;
+#else
     u32 base;
+#endif
 =20
     mega_scb *qFreeH;
     mega_scb *qFreeT;
@@ -598,7 +637,10 @@
     u32 qCcnt;
=20
     u32 nReads[FC_MAX_LOGICAL_DRIVES];
+    u32 nReadBlocks[FC_MAX_LOGICAL_DRIVES];
     u32 nWrites[FC_MAX_LOGICAL_DRIVES];
+    u32 nWriteBlocks[FC_MAX_LOGICAL_DRIVES];
+    u32 nInterrupts;
=20
     /* Host adapter parameters */
     u8 fwVer[7];
@@ -622,8 +664,18 @@
=20
     u8 max_cmds;
     mega_scb scbList[MAX_COMMANDS];
+#define PROCBUFSIZE 4096
+    char procbuf[PROCBUFSIZE];
+    int   procidx;
+    struct proc_dir_entry *controller_proc_dir_entry;
+    struct proc_dir_entry *proc_read, *proc_stat, *proc_status, *proc_mbox;
 } mega_host_config;
=20
+typedef struct _driver_info {
+	int size;
+	ulong version;
+} mega_driver_info;
+	=09
 const char *megaraid_info(struct Scsi_Host *);
 int megaraid_detect(Scsi_Host_Template *);
 int megaraid_release(struct Scsi_Host *);
@@ -634,5 +686,8 @@
 int megaraid_biosparam(Disk *, kdev_t, int *);
 int megaraid_proc_info(char *buffer, char **start, off_t offset,
 		       int length, int hostno, int inout);
+
+void mega_build_kernel_sg(char *, ulong , mega_scb *, mega_ioctl_mbox *);
+void mega_create_proc_entry(int index, struct proc_dir_entry *);
=20
 #endif

--oyUTqETQ0mS9luUI--

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6lnpJ9aKR2/T45h8RAh5EAKCId38hKow01r0ksdg/mRb3t3dpRwCeI8kY
no0KIkBFEw78KDe2DmaGPps=
=eKfI
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
