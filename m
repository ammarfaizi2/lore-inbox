Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUFKVUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUFKVUs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 17:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUFKVUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 17:20:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:11961 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263100AbUFKVUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 17:20:23 -0400
Date: Fri, 11 Jun 2004 16:19:59 -0500 (CDT)
From: moilanen@austin.ibm.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH][RFC] Spinlock-timeout
In-Reply-To: <1086968975.1885.11.camel@gaston>
Message-ID: <Pine.A41.4.44.0406111613060.68840-100000@forte.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Here's a revision to the patch that uses a HAVE_ARCH_GET_TB to allow
> > archs use their timebases if they have one, and if they don't, it uses
> > jiffies.  time_after_eq() is used to do the jiffy checking.
> >
> > I also left all of the arch/*/Kconfig changes in until a debug Kconfig
> > is done.  I pretty much added in the spinlock timeout on all archs that
> > have CONFIG_DEBUG_SPINLOCK.  If I missed your arch, I'm sorry.
>
> Nah, that's not how the abstraction should be done. Much simpler in
> fact. Just do something like this in the generic code:
>
> #ifndef ARCH_HAS_SPINLOCK_TIMEOUT
> #define get_spinlock_timeout() (jiffies + (SPINLOCK_TIMEOUT * HZ))
> #define check_spinlock_timeout(timeout) (time_after_eq(jiffies, timeout))
> #endif
>
> That's all. Then, any arch who has it's own implementation of these 2
> function will #define ARCH_HAS_SPINLOCK_TIMEOUT and implement them the
> way it wants. We shouldn't let anything like get_tb() slip into a common
> file, it's totally PPC specific. Other archs may have different counters
> they can use to impement the same thing. That part should be entirely
> self contained in asm-xxx

That's much better.  Here's hopefully a version that could be merged.

Thanks,
Jake

===== arch/alpha/Kconfig 1.37 vs edited =====
*** /tmp/Kconfig-1.37-23470	Tue May 18 10:22:12 2004
--- arch/alpha/Kconfig	Fri Jun 11 10:56:36 2004
*************** config DEBUG_SPINLOCK
*** 664,669 ****
--- 664,683 ----
  	  best used in conjunction with the NMI watchdog so that spinlock
  	  deadlocks are also debuggable.

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  config DEBUG_RWLOCK
  	bool "Read-write spinlock debugging"
  	depends on DEBUG_KERNEL
===== arch/alpha/defconfig 1.25 vs edited =====
*** /tmp/defconfig-1.25-23470	Tue Mar 23 12:24:34 2004
--- arch/alpha/defconfig	Fri Jun 11 10:56:36 2004
*************** CONFIG_MATHEMU=y
*** 868,873 ****
--- 868,874 ----
  # CONFIG_DEBUG_SLAB is not set
  CONFIG_MAGIC_SYSRQ=y
  # CONFIG_DEBUG_SPINLOCK is not set
+ # CONFIG_SPINLOCK_TIMEOUT is not set
  # CONFIG_DEBUG_RWLOCK is not set
  # CONFIG_DEBUG_SEMAPHORE is not set
  CONFIG_DEBUG_INFO=y
===== arch/arm/Kconfig 1.62 vs edited =====
*** /tmp/Kconfig-1.62-23470	Mon May 24 06:14:29 2004
--- arch/arm/Kconfig	Fri Jun 11 10:56:37 2004
*************** config DEBUG_SPINLOCK
*** 728,733 ****
--- 728,747 ----
  	  best used in conjunction with the NMI watchdog so that spinlock
  	  deadlocks are also debuggable.

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  config DEBUG_WAITQ
  	bool "Wait queue debugging"
  	depends on DEBUG_KERNEL
===== arch/arm/defconfig 1.5 vs edited =====
*** /tmp/defconfig-1.5-23470	Sat Aug  2 14:59:32 2003
--- arch/arm/defconfig	Fri Jun 11 10:56:37 2004
*************** CONFIG_FRAME_POINTER=y
*** 507,511 ****
--- 507,512 ----
  CONFIG_DEBUG_ERRORS=y
  CONFIG_DEBUG_USER=y
  # CONFIG_DEBUG_INFO is not set
+ # CONFIG_SPINLOCK_TIMEOUT is not set
  CONFIG_MAGIC_SYSRQ=y
  CONFIG_DEBUG_LL=y
===== arch/arm26/Kconfig 1.12 vs edited =====
*** /tmp/Kconfig-1.12-23470	Sat Mar 13 05:47:59 2004
--- arch/arm26/Kconfig	Fri Jun 11 10:56:37 2004
*************** config DEBUG_SPINLOCK
*** 284,289 ****
--- 284,303 ----
  	  best used in conjunction with the NMI watchdog so that spinlock
  	  deadlocks are also debuggable.

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  config DEBUG_WAITQ
  	bool "Wait queue debugging"
  	depends on DEBUG_KERNEL
===== arch/arm26/defconfig 1.3 vs edited =====
*** /tmp/defconfig-1.3-23470	Thu Mar 25 11:57:00 2004
--- arch/arm26/defconfig	Fri Jun 11 10:56:37 2004
*************** CONFIG_DEBUG_KERNEL=y
*** 344,349 ****
--- 344,350 ----
  CONFIG_DEBUG_SLAB=y
  CONFIG_MAGIC_SYSRQ=y
  CONFIG_DEBUG_SPINLOCK=y
+ # CONFIG_SPINLOCK_TIMEOUT is not set
  CONFIG_DEBUG_WAITQ=y
  CONFIG_DEBUG_BUGVERBOSE=y
  CONFIG_DEBUG_ERRORS=y
===== arch/i386/Kconfig 1.122 vs edited =====
*** /tmp/Kconfig-1.122-23470	Thu Jun  3 03:46:43 2004
--- arch/i386/Kconfig	Fri Jun 11 10:56:38 2004
*************** config DEBUG_SPINLOCK
*** 1247,1252 ****
--- 1247,1266 ----
  	  best used in conjunction with the NMI watchdog so that spinlock
  	  deadlocks are also debuggable.

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  config DEBUG_PAGEALLOC
  	bool "Page alloc debugging"
  	depends on DEBUG_KERNEL
===== arch/i386/defconfig 1.112 vs edited =====
*** /tmp/defconfig-1.112-23470	Mon Jun  7 08:29:17 2004
--- arch/i386/defconfig	Fri Jun 11 10:56:38 2004
*************** CONFIG_OPROFILE=y
*** 1220,1225 ****
--- 1220,1226 ----
  # CONFIG_DEBUG_KERNEL is not set
  CONFIG_EARLY_PRINTK=y
  CONFIG_DEBUG_SPINLOCK_SLEEP=y
+ # CONFIG_SPINLOCK_TIMEOUT is not set
  # CONFIG_FRAME_POINTER is not set
  CONFIG_4KSTACKS=y
  CONFIG_X86_FIND_SMP_CONFIG=y
===== arch/ia64/Kconfig 1.74 vs edited =====
*** /tmp/Kconfig-1.74-23470	Mon May 24 18:05:32 2004
--- arch/ia64/Kconfig	Fri Jun 11 10:56:39 2004
*************** config DEBUG_SPINLOCK_SLEEP
*** 468,473 ****
--- 468,487 ----
  	    If you say Y here, various routines which may sleep will become very
  	    noisy if they are called with a spinlock held.

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  config IA64_DEBUG_CMPXCHG
  	bool "Turn on compare-and-exchange bug checking (slow!)"
  	depends on DEBUG_KERNEL
===== arch/ia64/defconfig 1.30 vs edited =====
*** /tmp/defconfig-1.30-23470	Fri May 21 16:03:19 2004
--- arch/ia64/defconfig	Fri Jun 11 10:56:39 2004
*************** CONFIG_MAGIC_SYSRQ=y
*** 1089,1094 ****
--- 1089,1095 ----
  # CONFIG_DEBUG_SLAB is not set
  # CONFIG_DEBUG_SPINLOCK is not set
  # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+ # CONFIG_SPINLOCK_TIMEOUT is not set
  # CONFIG_IA64_DEBUG_CMPXCHG is not set
  # CONFIG_IA64_DEBUG_IRQ is not set
  CONFIG_DEBUG_INFO=y
===== arch/mips/Kconfig 1.26 vs edited =====
*** /tmp/Kconfig-1.26-23470	Mon May 10 06:25:30 2004
--- arch/mips/Kconfig	Fri Jun 11 10:56:39 2004
*************** config DEBUG_SPINLOCK_SLEEP
*** 1360,1365 ****
--- 1360,1379 ----
  	  If you say Y here, various routines which may sleep will become very
  	  noisy if they are called with a spinlock held.

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  config RTC_DS1742
  	bool "DS1742 BRAM/RTC support"
  	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927
===== arch/mips/defconfig 1.11 vs edited =====
*** /tmp/defconfig-1.11-23470	Mon May 10 06:25:30 2004
--- arch/mips/defconfig	Fri Jun 11 10:56:39 2004
*************** CONFIG_CPU_HAS_LLDSCD=y
*** 125,130 ****
--- 125,131 ----
  CONFIG_CPU_HAS_SYNC=y
  # CONFIG_PREEMPT is not set
  # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+ # CONFIG_SPINLOCK_TIMEOUT is not set

  #
  # Bus options (PCI, PCMCIA, EISA, ISA, TC)
===== arch/ppc/Kconfig 1.64 vs edited =====
*** /tmp/Kconfig-1.64-23470	Mon May 31 07:28:12 2004
--- arch/ppc/Kconfig	Fri Jun 11 10:56:39 2004
*************** config DEBUG_SPINLOCK_SLEEP
*** 1199,1204 ****
--- 1199,1218 ----
  	  If you say Y here, various routines which may sleep will become very
  	  noisy if they are called with a spinlock held.

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  config KGDB
  	bool "Include kgdb kernel debugger"
  	depends on DEBUG_KERNEL
===== arch/ppc/defconfig 1.28 vs edited =====
*** /tmp/defconfig-1.28-23470	Tue May 18 09:48:09 2004
--- arch/ppc/defconfig	Fri Jun 11 10:56:39 2004
*************** CONFIG_ZLIB_DEFLATE=y
*** 1318,1323 ****
--- 1318,1324 ----
  # Kernel hacking
  #
  # CONFIG_DEBUG_KERNEL is not set
+ # CONFIG_SPINLOCK_TIMEOUT is not set
  CONFIG_BOOTX_TEXT=y

  #
===== arch/ppc64/Kconfig 1.56 vs edited =====
*** /tmp/Kconfig-1.56-23470	Tue May 25 02:31:51 2004
--- arch/ppc64/Kconfig	Fri Jun 11 10:56:39 2004
*************** config MAGIC_SYSRQ
*** 387,392 ****
--- 387,406 ----
  	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
  	  unless you really know what this hack does.

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  config DEBUGGER
  	bool "Enable debugger hooks"
  	depends on DEBUG_KERNEL
===== arch/ppc64/defconfig 1.37 vs edited =====
*** /tmp/defconfig-1.37-23470	Wed Mar 31 16:27:07 2004
--- arch/ppc64/defconfig	Fri Jun 11 10:56:39 2004
*************** CONFIG_DEBUG_STACKOVERFLOW=y
*** 1054,1059 ****
--- 1054,1060 ----
  CONFIG_DEBUG_STACK_USAGE=y
  # CONFIG_DEBUG_SLAB is not set
  CONFIG_MAGIC_SYSRQ=y
+ # CONFIG_SPINLOCK_TIMEOUT is not set
  CONFIG_DEBUGGER=y
  CONFIG_XMON=y
  CONFIG_XMON_DEFAULT=y
===== arch/s390/Kconfig 1.27 vs edited =====
*** /tmp/Kconfig-1.27-23470	Thu Apr 29 04:41:09 2004
--- arch/s390/Kconfig	Fri Jun 11 10:56:39 2004
*************** config DEBUG_SPINLOCK_SLEEP
*** 423,428 ****
--- 423,442 ----
  	  If you say Y here, various routines which may sleep will become very
  	  noisy if they are called with a spinlock held.

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  endmenu

  source "security/Kconfig"
===== arch/s390/defconfig 1.45 vs edited =====
*** /tmp/defconfig-1.45-23470	Thu Jun  3 03:46:41 2004
--- arch/s390/defconfig	Fri Jun 11 10:56:39 2004
*************** CONFIG_MAGIC_SYSRQ=y
*** 474,479 ****
--- 474,480 ----
  # CONFIG_DEBUG_SLAB is not set
  # CONFIG_DEBUG_INFO is not set
  # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+ # CONFIG_SPINLOCK_TIMEOUT is not set

  #
  # Security options
===== arch/sh/Kconfig 1.29 vs edited =====
*** /tmp/Kconfig-1.29-23470	Tue Mar 23 04:05:27 2004
--- arch/sh/Kconfig	Fri Jun 11 10:56:39 2004
*************** config DEBUG_SPINLOCK
*** 675,680 ****
--- 675,694 ----
  	  best used in conjunction with the NMI watchdog so that spinlock
  	  deadlocks are also debuggable.

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  config SH_STANDARD_BIOS
  	bool "Use LinuxSH standard BIOS"
  	help
===== arch/sh/defconfig 1.9 vs edited =====
*** /tmp/defconfig-1.9-23470	Tue Mar 23 12:18:46 2004
--- arch/sh/defconfig	Fri Jun 11 10:56:39 2004
*************** CONFIG_MSDOS_PARTITION=y
*** 351,356 ****
--- 351,357 ----
  #
  # CONFIG_MAGIC_SYSRQ is not set
  # CONFIG_DEBUG_SPINLOCK is not set
+ # CONFIG_SPINLOCK_TIMEOUT is not set
  CONFIG_SH_STANDARD_BIOS=y
  CONFIG_SH_EARLY_PRINTK=y
  # CONFIG_KGDB is not set
===== arch/sparc/Kconfig 1.28 vs edited =====
*** /tmp/Kconfig-1.28-23470	Fri Mar 19 00:04:54 2004
--- arch/sparc/Kconfig	Fri Jun 11 10:56:39 2004
*************** config DEBUG_SPINLOCK_SLEEP
*** 440,445 ****
--- 440,459 ----
  	  If you say Y here, various routines which may sleep will become very
  	  noisy if they are called with a spinlock held.

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  config DEBUG_BUGVERBOSE
  	bool "Verbose BUG() reporting (adds 70K)"
  	depends on DEBUG_KERNEL
===== arch/sparc/defconfig 1.19 vs edited =====
*** /tmp/defconfig-1.19-23470	Wed Mar 31 00:40:57 2004
--- arch/sparc/defconfig	Fri Jun 11 10:56:39 2004
*************** CONFIG_DEBUG_KERNEL=y
*** 611,616 ****
--- 611,617 ----
  # CONFIG_DEBUG_SLAB is not set
  CONFIG_MAGIC_SYSRQ=y
  # CONFIG_DEBUG_SPINLOCK is not set
+ # CONFIG_SPINLOCK_TIMEOUT is not set
  # CONFIG_DEBUG_HIGHMEM is not set
  # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
  # CONFIG_DEBUG_BUGVERBOSE is not set
===== arch/sparc64/Kconfig 1.52 vs edited =====
*** /tmp/Kconfig-1.52-23470	Mon May 24 12:09:14 2004
--- arch/sparc64/Kconfig	Fri Jun 11 10:56:39 2004
*************** config DEBUG_SPINLOCK_SLEEP
*** 658,663 ****
--- 658,677 ----
  	  If you say Y here, various routines which may sleep will become very
  	  noisy if they are called with a spinlock held.

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  config DEBUG_BUGVERBOSE
  	bool "Verbose BUG() reporting (adds 70K)"
  	depends on DEBUG_KERNEL
===== arch/sparc64/defconfig 1.128 vs edited =====
*** /tmp/defconfig-1.128-23470	Thu Jun  3 16:54:05 2004
--- arch/sparc64/defconfig	Fri Jun 11 10:56:39 2004
*************** CONFIG_DEBUG_KERNEL=y
*** 1727,1732 ****
--- 1727,1733 ----
  CONFIG_MAGIC_SYSRQ=y
  # CONFIG_DEBUG_SPINLOCK is not set
  # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+ # CONFIG_SPINLOCK_TIMEOUT is not set
  # CONFIG_DEBUG_BUGVERBOSE is not set
  # CONFIG_DEBUG_DCFLUSH is not set
  # CONFIG_DEBUG_INFO is not set
===== arch/um/Kconfig 1.14 vs edited =====
*** /tmp/Kconfig-1.14-23470	Mon Apr 12 12:53:57 2004
--- arch/um/Kconfig	Fri Jun 11 10:56:39 2004
*************** config DEBUG_SLAB
*** 222,227 ****
--- 222,241 ----
  config DEBUG_SPINLOCK
  	bool "Debug spinlocks usage"

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  config DEBUG_INFO
  	bool "Enable kernel debugging symbols"
  	help
===== arch/um/defconfig 1.8 vs edited =====
*** /tmp/defconfig-1.8-23470	Fri Jun 20 15:19:15 2003
--- arch/um/defconfig	Fri Jun 11 10:56:39 2004
*************** CONFIG_MTD_BLKMTD=m
*** 399,404 ****
--- 399,405 ----
  #
  # CONFIG_DEBUG_SLAB is not set
  # CONFIG_DEBUG_SPINLOCK is not set
+ # CONFIG_SPINLOCK_TIMEOUT is not set
  CONFIG_DEBUG_INFO=y
  CONFIG_FRAME_POINTER=y
  CONFIG_PT_PROXY=y
===== arch/x86_64/Kconfig 1.51 vs edited =====
*** /tmp/Kconfig-1.51-23470	Sat May 15 08:32:23 2004
--- arch/x86_64/Kconfig	Fri Jun 11 10:56:39 2004
*************** config DEBUG_SPINLOCK
*** 436,441 ****
--- 436,455 ----
  	  best used in conjunction with the NMI watchdog so that spinlock
  	  deadlocks are also debuggable.

+ config SPINLOCK_TIMEOUT
+        bool "Spinlocks timeout"
+        depends on DEBUG_KERNEL && SMP
+        help
+          If you say Y here, the spinlocks will timeout after X number
+ 	 of seconds. This is useful for catching deadlocks, and make sure
+ 	 locks are not held too long.
+
+ config SPINLOCK_TIMEOUT_TIME
+ 	int "Spinlock timeout time in seconds (1-43200)"
+ 	range 1 43200
+ 	depends on SPINLOCK_TIMEOUT
+ 	default "10"
+
  # !SMP for now because the context switch early causes GPF in segment reloading
  # and the GS base checking does the wrong thing then, causing a hang.
  config CHECKING
===== arch/x86_64/defconfig 1.39 vs edited =====
*** /tmp/defconfig-1.39-23470	Sat Jun  5 02:25:22 2004
--- arch/x86_64/defconfig	Fri Jun 11 10:56:39 2004
*************** CONFIG_DEBUG_KERNEL=y
*** 910,915 ****
--- 910,916 ----
  # CONFIG_DEBUG_SLAB is not set
  CONFIG_MAGIC_SYSRQ=y
  # CONFIG_DEBUG_SPINLOCK is not set
+ # CONFIG_SPINLOCK_TIMEOUT is not set
  # CONFIG_INIT_DEBUG is not set
  # CONFIG_DEBUG_INFO is not set
  # CONFIG_FRAME_POINTER is not set
===== include/linux/jiffies.h 1.9 vs edited =====
*** /tmp/jiffies.h-1.9-23470	Mon Dec 29 15:38:06 2003
--- include/linux/jiffies.h	Fri Jun 11 10:56:40 2004
***************
*** 3,10 ****

  #include <linux/kernel.h>
  #include <linux/types.h>
- #include <linux/spinlock.h>
- #include <linux/seqlock.h>
  #include <asm/system.h>
  #include <asm/param.h>			/* for HZ */

--- 3,8 ----
===== include/linux/spinlock.h 1.28 vs edited =====
*** /tmp/spinlock.h-1.28-23470	Mon May 10 06:25:44 2004
--- include/linux/spinlock.h	Fri Jun 11 11:02:53 2004
***************
*** 38,43 ****
--- 38,62 ----
  #ifdef CONFIG_SMP
  #include <asm/spinlock.h>

+ #if defined(CONFIG_SPINLOCK_TIMEOUT)
+
+ #include <linux/jiffies.h>
+
+ #define SPINLOCK_TIMEOUT CONFIG_SPINLOCK_TIMEOUT_TIME
+
+ /*
+  * There are paths where jiffies won't be updated and
+  * SPINLOCK_TIMEOUT will not work.  To ensure they work, it is best
+  * to have every arch implement their own SPINLOCK_TIMEOUT routines
+  * that use hardware timers.
+  */
+ #ifndef ARCH_HAS_SPINLOCK_TIMEOUT
+ #define get_spinlock_timeout() (jiffies + (SPINLOCK_TIMEOUT * HZ))
+ #define check_spinlock_timeout(timeout) (time_after_eq(jiffies, timeout))
+ #endif /* !ARCH_HASH_SPINLOCK_TIMEOUT */
+
+ #endif /* CONFIG_SPINLOCK_TIMEOUT */
+
  #else

  #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
*************** do { \
*** 218,228 ****
--- 237,263 ----
  } while (0)

  #else
+ #if defined(CONFIG_SPINLOCK_TIMEOUT)
+
+ static inline void spin_lock(spinlock_t * lock) {
+ 	unsigned long timeout = get_spinlock_timeout();
+
+ 	preempt_disable();
+ 	do {
+ 		if (check_spinlock_timeout(timeout))
+ 		        BUG();
+ 	} while (!_raw_spin_trylock(lock));
+ }
+
+ #else /* CONFIG_SPINLOCK_TIMEOUT */
+
  #define spin_lock(lock)	\
  do { \
  	preempt_disable(); \
  	_raw_spin_lock(lock); \
  } while(0)
+
+ #endif /* CONFIG_SPINLOCK_TIMEOUT */

  #define write_lock(lock) \
  do { \
===== kernel/sched.c 1.309 vs edited =====
*** /tmp/sched.c-1.309-23470	Sat Jun  5 19:00:00 2004
--- kernel/sched.c	Fri Jun 11 10:56:40 2004
*************** EXPORT_SYMBOL(__might_sleep);
*** 3998,4011 ****
   */
  void __sched __preempt_spin_lock(spinlock_t *lock)
  {
  	if (preempt_count() > 1) {
  		_raw_spin_lock(lock);
  		return;
  	}
  	do {
  		preempt_enable();
! 		while (spin_is_locked(lock))
  			cpu_relax();
  		preempt_disable();
  	} while (!_raw_spin_trylock(lock));
  }
--- 3998,4020 ----
   */
  void __sched __preempt_spin_lock(spinlock_t *lock)
  {
+ #if defined(CONFIG_SPINLOCK_TIMEOUT)
+ 	unsigned long timeout = get_spinlock_timeout();
+ #endif
+
  	if (preempt_count() > 1) {
  		_raw_spin_lock(lock);
  		return;
  	}
  	do {
  		preempt_enable();
! 		while (spin_is_locked(lock)) {
! #if defined(CONFIG_SPINLOCK_TIMEOUT)
! 			if (check_spinlock_timeout(timeout))
! 				BUG();
! #endif
  			cpu_relax();
+ 		}
  		preempt_disable();
  	} while (!_raw_spin_trylock(lock));
  }

