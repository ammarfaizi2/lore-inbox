Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbUJYQC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUJYQC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbUJYQC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:02:29 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:17606 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261988AbUJYQAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:00:10 -0400
Message-ID: <417D2305.3020209@acm.org>
Date: Mon, 25 Oct 2004 11:00:05 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Race betwen the NMI handler and the RTC clock in practially all kernels
Content-Type: multipart/mixed;
 boundary="------------080508020708000709010105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080508020708000709010105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I had a customer on x86 notice that sometimes offset 0xf in the CMOS RAM 
was getting set to invalid values.  Their BIOS used this for information 
about how to boot, and this caused the BIOS to lock up.

They traced it down to the following code in arch/kernel/traps.c (now in 
include/asm-i386/mach-default/mach_traps.c):

    outb(0x8f, 0x70);
    inb(0x71);              /* dummy */
    outb(0x0f, 0x70);
    inb(0x71);              /* dummy */

This code is done at the end of NMI handling and is done without locks.  
0x70 is the CMOS RAM index register, 0x71 is the data register.  The RTC 
driver uses the same registers to set the RTC.  Obviously, this is bad.  
I'm not exactly how this code does its function, but it is definately 
conflicting with the RTC driver.

Fixing it is not so easy since you can't claim a lock inside the NMI 
code that is also claimed by non-NMI code.  However, it is fixable, it 
just requires some special handling (and support of 
compare-and-exchange).  I have attached a first shot at fixing it, 
relative to 2.6.9.  This creates a special lock that is owned by a CPU 
that also stores the index register being read/written.  This is 
moderatly ugly, I guess, but everything dealing with NMIs is ugly and I 
couldn't think of a better solution.

-Corey

--------------080508020708000709010105
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
+++ linux-2.6.9-nmifix.diff/include/asm-i386/mc146818rtc.h	2004-10-25 10:40:37.000000000 -0500
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
+	new = ((smp_processor_id() << 8)+1) | reg;
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
 

--------------080508020708000709010105--
