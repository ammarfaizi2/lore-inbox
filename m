Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283121AbRK2JX7>; Thu, 29 Nov 2001 04:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283120AbRK2JXt>; Thu, 29 Nov 2001 04:23:49 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:48629 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S283118AbRK2JXa>;
	Thu, 29 Nov 2001 04:23:30 -0500
Date: Thu, 29 Nov 2001 02:23:18 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI cleanup
Message-ID: <20011129022318.A29249@lynx.no>
Mail-Followup-To: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
the following patch fixes the ACPI busmgr code to not leave straggling
files in /proc/acpi if it fails to initialize properly in bm_osl_init().

This was a problem I noticed with the 2.4.9 kernel that causes an oops,
which was "glossed over" by calling the acpi_subsystem_status() function
in later kernels.  This will see if the ACPI subsystem even exists,
but doesn't really solve the underlying problem - bm_initialize() can
fail, and if it does it doesn't remove the files it created in /proc.

A couple of other minor cleanups:
1) don't return AE_ERROR instead of a valid error return code to userspace.
2) call bm_terminate() after removing the /proc entries, so that it is not
   possible to open one of these files after the ACPI code has shut down
   (I don't know if this is actually a problem, but just to be safe).

It should apply cleanly to all current kernels.

Cheers, Andreas
======================= acpi-2.4.15-busmgr.diff ============================
diff -ru linux-2.4.15.orig/drivers/acpi/ospm/busmgr/bm_osl.c linux-2.4.15-aed/drivers/acpi/ospm/busmgr/bm_osl.c
--- linux-2.4.15.orig/drivers/acpi/ospm/busmgr/bm_osl.c	Thu Nov 15 13:07:16 2001
+++ linux-2.4.15-aed/drivers/acpi/ospm/busmgr/bm_osl.c	Thu Nov 29 00:03:26 2001
@@ -297,7 +297,7 @@
 int
 bm_osl_init(void)
 {
-	acpi_status		status = AE_OK;
+	acpi_status		status;
 
 	status = acpi_subsystem_status();
 	if (ACPI_FAILURE(status))
@@ -305,7 +305,14 @@
 
 	bm_proc_root = proc_mkdir(BM_PROC_ROOT, NULL);
 	if (!bm_proc_root) {
-		return(AE_ERROR);
+		return(-ENOMEM);
+	}
+
+	status = bm_initialize();
+	if (ACPI_FAILURE(status)) {
+		remove_proc_entry(BM_PROC_ROOT, NULL);
+		bm_proc_root = NULL;
+		return(-ENODEV);
 	}
 
 	bm_proc_event = create_proc_entry(BM_PROC_EVENT, S_IRUSR, bm_proc_root);
@@ -313,9 +320,7 @@
 		bm_proc_event->proc_fops = &proc_event_operations;
 	}
 
-	status = bm_initialize();
-
-	return (ACPI_SUCCESS(status)) ? 0 : -ENODEV;
+	return 0;
 }
 
 
@@ -328,8 +333,6 @@
 void
 bm_osl_cleanup(void)
 {
-	bm_terminate();
-
 	if (bm_proc_event) {
 		remove_proc_entry(BM_PROC_EVENT, bm_proc_root);
 		bm_proc_event = NULL;
@@ -339,6 +342,8 @@
 		remove_proc_entry(BM_PROC_ROOT, NULL);
 		bm_proc_root = NULL;
 	}
+
+	bm_terminate();
 
 	return;
 }
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

