Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVAVABH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVAVABH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVAUXbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:31:49 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:62382 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262585AbVAUXXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:23:15 -0500
Date: Sat, 22 Jan 2005 00:18:37 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [patch 1/8] kill ide_driver_t->capacity
Message-ID: <Pine.GSO.4.58.0501220017500.28844@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* add private /proc/ide/hd?/capacity handlers to ide-{cd,disk,floppy}.c
* use generic proc_ide_read_capacity() for ide-{scsi,tape}.c
* kill ->capacity, default_capacity() and generic_subdriver_entries[]

diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	2005-01-21 22:23:17 +01:00
+++ b/drivers/ide/ide-cd.c	2005-01-21 22:23:17 +01:00
@@ -3251,6 +3251,25 @@

 static int ide_cdrom_attach (ide_drive_t *drive);

+#ifdef CONFIG_PROC_FS
+static int proc_idecd_read_capacity
+	(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	ide_drive_t*drive = (ide_drive_t *)data;
+	int len;
+
+	len = sprintf(page,"%llu\n", (long long)ide_cdrom_capacity(drive));
+	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
+}
+
+static ide_proc_entry_t idecd_proc[] = {
+	{ "capacity", S_IFREG|S_IRUGO, proc_idecd_read_capacity, NULL },
+	{ NULL, 0, NULL, NULL }
+};
+#else
+# define idecd_proc	NULL
+#endif
+
 static ide_driver_t ide_cdrom_driver = {
 	.owner			= THIS_MODULE,
 	.name			= "ide-cdrom",
@@ -3260,7 +3279,7 @@
 	.supports_dsc_overlap	= 1,
 	.cleanup		= ide_cdrom_cleanup,
 	.do_request		= ide_do_rw_cdrom,
-	.capacity		= ide_cdrom_capacity,
+	.proc			= idecd_proc,
 	.attach			= ide_cdrom_attach,
 	.drives			= LIST_HEAD_INIT(ide_cdrom_driver.drives),
 };
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	2005-01-21 22:23:17 +01:00
+++ b/drivers/ide/ide-disk.c	2005-01-21 22:23:17 +01:00
@@ -580,6 +580,16 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }

+static int proc_idedisk_read_capacity
+	(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	ide_drive_t*drive = (ide_drive_t *)data;
+	int len;
+
+	len = sprintf(page,"%llu\n", (long long)idedisk_capacity(drive));
+	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
+}
+
 static int proc_idedisk_read_smart_thresholds
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
@@ -620,6 +630,7 @@

 static ide_proc_entry_t idedisk_proc[] = {
 	{ "cache",		S_IFREG|S_IRUGO,	proc_idedisk_read_cache,		NULL },
+	{ "capacity",		S_IFREG|S_IRUGO,	proc_idedisk_read_capacity,		NULL },
 	{ "geometry",		S_IFREG|S_IRUGO,	proc_ide_read_geometry,			NULL },
 	{ "smart_values",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_values,		NULL },
 	{ "smart_thresholds",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_thresholds,	NULL },
@@ -985,7 +996,6 @@
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idedisk_cleanup,
 	.do_request		= ide_do_rw_disk,
-	.capacity		= idedisk_capacity,
 	.proc			= idedisk_proc,
 	.attach			= idedisk_attach,
 	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
diff -Nru a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c	2005-01-21 22:23:17 +01:00
+++ b/drivers/ide/ide-floppy.c	2005-01-21 22:23:17 +01:00
@@ -1847,7 +1847,18 @@

 #ifdef CONFIG_PROC_FS

+static int proc_idefloppy_read_capacity
+	(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	ide_drive_t*drive = (ide_drive_t *)data;
+	int len;
+
+	len = sprintf(page,"%llu\n", (long long)idefloppy_capacity(drive));
+	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
+}
+
 static ide_proc_entry_t idefloppy_proc[] = {
+	{ "capacity",	S_IFREG|S_IRUGO,	proc_idefloppy_read_capacity, NULL },
 	{ "geometry",	S_IFREG|S_IRUGO,	proc_ide_read_geometry,	NULL },
 	{ NULL, 0, NULL, NULL }
 };
@@ -1873,7 +1884,6 @@
 	.cleanup		= idefloppy_cleanup,
 	.do_request		= idefloppy_do_request,
 	.end_request		= idefloppy_do_end_request,
-	.capacity		= idefloppy_capacity,
 	.proc			= idefloppy_proc,
 	.attach			= idefloppy_attach,
 	.drives			= LIST_HEAD_INIT(idefloppy_driver.drives),
diff -Nru a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
--- a/drivers/ide/ide-proc.c	2005-01-21 22:23:17 +01:00
+++ b/drivers/ide/ide-proc.c	2005-01-21 22:23:17 +01:00
@@ -269,13 +269,11 @@
 int proc_ide_read_capacity
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
-	ide_drive_t	*drive = (ide_drive_t *) data;
-	int		len;
-
-	len = sprintf(page,"%llu\n",
-		      (long long) (DRIVER(drive)->capacity(drive)));
+	int len = sprintf(page,"%llu\n", (long long)0x7fffffff);
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
+
+EXPORT_SYMBOL_GPL(proc_ide_read_capacity);

 int proc_ide_read_geometry
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	2005-01-21 22:23:17 +01:00
+++ b/drivers/ide/ide-tape.c	2005-01-21 22:23:17 +01:00
@@ -4660,6 +4660,7 @@
 }

 static ide_proc_entry_t idetape_proc[] = {
+	{ "capacity",	S_IFREG|S_IRUGO,	proc_ide_read_capacity, NULL },
 	{ "name",	S_IFREG|S_IRUGO,	proc_idetape_read_name,	NULL },
 	{ NULL, 0, NULL, NULL }
 };
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2005-01-21 22:23:17 +01:00
+++ b/drivers/ide/ide.c	2005-01-21 22:23:17 +01:00
@@ -413,11 +413,6 @@

 #ifdef CONFIG_PROC_FS
 struct proc_dir_entry *proc_ide_root;
-
-ide_proc_entry_t generic_subdriver_entries[] = {
-	{ "capacity",	S_IFREG|S_IRUGO,	proc_ide_read_capacity,	NULL },
-	{ NULL, 0, NULL, NULL }
-};
 #endif

 static struct resource* hwif_request_region(ide_hwif_t *hwif,
@@ -2037,11 +2032,6 @@
 	return __ide_error(drive, rq, stat, err);
 }

-static sector_t default_capacity (ide_drive_t *drive)
-{
-	return 0x7fffffff;
-}
-
 static ide_startstop_t default_abort(ide_drive_t *drive, struct request *rq)
 {
 	return __ide_abort(drive, rq);
@@ -2055,7 +2045,6 @@
 	if (d->end_request == NULL)	d->end_request = default_end_request;
 	if (d->error == NULL)		d->error = default_error;
 	if (d->abort == NULL)		d->abort = default_abort;
-	if (d->capacity == NULL)	d->capacity = default_capacity;
 }

 int ide_register_subdriver(ide_drive_t *drive, ide_driver_t *driver)
@@ -2083,10 +2072,8 @@
 		drive->nice1 = 1;
 	}
 #ifdef CONFIG_PROC_FS
-	if (drive->driver != &idedefault_driver) {
-		ide_add_proc_entries(drive->proc, generic_subdriver_entries, drive);
+	if (drive->driver != &idedefault_driver)
 		ide_add_proc_entries(drive->proc, driver->proc, drive);
-	}
 #endif
 	return 0;
 }
@@ -2120,7 +2107,6 @@
 	}
 #ifdef CONFIG_PROC_FS
 	ide_remove_proc_entries(drive->proc, DRIVER(drive)->proc);
-	ide_remove_proc_entries(drive->proc, generic_subdriver_entries);
 #endif
 	auto_remove_settings(drive);
 	drive->driver = &idedefault_driver;
diff -Nru a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-01-21 22:23:17 +01:00
+++ b/drivers/scsi/ide-scsi.c	2005-01-21 22:23:17 +01:00
@@ -708,6 +708,15 @@

 static int idescsi_attach(ide_drive_t *drive);

+#ifdef CONFIG_PROC_FS
+static ide_proc_entry_t idescsi_proc[] = {
+	{ "capacity", S_IFREG|S_IRUGO, proc_ide_read_capacity, NULL },
+	{ NULL, 0, NULL, NULL }
+};
+#else
+# define idescsi_proc	NULL
+#endif
+
 /*
  *	IDE subdriver functions, registered with ide.c
  */
@@ -718,6 +727,7 @@
 	.media			= ide_scsi,
 	.busy			= 0,
 	.supports_dsc_overlap	= 0,
+	.proc			= idescsi_proc,
 	.attach			= idescsi_attach,
 	.cleanup		= idescsi_cleanup,
 	.do_request		= idescsi_do_request,
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-01-21 22:23:17 +01:00
+++ b/include/linux/ide.h	2005-01-21 22:23:17 +01:00
@@ -1100,7 +1100,6 @@
 	ide_startstop_t	(*error)(ide_drive_t *, struct request *rq, u8, u8);
 	ide_startstop_t	(*abort)(ide_drive_t *, struct request *rq);
 	int		(*ioctl)(ide_drive_t *, struct inode *, struct file *, unsigned int, unsigned long);
-	sector_t	(*capacity)(ide_drive_t *);
 	ide_proc_entry_t	*proc;
 	int		(*attach)(ide_drive_t *);
 	void		(*ata_prebuilder)(ide_drive_t *);
@@ -1358,7 +1357,6 @@
 extern void ide_init_subdrivers(void);

 extern struct block_device_operations ide_fops[];
-extern ide_proc_entry_t generic_subdriver_entries[];

 extern int ata_attach(ide_drive_t *);

