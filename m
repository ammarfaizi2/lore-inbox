Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266231AbUFUNhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266231AbUFUNhg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 09:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266228AbUFUNhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 09:37:36 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1984 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266231AbUFUNgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 09:36:38 -0400
Date: Mon, 21 Jun 2004 08:36:25 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] Spinlock timeouts
Message-Id: <20040621083625.1f9b83bd.moilanen@austin.ibm.com>
Organization: LTC
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will BUG() when a spinlock is held for longer then X
seconds.  It is useful for catching deadlocks since not all archs have a
NMI watchdog.  

It is also helpful to find locks that are held too long.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

diff -Nru a/arch/alpha/Kconfig b/arch/alpha/Kconfig
--- a/arch/alpha/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/alpha/Kconfig	Mon Jun 14 08:05:25 2004
@@ -664,6 +664,20 @@
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 config DEBUG_RWLOCK
 	bool "Read-write spinlock debugging"
 	depends on DEBUG_KERNEL
diff -Nru a/arch/alpha/defconfig b/arch/alpha/defconfig
--- a/arch/alpha/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/alpha/defconfig	Mon Jun 14 08:05:25 2004
@@ -868,6 +868,7 @@
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_DEBUG_RWLOCK is not set
 # CONFIG_DEBUG_SEMAPHORE is not set
 CONFIG_DEBUG_INFO=y
diff -Nru a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/arm/Kconfig	Mon Jun 14 08:05:25 2004
@@ -728,6 +728,20 @@
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 config DEBUG_WAITQ
 	bool "Wait queue debugging"
 	depends on DEBUG_KERNEL
diff -Nru a/arch/arm/defconfig b/arch/arm/defconfig
--- a/arch/arm/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/arm/defconfig	Mon Jun 14 08:05:25 2004
@@ -507,5 +507,6 @@
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_LL=y
diff -Nru a/arch/arm26/Kconfig b/arch/arm26/Kconfig
--- a/arch/arm26/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/arm26/Kconfig	Mon Jun 14 08:05:25 2004
@@ -284,6 +284,20 @@
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 config DEBUG_WAITQ
 	bool "Wait queue debugging"
 	depends on DEBUG_KERNEL
diff -Nru a/arch/arm26/defconfig b/arch/arm26/defconfig
--- a/arch/arm26/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/arm26/defconfig	Mon Jun 14 08:05:25 2004
@@ -344,6 +344,7 @@
 CONFIG_DEBUG_SLAB=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SPINLOCK=y
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_DEBUG_WAITQ=y
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_ERRORS=y
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/i386/Kconfig	Mon Jun 14 08:05:25 2004
@@ -1247,6 +1247,20 @@
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 config DEBUG_PAGEALLOC
 	bool "Page alloc debugging"
 	depends on DEBUG_KERNEL
diff -Nru a/arch/i386/defconfig b/arch/i386/defconfig
--- a/arch/i386/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/i386/defconfig	Mon Jun 14 08:05:25 2004
@@ -1220,6 +1220,7 @@
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_EARLY_PRINTK=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_FRAME_POINTER is not set
 CONFIG_4KSTACKS=y
 CONFIG_X86_FIND_SMP_CONFIG=y
diff -Nru a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/ia64/Kconfig	Mon Jun 14 08:05:25 2004
@@ -468,6 +468,20 @@
 	    If you say Y here, various routines which may sleep will become very
 	    noisy if they are called with a spinlock held.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 config IA64_DEBUG_CMPXCHG
 	bool "Turn on compare-and-exchange bug checking (slow!)"
 	depends on DEBUG_KERNEL
diff -Nru a/arch/ia64/defconfig b/arch/ia64/defconfig
--- a/arch/ia64/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/ia64/defconfig	Mon Jun 14 08:05:25 2004
@@ -1089,6 +1089,7 @@
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_IA64_DEBUG_CMPXCHG is not set
 # CONFIG_IA64_DEBUG_IRQ is not set
 CONFIG_DEBUG_INFO=y
diff -Nru a/arch/mips/Kconfig b/arch/mips/Kconfig
--- a/arch/mips/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/mips/Kconfig	Mon Jun 14 08:05:25 2004
@@ -1360,6 +1360,20 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 config RTC_DS1742
 	bool "DS1742 BRAM/RTC support"
 	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927
diff -Nru a/arch/mips/defconfig b/arch/mips/defconfig
--- a/arch/mips/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/mips/defconfig	Mon Jun 14 08:05:25 2004
@@ -125,6 +125,7 @@
 CONFIG_CPU_HAS_SYNC=y
 # CONFIG_PREEMPT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/ppc/Kconfig	Mon Jun 14 08:05:25 2004
@@ -1199,6 +1199,20 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 config KGDB
 	bool "Include kgdb kernel debugger"
 	depends on DEBUG_KERNEL
diff -Nru a/arch/ppc/defconfig b/arch/ppc/defconfig
--- a/arch/ppc/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/ppc/defconfig	Mon Jun 14 08:05:25 2004
@@ -1318,6 +1318,7 @@
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_BOOTX_TEXT=y
 
 #
diff -Nru a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/ppc64/Kconfig	Mon Jun 14 08:05:25 2004
@@ -387,6 +387,20 @@
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 config DEBUGGER
 	bool "Enable debugger hooks"
 	depends on DEBUG_KERNEL
diff -Nru a/arch/ppc64/defconfig b/arch/ppc64/defconfig
--- a/arch/ppc64/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/ppc64/defconfig	Mon Jun 14 08:05:25 2004
@@ -1054,6 +1054,7 @@
 CONFIG_DEBUG_STACK_USAGE=y
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_DEBUGGER=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
diff -Nru a/arch/s390/Kconfig b/arch/s390/Kconfig
--- a/arch/s390/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/s390/Kconfig	Mon Jun 14 08:05:25 2004
@@ -423,6 +423,20 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.	
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 endmenu
 
 source "security/Kconfig"
diff -Nru a/arch/s390/defconfig b/arch/s390/defconfig
--- a/arch/s390/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/s390/defconfig	Mon Jun 14 08:05:25 2004
@@ -474,6 +474,7 @@
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 
 #
 # Security options
diff -Nru a/arch/sh/Kconfig b/arch/sh/Kconfig
--- a/arch/sh/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/sh/Kconfig	Mon Jun 14 08:05:25 2004
@@ -675,6 +675,20 @@
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 config SH_STANDARD_BIOS
 	bool "Use LinuxSH standard BIOS"
 	help
diff -Nru a/arch/sh/defconfig b/arch/sh/defconfig
--- a/arch/sh/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/sh/defconfig	Mon Jun 14 08:05:25 2004
@@ -351,6 +351,7 @@
 #
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_SH_STANDARD_BIOS=y
 CONFIG_SH_EARLY_PRINTK=y
 # CONFIG_KGDB is not set
diff -Nru a/arch/sparc/Kconfig b/arch/sparc/Kconfig
--- a/arch/sparc/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/sparc/Kconfig	Mon Jun 14 08:05:25 2004
@@ -440,6 +440,20 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.	
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting (adds 70K)"
 	depends on DEBUG_KERNEL
diff -Nru a/arch/sparc/defconfig b/arch/sparc/defconfig
--- a/arch/sparc/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/sparc/defconfig	Mon Jun 14 08:05:25 2004
@@ -611,6 +611,7 @@
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_DEBUG_HIGHMEM is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
diff -Nru a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/sparc64/Kconfig	Mon Jun 14 08:05:25 2004
@@ -658,6 +658,20 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.	
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting (adds 70K)"
 	depends on DEBUG_KERNEL
diff -Nru a/arch/sparc64/defconfig b/arch/sparc64/defconfig
--- a/arch/sparc64/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/sparc64/defconfig	Mon Jun 14 08:05:25 2004
@@ -1727,6 +1727,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_DCFLUSH is not set
 # CONFIG_DEBUG_INFO is not set
diff -Nru a/arch/um/Kconfig b/arch/um/Kconfig
--- a/arch/um/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/um/Kconfig	Mon Jun 14 08:05:25 2004
@@ -222,6 +222,20 @@
 config DEBUG_SPINLOCK
 	bool "Debug spinlocks usage"
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 config DEBUG_INFO
 	bool "Enable kernel debugging symbols"
 	help
diff -Nru a/arch/um/defconfig b/arch/um/defconfig
--- a/arch/um/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/um/defconfig	Mon Jun 14 08:05:25 2004
@@ -399,6 +399,7 @@
 #
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_DEBUG_INFO=y
 CONFIG_FRAME_POINTER=y
 CONFIG_PT_PROXY=y
diff -Nru a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/x86_64/Kconfig	Mon Jun 14 08:05:25 2004
@@ -436,6 +436,20 @@
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout"	  
+       depends on DEBUG_KERNEL && SMP
+       help
+         If you say Y here, the spinlocks will timeout after X number
+	 of seconds. This is useful for catching deadlocks, and make sure
+	 locks are not held too long.
+
+config SPINLOCK_TIMEOUT_TIME
+	int "Spinlock timeout time in seconds (1-43200)"
+	range 1 43200
+	depends on SPINLOCK_TIMEOUT
+	default "10"
+
 # !SMP for now because the context switch early causes GPF in segment reloading
 # and the GS base checking does the wrong thing then, causing a hang.
 config CHECKING
diff -Nru a/arch/x86_64/defconfig b/arch/x86_64/defconfig
--- a/arch/x86_64/defconfig	Mon Jun 14 08:05:25 2004
+++ b/arch/x86_64/defconfig	Mon Jun 14 08:05:25 2004
@@ -910,6 +910,7 @@
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_INIT_DEBUG is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_FRAME_POINTER is not set
diff -Nru a/include/linux/jiffies.h b/include/linux/jiffies.h
--- a/include/linux/jiffies.h	Mon Jun 14 08:05:25 2004
+++ b/include/linux/jiffies.h	Mon Jun 14 08:05:25 2004
@@ -3,8 +3,6 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/spinlock.h>
-#include <linux/seqlock.h>
 #include <asm/system.h>
 #include <asm/param.h>			/* for HZ */
 
diff -Nru a/include/linux/spinlock.h b/include/linux/spinlock.h
--- a/include/linux/spinlock.h	Mon Jun 14 08:05:25 2004
+++ b/include/linux/spinlock.h	Mon Jun 14 08:05:25 2004
@@ -38,6 +38,25 @@
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
 
+#if defined(CONFIG_SPINLOCK_TIMEOUT)
+
+#include <linux/jiffies.h>
+
+#define SPINLOCK_TIMEOUT CONFIG_SPINLOCK_TIMEOUT_TIME
+
+/*
+ * There are paths where jiffies won't be updated and
+ * SPINLOCK_TIMEOUT will not work.  To ensure they work, it is best
+ * to have every arch implement their own SPINLOCK_TIMEOUT routines
+ * that use hardware timers.
+ */
+#ifndef ARCH_HAS_SPINLOCK_TIMEOUT
+#define get_spinlock_timeout() (jiffies + (SPINLOCK_TIMEOUT * HZ))
+#define check_spinlock_timeout(timeout) (time_after_eq(jiffies, timeout))
+#endif /* !ARCH_HASH_SPINLOCK_TIMEOUT */
+
+#endif /* CONFIG_SPINLOCK_TIMEOUT */
+
 #else
 
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
@@ -218,11 +237,27 @@
 } while (0)
 
 #else
+#if defined(CONFIG_SPINLOCK_TIMEOUT)
+
+static inline void spin_lock(spinlock_t * lock) {
+	unsigned long timeout = get_spinlock_timeout();
+
+	preempt_disable(); 
+	do { 
+		if (check_spinlock_timeout(timeout)) 
+		        BUG();
+	} while (!_raw_spin_trylock(lock));
+}
+
+#else /* CONFIG_SPINLOCK_TIMEOUT */
+
 #define spin_lock(lock)	\
 do { \
 	preempt_disable(); \
 	_raw_spin_lock(lock); \
 } while(0)
+
+#endif /* CONFIG_SPINLOCK_TIMEOUT */
 
 #define write_lock(lock) \
 do { \
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Mon Jun 14 08:05:25 2004
+++ b/kernel/sched.c	Mon Jun 14 08:05:25 2004
@@ -3998,14 +3998,23 @@
  */
 void __sched __preempt_spin_lock(spinlock_t *lock)
 {
+#if defined(CONFIG_SPINLOCK_TIMEOUT)
+	unsigned long timeout = get_spinlock_timeout();
+#endif
+
 	if (preempt_count() > 1) {
 		_raw_spin_lock(lock);
 		return;
 	}
 	do {
 		preempt_enable();
-		while (spin_is_locked(lock))
+		while (spin_is_locked(lock)) {
+#if defined(CONFIG_SPINLOCK_TIMEOUT)
+			if (check_spinlock_timeout(timeout)) 
+				BUG();
+#endif
 			cpu_relax();
+		}
 		preempt_disable();
 	} while (!_raw_spin_trylock(lock));
 }
