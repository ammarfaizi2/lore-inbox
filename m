Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbVLKMSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbVLKMSO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 07:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVLKMSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 07:18:14 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:35539 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751349AbVLKMSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 07:18:13 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: make image size limit tunable
Date: Sun, 11 Dec 2005 12:34:15 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111234.15553.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch makes the suspend image size limit tunable via
/sys/power/image_size.

It is necessary for systems on which there is a limited amount of swap
available for suspend.  It can also be useful for optimizing performance of
swsusp on systems with 1 GB of RAM or more.

This patch depends on the swsusp-limit-image-size patch.

Please apply.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 Documentation/power/interface.txt |   11 +++++++++++
 Documentation/power/swsusp.txt    |    7 ++++++-
 kernel/power/disk.c               |   20 ++++++++++++++++++++
 kernel/power/power.h              |    7 ++-----
 kernel/power/swsusp.c             |   10 +++++++++-
 5 files changed, 48 insertions(+), 7 deletions(-)

Index: linux-2.6.15-rc5-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/power/disk.c	2005-12-07 23:19:03.000000000 +0100
+++ linux-2.6.15-rc5-mm1/kernel/power/disk.c	2005-12-10 21:10:53.000000000 +0100
@@ -367,9 +367,29 @@
 
 power_attr(resume);
 
+static ssize_t image_size_show(struct subsystem * subsys, char *buf)
+{
+	return sprintf(buf, "%u\n", image_size);
+}
+
+static ssize_t image_size_store(struct subsystem * subsys, const char * buf, size_t n)
+{
+	unsigned int size;
+
+	if (sscanf(buf, "%u", &size) == 1) {
+		image_size = size;
+		return n;
+	}
+
+	return -EINVAL;
+}
+
+power_attr(image_size);
+
 static struct attribute * g[] = {
 	&disk_attr.attr,
 	&resume_attr.attr,
+	&image_size_attr.attr,
 	NULL,
 };
 
Index: linux-2.6.15-rc5-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/power/power.h	2005-12-10 20:59:52.000000000 +0100
+++ linux-2.6.15-rc5-mm1/kernel/power/power.h	2005-12-10 21:13:04.000000000 +0100
@@ -52,11 +52,8 @@
 extern unsigned int nr_copy_pages;
 extern struct pbe *pagedir_nosave;
 
-/*
- * Preferred image size in MB (set it to zero to get the smallest
- * image possible)
- */
-#define IMAGE_SIZE	500
+/* Preferred image size in MB (default 500) */
+extern unsigned int image_size;
 
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
Index: linux-2.6.15-rc5-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/power/swsusp.c	2005-12-10 20:59:52.000000000 +0100
+++ linux-2.6.15-rc5-mm1/kernel/power/swsusp.c	2005-12-10 22:21:25.000000000 +0100
@@ -69,6 +69,14 @@
 
 #include "power.h"
 
+/*
+ * Preferred image size in MB (tunable via /sys/power/image_size).
+ * When it is set to N, swsusp will do its best to ensure the image
+ * size will not exceed N MB, but if that is impossible, it will
+ * try to create the smallest image possible.
+ */
+unsigned int image_size = 500;
+
 #ifdef CONFIG_HIGHMEM
 unsigned int count_highmem_pages(void);
 int save_highmem(void);
@@ -647,7 +655,7 @@
 			if (!tmp)
 				return -ENOMEM;
 			pages += tmp;
-		} else if (size > (IMAGE_SIZE * 1024 * 1024) / PAGE_SIZE) {
+		} else if (size > (image_size * 1024 * 1024) / PAGE_SIZE) {
 			tmp = shrink_all_memory(SHRINK_BITE);
 			pages += tmp;
 		}
Index: linux-2.6.15-rc5-mm1/Documentation/power/swsusp.txt
===================================================================
--- linux-2.6.15-rc5-mm1.orig/Documentation/power/swsusp.txt	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc5-mm1/Documentation/power/swsusp.txt	2005-12-10 23:49:08.000000000 +0100
@@ -27,6 +27,11 @@
 
 echo platform > /sys/power/disk; echo disk > /sys/power/state
 
+If you want to limit the suspend image size to N megabytes, do
+
+echo N > /sys/power/image_size
+
+before suspend (it is limited to 500 MB by default).
 
 Encrypted suspend image:
 ------------------------
Index: linux-2.6.15-rc5-mm1/Documentation/power/interface.txt
===================================================================
--- linux-2.6.15-rc5-mm1.orig/Documentation/power/interface.txt	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc5-mm1/Documentation/power/interface.txt	2005-12-10 23:42:39.000000000 +0100
@@ -41,3 +41,14 @@
 It will only change to 'firmware' or 'platform' if the system supports
 it. 
 
+/sys/power/image_size controls the size of the image created by
+the suspend-to-disk mechanism.  It can be written a string
+representing a non-negative integer that will be used as an upper
+limit of the image size, in megabytes.  The suspend-to-disk mechanism will
+do its best to ensure the image size will not exceed that number.  However,
+if this turns out to be impossible, it will try to suspend anyway using the
+smallest image possible.  In particular, if "0" is written to this file, the
+suspend image will be as small as possible.
+
+Reading from this file will display the current image size limit, which
+is set to 500 MB by default.

