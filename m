Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbTE3OhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 10:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTE3OhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 10:37:19 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:39143 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263713AbTE3OhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 10:37:13 -0400
Date: Fri, 30 May 2003 16:49:59 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: matsunaga <matsunaga_kazuhisa@yahoo.co.jp>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH RFC] 1/2 central workspace for zlib
Message-ID: <20030530144959.GA4736@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The following creates a central workspace per cpu for the zlib.  The
original idea was to save memory for embedded, but this should also
improve performance for smp.

Currently, each user of the zlib has to provide a workspace for the
zlib to draw memory from.  Each workspace amounts to 400k for deflate
or 50k for inflate.  Four users exist, as of 2.4.20:
jffs2:	inflate & deflate, initialized once, 450k
cramfs:	inflate,	   initialized once,  50k
zisofs:	inflate,	   initialized once,  50k
ppp:	inflate & deflate, per channel,      450k * n

jffs2 and zisofs protect their workspace with a semaphore, cramfs
doesn't but I'm sure it should (anyone ever tried cramfs on smp or
with preempt?).  This doesn't scale too well on smp, even though few
people on smp should care about those filesystems.

This patch creates an extra workspace of 400k per cpu, that is used
for both inflate and deflate.  One of the central workspaces is used
for users that don't provide their own.  Semaphore protection is done
in zlib_(in|de)flateInit() and zlib_(in|de)flateEnd, so the user has
to call those functions more often to release the semaphores before
returning to userspace.

A second patch converts the three filesystems to use the central zlib,
and a third could convert ppp as well, but that isn't started yet.

The patches have had some basic testing on up with jffs2, but not
more, so handle with care.  Test results are welcome.

Caveats:
With only cramfs (or zisofs) compiled in, this uses 350k more than
before.  Currently everyone pays the price for deflate, whether
necessary or not.  Might make sense to split workspaces up between
inflate and deflate, which hurts some with 50k, but helps others with
350k.  Ideal would be to have the best of both, but I didn't dare to
tackle that problem (yet).

Jörn

-- 
Sometimes, asking the right question is already the answer.
-- Unknown

--- linux-2.4.20/lib/zlib_deflate/deflate.c~zlib_space	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20/lib/zlib_deflate/deflate.c	2003-05-28 15:55:25.000000000 +0200
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
 
--- linux-2.4.20/lib/zlib_inflate/inflate.c~zlib_space	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20/lib/zlib_inflate/inflate.c	2003-05-28 15:55:25.000000000 +0200
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
--- linux-2.4.20/include/linux/zlib.h~zlib_space	2003-04-11 10:37:13.000000000 +0200
+++ linux-2.4.20/include/linux/zlib.h	2003-05-30 16:16:06.000000000 +0200
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
--- linux-2.4.20/lib/Config.in~zlib_space	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20/lib/Config.in	2003-05-28 15:55:25.000000000 +0200
@@ -35,4 +35,14 @@
   fi
 fi
 
+if [ "$CONFIG_ZLIB_INFLATE" = "y" -o \
+     "$CONFIG_ZLIB_DEFLATE" = "y" ]; then
+   define_tristate CONFIG_ZLIB_GENERIC y
+else
+   if [ "$CONFIG_ZLIB_INFLATE" = "m" -o \
+        "$CONFIG_ZLIB_DEFLATE" = "m" ]; then
+      define_tristate CONFIG_ZLIB_GENERIC m
+   fi
+fi
+
 endmenu
--- linux-2.4.20/lib/Makefile~zlib_space	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20/lib/Makefile	2003-05-28 16:05:07.000000000 +0200
@@ -8,7 +8,8 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o rbtree.o
+export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o rbtree.o \
+	zlib_generic.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
 	 bust_spinlocks.o rbtree.o dump_stack.o
@@ -22,6 +23,7 @@
 
 subdir-$(CONFIG_ZLIB_INFLATE) += zlib_inflate
 subdir-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate
+obj-$(CONFIG_ZLIB_GENERIC) += zlib_generic.o
 
 # Include the subdirs, if necessary.
 obj-y += $(join $(subdir-y),$(subdir-y:%=/%.o))
--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.20/lib/zlib_generic.c	2003-05-30 16:19:52.000000000 +0200
@@ -0,0 +1,90 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/zutil.h>
+#include <linux/vmalloc.h>
+
+#include "zlib_inflate/infutil.h" /* for the workspace size */
+#include "zlib_deflate/defutil.h"
+#define MAX(a,b) (a) > (b) ? (a) : (b)
+
+static void *zlib_workspace[NR_CPUS];
+static uint32_t zlib_workspace_free;
+static struct semaphore zlib_workspace_sem;
+static spinlock_t zlib_workspace_free_lock;
+
+void zlib_exit(void)
+{
+	int i;
+
+	for (i=0; i<smp_num_cpus; i++) {
+		vfree(zlib_workspace[i]);
+	}
+}
+
+int __init zlib_init(void)
+{
+	int	 i;
+	size_t	 size;
+
+	zlib_workspace_free = 0;
+	size = MAX(sizeof(struct inflate_workspace),
+		   sizeof(struct deflate_workspace));
+	for (i=0; i<smp_num_cpus; i++) {
+		zlib_workspace[i] = vmalloc(size);
+		if (!zlib_workspace[i]) {
+			zlib_exit();
+			return -ENOMEM;
+		}
+	}
+	zlib_workspace_free = 0xffffffff;
+	sema_init(&zlib_workspace_sem, smp_num_cpus);
+	spin_lock_init(&zlib_workspace_free_lock);
+	return 0;
+}
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
+EXPORT_SYMBOL(zlib_get_workspace);
+EXPORT_SYMBOL(zlib_put_workspace);
+EXPORT_SYMBOL(__zlib_crash_workspace);
+MODULE_AUTHOR("Jörn Engel <joern@wh.fh-wedel.de>");
+MODULE_LICENSE("GPL");
--- linux-2.4.20/include/linux/zutil.h~zlib_space	2003-05-28 15:57:11.000000000 +0200
+++ linux-2.4.20/include/linux/zutil.h	2003-05-30 16:19:05.000000000 +0200
@@ -123,4 +123,7 @@
     return (s2 << 16) | s1;
 }
 
+extern void zlib_get_workspace(z_streamp z);
+extern void zlib_put_workspace(z_streamp z);
+
 #endif /* _Z_UTIL_H */
