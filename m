Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbULHH0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbULHH0x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbULHH0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:26:53 -0500
Received: from mail0.lsil.com ([147.145.40.20]:58103 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262052AbULHHYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:24:16 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CA8C@exa-atlanta>
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
Date: Wed, 8 Dec 2004 02:16:24 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4DCF5.D38518F0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4DCF5.D38518F0
Content-Type: text/plain

Hello All,

Last week we proposed to add couple of IOCTLs to scan/remove the LDs.
It was suggested on the list that our application go sysfs route instead.
We are taking that route. (Matt Domsh, Christoph, JBG and Brian King - 
thanks for your feedback! It is appreciated.)

Please review our updated proposal. Considering that our application can 
add and remove drives on the fly:

Adding a drive:- For application to use sysfs to scan newly added drive,
it needs to know the HCTL (SCSI address - Host, Channel, Target & Lun)
of the drive. Driver is the only one that knows the mapping between a 
drive and the corresponding HCTL.

Removing a drive:- There is no sane way for the application to map out
drives to /dev/sd<x>. If application has a way of knowing the HCTL of a
deleted drive, then using that HCTL, it can match the corresponding SCSI
device name (/dev/sd<x>) and use sysfs to remove that drive.

To this end, we are requesting to be allowed to add a small IOCTL to the
driver that returns the HCTL for an LD. Our strong case is really the
"Adding
a drive" case. Somebody may suggest that an application can blindly
scan all channels and all targets on a host when it adds one drive. That
would
_not_ be correct thing to do. Application should ideally scan only the
drives that 
it has added.

I am attaching and inlining the patch that implements this logic.

Thank you,
Sreenivas
LSI Logic

diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h
new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h
--- old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-07
16:40:16.000000000 -0500
+++ new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-07
23:57:51.415674008 -0500
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
@@ -217,6 +219,27 @@
 
 } __attribute__ ((packed)) mcontroller_t;
 
+/**
+ * ld_device_address_t	: SCSI device address for the logical drives
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
+typedef struct {
+	uint32_t	host_no;
+	uint32_t	channel;
+	uint32_t	scsi_id;
+	uint32_t	lun;
+	uint32_t	ld;
+	uint32_t	reserved[3];
+} ld_device_address_t;
 
 /**
  * mm_dmapool_t	: Represents one dma pool with just one buffer
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mbox.c
new-rc2/drivers/scsi/megaraid/megaraid_mbox.c
--- old-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-07
16:40:16.000000000 -0500
+++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-08
01:29:39.420330024 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mbox.c
- * Version	: v2.20.4.1 (Nov 04 2004)
+ * Version	: v2.20.4.1+ TEST VERSION
  *
  * Authors:
  * 	Atul Mukker		<Atul.Mukker@lsil.com>
@@ -3642,6 +3642,7 @@
 megaraid_mbox_mm_handler(unsigned long drvr_data, uioc_t *kioc, uint32_t
action)
 {
 	adapter_t *adapter;
+	ld_device_address_t* lda;
 
 	if (action != IOCTL_ISSUE) {
 		con_log(CL_ANN, (KERN_WARNING
@@ -3670,6 +3671,30 @@
 
 		return kioc->status;
 
+	case GET_LD_SADDR:
+		
+		lda = (ld_device_address_t*)(unsigned long)kioc->buf_vaddr;
+
+		if ((lda->ld < 0) || (lda->ld > MAX_LOGICAL_DRIVES_40LD)) {
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
+++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.h	2004-12-07
23:53:35.047647872 -0500
@@ -21,8 +21,8 @@
 #include "megaraid_ioctl.h"
 
 
-#define MEGARAID_VERSION	"2.20.4.1"
-#define MEGARAID_EXT_VERSION	"(Release Date: Thu Nov  4 17:44:59 EST
2004)"
+#define MEGARAID_VERSION	"2.20.4.1+ TEST VERSION"
+#define MEGARAID_EXT_VERSION	"(Release Date: TEST VERSION)"
 
 
 /*
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mm.c
new-rc2/drivers/scsi/megaraid/megaraid_mm.c
--- old-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-07
16:40:16.015101592 -0500
+++ new-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-08
01:27:35.171218760 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mm.c
- * Version	: v2.20.2.2 (Nov 04 2004)
+ * Version	: v2.20.2.2+ TEST VERSION
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
+			kioc->xferlen	= sizeof(ld_device_address_t);
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
@@ -809,6 +823,15 @@
 
 			return 0;
 
+		case MEGAIOC_GET_SADDR:
+
+			if (copy_to_user(kmimd.data, kioc->buf_vaddr,
+					sizeof(ld_device_address_t))) {
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
+++ new-rc2/drivers/scsi/megaraid/megaraid_mm.h	2004-12-07
23:52:50.975347880 -0500
@@ -29,9 +29,9 @@
 #include "megaraid_ioctl.h"
 
 
-#define LSI_COMMON_MOD_VERSION	"2.20.2.2"
+#define LSI_COMMON_MOD_VERSION	"2.20.2.2+ TEST VERSION"
 #define LSI_COMMON_MOD_EXT_VERSION	\
-		"(Release Date: Thu Nov  4 17:46:29 EST 2004)"
+		"(Release Date: TEST VERSION)"
 
 
 #define LSI_DBGLVL			dbglevel



>-----Original Message-----
>From: Matt Domsch [mailto:Matt_Domsch@dell.com] 
>Sent: Friday, December 03, 2004 12:11 PM
>To: Bagalkote, Sreenivas
>Cc: 'brking@us.ibm.com'; 'James Bottomley'; 
>'linux-kernel@vger.kernel.org'; 'linux-scsi@vger.kernel.org'; 
>'bunk@fs.tum.de'; 'Andrew Morton'; Ju, Seokmann; Doelfel, 
>Hardy; Mukker, Atul
>Subject: Re: How to add/drop SCSI drives from within the driver?
>
>On Fri, Dec 03, 2004 at 10:29:29AM -0500, Bagalkote, Sreenivas wrote:
>> I agree. The sysfs method would have been the most logical 
>way of doing it.
>> But then application becomes sysfs dependent. We really 
>cannot do that.
>
>Why?  With my efibootmgr (a userspace app like your 
>megalib/megamgr/megamon), it looks for the existance of 
>/sys/whatever/, and then operates with that if it is present.  
>Else it looks for the existance of /proc/whatever (in your case
>/proc/scsi/scsi) and does likewise.  No driver ioctl needed.
> 
>> Given that we have to do it from within the driver, is whatever I am 
>> doing right?
>
>Doing it within the driver means you've got to release a new 
>driver for each affected OS, to avoid having to update the 
>userspace app on each OS.  I claim it's much easier to update 
>a userspace lib/app than it is to update a driver on each 
>installed system.
>
>Thanks,
>Matt
>
>--
>Matt Domsch
>Sr. Software Engineer, Lead Engineer
>Dell Linux Solutions linux.dell.com & www.dell.com/linux Linux 
>on Dell mailing lists @ http://lists.us.dell.com
>


------_=_NextPart_000_01C4DCF5.D38518F0
Content-Type: application/octet-stream;
	name="megaraid_hctl.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="megaraid_hctl.patch"

diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h =
new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h=0A=
--- old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-07 =
16:40:16.000000000 -0500=0A=
+++ new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-07 =
23:57:51.415674008 -0500=0A=
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
@@ -217,6 +219,27 @@=0A=
 =0A=
 } __attribute__ ((packed)) mcontroller_t;=0A=
 =0A=
+/**=0A=
+ * ld_device_address_t	: SCSI device address for the logical drives=0A=
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
+typedef struct {=0A=
+	uint32_t	host_no;=0A=
+	uint32_t	channel;=0A=
+	uint32_t	scsi_id;=0A=
+	uint32_t	lun;=0A=
+	uint32_t	ld;=0A=
+	uint32_t	reserved[3];=0A=
+} ld_device_address_t;=0A=
 =0A=
 /**=0A=
  * mm_dmapool_t	: Represents one dma pool with just one buffer=0A=
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mbox.c =
new-rc2/drivers/scsi/megaraid/megaraid_mbox.c=0A=
--- old-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-07 =
16:40:16.000000000 -0500=0A=
+++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-08 =
01:29:39.420330024 -0500=0A=
@@ -10,7 +10,7 @@=0A=
  *	   2 of the License, or (at your option) any later version.=0A=
  *=0A=
  * FILE		: megaraid_mbox.c=0A=
- * Version	: v2.20.4.1 (Nov 04 2004)=0A=
+ * Version	: v2.20.4.1+ TEST VERSION=0A=
  *=0A=
  * Authors:=0A=
  * 	Atul Mukker		<Atul.Mukker@lsil.com>=0A=
@@ -3642,6 +3642,7 @@=0A=
 megaraid_mbox_mm_handler(unsigned long drvr_data, uioc_t *kioc, =
uint32_t action)=0A=
 {=0A=
 	adapter_t *adapter;=0A=
+	ld_device_address_t* lda;=0A=
 =0A=
 	if (action !=3D IOCTL_ISSUE) {=0A=
 		con_log(CL_ANN, (KERN_WARNING=0A=
@@ -3670,6 +3671,30 @@=0A=
 =0A=
 		return kioc->status;=0A=
 =0A=
+	case GET_LD_SADDR:=0A=
+		=0A=
+		lda =3D (ld_device_address_t*)(unsigned long)kioc->buf_vaddr;=0A=
+=0A=
+		if ((lda->ld < 0) || (lda->ld > MAX_LOGICAL_DRIVES_40LD)) {=0A=
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
+++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.h	2004-12-07 =
23:53:35.047647872 -0500=0A=
@@ -21,8 +21,8 @@=0A=
 #include "megaraid_ioctl.h"=0A=
 =0A=
 =0A=
-#define MEGARAID_VERSION	"2.20.4.1"=0A=
-#define MEGARAID_EXT_VERSION	"(Release Date: Thu Nov  4 17:44:59 EST =
2004)"=0A=
+#define MEGARAID_VERSION	"2.20.4.1+ TEST VERSION"=0A=
+#define MEGARAID_EXT_VERSION	"(Release Date: TEST VERSION)"=0A=
 =0A=
 =0A=
 /*=0A=
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mm.c =
new-rc2/drivers/scsi/megaraid/megaraid_mm.c=0A=
--- old-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-07 =
16:40:16.015101592 -0500=0A=
+++ new-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-08 =
01:27:35.171218760 -0500=0A=
@@ -10,7 +10,7 @@=0A=
  *	   2 of the License, or (at your option) any later version.=0A=
  *=0A=
  * FILE		: megaraid_mm.c=0A=
- * Version	: v2.20.2.2 (Nov 04 2004)=0A=
+ * Version	: v2.20.2.2+ TEST VERSION=0A=
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
+			kioc->xferlen	=3D sizeof(ld_device_address_t);=0A=
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
@@ -809,6 +823,15 @@=0A=
 =0A=
 			return 0;=0A=
 =0A=
+		case MEGAIOC_GET_SADDR:=0A=
+=0A=
+			if (copy_to_user(kmimd.data, kioc->buf_vaddr,=0A=
+					sizeof(ld_device_address_t))) {=0A=
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
+++ new-rc2/drivers/scsi/megaraid/megaraid_mm.h	2004-12-07 =
23:52:50.975347880 -0500=0A=
@@ -29,9 +29,9 @@=0A=
 #include "megaraid_ioctl.h"=0A=
 =0A=
 =0A=
-#define LSI_COMMON_MOD_VERSION	"2.20.2.2"=0A=
+#define LSI_COMMON_MOD_VERSION	"2.20.2.2+ TEST VERSION"=0A=
 #define LSI_COMMON_MOD_EXT_VERSION	\=0A=
-		"(Release Date: Thu Nov  4 17:46:29 EST 2004)"=0A=
+		"(Release Date: TEST VERSION)"=0A=
 =0A=
 =0A=
 #define LSI_DBGLVL			dbglevel=0A=

------_=_NextPart_000_01C4DCF5.D38518F0--
