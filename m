Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbULJSJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbULJSJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 13:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbULJSJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 13:09:54 -0500
Received: from mail0.lsil.com ([147.145.40.20]:28403 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261779AbULJSHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 13:07:49 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CAA5@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>
Cc: Matt Domsch <Matt_Domsch@Dell.com>,
       "'brking@us.ibm.com'" <brking@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: [PATCH 1/2] RE: How to add/drop SCSI drives from within the d
	rive r?
Date: Fri, 10 Dec 2004 12:59:57 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4DEE2.0F286FE0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4DEE2.0F286FE0
Content-Type: text/plain

>
>This patch won't apply --- it looks like your mailer broke the lines.
>Could you resend it?
>
>Thanks,
>
>James
>

diff -Naur a/Documentation/scsi/ChangeLog.megaraid
b/Documentation/scsi/ChangeLog.megaraid
--- a/Documentation/scsi/ChangeLog.megaraid	2004-12-07
16:40:23.000000000 -0500
+++ b/Documentation/scsi/ChangeLog.megaraid	2004-12-09
19:05:47.795231320 -0500
@@ -1,3 +1,10 @@
+Release Date	: Thu Dec  9 19:02:14 EST 2004 - Sreenivas Bagalkote
<sreenib@lsil.com>
+
+Current Version	: 2.20.4.1 (scsi module), 2.20.2.3 (cmm module)
+Older Version	: 2.20.4.1 (scsi module), 2.20.2.2 (cmm module)
+
+i.	Fix a bug in kioc's dma buffer deallocation
+
 Release Date	: Thu Nov  4 18:24:56 EST 2004 - Sreenivas Bagalkote
<sreenib@lsil.com>
 
 Current Version	: 2.20.4.1 (scsi module), 2.20.2.2 (cmm module)
diff -Naur a/drivers/scsi/megaraid/megaraid_ioctl.h
b/drivers/scsi/megaraid/megaraid_ioctl.h
--- a/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-07
16:40:16.000000000 -0500
+++ b/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-09
19:00:59.284091680 -0500
@@ -142,7 +142,7 @@
 
 	caddr_t			buf_vaddr;
 	dma_addr_t		buf_paddr;
-	uint8_t			pool_index;
+	int8_t			pool_index;
 	uint8_t			free_buf;
 
 	uint8_t			timedout;
diff -Naur a/drivers/scsi/megaraid/megaraid_mm.c
b/drivers/scsi/megaraid/megaraid_mm.c
--- a/drivers/scsi/megaraid/megaraid_mm.c	2004-12-07
16:40:16.000000000 -0500
+++ b/drivers/scsi/megaraid/megaraid_mm.c	2004-12-09
19:03:27.659535184 -0500
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mm.c
- * Version	: v2.20.2.2 (Nov 04 2004)
+ * Version	: v2.20.2.3 (Dec 09 2004)
  *
  * Common management module
  */
@@ -614,23 +614,27 @@
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
diff -Naur a/drivers/scsi/megaraid/megaraid_mm.h
b/drivers/scsi/megaraid/megaraid_mm.h
--- a/drivers/scsi/megaraid/megaraid_mm.h	2004-12-07
16:40:15.000000000 -0500
+++ b/drivers/scsi/megaraid/megaraid_mm.h	2004-12-09
19:03:00.020736920 -0500
@@ -29,10 +29,9 @@
 #include "megaraid_ioctl.h"
 
 
-#define LSI_COMMON_MOD_VERSION	"2.20.2.2"
+#define LSI_COMMON_MOD_VERSION	"2.20.2.3"
 #define LSI_COMMON_MOD_EXT_VERSION	\
-		"(Release Date: Thu Nov  4 17:46:29 EST 2004)"
-
+		"(Release Date: Thu Dec  9 19:02:14 EST 2004)"
 
 #define LSI_DBGLVL			dbglevel
 


------_=_NextPart_000_01C4DEE2.0F286FE0
Content-Type: application/octet-stream;
	name="megaraid-kioc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="megaraid-kioc.patch"

diff -Naur a/Documentation/scsi/ChangeLog.megaraid =
b/Documentation/scsi/ChangeLog.megaraid=0A=
--- a/Documentation/scsi/ChangeLog.megaraid	2004-12-07 =
16:40:23.000000000 -0500=0A=
+++ b/Documentation/scsi/ChangeLog.megaraid	2004-12-09 =
19:05:47.795231320 -0500=0A=
@@ -1,3 +1,10 @@=0A=
+Release Date	: Thu Dec  9 19:02:14 EST 2004 - Sreenivas Bagalkote =
<sreenib@lsil.com>=0A=
+=0A=
+Current Version	: 2.20.4.1 (scsi module), 2.20.2.3 (cmm module)=0A=
+Older Version	: 2.20.4.1 (scsi module), 2.20.2.2 (cmm module)=0A=
+=0A=
+i.	Fix a bug in kioc's dma buffer deallocation=0A=
+=0A=
 Release Date	: Thu Nov  4 18:24:56 EST 2004 - Sreenivas Bagalkote =
<sreenib@lsil.com>=0A=
 =0A=
 Current Version	: 2.20.4.1 (scsi module), 2.20.2.2 (cmm module)=0A=
diff -Naur a/drivers/scsi/megaraid/megaraid_ioctl.h =
b/drivers/scsi/megaraid/megaraid_ioctl.h=0A=
--- a/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-07 =
16:40:16.000000000 -0500=0A=
+++ b/drivers/scsi/megaraid/megaraid_ioctl.h	2004-12-09 =
19:00:59.284091680 -0500=0A=
@@ -142,7 +142,7 @@=0A=
 =0A=
 	caddr_t			buf_vaddr;=0A=
 	dma_addr_t		buf_paddr;=0A=
-	uint8_t			pool_index;=0A=
+	int8_t			pool_index;=0A=
 	uint8_t			free_buf;=0A=
 =0A=
 	uint8_t			timedout;=0A=
diff -Naur a/drivers/scsi/megaraid/megaraid_mm.c =
b/drivers/scsi/megaraid/megaraid_mm.c=0A=
--- a/drivers/scsi/megaraid/megaraid_mm.c	2004-12-07 16:40:16.000000000 =
-0500=0A=
+++ b/drivers/scsi/megaraid/megaraid_mm.c	2004-12-09 19:03:27.659535184 =
-0500=0A=
@@ -10,7 +10,7 @@=0A=
  *	   2 of the License, or (at your option) any later version.=0A=
  *=0A=
  * FILE		: megaraid_mm.c=0A=
- * Version	: v2.20.2.2 (Nov 04 2004)=0A=
+ * Version	: v2.20.2.3 (Dec 09 2004)=0A=
  *=0A=
  * Common management module=0A=
  */=0A=
@@ -614,23 +614,27 @@=0A=
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
diff -Naur a/drivers/scsi/megaraid/megaraid_mm.h =
b/drivers/scsi/megaraid/megaraid_mm.h=0A=
--- a/drivers/scsi/megaraid/megaraid_mm.h	2004-12-07 16:40:15.000000000 =
-0500=0A=
+++ b/drivers/scsi/megaraid/megaraid_mm.h	2004-12-09 19:03:00.020736920 =
-0500=0A=
@@ -29,10 +29,9 @@=0A=
 #include "megaraid_ioctl.h"=0A=
 =0A=
 =0A=
-#define LSI_COMMON_MOD_VERSION	"2.20.2.2"=0A=
+#define LSI_COMMON_MOD_VERSION	"2.20.2.3"=0A=
 #define LSI_COMMON_MOD_EXT_VERSION	\=0A=
-		"(Release Date: Thu Nov  4 17:46:29 EST 2004)"=0A=
-=0A=
+		"(Release Date: Thu Dec  9 19:02:14 EST 2004)"=0A=
 =0A=
 #define LSI_DBGLVL			dbglevel=0A=
 =0A=

------_=_NextPart_000_01C4DEE2.0F286FE0--
