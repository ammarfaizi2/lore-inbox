Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbTHVAoo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 20:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTHVAoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 20:44:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:43394 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262971AbTHVAom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 20:44:42 -0400
Subject: [PATCH] libaio-0.3.96 fix io_queue_wait compatibility
From: Daniel McNeil <daniel@osdl.org>
To: "linux-aio@kvack.org" <linux-aio@kvack.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-b3awYQAAUe3In6Lf7rhk"
Organization: 
Message-Id: <1061513079.32556.5.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Aug 2003 17:44:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b3awYQAAUe3In6Lf7rhk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

libaio-0.3.96 fixes the dynamic linking problem I was having with
libaio-0.3.93, still it has broken backward compatibility with
io_queue_wait().  Here's patch that fixes it.  I've tested binaries
compiled with libaio-0.3.13 and run them on libaio-0.3.96+patch on
2.6.0-test2-mm4.

Daniel


--=-b3awYQAAUe3In6Lf7rhk
Content-Disposition: attachment; filename=patch.libaio-0.3.96.compat.io_queue_wait
Content-Type: text/x-patch; name=patch.libaio-0.3.96.compat.io_queue_wait; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -rupN -X /home/daniel/dontdiff libaio-0.3.96/src/compat-0_1.c libaio-0.3.96.fix/src/compat-0_1.c
--- libaio-0.3.96/src/compat-0_1.c	2003-05-20 08:54:50.000000000 -0700
+++ libaio-0.3.96.fix/src/compat-0_1.c	2003-08-21 17:16:46.000000000 -0700
@@ -38,9 +38,12 @@ int compat0_1_io_cancel(io_context_t ctx
 }
 
 SYMVER(compat0_1_io_queue_wait, io_queue_wait, 0.1);
-int compat0_1_io_queue_wait(io_context_t ctx, struct iocb *iocb, const struct timespec *when)
+int compat0_1_io_queue_wait(io_context_t ctx, const struct timespec *when)
 {
-	return -ENOSYS;
+	struct timespec timeout;
+	if (when)
+		timeout = *when;
+	return io_getevents(ctx, 0, 0, NULL, when ? &timeout : NULL);
 }
 
 

--=-b3awYQAAUe3In6Lf7rhk--

