Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbTHYQPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbTHYQPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:15:17 -0400
Received: from pop.gmx.net ([213.165.64.20]:62408 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261981AbTHYQOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:14:48 -0400
Date: Mon, 25 Aug 2003 19:14:35 +0300
From: Dan Aloni <da-x@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] One strdup() to rule them all
Message-ID: <20030825161435.GB8961@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While working on the fix to network devices names and sysctl,
I fought to urge to create yet another strdup() implementation
This came up.

NOTE: I intentionally avoided changes to UML and ALSA. These were
the only two implementations left.

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1292, 2003-08-25 18:56:50+03:00, da-x@gmx.net
  One strdup() to rule them all.
  
  Unite 6 equal implementations of strdup() to just one.


 drivers/md/dm-ioctl-v1.c      |   14 ++++----------
 drivers/md/dm-ioctl-v4.c      |   14 ++++----------
 drivers/parport/probe.c       |    8 --------
 fs/afs/super.c                |    8 --------
 fs/intermezzo/intermezzo_fs.h |   11 +----------
 include/linux/string.h        |    1 +
 lib/string.c                  |   16 ++++++++++++++++
 net/sunrpc/svcauth_unix.c     |    9 +--------
 8 files changed, 27 insertions(+), 54 deletions(-)


diff -Nru a/drivers/md/dm-ioctl-v1.c b/drivers/md/dm-ioctl-v1.c
--- a/drivers/md/dm-ioctl-v1.c	Mon Aug 25 19:03:26 2003
+++ b/drivers/md/dm-ioctl-v1.c	Mon Aug 25 19:03:26 2003
@@ -14,6 +14,7 @@
 #include <linux/wait.h>
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/string.h>
 
 #include <asm/uaccess.h>
 
@@ -118,13 +119,6 @@
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
 
 static struct hash_cell *alloc_cell(const char *name, const char *uuid,
 				    struct mapped_device *md)
@@ -135,7 +129,7 @@
 	if (!hc)
 		return NULL;
 
-	hc->name = kstrdup(name);
+	hc->name = strdup(name);
 	if (!hc->name) {
 		kfree(hc);
 		return NULL;
@@ -145,7 +139,7 @@
 		hc->uuid = NULL;
 
 	else {
-		hc->uuid = kstrdup(uuid);
+		hc->uuid = strdup(uuid);
 		if (!hc->uuid) {
 			kfree(hc->name);
 			kfree(hc);
@@ -264,7 +258,7 @@
 	/*
 	 * duplicate new.
 	 */
-	new_name = kstrdup(new);
+	new_name = strdup(new);
 	if (!new_name)
 		return -ENOMEM;
 
diff -Nru a/drivers/md/dm-ioctl-v4.c b/drivers/md/dm-ioctl-v4.c
--- a/drivers/md/dm-ioctl-v4.c	Mon Aug 25 19:03:26 2003
+++ b/drivers/md/dm-ioctl-v4.c	Mon Aug 25 19:03:26 2003
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/dm-ioctl.h>
+#include <linux/string.h>
 
 #include <asm/uaccess.h>
 
@@ -119,13 +120,6 @@
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
 
 static struct hash_cell *alloc_cell(const char *name, const char *uuid,
 				    struct mapped_device *md)
@@ -136,7 +130,7 @@
 	if (!hc)
 		return NULL;
 
-	hc->name = kstrdup(name);
+	hc->name = strdup(name);
 	if (!hc->name) {
 		kfree(hc);
 		return NULL;
@@ -146,7 +140,7 @@
 		hc->uuid = NULL;
 
 	else {
-		hc->uuid = kstrdup(uuid);
+		hc->uuid = strdup(uuid);
 		if (!hc->uuid) {
 			kfree(hc->name);
 			kfree(hc);
@@ -268,7 +262,7 @@
 	/*
 	 * duplicate new.
 	 */
-	new_name = kstrdup(new);
+	new_name = strdup(new);
 	if (!new_name)
 		return -ENOMEM;
 
diff -Nru a/drivers/parport/probe.c b/drivers/parport/probe.c
--- a/drivers/parport/probe.c	Mon Aug 25 19:03:26 2003
+++ b/drivers/parport/probe.c	Mon Aug 25 19:03:26 2003
@@ -47,14 +47,6 @@
 	printk("\n");
 }
 
-static char *strdup(char *str)
-{
-	int n = strlen(str)+1;
-	char *s = kmalloc(n, GFP_KERNEL);
-	if (!s) return NULL;
-	return strcpy(s, str);
-}
-
 static void parse_data(struct parport *port, int device, char *str)
 {
 	char *txt = kmalloc(strlen(str)+1, GFP_KERNEL);
diff -Nru a/fs/afs/super.c b/fs/afs/super.c
--- a/fs/afs/super.c	Mon Aug 25 19:03:26 2003
+++ b/fs/afs/super.c	Mon Aug 25 19:03:26 2003
@@ -29,14 +29,6 @@
 
 #define AFS_FS_MAGIC 0x6B414653 /* 'kAFS' */
 
-static inline char *strdup(const char *s)
-{
-	char *ns = kmalloc(strlen(s)+1,GFP_KERNEL);
-	if (ns)
-		strcpy(ns,s);
-	return ns;
-}
-
 static void afs_i_init_once(void *foo, kmem_cache_t *cachep, unsigned long flags);
 
 static struct super_block *afs_get_sb(struct file_system_type *fs_type,
diff -Nru a/fs/intermezzo/intermezzo_fs.h b/fs/intermezzo/intermezzo_fs.h
--- a/fs/intermezzo/intermezzo_fs.h	Mon Aug 25 19:03:26 2003
+++ b/fs/intermezzo/intermezzo_fs.h	Mon Aug 25 19:03:26 2003
@@ -58,6 +58,7 @@
 # include <linux/slab.h>
 # include <linux/vmalloc.h>
 # include <linux/smp_lock.h>
+# include <linux/string.h>
 
 /* fixups for fs.h */
 # ifndef fs_down
@@ -702,16 +703,6 @@
 {
         return (strlen(name) == dentry->d_name.len &&
                 memcmp(name, dentry->d_name.name, dentry->d_name.len) == 0);
-}
-
-static inline char *strdup(char *str)
-{
-        char *tmp;
-        tmp = kmalloc(strlen(str) + 1, GFP_KERNEL);
-        if (tmp)
-                memcpy(tmp, str, strlen(str) + 1);
-               
-        return tmp;
 }
 
 /* buffer MUST be at least the size of izo_ioctl_hdr */
diff -Nru a/include/linux/string.h b/include/linux/string.h
--- a/include/linux/string.h	Mon Aug 25 19:03:26 2003
+++ b/include/linux/string.h	Mon Aug 25 19:03:26 2003
@@ -16,6 +16,7 @@
 extern char * strsep(char **,const char *);
 extern __kernel_size_t strspn(const char *,const char *);
 extern __kernel_size_t strcspn(const char *,const char *);
+extern char * strdup(const char *);
 
 /*
  * Include machine specific inline routines
diff -Nru a/lib/string.c b/lib/string.c
--- a/lib/string.c	Mon Aug 25 19:03:26 2003
+++ b/lib/string.c	Mon Aug 25 19:03:26 2003
@@ -582,3 +582,19 @@
 }
 
 #endif
+
+/**
+ * strdup - Allocate a copy of a string.
+ * @s: The string to copy. Must not be NULL.
+ *
+ * returns the address of the allocation, or NULL on
+ * error. 
+ */
+char *strdup(const char *s)
+{
+	char *rv = kmalloc(strlen(s)+1, GFP_KERNEL);
+	if (rv)
+		strcpy(rv, s);
+	return rv;
+}
+EXPORT_SYMBOL(strdup);
diff -Nru a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
--- a/net/sunrpc/svcauth_unix.c	Mon Aug 25 19:03:26 2003
+++ b/net/sunrpc/svcauth_unix.c	Mon Aug 25 19:03:26 2003
@@ -7,6 +7,7 @@
 #include <linux/err.h>
 #include <linux/seq_file.h>
 #include <linux/hash.h>
+#include <linux/string.h>
 
 #define RPCDBG_FACILITY	RPCDBG_AUTH
 
@@ -18,14 +19,6 @@
  * AUTHNULL as for AUTHUNIX, and that is done here.
  */
 
-
-static char *strdup(char *s)
-{
-	char *rv = kmalloc(strlen(s)+1, GFP_KERNEL);
-	if (rv)
-		strcpy(rv, s);
-	return rv;
-}
 
 struct unix_domain {
 	struct auth_domain	h;

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


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
$%Q@     
 


-- 
Dan Aloni
da-x@gmx.net
