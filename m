Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVAUXRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVAUXRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVAUXRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:17:07 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:32449 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262583AbVAUXDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:03:50 -0500
Message-ID: <41F18A52.9040703@acm.org>
Date: Fri, 21 Jan 2005 17:03:46 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Patch to fix race between the NMI code and the CMOS clock
Content-Type: multipart/mixed;
 boundary="------------040903020902050207090505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040903020902050207090505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------040903020902050207090505
Content-Type: text/plain;
 name="nmicmos_race.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmicmos_race.diff"

This patch fixes a race between the CMOS clock setting and the NMI
code.  The NMI code indiscriminatly sets index registers and values
in the same place the CMOS clock is set.  If you are setting the
CMOS clock and an NMI occurs, Bad values could be written to or
read from the CMOS RAM, or the NMI operation might not occur
correctly.

Fixing this requires creating a special lock so the NMI code can
know its CPU owns the lock an "do the right thing" in that case.

This was discovered and the fix has been tested by a very demanding
customer who tests the heck of out the software we deliver.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc1/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.11-rc1.orig/arch/i386/kernel/time.c	2005-01-19 09:53:59.000000000 -0600
+++ linux-2.6.11-rc1/arch/i386/kernel/time.c	2005-01-21 09:42:09.000000000 -0600
@@ -83,6 +83,14 @@
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
+/*
+ * This is a special lock that is owned by the CPU and holds the index
+ * register we are working with.  It is required for NMI access to the
+ * CMOS/RTC registers.  See include/asm-i386/mc146818rtc.h for details.
+ */
+volatile unsigned long cmos_lock = 0;
+EXPORT_SYMBOL(cmos_lock);
+
 spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
 EXPORT_SYMBOL(i8253_lock);
 
Index: linux-2.6.11-rc1/include/asm-i386/mach-default/mach_traps.h
===================================================================
--- linux-2.6.11-rc1.orig/include/asm-i386/mach-default/mach_traps.h	2004-12-24 15:34:58.000000000 -0600
+++ linux-2.6.11-rc1/include/asm-i386/mach-default/mach_traps.h	2005-01-21 09:42:09.000000000 -0600
@@ -7,6 +7,8 @@
 #ifndef _MACH_TRAPS_H
 #define _MACH_TRAPS_H
 
+#include <asm/mc146818rtc.h>
+
 static inline void clear_mem_error(unsigned char reason)
 {
 	reason = (reason & 0xf) | 4;
@@ -20,10 +22,20 @@
 
 static inline void reassert_nmi(void)
 {
+	int old_reg = -1;
+
+	if (do_i_have_lock_cmos())
+		old_reg = current_lock_cmos_reg();
+	else
+		lock_cmos(0); /* register doesn't matter here */
 	outb(0x8f, 0x70);
 	inb(0x71);		/* dummy */
 	outb(0x0f, 0x70);
 	inb(0x71);		/* dummy */
+	if (old_reg >= 0)
+		outb(old_reg, 0x70);
+	else
+		unlock_cmos();
 }
 
 #endif /* !_MACH_TRAPS_H */
Index: linux-2.6.11-rc1/include/asm-i386/mc146818rtc.h
===================================================================
--- linux-2.6.11-rc1.orig/include/asm-i386/mc146818rtc.h	2004-12-24 15:35:23.000000000 -0600
+++ linux-2.6.11-rc1/include/asm-i386/mc146818rtc.h	2005-01-21 09:42:10.000000000 -0600
@@ -5,24 +5,102 @@
 #define _ASM_MC146818RTC_H
 
 #include <asm/io.h>
+#include <asm/system.h>
+#include <linux/mc146818rtc.h>
 
 #ifndef RTC_PORT
 #define RTC_PORT(x)	(0x70 + (x))
 #define RTC_ALWAYS_BCD	1	/* RTC operates in binary mode */
 #endif
 
+#ifdef __HAVE_ARCH_CMPXCHG
+/*
+ * This lock provides nmi access to the CMOS/RTC registers.  It has some
+ * special properties.  It is owned by a CPU and stores the index register
+ * currently being accessed (if owned).  The idea here is that it works
+ * like a normal lock (normally).  However, in an NMI, the NMI code will
+ * first check to see if it's CPU owns the lock, meaning that the NMI
+ * interrupted during the read/write of the device.  If it does, it goes ahead
+ * and performs the access and then restores the index register.  If it does
+ * not, it locks normally.
+ *
+ * Note that since we are working with NMIs, we need this lock even in
+ * a non-SMP machine just to mark that the lock is owned.
+ *
+ * This only works with compare-and-swap.  There is no other way to
+ * atomically claim the lock and set the owner.
+ */
+extern volatile unsigned long cmos_lock;
+
+/*
+ * All of these below must be called with interrupts off, preempt
+ * disabled, etc.
+ */
+
+static inline void lock_cmos(unsigned char reg)
+{
+	unsigned long new;
+	new = ((smp_processor_id()+1) << 8) | reg;
+	for (;;) {
+		if (cmos_lock)
+			continue;
+		if (__cmpxchg(&cmos_lock, 0, new, sizeof(cmos_lock)) == 0)
+			return;
+	}
+}
+
+static inline void unlock_cmos(void)
+{
+	cmos_lock = 0;
+}
+static inline int do_i_have_lock_cmos(void)
+{
+	return (cmos_lock >> 8) == (smp_processor_id()+1);
+}
+static inline unsigned char current_lock_cmos_reg(void)
+{
+	return cmos_lock & 0xff;
+}
+#define lock_cmos_prefix(reg) \
+	do {					\
+		unsigned long cmos_flags;	\
+		local_irq_save(cmos_flags);	\
+		lock_cmos(reg)
+#define lock_cmos_suffix(reg) \
+		unlock_cmos();			\
+		local_irq_restore(cmos_flags);	\
+	} while (0)
+#else
+#define lock_cmos_prefix(reg) do {} while (0)
+#define lock_cmos_suffix(reg) do {} while (0)
+#define lock_cmos(reg)
+#define unlock_cmos()
+#define do_i_have_lock_cmos() 0
+#define current_lock_cmos_reg() 0
+#endif
+
 /*
  * The yet supported machines all access the RTC index register via
  * an ISA port access but the way to access the date register differs ...
+ * Note that these are functions, not defines, to keep the locking
+ * semantics correct even if you do CMOS_WRITE(CMOS_READ(x) | v, x).
  */
-#define CMOS_READ(addr) ({ \
-outb_p((addr),RTC_PORT(0)); \
-inb_p(RTC_PORT(1)); \
-})
-#define CMOS_WRITE(val, addr) ({ \
-outb_p((addr),RTC_PORT(0)); \
-outb_p((val),RTC_PORT(1)); \
-})
+static inline unsigned char CMOS_READ(unsigned char addr)
+{
+	unsigned char val;
+	lock_cmos_prefix(addr);
+	outb_p(addr, RTC_PORT(0));
+	val = inb_p(RTC_PORT(1));
+	lock_cmos_suffix(addr);
+	return val;
+}
+static inline void CMOS_WRITE(unsigned char val, unsigned char addr)
+{
+	lock_cmos_prefix(addr);
+	outb_p(addr, RTC_PORT(0));
+	outb_p(val, RTC_PORT(1));
+	lock_cmos_suffix(addr);
+}
 
 #define RTC_IRQ 8
 

--------------040903020902050207090505--
