Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUBCTxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266091AbUBCTxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:53:37 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:34321 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266085AbUBCTxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 14:53:25 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Date: Tue, 3 Feb 2004 22:48:40 +0300
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] rc3-mm1 - /proc/ide/HWIF for modular IDE
Message-ID: <20040203194840.GD3249@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

currently /proc/ide/HWIF are created in one shot during initialization
or in ide-generic meaning that for modular IDE you must include
ide-generic.

this adds per-hwif registration currently for PCI only (that is what I
can test); if this is OK I will make create_proc_ide_interfaces static
and replace it with create_proc_ide_interface where appropriate.

this also makes /proc/ide entries for PCI chipset be correctly created

-andrey

--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.2-rc3-mm1-modular_proc_ide.patch"

--- linux-2.6.2-rc3-mm1/drivers/ide/ide-proc.c.modular	2004-02-03 20:37:32.000000000 +0300
+++ linux-2.6.2-rc3-mm1/drivers/ide/ide-proc.c	2004-02-03 21:13:38.000000000 +0300
@@ -768,23 +768,27 @@ static ide_proc_entry_t hwif_entries[] =
 	{ NULL,	0, NULL, NULL }
 };
 
+void create_proc_ide_interface(ide_hwif_t *hwif)
+{
+	if (!hwif->present)
+		return;
+	if (!hwif->proc) {
+		hwif->proc = proc_mkdir(hwif->name, proc_ide_root);
+		if (!hwif->proc)
+			return;
+		ide_add_proc_entries(hwif->proc, hwif_entries, hwif);
+	}
+	create_proc_ide_drives(hwif);
+}
+
+EXPORT_SYMBOL(create_proc_ide_interface);
+
 void create_proc_ide_interfaces(void)
 {
 	int	h;
 
-	for (h = 0; h < MAX_HWIFS; h++) {
-		ide_hwif_t *hwif = &ide_hwifs[h];
-
-		if (!hwif->present)
-			continue;
-		if (!hwif->proc) {
-			hwif->proc = proc_mkdir(hwif->name, proc_ide_root);
-			if (!hwif->proc)
-				return;
-			ide_add_proc_entries(hwif->proc, hwif_entries, hwif);
-		}
-		create_proc_ide_drives(hwif);
-	}
+	for (h = 0; h < MAX_HWIFS; h++)
+		create_proc_ide_interface(&ide_hwifs[h]);
 }
 
 #ifdef CONFIG_BLK_DEV_IDEPCI
@@ -801,6 +805,12 @@ void ide_pci_register_host_proc (ide_pci
 		tmp->next = p;
 	} else
 		ide_pci_host_proc_list = p;
+
+	if (proc_ide_root) {
+		p->parent = proc_ide_root;
+		create_proc_info_entry(p->name, 0, p->parent, p->get_info);
+		p->set = 2;
+	}
 }
 
 EXPORT_SYMBOL(ide_pci_register_host_proc);
--- linux-2.6.2-rc3-mm1/drivers/ide/setup-pci.c.modular	2004-02-03 20:37:33.000000000 +0300
+++ linux-2.6.2-rc3-mm1/drivers/ide/setup-pci.c	2004-02-03 21:11:22.000000000 +0300
@@ -659,6 +659,10 @@ bypass_legacy_dma:
 			 */
 			d->init_hwif(hwif);
 
+#ifdef CONFIG_PROC_FS
+		create_proc_ide_interface(hwif);
+#endif
+
 		mate = hwif;
 		at_least_one_hwif_enabled = 1;
 	}
--- linux-2.6.2-rc3-mm1/include/linux/ide.h.modular	2004-02-03 20:38:06.000000000 +0300
+++ linux-2.6.2-rc3-mm1/include/linux/ide.h	2004-02-03 21:15:33.000000000 +0300
@@ -1117,6 +1117,7 @@ extern void proc_ide_create(void);
 extern void proc_ide_destroy(void);
 extern void destroy_proc_ide_device(ide_hwif_t *, ide_drive_t *);
 extern void destroy_proc_ide_drives(ide_hwif_t *);
+extern void create_proc_ide_interface(ide_hwif_t *);
 extern void create_proc_ide_interfaces(void);
 extern void ide_add_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *, void *);
 extern void ide_remove_proc_entries(struct proc_dir_entry *, ide_proc_entry_t *);

--96YOpH+ONegL0A3E--
