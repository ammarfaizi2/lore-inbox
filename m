Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUGQX1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUGQX1H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 19:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUGQWob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:44:31 -0400
Received: from digitalimplant.org ([64.62.235.95]:53225 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262905AbUGQWgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:36:06 -0400
Date: Sat, 17 Jul 2004 15:36:00 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [21/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171532140.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1863, 2004/07/17 13:27:57-07:00, mochel@digitalimplant.org

[Power Mgmt] Make default partition config option part of swsusp.

- Remove from pmdisk.
- Remove pmdisk= command line option.


 kernel/power/Kconfig  |   14 ++++----------
 kernel/power/pmdisk.c |   23 -----------------------
 kernel/power/swsusp.c |    2 +-
 3 files changed, 5 insertions(+), 34 deletions(-)


diff -Nru a/kernel/power/Kconfig b/kernel/power/Kconfig
--- a/kernel/power/Kconfig	2004-07-17 14:50:37 -07:00
+++ b/kernel/power/Kconfig	2004-07-17 14:50:37 -07:00
@@ -54,12 +54,12 @@

 	If unsure, Say N.

-config PM_DISK_PARTITION
+config PM_STD_PARTITION
 	string "Default resume partition"
-	depends on PM_DISK
+	depends on SOFTWARE_SUSPEND
 	default ""
 	---help---
-	  The default resume partition is the partition that the pmdisk suspend-
+	  The default resume partition is the partition that the suspend-
 	  to-disk implementation will look for a suspended disk image.

 	  The partition specified here will be different for almost every user.
@@ -68,15 +68,9 @@

 	  The partition specified can be overridden by specifying:

-		pmdisk=/dev/<other device>
+		resume=/dev/<other device>

 	  which will set the resume partition to the device specified.
-
-	  One may also do:
-
-		pmdisk=off
-
-	  to inform the kernel not to perform a resume transition.

 	  Note there is currently not a way to specify which device to save the
 	  suspended image to. It will simply pick the first available swap
diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:50:37 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:50:37 -07:00
@@ -33,26 +33,3 @@

 #include "power.h"

-/* For resume= kernel option */
-static char resume_file[256] = CONFIG_PM_DISK_PARTITION;
-extern suspend_pagedir_t *pagedir_save;
-
-/*
- * Saving part...
- */
-
-
-static int __init pmdisk_setup(char *str)
-{
-	if (strlen(str)) {
-		if (!strcmp(str,"off"))
-			resume_file[0] = '\0';
-		else
-			strncpy(resume_file, str, 255);
-	} else
-		resume_file[0] = '\0';
-	return 1;
-}
-
-__setup("pmdisk=", pmdisk_setup);
-
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:50:37 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:50:37 -07:00
@@ -89,7 +89,7 @@
 int nr_copy_pages_check;

 static int resume_status;
-static char resume_file[256] = "";			/* For resume= kernel option */
+static char resume_file[256] = CONFIG_PM_STD_PARTITION;
 static dev_t resume_device;
 /* Local variables that should not be affected by save */
 unsigned int nr_copy_pages __nosavedata = 0;
