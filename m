Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTLOAo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 19:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTLOAo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 19:44:56 -0500
Received: from imf24aec.mail.bellsouth.net ([205.152.59.72]:1454 "EHLO
	imf24aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262792AbTLOAov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 19:44:51 -0500
Subject: updated kstrdup
From: Rob Love <rml@tech9.net>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1071449091.1900.21.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sun, 14 Dec 2003 19:44:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty,

Doing some hacking, and I realized I needed a kstrdup().  Refusing to
reinvent it yet again, I went looking for your kstrdup patch.  But the
patch was marked BROKEN and - I being stubborn, and trying the patch
anyway - it did not apply cleanly to the current kernel.

So I updated it for 2.6.0-test11 and (because I am anal) added some
comments.

Patch is attached.

	Rob Love


 drivers/md/dm-ioctl-v1.c |   18 ++++--------------
 drivers/md/dm-ioctl-v4.c |   18 ++++--------------
 include/linux/string.h   |    2 ++
 lib/string.c             |   18 +++++++++++++++++-
 4 files changed, 27 insertions(+), 29 deletions(-)

diff -urN linux-2.6.0-test11/drivers/md/dm-ioctl-v1.c linux/drivers/md/dm-ioctl-v1.c
--- linux-2.6.0-test11/drivers/md/dm-ioctl-v1.c	2003-11-23 20:33:22.000000000 -0500
+++ linux/drivers/md/dm-ioctl-v1.c	2003-12-14 19:18:16.398172760 -0500
@@ -14,6 +14,7 @@
 #include <linux/wait.h>
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/string.h>
 
 #include <asm/uaccess.h>
 
@@ -115,17 +116,6 @@
 	return NULL;
 }
 
-/*-----------------------------------------------------------------
- * Inserting, removing and renaming a device.
- *---------------------------------------------------------------*/
-static inline char *kstrdup(const char *str)
-{
-	char *r = kmalloc(strlen(str) + 1, GFP_KERNEL);
-	if (r)
-		strcpy(r, str);
-	return r;
-}
-
 static struct hash_cell *alloc_cell(const char *name, const char *uuid,
 				    struct mapped_device *md)
 {
@@ -135,7 +125,7 @@
 	if (!hc)
 		return NULL;
 
-	hc->name = kstrdup(name);
+	hc->name = kstrdup(name, GFP_KERNEL);
 	if (!hc->name) {
 		kfree(hc);
 		return NULL;
@@ -145,7 +135,7 @@
 		hc->uuid = NULL;
 
 	else {
-		hc->uuid = kstrdup(uuid);
+		hc->uuid = kstrdup(uuid, GFP_KERNEL);
 		if (!hc->uuid) {
 			kfree(hc->name);
 			kfree(hc);
@@ -264,7 +254,7 @@
 	/*
 	 * duplicate new.
 	 */
-	new_name = kstrdup(new);
+	new_name = kstrdup(new, GFP_KERNEL);
 	if (!new_name)
 		return -ENOMEM;
 
diff -urN linux-2.6.0-test11/drivers/md/dm-ioctl-v4.c linux/drivers/md/dm-ioctl-v4.c
--- linux-2.6.0-test11/drivers/md/dm-ioctl-v4.c	2003-11-23 20:31:04.000000000 -0500
+++ linux/drivers/md/dm-ioctl-v4.c	2003-12-14 19:17:32.234886600 -0500
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/dm-ioctl.h>
+#include <linux/string.h>
 
 #include <asm/uaccess.h>
 
@@ -116,17 +117,6 @@
 	return NULL;
 }
 
-/*-----------------------------------------------------------------
- * Inserting, removing and renaming a device.
- *---------------------------------------------------------------*/
-static inline char *kstrdup(const char *str)
-{
-	char *r = kmalloc(strlen(str) + 1, GFP_KERNEL);
-	if (r)
-		strcpy(r, str);
-	return r;
-}
-
 static struct hash_cell *alloc_cell(const char *name, const char *uuid,
 				    struct mapped_device *md)
 {
@@ -136,7 +126,7 @@
 	if (!hc)
 		return NULL;
 
-	hc->name = kstrdup(name);
+	hc->name =kstrdup(name, GFP_KERNEL);
 	if (!hc->name) {
 		kfree(hc);
 		return NULL;
@@ -146,7 +136,7 @@
 		hc->uuid = NULL;
 
 	else {
-		hc->uuid = kstrdup(uuid);
+		hc->uuid = kstrdup(uuid, GFP_KERNEL);
 		if (!hc->uuid) {
 			kfree(hc->name);
 			kfree(hc);
@@ -268,7 +258,7 @@
 	/*
 	 * duplicate new.
 	 */
-	new_name = kstrdup(new);
+	new_name = kstrdup(new, GFP_KERNEL);
 	if (!new_name)
 		return -ENOMEM;
 
diff -urN linux-2.6.0-test11/include/linux/string.h linux/include/linux/string.h
--- linux-2.6.0-test11/include/linux/string.h	2003-11-23 20:31:47.000000000 -0500
+++ linux/include/linux/string.h	2003-12-14 19:14:31.032433560 -0500
@@ -84,6 +84,8 @@
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
 
+extern char *kstrdup(const char *s, int gfp);
+
 #ifdef __cplusplus
 }
 #endif
diff -urN linux-2.6.0-test11/lib/string.c linux/lib/string.c
--- linux-2.6.0-test11/lib/string.c	2003-11-23 20:32:51.000000000 -0500
+++ linux/lib/string.c	2003-12-14 19:32:52.711952816 -0500
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 
 #ifndef __HAVE_ARCH_STRNICMP
 /**
@@ -584,5 +585,20 @@
 	}
 	return NULL;
 }
-
 #endif
+
+/*
+ * kstrdup - allocate space for and copy an existing string
+ *
+ * @s: the string to duplicate
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ */
+char *kstrdup(const char *s, int gfp)
+{
+	char *buf = kmalloc(strlen(s)+1, gfp);
+	if (buf)
+		strcpy(buf, s);
+	return buf;
+}
+
+EXPORT_SYMBOL(kstrdup);


