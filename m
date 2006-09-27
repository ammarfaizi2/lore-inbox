Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030508AbWI0R7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030508AbWI0R7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbWI0R7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:59:34 -0400
Received: from [198.99.130.12] ([198.99.130.12]:49843 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030512AbWI0R7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 13:59:32 -0400
Message-Id: <200609271757.k8RHvsX1005737@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/5] UML - Locking documentation
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Sep 2006 13:57:54 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some locking documentation and a cleanup.  uml_exitcode is copied
into a local before sprintf sees it, in case sprintf does anything
non-atomic with it.

The rest are comments about why certain globals don't need any kind
of locking.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
---

 arch/um/drivers/null.c           |    1 +
 arch/um/drivers/random.c         |    4 ++++
 arch/um/drivers/stderr_console.c |    2 ++
 arch/um/drivers/stdio_console.c  |    1 +
 arch/um/kernel/exitcode.c        |    8 ++++++--
 5 files changed, 14 insertions(+), 2 deletions(-)

Index: linux-2.6.18-mm/arch/um/kernel/exitcode.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/exitcode.c	2006-09-26 16:28:49.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/exitcode.c	2006-09-26 16:29:14.000000000 -0400
@@ -16,9 +16,13 @@ int uml_exitcode = 0;
 static int read_proc_exitcode(char *page, char **start, off_t off,
 			      int count, int *eof, void *data)
 {
-	int len;
+	int len, val;
 
-	len = sprintf(page, "%d\n", uml_exitcode);
+	/* Save uml_exitcode in a local so that we don't need to guarantee
+	 * that sprintf accesses it atomically.
+	 */
+	val = uml_exitcode;
+	len = sprintf(page, "%d\n", val);
 	len -= off;
 	if(len <= off+count) *eof = 1;
 	*start = page + off;
Index: linux-2.6.18-mm/arch/um/drivers/null.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/null.c	2006-09-26 16:28:49.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/null.c	2006-09-26 16:29:39.000000000 -0400
@@ -8,6 +8,7 @@
 #include "chan_user.h"
 #include "os.h"
 
+/* This address is used only as a unique identifer */
 static int null_chan;
 
 static void *null_init(char *str, int device, const struct chan_opts *opts)
Index: linux-2.6.18-mm/arch/um/drivers/random.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/random.c	2006-09-26 16:28:49.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/random.c	2006-09-26 16:29:39.000000000 -0400
@@ -20,6 +20,10 @@
 
 #define RNG_MISCDEV_MINOR		183 /* official */
 
+/* Changed at init time, in the non-modular case, and at module load
+ * time, in the module case.  Presumably, the module subsystem
+ * protects against a module being loaded twice at the same time.
+ */
 static int random_fd = -1;
 
 static int rng_dev_open (struct inode *inode, struct file *filp)
Index: linux-2.6.18-mm/arch/um/drivers/stderr_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stderr_console.c	2006-09-26 16:28:49.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/stderr_console.c	2006-09-26 16:29:39.000000000 -0400
@@ -9,6 +9,8 @@
 /*
  * Don't register by default -- as this registeres very early in the
  * boot process it becomes the default console.
+ *
+ * Initialized at init time.
  */
 static int use_stderr_console = 0;
 
Index: linux-2.6.18-mm/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/stdio_console.c	2006-09-26 16:28:49.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/stdio_console.c	2006-09-26 16:29:39.000000000 -0400
@@ -107,6 +107,7 @@ static int con_open(struct tty_struct *t
 	return line_open(vts, tty);
 }
 
+/* Set in an initcall, checked in an exitcall */
 static int con_init_done = 0;
 
 static const struct tty_operations console_ops = {

