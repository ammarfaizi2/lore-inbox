Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264482AbUGFVRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbUGFVRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 17:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUGFVRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 17:17:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:13247 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264482AbUGFVQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 17:16:38 -0400
Date: Tue, 6 Jul 2004 16:16:27 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Spinlock timeout
Message-Id: <20040706161627.00f51cb0.moilanen@austin.ibm.com>
Organization: LTC
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This will cause a BUG() when a spinlock is held for longer then X
seconds.  It is useful for catching deadlocks since not all archs
have a NMI watchdog.

It is also helpful to find locks that are held too long.

Please comment or apply.

Thanks,
Jake

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---


diff -puN arch/alpha/Kconfig~spinlock-timeout arch/alpha/Kconfig
--- linux-2.6/arch/alpha/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/alpha/Kconfig	Tue Jul  6 15:16:51 2004
@@ -664,6 +664,20 @@ config DEBUG_SPINLOCK
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
diff -puN arch/alpha/defconfig~spinlock-timeout arch/alpha/defconfig
--- linux-2.6/arch/alpha/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/alpha/defconfig	Tue Jul  6 15:16:51 2004
@@ -868,6 +868,7 @@ CONFIG_MATHEMU=y
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_DEBUG_RWLOCK is not set
 # CONFIG_DEBUG_SEMAPHORE is not set
 CONFIG_DEBUG_INFO=y
diff -puN arch/arm/Kconfig~spinlock-timeout arch/arm/Kconfig
--- linux-2.6/arch/arm/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/arm/Kconfig	Tue Jul  6 15:16:51 2004
@@ -721,6 +721,20 @@ config DEBUG_SPINLOCK
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
diff -puN arch/arm/defconfig~spinlock-timeout arch/arm/defconfig
--- linux-2.6/arch/arm/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/arm/defconfig	Tue Jul  6 15:16:51 2004
@@ -507,5 +507,6 @@ CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_LL=y
diff -puN arch/arm26/Kconfig~spinlock-timeout arch/arm26/Kconfig
--- linux-2.6/arch/arm26/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/arm26/Kconfig	Tue Jul  6 15:16:51 2004
@@ -284,6 +284,20 @@ config DEBUG_SPINLOCK
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
diff -puN arch/arm26/defconfig~spinlock-timeout arch/arm26/defconfig
--- linux-2.6/arch/arm26/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/arm26/defconfig	Tue Jul  6 15:16:51 2004
@@ -344,6 +344,7 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_SLAB=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SPINLOCK=y
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_DEBUG_WAITQ=y
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_ERRORS=y
diff -puN arch/i386/Kconfig~spinlock-timeout arch/i386/Kconfig
--- linux-2.6/arch/i386/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/i386/Kconfig	Tue Jul  6 15:16:51 2004
@@ -1237,6 +1237,20 @@ config DEBUG_SPINLOCK
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
diff -puN arch/i386/defconfig~spinlock-timeout arch/i386/defconfig
--- linux-2.6/arch/i386/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/i386/defconfig	Tue Jul  6 15:16:51 2004
@@ -1216,6 +1216,7 @@ CONFIG_OPROFILE=y
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_EARLY_PRINTK=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_FRAME_POINTER is not set
 CONFIG_X86_FIND_SMP_CONFIG=y
 CONFIG_X86_MPPARSE=y
diff -puN arch/ia64/Kconfig~spinlock-timeout arch/ia64/Kconfig
--- linux-2.6/arch/ia64/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/ia64/Kconfig	Tue Jul  6 15:16:51 2004
@@ -459,6 +459,20 @@ config DEBUG_SPINLOCK_SLEEP
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
diff -puN arch/ia64/defconfig~spinlock-timeout arch/ia64/defconfig
--- linux-2.6/arch/ia64/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/ia64/defconfig	Tue Jul  6 15:16:51 2004
@@ -1093,6 +1093,7 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_IA64_DEBUG_CMPXCHG is not set
 # CONFIG_IA64_DEBUG_IRQ is not set
 CONFIG_DEBUG_INFO=y
diff -puN arch/mips/Kconfig~spinlock-timeout arch/mips/Kconfig
--- linux-2.6/arch/mips/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/mips/Kconfig	Tue Jul  6 15:16:51 2004
@@ -1314,6 +1314,20 @@ config DEBUG_SPINLOCK_SLEEP
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
diff -puN arch/mips/defconfig~spinlock-timeout arch/mips/defconfig
--- linux-2.6/arch/mips/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/mips/defconfig	Tue Jul  6 15:16:51 2004
@@ -122,6 +122,7 @@ CONFIG_CPU_HAS_LLDSCD=y
 CONFIG_CPU_HAS_SYNC=y
 # CONFIG_PREEMPT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
diff -puN arch/ppc/Kconfig~spinlock-timeout arch/ppc/Kconfig
--- linux-2.6/arch/ppc/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/ppc/Kconfig	Tue Jul  6 15:16:51 2004
@@ -1166,6 +1166,20 @@ config DEBUG_SPINLOCK_SLEEP
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
diff -puN arch/ppc/defconfig~spinlock-timeout arch/ppc/defconfig
--- linux-2.6/arch/ppc/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/ppc/defconfig	Tue Jul  6 15:16:51 2004
@@ -1223,6 +1223,7 @@ CONFIG_ZLIB_DEFLATE=y
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_BOOTX_TEXT=y
 
 #
diff -puN arch/ppc64/Kconfig~spinlock-timeout arch/ppc64/Kconfig
--- linux-2.6/arch/ppc64/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/ppc64/Kconfig	Tue Jul  6 15:16:51 2004
@@ -364,6 +364,20 @@ config MAGIC_SYSRQ
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
diff -puN arch/ppc64/defconfig~spinlock-timeout arch/ppc64/defconfig
--- linux-2.6/arch/ppc64/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/ppc64/defconfig	Tue Jul  6 15:16:51 2004
@@ -1054,6 +1054,7 @@ CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DEBUG_STACK_USAGE=y
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_DEBUGGER=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
diff -puN arch/s390/Kconfig~spinlock-timeout arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/s390/Kconfig	Tue Jul  6 15:16:51 2004
@@ -423,6 +423,20 @@ config DEBUG_SPINLOCK_SLEEP
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
diff -puN arch/s390/defconfig~spinlock-timeout arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/s390/defconfig	Tue Jul  6 15:16:51 2004
@@ -476,6 +476,7 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 
 #
 # Security options
diff -puN arch/sh/Kconfig~spinlock-timeout arch/sh/Kconfig
--- linux-2.6/arch/sh/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/sh/Kconfig	Tue Jul  6 15:16:51 2004
@@ -675,6 +675,20 @@ config DEBUG_SPINLOCK
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
diff -puN arch/sh/defconfig~spinlock-timeout arch/sh/defconfig
--- linux-2.6/arch/sh/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/sh/defconfig	Tue Jul  6 15:16:51 2004
@@ -351,6 +351,7 @@ CONFIG_MSDOS_PARTITION=y
 #
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_SH_STANDARD_BIOS=y
 CONFIG_SH_EARLY_PRINTK=y
 # CONFIG_KGDB is not set
diff -puN arch/sparc/Kconfig~spinlock-timeout arch/sparc/Kconfig
--- linux-2.6/arch/sparc/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/sparc/Kconfig	Tue Jul  6 15:16:51 2004
@@ -440,6 +440,20 @@ config DEBUG_SPINLOCK_SLEEP
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
diff -puN arch/sparc/defconfig~spinlock-timeout arch/sparc/defconfig
--- linux-2.6/arch/sparc/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/sparc/defconfig	Tue Jul  6 15:16:51 2004
@@ -611,6 +611,7 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_DEBUG_HIGHMEM is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
diff -puN arch/sparc64/Kconfig~spinlock-timeout arch/sparc64/Kconfig
--- linux-2.6/arch/sparc64/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/sparc64/Kconfig	Tue Jul  6 15:16:51 2004
@@ -658,6 +658,20 @@ config DEBUG_SPINLOCK_SLEEP
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
diff -puN arch/sparc64/defconfig~spinlock-timeout arch/sparc64/defconfig
--- linux-2.6/arch/sparc64/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/sparc64/defconfig	Tue Jul  6 15:16:51 2004
@@ -1718,6 +1718,7 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_DCFLUSH is not set
 # CONFIG_DEBUG_INFO is not set
diff -puN arch/um/Kconfig~spinlock-timeout arch/um/Kconfig
--- linux-2.6/arch/um/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/um/Kconfig	Tue Jul  6 15:16:51 2004
@@ -222,6 +222,20 @@ config DEBUG_SLAB
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
diff -puN arch/um/defconfig~spinlock-timeout arch/um/defconfig
--- linux-2.6/arch/um/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/um/defconfig	Tue Jul  6 15:16:51 2004
@@ -399,6 +399,7 @@ CONFIG_MTD_BLKMTD=m
 #
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_DEBUG_INFO=y
 CONFIG_FRAME_POINTER=y
 CONFIG_PT_PROXY=y
diff -puN arch/x86_64/Kconfig~spinlock-timeout arch/x86_64/Kconfig
--- linux-2.6/arch/x86_64/Kconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/x86_64/Kconfig	Tue Jul  6 15:16:51 2004
@@ -427,6 +427,20 @@ config DEBUG_SPINLOCK
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
diff -puN arch/x86_64/defconfig~spinlock-timeout arch/x86_64/defconfig
--- linux-2.6/arch/x86_64/defconfig~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/arch/x86_64/defconfig	Tue Jul  6 15:16:51 2004
@@ -814,6 +814,7 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_INIT_DEBUG is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_FRAME_POINTER is not set
diff -puN include/linux/jiffies.h~spinlock-timeout include/linux/jiffies.h
--- linux-2.6/include/linux/jiffies.h~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/include/linux/jiffies.h	Tue Jul  6 15:16:51 2004
@@ -3,8 +3,6 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/spinlock.h>
-#include <linux/seqlock.h>
 #include <asm/system.h>
 #include <asm/param.h>			/* for HZ */
 
diff -puN include/linux/spinlock.h~spinlock-timeout include/linux/spinlock.h
--- linux-2.6/include/linux/spinlock.h~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/include/linux/spinlock.h	Tue Jul  6 15:16:51 2004
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
 
 #if !defined(CONFIG_PREEMPT) && !defined(CONFIG_DEBUG_SPINLOCK)
@@ -216,12 +235,28 @@ do { \
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
 
+#endif /* CONFIG_SPINLOCK_TIMEOUT */
+
 #define write_lock(lock) \
 do { \
 	preempt_disable(); \
@@ -256,22 +291,19 @@ do { \
 #define spin_lock_irqsave(lock, flags) \
 do { \
 	local_irq_save(flags); \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
+	spin_lock(lock); \
 } while (0)
 
 #define spin_lock_irq(lock) \
 do { \
 	local_irq_disable(); \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
+	spin_lock(lock); \
 } while (0)
 
 #define spin_lock_bh(lock) \
 do { \
 	local_bh_disable(); \
-	preempt_disable(); \
-	_raw_spin_lock(lock); \
+	spin_lock(lock); \
 } while (0)
 
 #define read_lock_irqsave(lock, flags) \
diff -puN kernel/sched.c~spinlock-timeout kernel/sched.c
--- linux-2.6/kernel/sched.c~spinlock-timeout	Tue Jul  6 15:16:51 2004
+++ linux-2.6-moilanen/kernel/sched.c	Tue Jul  6 15:16:51 2004
@@ -3022,14 +3022,23 @@ EXPORT_SYMBOL(__might_sleep);
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

_
