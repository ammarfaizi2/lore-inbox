Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUI2BjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUI2BjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 21:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268145AbUI2BjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 21:39:08 -0400
Received: from mail0.lsil.com ([147.145.40.20]:8606 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S268142AbUI2Biz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 21:38:55 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230C969@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: bunk@fs.tum.de, "Mukker, Atul" <Atulm@lsil.com>,
       "'Andrew Morton'" <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>
Subject: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
Date: Tue, 28 Sep 2004 21:31:02 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Change Log:

Fixes a data corruption issue. Because of a typo in the driver, IO packets
were wrongly shared by the IOCTL path. This caused the whole IO command
to be replaced by an incoming IOCTL command.

This patch (generated against 2.6.9-rc2) is inlined below.

Sreenivas

---
diff -Naur linux-2.6.9-rc2-mrbug/Documentation/scsi/ChangeLog.megaraid
linux-2.6.9-rc2-fixed/Documentation/scsi/ChangeLog.megaraid
--- linux-2.6.9-rc2-mrbug/Documentation/scsi/ChangeLog.megaraid	2004-09-28
17:31:10.000000000 -0400
+++ linux-2.6.9-rc2-fixed/Documentation/scsi/ChangeLog.megaraid	2004-09-28
17:43:50.000000000 -0400
@@ -1,3 +1,11 @@
+Release Date	: Mon Sep 27 22:15:07 EDT 2004 - Atul Mukker
<atulm@lsil.com>
+Current Version	: 2.20.4.0 (scsi module), 2.20.2.0 (cmm module)
+Older Version	: 2.20.3.1 (scsi module), 2.20.2.0 (cmm module)
+
+i.	Fix data corruption. Because of a typo in the driver, the IO packets
+	were wrongly shared by the ioctl path. This causes a whole IO
command
+	to be replaced by an incoming ioctl command.
+
 Release Date	: Tue Aug 24 09:43:35 EDT 2004 - Atul Mukker
<atulm@lsil.com>
 Current Version	: 2.20.3.1 (scsi module), 2.20.2.0 (cmm module)
 Older Version	: 2.20.3.0 (scsi module), 2.20.2.0 (cmm module)
diff -Naur linux-2.6.9-rc2-mrbug/drivers/scsi/megaraid/megaraid_mbox.c
linux-2.6.9-rc2-fixed/drivers/scsi/megaraid/megaraid_mbox.c
--- linux-2.6.9-rc2-mrbug/drivers/scsi/megaraid/megaraid_mbox.c	2004-09-28
17:31:33.000000000 -0400
+++ linux-2.6.9-rc2-fixed/drivers/scsi/megaraid/megaraid_mbox.c	2004-09-28
17:43:50.000000000 -0400
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mbox.c
- * Version	: v2.20.3.1 (August 24 2004)
+ * Version	: v2.20.4 (September 27 2004)
  *
  * Authors:
  * 	Atul Mukker		<Atul.Mukker@lsil.com>
@@ -197,7 +197,7 @@
  * ### global data ###
  */
 static uint8_t megaraid_mbox_version[8] =
-	{ 0x02, 0x20, 0x02, 0x00, 7, 22, 20, 4 };
+	{ 0x02, 0x20, 0x04, 0x00, 9, 27, 20, 4 };
 
 
 /*
@@ -3562,7 +3562,7 @@
 	for (i = 0; i < MBOX_MAX_USER_CMDS; i++) {
 
 		scb			= adapter->uscb_list + i;
-		ccb			= raid_dev->ccb_list + i;
+		ccb			= raid_dev->uccb_list + i;
 
 		scb->ccb		= (caddr_t)ccb;
 		ccb->mbox64		= raid_dev->umbox64 + i;
diff -Naur linux-2.6.9-rc2-mrbug/drivers/scsi/megaraid/megaraid_mbox.h
linux-2.6.9-rc2-fixed/drivers/scsi/megaraid/megaraid_mbox.h
--- linux-2.6.9-rc2-mrbug/drivers/scsi/megaraid/megaraid_mbox.h	2004-09-28
17:31:33.000000000 -0400
+++ linux-2.6.9-rc2-fixed/drivers/scsi/megaraid/megaraid_mbox.h	2004-09-28
17:43:50.000000000 -0400
@@ -21,8 +21,8 @@
 #include "megaraid_ioctl.h"
 
 
-#define MEGARAID_VERSION	"2.20.3.1"
-#define MEGARAID_EXT_VERSION	"(Release Date: Tue Aug 24 09:43:35 EDT
2004)"
+#define MEGARAID_VERSION	"2.20.4.0"
+#define MEGARAID_EXT_VERSION	"(Release Date: Mon Sep 27 22:15:07 EDT
2004)"
 
 
 /*
---
