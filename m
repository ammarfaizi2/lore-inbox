Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293496AbSB1PKz>; Thu, 28 Feb 2002 10:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293487AbSB1PIP>; Thu, 28 Feb 2002 10:08:15 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:12044 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S293484AbSB1PFq>;
	Thu, 28 Feb 2002 10:05:46 -0500
Message-ID: <3C7E465A.4B3F4D9@yahoo.com>
Date: Thu, 28 Feb 2002 10:01:46 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
To: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] bluesmoke/MCE support optional
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Meant to do this a while ago.  Could do it via adding "nosmoke.c"  :-)
(similar to fs/noquot.c) instead of #ifdef in bluesmoke.c, if somebody
had a strong preference one way or the other.

Patch is against 2.4.18, complete with Aunt Tillie(tm) help text, etc.

Paul.


--- Documentation/Configure.help~	Sat Feb  2 06:50:31 2002
+++ Documentation/Configure.help	Thu Feb 28 09:01:28 2002
@@ -17450,6 +17450,17 @@
   The module is called shwdt.o. If you want to compile it as a module,
   say M here and read Documentation/modules.txt.
 	      
+Machine Check Exception
+CONFIG_X86_MCE
+  Machine Check Exception support allows the processor to notify the
+  kernel if it detects a problem (e.g. overheating, component failure).
+  The action the kernel takes depends on the severity of the problem, 
+  ranging from a warning message on the console, to halting the machine.
+  Your processor must be a Pentium or newer to support this - check the 
+  flags in /proc/cpuinfo for mce.  Note that some older Pentium systems
+  have a design flaw which leads to false MCE events - for these and
+  old non-MCE processors (386, 486), say N.  Otherwise say Y.
+
 Toshiba Laptop support
 CONFIG_TOSHIBA
   This adds a driver to safely access the System Management Mode of
--- arch/i386/defconfig~	Sat Feb  2 06:43:29 2002
+++ arch/i386/defconfig	Thu Feb 28 08:38:53 2002
@@ -49,6 +49,7 @@
 CONFIG_X86_GOOD_APIC=y
 CONFIG_X86_PGE=y
 CONFIG_X86_USE_PPRO_CHECKSUM=y
+CONFIG_X86_MCE=y
 # CONFIG_TOSHIBA is not set
 # CONFIG_I8K is not set
 # CONFIG_MICROCODE is not set
--- arch/i386/config.in~	Sat Feb  2 06:50:32 2002
+++ arch/i386/config.in	Thu Feb 28 08:37:25 2002
@@ -154,6 +154,9 @@
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
+
+bool 'Machine Check Exception' CONFIG_X86_MCE
+
 tristate 'Toshiba Laptop support' CONFIG_TOSHIBA
 tristate 'Dell laptop support' CONFIG_I8K
 
--- arch/i386/kernel/bluesmoke.c~	Sat Feb  2 06:43:30 2002
+++ arch/i386/kernel/bluesmoke.c	Thu Feb 28 09:18:35 2002
@@ -3,9 +3,12 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/config.h>
 #include <asm/processor.h> 
 #include <asm/msr.h>
 
+#ifdef CONFIG_X86_MCE
+
 static int mce_disabled __initdata = 0;
 
 /*
@@ -247,3 +250,8 @@
 
 __setup("nomce", mcheck_disable);
 __setup("mce", mcheck_enable);
+
+#else
+asmlinkage void do_machine_check(struct pt_regs * regs, long error_code) {}
+void __init mcheck_init(struct cpuinfo_x86 *c) {}
+#endif


