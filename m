Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbSKCWDl>; Sun, 3 Nov 2002 17:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263785AbSKCWDl>; Sun, 3 Nov 2002 17:03:41 -0500
Received: from holomorphy.com ([66.224.33.161]:61072 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263760AbSKCWDb>;
	Sun, 3 Nov 2002 17:03:31 -0500
Date: Sun, 3 Nov 2002 14:08:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: hch@lst.de, bcrl@redhat.com
Subject: interrupt checks for spinlocks
Message-ID: <20021103220816.GY16347@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, hch@lst.de, bcrl@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently thought about interrupt disablement and locking again, or
at least such as has gone about in various places, and I got scared.

Hence, a wee addition to CONFIG_DEBUG_SPINLOCK:

(1) check that spinlocks are not taken in interrupt context without
	interrupts disabled
(2) taint spinlocks taken in interrupt context
(3) check for tainted spinlocks taken without interrupts disabled
(4) check for spinlocking calls unconditionally disabling (and
	hence later re-enabling) interrupts with interrupts disabled

The only action taken is printk() and dump_stack(). No arch code has
been futzed with to provide irq tainting yet. Looks like a good way
to shake out lurking bugs to me (somewhat like may_sleep() etc.).

vs. 2.5.x-bk as of 2PM PST 3 Nov

Bill



diff -urN linux-virgin/include/linux/spinlock.h linux-wli/include/linux/spinlock.h
--- linux-virgin/include/linux/spinlock.h	Sun Aug 25 10:25:45 2002
+++ linux-wli/include/linux/spinlock.h	Sun Nov  3 13:58:47 2002
@@ -38,6 +38,48 @@
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
+		if (in_interrupt() && !irqs_disabled()) {		\
+			printk("spinlock taken in interrupt context "	\
+				"without disabling interrupts\n");	\
+			dump_stack();					\
+		} else if (in_interrupt())				\
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
@@ -87,6 +129,7 @@
  */
 #define spin_lock(lock)	\
 do { \
+	check_spinlock_irqs_disabled(lock); \
 	preempt_disable(); \
 	_raw_spin_lock(lock); \
 } while(0)
@@ -102,6 +145,7 @@
 
 #define read_lock(lock)	\
 do { \
+	check_spinlock_irqs_disabled(lock); \
 	preempt_disable(); \
 	_raw_read_lock(lock); \
 } while(0)
@@ -114,6 +158,7 @@
 
 #define write_lock(lock) \
 do { \
+	check_spinlock_irqs_disabled(lock); \
 	preempt_disable(); \
 	_raw_write_lock(lock); \
 } while(0)
@@ -136,6 +181,7 @@
 
 #define spin_lock_irq(lock) \
 do { \
+	check_spinlock_irq(lock); \
 	local_irq_disable(); \
 	preempt_disable(); \
 	_raw_spin_lock(lock); \
@@ -157,6 +203,7 @@
 
 #define read_lock_irq(lock) \
 do { \
+	check_spinlock_irq(lock); \
 	local_irq_disable(); \
 	preempt_disable(); \
 	_raw_read_lock(lock); \
@@ -178,6 +225,7 @@
 
 #define write_lock_irq(lock) \
 do { \
+	check_spinlock_irq(lock); \
 	local_irq_disable(); \
 	preempt_disable(); \
 	_raw_write_lock(lock); \
