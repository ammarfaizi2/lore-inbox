Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271139AbUJVBsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271139AbUJVBsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271168AbUJVBoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:44:11 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:391 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S271119AbUJVBmw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:42:52 -0400
Message-ID: <4178659B.4020303@rtr.ca>
Date: Thu, 21 Oct 2004 21:42:51 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [patch 2.6.9-ac3] ide: fixes for 2.6.9-ac3 ide issues
References: <1098400086.18025.0.camel@localhost.localdomain> <41785B65.4090202@rtr.ca>
In-Reply-To: <41785B65.4090202@rtr.ca>
Content-Type: multipart/mixed;
 boundary="------------010001010700020407040502"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010001010700020407040502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch fixes two problems with 2.6.9-ac3:

1. restores the missing spin_unlock_irq() line, and
2. removes hwif from /proc/ide/ as part of __ide_unregister_hwif().

(and also removes a bogus compiler warning)

Signed-off-by: Mark Lord <lkml@rtr.ca>
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")

--------------010001010700020407040502
Content-Type: text/plain;
 name="ac3-ide-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac3-ide-fixes.patch"

diff -u --recursive --new-file --exclude='.*' linux-2.6.9-ac3/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.6.9-ac3/drivers/ide/ide.c	2004-10-21 20:45:22.000000000 -0400
+++ linux/drivers/ide/ide.c	2004-10-21 21:28:54.000000000 -0400
@@ -862,7 +862,7 @@
 
 int __ide_unregister_hwif(ide_hwif_t *hwif)
 {
-	ide_drive_t *drive;
+	ide_drive_t *drive = NULL; /* keep compiler happy */
 	ide_hwif_t *g;
 	static ide_hwif_t tmp_hwif; /* protected by ide_cfg_sem */
 	ide_hwgroup_t *hwgroup;
@@ -901,6 +901,7 @@
 	was_present = hwif->present;	 
 	hwif->present = 0;
 
+	spin_unlock_irq(&ide_lock);
 	up(&ide_setting_sem);
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
@@ -912,6 +913,7 @@
 
 #ifdef CONFIG_PROC_FS
 	destroy_proc_ide_drives(hwif);
+	destroy_proc_ide_interface(hwif);
 #endif
 
 	spin_lock_irq(&ide_lock);
diff -u --recursive --new-file --exclude='.*' linux-2.6.9-ac3/drivers/ide/ide-proc.c linux/drivers/ide/ide-proc.c
--- linux-2.6.9-ac3/drivers/ide/ide-proc.c	2004-10-21 20:45:22.000000000 -0400
+++ linux/drivers/ide/ide-proc.c	2004-10-21 21:25:06.000000000 -0400
@@ -821,24 +821,30 @@
 EXPORT_SYMBOL_GPL(ide_pci_create_host_proc);
 #endif
 
+void destroy_proc_ide_interface(ide_hwif_t *hwif)
+{
+	int exist = (hwif->proc != NULL);
+#if 0
+	if (!hwif->present)
+		continue;
+#endif
+	if (exist) {
+		destroy_proc_ide_drives(hwif);
+		ide_remove_proc_entries(hwif->proc, hwif_entries);
+		remove_proc_entry(hwif->name, proc_ide_root);
+		hwif->proc = NULL;
+	}
+}
+
+EXPORT_SYMBOL(destroy_proc_ide_interface);
+
 void destroy_proc_ide_interfaces(void)
 {
 	int	h;
 
 	for (h = 0; h < MAX_HWIFS; h++) {
 		ide_hwif_t *hwif = &ide_hwifs[h];
-		int exist = (hwif->proc != NULL);
-#if 0
-		if (!hwif->present)
-			continue;
-#endif
-		if (exist) {
-			destroy_proc_ide_drives(hwif);
-			ide_remove_proc_entries(hwif->proc, hwif_entries);
-			remove_proc_entry(hwif->name, proc_ide_root);
-			hwif->proc = NULL;
-		} else
-			continue;
+		destroy_proc_ide_interface(hwif);
 	}
 }
 
diff -u --recursive --new-file --exclude='.*' linux-2.6.9-ac3/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.6.9-ac3/include/linux/ide.h	2004-10-21 20:45:22.000000000 -0400
+++ linux/include/linux/ide.h	2004-10-21 21:27:39.000000000 -0400
@@ -1076,6 +1076,7 @@
 extern void proc_ide_create(void);
 extern void proc_ide_destroy(void);
 extern void destroy_proc_ide_drives(ide_hwif_t *);
+extern void destroy_proc_ide_interface(ide_hwif_t *);
 extern void create_proc_ide_interfaces(void);
 extern void ide_add_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *, void *);
 extern void ide_remove_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *);

--------------010001010700020407040502--
