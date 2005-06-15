Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVFOOx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVFOOx0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVFOOx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:53:26 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:36304 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261159AbVFOOxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:53:13 -0400
Subject: [PATCH] 4 of 5 IMA: module measurement patch
From: Reiner Sailer <sailer@watson.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@mail.wirex.com>
Cc: Chris Wright <chrisw@osdl.org>, Greg KH <greg@kroah.com>,
       Kylene Hall <kylene@us.ibm.com>, Emily Rattlif <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, Reiner Sailer <sailer@us.ibm.com>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 10:57:23 -0400
Message-Id: <1118847443.2269.22.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies against linux-2.6.12-rc6-mm1 and provides an additional
measurement hook for measuring kernel modules before they are relocated
and available. At this point, the modules are still an exact copy of the 
file on the disk and yield representative measurements.

This is a kernel patch because we could not find a fitting LSM-hook.

Signed-off-by: Reiner Sailer <sailer@watson.ibm.com>
---


diff -uprN linux-2.6.12-rc6-mm1_orig/include/linux/ima_module.h linux-2.6.12-rc6-mm1-ima/include/linux/ima_module.h
--- linux-2.6.12-rc6-mm1_orig/include/linux/ima_module.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.12-rc6-mm1-ima/include/linux/ima_module.h	2005-06-14 16:25:13.000000000 -0400
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2005 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * Maintained by: Reiner Sailer <sailer@watson.ibm.com>
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
+extern void measure_kernel_module(void *start, unsigned long len, const char __user *uargs);
+
+static inline void ima_measure_module(void *start, unsigned long len, const char __user *uargs)
+{
+	if (!ima_terminating)
+		measure_kernel_module(start, len, uargs);
+}
+#else
+static inline void ima_measure_module(void *start, unsigned long len, const char __user *uargs)
+{
+}
+#endif
diff -uprN linux-2.6.12-rc6-mm1_orig/kernel/module.c linux-2.6.12-rc6-mm1-ima/kernel/module.c
--- linux-2.6.12-rc6-mm1_orig/kernel/module.c	2005-06-14 11:34:27.000000000 -0400
+++ linux-2.6.12-rc6-mm1-ima/kernel/module.c	2005-06-14 16:25:13.000000000 -0400
@@ -39,6 +39,7 @@
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <asm/cacheflush.h>
+#include <linux/ima_module.h>
 
 #if 0
 #define DEBUGP printk
@@ -1531,6 +1532,8 @@ static struct module *load_module(void _
 	if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr))
 		goto truncated;
 
+	ima_measure_module((void *)hdr, len, uargs);
+
 	/* Convenience variables */
 	sechdrs = (void *)hdr + hdr->e_shoff;
 	secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;


