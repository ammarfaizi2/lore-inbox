Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbUJZN45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbUJZN45 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 09:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbUJZN45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 09:56:57 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:24741 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262263AbUJZN4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 09:56:47 -0400
Message-ID: <417E579E.3090207@acm.org>
Date: Tue, 26 Oct 2004 08:56:46 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all
 kernels
References: <417D2305.3020209@acm.org>
In-Reply-To: <417D2305.3020209@acm.org>
Content-Type: multipart/mixed;
 boundary="------------040107090107020205000300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040107090107020205000300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

There was a misplaced "+1" in my previous version of this patch (in 
lock_cmos()).

Here is a corrected version...

--------------040107090107020205000300
Content-Type: text/plain;
 name="nmicmos.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmicmos.diff"

Index: linux-2.6.9-nmifix.diff/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.9-nmifix.diff.orig/arch/i386/kernel/time.c	2004-10-25 08:08:26.000000000 -0500
+++ linux-2.6.9-nmifix.diff/arch/i386/kernel/time.c	2004-10-25 10:18:17.000000000 -0500
@@ -82,6 +82,14 @@
 
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
 
Index: linux-2.6.9-nmifix.diff/include/asm-i386/mach-default/mach_traps.h
===================================================================
--- linux-2.6.9-nmifix.diff.orig/include/asm-i386/mach-default/mach_traps.h	2004-06-16 00:19:35.000000000 -0500
+++ linux-2.6.9-nmifix.diff/include/asm-i386/mach-default/mach_traps.h	2004-10-25 09:59:44.000000000 -0500
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
Index: linux-2.6.9-nmifix.diff/include/asm-i386/mc146818rtc.h
===================================================================
--- linux-2.6.9-nmifix.diff.orig/include/asm-i386/mc146818rtc.h	2004-06-16 00:19:43.000000000 -0500
+++ linux-2.6.9-nmifix.diff/include/asm-i386/mc146818rtc.h	2004-10-25 13:14:28.000000000 -0500
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
+ * special properties.  It is owned by a CPU and stored the index register
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
 

--------------040107090107020205000300--
