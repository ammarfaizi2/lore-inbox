Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269467AbUJSPfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269467AbUJSPfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269470AbUJSPfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:35:19 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:18668 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S269467AbUJSPeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:34:07 -0400
Date: Wed, 20 Oct 2004 00:33:51 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, ralf@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: fixed MIPS Makefile
Message-Id: <20041020003351.4f9ee7c0.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPS Makefile was changed so that the offset of data section
may not be dependent on a specific machine header file.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/Makefile a/arch/mips/Makefile
--- a-orig/arch/mips/Makefile	Tue Oct 19 06:53:06 2004
+++ a/arch/mips/Makefile	Tue Oct 19 23:33:51 2004
@@ -527,6 +527,7 @@
 #load-$(CONFIG_SGI_IP27)	+= 0xa80000000001c000
 ifdef CONFIG_MAPPED_KERNEL
 load-$(CONFIG_SGI_IP27)		+= 0xc001c000
+dataoffset-$(CONFIG_SGI_IP27)	+= 0x01000000
 else
 load-$(CONFIG_SGI_IP27)		+= 0x8001c000
 endif
@@ -625,6 +626,15 @@
 endif
 
 #
+# If you need data offset, please set up as follows.
+#
+# dataoffset-$(CONFIG_FOO) := <data offset value>
+# 
+
+DATAOFFSET	:= $(shell if [ -z $(dataoffset-y) ] ; then echo "0"; \
+			   else echo $(dataoffset-y); fi ;)
+
+#
 # Some machines like the Indy need 32-bit ELF binaries for booting purposes.
 # Other need ECOFF, so we build a 32-bit ELF binary for them which we then
 # convert to ECOFF using elf2ecoff.
@@ -644,7 +654,7 @@
 CPPFLAGS_vmlinux.lds := \
 	-D"LOADADDR=$(load-y)" \
 	-D"JIFFIES=$(JIFFIES)" \
-	-imacros $(srctree)/include/asm-$(ARCH)/sn/mapped_kernel.h
+	-D"DATAOFFSET=$(DATAOFFSET)"
 
 AFLAGS		+= $(cflags-y)
 CFLAGS		+= $(cflags-y)
diff -urN -X dontdiff a-orig/arch/mips/kernel/vmlinux.lds.S a/arch/mips/kernel/vmlinux.lds.S
--- a-orig/arch/mips/kernel/vmlinux.lds.S	Tue Oct 19 06:53:46 2004
+++ a/arch/mips/kernel/vmlinux.lds.S	Tue Oct 19 23:08:15 2004
@@ -49,7 +49,7 @@
 
   /* writeable */
   .data : {			/* Data */
-    . = . + MAPPED_OFFSET;	/* for CONFIG_MAPPED_KERNEL */
+    . = . + DATAOFFSET;		/* for CONFIG_MAPPED_KERNEL */
     *(.data.init_task)
 
     *(.data)
diff -urN -X dontdiff a-orig/include/asm-mips/sn/mapped_kernel.h a/include/asm-mips/sn/mapped_kernel.h
--- a-orig/include/asm-mips/sn/mapped_kernel.h	Tue Oct 19 06:54:07 2004
+++ a/include/asm-mips/sn/mapped_kernel.h	Tue Oct 19 23:08:15 2004
@@ -39,13 +39,11 @@
 #define MAPPED_KERN_RW_TO_PHYS(x) \
 				((unsigned long)MAPPED_ADDR_RW_TO_PHYS(x) | \
 				MAPPED_KERN_RW_PHYSBASE(get_compact_nodeid()))
-#define MAPPED_OFFSET			16777216
 
 #else /* CONFIG_MAPPED_KERNEL */
 
 #define MAPPED_KERN_RO_TO_PHYS(x)	(x - CKSEG0)
 #define MAPPED_KERN_RW_TO_PHYS(x)	(x - CKSEG0)
-#define MAPPED_OFFSET			0
 
 #endif /* CONFIG_MAPPED_KERNEL */
 
