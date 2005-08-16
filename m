Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbVHPO02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbVHPO02 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 10:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbVHPO01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 10:26:27 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:409 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965249AbVHPO00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 10:26:26 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13-rc6] remove 2.4 compat code from cpqfcTS driver, take 2
Date: Tue, 16 Aug 2005 16:28:07 +0200
User-Agent: KMail/1.8.2
Cc: linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bolke de Bruin <bdbruin@aub.nl>
References: <200508051202.07091@bilbo.math.uni-mannheim.de> <200508161111.35431@bilbo.math.uni-mannheim.de> <200508161112.47120@bilbo.math.uni-mannheim.de>
In-Reply-To: <200508161112.47120@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508161628.09474@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove compat code for Linux 2.4 and earlier. Fixed bug in earlier version
that caused compile error.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- a/drivers/scsi/cpqfcTScontrol.c	2005-08-13 19:00:35.000000000 +0200
+++ b/drivers/scsi/cpqfcTScontrol.c	2005-08-14 11:02:09.000000000 +0200
@@ -28,8 +28,6 @@
    Hewlitt Packard Manual Part Number 5968-1083E.
 */
 
-#define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
-
 #include <linux/blkdev.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
--- a/drivers/scsi/cpqfcTSstructs.h	2005-08-14 11:11:52.000000000 +0200
+++ b/drivers/scsi/cpqfcTSstructs.h	2005-08-14 11:12:54.000000000 +0200
@@ -88,7 +88,6 @@
 #define CPQFCTS_CMD_PER_LUN 15 // power of 2 -1, must be >0 
 #define CPQFCTS_REQ_QUEUE_LEN (TACH_SEST_LEN/2) // must be < TACH_SEST_LEN
 
-#define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
 #ifndef DECLARE_MUTEX_LOCKED
 #define DECLARE_MUTEX_LOCKED(sem) struct semaphore sem = MUTEX_LOCKED
 #endif
--- a/drivers/scsi/cpqfcTSinit.c	2005-08-14 14:56:41.000000000 +0200
+++ b/drivers/scsi/cpqfcTSinit.c	2005-08-14 14:57:27.000000000 +0200
@@ -29,8 +29,6 @@
 */
 
 
-#define LinuxVersionCode(v, p, s) (((v)<<16)+((p)<<8)+(s))
-
 #include <linux/config.h>  
 #include <linux/interrupt.h>  
 #include <linux/module.h>
@@ -72,31 +70,10 @@ int cpqfcTS_TargetDeviceReset( Scsi_Devi
 // few fields...
 // NOTE: proc_fs changes in 2.4 kernel
 
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,3,27)
-static struct proc_dir_entry proc_scsi_cpqfcTS =
-{
-  PROC_SCSI_CPQFCTS,           // ushort low_ino (enumerated list)
-  7,                           // ushort namelen
-  DEV_NAME,                    // const char* name
-  S_IFDIR | S_IRUGO | S_IXUGO, // mode_t mode
-  2                            // nlink_t nlink
-	                       // etc. ...
-};
-
-
-#endif
-
-#if LINUX_VERSION_CODE >= LinuxVersionCode(2,4,7)
-#  define CPQFC_DECLARE_COMPLETION(x) DECLARE_COMPLETION(x)
-#  define CPQFC_WAITING waiting
-#  define CPQFC_COMPLETE(x) complete(x)
-#  define CPQFC_WAIT_FOR_COMPLETION(x) wait_for_completion(x);
-#else
-#  define CPQFC_DECLARE_COMPLETION(x) DECLARE_MUTEX_LOCKED(x)
-#  define CPQFC_WAITING sem
-#  define CPQFC_COMPLETE(x) up(x)
-#  define CPQFC_WAIT_FOR_COMPLETION(x) down(x)
-#endif
+#define CPQFC_DECLARE_COMPLETION(x) DECLARE_COMPLETION(x)
+#define CPQFC_WAITING waiting
+#define CPQFC_COMPLETE(x) complete(x)
+#define CPQFC_WAIT_FOR_COMPLETION(x) wait_for_completion(x);
 
 static int cpqfc_alloc_private_data_pool(CPQFCHBA *hba);
 
@@ -284,12 +261,6 @@ int cpqfcTS_detect(Scsi_Host_Template *S
 
   ENTER("cpqfcTS_detect");
 
-#if LINUX_VERSION_CODE < LinuxVersionCode(2,3,27)
-  ScsiHostTemplate->proc_dir = &proc_scsi_cpqfcTS;
-#else
-  ScsiHostTemplate->proc_name = "cpqfcTS";
-#endif
-
   for(i = 0; cpqfc_boards[i]; i++) {
     while((PciDev = pci_get_device(cpqfc_boards[i].vendor,
 				    cpqfc_boards[i].device, PciDev))) {
@@ -2059,6 +2030,7 @@ void* fcMemManager( struct pci_dev *pdev
 
 
 static Scsi_Host_Template driver_template = {
+	.proc_name              = DEV_NAME,
 	.detect                 = cpqfcTS_detect,
 	.release                = cpqfcTS_release,
 	.info                   = cpqfcTS_info,
