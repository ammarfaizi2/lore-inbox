Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263944AbUFKOF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbUFKOF6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 10:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUFKOF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 10:05:58 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:19394 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263944AbUFKOFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 10:05:09 -0400
Subject: Re: [PATCH][RFC] Spinlock-timeout
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <1086560618.10538.32.camel@gaston>
References: <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>
	 <1086560618.10538.32.camel@gaston>
Content-Type: multipart/mixed; boundary="=-+vjtRRbXK3IEiVmOxvLk"
Message-Id: <1086962704.3476.53.camel@dyn95394175.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 11 Jun 2004 09:05:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+vjtRRbXK3IEiVmOxvLk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-06-06 at 17:23, Benjamin Herrenschmidt wrote:
> On Sat, 2004-06-05 at 15:31, Jake Moilanen wrote:
> > Here's a patch that will BUG() when a spinlock is held for longer then X
> > seconds.  It is useful for catching deadlocks since not all archs have a
> > NMI watchdog.  
> > 
> > It is also helpful to find locks that are held too long.
> > 
> > Please send comments.
> 
> It would be better to use the timebase on CPUs that have one, no ? Or
> you'll miss cases where either irqs are disabled or you are on a code
> path issued by the timer interrupt, and thus jiffies isn't updated

Here's a revision to the patch that uses a HAVE_ARCH_GET_TB to allow
archs use their timebases if they have one, and if they don't, it uses
jiffies.  time_after_eq() is used to do the jiffy checking.

I also left all of the arch/*/Kconfig changes in until a debug Kconfig
is done.  I pretty much added in the spinlock timeout on all archs that
have CONFIG_DEBUG_SPINLOCK.  If I missed your arch, I'm sorry.    

Thanks,
Jake



--=-+vjtRRbXK3IEiVmOxvLk
Content-Disposition: attachment; filename=spinlock-timeout-2.6-v2.patch
Content-Type: text/x-patch; name=spinlock-timeout-2.6-v2.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== arch/alpha/Kconfig 1.37 vs edited =====
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.37_BUiPrR	2004-05-18 15:22:12 +00:00
--- arch/alpha/Kconfig	2004-06-09 16:38:19 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.25_bRXYlh	2004-03-23 18:24:34 +00:00
--- arch/alpha/defconfig	2004-06-09 16:38:20 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.62_2gdtiH	2004-05-24 11:14:29 +00:00
--- arch/arm/Kconfig	2004-06-09 16:38:20 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.5_HTP3h7	2003-08-02 19:59:32 +00:00
--- arch/arm/defconfig	2004-06-09 16:38:20 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.12_fHaOkx	2004-03-13 11:47:59 +00:00
--- arch/arm26/Kconfig	2004-06-09 16:38:20 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.3_BiEksX	2004-03-25 17:57:00 +00:00
--- arch/arm26/defconfig	2004-06-09 16:38:21 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.122_GpRUBn	2004-06-03 08:46:43 +00:00
--- arch/i386/Kconfig	2004-06-09 16:38:21 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.112_lLqTPN	2004-06-07 13:29:17 +00:00
--- arch/i386/defconfig	2004-06-09 16:38:21 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.74_cbpL7d	2004-05-24 23:05:32 +00:00
--- arch/ia64/Kconfig	2004-06-09 16:38:21 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.30_JLmbuE	2004-05-21 21:03:19 +00:00
--- arch/ia64/defconfig	2004-06-09 16:38:22 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.26_TFCFU4	2004-05-10 11:25:30 +00:00
--- arch/mips/Kconfig	2004-06-09 16:38:22 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.11_dfmkrv	2004-05-10 11:25:30 +00:00
--- arch/mips/defconfig	2004-06-09 16:38:22 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.64_vJsX1V	2004-05-31 12:28:12 +00:00
--- arch/ppc/Kconfig	2004-06-09 16:38:22 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.28_40DsJm	2004-05-18 14:48:09 +00:00
--- arch/ppc/defconfig	2004-06-09 16:38:23 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.56_5CbvuN	2004-05-25 07:31:51 +00:00
--- arch/ppc64/Kconfig	2004-06-09 16:38:23 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.37_O87Bje	2004-03-31 22:27:07 +00:00
--- arch/ppc64/defconfig	2004-06-09 16:38:23 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.27_xMQxUo	2004-04-29 09:41:09 +00:00
--- arch/s390/Kconfig	2004-06-09 16:38:25 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.45_TiY8TP	2004-06-03 08:46:41 +00:00
--- arch/s390/defconfig	2004-06-09 16:38:25 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.29_YVtFVg	2004-03-23 10:05:27 +00:00
--- arch/sh/Kconfig	2004-06-09 16:38:25 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.9_Rt2WZH	2004-03-23 18:18:46 +00:00
--- arch/sh/defconfig	2004-06-09 16:38:25 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.28_iel758	2004-03-19 06:04:54 +00:00
--- arch/sparc/Kconfig	2004-06-09 16:38:26 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.19_L7AnfA	2004-03-31 06:40:57 +00:00
--- arch/sparc/defconfig	2004-06-09 16:38:26 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.52_VPYCq1	2004-05-24 17:09:14 +00:00
--- arch/sparc64/Kconfig	2004-06-09 16:38:26 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.128_DpO8Es	2004-06-03 21:54:05 +00:00
--- arch/sparc64/defconfig	2004-06-09 16:38:26 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.14_MUJWWT	2004-04-12 17:53:57 +00:00
--- arch/um/Kconfig	2004-06-09 16:38:27 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.8_hSaMgl	2003-06-20 20:19:15 +00:00
--- arch/um/defconfig	2004-06-09 16:38:27 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_Kconfig-1.51_34XYCM	2004-05-15 13:32:23 +00:00
--- arch/x86_64/Kconfig	2004-06-09 16:38:27 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_defconfig-1.39_kfNq3d	2004-06-05 07:25:22 +00:00
--- arch/x86_64/defconfig	2004-06-09 16:38:27 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_jiffies.h-1.9_ezvDfY	2003-12-29 21:38:06 +00:00
--- include/linux/jiffies.h	2004-06-09 16:38:29 +00:00
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_spinlock.h-1.28_TZkdjr	2004-05-10 11:25:44 +00:00
--- include/linux/spinlock.h	2004-06-10 14:17:37 +00:00
***************
*** 38,43 ****
--- 38,69 ----
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
+  * to have every arch implement a get_tb() that can pull from the
+  * hardware for the time update.
+  */
+ #ifdef HAVE_ARCH_GET_TB
+ #include <asm/time.h>
+ #define get_spinlock_timeout() (get_tb() + (tb_ticks_per_jiffy * SPINLOCK_TIMEOUT * HZ))
+ #define check_spinlock_timeout(timeout) (get_tb() >= timeout ? 1 : 0)
+ 
+ #else /* HAVE_ARCH_GET_TB */
+ 
+ #define get_spinlock_timeout() (jiffies + (SPINLOCK_TIMEOUT * HZ))
+ #define check_spinlock_timeout(timeout) (time_after_eq(jiffies, timeout))
+ #endif /* HAVE_ARCH_GET_TB */
+ 
+ #endif /* CONFIG_SPINLOCK_TIMEOUT */
+ 
+ 
  #else
  
  #define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
*************** do { \
*** 218,228 ****
--- 244,270 ----
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
*** /home/moilanen/sbx/linux-2.6/BitKeeper/tmp/bk_sched.c-1.309_8DCjsU	2004-06-06 00:00:00 +00:00
--- kernel/sched.c	2004-06-10 15:13:16 +00:00
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

--=-+vjtRRbXK3IEiVmOxvLk--

