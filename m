Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbUKLFDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbUKLFDm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 00:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbUKLFDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 00:03:42 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:35853 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262442AbUKLFDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 00:03:36 -0500
Date: Thu, 11 Nov 2004 21:03:09 -0800
To: Bill Huey <bhuey@lnxw.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041112050309.GA1207@nietzsche.lynx.com>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041112040845.GA26545@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20041112040845.GA26545@nietzsche.lynx.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 11, 2004 at 08:08:45PM -0800, Bill Huey wrote:
> Patch to get rudimentary kgdb support working.

Resent with some contamination removed from it.

bill


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kgdb.diff"

diff -rwu linux.voluntary.virgin/arch/i386/Kconfig.kgdb linux.voluntary/arch/i386/Kconfig.kgdb
--- linux.voluntary.virgin/arch/i386/Kconfig.kgdb	2004-11-11 17:05:32.000000000 -0800
+++ linux.voluntary/arch/i386/Kconfig.kgdb	2004-11-11 19:44:29.000000000 -0800
@@ -1,6 +1,6 @@
 config KGDB
 	bool "Include kgdb kernel debugger"
-	depends on DEBUG_KERNEL && !KPROBES && !PREEMPT_RT
+	depends on DEBUG_KERNEL && !KPROBES
 	help
 	  If you say Y here, the system will be compiled with the debug
 	  option (-g) and a debugging stub will be included in the
diff -rwu linux.voluntary.virgin/arch/i386/kernel/kgdb_stub.c linux.voluntary/arch/i386/kernel/kgdb_stub.c
--- linux.voluntary.virgin/arch/i386/kernel/kgdb_stub.c	2004-11-11 17:05:32.000000000 -0800
+++ linux.voluntary/arch/i386/kernel/kgdb_stub.c	2004-11-11 17:11:13.000000000 -0800
@@ -365,8 +365,8 @@
 
 #ifdef CONFIG_SMP
 static int in_kgdb_called;
-static spinlock_t waitlocks[MAX_NO_CPUS] =
-    {[0 ... MAX_NO_CPUS - 1] = SPIN_LOCK_UNLOCKED };
+static raw_spinlock_t waitlocks[MAX_NO_CPUS] =
+    {[0 ... MAX_NO_CPUS - 1] = RAW_SPIN_LOCK_UNLOCKED };
 /*
  * The following array has the thread pointer of each of the "other"
  * cpus.  We make it global so it can be seen by gdb.
@@ -374,9 +374,9 @@
 volatile int in_kgdb_entry_log[MAX_NO_CPUS];
 volatile struct pt_regs *in_kgdb_here_log[MAX_NO_CPUS];
 /*
-static spinlock_t continuelocks[MAX_NO_CPUS];
+static raw_spinlock_t continuelocks[MAX_NO_CPUS];
 */
-spinlock_t kgdb_spinlock = SPIN_LOCK_UNLOCKED;
+raw_spinlock_t kgdb_spinlock = RAW_SPIN_LOCK_UNLOCKED;
 /* waiters on our spinlock plus us */
 static atomic_t spinlock_waiters = ATOMIC_INIT(1);
 static int spinlock_count = 0;
@@ -2404,7 +2404,7 @@
 void
 kgdb_tstamp(int line, char *source, int data0, int data1)
 {
-	static spinlock_t ts_spin = SPIN_LOCK_UNLOCKED;
+	static raw_spinlock_t ts_spin = RAW_SPIN_LOCK_UNLOCKED;
 	int flags;
 	kgdb_local_irq_save(flags);
 	spin_lock(&ts_spin);
diff -rwu linux.voluntary.virgin/arch/i386/kernel/timers/timer_hpet.c linux.voluntary/arch/i386/kernel/timers/timer_hpet.c
--- linux.voluntary.virgin/arch/i386/kernel/timers/timer_hpet.c	2004-11-11 17:05:31.000000000 -0800
+++ linux.voluntary/arch/i386/kernel/timers/timer_hpet.c	2004-11-11 17:11:13.000000000 -0800
@@ -49,7 +49,9 @@
 	cyc2ns_scale = (1000 << CYC2NS_SCALE_FACTOR)/cpu_mhz;
 }
 
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+//static inline
+//#error
+unsigned long long cycles_2_ns(unsigned long long cyc)
 {
 	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
 }
diff -rwu linux.voluntary.virgin/arch/i386/lib/kgdb_serial.c linux.voluntary/arch/i386/lib/kgdb_serial.c
--- linux.voluntary.virgin/arch/i386/lib/kgdb_serial.c	2004-11-11 17:05:32.000000000 -0800
+++ linux.voluntary/arch/i386/lib/kgdb_serial.c	2004-11-11 17:11:13.000000000 -0800
@@ -104,9 +104,9 @@
  * but we will just depend on the uart status to help keep that straight.
 
  */
-static spinlock_t uart_interrupt_lock = SPIN_LOCK_UNLOCKED;
+static raw_spinlock_t uart_interrupt_lock = RAW_SPIN_LOCK_UNLOCKED;
 #ifdef CONFIG_SMP
-extern spinlock_t kgdb_spinlock;
+extern raw_spinlock_t kgdb_spinlock;
 #endif
 
 static int
@@ -343,7 +343,7 @@
  */
 int kgdb_in_isr = 0;
 int kgdb_in_lsr = 0;
-extern spinlock_t kgdb_spinlock;
+extern raw_spinlock_t kgdb_spinlock;
 
 /* Caller takes needed protections */
 
@@ -381,7 +381,7 @@
 }				/* tty_getDebugChar */
 
 static int count = 3;
-static spinlock_t one_at_atime = SPIN_LOCK_UNLOCKED;
+static raw_spinlock_t one_at_atime = RAW_SPIN_LOCK_UNLOCKED;
 
 static int __init
 kgdb_enable_ints(void)

--oyUTqETQ0mS9luUI--
