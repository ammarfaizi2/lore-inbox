Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUBTCGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 21:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267675AbUBTCGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 21:06:21 -0500
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:13331 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S267667AbUBTCGI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 21:06:08 -0500
Subject: [PATCH][BUGFIX] : Megaraid patch for 2.6 2/5
From: Paul Wagland <paul@kungfoocoder.org>
To: Linux SCSI mailing list <linux-scsi@vger.kernel.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, torvalds@osdl.org, James.Bottomley@HansenPartnership.com,
       atulm@lsil.com
Content-Type: multipart/mixed; boundary="=-ARPBelpW9QLdsUC18RF+"
Organization: Kung Foo Coders!
Message-Id: <1077242759.12567.78.camel@morsel.kungfoocoder.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 03:06:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ARPBelpW9QLdsUC18RF+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

On Linux-SCSI over the last few days I have been discussing a couple of
problems with the 2.6.2 megaraid driver. This patch fixes the problem
that the /proc files were being created in the wrong place, the reason
for this is that the /proc/megaraid directory was being created too
late, so it has been moved earlier in the initialisation sequence. There
has been one comment made about the #ifdef CONFIG_PROC_FS not being
needed, but if they are removed then I would also need to remove the
error when we can't create it, since it always "fails" to create a proc
entry when CONFIG_PROC_FS is not set. Please let me know if you would
like this re-submitted.

patch is attached and below.

diff --recursive --ignore-all-space --unified linux-2.6.2.o/drivers/scsi/megaraid.c linux-2.6.2.megaraid/drivers/scsi/megaraid.c
--- linux-2.6.2.o/drivers/scsi/megaraid.c	2004-02-20 01:32:21.000000000 +0100
+++ linux-2.6.2.megaraid/drivers/scsi/megaraid.c	2004-02-20 01:32:26.000000000 +0100
@@ -5119,10 +5119,6 @@
 	if (max_mbox_busy_wait > MBOX_BUSY_WAIT)
 		max_mbox_busy_wait = MBOX_BUSY_WAIT;
 
-	error = pci_module_init(&megaraid_pci_driver);
-	if (error) 
-		return error;
-	
 #ifdef CONFIG_PROC_FS
 	mega_proc_dir_entry = proc_mkdir("megaraid", &proc_root);
 	if (!mega_proc_dir_entry) {
@@ -5130,6 +5126,13 @@
 				"megaraid: failed to create megaraid root\n");
 	}
 #endif
+	error = pci_module_init(&megaraid_pci_driver);
+	if (error) {
+#ifdef CONFIG_PROC_FS
+		remove_proc_entry("megaraid", &proc_root);
+#endif
+		return error;
+	}
 
 	/*
 	 * Register the driver as a character device, for applications


--=-ARPBelpW9QLdsUC18RF+
Content-Disposition: attachment; filename=2-megaraid.init.patch
Content-Type: text/x-patch; name=2-megaraid.init.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --recursive --ignore-all-space --unified linux-2.6.2.o/drivers/scsi/megaraid.c linux-2.6.2.megaraid/drivers/scsi/megaraid.c
--- linux-2.6.2.o/drivers/scsi/megaraid.c	2004-02-20 01:32:21.000000000 +0100
+++ linux-2.6.2.megaraid/drivers/scsi/megaraid.c	2004-02-20 01:32:26.000000000 +0100
@@ -5119,10 +5119,6 @@
 	if (max_mbox_busy_wait > MBOX_BUSY_WAIT)
 		max_mbox_busy_wait = MBOX_BUSY_WAIT;
 
-	error = pci_module_init(&megaraid_pci_driver);
-	if (error) 
-		return error;
-	
 #ifdef CONFIG_PROC_FS
 	mega_proc_dir_entry = proc_mkdir("megaraid", &proc_root);
 	if (!mega_proc_dir_entry) {
@@ -5130,6 +5126,13 @@
 				"megaraid: failed to create megaraid root\n");
 	}
 #endif
+	error = pci_module_init(&megaraid_pci_driver);
+	if (error) {
+#ifdef CONFIG_PROC_FS
+		remove_proc_entry("megaraid", &proc_root);
+#endif
+		return error;
+	}
 
 	/*
 	 * Register the driver as a character device, for applications

--=-ARPBelpW9QLdsUC18RF+--

