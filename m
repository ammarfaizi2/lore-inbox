Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbUAHKnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 05:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbUAHKnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 05:43:22 -0500
Received: from dirac.phys.uwm.edu ([129.89.57.19]:19840 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S264311AbUAHKm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 05:42:59 -0500
Date: Thu, 8 Jan 2004 04:42:58 -0600 (CST)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: linux-kernel@vger.kernel.org
cc: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: have drivers/ide/ide-disk.c return missing SMART information
Message-ID: <Pine.GSO.4.21.0401080422300.4627-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The /proc/ide/hd?/ directory contains entries called smart_values and
smart_thresholds.  These are useful for ATA-3 and later disks, and contain
Self-Monitoring, Analysis, and Reporting Technology (SMART) disk
reliability information.

Unfortunately there are no entries for the SMART health status, SMART
summary ATA error log, or SMART summary self-test log.  For ATA-5 and on,
the data in smart_values and smart_thresholds are 'Vendor Specific' and
much of the most useful information is contained in the SMART health
status, SMART summary error log, or SMART summary self-test log.

The patch below adds these three additional missing entries to the
/proc/ide/hd?/ directories. The three new entries are called:
  smart_errorlog
  smart_selftestlog
  smart_status
The first two look just like the current smart_values and smart_thresholds
entries, and contain a text representation of the 512-byte structures. The
third contains exactly one of the three possible text strings:
  GOOD
  FAILING
  UNKNOWN
to indicate the SMART health status of the device. Having these entries in
/proc also allows unpriviledged users/applications additional access to
disk reliability information.

[Note: the file version number in the leading comment block of ide-disk.c
was not consistent with IDEDISK_VERSION.  So my patch doesn't bump the
version number.]

Bruce Allen



--- drivers/ide/ide-disk.c.original	2004-01-08 01:26:35.000000000 -0600
+++ drivers/ide/ide-disk.c	2004-01-08 04:18:11.383998551 -0600
@@ -39,6 +39,8 @@
  * Version 1.16		added suspend-resume-checkpower
  * Version 1.17		do flush on standy, do flush on ATA < ATA6
  *			fix wcache setup.
+ * Version 1.18         added smart_status, smart_errorlog, smart_selftestlog
+ *                      to /proc SMART entries
  */
 
 #define IDEDISK_VERSION	"1.18"
@@ -1245,27 +1247,71 @@
 	return ide_raw_taskfile(drive, &args, NULL);
 }
 
-static int get_smart_values(ide_drive_t *drive, u8 *buf)
+/* return values:
+ * -1: SMART STATUS: not supported or unknown
+ *  0: SMART STATUS: GOOD
+ *  1: SMART STATUS: FAILING
+ */
+static int smart_status(ide_drive_t *drive)
 {
 	ide_task_t args;
 
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	= SMART_READ_VALUES;
-	args.tfRegister[IDE_NSECTOR_OFFSET]	= 0x01;
+	args.tfRegister[IDE_FEATURE_OFFSET]	= SMART_STATUS;
 	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
 	args.command_type			= ide_cmd_type_parser(&args);
-	(void) smart_enable(drive);
-	return ide_raw_taskfile(drive, &args, buf);
+
+        if (ide_raw_taskfile(drive, &args, NULL))
+          return -1;
+        
+        /* registers unchanged: GOOD SMART status */
+        if (SMART_LCYL_PASS == args.tfRegister[IDE_LCYL_OFFSET] &&
+            SMART_HCYL_PASS == args.tfRegister[IDE_HCYL_OFFSET])
+          return 0;
+        
+        /* low/high nibbles swapped: FAILING SMART status */
+        if (0xF4 == args.tfRegister[IDE_LCYL_OFFSET] &&
+            0x2C == args.tfRegister[IDE_HCYL_OFFSET])
+          return 1;
+
+        /* anything else: SMART status command not supported */
+        return -1;
 }
 
-static int get_smart_thresholds(ide_drive_t *drive, u8 *buf)
+static int get_smart_data(ide_drive_t *drive, u8 *buf, int datatype)
 {
 	ide_task_t args;
+
 	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_FEATURE_OFFSET]	= SMART_READ_THRESHOLDS;
-	args.tfRegister[IDE_NSECTOR_OFFSET]	= 0x01;
+
+        /* allowed datatype values:
+         * 0 -- SMART READ DATA
+         * 1 -- SMART READ THRESHOLDS
+         * 2 -- SMART READ SUMMARY ATA ERROR LOG
+         * 3 -- SMART READ SUMMARY SELF-TEST LOG
+         */
+        switch (datatype) {
+          case 0:
+                args.tfRegister[IDE_FEATURE_OFFSET]     = SMART_READ_VALUES;
+                break;
+          case 1:
+                args.tfRegister[IDE_FEATURE_OFFSET]     = SMART_READ_THRESHOLDS;
+                break;
+          case 2:
+                args.tfRegister[IDE_SECTOR_OFFSET]      = 0x01;
+                args.tfRegister[IDE_FEATURE_OFFSET]     = SMART_READ_LOG_SECTOR;
+                break;
+          case 3:
+                args.tfRegister[IDE_SECTOR_OFFSET]      = 0x06;
+                args.tfRegister[IDE_FEATURE_OFFSET]     = SMART_READ_LOG_SECTOR;
+                break;
+          default:
+                return -ENOSYS;
+        }
+
+        args.tfRegister[IDE_NSECTOR_OFFSET]     = 0x01;
 	args.tfRegister[IDE_LCYL_OFFSET]	= SMART_LCYL_PASS;
 	args.tfRegister[IDE_HCYL_OFFSET]	= SMART_HCYL_PASS;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_SMART;
@@ -1288,13 +1334,32 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
+static int proc_idedisk_read_smart_values
+	(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	ide_drive_t	*drive = (ide_drive_t *)data;
+	int		len = 0, i = 0;
+
+	if (!get_smart_data(drive, page, 0)) {
+		unsigned short *val = (unsigned short *) page;
+		char *out = ((char *)val) + (SECTOR_WORDS * 4);
+		page = out;
+		do {
+			out += sprintf(out, "%04x%c", le16_to_cpu(*val), (++i & 7) ? ' ' : '\n');
+			val += 1;
+		} while (i < (SECTOR_WORDS * 2));
+		len = out - page;
+	}
+	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
+}
+
 static int proc_idedisk_read_smart_thresholds
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *)data;
 	int		len = 0, i = 0;
 
-	if (!get_smart_thresholds(drive, page)) {
+	if (!get_smart_data(drive, page, 1)) {
 		unsigned short *val = (unsigned short *) page;
 		char *out = ((char *)val) + (SECTOR_WORDS * 4);
 		page = out;
@@ -1307,13 +1372,13 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
-static int proc_idedisk_read_smart_values
+static int proc_idedisk_read_smart_errorlog
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *)data;
 	int		len = 0, i = 0;
 
-	if (!get_smart_values(drive, page)) {
+	if (!get_smart_data(drive, page, 2)) {
 		unsigned short *val = (unsigned short *) page;
 		char *out = ((char *)val) + (SECTOR_WORDS * 4);
 		page = out;
@@ -1326,11 +1391,50 @@
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
+static int proc_idedisk_read_smart_selftestlog
+	(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	ide_drive_t	*drive = (ide_drive_t *)data;
+	int		len = 0, i = 0;
+
+	if (!get_smart_data(drive, page, 3)) {
+		unsigned short *val = (unsigned short *) page;
+		char *out = ((char *)val) + (SECTOR_WORDS * 4);
+		page = out;
+		do {
+			out += sprintf(out, "%04x%c", le16_to_cpu(*val), (++i & 7) ? ' ' : '\n');
+			val += 1;
+		} while (i < (SECTOR_WORDS * 2));
+		len = out - page;
+	}
+	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
+}
+
+static int proc_idedisk_read_smart_status
+	(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	ide_drive_t	*drive = (ide_drive_t *)data;
+	int		len;
+        int             smartstat = smart_status(drive);
+
+        if (smartstat==0)
+                len = sprintf(page, "GOOD\n");
+        else if (smartstat==1)
+                len = sprintf(page, "FAILING\n");
+        else
+                len = sprintf(page, "UNKNOWN\n");
+
+	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
+}
+
 static ide_proc_entry_t idedisk_proc[] = {
 	{ "cache",		S_IFREG|S_IRUGO,	proc_idedisk_read_cache,		NULL },
 	{ "geometry",		S_IFREG|S_IRUGO,	proc_ide_read_geometry,			NULL },
 	{ "smart_values",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_values,		NULL },
 	{ "smart_thresholds",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_thresholds,	NULL },
+	{ "smart_errorlog",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_errorlog,	NULL },
+	{ "smart_selftestlog",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_selftestlog,	NULL },
+	{ "smart_status",	S_IFREG|S_IRUSR,	proc_idedisk_read_smart_status,         NULL },
 	{ NULL, 0, NULL, NULL }
 };
 

