Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbUKHOvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbUKHOvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUKHOdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:33:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57024 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261845AbUKHOcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:32:52 -0500
Date: Mon, 8 Nov 2004 14:32:40 GMT
Message-Id: <200411081432.iA8EWewv023403@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH] Termio userspace access error handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch creates a generic set of termio userspace access functions
with proper error handling. None of the current archs check for errors in this
case.

Signed-Off-By: dhowells@redhat.com
---
diffstat termio-2610rc1mm3.diff
 termios.h |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-generic/termios.h linux-2.6.10-rc1-mm3-frv/include/asm-generic/termios.h
--- /warthog/kernels/linux-2.6.10-rc1-mm3/include/asm-generic/termios.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/include/asm-generic/termios.h	2004-11-05 14:13:04.332459541 +0000
@@ -0,0 +1,69 @@
+/* termios.h: generic termios/termio user copying/translation
+ */
+
+#ifndef _ASM_GENERIC_TERMIOS_H
+#define _ASM_GENERIC_TERMIOS_H
+
+#include <asm/uaccess.h>
+
+#ifndef __ARCH_TERMIO_GETPUT
+
+/*
+ * Translate a "termio" structure into a "termios". Ugh.
+ */
+static inline int user_termio_to_kernel_termios(struct termios *termios,
+						struct termio __user *termio)
+{
+	unsigned short tmp;
+
+	if (get_user(tmp, &termio->c_iflag) < 0)
+		goto fault;
+	termios->c_iflag = (0xffff0000 & termios->c_iflag) | tmp;
+
+	if (get_user(tmp, &termio->c_oflag) < 0)
+		goto fault;
+	termios->c_oflag = (0xffff0000 & termios->c_oflag) | tmp;
+
+	if (get_user(tmp, &termio->c_cflag) < 0)
+		goto fault;
+	termios->c_cflag = (0xffff0000 & termios->c_cflag) | tmp;
+
+	if (get_user(tmp, &termio->c_lflag) < 0)
+		goto fault;
+	termios->c_lflag = (0xffff0000 & termios->c_lflag) | tmp;
+
+	if (get_user(termios->c_line, &termio->c_line) < 0)
+		goto fault;
+
+	if (copy_from_user(termios->c_cc, termio->c_cc, NCC) != 0)
+		goto fault;
+
+	return 0;
+
+ fault:
+	return -EFAULT;
+}
+
+/*
+ * Translate a "termios" structure into a "termio". Ugh.
+ */
+static inline int kernel_termios_to_user_termio(struct termio __user *termio,
+						struct termios *termios)
+{
+	if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
+	    put_user(termios->c_oflag, &termio->c_oflag) < 0 ||
+	    put_user(termios->c_cflag, &termio->c_cflag) < 0 ||
+	    put_user(termios->c_lflag, &termio->c_lflag) < 0 ||
+	    put_user(termios->c_line,  &termio->c_line) < 0 ||
+	    copy_to_user(termio->c_cc, termios->c_cc, NCC) != 0)
+		return -EFAULT;
+
+	return 0;
+}
+
+#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
+#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
+
+#endif	/* __ARCH_TERMIO_GETPUT */
+
+#endif /* _ASM_GENERIC_TERMIOS_H */
