Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267173AbUFZOfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267173AbUFZOfn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 10:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267174AbUFZOfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 10:35:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38930 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267173AbUFZOfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 10:35:19 -0400
Date: Sat, 26 Jun 2004 15:35:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: 2.6.7-bk: asm/setup.h and linux/init.h
Message-ID: <20040626153511.A30532@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice that recent changes resulted in asm/setup.h being included by
linux/init.h, for the saved_command_line change:

@@ -66,6 +67,9 @@

 extern initcall_t __con_initcall_start, __con_initcall_end;
 extern initcall_t __security_initcall_start, __security_initcall_end;
+
+/* Defined in init/main.c */
+extern char saved_command_line[COMMAND_LINE_SIZE];
 #endif

 #ifndef MODULE

Unfortunately, this causes problems on ARM, because asm/setup.h on
ARM needs things like linux/types.h, which I'd rather not include
here since:

1. it means that we'll be at odds with what other architectures include
   (and therefore will hide a missing linux/types.h include when
   developing on ARM.)
2. linux/init.h is included by the majority of the kernel, and I'd
   rather not have asm/setup.h added to the dependency of every single
   kernel source file.

Is there a reason why we can't delete asm/setup.h from linux/init.h
and change that declaration to:

+extern char saved_command_line[];

?

IOW, like this (which works fine on ARM):

===== include/linux/init.h 1.32 vs edited =====
--- 1.32/include/linux/init.h	Thu Jun 24 09:55:46 2004
+++ edited/include/linux/init.h	Sat Jun 26 12:50:09 2004
@@ -3,7 +3,6 @@
 
 #include <linux/config.h>
 #include <linux/compiler.h>
-#include <asm/setup.h>
 
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)
@@ -69,7 +68,7 @@
 extern initcall_t __security_initcall_start, __security_initcall_end;
 
 /* Defined in init/main.c */
-extern char saved_command_line[COMMAND_LINE_SIZE];
+extern char saved_command_line[];
 #endif
   
 #ifndef MODULE
===== init/main.c 1.148 vs edited =====
--- 1.148/init/main.c	Thu Jun 24 09:55:46 2004
+++ edited/init/main.c	Sat Jun 26 12:51:27 2004
@@ -47,6 +47,7 @@
 
 #include <asm/io.h>
 #include <asm/bugs.h>
+#include <asm/setup.h>
 
 /*
  * This is one of the first .c files built. Error out early


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
