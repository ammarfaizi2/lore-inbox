Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264921AbSJPNpV>; Wed, 16 Oct 2002 09:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264922AbSJPNpT>; Wed, 16 Oct 2002 09:45:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36875 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264921AbSJPNpR>;
	Wed, 16 Oct 2002 09:45:17 -0400
Date: Wed, 16 Oct 2002 14:51:13 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] Allow compilation with -ffunction-sections
Message-ID: <20021016145113.E15163@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you compile the kernel with -ffunction-sections, each function gets
put in a section .text.function_name.  This collides with our current use
of .text.init.  So here's a patch which converts x86 to use .init.text
instead.

I've tested it on x86 and it still frees 120k of ram, so it seems to work.
Other architectures will need to change their vmlinux.lds appropriately,
and may need other changes (arm, m68k seem to use .text.init verbatim).

diff -urpNX dontdiff linux-2.5.43/arch/i386/vmlinux.lds.S linux-2.5.43-willy/arch/i386/vmlinux.lds.S
--- linux-2.5.43/arch/i386/vmlinux.lds.S	2002-10-11 05:23:56.000000000 -0700
+++ linux-2.5.43-willy/arch/i386/vmlinux.lds.S	2002-10-16 06:34:00.000000000 -0700
@@ -41,11 +41,11 @@ SECTIONS
 
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
+  .init.text : { *(.init.text) }
+  .init.data : { *(.init.data) }
   . = ALIGN(16);
   __setup_start = .;
-  .setup.init : { *(.setup.init) }
+  .init.setup : { *(.init.setup) }
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : {
@@ -89,8 +89,8 @@ SECTIONS
 
   /* Sections to be discarded */
   /DISCARD/ : {
-	*(.text.exit)
-	*(.data.exit)
+	*(.exit.text)
+	*(.exit.data)
 	*(.exitcall.exit)
 	}
 
diff -urpNX dontdiff linux-2.5.43/include/linux/init.h linux-2.5.43-willy/include/linux/init.h
--- linux-2.5.43/include/linux/init.h	2002-08-13 19:54:03.000000000 -0700
+++ linux-2.5.43-willy/include/linux/init.h	2002-10-16 06:00:22.000000000 -0700
@@ -93,18 +93,18 @@ extern struct kernel_param __setup_start
  * Mark functions and data as being only used at initialization
  * or exit time.
  */
-#define __init		__attribute__ ((__section__ (".text.init")))
-#define __exit		__attribute__ ((unused, __section__(".text.exit")))
-#define __initdata	__attribute__ ((__section__ (".data.init")))
-#define __exitdata	__attribute__ ((unused, __section__ (".data.exit")))
-#define __initsetup	__attribute__ ((unused,__section__ (".setup.init")))
+#define __init		__attribute__ ((__section__ (".init.text")))
+#define __exit		__attribute__ ((unused, __section__(".exit.text")))
+#define __initdata	__attribute__ ((__section__ (".init.data")))
+#define __exitdata	__attribute__ ((unused, __section__ (".exit.data")))
+#define __initsetup	__attribute__ ((unused,__section__ (".init.setup")))
 #define __init_call(level)  __attribute__ ((unused,__section__ (".initcall" level ".init")))
 #define __exit_call	__attribute__ ((unused,__section__ (".exitcall.exit")))
 
 /* For assembly routines */
-#define __INIT		.section	".text.init","ax"
+#define __INIT		.section	".init.text","ax"
 #define __FINIT		.previous
-#define __INITDATA	.section	".data.init","aw"
+#define __INITDATA	.section	".init.data","aw"
 
 /**
  * module_init() - driver initialization entry point

-- 
Revolutions do not require corporate support.
