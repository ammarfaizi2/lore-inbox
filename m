Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268533AbTANCrc>; Mon, 13 Jan 2003 21:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268530AbTANCqb>; Mon, 13 Jan 2003 21:46:31 -0500
Received: from dp.samba.org ([66.70.73.150]:27532 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268531AbTANCqA>;
	Mon, 13 Jan 2003 21:46:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, trivial@rustcorp.com.au,
       Neil Brown <neilb@cse.unsw.edu.au>, dwmw2@redhat.com
Subject: [PATCH] [TRIVIAL] kstrdup
Date: Tue, 14 Jan 2003 12:55:40 +1100
Message-Id: <20030114025452.656612C385@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone loves reimplementing strdup.  Give them a kstrdup (basically
from drivers/md).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: kstrdup
Author: Neil Brown and Rusty Russell
Status: Trivial

D: Everyone loves reimplementing strdup.  Give them a kstrdup.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/md/dm-ioctl.c working-2.5-bk-kstrdup/drivers/md/dm-ioctl.c
--- linux-2.5-bk/drivers/md/dm-ioctl.c	2003-01-02 12:47:01.000000000 +1100
+++ working-2.5-bk-kstrdup/drivers/md/dm-ioctl.c	2003-01-06 15:47:26.000000000 +1100
@@ -14,6 +14,7 @@
 #include <linux/wait.h>
 #include <linux/blk.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 #include <asm/uaccess.h>
 
@@ -118,14 +119,6 @@ static struct hash_cell *__get_uuid_cell
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
@@ -135,7 +128,7 @@ static struct hash_cell *alloc_cell(cons
 	if (!hc)
 		return NULL;
 
-	hc->name = kstrdup(name);
+	hc->name = kstrdup(name, GFP_KERNEL);
 	if (!hc->name) {
 		kfree(hc);
 		return NULL;
@@ -145,7 +138,7 @@ static struct hash_cell *alloc_cell(cons
 		hc->uuid = NULL;
 
 	else {
-		hc->uuid = kstrdup(uuid);
+		hc->uuid = kstrdup(uuid, GFP_KERNEL);
 		if (!hc->uuid) {
 			kfree(hc->name);
 			kfree(hc);
@@ -266,7 +259,7 @@ int dm_hash_rename(const char *old, cons
 	/*
 	 * duplicate new.
 	 */
-	new_name = kstrdup(new);
+	new_name = kstrdup(new, GFP_KERNEL);
 	if (!new_name)
 		return -ENOMEM;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/include/linux/string.h working-2.5-bk-kstrdup/include/linux/string.h
--- linux-2.5-bk/include/linux/string.h	2003-01-02 12:35:15.000000000 +1100
+++ working-2.5-bk-kstrdup/include/linux/string.h	2003-01-06 15:48:24.000000000 +1100
@@ -78,6 +78,8 @@ extern int memcmp(const void *,const voi
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
 
+extern char *kstrdup(const char *s, int gfp);
+
 #ifdef __cplusplus
 }
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/kernel/ksyms.c working-2.5-bk-kstrdup/kernel/ksyms.c
--- linux-2.5-bk/kernel/ksyms.c	2003-01-02 14:48:01.000000000 +1100
+++ working-2.5-bk-kstrdup/kernel/ksyms.c	2003-01-06 15:49:30.000000000 +1100
@@ -577,6 +577,7 @@ EXPORT_SYMBOL(get_write_access);
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);
 EXPORT_SYMBOL(strsep);
+EXPORT_SYMBOL(kstrdup);
 
 /* software interrupts */
 EXPORT_SYMBOL(tasklet_init);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/lib/string.c working-2.5-bk-kstrdup/lib/string.c
--- linux-2.5-bk/lib/string.c	2003-01-02 12:35:15.000000000 +1100
+++ working-2.5-bk-kstrdup/lib/string.c	2003-01-06 15:48:57.000000000 +1100
@@ -525,5 +525,12 @@ void *memchr(const void *s, int c, size_
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
