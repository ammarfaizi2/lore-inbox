Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264277AbUFKVXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbUFKVXW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 17:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbUFKVXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 17:23:21 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:5621 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264277AbUFKVXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 17:23:04 -0400
Date: Fri, 11 Jun 2004 16:22:50 -0500 (CDT)
From: moilanen@austin.ibm.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH][RFC] Spinlock-timeout
In-Reply-To: <1086968975.1885.11.camel@gaston>
Message-ID: <Pine.A41.4.44.0406111620061.68840-100000@forte.austin.ibm.com>
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

Here's the ppc64 add-on for using timebase register for the spinlock
timeout.  If no one has any issues w/ the base spin-lock timeout patch, or
this one, please apply.

Thanks,
Jake

===== arch/ppc64/kernel/chrp_setup.c 1.47 vs edited =====
*** /tmp/chrp_setup.c-1.47-18066	Tue Apr 27 00:07:31 2004
--- arch/ppc64/kernel/chrp_setup.c	Fri Jun 11 11:58:11 2004
*************** chrp_progress(char *s, unsigned short he
*** 405,414 ****

  extern void setup_default_decr(void);

- /* Some sane defaults: 125 MHz timebase, 1GHz processor */
- #define DEFAULT_TB_FREQ		125000000UL
- #define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)
-
  void __init pSeries_calibrate_decr(void)
  {
  	struct device_node *cpu;
--- 405,410 ----
===== arch/ppc64/kernel/time.c 1.30 vs edited =====
*** /tmp/time.c-1.30-18066	Mon May 31 12:41:03 2004
--- arch/ppc64/kernel/time.c	Fri Jun 11 14:19:48 2004
*************** static unsigned long first_settimeofday
*** 81,87 ****

  #define XSEC_PER_SEC (1024*1024)

! unsigned long tb_ticks_per_jiffy;
  unsigned long tb_ticks_per_usec;
  unsigned long tb_ticks_per_sec;
  unsigned long next_xtime_sync_tb;
--- 81,87 ----

  #define XSEC_PER_SEC (1024*1024)

! unsigned long tb_ticks_per_jiffy = DEFAULT_TB_FREQ / HZ;
  unsigned long tb_ticks_per_usec;
  unsigned long tb_ticks_per_sec;
  unsigned long next_xtime_sync_tb;
===== include/asm-ppc64/processor.h 1.45 vs edited =====
*** /tmp/processor.h-1.45-18066	Tue Jun  1 04:27:47 2004
--- include/asm-ppc64/processor.h	Fri Jun 11 11:58:44 2004
*************** GLUE(.,name):
*** 440,445 ****
--- 440,448 ----

  #endif /* __ASSEMBLY__ */

+ /* Some sane defaults: 125 MHz timebase, 1GHz processor */
+ #define DEFAULT_TB_FREQ		125000000UL
+ #define DEFAULT_PROC_FREQ	(DEFAULT_TB_FREQ * 8)

  /* Macros for setting and retrieving special purpose registers */

===== include/asm-ppc64/spinlock.h 1.10 vs edited =====
*** /tmp/spinlock.h-1.10-18066	Tue May 25 04:53:02 2004
--- include/asm-ppc64/spinlock.h	Fri Jun 11 14:30:57 2004
*************** static __inline__ void _raw_write_lock(r
*** 278,282 ****
--- 278,293 ----
  }
  #endif /* CONFIG_SPINLINE */

+ #ifdef CONFIG_SPINLOCK_TIMEOUT
+
+ #define ARCH_HAS_SPINLOCK_TIMEOUT
+
+ extern unsigned long tb_ticks_per_jiffy;
+
+ #define get_spinlock_timeout() (mftb() + (tb_ticks_per_jiffy * SPINLOCK_TIMEOUT * HZ))
+ #define check_spinlock_timeout(timeout) (mftb() >= timeout ? 1 : 0)
+
+ #endif /* CONFIG_SPINLOCK_TIMEOUT */
+
  #endif /* __KERNEL__ */
  #endif /* __ASM_SPINLOCK_H */

