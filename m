Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTDRHuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 03:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbTDRHuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 03:50:17 -0400
Received: from dp.samba.org ([66.70.73.150]:39903 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262932AbTDRHuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 03:50:08 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] kstrdup
Date: Fri, 18 Apr 2003 17:58:10 +1000
Message-Id: <20030418080205.A21702C2E1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Rusty Russell <rusty@rustcorp.com.au>

  Everyone loves reimplementing strdup.  Give them a kstrdup (basically
  from drivers/md).
  
  Rusty.
  --
    Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
  
  Name: kstrdup
  Author: Neil Brown and Rusty Russell
  Status: Trivial
  
  D: Everyone loves reimplementing strdup.  Give them a kstrdup.
  

--- trivial-2.5.67-bk8/drivers/md/dm-ioctl.c.orig	2003-04-18 17:43:57.000000000 +1000
+++ trivial-2.5.67-bk8/drivers/md/dm-ioctl.c	2003-04-18 17:43:57.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/wait.h>
 #include <linux/blk.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 #include <asm/uaccess.h>
 
@@ -118,14 +119,6 @@
 /*-----------------------------------------------------------------
  * Inserting, removing and renaming a device.
  *---------------------------------------------------------------*/
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
@@ -135,7 +128,7 @@
 	if (!hc)
 		return NULL;
 
-	hc->name = kstrdup(name);
+	hc->name = kstrdup(name, GFP_KERNEL);
 	if (!hc->name) {
 		kfree(hc);
 		return NULL;
@@ -145,7 +138,7 @@
 		hc->uuid = NULL;
 
 	else {
-		hc->uuid = kstrdup(uuid);
+		hc->uuid = kstrdup(uuid, GFP_KERNEL);
 		if (!hc->uuid) {
 			kfree(hc->name);
 			kfree(hc);
@@ -270,7 +263,7 @@
 	/*
 	 * duplicate new.
 	 */
-	new_name = kstrdup(new);
+	new_name = kstrdup(new, GFP_KERNEL);
 	if (!new_name)
 		return -ENOMEM;
 
--- trivial-2.5.67-bk8/include/linux/string.h.orig	2003-04-18 17:43:57.000000000 +1000
+++ trivial-2.5.67-bk8/include/linux/string.h	2003-04-18 17:43:57.000000000 +1000
@@ -78,6 +78,8 @@
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
 
+extern char *kstrdup(const char *s, int gfp);
+
 #ifdef __cplusplus
 }
 #endif
--- trivial-2.5.67-bk8/kernel/ksyms.c.orig	2003-04-18 17:43:57.000000000 +1000
+++ trivial-2.5.67-bk8/kernel/ksyms.c	2003-04-18 17:43:57.000000000 +1000
@@ -585,6 +585,7 @@
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);
 EXPORT_SYMBOL(strsep);
+EXPORT_SYMBOL(kstrdup);
 
 /* software interrupts */
 EXPORT_SYMBOL(tasklet_init);
--- trivial-2.5.67-bk8/lib/string.c.orig	2003-04-18 17:43:57.000000000 +1000
+++ trivial-2.5.67-bk8/lib/string.c	2003-04-18 17:43:57.000000000 +1000
@@ -22,6 +22,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <linux/slab.h>
 
 #ifndef __HAVE_ARCH_STRNICMP
 /**
@@ -525,5 +526,12 @@
 	}
 	return NULL;
 }
-
 #endif
+
+char *kstrdup(const char *s, int gfp)
+{
+	char *buf = kmalloc(strlen(s)+1, gfp);
+	if (buf)
+		strcpy(buf, s);
+	return buf;
+}
-- 
  Don't blame me: the Monkey is driving
  File: Rusty Russell <rusty@rustcorp.com.au>: [PATCH] [TRIVIAL] kstrdup
