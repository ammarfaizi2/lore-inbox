Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130153AbRA2WS1>; Mon, 29 Jan 2001 17:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbRA2WSS>; Mon, 29 Jan 2001 17:18:18 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:14858 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S130153AbRA2WSF>; Mon, 29 Jan 2001 17:18:05 -0500
From: Stefani Seibold <stefani@seibold.net>
Date: Mon, 29 Jan 2001 23:16:17 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, Stefani@seibold.net
Subject: patch for 2.4.0 disable printk and panic messages, ask for add it to kernel
MIME-Version: 1.0
Message-Id: <01012923161700.12375@deepthought.seibold.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

this is now the fourth try to release my patch for disabling all kernel 
messages. It is usefull on deep embedded systems with no human interactions 
and for rescue discs where the diskspace is always to less.

This patch has now the following features:

The macro printk is now defined as
#define printk(format, args...) ((format ,## args),(int)0)
This macro evaluate now all parameters and return 0 as result. So it should 
be now do the same, like the original printk funciton.

The macro panic is now defined as
#define panic(format, args...) ((format ,## args),panic_nomsg())
This macro evaluate now all parameters and calls a function 
"NORET_TYPE void panic_nomsg(void) ATTRIB_NORET", which is still the same as 
the old panic function, but without display an oops and reboot immidiately.

All parameters of printk and panic will be automatically removed by the 
compiler optimizions.

The old functions printk and panic will be also implemented and exported as 
silent functions for backward compatibility.

The name of the config variable is now CONFIG_NOPRINTK.

The option for disabling the printk and panic messages in in menu kernel 
hacking.

If CONFIG_NOPRINTK is defined, the compilers warning for unused variables and 
results will now switch off by -Wno-unused.

The option is removed for S390, because it makes no sense on a mainframe 
machine.

I hope this will it now do in the offical kernel release, because no side 
effects should be now expect.

Thanks you all for helping me, to make this patch as save as possible.

Greetings,
Stefani

-----patch for 2.4.0 disable printk and panic -----

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
diff -u --recursive --new-file linux/Documentation/Configure.help 
linux.noprintk/Documentation/Configure.help
--- linux/Documentation/Configure.help	Thu Jan  4 22:00:55 2001
+++ linux.noprintk/Documentation/Configure.help	Sun Jan 28 10:57:29 2001
@@ -12139,6 +12179,14 @@
 
   If unsure, say Y, or else you won't be able to do much with your new
   shiny Linux system :-)
+
+Disable kernel messages
+CONFIG_NOPRINTK
+  This option allows you to disable all kernel messages by overriding
+  the printk function with an empty macro.
+  On small embedded systems, this save a lot of rom and ram space. On
+  server or desktop systems you want human readable outputs, so it is
+  normally the best choice to say N to this option.
 
 Support for console on virtual terminal
 CONFIG_VT_CONSOLE
diff -u --recursive --new-file linux/arch/alpha/config.in 
linux.noprintk/arch/alpha/config.in
--- linux/arch/alpha/config.in	Fri Dec 29 23:07:19 2000
+++ linux.noprintk/arch/alpha/config.in	Sun Jan 28 10:56:21 2001
@@ -359,6 +359,7 @@
 fi
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_NOPRINTK
 
 bool 'Legacy kernel start address' CONFIG_ALPHA_LEGACY_START_ADDRESS
 
diff -u --recursive --new-file linux/arch/arm/config.in 
linux.noprintk/arch/arm/config.in
--- linux/arch/arm/config.in	Thu Nov 16 21:51:28 2000
+++ linux.noprintk/arch/arm/config.in	Sun Jan 28 10:55:58 2001
@@ -414,6 +414,7 @@
 bool 'Verbose user fault messages' CONFIG_DEBUG_USER
 bool 'Include debugging information in kernel binary' CONFIG_DEBUG_INFO
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_NOPRINTK
 if [ "$CONFIG_CPU_26" = "y" ]; then
    bool 'Disable pgtable cache' CONFIG_NO_PGT_CACHE
 fi
diff -u --recursive --new-file linux/arch/i386/config.in 
linux.noprintk/arch/i386/config.in
--- linux/arch/i386/config.in	Fri Dec 29 23:35:47 2000
+++ linux.noprintk/arch/i386/config.in	Sun Jan 28 10:56:04 2001
@@ -374,4 +374,5 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_NOPRINTK
 endmenu
diff -u --recursive --new-file linux/arch/ia64/config.in 
linux.noprintk/arch/ia64/config.in
--- linux/arch/ia64/config.in	Thu Jan  4 21:50:17 2001
+++ linux.noprintk/arch/ia64/config.in	Sun Jan 28 10:56:07 2001
@@ -249,6 +249,7 @@
 fi
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_NOPRINTK
 bool 'Early printk support (requires VGA!)' CONFIG_IA64_EARLY_PRINTK
 bool 'Turn on compare-and-exchange bug checking (slow!)' 
CONFIG_IA64_DEBUG_CMPXCHG
 bool 'Turn on irq debug checks (slow!)' CONFIG_IA64_DEBUG_IRQ
diff -u --recursive --new-file linux/arch/m68k/config.in 
linux.noprintk/arch/m68k/config.in
--- linux/arch/m68k/config.in	Thu Jan  4 22:00:55 2001
+++ linux.noprintk/arch/m68k/config.in	Sun Jan 28 10:56:09 2001
@@ -538,4 +538,5 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_NOPRINTK
 endmenu
diff -u --recursive --new-file linux/arch/mips/config.in 
linux.noprintk/arch/mips/config.in
--- linux/arch/mips/config.in	Thu Nov 16 21:51:28 2000
+++ linux.noprintk/arch/mips/config.in	Sun Jan 28 10:56:12 2001
@@ -397,4 +397,5 @@
   bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 fi
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_NOPRINTK
 endmenu
diff -u --recursive --new-file linux/arch/mips64/config.in 
linux.noprintk/arch/mips64/config.in
--- linux/arch/mips64/config.in	Wed Nov 29 06:42:04 2000
+++ linux.noprintk/arch/mips64/config.in	Sun Jan 28 10:56:31 2001
@@ -266,4 +266,5 @@
 fi
 bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_NOPRINTK
 endmenu
diff -u --recursive --new-file linux/arch/parisc/config.in 
linux.noprintk/arch/parisc/config.in
--- linux/arch/parisc/config.in	Tue Dec  5 21:29:39 2000
+++ linux.noprintk/arch/parisc/config.in	Sun Jan 28 10:56:34 2001
@@ -204,5 +204,6 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_NOPRINTK
 endmenu
 
diff -u --recursive --new-file linux/arch/ppc/config.in 
linux.noprintk/arch/ppc/config.in
--- linux/arch/ppc/config.in	Thu Nov 16 21:51:28 2000
+++ linux.noprintk/arch/ppc/config.in	Sun Jan 28 10:56:01 2001
@@ -324,6 +324,7 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_NOPRINTK
 bool 'Include kgdb kernel debugger' CONFIG_KGDB
 bool 'Include xmon kernel debugger' CONFIG_XMON
 endmenu
diff -u --recursive --new-file linux/arch/sh/config.in 
linux.noprintk/arch/sh/config.in
--- linux/arch/sh/config.in	Thu Jan  4 22:19:13 2001
+++ linux.noprintk/arch/sh/config.in	Sun Jan 28 10:55:55 2001
@@ -260,6 +260,7 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_NOPRINTK
 bool 'Use LinuxSH standard BIOS' CONFIG_SH_STANDARD_BIOS
 if [ "$CONFIG_SH_STANDARD_BIOS" = "y" ]; then
    bool 'GDB Stub kernel debug' CONFIG_DEBUG_KERNEL_WITH_GDB_STUB
diff -u --recursive --new-file linux/arch/sparc/config.in 
linux.noprintk/arch/sparc/config.in
--- linux/arch/sparc/config.in	Wed Nov 29 06:53:44 2000
+++ linux.noprintk/arch/sparc/config.in	Sun Jan 28 10:56:26 2001
@@ -258,4 +258,5 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_NOPRINTK
 endmenu
diff -u --recursive --new-file linux/arch/sparc64/config.in 
linux.noprintk/arch/sparc64/config.in
--- linux/arch/sparc64/config.in	Thu Nov 16 21:51:28 2000
+++ linux.noprintk/arch/sparc64/config.in	Sun Jan 28 10:56:29 2001
@@ -331,5 +331,6 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Disable kernel messages' CONFIG_NOPRINTK
 #bool 'ECache flush trap support at ta 0x72' CONFIG_EC_FLUSH_TRAP
 endmenu
diff -u --recursive --new-file linux/include/asm-i386/spinlock.h 
linux.noprintk/include/asm-i386/spinlock.h
--- linux/include/asm-i386/spinlock.h	Thu Jan  4 23:50:46 2001
+++ linux.noprintk/include/asm-i386/spinlock.h	Sun Jan 28 12:16:17 2001
@@ -5,8 +5,10 @@
 #include <asm/rwlock.h>
 #include <asm/page.h>
 
+#ifndef CONFIG_NOPRINTK
 extern int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+#endif
 
 /* It seems that people are forgetting to
  * initialize their spinlocks properly, tsk tsk.
diff -u --recursive --new-file linux/include/linux/kernel.h 
linux.noprintk/include/linux/kernel.h
--- linux/include/linux/kernel.h	Mon Dec 11 21:49:54 2000
+++ linux.noprintk/include/linux/kernel.h	Mon Jan 29 21:03:40 2001
@@ -48,8 +48,15 @@
 struct semaphore;
 
 extern struct notifier_block *panic_notifier_list;
+#ifdef CONFIG_NOPRINTK
+
+#define panic(format, args...) ((format ,## args),panic_nomsg())
+
+NORET_TYPE void panic_nomsg(void) ATTRIB_NORET;
+#else
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
+#endif
 NORET_TYPE void do_exit(long error_code)
 	ATTRIB_NORET;
 NORET_TYPE void up_and_exit(struct semaphore *, long)
@@ -68,8 +75,15 @@
 
 extern int session_of_pgrp(int pgrp);
 
+#ifdef CONFIG_NOPRINTK
+#define printk(format, args...) ((format ,## args),(int)0)
+
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
+++ linux.noprintk/kernel/ksyms.c	Sun Jan 28 10:56:51 2001
@@ -438,8 +439,10 @@
 EXPORT_SYMBOL(nr_running);
 
 /* misc */
+#ifndef CONFIG_NOPRINTK
 EXPORT_SYMBOL(panic);
 EXPORT_SYMBOL(printk);
+#endif
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(vsprintf);
 EXPORT_SYMBOL(kdevname);
diff -u --recursive --new-file linux/kernel/panic.c 
linux.noprintk/kernel/panic.c
--- linux/kernel/panic.c	Mon Oct 16 21:58:51 2000
+++ linux.noprintk/kernel/panic.c	Sun Jan 28 12:13:47 2001
@@ -43,18 +43,25 @@
  *	This function never returns.
  */
  
+#ifdef CONFIG_NOPRINTK
+NORET_TYPE void panic_nomsg(void)
+#else
 NORET_TYPE void panic(const char * fmt, ...)
+#endif
 {
-	static char buf[1024];
-	va_list args;
 #if defined(CONFIG_ARCH_S390)
         unsigned long caller = (unsigned long) __builtin_return_address(0);
 #endif
 
+#ifndef CONFIG_NOPRINTK
+	static char buf[1024];
+	va_list args;
+
 	va_start(args, fmt);
 	vsprintf(buf, fmt, args);
 	va_end(args);
 	printk(KERN_EMERG "Kernel panic: %s\n",buf);
+#endif
 	if (in_interrupt())
 		printk(KERN_EMERG "In interrupt handler - not syncing\n");
 	else if (!current->pid)
@@ -70,6 +77,9 @@
 
 	notifier_call_chain(&panic_notifier_list, 0, NULL);
 
+#ifdef CONFIG_NOPRINTK
+	machine_restart(NULL);
+#else
 	if (panic_timeout > 0)
 	{
 		/*
@@ -93,6 +103,7 @@
 		printk("Press L1-A to return to the boot prom\n");
 	}
 #endif
+#endif
 #if defined(CONFIG_ARCH_S390)
         disabled_wait(caller);
 #endif
@@ -101,3 +112,18 @@
 		CHECK_EMERGENCY_SYNC
 	}
 }
+
+#ifdef CONFIG_NOPRINTK
+#undef panic
+
+#include <linux/module.h>
+
+NORET_TYPE void panic(const char * fmt, ...)
+{
+	panic_nomsg();
+}
+
+EXPORT_SYMBOL_NOVERS(panic);
+
+#endif
+
diff -u --recursive --new-file linux/kernel/printk.c 
linux.noprintk/kernel/printk.c
--- linux/kernel/printk.c	Sun Dec 31 03:16:13 2000
+++ linux.noprintk/kernel/printk.c	Sun Jan 28 10:57:23 2001
@@ -25,7 +25,9 @@
 #define LOG_BUF_LEN	(16384)
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
 
+#ifndef CONFIG_NOPRINTK
 static char buf[1024];
+#endif
 
 /* printk's without a loglevel use this.. */
 #define DEFAULT_MESSAGE_LOGLEVEL 4 /* KERN_WARNING */
@@ -251,6 +253,20 @@
 	return do_syslog(type, buf, len);
 }
 
+
+#ifdef CONFIG_NOPRINTK
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
@@ -311,6 +327,7 @@
 	wake_up_interruptible(&log_wait);
 	return i;
 }
+#endif
 
 void console_print(const char *s)
 {
diff -u --recursive --new-file linux/Makefile linux.noprintk/Makefile
--- linux/Makefile	Thu Jan  4 22:48:13 2001
+++ linux.noprintk/Makefile	Mon Jan 29 20:51:51 2001
@@ -89,6 +90,10 @@
 
 CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer 
-fno-strict-aliasing
 AFLAGS := -D__ASSEMBLY__ $(CPPFLAGS)
+
+ifneq ($(CONFIG_NOPRINTK),)
+CFLAGS += -Wno-unused
+endif
 
 #
 # ROOT_DEV specifies the default root-device when making the image.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
