Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbSKDDRJ>; Sun, 3 Nov 2002 22:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbSKDDRJ>; Sun, 3 Nov 2002 22:17:09 -0500
Received: from holomorphy.com ([66.224.33.161]:914 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264672AbSKDDRH>;
	Sun, 3 Nov 2002 22:17:07 -0500
Date: Sun, 3 Nov 2002 19:22:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: interrupt checks for spinlocks
Message-ID: <20021104032215.GW23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org
References: <mailman.1036362421.16883.linux-kernel2news@redhat.com> <200211040028.gA40S8600593@devserv.devel.redhat.com> <20021104002813.GZ16347@holomorphy.com> <20021103194249.A1603@devserv.devel.redhat.com> <20021104005339.GA16347@holomorphy.com> <1036372685.752.7.camel@phantasy> <20021104014224.GR23425@holomorphy.com> <1036378887.750.96.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036378887.750.96.camel@phantasy>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 10:01:24PM -0500, Robert Love wrote:
> You can do #1, but you need to figure out if your interrupt is the only
> interrupt using the lock or not (possibly hard).
> In other words, a lock unique to your interrupt handler does not need to
> disable interrupts (since only that handler can grab the lock and it is
> disabled).
> If other handlers can grab the lock, interrupts need to be disabled.
> So a test of irqs_disabled() would show a false-positive in the first
> case.  No easy way to tell..
> 	Robert Love

Attempt #1:



===== include/linux/spinlock.h 1.18 vs edited =====
--- 1.18/include/linux/spinlock.h	Sun Aug 25 10:25:45 2002
+++ edited/include/linux/spinlock.h	Sun Nov  3 19:21:44 2002
@@ -38,6 +38,44 @@
 #include <asm/spinlock.h>
 
 /*
+ * if a lock is ever taken in interrupt context, it must always be
+ * taken with interrupts disabled. If a locking call is made that
+ * unconditionally disables and then re-enables interrupts, it must
+ * be made with interrupts enabled.
+ */
+#ifndef irq_tainted_lock
+#define irq_tainted_lock(lock)	0 
+#endif
+
+#ifndef irq_taint_lock
+#define irq_taint_lock(lock)	do { } while (0)
+#define
+
+#ifndef CONFIG_DEBUG_SPINLOCK
+#define check_spinlock_irq(lock)		do { } while (0)
+#define check_spinlock_irqs_disabled(lock)	do { } while (0)
+#else
+#define check_spinlock_irq(lock)					\
+	do {								\
+		if (irqs_disabled()) {					\
+			printk("spinlock taken unconditionally "	\
+				"re-enabling interrupts\n");		\
+			dump_stack();					\
+		}							\
+	} while (0)
+#define check_spinlock_irqs_disabled(lock)				\
+	do {								\
+		if (in_interrupt())				\
+			irq_taint_lock(lock);				\
+		else if (irq_tainted_lock(lock)) {			\
+			printk("spinlock taken in process context "	\
+				"without disabling interrupts\n");	\
+			dump_stack();					\
+		}							\
+	} while (0)
+#endif
+
+/*
  * !CONFIG_SMP and spin_lock_init not previously defined
  * (e.g. by including include/asm/spinlock.h)
  */
@@ -87,6 +125,7 @@
  */
 #define spin_lock(lock)	\
 do { \
+	check_spinlock_irqs_disabled(lock); \
 	preempt_disable(); \
 	_raw_spin_lock(lock); \
 } while(0)
@@ -102,6 +141,7 @@
 
 #define read_lock(lock)	\
 do { \
+	check_spinlock_irqs_disabled(lock); \
 	preempt_disable(); \
 	_raw_read_lock(lock); \
 } while(0)
@@ -114,6 +154,7 @@
 
 #define write_lock(lock) \
 do { \
+	check_spinlock_irqs_disabled(lock); \
 	preempt_disable(); \
 	_raw_write_lock(lock); \
 } while(0)
@@ -136,6 +177,7 @@
 
 #define spin_lock_irq(lock) \
 do { \
+	check_spinlock_irq(lock); \
 	local_irq_disable(); \
 	preempt_disable(); \
 	_raw_spin_lock(lock); \
@@ -157,6 +199,7 @@
 
 #define read_lock_irq(lock) \
 do { \
+	check_spinlock_irq(lock); \
 	local_irq_disable(); \
 	preempt_disable(); \
 	_raw_read_lock(lock); \
@@ -178,6 +221,7 @@
 
 #define write_lock_irq(lock) \
 do { \
+	check_spinlock_irq(lock); \
 	local_irq_disable(); \
 	preempt_disable(); \
 	_raw_write_lock(lock); \
