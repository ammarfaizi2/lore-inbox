Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263821AbTCUT20>; Fri, 21 Mar 2003 14:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263831AbTCUT1c>; Fri, 21 Mar 2003 14:27:32 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53380
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263821AbTCUT0o>; Fri, 21 Mar 2003 14:26:44 -0500
Date: Fri, 21 Mar 2003 20:42:01 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212042.h2LKg1cM026443@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove special cases from ide_proc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-proc.c linux-2.5.65-ac2/drivers/ide/ide-proc.c
--- linux-2.5.65/drivers/ide/ide-proc.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-proc.c	2003-03-14 01:20:37.000000000 +0000
@@ -1,7 +1,8 @@
 /*
- *  linux/drivers/ide/ide-proc.c	Version 1.03	January  2, 1998
+ *  linux/drivers/ide/ide-proc.c	Version 1.05	Mar 05, 2003
  *
  *  Copyright (C) 1997-1998	Mark Lord
+ *  Copyright (C) 2003		Red Hat <alan@redhat.com>
  */
 
 /*
@@ -57,7 +58,6 @@
  */
 
 #include <linux/config.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include <asm/uaccess.h>
@@ -365,6 +365,7 @@
 		case ide_cy82c693:	name = "cy82c693";	break;
 		case ide_4drives:	name = "4drives";	break;
 		case ide_pmac:		name = "mac-io";	break;
+		case ide_pc9800:	name = "pc9800";	break;
 		default:		name = "(unknown)";	break;
 	}
 	len = sprintf(page, "%s\n", name);
@@ -568,14 +569,10 @@
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t    *driver = (ide_driver_t *) drive->driver;
 	int		len;
 
-	if (!driver)
-		len = sprintf(page, "(none)\n");
-        else
-		len = sprintf(page,"%llu\n",
-			      (long long) ((ide_driver_t *)drive->driver)->capacity(drive));
+	len = sprintf(page,"%llu\n",
+		      (long long) (DRIVER(drive)->capacity(drive)));
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
@@ -620,10 +617,7 @@
 	ide_driver_t	*driver = drive->driver;
 	int		len;
 
-	if (!driver)
-		len = sprintf(page, "(none)\n");
-	else
-		len = sprintf(page, "%s version %s\n",
+	len = sprintf(page, "%s version %s\n",
 			driver->name, driver->version);
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
@@ -775,8 +769,7 @@
 	ide_driver_t *driver = drive->driver;
 
 	if (drive->proc) {
-		if (driver)
-			ide_remove_proc_entries(drive->proc, driver->proc);
+		ide_remove_proc_entries(drive->proc, driver->proc);
 		ide_remove_proc_entries(drive->proc, generic_drive_entries);
 		remove_proc_entry(drive->name, proc_ide_root);
 		remove_proc_entry(drive->name, hwif->proc);
