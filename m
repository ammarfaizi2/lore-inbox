Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267328AbUBSPDn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 10:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUBSPCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 10:02:51 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58340 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267304AbUBSOzl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:55:41 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.3 (9/9)
Date: Thu, 19 Feb 2004 16:00:22 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191600.22350.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] fix /proc/ide/<chipset> for IDE PCI modules

Make IDE PCI drivers register /proc/ide/<chipset> entries themselves.

 linux-2.6.3-root/drivers/ide/ide-proc.c         |   63 +++---------------------
 linux-2.6.3-root/drivers/ide/ide.c              |    6 ++
 linux-2.6.3-root/drivers/ide/pci/aec62xx.c      |    2 
 linux-2.6.3-root/drivers/ide/pci/aec62xx.h      |   18 ------
 linux-2.6.3-root/drivers/ide/pci/alim15x3.c     |    2 
 linux-2.6.3-root/drivers/ide/pci/alim15x3.h     |   18 ------
 linux-2.6.3-root/drivers/ide/pci/amd74xx.c      |    4 +
 linux-2.6.3-root/drivers/ide/pci/amd74xx.h      |   18 ------
 linux-2.6.3-root/drivers/ide/pci/cmd64x.c       |    2 
 linux-2.6.3-root/drivers/ide/pci/cmd64x.h       |   19 -------
 linux-2.6.3-root/drivers/ide/pci/cs5520.c       |    2 
 linux-2.6.3-root/drivers/ide/pci/cs5520.h       |   18 ------
 linux-2.6.3-root/drivers/ide/pci/cs5530.c       |    2 
 linux-2.6.3-root/drivers/ide/pci/cs5530.h       |   18 ------
 linux-2.6.3-root/drivers/ide/pci/hpt34x.c       |    2 
 linux-2.6.3-root/drivers/ide/pci/hpt34x.h       |   18 ------
 linux-2.6.3-root/drivers/ide/pci/hpt366.c       |    2 
 linux-2.6.3-root/drivers/ide/pci/hpt366.h       |   18 ------
 linux-2.6.3-root/drivers/ide/pci/pdc202xx_new.c |    2 
 linux-2.6.3-root/drivers/ide/pci/pdc202xx_new.h |   19 -------
 linux-2.6.3-root/drivers/ide/pci/pdc202xx_old.c |    2 
 linux-2.6.3-root/drivers/ide/pci/pdc202xx_old.h |   19 -------
 linux-2.6.3-root/drivers/ide/pci/piix.c         |    2 
 linux-2.6.3-root/drivers/ide/pci/piix.h         |   18 ------
 linux-2.6.3-root/drivers/ide/pci/sc1200.c       |    2 
 linux-2.6.3-root/drivers/ide/pci/sc1200.h       |   18 ------
 linux-2.6.3-root/drivers/ide/pci/serverworks.c  |    2 
 linux-2.6.3-root/drivers/ide/pci/serverworks.h  |   18 ------
 linux-2.6.3-root/drivers/ide/pci/siimage.c      |    2 
 linux-2.6.3-root/drivers/ide/pci/siimage.h      |   20 -------
 linux-2.6.3-root/drivers/ide/pci/sis5513.c      |    2 
 linux-2.6.3-root/drivers/ide/pci/sis5513.h      |   18 ------
 linux-2.6.3-root/drivers/ide/pci/slc90e66.c     |    2 
 linux-2.6.3-root/drivers/ide/pci/slc90e66.h     |   18 ------
 linux-2.6.3-root/drivers/ide/pci/triflex.c      |    2 
 linux-2.6.3-root/drivers/ide/pci/triflex.h      |    9 ---
 linux-2.6.3-root/drivers/ide/pci/via82cxxx.c    |    2 
 linux-2.6.3-root/drivers/ide/pci/via82cxxx.h    |   18 ------
 linux-2.6.3-root/include/linux/ide.h            |   18 ++----
 39 files changed, 41 insertions(+), 404 deletions(-)

diff -puN drivers/ide/ide.c~ide_pci_proc_fix drivers/ide/ide.c
--- linux-2.6.3/drivers/ide/ide.c~ide_pci_proc_fix	2004-02-19 02:14:51.149195736 +0100
+++ linux-2.6.3-root/drivers/ide/ide.c	2004-02-19 02:14:51.303172328 +0100
@@ -474,6 +474,8 @@ struct seq_operations ide_drivers_op = {
 };
 
 #ifdef CONFIG_PROC_FS
+struct proc_dir_entry *proc_ide_root;
+
 ide_proc_entry_t generic_subdriver_entries[] = {
 	{ "capacity",	S_IFREG|S_IRUGO,	proc_ide_read_capacity,	NULL },
 	{ NULL, 0, NULL, NULL }
@@ -2402,6 +2404,10 @@ int __init ide_init (void)
 
 	init_ide_data();
 
+#ifdef CONFIG_PROC_FS
+	proc_ide_root = proc_mkdir("ide", 0);
+#endif
+
 #ifdef CONFIG_BLK_DEV_ALI14XX
 	if (probe_ali14xx)
 		(void)ali14xx_init();
diff -puN drivers/ide/ide-proc.c~ide_pci_proc_fix drivers/ide/ide-proc.c
--- linux-2.6.3/drivers/ide/ide-proc.c~ide_pci_proc_fix	2004-02-19 02:14:51.154194976 +0100
+++ linux-2.6.3-root/drivers/ide/ide-proc.c	2004-02-19 02:14:51.305172024 +0100
@@ -109,17 +109,6 @@ static int xx_xx_parse_error (const char
 	return -EINVAL;
 }
 
-static struct proc_dir_entry * proc_ide_root = NULL;
-
-#ifdef CONFIG_BLK_DEV_IDEPCI
-#include <linux/delay.h>
-/*
- * This is the list of registered PCI chipset driver data structures.
- */
-static ide_pci_host_proc_t * ide_pci_host_proc_list;
-
-#endif /* CONFIG_BLK_DEV_IDEPCI */
-
 static int proc_ide_write_config
 	(struct file *file, const char *buffer, unsigned long count, void *data)
 {
@@ -787,27 +776,16 @@ void create_proc_ide_interfaces(void)
 	}
 }
 
+EXPORT_SYMBOL(create_proc_ide_interfaces);
+
 #ifdef CONFIG_BLK_DEV_IDEPCI
-void ide_pci_register_host_proc (ide_pci_host_proc_t *p)
+void ide_pci_create_host_proc(const char *name, get_info_t *get_info)
 {
-	ide_pci_host_proc_t *tmp;
-
-	if (!p) return;
-	p->next = NULL;
-	p->set = 1;
-	if (ide_pci_host_proc_list) {
-		tmp = ide_pci_host_proc_list;
-		while (tmp->next) tmp = tmp->next;
-		tmp->next = p;
-	} else
-		ide_pci_host_proc_list = p;
+	create_proc_info_entry(name, 0, proc_ide_root, get_info);
 }
 
-EXPORT_SYMBOL(ide_pci_register_host_proc);
-
-#endif /* CONFIG_BLK_DEV_IDEPCI */
-
-EXPORT_SYMBOL(create_proc_ide_interfaces);
+EXPORT_SYMBOL_GPL(ide_pci_create_host_proc);
+#endif
 
 void destroy_proc_ide_interfaces(void)
 {
@@ -846,45 +824,22 @@ static struct file_operations ide_driver
 
 void proc_ide_create(void)
 {
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	ide_pci_host_proc_t *p = ide_pci_host_proc_list;
-#endif /* CONFIG_BLK_DEV_IDEPCI */
 	struct proc_dir_entry *entry;
-	proc_ide_root = proc_mkdir("ide", 0);
-	if (!proc_ide_root) return;
+
+	if (!proc_ide_root)
+		return;
 
 	create_proc_ide_interfaces();
 
 	entry = create_proc_entry("drivers", 0, proc_ide_root);
 	if (entry)
 		entry->proc_fops = &ide_drivers_operations;
-
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	while (p != NULL)
-	{
-		if (p->name != NULL && p->set == 1 && p->get_info != NULL) 
-		{
-			p->parent = proc_ide_root;
-			create_proc_info_entry(p->name, 0, p->parent, p->get_info);
-			p->set = 2;
-		}
-		p = p->next;
-	}
-#endif /* CONFIG_BLK_DEV_IDEPCI */
 }
 
 EXPORT_SYMBOL(proc_ide_create);
 
 void proc_ide_destroy(void)
 {
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	ide_pci_host_proc_t *p;
-
-	for (p = ide_pci_host_proc_list; p; p = p->next) {
-		if (p->set == 2)
-			remove_proc_entry(p->name, p->parent);
-	}
-#endif /* CONFIG_BLK_DEV_IDEPCI */
 	remove_proc_entry("ide/drivers", proc_ide_root);
 	destroy_proc_ide_interfaces();
 	remove_proc_entry("ide", 0);
diff -puN drivers/ide/pci/aec62xx.c~ide_pci_proc_fix drivers/ide/pci/aec62xx.c
--- linux-2.6.3/drivers/ide/pci/aec62xx.c~ide_pci_proc_fix	2004-02-19 02:14:51.158194368 +0100
+++ linux-2.6.3-root/drivers/ide/pci/aec62xx.c	2004-02-19 02:14:51.306171872 +0100
@@ -423,7 +423,7 @@ static unsigned int __init init_chipset_
 
 	if (!aec62xx_proc) {
 		aec62xx_proc = 1;
-		ide_pci_register_host_proc(&aec62xx_procs[0]);
+		ide_pci_create_host_proc("aec62xx", aec62xx_get_info);
 	}
 #endif /* DISPLAY_AEC62XX_TIMINGS && CONFIG_PROC_FS */
 
diff -puN drivers/ide/pci/aec62xx.h~ide_pci_proc_fix drivers/ide/pci/aec62xx.h
--- linux-2.6.3/drivers/ide/pci/aec62xx.h~ide_pci_proc_fix	2004-02-19 02:14:51.163193608 +0100
+++ linux-2.6.3-root/drivers/ide/pci/aec62xx.h	2004-02-19 02:14:51.307171720 +0100
@@ -70,24 +70,6 @@ struct chipset_bus_clock_list_entry aec6
 #define BUSCLOCK(D)	\
 	((struct chipset_bus_clock_list_entry *) pci_get_drvdata((D)))
 
-#if defined(DISPLAY_AEC62XX_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 aec62xx_proc;
-
-static int aec62xx_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t aec62xx_procs[] = {
-	{
-		.name		= "aec62xx",
-		.set		= 1,
-		.get_info	= aec62xx_get_info,
-		.parent		= NULL,
-	},
-};
-#endif /* DISPLAY_AEC62XX_TIMINGS && CONFIG_PROC_FS */
-
 static void init_setup_aec6x80(struct pci_dev *, ide_pci_device_t *);
 static void init_setup_aec62xx(struct pci_dev *, ide_pci_device_t *);
 static unsigned int init_chipset_aec62xx(struct pci_dev *, const char *);
diff -puN drivers/ide/pci/alim15x3.c~ide_pci_proc_fix drivers/ide/pci/alim15x3.c
--- linux-2.6.3/drivers/ide/pci/alim15x3.c~ide_pci_proc_fix	2004-02-19 02:14:51.166193152 +0100
+++ linux-2.6.3-root/drivers/ide/pci/alim15x3.c	2004-02-19 02:14:51.309171416 +0100
@@ -588,7 +588,7 @@ static unsigned int __init init_chipset_
 	if (!ali_proc) {
 		ali_proc = 1;
 		bmide_dev = dev;
-		ide_pci_register_host_proc(&ali_procs[0]);
+		ide_pci_create_host_proc("ali", ali_get_info);
 	}
 #endif  /* defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS) */
 
diff -puN drivers/ide/pci/alim15x3.h~ide_pci_proc_fix drivers/ide/pci/alim15x3.h
--- linux-2.6.3/drivers/ide/pci/alim15x3.h~ide_pci_proc_fix	2004-02-19 02:14:51.170192544 +0100
+++ linux-2.6.3-root/drivers/ide/pci/alim15x3.h	2004-02-19 02:14:51.310171264 +0100
@@ -7,24 +7,6 @@
 
 #define DISPLAY_ALI_TIMINGS
 
-#if defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 ali_proc;
-
-static int ali_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t ali_procs[] = {
-	{
-		.name		= "ali",
-		.set		= 1,
-		.get_info	= ali_get_info,
-		.parent		= NULL,
-	},
-};
-#endif /* DISPLAY_ALI_TIMINGS && CONFIG_PROC_FS */
-
 static unsigned int init_chipset_ali15x3(struct pci_dev *, const char *);
 static void init_hwif_common_ali15x3(ide_hwif_t *);
 static void init_hwif_ali15x3(ide_hwif_t *);
diff -puN drivers/ide/pci/amd74xx.c~ide_pci_proc_fix drivers/ide/pci/amd74xx.c
--- linux-2.6.3/drivers/ide/pci/amd74xx.c~ide_pci_proc_fix	2004-02-19 02:14:51.173192088 +0100
+++ linux-2.6.3-root/drivers/ide/pci/amd74xx.c	2004-02-19 02:14:51.311171112 +0100
@@ -88,6 +88,8 @@ static unsigned char amd_cyc2udma[] = { 
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
+static u8 amd74xx_proc;
+
 static unsigned char amd_udma2cyc[] = { 4, 6, 8, 10, 3, 2, 1, 15 };
 static unsigned long amd_base;
 static struct pci_dev *bmide_dev;
@@ -398,7 +400,7 @@ static unsigned int __init init_chipset_
         if (!amd74xx_proc) {
                 amd_base = pci_resource_start(dev, 4);
                 bmide_dev = dev;
-                ide_pci_register_host_proc(&amd74xx_procs[0]);
+		ide_pci_create_host_proc("amd74xx", amd74xx_get_info);
                 amd74xx_proc = 1;
         }
 #endif /* DISPLAY_AMD_TIMINGS && CONFIG_PROC_FS */
diff -puN drivers/ide/pci/amd74xx.h~ide_pci_proc_fix drivers/ide/pci/amd74xx.h
--- linux-2.6.3/drivers/ide/pci/amd74xx.h~ide_pci_proc_fix	2004-02-19 02:14:51.176191632 +0100
+++ linux-2.6.3-root/drivers/ide/pci/amd74xx.h	2004-02-19 02:14:51.312170960 +0100
@@ -7,24 +7,6 @@
 
 #define DISPLAY_AMD_TIMINGS
 
-#if defined(DISPLAY_AMD_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 amd74xx_proc;
-
-static int amd74xx_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t amd74xx_procs[] = {
-	{
-		.name		= "amd74xx",
-		.set		= 1,
-		.get_info	= amd74xx_get_info,
-		.parent		= NULL,
-	},
-};
-#endif  /* defined(DISPLAY_AMD_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 static unsigned int init_chipset_amd74xx(struct pci_dev *, const char *);
 static void init_hwif_amd74xx(ide_hwif_t *);
 
diff -puN drivers/ide/pci/cmd64x.c~ide_pci_proc_fix drivers/ide/pci/cmd64x.c
--- linux-2.6.3/drivers/ide/pci/cmd64x.c~ide_pci_proc_fix	2004-02-19 02:14:51.180191024 +0100
+++ linux-2.6.3-root/drivers/ide/pci/cmd64x.c	2004-02-19 02:14:51.313170808 +0100
@@ -667,7 +667,7 @@ static unsigned int __init init_chipset_
 
 	if (!cmd64x_proc) {
 		cmd64x_proc = 1;
-		ide_pci_register_host_proc(&cmd64x_procs[0]);
+		ide_pci_create_host_proc("cmd64x", cmd64x_get_info);
 	}
 #endif /* DISPLAY_CMD64X_TIMINGS && CONFIG_PROC_FS */
 
diff -puN drivers/ide/pci/cmd64x.h~ide_pci_proc_fix drivers/ide/pci/cmd64x.h
--- linux-2.6.3/drivers/ide/pci/cmd64x.h~ide_pci_proc_fix	2004-02-19 02:14:51.184190416 +0100
+++ linux-2.6.3-root/drivers/ide/pci/cmd64x.h	2004-02-19 02:14:51.314170656 +0100
@@ -60,25 +60,6 @@
 #define UDIDETCR1	0x7B
 #define DTPR1		0x7C
 
-#if defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 cmd64x_proc;
-
-static char * print_cmd64x_get_info(char *, struct pci_dev *, int);
-static int cmd64x_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t cmd64x_procs[] = {
-	{
-		.name		= "cmd64x",
-		.set		= 1,
-		.get_info	= cmd64x_get_info,
-		.parent		= NULL,
-	},
-};
-#endif  /* defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 static unsigned int init_chipset_cmd64x(struct pci_dev *, const char *);
 static void init_hwif_cmd64x(ide_hwif_t *);
 
diff -puN drivers/ide/pci/cs5520.c~ide_pci_proc_fix drivers/ide/pci/cs5520.c
--- linux-2.6.3/drivers/ide/pci/cs5520.c~ide_pci_proc_fix	2004-02-19 02:14:51.188189808 +0100
+++ linux-2.6.3-root/drivers/ide/pci/cs5520.c	2004-02-19 02:14:51.315170504 +0100
@@ -196,7 +196,7 @@ static unsigned int __devinit init_chips
 	if (!cs5520_proc) {
 		cs5520_proc = 1;
 		bmide_dev = dev;
-		ide_pci_register_host_proc(&cs5520_procs[0]);
+		ide_pci_create_host_proc("cs5520", cs5520_get_info);
 	}
 #endif /* DISPLAY_CS5520_TIMINGS && CONFIG_PROC_FS */
 	return 0;
diff -puN drivers/ide/pci/cs5520.h~ide_pci_proc_fix drivers/ide/pci/cs5520.h
--- linux-2.6.3/drivers/ide/pci/cs5520.h~ide_pci_proc_fix	2004-02-19 02:14:51.191189352 +0100
+++ linux-2.6.3-root/drivers/ide/pci/cs5520.h	2004-02-19 02:14:51.316170352 +0100
@@ -7,24 +7,6 @@
 
 #define DISPLAY_CS5520_TIMINGS
 
-#if defined(DISPLAY_CS5520_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 cs5520_proc;
-
-static int cs5520_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t cs5520_procs[] = {
-	{
-		.name		= "cs5520",
-		.set		= 1,
-		.get_info	= cs5520_get_info,
-		.parent		= NULL,
-	},
-};
-#endif  /* defined(DISPLAY_CS5520_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 static unsigned int init_chipset_cs5520(struct pci_dev *, const char *);
 static void init_hwif_cs5520(ide_hwif_t *);
 static void cs5520_init_setup_dma(struct pci_dev *dev, struct ide_pci_device_s *d, ide_hwif_t *hwif);
diff -puN drivers/ide/pci/cs5530.c~ide_pci_proc_fix drivers/ide/pci/cs5530.c
--- linux-2.6.3/drivers/ide/pci/cs5530.c~ide_pci_proc_fix	2004-02-19 02:14:51.194188896 +0100
+++ linux-2.6.3-root/drivers/ide/pci/cs5530.c	2004-02-19 02:14:51.317170200 +0100
@@ -276,7 +276,7 @@ static unsigned int __init init_chipset_
 	if (!cs5530_proc) {
 		cs5530_proc = 1;
 		bmide_dev = dev;
-		ide_pci_register_host_proc(&cs5530_procs[0]);
+		ide_pci_create_host_proc("cs5530", cs5530_get_info);
 	}
 #endif /* DISPLAY_CS5530_TIMINGS && CONFIG_PROC_FS */
 
diff -puN drivers/ide/pci/cs5530.h~ide_pci_proc_fix drivers/ide/pci/cs5530.h
--- linux-2.6.3/drivers/ide/pci/cs5530.h~ide_pci_proc_fix	2004-02-19 02:14:51.198188288 +0100
+++ linux-2.6.3-root/drivers/ide/pci/cs5530.h	2004-02-19 02:14:51.318170048 +0100
@@ -7,24 +7,6 @@
 
 #define DISPLAY_CS5530_TIMINGS
 
-#if defined(DISPLAY_CS5530_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 cs5530_proc;
-
-static int cs5530_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t cs5530_procs[] = {
-	{
-		.name		= "cs5530",
-		.set		= 1,
-		.get_info	= cs5530_get_info,
-		.parent		= NULL,
-	},
-};
-#endif /* DISPLAY_CS5530_TIMINGS && CONFIG_PROC_FS */
-
 static unsigned int init_chipset_cs5530(struct pci_dev *, const char *);
 static void init_hwif_cs5530(ide_hwif_t *);
 
diff -puN drivers/ide/pci/hpt34x.c~ide_pci_proc_fix drivers/ide/pci/hpt34x.c
--- linux-2.6.3/drivers/ide/pci/hpt34x.c~ide_pci_proc_fix	2004-02-19 02:14:51.201187832 +0100
+++ linux-2.6.3-root/drivers/ide/pci/hpt34x.c	2004-02-19 02:14:51.318170048 +0100
@@ -282,7 +282,7 @@ static unsigned int __init init_chipset_
 
 	if (!hpt34x_proc) {
 		hpt34x_proc = 1;
-		ide_pci_register_host_proc(&hpt34x_procs[0]);
+		ide_pci_create_host_proc("hpt34x", hpt34x_get_info);
 	}
 #endif /* DISPLAY_HPT34X_TIMINGS && CONFIG_PROC_FS */
 
diff -puN drivers/ide/pci/hpt34x.h~ide_pci_proc_fix drivers/ide/pci/hpt34x.h
--- linux-2.6.3/drivers/ide/pci/hpt34x.h~ide_pci_proc_fix	2004-02-19 02:14:51.205187224 +0100
+++ linux-2.6.3-root/drivers/ide/pci/hpt34x.h	2004-02-19 02:14:51.319169896 +0100
@@ -13,24 +13,6 @@
 
 #undef DISPLAY_HPT34X_TIMINGS
 
-#if defined(DISPLAY_HPT34X_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 hpt34x_proc;
-
-static int hpt34x_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t hpt34x_procs[] = {
-	{
-		.name		= "hpt34x",
-		.set		= 1,
-		.get_info	= hpt34x_get_info,
-		.parent		= NULL,
-	},
-};
-#endif  /* defined(DISPLAY_HPT34X_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 static unsigned int init_chipset_hpt34x(struct pci_dev *, const char *);
 static void init_hwif_hpt34x(ide_hwif_t *);
 
diff -puN drivers/ide/pci/hpt366.c~ide_pci_proc_fix drivers/ide/pci/hpt366.c
--- linux-2.6.3/drivers/ide/pci/hpt366.c~ide_pci_proc_fix	2004-02-19 02:14:51.209186616 +0100
+++ linux-2.6.3-root/drivers/ide/pci/hpt366.c	2004-02-19 02:14:51.321169592 +0100
@@ -972,7 +972,7 @@ static unsigned int __init init_chipset_
 
 	if (!hpt366_proc) {
 		hpt366_proc = 1;
-		ide_pci_register_host_proc(&hpt366_procs[0]);
+		ide_pci_create_host_proc("hpt366", hpt366_get_info);
 	}
 #endif /* DISPLAY_HPT366_TIMINGS && CONFIG_PROC_FS */
 
diff -puN drivers/ide/pci/hpt366.h~ide_pci_proc_fix drivers/ide/pci/hpt366.h
--- linux-2.6.3/drivers/ide/pci/hpt366.h~ide_pci_proc_fix	2004-02-19 02:14:51.214185856 +0100
+++ linux-2.6.3-root/drivers/ide/pci/hpt366.h	2004-02-19 02:14:51.322169440 +0100
@@ -416,24 +416,6 @@ struct chipset_bus_clock_list_entry sixt
 #define F_LOW_PCI_50      0x2d
 #define F_LOW_PCI_66      0x42
 
-#if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 hpt366_proc;
-
-static int hpt366_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t hpt366_procs[] = {
-	{
-		.name		= "hpt366",
-		.set		= 1,
-		.get_info	= hpt366_get_info,
-		.parent		= NULL,
-	},
-};
-#endif  /* defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 static void init_setup_hpt366(struct pci_dev *, ide_pci_device_t *);
 static void init_setup_hpt37x(struct pci_dev *, ide_pci_device_t *);
 static void init_setup_hpt374(struct pci_dev *, ide_pci_device_t *);
diff -puN drivers/ide/pci/pdc202xx_new.c~ide_pci_proc_fix drivers/ide/pci/pdc202xx_new.c
--- linux-2.6.3/drivers/ide/pci/pdc202xx_new.c~ide_pci_proc_fix	2004-02-19 02:14:51.217185400 +0100
+++ linux-2.6.3-root/drivers/ide/pci/pdc202xx_new.c	2004-02-19 02:14:51.323169288 +0100
@@ -574,7 +574,7 @@ static unsigned int __init init_chipset_
 
 	if (!pdcnew_proc) {
 		pdcnew_proc = 1;
-		ide_pci_register_host_proc(&pdcnew_procs[0]);
+		ide_pci_create_host_proc("pdcnew", pdcnew_get_info);
 	}
 #endif /* DISPLAY_PDC202XX_TIMINGS && CONFIG_PROC_FS */
 
diff -puN drivers/ide/pci/pdc202xx_new.h~ide_pci_proc_fix drivers/ide/pci/pdc202xx_new.h
--- linux-2.6.3/drivers/ide/pci/pdc202xx_new.h~ide_pci_proc_fix	2004-02-19 02:14:51.221184792 +0100
+++ linux-2.6.3-root/drivers/ide/pci/pdc202xx_new.h	2004-02-19 02:14:51.324169136 +0100
@@ -164,25 +164,6 @@ static void decode_registers (u8 registe
 
 #define DISPLAY_PDC202XX_TIMINGS
 
-#if defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 pdcnew_proc;
-
-static int pdcnew_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t pdcnew_procs[] = {
-	{
-		.name		= "pdcnew",
-		.set		= 1,
-		.get_info	= pdcnew_get_info,
-		.parent		= NULL,
-	},
-};
-#endif /* DISPLAY_PDC202XX_TIMINGS && CONFIG_PROC_FS */
-
-
 static void init_setup_pdcnew(struct pci_dev *, ide_pci_device_t *);
 static void init_setup_pdc20270(struct pci_dev *, ide_pci_device_t *);
 static void init_setup_pdc20276(struct pci_dev *dev, ide_pci_device_t *d);
diff -puN drivers/ide/pci/pdc202xx_old.c~ide_pci_proc_fix drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.3/drivers/ide/pci/pdc202xx_old.c~ide_pci_proc_fix	2004-02-19 02:14:51.226184032 +0100
+++ linux-2.6.3-root/drivers/ide/pci/pdc202xx_old.c	2004-02-19 02:14:51.325168984 +0100
@@ -707,7 +707,7 @@ static unsigned int __init init_chipset_
 
 	if (!pdc202xx_proc) {
 		pdc202xx_proc = 1;
-		ide_pci_register_host_proc(&pdc202xx_procs[0]);
+		ide_pci_create_host_proc("pdc202xx", pdc202xx_get_info);
 	}
 #endif /* DISPLAY_PDC202XX_TIMINGS && CONFIG_PROC_FS */
 
diff -puN drivers/ide/pci/pdc202xx_old.h~ide_pci_proc_fix drivers/ide/pci/pdc202xx_old.h
--- linux-2.6.3/drivers/ide/pci/pdc202xx_old.h~ide_pci_proc_fix	2004-02-19 02:14:51.230183424 +0100
+++ linux-2.6.3-root/drivers/ide/pci/pdc202xx_old.h	2004-02-19 02:14:51.326168832 +0100
@@ -199,25 +199,6 @@ static void decode_registers (u8 registe
 
 #define DISPLAY_PDC202XX_TIMINGS
 
-#if defined(DISPLAY_PDC202XX_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 pdc202xx_proc;
-
-static int pdc202xx_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t pdc202xx_procs[] = {
-	{
-		.name		= "pdc202xx",
-		.set		= 1,
-		.get_info	= pdc202xx_get_info,
-		.parent		= NULL,
-	},
-};
-#endif /* DISPLAY_PDC202XX_TIMINGS && CONFIG_PROC_FS */
-
-
 static void init_setup_pdc202ata4(struct pci_dev *dev, ide_pci_device_t *d);
 static void init_setup_pdc20265(struct pci_dev *, ide_pci_device_t *);
 static void init_setup_pdc202xx(struct pci_dev *, ide_pci_device_t *);
diff -puN drivers/ide/pci/piix.c~ide_pci_proc_fix drivers/ide/pci/piix.c
--- linux-2.6.3/drivers/ide/pci/piix.c~ide_pci_proc_fix	2004-02-19 02:14:51.234182816 +0100
+++ linux-2.6.3-root/drivers/ide/pci/piix.c	2004-02-19 02:14:51.327168680 +0100
@@ -636,7 +636,7 @@ static unsigned int __devinit init_chips
 
 	if (!piix_proc) {
 		piix_proc = 1;
-		ide_pci_register_host_proc(&piix_procs[0]);
+		ide_pci_create_host_proc("piix", piix_get_info);
 	}
 #endif /* DISPLAY_PIIX_TIMINGS && CONFIG_PROC_FS */
 	return 0;
diff -puN drivers/ide/pci/piix.h~ide_pci_proc_fix drivers/ide/pci/piix.h
--- linux-2.6.3/drivers/ide/pci/piix.h~ide_pci_proc_fix	2004-02-19 02:14:51.238182208 +0100
+++ linux-2.6.3-root/drivers/ide/pci/piix.h	2004-02-19 02:14:51.328168528 +0100
@@ -9,24 +9,6 @@
 
 #define DISPLAY_PIIX_TIMINGS
 
-#if defined(DISPLAY_PIIX_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 piix_proc;
-
-static int piix_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t piix_procs[] = {
-	{
-		.name		= "piix",
-		.set		= 1,
-		.get_info	= piix_get_info,
-		.parent		= NULL,
-	},
-};
-#endif  /* defined(DISPLAY_PIIX_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 static void init_setup_piix(struct pci_dev *, ide_pci_device_t *);
 static unsigned int __devinit init_chipset_piix(struct pci_dev *, const char *);
 static void init_hwif_piix(ide_hwif_t *);
diff -puN drivers/ide/pci/sc1200.c~ide_pci_proc_fix drivers/ide/pci/sc1200.c
--- linux-2.6.3/drivers/ide/pci/sc1200.c~ide_pci_proc_fix	2004-02-19 02:14:51.242181600 +0100
+++ linux-2.6.3-root/drivers/ide/pci/sc1200.c	2004-02-19 02:14:51.331168072 +0100
@@ -515,7 +515,7 @@ static unsigned int __init init_chipset_
 	if (!bmide_dev) {
 		sc1200_proc = 1;
 		bmide_dev = dev;
-		ide_pci_register_host_proc(&sc1200_procs[0]);
+		ide_pci_create_host_proc("sc1200", sc1200_get_info);
 	}
 #endif /* DISPLAY_SC1200_TIMINGS && CONFIG_PROC_FS */
 	return 0;
diff -puN drivers/ide/pci/sc1200.h~ide_pci_proc_fix drivers/ide/pci/sc1200.h
--- linux-2.6.3/drivers/ide/pci/sc1200.h~ide_pci_proc_fix	2004-02-19 02:14:51.245181144 +0100
+++ linux-2.6.3-root/drivers/ide/pci/sc1200.h	2004-02-19 02:14:51.332167920 +0100
@@ -7,24 +7,6 @@
 
 #define DISPLAY_SC1200_TIMINGS
 
-#if defined(DISPLAY_SC1200_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 sc1200_proc;
-
-static int sc1200_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t sc1200_procs[] = {
-	{
-		.name		= "sc1200",
-		.set		= 1,
-		.get_info	= sc1200_get_info,
-		.parent		= NULL,
-	},
-};
-#endif /* DISPLAY_SC1200_TIMINGS && CONFIG_PROC_FS */
-
 static unsigned int init_chipset_sc1200(struct pci_dev *, const char *);
 static void init_hwif_sc1200(ide_hwif_t *);
 
diff -puN drivers/ide/pci/serverworks.c~ide_pci_proc_fix drivers/ide/pci/serverworks.c
--- linux-2.6.3/drivers/ide/pci/serverworks.c~ide_pci_proc_fix	2004-02-19 02:14:51.252180080 +0100
+++ linux-2.6.3-root/drivers/ide/pci/serverworks.c	2004-02-19 02:14:51.334167616 +0100
@@ -621,7 +621,7 @@ static unsigned int __init init_chipset_
 
 	if (!svwks_proc) {
 		svwks_proc = 1;
-		ide_pci_register_host_proc(&svwks_procs[0]);
+		ide_pci_create_host_proc("svwks", svwks_get_info);
 	}
 #endif /* DISPLAY_SVWKS_TIMINGS && CONFIG_PROC_FS */
 
diff -puN drivers/ide/pci/serverworks.h~ide_pci_proc_fix drivers/ide/pci/serverworks.h
--- linux-2.6.3/drivers/ide/pci/serverworks.h~ide_pci_proc_fix	2004-02-19 02:14:51.255179624 +0100
+++ linux-2.6.3-root/drivers/ide/pci/serverworks.h	2004-02-19 02:14:51.335167464 +0100
@@ -23,24 +23,6 @@ const char *svwks_bad_ata100[] = {
 
 #define DISPLAY_SVWKS_TIMINGS	1
 
-#if defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 svwks_proc;
-
-static int svwks_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t svwks_procs[] = {
-{
-		.name		= "svwks",
-		.set		= 1,
-		.get_info	= svwks_get_info,
-		.parent		= NULL,
-	},
-};
-#endif  /* defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 static void init_setup_svwks(struct pci_dev *, ide_pci_device_t *);
 static void init_setup_csb6(struct pci_dev *, ide_pci_device_t *);
 static unsigned int init_chipset_svwks(struct pci_dev *, const char *);
diff -puN drivers/ide/pci/siimage.c~ide_pci_proc_fix drivers/ide/pci/siimage.c
--- linux-2.6.3/drivers/ide/pci/siimage.c~ide_pci_proc_fix	2004-02-19 02:14:51.259179016 +0100
+++ linux-2.6.3-root/drivers/ide/pci/siimage.c	2004-02-19 02:14:51.336167312 +0100
@@ -785,7 +785,7 @@ static void proc_reports_siimage (struct
 
 	if (!siimage_proc) {
 		siimage_proc = 1;
-		ide_pci_register_host_proc(&siimage_procs[0]);
+		ide_pci_create_host_proc("siimage", siimage_get_info);
 	}
 #endif /* DISPLAY_SIIMAGE_TIMINGS && CONFIG_PROC_FS */
 }
diff -puN drivers/ide/pci/siimage.h~ide_pci_proc_fix drivers/ide/pci/siimage.h
--- linux-2.6.3/drivers/ide/pci/siimage.h~ide_pci_proc_fix	2004-02-19 02:14:51.264178256 +0100
+++ linux-2.6.3-root/drivers/ide/pci/siimage.h	2004-02-19 02:14:51.337167160 +0100
@@ -21,26 +21,6 @@
 #define siiprintk(x...)
 #endif
 
-
-#if defined(DISPLAY_SIIMAGE_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static char * print_siimage_get_info(char *, struct pci_dev *, int);
-static int siimage_get_info(char *, char **, off_t, int);
-
-static u8 siimage_proc;
-
-static ide_pci_host_proc_t siimage_procs[] = {
-	{
-		.name		= "siimage",
-		.set		= 1,
-		.get_info	= siimage_get_info,
-		.parent		= NULL,
-	},
-};
-#endif /* DISPLAY_SIIMAGE_TIMINGS && CONFIG_PROC_FS */	
-
 static unsigned int init_chipset_siimage(struct pci_dev *, const char *);
 static void init_iops_siimage(ide_hwif_t *);
 static void init_hwif_siimage(ide_hwif_t *);
diff -puN drivers/ide/pci/sis5513.c~ide_pci_proc_fix drivers/ide/pci/sis5513.c
--- linux-2.6.3/drivers/ide/pci/sis5513.c~ide_pci_proc_fix	2004-02-19 02:14:51.267177800 +0100
+++ linux-2.6.3-root/drivers/ide/pci/sis5513.c	2004-02-19 02:14:51.338167008 +0100
@@ -881,7 +881,7 @@ static unsigned int __init init_chipset_
 		if (!sis_proc) {
 			sis_proc = 1;
 			bmide_dev = dev;
-			ide_pci_register_host_proc(&sis_procs[0]);
+			ide_pci_create_host_proc("sis", sis_get_info);
 		}
 #endif
 	}
diff -puN drivers/ide/pci/sis5513.h~ide_pci_proc_fix drivers/ide/pci/sis5513.h
--- linux-2.6.3/drivers/ide/pci/sis5513.h~ide_pci_proc_fix	2004-02-19 02:14:51.271177192 +0100
+++ linux-2.6.3-root/drivers/ide/pci/sis5513.h	2004-02-19 02:14:51.339166856 +0100
@@ -7,24 +7,6 @@
 
 #define DISPLAY_SIS_TIMINGS
 
-#if defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 sis_proc;
-
-static int sis_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t sis_procs[] = {
-{
-		.name		= "sis",
-		.set		= 1,
-		.get_info	= sis_get_info,
-		.parent		= NULL,
-	},
-};
-#endif /* defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 static unsigned int init_chipset_sis5513(struct pci_dev *, const char *);
 static void init_hwif_sis5513(ide_hwif_t *);
 
diff -puN drivers/ide/pci/slc90e66.c~ide_pci_proc_fix drivers/ide/pci/slc90e66.c
--- linux-2.6.3/drivers/ide/pci/slc90e66.c~ide_pci_proc_fix	2004-02-19 02:14:51.275176584 +0100
+++ linux-2.6.3-root/drivers/ide/pci/slc90e66.c	2004-02-19 02:14:51.340166704 +0100
@@ -319,7 +319,7 @@ static unsigned int __init init_chipset_
 	if (!slc90e66_proc) {
 		slc90e66_proc = 1;
 		bmide_dev = dev;
-		ide_pci_register_host_proc(&slc90e66_procs[0]);
+		ide_pci_create_host_proc("slc90e66", slc90e66_get_info);
 	}
 #endif /* DISPLAY_SLC90E66_TIMINGS && CONFIG_PROC_FS */
 	return 0;
diff -puN drivers/ide/pci/slc90e66.h~ide_pci_proc_fix drivers/ide/pci/slc90e66.h
--- linux-2.6.3/drivers/ide/pci/slc90e66.h~ide_pci_proc_fix	2004-02-19 02:14:51.278176128 +0100
+++ linux-2.6.3-root/drivers/ide/pci/slc90e66.h	2004-02-19 02:14:51.341166552 +0100
@@ -9,24 +9,6 @@
 
 #define SLC90E66_DEBUG_DRIVE_INFO	0
 
-#if defined(DISPLAY_SLC90E66_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 slc90e66_proc;
-
-static int slc90e66_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t slc90e66_procs[] = {
-	{
-		.name		= "slc90e66",
-		.set		= 1,
-		.get_info	= slc90e66_get_info,
-		.parent		= NULL,
-	},
-};
-#endif	/* defined(DISPLAY_SLC90E66_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 static unsigned int init_chipset_slc90e66(struct pci_dev *, const char *);
 static void init_hwif_slc90e66(ide_hwif_t *);
 
diff -puN drivers/ide/pci/triflex.c~ide_pci_proc_fix drivers/ide/pci/triflex.c
--- linux-2.6.3/drivers/ide/pci/triflex.c~ide_pci_proc_fix	2004-02-19 02:14:51.281175672 +0100
+++ linux-2.6.3-root/drivers/ide/pci/triflex.c	2004-02-19 02:14:51.342166400 +0100
@@ -212,7 +212,7 @@ static unsigned int __init init_chipset_
 		const char *name) 
 {
 #ifdef CONFIG_PROC_FS
-	ide_pci_register_host_proc(&triflex_proc);
+	ide_pci_create_host_proc("triflex", triflex_get_info);
 #endif
 	return 0;	
 }
diff -puN drivers/ide/pci/triflex.h~ide_pci_proc_fix drivers/ide/pci/triflex.h
--- linux-2.6.3/drivers/ide/pci/triflex.h~ide_pci_proc_fix	2004-02-19 02:14:51.285175064 +0100
+++ linux-2.6.3-root/drivers/ide/pci/triflex.h	2004-02-19 02:14:51.343166248 +0100
@@ -14,15 +14,6 @@
 
 static unsigned int __devinit init_chipset_triflex(struct pci_dev *, const char *);
 static void init_hwif_triflex(ide_hwif_t *);
-#ifdef CONFIG_PROC_FS
-static int triflex_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t triflex_proc = {
-	.name		= "triflex",
-	.set		= 1,
-	.get_info 	= triflex_get_info,
-};
-#endif
 
 static ide_pci_device_t triflex_devices[] __devinitdata = {
 	{
diff -puN drivers/ide/pci/via82cxxx.c~ide_pci_proc_fix drivers/ide/pci/via82cxxx.c
--- linux-2.6.3/drivers/ide/pci/via82cxxx.c~ide_pci_proc_fix	2004-02-19 02:14:51.289174456 +0100
+++ linux-2.6.3-root/drivers/ide/pci/via82cxxx.c	2004-02-19 02:14:51.346165792 +0100
@@ -567,7 +567,7 @@ static unsigned int __init init_chipset_
 		via_base = pci_resource_start(dev, 4);
 		bmide_dev = dev;
 		isa_dev = isa;
-		ide_pci_register_host_proc(&via_procs[0]);
+		ide_pci_create_host_proc("via", via_get_info);
 		via_proc = 1;
 	}
 #endif /* DISPLAY_VIA_TIMINGS && CONFIG_PROC_FS */
diff -puN drivers/ide/pci/via82cxxx.h~ide_pci_proc_fix drivers/ide/pci/via82cxxx.h
--- linux-2.6.3/drivers/ide/pci/via82cxxx.h~ide_pci_proc_fix	2004-02-19 02:14:51.292174000 +0100
+++ linux-2.6.3-root/drivers/ide/pci/via82cxxx.h	2004-02-19 02:14:51.347165640 +0100
@@ -7,24 +7,6 @@
 
 #define DISPLAY_VIA_TIMINGS
 
-#if defined(DISPLAY_VIA_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 via_proc;
-
-static int via_get_info(char *, char **, off_t, int);
-
-static ide_pci_host_proc_t via_procs[] = {
-	{
-		.name		= "via",
-		.set		= 1,
-		.get_info	= via_get_info,
-		.parent		= NULL,
-	},
-};
-#endif /* DISPLAY_VIA_TIMINGS && CONFIG_PROC_FS */
-
 static unsigned int init_chipset_via82cxxx(struct pci_dev *, const char *);
 static void init_hwif_via82cxxx(ide_hwif_t *);
 
diff -puN include/linux/ide.h~ide_pci_proc_fix include/linux/ide.h
--- linux-2.6.3/include/linux/ide.h~ide_pci_proc_fix	2004-02-19 02:14:51.298173088 +0100
+++ linux-2.6.3-root/include/linux/ide.h	2004-02-19 02:14:51.349165336 +0100
@@ -1087,6 +1087,8 @@ typedef struct {
 } ide_proc_entry_t;
 
 #ifdef CONFIG_PROC_FS
+extern struct proc_dir_entry *proc_ide_root;
+
 extern void proc_ide_create(void);
 extern void proc_ide_destroy(void);
 extern void destroy_proc_ide_device(ide_hwif_t *, ide_drive_t *);
@@ -1097,6 +1099,10 @@ extern void ide_remove_proc_entries(stru
 read_proc_t proc_ide_read_capacity;
 read_proc_t proc_ide_read_geometry;
 
+#ifdef CONFIG_BLK_DEV_IDEPCI
+void ide_pci_create_host_proc(const char *, get_info_t *);
+#endif
+
 /*
  * Standard exit stuff:
  */
@@ -1522,18 +1528,6 @@ int ide_register_subdriver(ide_drive_t *
 int ide_unregister_subdriver (ide_drive_t *drive);
 int ide_replace_subdriver(ide_drive_t *drive, const char *driver);
 
-#ifdef CONFIG_PROC_FS
-typedef struct ide_pci_host_proc_s {
-	char				*name;
-	u8				set;
-	get_info_t			*get_info;
-	struct proc_dir_entry		*parent;
-	struct ide_pci_host_proc_s	*next;
-} ide_pci_host_proc_t;
-
-void ide_pci_register_host_proc(ide_pci_host_proc_t *);
-#endif /* CONFIG_PROC_FS */
-
 #define ON_BOARD		1
 #define NEVER_BOARD		0
 

_

