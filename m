Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUFEUbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUFEUbz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 16:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUFEUbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 16:31:55 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:50076 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S261867AbUFEUb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 16:31:28 -0400
Subject: [PATCH][RFC] Spinlock-timeout
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-2oyfThvPmuyKlIpoWdoE"
Message-Id: <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 05 Jun 2004 15:31:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2oyfThvPmuyKlIpoWdoE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here's a patch that will BUG() when a spinlock is held for longer then X
seconds.  It is useful for catching deadlocks since not all archs have a
NMI watchdog.  

It is also helpful to find locks that are held too long.

Please send comments.

Thanks,
Jake



--=-2oyfThvPmuyKlIpoWdoE
Content-Disposition: attachment; filename=spinlock-timeout-2.6-1.patch
Content-Type: text/x-patch; name=spinlock-timeout-2.6-1.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1613  -> 1.1614 
#	  arch/sparc/Kconfig	1.29    -> 1.30   
#	 arch/ia64/defconfig	1.28    -> 1.29   
#	 arch/mips/defconfig	1.12    -> 1.13   
#	   arch/i386/Kconfig	1.113   -> 1.114  
#	arch/arm26/defconfig	1.3     -> 1.4    
#	arch/ppc64/defconfig	1.53    -> 1.54   
#	  arch/arm/defconfig	1.6     -> 1.7    
#	arch/sparc64/defconfig	1.127   -> 1.128  
#	   arch/s390/Kconfig	1.26    -> 1.27   
#	   arch/mips/Kconfig	1.27    -> 1.28   
#	     arch/um/Kconfig	1.16    -> 1.17   
#	include/linux/spinlock.h	1.29    -> 1.30   
#	arch/alpha/defconfig	1.26    -> 1.27   
#	    arch/arm/Kconfig	1.51    -> 1.52   
#	   arch/sh/defconfig	1.10    -> 1.11   
#	  arch/ppc64/Kconfig	1.64    -> 1.65   
#	  arch/arm26/Kconfig	1.12    -> 1.13   
#	 arch/i386/defconfig	1.113   -> 1.114  
#	arch/x86_64/defconfig	1.39    -> 1.40   
#	arch/sparc/defconfig	1.20    -> 1.21   
#	 arch/x86_64/Kconfig	1.48    -> 1.49   
#	      kernel/sched.c	1.252   -> 1.253  
#	  arch/ppc/defconfig	1.28    -> 1.29   
#	 arch/s390/defconfig	1.36    -> 1.37   
#	arch/sparc64/Kconfig	1.55    -> 1.56   
#	   arch/ia64/Kconfig	1.66    -> 1.67   
#	    arch/ppc/Kconfig	1.52    -> 1.53   
#	     arch/sh/Kconfig	1.31    -> 1.32   
#	   arch/um/defconfig	1.9     -> 1.10   
#	  arch/alpha/Kconfig	1.37    -> 1.38   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/06/05	moilanen@zippy.ltc.austin.ibm.com	1.1614
# Spinlock timeout
# --------------------------------------------
#
diff -Nru a/arch/alpha/Kconfig b/arch/alpha/Kconfig
--- a/arch/alpha/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/alpha/Kconfig	Sat Jun  5 14:25:51 2004
@@ -664,6 +664,20 @@
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
--- a/arch/alpha/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/alpha/defconfig	Sat Jun  5 14:25:51 2004
@@ -868,6 +868,7 @@
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_DEBUG_RWLOCK is not set
 # CONFIG_DEBUG_SEMAPHORE is not set
 CONFIG_DEBUG_INFO=y
diff -Nru a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/arm/Kconfig	Sat Jun  5 14:25:51 2004
@@ -721,6 +721,20 @@
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
--- a/arch/arm/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/arm/defconfig	Sat Jun  5 14:25:51 2004
@@ -507,5 +507,6 @@
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_USER=y
 # CONFIG_DEBUG_INFO is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_LL=y
diff -Nru a/arch/arm26/Kconfig b/arch/arm26/Kconfig
--- a/arch/arm26/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/arm26/Kconfig	Sat Jun  5 14:25:51 2004
@@ -284,6 +284,20 @@
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
--- a/arch/arm26/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/arm26/defconfig	Sat Jun  5 14:25:51 2004
@@ -344,6 +344,7 @@
 CONFIG_DEBUG_SLAB=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SPINLOCK=y
+CONFIG_SPINLOCK_TIMEOUT=y
 CONFIG_DEBUG_WAITQ=y
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_ERRORS=y
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/i386/Kconfig	Sat Jun  5 14:25:51 2004
@@ -1247,6 +1247,20 @@
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
--- a/arch/i386/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/i386/defconfig	Sat Jun  5 14:25:51 2004
@@ -1216,6 +1216,7 @@
 # CONFIG_DEBUG_KERNEL is not set
 CONFIG_EARLY_PRINTK=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_FRAME_POINTER is not set
 CONFIG_X86_FIND_SMP_CONFIG=y
 CONFIG_X86_MPPARSE=y
diff -Nru a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/ia64/Kconfig	Sat Jun  5 14:25:51 2004
@@ -459,6 +459,20 @@
 	    If you say Y here, various routines which may sleep will become very
 	    noisy if they are called with a spinlock held.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
--- a/arch/ia64/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/ia64/defconfig	Sat Jun  5 14:25:51 2004
@@ -1093,6 +1093,7 @@
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_IA64_DEBUG_CMPXCHG is not set
 # CONFIG_IA64_DEBUG_IRQ is not set
 CONFIG_DEBUG_INFO=y
diff -Nru a/arch/mips/Kconfig b/arch/mips/Kconfig
--- a/arch/mips/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/mips/Kconfig	Sat Jun  5 14:25:51 2004
@@ -1360,6 +1360,20 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
--- a/arch/mips/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/mips/defconfig	Sat Jun  5 14:25:51 2004
@@ -125,6 +125,7 @@
 CONFIG_CPU_HAS_SYNC=y
 # CONFIG_PREEMPT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/ppc/Kconfig	Sat Jun  5 14:25:51 2004
@@ -1166,6 +1166,20 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
--- a/arch/ppc/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/ppc/defconfig	Sat Jun  5 14:25:51 2004
@@ -1223,6 +1223,7 @@
 # Kernel hacking
 #
 # CONFIG_DEBUG_KERNEL is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_BOOTX_TEXT=y
 
 #
diff -Nru a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/ppc64/Kconfig	Sat Jun  5 14:25:51 2004
@@ -465,7 +465,21 @@
 	help
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
-	  
+
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
diff -Nru a/arch/ppc64/defconfig b/arch/ppc64/defconfig
--- a/arch/ppc64/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/ppc64/defconfig	Sat Jun  5 14:25:51 2004
@@ -1067,6 +1067,7 @@
 # CONFIG_PPCDBG is not set
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
+# CONFIG_SPINLOCK_TIMEOUT is not set
 
 #
 # Security options
diff -Nru a/arch/s390/Kconfig b/arch/s390/Kconfig
--- a/arch/s390/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/s390/Kconfig	Sat Jun  5 14:25:51 2004
@@ -423,6 +423,20 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.	
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
--- a/arch/s390/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/s390/defconfig	Sat Jun  5 14:25:51 2004
@@ -476,6 +476,7 @@
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 
 #
 # Security options
diff -Nru a/arch/sh/Kconfig b/arch/sh/Kconfig
--- a/arch/sh/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/sh/Kconfig	Sat Jun  5 14:25:51 2004
@@ -675,6 +675,20 @@
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
--- a/arch/sh/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/sh/defconfig	Sat Jun  5 14:25:51 2004
@@ -351,6 +351,7 @@
 #
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_SH_STANDARD_BIOS=y
 CONFIG_SH_EARLY_PRINTK=y
 # CONFIG_KGDB is not set
diff -Nru a/arch/sparc/Kconfig b/arch/sparc/Kconfig
--- a/arch/sparc/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/sparc/Kconfig	Sat Jun  5 14:25:51 2004
@@ -440,6 +440,20 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.	
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
--- a/arch/sparc/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/sparc/defconfig	Sat Jun  5 14:25:51 2004
@@ -611,6 +611,7 @@
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_DEBUG_HIGHMEM is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
diff -Nru a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/sparc64/Kconfig	Sat Jun  5 14:25:51 2004
@@ -658,6 +658,20 @@
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.	
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
--- a/arch/sparc64/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/sparc64/defconfig	Sat Jun  5 14:25:51 2004
@@ -1718,6 +1718,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_DCFLUSH is not set
 # CONFIG_DEBUG_INFO is not set
diff -Nru a/arch/um/Kconfig b/arch/um/Kconfig
--- a/arch/um/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/um/Kconfig	Sat Jun  5 14:25:51 2004
@@ -222,6 +222,20 @@
 config DEBUG_SPINLOCK
 	bool "Debug spinlocks usage"
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
--- a/arch/um/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/um/defconfig	Sat Jun  5 14:25:51 2004
@@ -399,6 +399,7 @@
 #
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 CONFIG_DEBUG_INFO=y
 CONFIG_FRAME_POINTER=y
 CONFIG_PT_PROXY=y
diff -Nru a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/x86_64/Kconfig	Sat Jun  5 14:25:51 2004
@@ -437,6 +437,20 @@
 	  best used in conjunction with the NMI watchdog so that spinlock
 	  deadlocks are also debuggable.
 
+config SPINLOCK_TIMEOUT
+       bool "Spinlocks timeout checking"	  
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
--- a/arch/x86_64/defconfig	Sat Jun  5 14:25:51 2004
+++ b/arch/x86_64/defconfig	Sat Jun  5 14:25:51 2004
@@ -814,6 +814,7 @@
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_SPINLOCK_TIMEOUT is not set
 # CONFIG_INIT_DEBUG is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_FRAME_POINTER is not set
diff -Nru a/include/linux/spinlock.h b/include/linux/spinlock.h
--- a/include/linux/spinlock.h	Sat Jun  5 14:25:51 2004
+++ b/include/linux/spinlock.h	Sat Jun  5 14:25:51 2004
@@ -38,6 +38,16 @@
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
 
+#if defined(CONFIG_SPINLOCK_TIMEOUT)
+
+#include <asm/param.h>
+
+#define SPINLOCK_TIMEOUT CONFIG_SPINLOCK_TIMEOUT_TIME
+extern unsigned long volatile jiffies;
+
+#endif /* CONFIG_SPINLOCK_TIMEOUT */
+
+
 #else
 
 #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
@@ -218,11 +228,27 @@
 } while (0)
 
 #else
+#if defined(CONFIG_SPINLOCK_TIMEOUT)
+
+static inline void spin_lock(spinlock_t * lock) {
+	unsigned long jiffy_timeout = jiffies + (SPINLOCK_TIMEOUT * HZ); 
+
+	preempt_disable(); 
+	do { 
+		if (jiffies >= jiffy_timeout) 
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
--- a/kernel/sched.c	Sat Jun  5 14:25:51 2004
+++ b/kernel/sched.c	Sat Jun  5 14:25:51 2004
@@ -3958,6 +3958,10 @@
  */
 void __sched __preempt_spin_lock(spinlock_t *lock)
 {
+#if defined(CONFIG_SPINLOCK_TIMEOUT)
+	unsigned long jiffy_timeout = jiffies + (SPINLOCK_TIMEOUT * HZ);
+#endif
+
 	if (preempt_count() > 1) {
 		_raw_spin_lock(lock);
 		return;
@@ -3967,6 +3971,10 @@
 		while (spin_is_locked(lock))
 			cpu_relax();
 		preempt_disable();
+#if defined(CONFIG_SPINLOCK_TIMEOUT)
+		if (jiffies > = jiffy_timeout)
+			BUG();
+#endif
 	} while (!_raw_spin_trylock(lock));
 }
 

--=-2oyfThvPmuyKlIpoWdoE--

