Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261313AbSJUKFH>; Mon, 21 Oct 2002 06:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSJUKD2>; Mon, 21 Oct 2002 06:03:28 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:33607 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261308AbSJUKBj>; Mon, 21 Oct 2002 06:01:39 -0400
Date: Mon, 21 Oct 2002 03:16:03 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210211016.g9LAG3921207@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org, yakker@aparity.com
Subject: [PATCH] 2.5.44: lkcd (8/9): dump compression files
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the dump compression modules, which are part of the
entire dump package.  I would have included them in the main
dump.patch, but the patch itself would have been too large to
include on the mailing list.

 dump_gzip.c |  129 +++++++++++++++++++++++++++++++++++++++++++
 dump_rle.c  |  176 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 305 insertions(+)

diff -Naur linux-2.5.44.orig/drivers/dump/dump_gzip.c linux-2.5.44.lkcd/drivers/dump/dump_gzip.c
--- linux-2.5.44.orig/drivers/dump/dump_gzip.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.lkcd/drivers/dump/dump_gzip.c	Sat Oct 19 12:39:15 2002
@@ -0,0 +1,129 @@
+/*
+ * GZIP Compression functions for kernel crash dumps.
+ *
+ * Created by: Matt Robinson (yakker@sourceforge.net)
+ * Copyright 2001 Matt D. Robinson.  All rights reserved.
+ *
+ * This code is released under version 2 of the GNU GPL.
+ */
+
+/* header files */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/dump.h>
+#include <linux/zlib.h>
+#include <linux/vmalloc.h>
+
+/*
+ * -----------------------------------------------------------------------
+ *                       D E F I N I T I O N S
+ * -----------------------------------------------------------------------
+ */
+#define DUMP_MODULE_NAME "dump_gzip"
+#define DUMP_PRINTN(format, args...) \
+	printk("%s: " format , DUMP_MODULE_NAME , ## args);
+#define DUMP_PRINT(format, args...) \
+	printk(format , ## args);
+
+static void *deflate_workspace;
+
+/*
+ * Name: dump_compress_gzip()
+ * Func: Compress a DUMP_PAGE_SIZE page using gzip-style algorithms (the.
+ *       deflate functions similar to what's used in PPP).
+ */
+static int
+dump_compress_gzip(char *old, int oldsize, char *new, int newsize)
+{
+	/* error code and dump stream */
+	int err;
+	z_stream dump_stream;
+	
+	dump_stream.workspace = deflate_workspace;
+	
+	if ((err = zlib_deflateInit(&dump_stream, Z_BEST_COMPRESSION)) != Z_OK) {
+		/* fall back to RLE compression */
+		DUMP_PRINT("dump_compress_gzip(): zlib_deflateInit() "
+			"failed (%d)!\n", err);
+		return (0);
+	}
+
+	/* use old (page of memory) and size (DUMP_PAGE_SIZE) as in-streams */
+	dump_stream.next_in = old;
+	dump_stream.avail_in = oldsize;
+
+	/* out streams are new (dpcpage) and new size (DUMP_DPC_PAGE_SIZE) */
+	dump_stream.next_out = new;
+	dump_stream.avail_out = newsize;
+
+	/* deflate the page -- check for error */
+	err = zlib_deflate(&dump_stream, Z_FINISH);
+	if (err != Z_STREAM_END) {
+		/* zero is return code here */
+		(void)zlib_deflateEnd(&dump_stream);
+		DUMP_PRINT("dump_compress_gzip():zlib_deflate() failed (%d)!\n",
+			err);
+		return (0);
+	}
+
+	/* let's end the deflated compression stream */
+	if ((err = zlib_deflateEnd(&dump_stream)) != Z_OK) {
+		DUMP_PRINT("dump_compress_gzip(): zlib_deflateEnd() "
+			"failed (%d)!\n", err);
+	}
+
+	/* return the compressed byte total (if it's smaller) */
+	if (dump_stream.total_out >= oldsize) {
+		return (oldsize);
+	}
+	return (dump_stream.total_out);
+}
+
+/* setup the gzip compression functionality */
+static dump_compress_t dump_gzip_compression = {
+	compress_type:	DUMP_COMPRESS_GZIP,
+	compress_func:	dump_compress_gzip,
+};
+
+/*
+ * Name: dump_compress_gzip_init()
+ * Func: Initialize gzip as a compression mechanism.
+ */
+int __init
+dump_compress_gzip_init(void)
+{
+	deflate_workspace = vmalloc(zlib_deflate_workspacesize());
+	if (!deflate_workspace) {
+		DUMP_PRINT("Failed to alloc %d bytes for deflate workspace\n",
+			zlib_deflate_workspacesize());
+		return -ENOMEM;
+	}
+	dump_register_compression(&dump_gzip_compression);
+	return (0);
+}
+
+/*
+ * Name: dump_compress_gzip_cleanup()
+ * Func: Remove gzip as a compression mechanism.
+ */
+void __exit
+dump_compress_gzip_cleanup(void)
+{
+	vfree(deflate_workspace);
+	dump_unregister_compression(DUMP_COMPRESS_GZIP);
+}
+
+/* module initialization */
+module_init(dump_compress_gzip_init);
+module_exit(dump_compress_gzip_cleanup);
+
+#ifdef MODULE
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,16))
+MODULE_LICENSE("GPL");
+#endif
+#endif /* MODULE */
diff -Naur linux-2.5.44.orig/drivers/dump/dump_rle.c linux-2.5.44.lkcd/drivers/dump/dump_rle.c
--- linux-2.5.44.orig/drivers/dump/dump_rle.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.44.lkcd/drivers/dump/dump_rle.c	Sat Oct 19 12:39:15 2002
@@ -0,0 +1,176 @@
+/*
+ * RLE Compression functions for kernel crash dumps.
+ *
+ * Created by: Matt Robinson (yakker@sourceforge.net)
+ * Copyright 2001 Matt D. Robinson.  All rights reserved.
+ *
+ * This code is released under version 2 of the GNU GPL.
+ */
+
+/* header files */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/init.h>
+#include <linux/dump.h>
+
+/*
+ * Name: dump_compress_rle()
+ * Func: Compress a DUMP_PAGE_SIZE (hardware) page down to something more reasonable,
+ *       if possible.  This is the same routine we use in IRIX.
+ */
+static int
+dump_compress_rle(char *old, int oldsize, char *new, int newsize)
+{
+	int ri, wi, count = 0;
+	u_char value = 0, cur_byte;
+
+	/*
+	 * If the block should happen to "compress" to larger than the
+	 * buffer size, allocate a larger one and change cur_buf_size.
+	 */
+
+	wi = ri = 0;
+
+	while (ri < oldsize) {
+		if (!ri) {
+			cur_byte = value = old[ri];
+			count = 0;
+		} else {
+			if (count == 255) {
+				if (wi + 3 > oldsize) {
+					return oldsize;
+				}
+				new[wi++] = 0;
+				new[wi++] = count;
+				new[wi++] = value;
+				value = cur_byte = old[ri];
+				count = 0;
+			} else { 
+				if ((cur_byte = old[ri]) == value) {
+					count++;
+				} else {
+					if (count > 1) {
+						if (wi + 3 > oldsize) {
+							return oldsize;
+						}
+						new[wi++] = 0;
+						new[wi++] = count;
+						new[wi++] = value;
+					} else if (count == 1) {
+						if (value == 0) {
+							if (wi + 3 > oldsize) {
+								return oldsize;
+							}
+							new[wi++] = 0;
+							new[wi++] = 1;
+							new[wi++] = 0;
+						} else {
+							if (wi + 2 > oldsize) {
+								return oldsize;
+							}
+							new[wi++] = value;
+							new[wi++] = value;
+						}
+					} else { /* count == 0 */
+						if (value == 0) {
+							if (wi + 2 > oldsize) {
+								return oldsize;
+							}
+							new[wi++] = value;
+							new[wi++] = value;
+						} else {
+							if (wi + 1 > oldsize) {
+								return oldsize;
+							}
+							new[wi++] = value;
+						}
+					} /* if count > 1 */
+
+					value = cur_byte;
+					count = 0;
+
+				} /* if byte == value */
+
+			} /* if count == 255 */
+
+		} /* if ri == 0 */
+		ri++;
+
+	}
+	if (count > 1) {
+		if (wi + 3 > oldsize) {
+			return oldsize;
+		}
+		new[wi++] = 0;
+		new[wi++] = count;
+		new[wi++] = value;
+	} else if (count == 1) {
+		if (value == 0) {
+			if (wi + 3 > oldsize)
+				return oldsize;
+			new[wi++] = 0;
+			new[wi++] = 1;
+			new[wi++] = 0;
+		} else {
+			if (wi + 2 > oldsize)
+				return oldsize;
+			new[wi++] = value;
+			new[wi++] = value;
+		}
+	} else { /* count == 0 */
+		if (value == 0) {
+			if (wi + 2 > oldsize)
+				return oldsize;
+			new[wi++] = value;
+			new[wi++] = value;
+		} else {
+			if (wi + 1 > oldsize)
+				return oldsize;
+			new[wi++] = value;
+		}
+	} /* if count > 1 */
+
+	value = cur_byte;
+	count = 0;
+	return (wi);
+}
+
+/* setup the rle compression functionality */
+static dump_compress_t dump_rle_compression = {
+	compress_type:	DUMP_COMPRESS_RLE,
+	compress_func:	dump_compress_rle,
+};
+
+/*
+ * Name: dump_compress_rle_init()
+ * Func: Initialize rle compression for dumping.
+ */
+int __init
+dump_compress_rle_init(void)
+{
+	dump_register_compression(&dump_rle_compression);
+	return (0);
+}
+
+/*
+ * Name: dump_compress_rle_cleanup()
+ * Func: Remove rle compression for dumping.
+ */
+void __exit
+dump_compress_rle_cleanup(void)
+{
+	dump_unregister_compression(DUMP_COMPRESS_RLE);
+}
+
+/* module initialization */
+module_init(dump_compress_rle_init);
+module_exit(dump_compress_rle_cleanup);
+
+#ifdef MODULE
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,16))
+MODULE_LICENSE("GPL");
+#endif
+#endif /* MODULE */
