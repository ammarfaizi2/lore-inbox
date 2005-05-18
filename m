Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVERE2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVERE2X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 00:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVERE2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 00:28:05 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:23565 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262084AbVEREZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 00:25:37 -0400
Message-Id: <200505180420.j4I4KRBG017327@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Subject: [PATCH 5/9] UML - initrd cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 May 2005 00:20:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves all systemcalls from initrd_user.c file under os-Linux dir
and join initrd_user.c and initrd_kern.c files in new file initrd.c

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/Makefile	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/Makefile	2005-05-17 18:12:26.000000000 -0400
@@ -14,7 +14,7 @@ obj-y = config.o exec_kern.o exitcode.o 
 	tlb.o trap_kern.o trap_user.o uaccess_user.o um_arch.o umid.o \
 	user_util.o
 
-obj-$(CONFIG_BLK_DEV_INITRD) += initrd_kern.o initrd_user.o
+obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_GCOV)	+= gmon_syms.o
 obj-$(CONFIG_TTY_LOG)	+= tty_log.o
Index: linux-2.6.12-rc/arch/um/kernel/initrd.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/initrd.c	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/initrd.c	2005-05-17 18:12:26.000000000 -0400
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include "linux/init.h"
+#include "linux/bootmem.h"
+#include "linux/initrd.h"
+#include "asm/types.h"
+#include "user_util.h"
+#include "kern_util.h"
+#include "initrd.h"
+#include "init.h"
+#include "os.h"
+
+/* Changed by uml_initrd_setup, which is a setup */
+static char *initrd __initdata = NULL;
+
+static int __init read_initrd(void)
+{
+	void *area;
+	long long size;
+	int err;
+
+	if(initrd == NULL) return 0;
+	err = os_file_size(initrd, &size);
+	if(err) return 0;
+	area = alloc_bootmem(size);
+	if(area == NULL) return 0;
+	if(load_initrd(initrd, area, size) == -1) return 0;
+	initrd_start = (unsigned long) area;
+	initrd_end = initrd_start + size;
+	return 0;
+}
+
+__uml_postsetup(read_initrd);
+
+static int __init uml_initrd_setup(char *line, int *add)
+{
+	initrd = line;
+	return 0;
+}
+
+__uml_setup("initrd=", uml_initrd_setup, 
+"initrd=<initrd image>\n"
+"    This is used to boot UML from an initrd image.  The argument is the\n"
+"    name of the file containing the image.\n\n"
+);
+
+int load_initrd(char *filename, void *buf, int size)
+{
+	int fd, n;
+
+	fd = os_open_file(filename, of_read(OPENFLAGS()), 0);
+	if(fd < 0){
+		printk("Opening '%s' failed - err = %d\n", filename, -fd);
+		return(-1);
+	}
+	n = os_read_file(fd, buf, size);
+	if(n != size){
+		printk("Read of %d bytes from '%s' failed, err = %d\n", size,
+		       filename, -n);
+		return(-1);
+	}
+
+	os_close_file(fd);
+	return(0);
+}
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */

