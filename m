Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbUKETgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbUKETgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbUKETgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:36:45 -0500
Received: from mail0.lsil.com ([147.145.40.20]:36314 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261157AbUKETbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:31:32 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57054DC51E@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>
Cc: "Mukker, Atul" <Atulm@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>
Subject: [RELEASE] megaraid 2.20.4.1 Driver
Date: Fri, 5 Nov 2004 14:23:34 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4C36C.F129A8A0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4C36C.F129A8A0
Content-Type: text/plain

Hello All,

We are releasing megaraid 2.20.4.1 driver. This version fixes two issues -

1. Handle IOCTL command timeouts properly
2. Replace incorrectly introduced pci_dma_sync_{sg,single}_for_cpu with
correct pci_dma_sync_{sg,single}_for_device.

The patch below is generated against 2.6.10-rc1. The same patch is attached
to this mail as well.

Thanks,
Sreenivas

---------------------

diff -Naur linux-2.6.10-rc1/Documentation/scsi/ChangeLog.megaraid
linux-2.6.10-rc1-new/Documentation/scsi/ChangeLog.megaraid
--- linux-2.6.10-rc1/Documentation/scsi/ChangeLog.megaraid	2004-11-04
16:32:54.818802920 -0500
+++ linux-2.6.10-rc1-new/Documentation/scsi/ChangeLog.megaraid	2004-11-04
18:25:35.973951104 -0500
@@ -1,3 +1,14 @@
+Release Date	: Thu Nov  4 18:24:56 EST 2004 - Sreenivas Bagalkote
<sreenib@lsil.com>
+
+Current Version	: 2.20.4.1 (scsi module), 2.20.2.2 (cmm module)
+Older Version	: 2.20.4.0 (scsi module), 2.20.2.1 (cmm module)
+
+i.	Handle IOCTL cmd timeouts more properly.
+
+ii.	pci_dma_sync_{sg,single}_for_cpu was introduced into megaraid_mbox
+	incorrectly (instead of _for_device). Changed to appropriate 
+	pci_dma_sync_{sg,single}_for_device.
+
 Release Date	: Wed Oct 06 11:15:29 EDT 2004 - Sreenivas Bagalkote
<sreenib@lsil.com>
 Current Version	: 2.20.4.0 (scsi module), 2.20.2.1 (cmm module)
 Older Version	: 2.20.4.0 (scsi module), 2.20.2.0 (cmm module)
diff -Naur linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_ioctl.h
linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_ioctl.h
--- linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_ioctl.h	2004-10-18
17:53:46.000000000 -0400
+++ linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_ioctl.h	2004-11-04
17:42:05.737767320 -0500
@@ -145,6 +145,8 @@
 	uint8_t			pool_index;
 	uint8_t			free_buf;
 
+	uint8_t			timedout;
+
 } __attribute__ ((aligned(1024),packed)) uioc_t;
 
 
@@ -247,6 +249,7 @@
  * @pdev		: pci dev; used for allocating dma'ble memory
  * @issue_uioc		: Driver supplied routine to issue uioc_t commands
  *			: issue_uioc(drvr_data, kioc, ISSUE/ABORT,
uioc_done)
+ * @quiescent		: flag to indicate if ioctl can be issued to this
adp
  * @list		: attach with the global list of adapters
  * @kioc_list		: block of mem for @max_kioc number of kiocs
  * @kioc_pool		: pool of free kiocs
@@ -264,7 +267,7 @@
 	uint32_t		unique_id;
 	uint32_t		drvr_type;
 	unsigned long		drvr_data;
-	uint8_t			timeout;
+	uint16_t		timeout;
 	uint8_t			max_kioc;
 
 	struct pci_dev		*pdev;
@@ -272,6 +275,7 @@
 	int(*issue_uioc)(unsigned long, uioc_t *, uint32_t);
 
 /* Maintained by common module */
+	uint32_t		quiescent;
 
 	struct list_head	list;
 	uioc_t			*kioc_list;
diff -Naur linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mbox.c
linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mbox.c
--- linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mbox.c	2004-11-04
16:33:00.000000000 -0500
+++ linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mbox.c	2004-11-04
17:45:45.801312576 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mbox.c
- * Version	: v2.20.4 (September 27 2004)
+ * Version	: v2.20.4.1 (Nov 04 2004)
  *
  * Authors:
  * 	Atul Mukker		<Atul.Mukker@lsil.com>
@@ -1553,12 +1553,12 @@
 
 	if (scb->dma_direction == PCI_DMA_TODEVICE) {
 		if (!scb->scp->use_sg) {	// sg list not used
-			pci_dma_sync_single_for_cpu(adapter->pdev,
ccb->buf_dma_h,
+			pci_dma_sync_single_for_device(adapter->pdev,
ccb->buf_dma_h,
 					scb->scp->request_bufflen,
 					PCI_DMA_TODEVICE);
 		}
 		else {
-			pci_dma_sync_sg_for_cpu(adapter->pdev,
scb->scp->request_buffer,
+			pci_dma_sync_sg_for_device(adapter->pdev,
scb->scp->request_buffer,
 				scb->scp->use_sg, PCI_DMA_TODEVICE);
 		}
 	}
@@ -3590,7 +3590,7 @@
 	adp.drvr_data		= (unsigned long)adapter;
 	adp.pdev		= adapter->pdev;
 	adp.issue_uioc		= megaraid_mbox_mm_handler;
-	adp.timeout		= 30;
+	adp.timeout		= 300;
 	adp.max_kioc		= MBOX_MAX_USER_CMDS;
 
 	if ((rval = mraid_mm_register_adp(&adp)) != 0) {
diff -Naur linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mbox.h
linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mbox.h
--- linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mbox.h	2004-11-04
16:33:00.523935608 -0500
+++ linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mbox.h	2004-11-04
17:45:34.510029112 -0500
@@ -21,8 +21,8 @@
 #include "megaraid_ioctl.h"
 
 
-#define MEGARAID_VERSION	"2.20.4.0"
-#define MEGARAID_EXT_VERSION	"(Release Date: Mon Sep 27 22:15:07 EDT
2004)"
+#define MEGARAID_VERSION	"2.20.4.1"
+#define MEGARAID_EXT_VERSION	"(Release Date: Thu Nov  4 17:44:59 EST
2004)"
 
 
 /*
diff -Naur linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mm.c
linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mm.c
--- linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mm.c	2004-11-04
16:33:00.000000000 -0500
+++ linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mm.c	2004-11-04
17:57:36.924205464 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mm.c
- * Version	: v2.20.2.1 (Oct 06 2004)
+ * Version	: v2.20.2.2 (Nov 04 2004)
  *
  * Common management module
  */
@@ -156,6 +156,17 @@
 	}
 
 	/*
+	 * Check if adapter can accept ioctl. We may have marked it offline
+	 * if any previous kioc had timedout on this controller.
+	 */
+	if (!adp->quiescent) {
+		con_log(CL_ANN, (KERN_WARNING
+			"megaraid cmm: controller cannot accept cmds due to
"
+			"earlier errors\n" ));
+		return -EFAULT;
+	}
+
+	/*
 	 * The following call will block till a kioc is available
 	 */
 	kioc = mraid_mm_alloc_kioc(adp);
@@ -171,10 +182,15 @@
 	kioc->done = ioctl_done;
 
 	/*
-	 * Issue the IOCTL to the low level driver
+	 * Issue the IOCTL to the low level driver. After the IOCTL
completes
+	 * release the kioc if and only if it was _not_ timedout. If it was
+	 * timedout, that means that resources are still with low level
driver.
 	 */
 	if ((rval = lld_ioctl(adp, kioc))) {
-		mraid_mm_dealloc_kioc(adp, kioc);
+
+		if (!kioc->timedout)
+			mraid_mm_dealloc_kioc(adp, kioc);
+
 		return rval;
 	}
 
@@ -581,6 +597,7 @@
 	kioc->user_data		= NULL;
 	kioc->user_data_len	= 0;
 	kioc->user_pthru	= NULL;
+	kioc->timedout		= 0;
 
 	return kioc;
 }
@@ -667,6 +684,14 @@
 		del_timer_sync(tp);
 	}
 
+	/*
+	 * If the command had timedout, we mark the controller offline
+	 * before returning
+	 */
+	if (kioc->timedout) {
+		adp->quiescent = 0;
+	}
+
 	return kioc->status;
 }
 
@@ -679,6 +704,10 @@
 static void
 ioctl_done(uioc_t *kioc)
 {
+	uint32_t	adapno;
+	int		iterator;
+	mraid_mmadp_t*	adapter;
+
 	/*
 	 * When the kioc returns from driver, make sure it still doesn't
 	 * have ENODATA in status. Otherwise, driver will hang on wait_event
@@ -691,7 +720,32 @@
 		kioc->status = -EINVAL;
 	}
 
-	wake_up(&wait_q);
+	/*
+	 * Check if this kioc was timedout before. If so, nobody is waiting
+	 * on this kioc. We don't have to wake up anybody. Instead, we just
+	 * have to free the kioc
+	 */
+	if (kioc->timedout) {
+		iterator	= 0;
+		adapter		= NULL;
+		adapno		= kioc->adapno;
+
+		con_log(CL_ANN, ( KERN_WARNING "megaraid cmm: completed "
+					"ioctl that was timedout
before\n"));
+
+		list_for_each_entry(adapter, &adapters_list_g, list) {
+			if (iterator++ == adapno) break;
+		}
+
+		kioc->timedout = 0;
+
+		if (adapter) {
+			mraid_mm_dealloc_kioc( adapter, kioc );
+		}
+	}
+	else {
+		wake_up(&wait_q);
+	}
 }
 
 
@@ -706,6 +760,7 @@
 	uioc_t *kioc	= (uioc_t *)ptr;
 
 	kioc->status 	= -ETIME;
+	kioc->timedout	= 1;
 
 	con_log(CL_ANN, (KERN_WARNING "megaraid cmm: ioctl timed out\n"));
 
@@ -850,6 +905,7 @@
 	adapter->issue_uioc	= lld_adp->issue_uioc;
 	adapter->timeout	= lld_adp->timeout;
 	adapter->max_kioc	= lld_adp->max_kioc;
+	adapter->quiescent	= 1;
 
 	/*
 	 * Allocate single blocks of memory for all required kiocs,
diff -Naur linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mm.h
linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mm.h
--- linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mm.h	2004-11-04
16:33:00.000000000 -0500
+++ linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mm.h	2004-11-04
17:46:36.390621832 -0500
@@ -29,9 +29,9 @@
 #include "megaraid_ioctl.h"
 
 
-#define LSI_COMMON_MOD_VERSION	"2.20.2.1"
+#define LSI_COMMON_MOD_VERSION	"2.20.2.2"
 #define LSI_COMMON_MOD_EXT_VERSION	\
-		"(Release Date: Wed Oct 06 11:15:29 EDT 2004)"
+		"(Release Date: Thu Nov  4 17:46:29 EST 2004)"
 
 
 #define LSI_DBGLVL			dbglevel

---------------------


------_=_NextPart_000_01C4C36C.F129A8A0
Content-Type: application/octet-stream;
	name="mr2.20.4.0-to-2.20.4.1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mr2.20.4.0-to-2.20.4.1.patch"

diff -Naur linux-2.6.10-rc1/Documentation/scsi/ChangeLog.megaraid =
linux-2.6.10-rc1-new/Documentation/scsi/ChangeLog.megaraid=0A=
--- linux-2.6.10-rc1/Documentation/scsi/ChangeLog.megaraid	2004-11-04 =
16:32:54.818802920 -0500=0A=
+++ linux-2.6.10-rc1-new/Documentation/scsi/ChangeLog.megaraid	=
2004-11-04 18:25:35.973951104 -0500=0A=
@@ -1,3 +1,14 @@=0A=
+Release Date	: Thu Nov  4 18:24:56 EST 2004 - Sreenivas Bagalkote =
<sreenib@lsil.com>=0A=
+=0A=
+Current Version	: 2.20.4.1 (scsi module), 2.20.2.2 (cmm module)=0A=
+Older Version	: 2.20.4.0 (scsi module), 2.20.2.1 (cmm module)=0A=
+=0A=
+i.	Handle IOCTL cmd timeouts more properly.=0A=
+=0A=
+ii.	pci_dma_sync_{sg,single}_for_cpu was introduced into =
megaraid_mbox=0A=
+	incorrectly (instead of _for_device). Changed to appropriate =0A=
+	pci_dma_sync_{sg,single}_for_device.=0A=
+=0A=
 Release Date	: Wed Oct 06 11:15:29 EDT 2004 - Sreenivas Bagalkote =
<sreenib@lsil.com>=0A=
 Current Version	: 2.20.4.0 (scsi module), 2.20.2.1 (cmm module)=0A=
 Older Version	: 2.20.4.0 (scsi module), 2.20.2.0 (cmm module)=0A=
diff -Naur linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_ioctl.h =
linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_ioctl.h=0A=
--- linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_ioctl.h	2004-10-18 =
17:53:46.000000000 -0400=0A=
+++ linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_ioctl.h	=
2004-11-04 17:42:05.737767320 -0500=0A=
@@ -145,6 +145,8 @@=0A=
 	uint8_t			pool_index;=0A=
 	uint8_t			free_buf;=0A=
 =0A=
+	uint8_t			timedout;=0A=
+=0A=
 } __attribute__ ((aligned(1024),packed)) uioc_t;=0A=
 =0A=
 =0A=
@@ -247,6 +249,7 @@=0A=
  * @pdev		: pci dev; used for allocating dma'ble memory=0A=
  * @issue_uioc		: Driver supplied routine to issue uioc_t commands=0A=
  *			: issue_uioc(drvr_data, kioc, ISSUE/ABORT, uioc_done)=0A=
+ * @quiescent		: flag to indicate if ioctl can be issued to this =
adp=0A=
  * @list		: attach with the global list of adapters=0A=
  * @kioc_list		: block of mem for @max_kioc number of kiocs=0A=
  * @kioc_pool		: pool of free kiocs=0A=
@@ -264,7 +267,7 @@=0A=
 	uint32_t		unique_id;=0A=
 	uint32_t		drvr_type;=0A=
 	unsigned long		drvr_data;=0A=
-	uint8_t			timeout;=0A=
+	uint16_t		timeout;=0A=
 	uint8_t			max_kioc;=0A=
 =0A=
 	struct pci_dev		*pdev;=0A=
@@ -272,6 +275,7 @@=0A=
 	int(*issue_uioc)(unsigned long, uioc_t *, uint32_t);=0A=
 =0A=
 /* Maintained by common module */=0A=
+	uint32_t		quiescent;=0A=
 =0A=
 	struct list_head	list;=0A=
 	uioc_t			*kioc_list;=0A=
diff -Naur linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mbox.c =
linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mbox.c=0A=
--- linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mbox.c	2004-11-04 =
16:33:00.000000000 -0500=0A=
+++ linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mbox.c	=
2004-11-04 17:45:45.801312576 -0500=0A=
@@ -10,7 +10,7 @@=0A=
  *	   2 of the License, or (at your option) any later version.=0A=
  *=0A=
  * FILE		: megaraid_mbox.c=0A=
- * Version	: v2.20.4 (September 27 2004)=0A=
+ * Version	: v2.20.4.1 (Nov 04 2004)=0A=
  *=0A=
  * Authors:=0A=
  * 	Atul Mukker		<Atul.Mukker@lsil.com>=0A=
@@ -1553,12 +1553,12 @@=0A=
 =0A=
 	if (scb->dma_direction =3D=3D PCI_DMA_TODEVICE) {=0A=
 		if (!scb->scp->use_sg) {	// sg list not used=0A=
-			pci_dma_sync_single_for_cpu(adapter->pdev, ccb->buf_dma_h,=0A=
+			pci_dma_sync_single_for_device(adapter->pdev, ccb->buf_dma_h,=0A=
 					scb->scp->request_bufflen,=0A=
 					PCI_DMA_TODEVICE);=0A=
 		}=0A=
 		else {=0A=
-			pci_dma_sync_sg_for_cpu(adapter->pdev, scb->scp->request_buffer,=0A=
+			pci_dma_sync_sg_for_device(adapter->pdev, =
scb->scp->request_buffer,=0A=
 				scb->scp->use_sg, PCI_DMA_TODEVICE);=0A=
 		}=0A=
 	}=0A=
@@ -3590,7 +3590,7 @@=0A=
 	adp.drvr_data		=3D (unsigned long)adapter;=0A=
 	adp.pdev		=3D adapter->pdev;=0A=
 	adp.issue_uioc		=3D megaraid_mbox_mm_handler;=0A=
-	adp.timeout		=3D 30;=0A=
+	adp.timeout		=3D 300;=0A=
 	adp.max_kioc		=3D MBOX_MAX_USER_CMDS;=0A=
 =0A=
 	if ((rval =3D mraid_mm_register_adp(&adp)) !=3D 0) {=0A=
diff -Naur linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mbox.h =
linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mbox.h=0A=
--- linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mbox.h	2004-11-04 =
16:33:00.523935608 -0500=0A=
+++ linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mbox.h	=
2004-11-04 17:45:34.510029112 -0500=0A=
@@ -21,8 +21,8 @@=0A=
 #include "megaraid_ioctl.h"=0A=
 =0A=
 =0A=
-#define MEGARAID_VERSION	"2.20.4.0"=0A=
-#define MEGARAID_EXT_VERSION	"(Release Date: Mon Sep 27 22:15:07 EDT 20=
04)"=0A=
+#define MEGARAID_VERSION	"2.20.4.1"=0A=
+#define MEGARAID_EXT_VERSION	"(Release Date: Thu Nov  4 17:44:59 EST =
2004)"=0A=
 =0A=
 =0A=
 /*=0A=
diff -Naur linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mm.c =
linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mm.c=0A=
--- linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mm.c	2004-11-04 =
16:33:00.000000000 -0500=0A=
+++ linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mm.c	2004-11-04 =
17:57:36.924205464 -0500=0A=
@@ -10,7 +10,7 @@=0A=
  *	   2 of the License, or (at your option) any later version.=0A=
  *=0A=
  * FILE		: megaraid_mm.c=0A=
- * Version	: v2.20.2.1 (Oct 06 2004)=0A=
+ * Version	: v2.20.2.2 (Nov 04 2004)=0A=
  *=0A=
  * Common management module=0A=
  */=0A=
@@ -156,6 +156,17 @@=0A=
 	}=0A=
 =0A=
 	/*=0A=
+	 * Check if adapter can accept ioctl. We may have marked it =
offline=0A=
+	 * if any previous kioc had timedout on this controller.=0A=
+	 */=0A=
+	if (!adp->quiescent) {=0A=
+		con_log(CL_ANN, (KERN_WARNING=0A=
+			"megaraid cmm: controller cannot accept cmds due to "=0A=
+			"earlier errors\n" ));=0A=
+		return -EFAULT;=0A=
+	}=0A=
+=0A=
+	/*=0A=
 	 * The following call will block till a kioc is available=0A=
 	 */=0A=
 	kioc =3D mraid_mm_alloc_kioc(adp);=0A=
@@ -171,10 +182,15 @@=0A=
 	kioc->done =3D ioctl_done;=0A=
 =0A=
 	/*=0A=
-	 * Issue the IOCTL to the low level driver=0A=
+	 * Issue the IOCTL to the low level driver. After the IOCTL =
completes=0A=
+	 * release the kioc if and only if it was _not_ timedout. If it =
was=0A=
+	 * timedout, that means that resources are still with low level =
driver.=0A=
 	 */=0A=
 	if ((rval =3D lld_ioctl(adp, kioc))) {=0A=
-		mraid_mm_dealloc_kioc(adp, kioc);=0A=
+=0A=
+		if (!kioc->timedout)=0A=
+			mraid_mm_dealloc_kioc(adp, kioc);=0A=
+=0A=
 		return rval;=0A=
 	}=0A=
 =0A=
@@ -581,6 +597,7 @@=0A=
 	kioc->user_data		=3D NULL;=0A=
 	kioc->user_data_len	=3D 0;=0A=
 	kioc->user_pthru	=3D NULL;=0A=
+	kioc->timedout		=3D 0;=0A=
 =0A=
 	return kioc;=0A=
 }=0A=
@@ -667,6 +684,14 @@=0A=
 		del_timer_sync(tp);=0A=
 	}=0A=
 =0A=
+	/*=0A=
+	 * If the command had timedout, we mark the controller offline=0A=
+	 * before returning=0A=
+	 */=0A=
+	if (kioc->timedout) {=0A=
+		adp->quiescent =3D 0;=0A=
+	}=0A=
+=0A=
 	return kioc->status;=0A=
 }=0A=
 =0A=
@@ -679,6 +704,10 @@=0A=
 static void=0A=
 ioctl_done(uioc_t *kioc)=0A=
 {=0A=
+	uint32_t	adapno;=0A=
+	int		iterator;=0A=
+	mraid_mmadp_t*	adapter;=0A=
+=0A=
 	/*=0A=
 	 * When the kioc returns from driver, make sure it still doesn't=0A=
 	 * have ENODATA in status. Otherwise, driver will hang on =
wait_event=0A=
@@ -691,7 +720,32 @@=0A=
 		kioc->status =3D -EINVAL;=0A=
 	}=0A=
 =0A=
-	wake_up(&wait_q);=0A=
+	/*=0A=
+	 * Check if this kioc was timedout before. If so, nobody is =
waiting=0A=
+	 * on this kioc. We don't have to wake up anybody. Instead, we =
just=0A=
+	 * have to free the kioc=0A=
+	 */=0A=
+	if (kioc->timedout) {=0A=
+		iterator	=3D 0;=0A=
+		adapter		=3D NULL;=0A=
+		adapno		=3D kioc->adapno;=0A=
+=0A=
+		con_log(CL_ANN, ( KERN_WARNING "megaraid cmm: completed "=0A=
+					"ioctl that was timedout before\n"));=0A=
+=0A=
+		list_for_each_entry(adapter, &adapters_list_g, list) {=0A=
+			if (iterator++ =3D=3D adapno) break;=0A=
+		}=0A=
+=0A=
+		kioc->timedout =3D 0;=0A=
+=0A=
+		if (adapter) {=0A=
+			mraid_mm_dealloc_kioc( adapter, kioc );=0A=
+		}=0A=
+	}=0A=
+	else {=0A=
+		wake_up(&wait_q);=0A=
+	}=0A=
 }=0A=
 =0A=
 =0A=
@@ -706,6 +760,7 @@=0A=
 	uioc_t *kioc	=3D (uioc_t *)ptr;=0A=
 =0A=
 	kioc->status 	=3D -ETIME;=0A=
+	kioc->timedout	=3D 1;=0A=
 =0A=
 	con_log(CL_ANN, (KERN_WARNING "megaraid cmm: ioctl timed out\n"));=0A=
 =0A=
@@ -850,6 +905,7 @@=0A=
 	adapter->issue_uioc	=3D lld_adp->issue_uioc;=0A=
 	adapter->timeout	=3D lld_adp->timeout;=0A=
 	adapter->max_kioc	=3D lld_adp->max_kioc;=0A=
+	adapter->quiescent	=3D 1;=0A=
 =0A=
 	/*=0A=
 	 * Allocate single blocks of memory for all required kiocs,=0A=
diff -Naur linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mm.h =
linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mm.h=0A=
--- linux-2.6.10-rc1/drivers/scsi/megaraid/megaraid_mm.h	2004-11-04 =
16:33:00.000000000 -0500=0A=
+++ linux-2.6.10-rc1-new/drivers/scsi/megaraid/megaraid_mm.h	2004-11-04 =
17:46:36.390621832 -0500=0A=
@@ -29,9 +29,9 @@=0A=
 #include "megaraid_ioctl.h"=0A=
 =0A=
 =0A=
-#define LSI_COMMON_MOD_VERSION	"2.20.2.1"=0A=
+#define LSI_COMMON_MOD_VERSION	"2.20.2.2"=0A=
 #define LSI_COMMON_MOD_EXT_VERSION	\=0A=
-		"(Release Date: Wed Oct 06 11:15:29 EDT 2004)"=0A=
+		"(Release Date: Thu Nov  4 17:46:29 EST 2004)"=0A=
 =0A=
 =0A=
 #define LSI_DBGLVL			dbglevel=0A=

------_=_NextPart_000_01C4C36C.F129A8A0--
