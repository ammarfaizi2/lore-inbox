Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318088AbSFTBwE>; Wed, 19 Jun 2002 21:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318089AbSFTBwC>; Wed, 19 Jun 2002 21:52:02 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:60869 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S318088AbSFTBvD>;
	Wed, 19 Jun 2002 21:51:03 -0400
Date: Thu, 20 Jun 2002 11:50:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH] make kstack_depth_to_print and some APM stuff static
Message-Id: <20020620115016.2b82660c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, All,

Tridge has written a little utility
(http://samba.org/ftp/unpacked/junkcode/findstatic.pl) that (given a set of
object files) works out a list of candidate finctions and variables that
may be able to be made static.  Obviously some hand checking is needed
(different configs and/or architectures etc), but it seems useful.

Here is my first patch using its outout.

kstack_depth_to_print is used in many architectures, but only in one
file in each.  In some architectures it is declared and not used.  It
is not even clear why kstack_depth_to_print is not a #define.  Tridge
suggested that maybe you could change its value with a debugger ...

The APM code has a function and a struct that can be static.

Linus, please apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.23/arch/alpha/kernel/traps.c
2.5.23-sfr.1/arch/alpha/kernel/traps.c
--- 2.5.23/arch/alpha/kernel/traps.c	Wed Feb 20 14:12:54 2002
+++ 2.5.23-sfr.1/arch/alpha/kernel/traps.c	Wed Jun 19 17:42:22 2002
@@ -141,7 +141,7 @@
 	}
 }
 
-int kstack_depth_to_print = 24;
+static int kstack_depth_to_print = 24;
 
 void show_stack(unsigned long *sp)
 {
diff -ruN 2.5.23/arch/cris/kernel/traps.c
2.5.23-sfr.1/arch/cris/kernel/traps.c
--- 2.5.23/arch/cris/kernel/traps.c	Thu Jan 31 07:12:25 2002
+++ 2.5.23-sfr.1/arch/cris/kernel/traps.c	Wed Jun 19 17:42:37 2002
@@ -28,7 +28,7 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 
-int kstack_depth_to_print = 24;
+static int kstack_depth_to_print = 24;
 
 void show_trace(unsigned long * stack)
 {
diff -ruN 2.5.23/arch/i386/kernel/apm.c
2.5.23-sfr.1/arch/i386/kernel/apm.c
--- 2.5.23/arch/i386/kernel/apm.c	Wed Jun 19 12:41:50 2002
+++ 2.5.23-sfr.1/arch/i386/kernel/apm.c	Wed Jun 19 17:23:08 2002
@@ -922,12 +922,13 @@
  * callback we use.
  */
 
-void handle_poweroff (int key, struct pt_regs *pt_regs,
-		struct kbd_struct *kbd, struct tty_struct *tty) {
+static void handle_poweroff (int key, struct pt_regs *pt_regs,
+		struct kbd_struct *kbd, struct tty_struct *tty)
+{
         apm_power_off();
 }
 
-struct sysrq_key_op	sysrq_poweroff_op = {
+static struct sysrq_key_op	sysrq_poweroff_op = {
 	handler:        handle_poweroff,
 	help_msg:       "Off",
 	action_msg:     "Power Off\n"
diff -ruN 2.5.23/arch/i386/kernel/traps.c
2.5.23-sfr.1/arch/i386/kernel/traps.c
--- 2.5.23/arch/i386/kernel/traps.c	Sat May 25 21:19:59 2002
+++ 2.5.23-sfr.1/arch/i386/kernel/traps.c	Wed Jun 19 17:42:56 2002
@@ -89,7 +89,7 @@
 asmlinkage void spurious_interrupt_bug(void);
 asmlinkage void machine_check(void);
 
-int kstack_depth_to_print = 24;
+static int kstack_depth_to_print = 24;
 
 
 /*
diff -ruN 2.5.23/arch/m68k/kernel/traps.c
2.5.23-sfr.1/arch/m68k/kernel/traps.c
--- 2.5.23/arch/m68k/kernel/traps.c	Fri May 10 09:12:18 2002
+++ 2.5.23-sfr.1/arch/m68k/kernel/traps.c	Wed Jun 19 17:43:27 2002
@@ -815,7 +815,7 @@
 }
 
 
-int kstack_depth_to_print = 48;
+static int kstack_depth_to_print = 48;
 extern struct module kernel_module;
 
 static inline int kernel_text_address(unsigned long addr)
diff -ruN 2.5.23/arch/mips/kernel/traps.c
2.5.23-sfr.1/arch/mips/kernel/traps.c
--- 2.5.23/arch/mips/kernel/traps.c	Mon Sep 10 03:43:01 2001
+++ 2.5.23-sfr.1/arch/mips/kernel/traps.c	Wed Jun 19 17:43:38 2002
@@ -69,8 +69,6 @@
 void (*ibe_board_handler)(struct pt_regs *regs);
 void (*dbe_board_handler)(struct pt_regs *regs);
 
-int kstack_depth_to_print = 24;
-
 /*
  * These constant is for searching for possible module text segments.
  * MODULE_RANGE is a guess of how much space is likely to be vmalloced.
diff -ruN 2.5.23/arch/mips64/kernel/traps.c
2.5.23-sfr.1/arch/mips64/kernel/traps.c
--- 2.5.23/arch/mips64/kernel/traps.c	Mon Sep 10 03:43:01 2001
+++ 2.5.23-sfr.1/arch/mips64/kernel/traps.c	Wed Jun 19 17:43:49 2002
@@ -51,8 +51,6 @@
 char vce_available = 0;
 char mips4_available = 0;
 
-int kstack_depth_to_print = 24;
-
 /*
  * These constant is for searching for possible module text segments.
  * MODULE_RANGE is a guess of how much space is likely to be vmalloced.
diff -ruN 2.5.23/arch/parisc/kernel/traps.c
2.5.23-sfr.1/arch/parisc/kernel/traps.c
--- 2.5.23/arch/parisc/kernel/traps.c	Mon Oct  1 05:26:08 2001
+++ 2.5.23-sfr.1/arch/parisc/kernel/traps.c	Wed Jun 19 17:43:59 2002
@@ -58,8 +58,6 @@
 #define VMALLOC_OFFSET (8*1024*1024)
 #define MODULE_RANGE (8*1024*1024)
 
-int kstack_depth_to_print = 24;
-
 static void printbinary(unsigned long x, int nbits)
 {
 	unsigned long mask = 1UL << (nbits - 1);
diff -ruN 2.5.23/arch/s390/kernel/traps.c
2.5.23-sfr.1/arch/s390/kernel/traps.c
--- 2.5.23/arch/s390/kernel/traps.c	Sun Jun  9 16:12:27 2002
+++ 2.5.23-sfr.1/arch/s390/kernel/traps.c	Wed Jun 19 17:44:15 2002
@@ -61,7 +61,7 @@
 static ext_int_info_t ext_int_pfault;
 #endif
 
-int kstack_depth_to_print = 12;
+static int kstack_depth_to_print = 12;
 
 /*
  * If the address is either in the .text section of the
diff -ruN 2.5.23/arch/s390x/kernel/traps.c
2.5.23-sfr.1/arch/s390x/kernel/traps.c
--- 2.5.23/arch/s390x/kernel/traps.c	Sun Jun  9 16:12:28 2002
+++ 2.5.23-sfr.1/arch/s390x/kernel/traps.c	Wed Jun 19 17:44:24 2002
@@ -63,7 +63,7 @@
 static ext_int_info_t ext_int_pfault;
 #endif
 
-int kstack_depth_to_print = 20;
+static int kstack_depth_to_print = 20;
 
 /*
  * If the address is either in the .text section of the
diff -ruN 2.5.23/arch/x86_64/kernel/traps.c
2.5.23-sfr.1/arch/x86_64/kernel/traps.c
--- 2.5.23/arch/x86_64/kernel/traps.c	Mon Jun 17 13:12:21 2002
+++ 2.5.23-sfr.1/arch/x86_64/kernel/traps.c	Wed Jun 19 17:44:35 2002
@@ -81,7 +81,7 @@
 
 struct notifier_block *die_chain;
 
-int kstack_depth_to_print = 10;
+static int kstack_depth_to_print = 10;
 
 #ifdef CONFIG_KALLSYMS
 #include <linux/kallsyms.h> 
