Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVETOFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVETOFf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 10:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVETN7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:59:51 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:60364 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261459AbVETN4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:56:38 -0400
Subject: [PATCH 4 of 4] ima: module measure extension
From: Reiner Sailer <sailer@watson.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-security-module@mail.wirex.com, kylene@us.ibm.com, emilyr@us.ibm.com,
       toml@us.ibm.com
Content-Type: text/plain
Date: Fri, 20 May 2005 10:01:18 -0400
Message-Id: <1116597678.8426.3.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 4th of 4 patches that constitute the IBM Integrity
Measurement Architecture (IMA). This patch includes a small additional
hook that measures kernel modules before they are relocated. LSM does
not offer a proper hook for this.

This patch applies to the clean 2.6.12-rc4 test kernel.

Signed-off-by: Reiner Sailer <sailer@watson.ibm.com>
---
diff -uprN linux-2.6.12-rc4/include/linux/ima_module.h linux-2.6.12-rc4-ima/include/linux/ima_module.h
--- linux-2.6.12-rc4/include/linux/ima_module.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc4-ima/include/linux/ima_module.h	2005-05-19 17:59:19.000000000 -0400
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: TBD
+ *
+ * LSM IBM Integrity Measurement Architecture.		  
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_module.h
+ *             define modules measurement hook (no LSM hook) to measure
+ *             modules before they are relocated
+ */
+#ifdef CONFIG_IMA_MEASURE
+extern int ima_terminating;
+extern void measure_kernel_module(void *start, unsigned long len, void *uargs);
+
+static inline void ima_measure_module(void *start, unsigned long len, void *uargs)
+{
+	if (!ima_terminating)
+		measure_kernel_module(start, len, uargs);
+}
+#else
+static inline void ima_measure_module(void *start, unsigned long len, void *uargs)
+{
+}
+#endif
diff -uprN linux-2.6.12-rc4/kernel/module.c linux-2.6.12-rc4-ima/kernel/module.c
--- linux-2.6.12-rc4/kernel/module.c	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4-ima/kernel/module.c	2005-05-19 17:59:19.000000000 -0400
@@ -38,6 +38,7 @@
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/cacheflush.h>
+#include <linux/ima_module.h>
 
 #if 0
 #define DEBUGP printk
@@ -1441,6 +1442,8 @@ static struct module *load_module(void _
 	if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr))
 		goto truncated;
 
+	ima_measure_module((void *)hdr, len, (void *)uargs);
+
 	/* Convenience variables */
 	sechdrs = (void *)hdr + hdr->e_shoff;
 	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;


