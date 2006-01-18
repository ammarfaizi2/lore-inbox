Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWARJS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWARJS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 04:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWARJS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 04:18:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:25802 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030294AbWARJS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 04:18:58 -0500
Date: Wed, 18 Jan 2006 10:18:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: ntl@pobox.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org,
       michael@ellerman.id.au, linuxppc64-dev@ozlabs.org, serue@us.ibm.com,
       paulus@au1.ibm.com, torvalds@osdl.org
Subject: [patch] turn on might_sleep() in early bootup code too
Message-ID: <20060118091834.GA21366@elte.hu>
References: <200601180032.46867.michael@ellerman.id.au> <20060117140050.GA13188@elte.hu> <200601181119.39872.michael@ellerman.id.au> <20060118033239.GA621@cs.umn.edu> <20060118063732.GA21003@elte.hu> <20060117225304.4b6dd045.akpm@osdl.org> <20060118072815.GR2846@localhost.localdomain> <20060117233734.506c2f2e.akpm@osdl.org> <20060118080828.GA2324@elte.hu> <20060118002459.3bc8f75a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118002459.3bc8f75a.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could we try the patch below in -mm, to get a feeling of how widespread 
the early bootup lock-atomicity assumptions are? I also added a .config 
option to add back the workaround, and turned it on for ppc64. (users 
can still select this manually on any other arch as well)

i found one such bug on x86: early-printk calls register_console(), 
which acquires console_sem. Since we can work such things around 
per-lock and per-assumption [see the printk.c changes], i think we 
should rather do the workarounds that way, and thus document the hacks 
we need - without impacting the ability of such platforms to boot - 
while still keeping might_sleep() checks widely enabled. (btw., x86 
still booted fine, despite the warning.)

	Ingo

--

enable might_sleep() checks even in early bootup code (when system_state 
!= SYSTEM_RUNNING). There's also a new config option to turn this off:
CONFIG_DEBUG_SPINLOCK_SLEEP_EARLY_BOOTUP_WORKAROUND
while most other architectures.

the patch also documents and works around an EARLY_PRINTK locking 
dependency. [which we might want to get rid of in the future.]

tested on x86.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 arch/powerpc/Kconfig.debug |    2 ++
 kernel/printk.c            |   11 ++++++++++-
 kernel/sched.c             |    7 +++++--
 lib/Kconfig.debug          |   11 +++++++++++
 4 files changed, 28 insertions(+), 3 deletions(-)

Index: linux/arch/powerpc/Kconfig.debug
===================================================================
--- linux.orig/arch/powerpc/Kconfig.debug
+++ linux/arch/powerpc/Kconfig.debug
@@ -2,6 +2,8 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
+select CONFIG_DEBUG_SPINLOCK_SLEEP_EARLY_BOOTUP_WORKAROUND
+
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL && PPC64
Index: linux/kernel/printk.c
===================================================================
--- linux.orig/kernel/printk.c
+++ linux/kernel/printk.c
@@ -710,7 +710,16 @@ void acquire_console_sem(void)
 {
 	if (in_interrupt())
 		BUG();
-	down(&console_sem);
+	/*
+	 * Early-printk wants to acquire the console_sem in
+	 * register_console(). Make a special exception for them by
+	 * going via trylock first, which doesnt trigger the
+	 * might_sleep() atomicity check.
+	 */
+#ifdef CONFIG_EARLY_PRINTK
+	if (down_trylock(&console_sem))
+#endif
+		down(&console_sem);
 	console_locked = 1;
 	console_may_schedule = 1;
 }
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -6285,8 +6285,11 @@ void __might_sleep(char *file, int line)
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
-	if ((in_atomic() || irqs_disabled()) &&
-	    system_state == SYSTEM_RUNNING && !oops_in_progress) {
+#ifdef CONFIG_DEBUG_SPINLOCK_SLEEP_EARLY_BOOTUP_WORKAROUND
+	if (system_state != SYSTEM_RUNNING)
+		return;
+#endif
+	if ((in_atomic() || irqs_disabled()) && !oops_in_progress) {
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
 			return;
 		prev_jiffy = jiffies;
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -128,6 +128,17 @@ config DEBUG_SPINLOCK_SLEEP
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
 
+config DEBUG_SPINLOCK_SLEEP_EARLY_BOOTUP_WORKAROUND
+	bool "Work around sleep-inside-spinlock checking in early bootup code"
+	depends on DEBUG_SPINLOCK_SLEEP
+	help
+	  If you say Y here, then early bootup code will not check for
+	  "do not call potentially sleeping functions in atomic sections"
+	  rule, that the DEBUG_SPINLOCK_SLEEP option enforces.
+
+	  You want to say N here, unless your system does not boot with
+	  "Y" here.
+
 config DEBUG_KOBJECT
 	bool "kobject debugging"
 	depends on DEBUG_KERNEL
