Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbULCCNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbULCCNR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 21:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbULCCNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 21:13:17 -0500
Received: from mail0.lsil.com ([147.145.40.20]:55020 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261878AbULCCMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 21:12:12 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CA69@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Matt_Domsch@dell.com'" <Matt_Domsch@dell.com>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: How to add/drop SCSI drives from within the driver?
Date: Thu, 2 Dec 2004 21:04:24 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4D8DC.693FF360"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4D8DC.693FF360
Content-Type: text/plain

Hello All,

I am trying to implement a feature in my SCSI driver, where it can
trigger the SCSI mid-layer to scan or remove a particular drive. I 
appreciate any help in nudging me in the right direction.

The exported functions - 

scsi_add_device( host, channel, target, lun )
scsi_remove_device( struct scsi_device* )

seem to work well in my limited testing. Are there any caveats in this
method? Does this method work well without exceptions? I am inlining
the full patch for megaraid SCSI driver taken against 2.6.10-rc2. I am
also attaching it to this mail.

Thank you,
Sreenivas


----
diff -Naur old-rc3/drivers/scsi/megaraid/mega_common.h
new-rc2/drivers/scsi/megaraid/mega_common.h
--- old-rc2/drivers/scsi/megaraid/mega_common.h	2004-10-18
17:54:31.000000000 -0400
+++ new-rc2/drivers/scsi/megaraid/mega_common.h	2004-12-02
20:23:35.000000000 -0500
@@ -242,6 +242,15 @@
 					[SCP2TARGET(scp)] & 0xFF);	\
 	}
 
+/**
+ * MRAID_LD_TARGET
+ * @param adp		- Adapter's soft state
+ * @param ld		- Logical drive number
+ *
+ * Macro to retrieve the SCSI target id of a logical drive
+ */
+#define MRAID_LD_TARGET(adp, ld) (((ld) < (adp)->init_id) ? (ld) : (ld)+1)

+
 /*
  * ### Helper routines ###
  */
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h
new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h
--- old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-02
20:20:16.000000000 -0500
+++ new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-02
20:23:25.000000000 -0500
@@ -51,8 +51,11 @@
 #define MEGAIOC_QNADAP		'm'	/* Query # of adapters		*/
 #define MEGAIOC_QDRVRVER	'e'	/* Query driver version		*/
 #define MEGAIOC_QADAPINFO   	'g'	/* Query adapter information	*/
+#define MEGAIOC_ADD_LD		'a'
+#define MEGAIOC_DEL_LD		'r'
 
 #define USCSICMD		0x80
+#define UIOC_NONE		0x00000
 #define UIOC_RD			0x00001
 #define UIOC_WR			0x00002
 
@@ -62,6 +65,8 @@
 #define GET_ADAP_INFO		0x30000
 #define GET_CAP			0x40000
 #define GET_STATS		0x50000
+#define	ADD_LD			0x60000
+#define DEL_LD			0x70000
 #define GET_IOCTL_VERSION	0x01
 
 #define EXT_IOCTL_SIGN_SZ	16
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mbox.c
new-rc2/drivers/scsi/megaraid/megaraid_mbox.c
--- old-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-02
20:20:16.000000000 -0500
+++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-02
20:32:33.408278216 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mbox.c
- * Version	: v2.20.4.1 (Nov 04 2004)
+ * Version	: v2.20.4.1+ TEST VERSION
  *
  * Authors:
  * 	Atul Mukker		<Atul.Mukker@lsil.com>
@@ -3642,6 +3642,10 @@
 megaraid_mbox_mm_handler(unsigned long drvr_data, uioc_t *kioc, uint32_t
action)
 {
 	adapter_t *adapter;
+	uint32_t ld;
+	struct scsi_device* sdev;
+	int ch;
+	int tg;
 
 	if (action != IOCTL_ISSUE) {
 		con_log(CL_ANN, (KERN_WARNING
@@ -3670,6 +3674,31 @@
 
 		return kioc->status;
 
+	case ADD_LD:
+		ld = *(uint32_t*) kioc->buf_vaddr;
+		ch = adapter->max_channel;
+		tg = MRAID_LD_TARGET( adapter, ld );
+		scsi_add_device(adapter->host, ch, tg, 0);
+
+		kioc->status = 0;
+		kioc->done(kioc);
+		return kioc->status;
+
+	case DEL_LD:
+		ld = *(uint32_t*) kioc->buf_vaddr;
+		ch = adapter->max_channel;
+		tg = MRAID_LD_TARGET( adapter, ld );
+		sdev = scsi_device_lookup( adapter->host, ch, tg, 0);
+		
+		if( sdev ) {
+			scsi_remove_device( sdev );
+			scsi_device_put( sdev );
+		}
+
+		kioc->status = 0;
+		kioc->done(kioc);
+		return kioc->status;
+
 	case MBOX_CMD:
 
 		return megaraid_mbox_mm_command(adapter, kioc);
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mbox.h
new-rc2/drivers/scsi/megaraid/megaraid_mbox.h
--- old-rc2/drivers/scsi/megaraid/megaraid_mbox.h	2004-12-02
20:20:16.000000000 -0500
+++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.h	2004-12-02
20:32:09.737876664 -0500
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
--- old-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-02
20:20:16.000000000 -0500
+++ new-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-02
20:22:57.000000000 -0500
@@ -373,6 +373,34 @@
 			if (mraid_mm_attach_buf(adp, kioc, kioc->xferlen))
 				return (-ENOMEM);
 		}
+		else if (subopcode == MEGAIOC_ADD_LD) {
+
+			kioc->opcode	= ADD_LD;
+			kioc->data_dir	= UIOC_NONE;
+			kioc->xferlen	= sizeof(uint32_t);
+
+			if (mraid_mm_attach_buf(adp, kioc, kioc->xferlen))
+				return -(ENOMEM);
+
+			if (copy_from_user(kioc->buf_vaddr, mimd.data,
+							kioc->xferlen)) {
+				return (-EFAULT);
+			}
+		}
+		else if (subopcode == MEGAIOC_DEL_LD) {
+
+			kioc->opcode	= DEL_LD;
+			kioc->data_dir	= UIOC_NONE;
+			kioc->xferlen	= sizeof(uint32_t);
+
+			if (mraid_mm_attach_buf(adp, kioc, kioc->xferlen))
+				return -(ENOMEM);
+
+			if (copy_from_user(kioc->buf_vaddr, mimd.data,
+							kioc->xferlen)) {
+				return (-EFAULT);
+			}
+		}
 		else {
 			con_log(CL_ANN, (KERN_WARNING
 					"megaraid cmm: Invalid subop\n"));
@@ -809,6 +837,9 @@
 
 			return 0;
 
+		case MEGAIOC_ADD_LD:
+		case MEGAIOC_DEL_LD:
+			return 0;
 		default:
 			return (-EINVAL);
 		}
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mm.h
new-rc2/drivers/scsi/megaraid/megaraid_mm.h
--- old-rc2/drivers/scsi/megaraid/megaraid_mm.h	2004-12-02
20:20:16.000000000 -0500
+++ new-rc2/drivers/scsi/megaraid/megaraid_mm.h	2004-12-02
20:33:00.709127856 -0500
@@ -29,9 +29,9 @@
 #include "megaraid_ioctl.h"
 
 
-#define LSI_COMMON_MOD_VERSION	"2.20.2.2"
+#define LSI_COMMON_MOD_VERSION	"2.20.2.2+ TEST VERSION"
 #define LSI_COMMON_MOD_EXT_VERSION	\
-		"(Release Date: Thu Nov  4 17:46:29 EST 2004)"
+		"(Release Date: TEST VERSION)"
 
 
 #define LSI_DBGLVL			dbglevel
----


------_=_NextPart_000_01C4D8DC.693FF360
Content-Type: application/octet-stream;
	name="megaraid-scan.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="megaraid-scan.patch"

diff -Naur old-rc2/drivers/scsi/megaraid/mega_common.h =
new-rc2/drivers/scsi/megaraid/mega_common.h=0A=
--- old-rc2/drivers/scsi/megaraid/mega_common.h	2004-10-18 =
17:54:31.000000000 -0400=0A=
+++ new-rc2/drivers/scsi/megaraid/mega_common.h	2004-12-02 =
20:23:35.000000000 -0500=0A=
@@ -242,6 +242,15 @@=0A=
 					[SCP2TARGET(scp)] & 0xFF);	\=0A=
 	}=0A=
 =0A=
+/**=0A=
+ * MRAID_LD_TARGET=0A=
+ * @param adp		- Adapter's soft state=0A=
+ * @param ld		- Logical drive number=0A=
+ *=0A=
+ * Macro to retrieve the SCSI target id of a logical drive=0A=
+ */=0A=
+#define MRAID_LD_TARGET(adp, ld) (((ld) < (adp)->init_id) ? (ld) : =
(ld)+1)	=0A=
+=0A=
 /*=0A=
  * ### Helper routines ###=0A=
  */=0A=
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h =
new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h=0A=
--- old-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-02 =
20:20:16.000000000 -0500=0A=
+++ new-rc2/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-02 =
20:23:25.000000000 -0500=0A=
@@ -51,8 +51,11 @@=0A=
 #define MEGAIOC_QNADAP		'm'	/* Query # of adapters		*/=0A=
 #define MEGAIOC_QDRVRVER	'e'	/* Query driver version		*/=0A=
 #define MEGAIOC_QADAPINFO   	'g'	/* Query adapter information	*/=0A=
+#define MEGAIOC_ADD_LD		'a'=0A=
+#define MEGAIOC_DEL_LD		'r'=0A=
 =0A=
 #define USCSICMD		0x80=0A=
+#define UIOC_NONE		0x00000=0A=
 #define UIOC_RD			0x00001=0A=
 #define UIOC_WR			0x00002=0A=
 =0A=
@@ -62,6 +65,8 @@=0A=
 #define GET_ADAP_INFO		0x30000=0A=
 #define GET_CAP			0x40000=0A=
 #define GET_STATS		0x50000=0A=
+#define	ADD_LD			0x60000=0A=
+#define DEL_LD			0x70000=0A=
 #define GET_IOCTL_VERSION	0x01=0A=
 =0A=
 #define EXT_IOCTL_SIGN_SZ	16=0A=
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mbox.c =
new-rc2/drivers/scsi/megaraid/megaraid_mbox.c=0A=
--- old-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-02 =
20:20:16.000000000 -0500=0A=
+++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.c	2004-12-02 =
20:32:33.408278216 -0500=0A=
@@ -10,7 +10,7 @@=0A=
  *	   2 of the License, or (at your option) any later version.=0A=
  *=0A=
  * FILE		: megaraid_mbox.c=0A=
- * Version	: v2.20.4.1 (Nov 04 2004)=0A=
+ * Version	: v2.20.4.1+ TEST VERSION=0A=
  *=0A=
  * Authors:=0A=
  * 	Atul Mukker		<Atul.Mukker@lsil.com>=0A=
@@ -3642,6 +3642,10 @@=0A=
 megaraid_mbox_mm_handler(unsigned long drvr_data, uioc_t *kioc, =
uint32_t action)=0A=
 {=0A=
 	adapter_t *adapter;=0A=
+	uint32_t ld;=0A=
+	struct scsi_device* sdev;=0A=
+	int ch;=0A=
+	int tg;=0A=
 =0A=
 	if (action !=3D IOCTL_ISSUE) {=0A=
 		con_log(CL_ANN, (KERN_WARNING=0A=
@@ -3670,6 +3674,31 @@=0A=
 =0A=
 		return kioc->status;=0A=
 =0A=
+	case ADD_LD:=0A=
+		ld =3D *(uint32_t*) kioc->buf_vaddr;=0A=
+		ch =3D adapter->max_channel;=0A=
+		tg =3D MRAID_LD_TARGET( adapter, ld );=0A=
+		scsi_add_device(adapter->host, ch, tg, 0);=0A=
+=0A=
+		kioc->status =3D 0;=0A=
+		kioc->done(kioc);=0A=
+		return kioc->status;=0A=
+=0A=
+	case DEL_LD:=0A=
+		ld =3D *(uint32_t*) kioc->buf_vaddr;=0A=
+		ch =3D adapter->max_channel;=0A=
+		tg =3D MRAID_LD_TARGET( adapter, ld );=0A=
+		sdev =3D scsi_device_lookup( adapter->host, ch, tg, 0);=0A=
+		=0A=
+		if( sdev ) {=0A=
+			scsi_remove_device( sdev );=0A=
+			scsi_device_put( sdev );=0A=
+		}=0A=
+=0A=
+		kioc->status =3D 0;=0A=
+		kioc->done(kioc);=0A=
+		return kioc->status;=0A=
+=0A=
 	case MBOX_CMD:=0A=
 =0A=
 		return megaraid_mbox_mm_command(adapter, kioc);=0A=
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mbox.h =
new-rc2/drivers/scsi/megaraid/megaraid_mbox.h=0A=
--- old-rc2/drivers/scsi/megaraid/megaraid_mbox.h	2004-12-02 =
20:20:16.000000000 -0500=0A=
+++ new-rc2/drivers/scsi/megaraid/megaraid_mbox.h	2004-12-02 =
20:32:09.737876664 -0500=0A=
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
--- old-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-02 =
20:20:16.000000000 -0500=0A=
+++ new-rc2/drivers/scsi/megaraid/megaraid_mm.c	2004-12-02 =
20:22:57.000000000 -0500=0A=
@@ -373,6 +373,34 @@=0A=
 			if (mraid_mm_attach_buf(adp, kioc, kioc->xferlen))=0A=
 				return (-ENOMEM);=0A=
 		}=0A=
+		else if (subopcode =3D=3D MEGAIOC_ADD_LD) {=0A=
+=0A=
+			kioc->opcode	=3D ADD_LD;=0A=
+			kioc->data_dir	=3D UIOC_NONE;=0A=
+			kioc->xferlen	=3D sizeof(uint32_t);=0A=
+=0A=
+			if (mraid_mm_attach_buf(adp, kioc, kioc->xferlen))=0A=
+				return -(ENOMEM);=0A=
+=0A=
+			if (copy_from_user(kioc->buf_vaddr, mimd.data,=0A=
+							kioc->xferlen)) {=0A=
+				return (-EFAULT);=0A=
+			}=0A=
+		}=0A=
+		else if (subopcode =3D=3D MEGAIOC_DEL_LD) {=0A=
+=0A=
+			kioc->opcode	=3D DEL_LD;=0A=
+			kioc->data_dir	=3D UIOC_NONE;=0A=
+			kioc->xferlen	=3D sizeof(uint32_t);=0A=
+=0A=
+			if (mraid_mm_attach_buf(adp, kioc, kioc->xferlen))=0A=
+				return -(ENOMEM);=0A=
+=0A=
+			if (copy_from_user(kioc->buf_vaddr, mimd.data,=0A=
+							kioc->xferlen)) {=0A=
+				return (-EFAULT);=0A=
+			}=0A=
+		}=0A=
 		else {=0A=
 			con_log(CL_ANN, (KERN_WARNING=0A=
 					"megaraid cmm: Invalid subop\n"));=0A=
@@ -809,6 +837,9 @@=0A=
 =0A=
 			return 0;=0A=
 =0A=
+		case MEGAIOC_ADD_LD:=0A=
+		case MEGAIOC_DEL_LD:=0A=
+			return 0;=0A=
 		default:=0A=
 			return (-EINVAL);=0A=
 		}=0A=
diff -Naur old-rc2/drivers/scsi/megaraid/megaraid_mm.h =
new-rc2/drivers/scsi/megaraid/megaraid_mm.h=0A=
--- old-rc2/drivers/scsi/megaraid/megaraid_mm.h	2004-12-02 =
20:20:16.000000000 -0500=0A=
+++ new-rc2/drivers/scsi/megaraid/megaraid_mm.h	2004-12-02 =
20:33:00.709127856 -0500=0A=
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

------_=_NextPart_000_01C4D8DC.693FF360--
