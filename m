Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270832AbTHOUgE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 16:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270833AbTHOUgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 16:36:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:26823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270832AbTHOUf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 16:35:57 -0400
Subject: [PATCH] libaio-0.3.93 fix dynamic linking and compatibility
From: Daniel McNeil <daniel@osdl.org>
To: "linux-aio@kvack.org" <linux-aio@kvack.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1060712778.1962.17.camel@ibm-c.pdx.osdl.net>
References: <1060712778.1962.17.camel@ibm-c.pdx.osdl.net>
Content-Type: multipart/mixed; boundary="=-wKekMEi2iWRz8lHzbfXF"
Organization: 
Message-Id: <1060979752.1962.55.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Aug 2003 13:35:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wKekMEi2iWRz8lHzbfXF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I found the problem with the libaio-0.3.93 library.  The changes
which added backward compatibility with older libaio (like 0.3.13)
broke dynamic linking.  FYI, libaio-0.3.92 links dynamically.

Here is a patch to the libaio-0.3.93 which fixes dynamic linking and
adds compatibility with binaries built with the old libraries.  I've
tested the by building binaries on redhat 9 (libaio-0.3.93) and 
redhat 8 (libaio-0.3.13).  I've tested the AIO interfaces on
2.6.0-test2-mm4 using both old and new binaries.

Daniel <daniel@osdl.org>

--=-wKekMEi2iWRz8lHzbfXF
Content-Disposition: attachment; filename=patch.libaio-0.3-93.fix
Content-Type: text/x-patch; name=patch.libaio-0.3-93.fix; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -rupN -X /home/daniel/dontdiff libaio-0.3.93/src/compat-0_1.c libaio-0.3.93-fix.compat/src/compat-0_1.c
--- libaio-0.3.93/src/compat-0_1.c	2002-09-13 15:36:45.000000000 -0700
+++ libaio-0.3.93-fix.compat/src/compat-0_1.c	2003-08-14 17:30:46.444768358 -0700
@@ -57,3 +57,36 @@ int compat0_1_io_getevents(io_context_t 
 			const_timeout ? &timeout : NULL);
 }
 
+/*
+ * Compatible interfaces that still need an entry point.
+ */
+
+SYMVER(compat0_1_io_queue_init, io_queue_init, 0.1);
+int compat0_1_io_queue_init(int maxevents, io_context_t *ctxp)
+{
+	return io_queue_init(maxevents, ctxp);
+}
+
+SYMVER(compat0_1_io_queue_run, io_queue_run, 0.1);
+int compat0_1_io_queue_run(io_context_t ctx)
+{
+	return io_queue_run(ctx);
+}
+
+SYMVER(compat0_1_io_submit, io_submit, 0.1);
+int compat0_1_io_submit(io_context_t ctx, long nr, struct iocb **iocbs)
+{
+        return io_submit(ctx, nr, iocbs);
+}
+
+SYMVER(compat0_1_io_queue_wait, io_queue_wait, 0.1);
+int compat0_1_io_queue_wait(io_context_t ctx, struct timespec *timeout)
+{
+        return io_getevents(ctx, 0, 0, NULL, timeout);
+}
+
+SYMVER(compat0_1_io_queue_release, io_queue_release, 0.1);
+int compat0_1_io_queue_release(io_context_t ctx)
+{
+	return io_destroy(ctx);
+}
diff -rupN -X /home/daniel/dontdiff libaio-0.3.93/src/io_queue_init.c libaio-0.3.93-fix.compat/src/io_queue_init.c
--- libaio-0.3.93/src/io_queue_init.c	2002-09-26 08:56:29.000000000 -0700
+++ libaio-0.3.93-fix.compat/src/io_queue_init.c	2003-08-14 17:45:14.225491960 -0700
@@ -21,9 +21,6 @@
 #include <sys/stat.h>
 #include <errno.h>
 
-#include "syscall.h"
-
-SYMVER(io_queue_init, io_queue_init, 0.1);
 int io_queue_init(int maxevents, io_context_t *ctxp)
 {
 	if (maxevents > 0) {
diff -rupN -X /home/daniel/dontdiff libaio-0.3.93/src/io_submit.c libaio-0.3.93-fix.compat/src/io_submit.c
--- libaio-0.3.93/src/io_submit.c	2002-09-26 08:56:29.000000000 -0700
+++ libaio-0.3.93-fix.compat/src/io_submit.c	2003-08-14 17:49:27.025975498 -0700
@@ -20,5 +20,4 @@
 #include <libaio.h>
 #include "syscall.h"
 
-SYMVER(io_submit, io_submit, 0.1);
 io_syscall3(int, io_submit, io_context_t, ctx, long, nr, struct iocb **, iocbs)

--=-wKekMEi2iWRz8lHzbfXF--

