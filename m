Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268839AbUJPUNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268839AbUJPUNY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268846AbUJPUNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:13:24 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:42174 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268839AbUJPULJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:11:09 -0400
Subject: [PATCH] fix pcmcia probing to work on parisc
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: willy@debian.org, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 16 Oct 2004 15:10:44 -0500
Message-Id: <1097957451.2283.336.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

This is the last piece of our parisc PCMCIA puzzle after I converted the
original code to use the new resource manager stuff.  Basically, we
can't be probed either on memory or on I/O.  Since it looks like the
other two arm architectures which don't set CONFIG_PCMCIA_PROBE still do
memory probing, I introduced a new option to control this
(CONFIG_PCMCIA_PROBE_MEM).

James

===== drivers/pcmcia/Kconfig 1.11 vs edited =====
--- 1.11/drivers/pcmcia/Kconfig	2004-06-19 12:10:24 -05:00
+++ edited/drivers/pcmcia/Kconfig	2004-10-16 09:49:49 -05:00
@@ -136,7 +136,11 @@
 
 config PCMCIA_PROBE
 	bool
-	default y if ISA && !ARCH_SA1100 && !ARCH_CLPS711X
+	default y if ISA && !ARCH_SA1100 && !ARCH_CLPS711X && !PARISC
+
+config PCMCIA_PROBE_MEM
+	bool
+	default y if !PARISC
 
 endmenu
 
===== drivers/pcmcia/rsrc_mgr.c 1.41 vs edited =====
--- 1.41/drivers/pcmcia/rsrc_mgr.c	2004-10-10 12:39:48 -05:00
+++ edited/drivers/pcmcia/rsrc_mgr.c	2004-10-16 09:50:28 -05:00
@@ -59,7 +59,11 @@
 
 #define INT_MODULE_PARM(n, v) static int n = v; module_param(n, int, 0444)
 
+#ifdef CONFIG_PCMCIA_PROBE_MEM
 INT_MODULE_PARM(probe_mem,	1);		/* memory probe? */
+#else
+INT_MODULE_PARM(probe_mem,	0);		/* memory probe? */
+#endif
 #ifdef CONFIG_PCMCIA_PROBE
 INT_MODULE_PARM(probe_io,	1);		/* IO port probe? */
 INT_MODULE_PARM(mem_limit,	0x10000);

