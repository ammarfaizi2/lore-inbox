Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263198AbTDGCh1 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 22:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbTDGCh1 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 22:37:27 -0400
Received: from dp.samba.org ([66.70.73.150]:700 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263198AbTDGChX (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 22:37:23 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Fabrice Bellard <fabrice.bellard@free.fr>
Cc: linux-kernel@vger.kernel.org, paulus@samba.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Qemu support for PPC
Date: Mon, 07 Apr 2003 12:40:38 +1000
Message-Id: <20030407024858.C32422C014@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul, is this OK?

I'd like it in 2.4.21 if possible.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Qemu Kernel Patch for PPC
Author: Rusty Russell
Status: Tested on 2.4.21-pre6

D: Allow (0.1.5 or above) qemu to set the personality for emulation,
D: so files in /usr/gnemul/x86-linux get looked up before normal files
D: (this is the standard way of hooking in emulation libraries, etc).

diff -urpN --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.21-pre6/Documentation/Configure.help working-2.4.21-pre6-wagner/Documentation/Configure.help
--- linux-2.4.21-pre6/Documentation/Configure.help	2003-03-27 12:10:45.000000000 +1100
+++ working-2.4.21-pre6-wagner/Documentation/Configure.help	2003-04-04 17:15:21.000000000 +1000
@@ -4123,6 +4123,19 @@ CONFIG_BINFMT_JAVA
   binaries directly.  Note: this option is obsolete and scheduled for
   removal, use CONFIG_BINFMT_MISC instead.
 
+Kernel support for Linux/Intel ELF binaries
+CONFIG_X86_EMU
+  Say Y here if you want to be able to execute Linux/Intel ELF
+  binaries just like native binaries on your PPC machine. For
+  this to work, you need to have /usr/gnemul/x86-linux populated
+  with Intel libraries. etc.
+
+  You may answer M to compile the emulation support as a module and
+  later load the module when you want to use a Linux/Intel binary. The
+  module will be called x86emu.o.  If unsure, say Y.
+
 Solaris binary emulation
 CONFIG_SOLARIS_EMUL
   This is experimental code which will enable you to run (many)
diff -urpN --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.21-pre6/arch/ppc/config.in working-2.4.21-pre6-wagner/arch/ppc/config.in
--- linux-2.4.21-pre6/arch/ppc/config.in	2003-03-27 12:10:49.000000000 +1100
+++ working-2.4.21-pre6-wagner/arch/ppc/config.in	2003-04-04 17:11:48.000000000 +1000
@@ -183,6 +183,7 @@ fi
 define_bool CONFIG_BINFMT_ELF y
 define_bool CONFIG_KERNEL_ELF y
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
+dep_tristate 'Kernel support for Linux/Intel ELF binaries' CONFIG_X86_EMU
 
 source drivers/pci/Config.in
 
diff -urpN --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.21-pre6/arch/ppc/kernel/Makefile working-2.4.21-pre6-wagner/arch/ppc/kernel/Makefile
--- linux-2.4.21-pre6/arch/ppc/kernel/Makefile	2003-03-27 12:10:49.000000000 +1100
+++ working-2.4.21-pre6-wagner/arch/ppc/kernel/Makefile	2003-04-04 17:11:16.000000000 +1000
@@ -66,6 +66,7 @@ obj-$(CONFIG_PAL4)		+= indirect_pci.o pc
 obj-$(CONFIG_SPRUCE)		+= indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_8260)		+= m8260_setup.o ppc8260_pic.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
+obj-$(CONFIG_X86_EMU)		+= x86emu.o
 
 include $(TOPDIR)/Rules.make
 
diff -urpN --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.21-pre6/arch/ppc/kernel/x86emu.c working-2.4.21-pre6-wagner/arch/ppc/kernel/x86emu.c
--- linux-2.4.21-pre6/arch/ppc/kernel/x86emu.c	1970-01-01 10:00:00.000000000 +1000
+++ working-2.4.21-pre6-wagner/arch/ppc/kernel/x86emu.c	2003-04-07 11:44:44.000000000 +1000
@@ -0,0 +1,29 @@
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/personality.h>
+#include <linux/binfmts.h>
+
+struct exec_domain x86_linux_exec_domain = {
+	.name		="X86LINUX",
+	.pers_low	= PER_X86_LINUX & PER_MASK,
+	.pers_high	= PER_X86_LINUX & PER_MASK,
+	.module		= THIS_MODULE
+};
+
+static int init(void)
+{
+	return register_exec_domain(&x86_linux_exec_domain);
+}
+
+static void fini(void)
+{
+	unregister_exec_domain(&x86_linux_exec_domain);
+}
+
+module_init(init);
+module_exit(fini);
+
+MODULE_DESCRIPTION("x86 Linux execution domain");
+MODULE_LICENSE("GPL");
diff -urpN --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.21-pre6/include/asm-ppc/namei.h working-2.4.21-pre6-wagner/include/asm-ppc/namei.h
--- linux-2.4.21-pre6/include/asm-ppc/namei.h	2003-03-27 12:11:03.000000000 +1100
+++ working-2.4.21-pre6-wagner/include/asm-ppc/namei.h	2003-04-04 15:15:12.000000000 +1000
@@ -8,12 +8,15 @@
 #ifndef __PPC_NAMEI_H
 #define __PPC_NAMEI_H
 
-/* This dummy routine maybe changed to something useful
- * for /usr/gnemul/ emulation stuff.
- * Look at asm-sparc/namei.h for details.
- */
-
-#define __emul_prefix() NULL
+static inline char *__emul_prefix(void)
+{
+	switch (current->personality) {
+	case (PER_X86_LINUX & PER_MASK):
+		return "usr/gnemul/x86-linux/";
+	default:
+		return NULL;
+	}
+}
 
 #endif /* __PPC_NAMEI_H */
 #endif /* __KERNEL__ */
diff -urpN --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.21-pre6/include/linux/personality.h working-2.4.21-pre6-wagner/include/linux/personality.h
--- linux-2.4.21-pre6/include/linux/personality.h	2003-03-18 04:59:22.000000000 +1100
+++ working-2.4.21-pre6-wagner/include/linux/personality.h	2003-04-04 12:14:09.000000000 +1000
@@ -64,6 +64,7 @@ enum {
 	PER_UW7 =		0x000e | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
 	PER_HPUX =		0x000f,
 	PER_OSF4 =		0x0010,			 /* OSF/1 v4 */
+	PER_X86_LINUX =		0x0011 | ADDR_LIMIT_32BIT,/* QEMU */
 	PER_MASK =		0x00ff,
 };
 
