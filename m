Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbTIWKIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 06:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbTIWKIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 06:08:53 -0400
Received: from vsmtp4.tin.it ([212.216.176.224]:6297 "EHLO vsmtp4.tin.it")
	by vger.kernel.org with ESMTP id S263337AbTIWKIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 06:08:50 -0400
Date: Tue, 23 Sep 2003 12:07:01 +0200
From: Antonio Gallo <agx@linux.it>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org, rubini@gnu.org
Subject: [PATCH] serial_no displaed under /proc/ide/ideX/hdX/
Message-Id: <20030923120701.4c31f455.agx@linux.it>
Organization: www.badpenguin.org
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Bad Penguin 1.0.0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This you to "cat" the file /proc/ide/ide*/hd*/serial_no in order to
display the "Serial Number" of the selected HD, if available.

The patch just add this entries to the proc filesystem since the serial_no
is already there thanks to already implemented kernel functions.

I also added some few notes to the kernel.

The patch is for kernel 2.4.21, i also tested it with 2.4.22

The touched file are drivers/ide/ide-disk.c and drivers/ide/ide-proc.c

I'm no currently subscribed to the kernel ML so if possibile answer me back
to my source email address.

Thank you in advance, this is my FIRST kernel patch :-) i hope it is
usefull as it is usefull for me, bye!!!

Antonio Gallo - http://www.linux.it/~agx/



diff -urN linux-vanilla/drivers/ide/ide-disk.c linux-2.4.21/drivers/ide/ide-disk.c
--- linux-vanilla/drivers/ide/ide-disk.c	2003-06-13 16:51:33.000000000 +0200
+++ linux-2.4.21/drivers/ide/ide-disk.c	2003-09-22 12:43:53.000000000 +0200
@@ -1397,6 +1397,10 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
+/*
+ * this static array defines addittional entries that the proc virtual filesystem
+ * will display under the /proc/ide/ideX/hdX directory (Antonio Gallo)
+ */
 static ide_proc_entry_t idedisk_proc[] = {
 	{ "cache",		S_IFREG|S_IRUGO,	proc_idedisk_read_cache,		NULL },
 	{ "geometry",		S_IFREG|S_IRUGO,	proc_ide_read_geometry,			NULL },
diff -urN linux-vanilla/drivers/ide/ide-proc.c linux-2.4.21/drivers/ide/ide-proc.c
--- linux-vanilla/drivers/ide/ide-proc.c	2003-06-13 16:51:33.000000000 +0200
+++ linux-2.4.21/drivers/ide/ide-proc.c	2003-09-22 12:43:33.000000000 +0200
@@ -691,6 +691,25 @@
 
 EXPORT_SYMBOL(proc_ide_read_dmodel);
 
+/*
+ * This function return to the proc virtual filesystem the "serial_no" field
+ * of the drive->id structure if available. This function is exactly as the
+ * above proc_ide_read_dmodel (Antonio Gallo)
+ */
+int proc_ide_read_serial_no
+	(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	ide_drive_t	*drive = (ide_drive_t *) data;
+	struct hd_driveid *id = drive->id;
+	int		len;
+
+	len = sprintf(page, "%.40s\n",
+		(id && id->serial_no[0]) ? (char *)id->serial_no : "(none)");
+	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
+}
+
+EXPORT_SYMBOL(proc_ide_read_serial_no);
+
 int proc_ide_read_driver
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
@@ -745,12 +764,17 @@
 
 EXPORT_SYMBOL(proc_ide_read_media);
 
+/*
+ * This static array defines the entries that the proc virtual filesystem will display
+ * under the /proc/ide/ideX/hdX directory (Antonio Gallo)
+ */
 static ide_proc_entry_t generic_drive_entries[] = {
 	{ "driver",	S_IFREG|S_IRUGO,	proc_ide_read_driver,	proc_ide_write_driver },
 	{ "identify",	S_IFREG|S_IRUSR,	proc_ide_read_identify,	NULL },
 	{ "media",	S_IFREG|S_IRUGO,	proc_ide_read_media,	NULL },
 	{ "model",	S_IFREG|S_IRUGO,	proc_ide_read_dmodel,	NULL },
 	{ "settings",	S_IFREG|S_IRUSR|S_IWUSR,proc_ide_read_settings,	proc_ide_write_settings },
+	{ "serial_no",	S_IFREG|S_IRUGO,	proc_ide_read_serial_no,NULL },
 	{ NULL,	0, NULL, NULL }
 };
 
@@ -874,6 +898,10 @@
 
 EXPORT_SYMBOL(destroy_proc_ide_drives);
 
+/*
+ * This static array defines the entries that the proc virtual filesystem will display
+ * under the /proc/ide/ideX/ directory (Antonio Gallo)
+ */
 static ide_proc_entry_t hwif_entries[] = {
 	{ "channel",	S_IFREG|S_IRUGO,	proc_ide_read_channel,	NULL },
 	{ "config",	S_IFREG|S_IRUGO|S_IWUSR,proc_ide_read_config,	proc_ide_write_config },
