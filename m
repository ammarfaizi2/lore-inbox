Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWAWXbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWAWXbU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 18:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWAWXbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 18:31:19 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:42689 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030213AbWAWXbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 18:31:19 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] swsusp: use bytes as image size units
Date: Tue, 24 Jan 2006 00:32:26 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601240032.26735.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch makes swsusp use bytes as the image size units, which is needed
for future compatibility.

The patch changes the behavior of the /sys/power/image_size attribute already
present in 2.6.16-rc1, so it is against this kernel.

Please apply (Pavel, please ack).

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 Documentation/power/interface.txt |    2 +-
 Documentation/power/swsusp.txt    |    2 +-
 kernel/power/disk.c               |    6 +++---
 kernel/power/power.h              |    4 ++--
 kernel/power/swsusp.c             |    8 ++++----
 5 files changed, 11 insertions(+), 11 deletions(-)

Index: linux-2.6.16-rc1/kernel/power/power.h
===================================================================
--- linux-2.6.16-rc1.orig/kernel/power/power.h	2006-01-23 15:33:46.000000000 +0100
+++ linux-2.6.16-rc1/kernel/power/power.h	2006-01-23 15:43:40.000000000 +0100
@@ -51,8 +51,8 @@
 extern unsigned int nr_copy_pages;
 extern struct pbe *pagedir_nosave;
 
-/* Preferred image size in MB (default 500) */
-extern unsigned int image_size;
+/* Preferred image size in bytes (default 500 MB) */
+extern unsigned long image_size;
 
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
Index: linux-2.6.16-rc1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.16-rc1.orig/kernel/power/swsusp.c	2006-01-23 15:33:46.000000000 +0100
+++ linux-2.6.16-rc1/kernel/power/swsusp.c	2006-01-23 15:43:40.000000000 +0100
@@ -70,12 +70,12 @@
 #include "power.h"
 
 /*
- * Preferred image size in MB (tunable via /sys/power/image_size).
+ * Preferred image size in bytes (tunable via /sys/power/image_size).
  * When it is set to N, swsusp will do its best to ensure the image
- * size will not exceed N MB, but if that is impossible, it will
+ * size will not exceed N bytes, but if that is impossible, it will
  * try to create the smallest image possible.
  */
-unsigned int image_size = 500;
+unsigned long image_size = 500 * 1024 * 1024;
 
 #ifdef CONFIG_HIGHMEM
 unsigned int count_highmem_pages(void);
@@ -590,7 +590,7 @@
 			if (!tmp)
 				return -ENOMEM;
 			pages += tmp;
-		} else if (size > (image_size * 1024 * 1024) / PAGE_SIZE) {
+		} else if (size > image_size / PAGE_SIZE) {
 			tmp = shrink_all_memory(SHRINK_BITE);
 			pages += tmp;
 		}
Index: linux-2.6.16-rc1/Documentation/power/swsusp.txt
===================================================================
--- linux-2.6.16-rc1.orig/Documentation/power/swsusp.txt	2006-01-23 15:33:15.000000000 +0100
+++ linux-2.6.16-rc1/Documentation/power/swsusp.txt	2006-01-23 15:43:40.000000000 +0100
@@ -27,7 +27,7 @@
 
 echo platform > /sys/power/disk; echo disk > /sys/power/state
 
-If you want to limit the suspend image size to N megabytes, do
+If you want to limit the suspend image size to N bytes, do
 
 echo N > /sys/power/image_size
 
Index: linux-2.6.16-rc1/Documentation/power/interface.txt
===================================================================
--- linux-2.6.16-rc1.orig/Documentation/power/interface.txt	2006-01-23 15:33:15.000000000 +0100
+++ linux-2.6.16-rc1/Documentation/power/interface.txt	2006-01-23 15:43:40.000000000 +0100
@@ -44,7 +44,7 @@
 /sys/power/image_size controls the size of the image created by
 the suspend-to-disk mechanism.  It can be written a string
 representing a non-negative integer that will be used as an upper
-limit of the image size, in megabytes.  The suspend-to-disk mechanism will
+limit of the image size, in bytes.  The suspend-to-disk mechanism will
 do its best to ensure the image size will not exceed that number.  However,
 if this turns out to be impossible, it will try to suspend anyway using the
 smallest image possible.  In particular, if "0" is written to this file, the
Index: linux-2.6.16-rc1/kernel/power/disk.c
===================================================================
--- linux-2.6.16-rc1.orig/kernel/power/disk.c	2006-01-23 15:33:46.000000000 +0100
+++ linux-2.6.16-rc1/kernel/power/disk.c	2006-01-23 15:43:40.000000000 +0100
@@ -367,14 +367,14 @@
 
 static ssize_t image_size_show(struct subsystem * subsys, char *buf)
 {
-	return sprintf(buf, "%u\n", image_size);
+	return sprintf(buf, "%lu\n", image_size);
 }
 
 static ssize_t image_size_store(struct subsystem * subsys, const char * buf, size_t n)
 {
-	unsigned int size;
+	unsigned long size;
 
-	if (sscanf(buf, "%u", &size) == 1) {
+	if (sscanf(buf, "%lu", &size) == 1) {
 		image_size = size;
 		return n;
 	}
