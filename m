Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129962AbRA0WeJ>; Sat, 27 Jan 2001 17:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130281AbRA0WeA>; Sat, 27 Jan 2001 17:34:00 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:19473 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129962AbRA0Wdn>; Sat, 27 Jan 2001 17:33:43 -0500
From: Stefani Seibold <stefani@seibold.net>
Date: Sat, 27 Jan 2001 23:31:35 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: Andrew Morton <andrewm@uow.edu.au>, David Weinehall <tao@acc.umu.se>,
        linux-kernel@vger.kernel.org, Stefani@seibold.net
Subject: Re: patch for 2.4.0 disable printk
MIME-Version: 1.0
Message-Id: <01012723313500.01190@deepthought.seibold.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

thanks for the feedback. This is now the second try of my disable printk 
patch.

First i moved the option for disabling the prinbtk messages form the menu 
character devices to kernel hacking.

Second, i had change the macro so it calls now a inline funciton 
printk_inline which always return 0. So it should be now compatibel to the 
standard printk funciton.

I hope you like the patch...

Greetings,
Stefani

-----patch for 2.4.0 disable printk-----

diff -u --recursive --new-file linux/Documentation/Configure.help 
linux.noprintk/Documentation/Configure.help
--- linux/Documentation/Configure.help	Thu Jan  4 22:00:55 2001
+++ linux.noprintk/Documentation/Configure.help	Thu Jan 18 12:14:41 2001
@@ -12139,6 +12179,14 @@
 
   If unsure, say Y, or else you won't be able to do much with your new
   shiny Linux system :-)
+
+Disable kernel messages
+CONFIG_PRINTK
+  This option allows you to disable all kernel messages by overriding
+  the printk function with an empty macro.
+  On small embedded systems, this save a lot of rom and ram space. On
+  server or desktop systems you want human readable outputs, so it is
+  normally the best choice to say N to this option.
 
 Support for console on virtual terminal
 CONFIG_VT_CONSOLE
diff -u --recursive --new-file linux/include/asm-i386/spinlock.h 
linux.noprintk/include/asm-i386/spinlock.h
--- linux/include/asm-i386/spinlock.h	Thu Jan  4 23:50:46 2001
+++ linux.noprintk/include/asm-i386/spinlock.h	Thu Jan 25 23:07:43 2001
@@ -5,8 +5,10 @@
 #include <asm/rwlock.h>
 #include <asm/page.h>
 
+#ifndef CONFIG_PRINTK
 extern int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+#endif
 
 /* It seems that people are forgetting to
  * initialize their spinlocks properly, tsk tsk.
diff -u --recursive --new-file linux/include/linux/kernel.h 
linux.noprintk/include/linux/kernel.h
--- linux/include/linux/kernel.h	Mon Dec 11 21:49:54 2000
+++ linux.noprintk/include/linux/kernel.h	Sat Jan 27 22:22:59 2001
@@ -68,8 +68,18 @@
 
 extern int session_of_pgrp(int pgrp);
 
+#ifdef CONFIG_PRINTK
+#define	printk(x...)	printk_inline()
+
+static inline int printk_inline(void) __attribute__ ((const,unused));
+
+static inline int printk_inline(void)	{ return 0; }
+#else
+
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+#endif
+
 
 extern int console_loglevel;
 
diff -u --recursive --new-file linux/kernel/ksyms.c 
linux.noprintk/kernel/ksyms.c
--- linux/kernel/ksyms.c	Wed Jan  3 01:45:37 2001
+++ linux.noprintk/kernel/ksyms.c	Thu Jan 18 12:14:41 2001
@@ -439,7 +440,9 @@
 
 /* misc */
 EXPORT_SYMBOL(panic);
+#ifndef CONFIG_PRINTK
 EXPORT_SYMBOL(printk);
+#endif
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(vsprintf);
 EXPORT_SYMBOL(kdevname);
diff -u --recursive --new-file linux/kernel/printk.c 
linux.noprintk/kernel/printk.c
--- linux/kernel/printk.c	Sun Dec 31 03:16:13 2000
+++ linux.noprintk/kernel/printk.c	Thu Jan 25 23:03:37 2001
@@ -25,7 +25,9 @@
 #define LOG_BUF_LEN	(16384)
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
 
+#ifndef CONFIG_PRINTK
 static char buf[1024];
+#endif
 
 /* printk's without a loglevel use this.. */
 #define DEFAULT_MESSAGE_LOGLEVEL 4 /* KERN_WARNING */
@@ -251,6 +253,20 @@
 	return do_syslog(type, buf, len);
 }
 
+
+#ifdef CONFIG_PRINTK
+#undef printk
+
+#include <linux/module.h>
+
+asmlinkage int printk(const char *fmt, ...)
+{
+	return 0;
+}
+
+EXPORT_SYMBOL_NOVERS(printk);
+
+#else
 asmlinkage int printk(const char *fmt, ...)
 {
 	va_list args;
@@ -311,6 +322,7 @@
 	wake_up_interruptible(&log_wait);
 	return i;
 }
+#endif
 
 void console_print(const char *s)
 {
diff -u --recursive --new-file linux/CREDITS linux.noprintk/CREDITS
--- linux/CREDITS	Sun Dec 31 18:27:57 2000
+++ linux.noprintk/CREDITS	Fri Jan 26 10:51:19 2001
@@ -2395,6 +2395,14 @@
 S: Oldenburg
 S: Germany
 
+N: Stefani Seibold
+E: Stefani@Seibold.net
+D: Possibility to disable all kernel messages by overload printk with a
+D: dummy macro (saves a lot of disk- and ramspace for embedded systems
+D: and rescue disks)
+S: Munich
+S: Germany
+
 N: Darren Senn
 E: sinster@darkwater.com
 D: Whatever I notice needs doing (so far: itimers, /proc)
diff -u --recursive --new-file linux/arch/alpha/config.in 
linux.noprintk/arch/alpha/config.in
--- linux/arch/alpha/config.in	Fri Dec 29 23:07:19 2000
+++ linux.noprintk/arch/alpha/config.in	Sat Jan 27 22:37:20 2001
@@ -359,6 +359,7 @@
 fi
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_PRINTK
 
 bool 'Legacy kernel start address' CONFIG_ALPHA_LEGACY_START_ADDRESS
 
diff -u --recursive --new-file linux/arch/arm/config.in 
linux.noprintk/arch/arm/config.in
--- linux/arch/arm/config.in	Thu Nov 16 21:51:28 2000
+++ linux.noprintk/arch/arm/config.in	Sat Jan 27 22:34:57 2001
@@ -414,6 +414,7 @@
 bool 'Verbose user fault messages' CONFIG_DEBUG_USER
 bool 'Include debugging information in kernel binary' CONFIG_DEBUG_INFO
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_PRINTK
 if [ "$CONFIG_CPU_26" = "y" ]; then
    bool 'Disable pgtable cache' CONFIG_NO_PGT_CACHE
 fi
diff -u --recursive --new-file linux/arch/i386/config.in 
linux.noprintk/arch/i386/config.in
--- linux/arch/i386/config.in	Fri Dec 29 23:35:47 2000
+++ linux.noprintk/arch/i386/config.in	Sat Jan 27 22:36:09 2001
@@ -374,4 +374,5 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_PRINTK
 endmenu
diff -u --recursive --new-file linux/arch/ia64/config.in 
linux.noprintk/arch/ia64/config.in
--- linux/arch/ia64/config.in	Thu Jan  4 21:50:17 2001
+++ linux.noprintk/arch/ia64/config.in	Sat Jan 27 22:36:48 2001
@@ -249,6 +249,7 @@
 fi
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_PRINTK
 bool 'Early printk support (requires VGA!)' CONFIG_IA64_EARLY_PRINTK
 bool 'Turn on compare-and-exchange bug checking (slow!)' 
CONFIG_IA64_DEBUG_CMPXCHG
 bool 'Turn on irq debug checks (slow!)' CONFIG_IA64_DEBUG_IRQ
diff -u --recursive --new-file linux/arch/m68k/config.in 
linux.noprintk/arch/m68k/config.in
--- linux/arch/m68k/config.in	Thu Jan  4 22:00:55 2001
+++ linux.noprintk/arch/m68k/config.in	Sat Jan 27 22:36:57 2001
@@ -538,4 +538,5 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_PRINTK
 endmenu
diff -u --recursive --new-file linux/arch/mips/config.in 
linux.noprintk/arch/mips/config.in
--- linux/arch/mips/config.in	Thu Nov 16 21:51:28 2000
+++ linux.noprintk/arch/mips/config.in	Sat Jan 27 22:37:02 2001
@@ -397,4 +397,5 @@
   bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 fi
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_PRINTK
 endmenu
diff -u --recursive --new-file linux/arch/mips64/config.in 
linux.noprintk/arch/mips64/config.in
--- linux/arch/mips64/config.in	Wed Nov 29 06:42:04 2000
+++ linux.noprintk/arch/mips64/config.in	Sat Jan 27 22:37:45 2001
@@ -266,4 +266,5 @@
 fi
 bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_PRINTK
 endmenu
diff -u --recursive --new-file linux/arch/parisc/config.in 
linux.noprintk/arch/parisc/config.in
--- linux/arch/parisc/config.in	Tue Dec  5 21:29:39 2000
+++ linux.noprintk/arch/parisc/config.in	Sat Jan 27 22:37:51 2001
@@ -204,5 +204,6 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_PRINTK
 endmenu
 
diff -u --recursive --new-file linux/arch/ppc/config.in 
linux.noprintk/arch/ppc/config.in
--- linux/arch/ppc/config.in	Thu Nov 16 21:51:28 2000
+++ linux.noprintk/arch/ppc/config.in	Sat Jan 27 22:35:33 2001
@@ -324,6 +324,7 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_PRINTK
 bool 'Include kgdb kernel debugger' CONFIG_KGDB
 bool 'Include xmon kernel debugger' CONFIG_XMON
 endmenu
diff -u --recursive --new-file linux/arch/s390/config.in 
linux.noprintk/arch/s390/config.in
--- linux/arch/s390/config.in	Thu Nov 16 21:51:28 2000
+++ linux.noprintk/arch/s390/config.in	Sat Jan 27 22:37:14 2001
@@ -77,5 +77,6 @@
   bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 fi
 # this does not work. bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_PRINTK
 endmenu
 
diff -u --recursive --new-file linux/arch/sh/config.in 
linux.noprintk/arch/sh/config.in
--- linux/arch/sh/config.in	Thu Jan  4 22:19:13 2001
+++ linux.noprintk/arch/sh/config.in	Sat Jan 27 22:35:09 2001
@@ -260,6 +260,7 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_PRINTK
 bool 'Use LinuxSH standard BIOS' CONFIG_SH_STANDARD_BIOS
 if [ "$CONFIG_SH_STANDARD_BIOS" = "y" ]; then
    bool 'GDB Stub kernel debug' CONFIG_DEBUG_KERNEL_WITH_GDB_STUB
diff -u --recursive --new-file linux/arch/sparc/config.in 
linux.noprintk/arch/sparc/config.in
--- linux/arch/sparc/config.in	Wed Nov 29 06:53:44 2000
+++ linux.noprintk/arch/sparc/config.in	Sat Jan 27 22:37:29 2001
@@ -258,4 +258,5 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_PRINTK
 endmenu
diff -u --recursive --new-file linux/arch/sparc64/config.in 
linux.noprintk/arch/sparc64/config.in
--- linux/arch/sparc64/config.in	Thu Nov 16 21:51:28 2000
+++ linux.noprintk/arch/sparc64/config.in	Sat Jan 27 22:37:38 2001
@@ -331,5 +331,6 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_PRINTK
 #bool 'ECache flush trap support at ta 0x72' CONFIG_EC_FLUSH_TRAP
 endmenu
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
