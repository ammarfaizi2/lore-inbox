Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281027AbRLDQo1>; Tue, 4 Dec 2001 11:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280961AbRLDQnz>; Tue, 4 Dec 2001 11:43:55 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:5583 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281068AbRLDQmO>; Tue, 4 Dec 2001 11:42:14 -0500
From: Stefani Seibold <stefani@seibold.net>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Subject: patch for suppress printk messages
Date: Tue, 4 Dec 2001 17:40:21 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Stefani@seibold.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_9NVTVK5SIZIXL0WLMKGJ"
Message-ID: <16BIdM-12MonAC@fmrl05.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_9NVTVK5SIZIXL0WLMKGJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi everybody,

this is my new version for suppressing kernel printk messages. This will shrink
the kernel by an average of 10 percent (for example my desktop kernel will shrink
about 90K).
It is usefull on deeply embedded systems with no human interactions  and for rescue 
discs where the diskspace is always to less.

This patch has the following features:

- The macro printk will evalute all parameters, than throw it away and return 0 as 
  result. So it should be do the same from the callers view, like the original printk 
  function, but all arguments will be removed by compiler optimatzion if possible.

- The macro panic will also evaluate the parameters and throw it away by compiler
  optimatzion if possible.

- No compiler warnings also on max. compiler warning level.

- Up to 16 arguments will be evaluated. This can be simply extended by adding
  additional DOARG_xx Macros.

- For backward compatibility the functions printk and panic will be also implemented and
  exported as functions with no output .

- The name of the config variable is CONFIG_DEBUG_SUPPRESS.

- The option for disabling the printk and panic messages in the menu kernel 
  hacking.

The complexity for the printk and panic macro is still necessary, because this
is the only way, to evaluate a macro with variable arguments without
compiler warnings.

I hope this will it now do in the developer kernel release 2.5, because no side 
effects should be now expect.

Thanks,
Stefani Seibold

-----patch for suppress printk messages against 2.4.16  -----

diff -u --recursive --new-file linux.orig/Documentation/Configure.help linux.new/Documentation/Configure.help
--- /home/stefani/soft/kernel/linux/Documentation/Configure.help        Thu Nov 22 19:52:44 2001
+++ linux/Documentation/Configure.help  Tue Dec  4 16:40:24 2001
@@ -23590,11 +23590,19 @@
   best used in conjunction with the NMI watchdog so that spinlock
   deadlocks are also debuggable.
 
-Verbose BUG() reporting (adds 70K)
-CONFIG_DEBUG_BUGVERBOSE
-  Say Y here to make BUG() panics output the file name and line number
-  of the BUG call as well as the EIP and oops trace.  This aids
-  debugging but costs about 70-100K of memory.
+Kernel debug output
+CONFIG_DEBUG_DEFAULT
+  Which this option, you can specify the kernel verbosity.
+
+  - default is the normal setting for most linux boxes (Server, Desktop)
+  - verbose will aids debugging and is the recommended setting for kernel
+    hackers. Say Y here to make BUG() panics output the file name and line
+    number of the BUG call as well as the EIP and oops trace.
+    (this options adds 70K-100K to your kernel)
+  - suppress wil be useful for deeply embedded system where nobody will
+    see any kernel output
+    (this option will save a lot of rom and ram space >70K)
+    
 
 Include kgdb kernel debugger
 CONFIG_KGDB
diff -u --recursive --new-file linux.orig/kernel/panic.c linux.new/kernel/panic.c
--- /home/stefani/soft/kernel/linux/kernel/panic.c      Tue Dec  4 16:10:36 2001
+++ linux/kernel/panic.c        Tue Dec  4 14:10:45 2001
@@ -8,14 +8,17 @@
  * This function is used through-out the kernel (including mm and fs)
  * to indicate a major problem.
  */
-#include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/notifier.h>
-#include <linux/init.h>
 #include <linux/sysrq.h>
-#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>                   /* For in_interrupt() */
+#include <linux/config.h>
+
+#include <asm/uaccess.h>
 
 asmlinkage void sys_sync(void);        /* it's really int */
 
@@ -31,6 +34,12 @@
 
 __setup("panic=", panic_setup);
 
+#ifdef CONFIG_DEBUG_SUPPRESS
+#undef panic
+
+NORET_TYPE void panic_nomsg(void) __attribute__ ((alias("panic")));
+#endif
+
 /**
  *     panic - halt the system
  *     @fmt: The text string to print
@@ -43,17 +52,21 @@
  
 NORET_TYPE void panic(const char * fmt, ...)
 {
-       static char buf[1024];
-       va_list args;
 #if defined(CONFIG_ARCH_S390)
         unsigned long caller = (unsigned long) __builtin_return_address(0);
 #endif
+#ifndef CONFIG_DEBUG_SUPPRESS
+       static char buf[1024];
+       va_list args;
 
-       bust_spinlocks(1);
        va_start(args, fmt);
        vsprintf(buf, fmt, args);
        va_end(args);
        printk(KERN_EMERG "Kernel panic: %s\n",buf);
+#else
+       (void)(fmt);
+#endif
+       bust_spinlocks(1);
        if (in_interrupt())
                printk(KERN_EMERG "In interrupt handler - not syncing\n");
        else if (!current->pid)
@@ -100,7 +113,9 @@
        }
 }
 
-/**
+EXPORT_SYMBOL(panic);
+
+/*
  *     print_tainted - return a string to represent the kernel taint state.
  *
  *     The string is overwritten by the next call to print_taint().
diff -u --recursive --new-file linux.orig/kernel/printk.c linux.new/kernel/printk.c
--- /home/stefani/soft/kernel/linux/kernel/printk.c     Tue Dec  4 16:10:36 2001
+++ linux/kernel/printk.c       Tue Dec  4 16:07:20 2001
@@ -371,6 +371,22 @@
        _call_console_drivers(start_print, end, msg_level);
 }
 
+#ifdef CONFIG_DEBUG_SUPPRESS
+
+/*
+ * Disable printk function calls
+ * This is useful for deeply embedded system where nobody will see the
+ * kernel output
+ * Stefani Seibold <Stefani@Seibold.net>
+ */
+
+#undef printk
+asmlinkage int printk(const char *fmt, ...)
+{
+       (void)(fmt);
+       return 0;
+}
+#else
 static void emit_log_char(char c)
 {
        LOG_BUF(log_end) = c;
@@ -456,6 +472,8 @@
        }
        return printed_len;
 }
+#endif
+
 EXPORT_SYMBOL(printk);
 
 /**
diff -u --recursive --new-file linux.orig/kernel/ksyms.c linux.new/kernel/ksyms.c
--- /home/stefani/soft/kernel/linux/kernel/ksyms.c      Tue Dec  4 16:10:36 2001
+++ linux/kernel/ksyms.c        Tue Dec  4 14:03:53 2001
@@ -449,7 +449,6 @@
 EXPORT_SYMBOL(nr_running);
 
 /* misc */
-EXPORT_SYMBOL(panic);
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(snprintf);
 EXPORT_SYMBOL(sscanf);
diff -u --recursive --new-file linux.orig/kernel/Makefile linux.new/kernel/Makefile
--- /home/stefani/soft/kernel/linux/kernel/Makefile     Tue Dec  4 16:10:36 2001
+++ linux/kernel/Makefile       Tue Dec  4 13:52:24 2001
@@ -9,7 +9,7 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o panic.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
            module.o exit.o itimer.o info.o time.o softirq.o resource.o \
diff -u --recursive --new-file linux.orig/include/linux/kernel.h linux.new/include/linux/kernel.h
--- /home/stefani/soft/kernel/linux/include/linux/kernel.h      Tue Dec  4 16:10:36 2001
+++ linux/include/linux/kernel.h        Tue Dec  4 16:31:23 2001
@@ -49,8 +49,16 @@
 struct completion;
 
 extern struct notifier_block *panic_notifier_list;
+
 NORET_TYPE void panic(const char * fmt, ...)
        __attribute__ ((NORET_AND format (printf, 1, 2)));
+
+#ifdef CONFIG_DEBUG_SUPPRESS
+#define panic(format ,args...) (DOARG_0(format, ## args ,0),panic_nomsg())
+
+NORET_TYPE void panic_nomsg(void) ATTRIB_NORET;
+#endif
+
 asmlinkage NORET_TYPE void do_exit(long error_code)
        ATTRIB_NORET;
 NORET_TYPE void complete_and_exit(struct completion *, long)
@@ -79,8 +87,35 @@
 
 extern int session_of_pgrp(int pgrp);
 
+#ifdef CONFIG_DEBUG_SUPPRESS
+static __inline__ int printk_nomsg(void)
+{
+       return 0;
+}
+
+#define DOARG_15(arg, args...) ((void)(arg))
+#define DOARG_14(arg, args...) (DOARG_15(args,0),((void)(arg)))
+#define DOARG_13(arg, args...) (DOARG_14(args,0),((void)(arg)))
+#define DOARG_12(arg, args...) (DOARG_13(args,0),((void)(arg)))
+#define DOARG_11(arg, args...) (DOARG_12(args,0),((void)(arg)))
+#define DOARG_10(arg, args...) (DOARG_11(args,0),((void)(arg)))
+#define DOARG_9(arg, args...)  (DOARG_10(args,0),((void)(arg)))
+#define DOARG_8(arg, args...)  (DOARG_9(args,0),((void)(arg)))
+#define DOARG_7(arg, args...)  (DOARG_8(args,0),((void)(arg)))
+#define DOARG_6(arg, args...)  (DOARG_7(args,0),((void)(arg)))
+#define DOARG_5(arg, args...)  (DOARG_6(args,0),((void)(arg)))
+#define DOARG_4(arg, args...)  (DOARG_5(args,0),((void)(arg)))
+#define DOARG_3(arg, args...)  (DOARG_5(args,0),((void)(arg)))
+#define DOARG_2(arg, args...)  (DOARG_3(args,0),((void)(arg)))
+#define DOARG_1(arg, args...)  (DOARG_2(args,0),((void)(arg)))
+#define DOARG_0(arg, args...)  (DOARG_1(args,0),((void)(arg)))
+
+#define printk(format ,args...)        (DOARG_0(format, ## args ,0),printk_nomsg())
+#else
+
 asmlinkage int printk(const char * fmt, ...)
        __attribute__ ((format (printf, 1, 2)));
+#endif
 
 extern int console_loglevel;
 
diff -u --recursive --new-file linux.orig/include/asm-i386/spinlock.h linux.new/include/asm-i386/spinlock.h
--- /home/stefani/soft/kernel/linux/include/asm-i386/spinlock.h Tue Dec  4 16:10:36 2001
+++ linux/include/asm-i386/spinlock.h   Tue Dec  4 14:12:00 2001
@@ -6,8 +6,12 @@
 #include <asm/page.h>
 #include <linux/config.h>
 
+#ifdef CONFIG_DEBUG_SUPPRESS
+inline int printk(const char * fmt, ...) { (void)(fmt); }
+#else
 extern int printk(const char * fmt, ...)
        __attribute__ ((format (printf, 1, 2)));
+#endif
 
 /* It seems that people are forgetting to
  * initialize their spinlocks properly, tsk tsk.
diff -u --recursive --new-file linux.orig/arch/i386/kernel/head.S linux.new/arch/i386/kernel/head.S
--- /home/stefani/soft/kernel/linux/arch/i386/kernel/head.S     Tue Dec  4 16:10:36 2001
+++ linux/arch/i386/kernel/head.S       Tue Dec  4 16:11:19 2001
@@ -324,6 +324,7 @@
        .long __KERNEL_DS
 
 /* This is the default interrupt "handler" :-) */
+#ifndef CONFIG_DEBUG_SUPPRESS
 int_msg:
        .asciz "Unknown interrupt\n"
        ALIGN
@@ -345,6 +346,11 @@
        popl %edx
        popl %ecx
        popl %eax
+#else
+ignore_int:
+       ALIGN
+       cld
+#endif
        iret
 
 /*
diff -u --recursive --new-file linux.orig/arch/i386/config.in linux.new/arch/i386/config.in
--- /home/stefani/soft/kernel/linux/arch/i386/config.in Tue Dec  4 16:10:36 2001
+++ linux/arch/i386/config.in   Tue Dec  4 16:37:02 2001
@@ -406,7 +406,10 @@
    bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
-   bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
+   choice 'Kernel debug output' \
+       "default                CONFIG_DEBUG_DEFAULT \
+        verbose                CONFIG_DEBUG_BUGVERBOSE \
+        suppress               CONFIG_DEBUG_SUPPRESS" default
 fi
 
 endmenu
diff -u --recursive --new-file linux.orig/arch/ppc/config.in linux.new/arch/ppc/config.in
--- /home/stefani/soft/kernel/linux/arch/ppc/config.in  Tue Dec  4 16:10:36 2001
+++ linux/arch/ppc/config.in    Tue Dec  4 14:42:33 2001
@@ -392,4 +392,8 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Include kgdb kernel debugger' CONFIG_KGDB
 bool 'Include xmon kernel debugger' CONFIG_XMON
+choice 'Kernel debug output' \
+       "default                CONFIG_DEBUG_DEFAULT \
+        verbose                CONFIG_DEBUG_BUGVERBOSE \
+        suppress               CONFIG_DEBUG_SUPPRESS" default
 endmenu

--------------Boundary-00=_9NVTVK5SIZIXL0WLMKGJ
Content-Type: application/x-gzip;
  name="patch-suppress-debug.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-suppress-debug.gz"

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

--------------Boundary-00=_9NVTVK5SIZIXL0WLMKGJ--
