Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbULIXq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbULIXq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbULIXq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:46:58 -0500
Received: from mail0.lsil.com ([147.145.40.20]:12419 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261664AbULIXpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:45:20 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CA9C@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Thu, 9 Dec 2004 18:37:19 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4DE48.05D7D920"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4DE48.05D7D920
Content-Type: text/plain

All,

I am submitting the final patch that incorporates Matt's suggestions.

Thank you,
Sreenivas


diff -Naur old-rc2/Documentation/scsi/ChangeLog.megaraid
new-rc2/Documentation/scsi/ChangeLog.megaraid
--- old-rc2/Documentation/scsi/ChangeLog.megaraid	2004-12-07
16:40:23.000000000 -0500
+++ new-rc2/Documentation/scsi/ChangeLog.megaraid	2004-12-09
17:38:58.000000000 -0500
@@ -1,3 +1,22 @@
+Release Date	: Thu Dec  9 17:25:27 EST 2004 - Sreenivas Bagalkote
<sreenib@lsil.com>
+
+Current Version	: 2.20.4.2 (scsi module), 2.20.2.3 (cmm module)
+Older Version	: 2.20.4.1 (scsi module), 2.20.2.2 (cmm module)
+
+i.	Fixed a bug in deallocating kioc's dma buffer in megaraid_mm module
+ii.	Introduced driver ioctl that returns scsi address for a given ld.
+	
+	"Why can't the existing sysfs interfaces be used to do this?"
+		- Brian King (brking@us.ibm.com)
+	
+	"I've looked into solving this another way, but I cannot see how
+	to get this driver-private mapping of logical drive number-> HCTL
+	without putting code something like this into the driver."
+
+	"...and by providing a mapping a function to userspace, the driver
+	is free to change its mapping algorithm in the future if necessary
.."
+		- Matt Domsch (Matt_Domsch@dell.com)
+
 Release Date	: Thu Nov  4 18:24:56 EST 2004 - Sreenivas Bagalkote
<sreenib@lsil.com>
 
 Current Version	: 2.20.4.1 (scsi module), 2.20.2.2 (cmm module)
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h
new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h
--- old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-07
16:40:16.000000000 -0500
+++ new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-09
17:05:18.000000000 -0500
@@ -51,6 +51,7 @@
 #define MEGAIOC_QNADAP		'm'	/* Query # of adapters		*/
 #define MEGAIOC_QDRVRVER	'e'	/* Query driver version		*/
 #define MEGAIOC_QADAPINFO   	'g'	/* Query adapter information	*/
+#define MEGAIOC_GET_SADDR	'a'	/* Get SCSI address of an LD	*/
 
 #define USCSICMD		0x80
 #define UIOC_RD			0x00001
@@ -62,6 +63,7 @@
 #define GET_ADAP_INFO		0x30000
 #define GET_CAP			0x40000
 #define GET_STATS		0x50000
+#define GET_LD_SADDR		0x60000
 #define GET_IOCTL_VERSION	0x01
 
 #define EXT_IOCTL_SIGN_SZ	16
@@ -142,7 +144,7 @@
 
 	caddr_t			buf_vaddr;
 	dma_addr_t		buf_paddr;
-	uint8_t			pool_index;
+	int8_t			pool_index;
 	uint8_t			free_buf;
 
 	uint8_t			timedout;
@@ -217,6 +219,27 @@
 
 } __attribute__ ((packed)) mcontroller_t;
 
+/**
+ * ld_device_address	: SCSI device address for the logical drives
+ * 
+ * @host_no		: host# to which LD belogs; as understood by
mid-layer
+ * @channel		: channel on which LD is exported
+ * @target		: target on which the LD is exported
+ * @lun			: lun on which the LD is exported
+ * @ld			: the LD for which this information is sought
+ * @reserved		: reserved fields; must be set to zero
+ *
+ * NOTE			: Applications set the LD number and expect
the 
+ * 			  SCSI address to be returned in the first four
fields
+ */
+struct ld_device_address {
+	uint32_t	host_no;
+	uint32_t	channel;
+	uint32_t	scsi_id;
+	uint32_t	lun;
+	uint32_t	ld;
+	uint32_t	reserved[3];
+} __attribute__ ((packed));
 
 /**
  * mm_dmapool_t	: Represents one dma pool with just one buffer
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mbox.c
new-rc2/drivers/scsi/megaraid/megaraid_mbox.c
--- old-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-07
16:40:16.000000000 -0500
+++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-09
17:42:33.538473752 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mbox.c
- * Version	: v2.20.4.1 (Nov 04 2004)
+ * Version	: v2.20.4.2 (Dec  9 2004)
  *
  * Authors:
  * 	Atul Mukker		<Atul.Mukker@lsil.com>
@@ -3642,6 +3642,7 @@
 megaraid_mbox_mm_handler(unsigned long drvr_data, uioc_t *kioc, uint32_t
action)
 {
 	adapter_t *adapter;
+	struct ld_device_address* lda;
 
 	if (action != IOCTL_ISSUE) {
 		con_log(CL_ANN, (KERN_WARNING
@@ -3670,6 +3671,30 @@
 
 		return kioc->status;
 
+	case GET_LD_SADDR:
+		
+		lda = (struct ld_device_address*)(unsigned
long)kioc->buf_vaddr;
+
+		if (lda->ld > MAX_LOGICAL_DRIVES_40LD) {
+			lda->host_no	= 0xffffffff;
+			lda->channel	= 0xffffffff;
+			lda->scsi_id	= 0xffffffff;
+			lda->lun	= 0xffffffff;
+			kioc->status	= -ENODEV;
+			kioc->done(kioc);
+			return kioc->status;
+		}
+
+		lda->host_no	= adapter->host->host_no;
+		lda->channel	= adapter->max_channel;
+		lda->scsi_id	= (lda->ld < adapter->init_id) ? 
+						lda->ld : lda->ld + 1;
+		lda->lun	= 0;
+		kioc->status	= 0;
+		kioc->done(kioc);
+
+		return kioc->status;
+
 	case MBOX_CMD:
 
 		return megaraid_mbox_mm_command(adapter, kioc);
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mbox.h
new-rc2/drivers/scsi/megaraid/megaraid_mbox.h
--- old-rc2/drivers/scsi/megaraid/megaraid_mbox.h	2004-12-07
16:40:16.000000000 -0500
+++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.h	2004-12-09
17:41:34.706417584 -0500
@@ -21,8 +21,8 @@
 #include "megaraid_ioctl.h"
 
 
-#define MEGARAID_VERSION	"2.20.4.1"
-#define MEGARAID_EXT_VERSION	"(Release Date: Thu Nov  4 17:44:59 EST
2004)"
+#define MEGARAID_VERSION	"2.20.4.2"
+#define MEGARAID_EXT_VERSION	"(Release Date: Thu Dec  9 17:25:27 EST
2004)"
 
 
 /*
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mm.c
new-rc2/drivers/scsi/megaraid/megaraid_mm.c
--- old-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-07
16:40:16.000000000 -0500
+++ new-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-09
18:12:16.485424616 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mm.c
- * Version	: v2.20.2.2 (Nov 04 2004)
+ * Version	: v2.20.2.3 (Dec  9 2004)
  *
  * Common management module
  */
@@ -373,6 +373,20 @@
 			if (mraid_mm_attach_buf(adp, kioc, kioc->xferlen))
 				return (-ENOMEM);
 		}
+		else if (subopcode == MEGAIOC_GET_SADDR) {
+
+			kioc->opcode	= GET_LD_SADDR;
+			kioc->data_dir	= UIOC_RD;
+			kioc->xferlen	= sizeof(struct ld_device_address);
+
+			if (mraid_mm_attach_buf(adp, kioc, kioc->xferlen))
+				return (-ENOMEM);
+
+			if (copy_from_user(kioc->buf_vaddr, mimd.data,
+							kioc->xferlen )) {
+				return (-EFAULT);
+			}
+		}
 		else {
 			con_log(CL_ANN, (KERN_WARNING
 					"megaraid cmm: Invalid subop\n"));
@@ -614,23 +628,27 @@
 	mm_dmapool_t	*pool;
 	unsigned long	flags;
 
-	pool = &adp->dma_pool_list[kioc->pool_index];
+	if (kioc->pool_index != -1) {
+		pool = &adp->dma_pool_list[kioc->pool_index];
 
-	/* This routine may be called in non-isr context also */
-	spin_lock_irqsave(&pool->lock, flags);
+		/* This routine may be called in non-isr context also */
+		spin_lock_irqsave(&pool->lock, flags);
 
-	/*
-	 * While attaching the dma buffer, if we didn't get the required
-	 * buffer from the pool, we would have allocated it at the run time
-	 * and set the free_buf flag. We must free that buffer. Otherwise,
-	 * just mark that the buffer is not in use
-	 */
-	if (kioc->free_buf == 1)
-		pci_pool_free(pool->handle, kioc->buf_vaddr,
kioc->buf_paddr);
-	else
-		pool->in_use = 0;
+		/*
+		 * While attaching the dma buffer, if we didn't get the 
+		 * required buffer from the pool, we would have allocated 
+		 * it at the run time and set the free_buf flag. We must 
+		 * free that buffer. Otherwise, just mark that the buffer is

+		 * not in use
+		 */
+		if (kioc->free_buf == 1)
+			pci_pool_free(pool->handle, kioc->buf_vaddr, 
+							kioc->buf_paddr);
+		else
+			pool->in_use = 0;
 
-	spin_unlock_irqrestore(&pool->lock, flags);
+		spin_unlock_irqrestore(&pool->lock, flags);
+	}
 
 	/* Return the kioc to the free pool */
 	spin_lock_irqsave(&adp->kioc_pool_lock, flags);
@@ -809,6 +827,15 @@
 
 			return 0;
 
+		case MEGAIOC_GET_SADDR:
+
+			if (copy_to_user(kmimd.data, kioc->buf_vaddr,
+					sizeof(struct ld_device_address))) {
+				return (-EFAULT);
+			}
+			
+			return kioc->status;
+
 		default:
 			return (-EINVAL);
 		}
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mm.h
new-rc2/drivers/scsi/megaraid/megaraid_mm.h
--- old-rc2/drivers/scsi/megaraid/megaraid_mm.h	2004-12-07
16:40:15.000000000 -0500
+++ new-rc2/drivers/scsi/megaraid/megaraid_mm.h	2004-12-09
18:12:10.336359416 -0500
@@ -29,9 +29,9 @@
 #include "megaraid_ioctl.h"
 
 
-#define LSI_COMMON_MOD_VERSION	"2.20.2.2"
+#define LSI_COMMON_MOD_VERSION	"2.20.2.3"
 #define LSI_COMMON_MOD_EXT_VERSION	\
-		"(Release Date: Thu Nov  4 17:46:29 EST 2004)"
+		"(Release Date: Thu Dec  9 17:25:27 EST 2004)"
 
 
 #define LSI_DBGLVL			dbglevel



------_=_NextPart_000_01C4DE48.05D7D920
Content-Type: application/octet-stream;
	name="megaraid-hctl.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="megaraid-hctl.patch"

diff -Naur old-rc2/Documentation/scsi/ChangeLog.megaraid =
new-rc2/Documentation/scsi/ChangeLog.megaraid=0A=
--- old-rc2/Documentation/scsi/ChangeLog.megaraid	2004-12-07 =
16:40:23.000000000 -0500=0A=
+++ new-rc2/Documentation/scsi/ChangeLog.megaraid	2004-12-09 =
17:38:58.000000000 -0500=0A=
@@ -1,3 +1,22 @@=0A=
+Release Date	: Thu Dec  9 17:25:27 EST 2004 - Sreenivas Bagalkote =
<sreenib@lsil.com>=0A=
+=0A=
+Current Version	: 2.20.4.2 (scsi module), 2.20.2.3 (cmm module)=0A=
+Older Version	: 2.20.4.1 (scsi module), 2.20.2.2 (cmm module)=0A=
+=0A=
+i.	Fixed a bug in deallocating kioc's dma buffer in megaraid_mm =
module=0A=
+ii.	Introduced driver ioctl that returns scsi address for a given =
ld.=0A=
+	=0A=
+	"Why can't the existing sysfs interfaces be used to do this?"=0A=
+		- Brian King (brking@us.ibm.com)=0A=
+	=0A=
+	"I've looked into solving this another way, but I cannot see how=0A=
+	to get this driver-private mapping of logical drive number-> HCTL=0A=
+	without putting code something like this into the driver."=0A=
+=0A=
+	"...and by providing a mapping a function to userspace, the driver=0A=
+	is free to change its mapping algorithm in the future if necessary =
.."=0A=
+		- Matt Domsch (Matt_Domsch@dell.com)=0A=
+=0A=
 Release Date	: Thu Nov  4 18:24:56 EST 2004 - Sreenivas Bagalkote =
<sreenib@lsil.com>=0A=
 =0A=
 Current Version	: 2.20.4.1 (scsi module), 2.20.2.2 (cmm module)=0A=
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h =
new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h=0A=
--- old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-07 =
16:40:16.000000000 -0500=0A=
+++ new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-09 =
17:05:18.000000000 -0500=0A=
@@ -51,6 +51,7 @@=0A=
 #define MEGAIOC_QNADAP		'm'	/* Query # of adapters		*/=0A=
 #define MEGAIOC_QDRVRVER	'e'	/* Query driver version		*/=0A=
 #define MEGAIOC_QADAPINFO   	'g'	/* Query adapter information	*/=0A=
+#define MEGAIOC_GET_SADDR	'a'	/* Get SCSI address of an LD	*/=0A=
 =0A=
 #define USCSICMD		0x80=0A=
 #define UIOC_RD			0x00001=0A=
@@ -62,6 +63,7 @@=0A=
 #define GET_ADAP_INFO		0x30000=0A=
 #define GET_CAP			0x40000=0A=
 #define GET_STATS		0x50000=0A=
+#define GET_LD_SADDR		0x60000=0A=
 #define GET_IOCTL_VERSION	0x01=0A=
 =0A=
 #define EXT_IOCTL_SIGN_SZ	16=0A=
@@ -142,7 +144,7 @@=0A=
 =0A=
 	caddr_t			buf_vaddr;=0A=
 	dma_addr_t		buf_paddr;=0A=
-	uint8_t			pool_index;=0A=
+	int8_t			pool_index;=0A=
 	uint8_t			free_buf;=0A=
 =0A=
 	uint8_t			timedout;=0A=
@@ -217,6 +219,27 @@=0A=
 =0A=
 } __attribute__ ((packed)) mcontroller_t;=0A=
 =0A=
+/**=0A=
+ * ld_device_address	: SCSI device address for the logical drives=0A=
+ * =0A=
+ * @host_no		: host# to which LD belogs; as understood by mid-layer=0A=
+ * @channel		: channel on which LD is exported=0A=
+ * @target		: target on which the LD is exported=0A=
+ * @lun			: lun on which the LD is exported=0A=
+ * @ld			: the LD for which this information is sought=0A=
+ * @reserved		: reserved fields; must be set to zero=0A=
+ *=0A=
+ * NOTE			: Applications set the LD number and expect the =0A=
+ * 			  SCSI address to be returned in the first four fields=0A=
+ */=0A=
+struct ld_device_address {=0A=
+	uint32_t	host_no;=0A=
+	uint32_t	channel;=0A=
+	uint32_t	scsi_id;=0A=
+	uint32_t	lun;=0A=
+	uint32_t	ld;=0A=
+	uint32_t	reserved[3];=0A=
+} __attribute__ ((packed));=0A=
 =0A=
 /**=0A=
  * mm_dmapool_t	: Represents one dma pool with just one buffer=0A=
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mbox.c =
new-rc2/drivers/scsi/megaraid/megaraid_mbox.c=0A=
--- old-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-07 =
16:40:16.000000000 -0500=0A=
+++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-09 =
17:42:33.538473752 -0500=0A=
@@ -10,7 +10,7 @@=0A=
  *	   2 of the License, or (at your option) any later version.=0A=
  *=0A=
  * FILE		: megaraid_mbox.c=0A=
- * Version	: v2.20.4.1 (Nov 04 2004)=0A=
+ * Version	: v2.20.4.2 (Dec  9 2004)=0A=
  *=0A=
  * Authors:=0A=
  * 	Atul Mukker		<Atul.Mukker@lsil.com>=0A=
@@ -3642,6 +3642,7 @@=0A=
 megaraid_mbox_mm_handler(unsigned long drvr_data, uioc_t *kioc, =
uint32_t action)=0A=
 {=0A=
 	adapter_t *adapter;=0A=
+	struct ld_device_address* lda;=0A=
 =0A=
 	if (action !=3D IOCTL_ISSUE) {=0A=
 		con_log(CL_ANN, (KERN_WARNING=0A=
@@ -3670,6 +3671,30 @@=0A=
 =0A=
 		return kioc->status;=0A=
 =0A=
+	case GET_LD_SADDR:=0A=
+		=0A=
+		lda =3D (struct ld_device_address*)(unsigned =
long)kioc->buf_vaddr;=0A=
+=0A=
+		if (lda->ld > MAX_LOGICAL_DRIVES_40LD) {=0A=
+			lda->host_no	=3D 0xffffffff;=0A=
+			lda->channel	=3D 0xffffffff;=0A=
+			lda->scsi_id	=3D 0xffffffff;=0A=
+			lda->lun	=3D 0xffffffff;=0A=
+			kioc->status	=3D -ENODEV;=0A=
+			kioc->done(kioc);=0A=
+			return kioc->status;=0A=
+		}=0A=
+=0A=
+		lda->host_no	=3D adapter->host->host_no;=0A=
+		lda->channel	=3D adapter->max_channel;=0A=
+		lda->scsi_id	=3D (lda->ld < adapter->init_id) ? =0A=
+						lda->ld : lda->ld + 1;=0A=
+		lda->lun	=3D 0;=0A=
+		kioc->status	=3D 0;=0A=
+		kioc->done(kioc);=0A=
+=0A=
+		return kioc->status;=0A=
+=0A=
 	case MBOX_CMD:=0A=
 =0A=
 		return megaraid_mbox_mm_command(adapter, kioc);=0A=
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mbox.h =
new-rc2/drivers/scsi/megaraid/megaraid_mbox.h=0A=
--- old-rc2/drivers/scsi/megaraid/megaraid_mbox.h	2004-12-07 =
16:40:16.000000000 -0500=0A=
+++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.h	2004-12-09 =
17:41:34.706417584 -0500=0A=
@@ -21,8 +21,8 @@=0A=
 #include "megaraid_ioctl.h"=0A=
 =0A=
 =0A=
-#define MEGARAID_VERSION	"2.20.4.1"=0A=
-#define MEGARAID_EXT_VERSION	"(Release Date: Thu Nov  4 17:44:59 EST =
2004)"=0A=
+#define MEGARAID_VERSION	"2.20.4.2"=0A=
+#define MEGARAID_EXT_VERSION	"(Release Date: Thu Dec  9 17:25:27 EST =
2004)"=0A=
 =0A=
 =0A=
 /*=0A=
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mm.c =
new-rc2/drivers/scsi/megaraid/megaraid_mm.c=0A=
--- old-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-07 =
16:40:16.000000000 -0500=0A=
+++ new-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-09 =
18:12:16.485424616 -0500=0A=
@@ -10,7 +10,7 @@=0A=
  *	   2 of the License, or (at your option) any later version.=0A=
  *=0A=
  * FILE		: megaraid_mm.c=0A=
- * Version	: v2.20.2.2 (Nov 04 2004)=0A=
+ * Version	: v2.20.2.3 (Dec  9 2004)=0A=
  *=0A=
  * Common management module=0A=
  */=0A=
@@ -373,6 +373,20 @@=0A=
 			if (mraid_mm_attach_buf(adp, kioc, kioc->xferlen))=0A=
 				return (-ENOMEM);=0A=
 		}=0A=
+		else if (subopcode =3D=3D MEGAIOC_GET_SADDR) {=0A=
+=0A=
+			kioc->opcode	=3D GET_LD_SADDR;=0A=
+			kioc->data_dir	=3D UIOC_RD;=0A=
+			kioc->xferlen	=3D sizeof(struct ld_device_address);=0A=
+=0A=
+			if (mraid_mm_attach_buf(adp, kioc, kioc->xferlen))=0A=
+				return (-ENOMEM);=0A=
+=0A=
+			if (copy_from_user(kioc->buf_vaddr, mimd.data,=0A=
+							kioc->xferlen )) {=0A=
+				return (-EFAULT);=0A=
+			}=0A=
+		}=0A=
 		else {=0A=
 			con_log(CL_ANN, (KERN_WARNING=0A=
 					"megaraid cmm: Invalid subop\n"));=0A=
@@ -614,23 +628,27 @@=0A=
 	mm_dmapool_t	*pool;=0A=
 	unsigned long	flags;=0A=
 =0A=
-	pool =3D &adp->dma_pool_list[kioc->pool_index];=0A=
+	if (kioc->pool_index !=3D -1) {=0A=
+		pool =3D &adp->dma_pool_list[kioc->pool_index];=0A=
 =0A=
-	/* This routine may be called in non-isr context also */=0A=
-	spin_lock_irqsave(&pool->lock, flags);=0A=
+		/* This routine may be called in non-isr context also */=0A=
+		spin_lock_irqsave(&pool->lock, flags);=0A=
 =0A=
-	/*=0A=
-	 * While attaching the dma buffer, if we didn't get the required=0A=
-	 * buffer from the pool, we would have allocated it at the run =
time=0A=
-	 * and set the free_buf flag. We must free that buffer. Otherwise,=0A=
-	 * just mark that the buffer is not in use=0A=
-	 */=0A=
-	if (kioc->free_buf =3D=3D 1)=0A=
-		pci_pool_free(pool->handle, kioc->buf_vaddr, kioc->buf_paddr);=0A=
-	else=0A=
-		pool->in_use =3D 0;=0A=
+		/*=0A=
+		 * While attaching the dma buffer, if we didn't get the =0A=
+		 * required buffer from the pool, we would have allocated =0A=
+		 * it at the run time and set the free_buf flag. We must =0A=
+		 * free that buffer. Otherwise, just mark that the buffer is =0A=
+		 * not in use=0A=
+		 */=0A=
+		if (kioc->free_buf =3D=3D 1)=0A=
+			pci_pool_free(pool->handle, kioc->buf_vaddr, =0A=
+							kioc->buf_paddr);=0A=
+		else=0A=
+			pool->in_use =3D 0;=0A=
 =0A=
-	spin_unlock_irqrestore(&pool->lock, flags);=0A=
+		spin_unlock_irqrestore(&pool->lock, flags);=0A=
+	}=0A=
 =0A=
 	/* Return the kioc to the free pool */=0A=
 	spin_lock_irqsave(&adp->kioc_pool_lock, flags);=0A=
@@ -809,6 +827,15 @@=0A=
 =0A=
 			return 0;=0A=
 =0A=
+		case MEGAIOC_GET_SADDR:=0A=
+=0A=
+			if (copy_to_user(kmimd.data, kioc->buf_vaddr,=0A=
+					sizeof(struct ld_device_address))) {=0A=
+				return (-EFAULT);=0A=
+			}=0A=
+			=0A=
+			return kioc->status;=0A=
+=0A=
 		default:=0A=
 			return (-EINVAL);=0A=
 		}=0A=
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mm.h =
new-rc2/drivers/scsi/megaraid/megaraid_mm.h=0A=
--- old-rc2/drivers/scsi/megaraid/megaraid_mm.h	2004-12-07 =
16:40:15.000000000 -0500=0A=
+++ new-rc2/drivers/scsi/megaraid/megaraid_mm.h	2004-12-09 =
18:12:10.336359416 -0500=0A=
@@ -29,9 +29,9 @@=0A=
 #include "megaraid_ioctl.h"=0A=
 =0A=
 =0A=
-#define LSI_COMMON_MOD_VERSION	"2.20.2.2"=0A=
+#define LSI_COMMON_MOD_VERSION	"2.20.2.3"=0A=
 #define LSI_COMMON_MOD_EXT_VERSION	\=0A=
-		"(Release Date: Thu Nov  4 17:46:29 EST 2004)"=0A=
+		"(Release Date: Thu Dec  9 17:25:27 EST 2004)"=0A=
 =0A=
 =0A=
 #define LSI_DBGLVL			dbglevel=0A=

------_=_NextPart_000_01C4DE48.05D7D920--
