Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264802AbTFBRZP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264808AbTFBRZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:25:15 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:20367 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264802AbTFBRZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:25:03 -0400
Date: Mon, 2 Jun 2003 19:38:04 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: James Morris <jmorris@intercode.com.au>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>,
       matsunaga <matsunaga_kazuhisa@yahoo.co.jp>
Subject: [PATCH for testing] central workspace for zlib, take 3
Message-ID: <20030602173804.GD679@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This version picks up a suggestion by Matsunaga and adds a notifier
for added/removed cpus.  Completely untested.

Does anyone know the semantics of cpu notifiers?  When booting a
machine, how often are the notifier functions called? 0?
num_booting_cpus()? num_booting_cpus() - 1?

Jörn

-- 
Data expands to fill the space available for storage.
-- Parkinson's Law

--- linux-2.5.70/lib/zlib_deflate/deflate.c~zlibspace	2003-04-07 19:30:42.000000000 +0200
+++ linux-2.5.70/lib/zlib_deflate/deflate.c	2003-05-31 10:44:52.000000000 +0200
@@ -208,6 +208,7 @@
 
     if (level == Z_DEFAULT_COMPRESSION) level = 6;
 
+    zlib_get_workspace(strm);
     mem = (deflate_workspace *) strm->workspace;
 
     if (windowBits < 0) { /* undocumented feature: suppress zlib header */
@@ -558,6 +559,8 @@
 
     strm->state = Z_NULL;
 
+    zlib_put_workspace(strm);
+
     return status == BUSY_STATE ? Z_DATA_ERROR : Z_OK;
 }
 
--- linux-2.5.70/lib/zlib_inflate/inflate.c~zlibspace	2003-04-07 19:31:23.000000000 +0200
+++ linux-2.5.70/lib/zlib_inflate/inflate.c	2003-05-31 10:44:52.000000000 +0200
@@ -8,6 +8,7 @@
 #include "infblock.h"
 #include "infutil.h"
 
+
 int ZEXPORT zlib_inflate_workspacesize(void)
 {
   return sizeof(struct inflate_workspace);
@@ -35,6 +36,7 @@
   if (z->state->blocks != Z_NULL)
     zlib_inflate_blocks_free(z->state->blocks, z);
   z->state = Z_NULL;
+  zlib_put_workspace(z);
   return Z_OK;
 }
 
@@ -46,12 +48,13 @@
 int stream_size;
 {
   if (version == Z_NULL || version[0] != ZLIB_VERSION[0] ||
-      stream_size != sizeof(z_stream) || z->workspace == Z_NULL)
+      stream_size != sizeof(z_stream))
       return Z_VERSION_ERROR;
 
   /* initialize state */
   if (z == Z_NULL)
     return Z_STREAM_ERROR;
+  zlib_get_workspace(z);
   z->msg = Z_NULL;
   z->state = &WS(z)->internal_state;
   z->state->blocks = Z_NULL;
--- linux-2.5.70/include/linux/zlib.h~zlibspace	2003-04-07 19:31:43.000000000 +0200
+++ linux-2.5.70/include/linux/zlib.h	2003-05-31 10:44:52.000000000 +0200
@@ -78,6 +78,7 @@
     struct internal_state FAR *state; /* not visible by applications */
 
     void     *workspace; /* memory allocated for this stream */
+    int      ws_num;    /* index in the internal workspace array */
 
     int     data_type;  /* best guess about the data type: ascii or binary */
     uLong   adler;      /* adler32 value of the uncompressed data */
@@ -171,6 +172,18 @@
    This check is automatically made by deflateInit and inflateInit.
  */
 
+ZEXTERN void * __zlib_panic_workspace OF((void));
+/*
+ 	BIG FAT WARNING:
+ 	The only valid user of this function is a panic handler. This will
+ 	break for sure in any other case, as it bypasses the locking.
+
+   Returns the first internal workspace. Use this for a panic handler that
+   needs a workspace during panic, but shouldn't waste the memory for it
+   during normal operation.
+*/
+
+
 ZEXTERN int ZEXPORT zlib_deflate_workspacesize OF((void));
 /*
    Returns the number of bytes that needs to be allocated for a per-
--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.70/lib/zlib_generic.c	2003-06-02 19:27:04.000000000 +0200
@@ -0,0 +1,137 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/zutil.h>
+#include <linux/vmalloc.h>
+#include <linux/smp.h>
+#include <linux/notifier.h>
+
+#include "zlib_inflate/infutil.h" /* for the workspace size */
+#include "zlib_deflate/defutil.h"
+#define MAX(a,b) (a) > (b) ? (a) : (b)
+#define WS_SIZE MAX(sizeof(struct inflate_workspace), \
+		    sizeof(struct deflate_workspace))
+
+
+static char zlib_default_workspace[WS_SIZE];
+static void *zlib_workspace[NR_CPUS];
+static unsigned long zlib_workspace_free;
+static struct semaphore zlib_workspace_sem;
+static spinlock_t zlib_workspace_free_lock;
+static int zlib_no_workspaces;
+
+
+void zlib_get_workspace(z_streamp z)
+{
+	if (z->workspace) /* transition period, will remove workspace later */
+		z->ws_num = -1;
+	else {
+		down_interruptible(&zlib_workspace_sem);
+
+		spin_lock(&zlib_workspace_free_lock);
+		z->ws_num = ffs(zlib_workspace_free) - 1;
+		clear_bit(z->ws_num, &zlib_workspace_free);
+		spin_unlock(&zlib_workspace_free_lock);
+
+		z->workspace = zlib_workspace[z->ws_num];
+	}
+}
+
+void zlib_put_workspace(z_streamp z)
+{
+	if (z->ws_num < 0)
+		;
+	else {
+		z->workspace = NULL;
+
+		spin_lock(&zlib_workspace_free_lock);
+		__set_bit(z->ws_num, &zlib_workspace_free);
+		spin_unlock(&zlib_workspace_free_lock);
+
+		up(&zlib_workspace_sem);
+	}
+}
+
+
+static int zlib_cpu_callback(struct notifier_block *nfb,
+			     unsigned long action,
+			     void *hcpu)
+{
+	switch (action) {
+	case CPU_ONLINE:
+		if (zlib_no_workspaces > num_online_cpus())
+			break;
+
+		zlib_workspace[zlib_no_workspaces] = vmalloc(WS_SIZE);
+		if (!zlib_workspace[zlib_no_workspaces])
+			break;
+		zlib_no_workspaces++;
+		up(&zlib_workspace_sem);
+		break;
+
+	case CPU_OFFLINE:
+		if (zlib_no_workspaces < num_online_cpus())
+			break;
+
+		down_interruptible(&zlib_workspace_sem);
+		zlib_no_workspaces--;
+		vfree(zlib_workspace[zlib_no_workspaces]);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+
+static struct notifier_block cpu_nfb = {
+	.notifier_call = zlib_cpu_callback,
+};
+
+void __exit zlib_exit(void)
+{
+	int i;
+
+	unregister_cpu_notifier(&cpu_nfb);
+
+	for (i=1; i<zlib_no_workspaces; i++) {
+		vfree(zlib_workspace[i]);
+	}
+}
+
+int __init zlib_init(void)
+{
+	int	 i;
+
+	zlib_workspace[0] = zlib_default_workspace;
+	zlib_no_workspaces = num_online_cpus();
+
+	for (i=1; i<zlib_no_workspaces; i++) {
+		zlib_workspace[i] = vmalloc(WS_SIZE);
+		if (!zlib_workspace[i]) {
+			zlib_no_workspaces = i-1;
+		}
+	}
+	zlib_workspace_free = 0xffffffff;
+	sema_init(&zlib_workspace_sem, zlib_no_workspaces);
+	spin_lock_init(&zlib_workspace_free_lock);
+
+	register_cpu_notifier(&cpu_nfb);
+
+	return 0;
+}
+
+/**
+ *	BIG FAT WARNING:
+ *	The only valid user of this function is a panic handler. This will
+ *	break for sure in any other case, as it bypasses the locking.
+ */
+void *__zlib_crash_workspace(void)
+{
+	return zlib_workspace[0];
+}
+
+
+EXPORT_SYMBOL(zlib_get_workspace);
+EXPORT_SYMBOL(zlib_put_workspace);
+EXPORT_SYMBOL(__zlib_crash_workspace);
+MODULE_AUTHOR("Jörn Engel <joern@wh.fh-wedel.de>");
+MODULE_LICENSE("GPL");
--- linux-2.5.70/include/linux/zutil.h~zlibspace	2003-04-07 19:31:50.000000000 +0200
+++ linux-2.5.70/include/linux/zutil.h	2003-05-31 10:44:52.000000000 +0200
@@ -123,4 +123,7 @@
     return (s2 << 16) | s1;
 }
 
+extern void zlib_get_workspace(z_streamp z);
+extern void zlib_put_workspace(z_streamp z);
+
 #endif /* _Z_UTIL_H */
--- linux-2.5.70/lib/Makefile~zlibspace	2003-05-28 21:39:14.000000000 +0200
+++ linux-2.5.70/lib/Makefile	2003-05-31 10:49:36.000000000 +0200
@@ -24,6 +24,7 @@
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
+obj-$(CONFIG_ZLIB_DEFLATE) += zlib_generic.o
 
 include $(TOPDIR)/drivers/net/Makefile.lib
 include $(TOPDIR)/drivers/usb/Makefile.lib
--- linux-2.5.70/lib/Kconfig~zlibspace	2003-04-07 19:31:46.000000000 +0200
+++ linux-2.5.70/lib/Kconfig	2003-05-31 10:48:52.000000000 +0200
@@ -26,5 +26,10 @@
 		(PPP_DEFLATE=m || JFFS2_FS=m || CRYPTO_DEFLATE=m)
 	default y if PPP_DEFLATE=y || JFFS2_FS=y || CRYPTO_DEFLATE=y
 
+config ZLIB_GENERIC
+	tristate
+	default m if ZLIB_DEFLATE=m || ZLIB_INFLATE=m
+	default y if ZLIB_DEFLATE=y || ZLIB_INFLATE=y
+
 endmenu
 
