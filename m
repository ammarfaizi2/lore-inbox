Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVCGSsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVCGSsm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 13:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVCGSsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 13:48:42 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:57832 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261219AbVCGSsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 13:48:31 -0500
Message-ID: <422CA1FA.1010903@acm.org>
Date: Mon, 07 Mar 2005 12:48:26 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] NMI/CMOS RTC race fix for x86-64
Content-Type: multipart/mixed;
 boundary="------------030004010308070000080305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030004010308070000080305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------030004010308070000080305
Content-Type: text/plain;
 name="nmicmos_x86_64_race.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmicmos_x86_64_race.diff"

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

This is basically the same as the x86 patch at
http://marc.theaimsgroup.com/?l=linux-kernel&m=110634968908435&w=2
but for x86_64.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-rc5-mm1/include/asm-x86_64/mc146818rtc.h
===================================================================
--- linux-2.6.11-rc5-mm1.orig/include/asm-x86_64/mc146818rtc.h
+++ linux-2.6.11-rc5-mm1/include/asm-x86_64/mc146818rtc.h
@@ -5,6 +5,8 @@
 #define _ASM_MC146818RTC_H
 
 #include <asm/io.h>
+#include <asm/system.h>
+#include <linux/mc146818rtc.h>
 
 #ifndef RTC_PORT
 #define RTC_PORT(x)	(0x70 + (x))
@@ -12,17 +14,71 @@
 #endif
 
 /*
+ * This lock provides nmi access to the CMOS/RTC registers.  It has some
+ * special properties.  It is owned by a CPU and stores the index register
+ * currently being accessed (if owned).  The idea here is that it works
+ * like a normal lock (normally).  However, in an NMI, the NMI code will
+ * first check to see if its CPU owns the lock, meaning that the NMI
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
+#include <linux/smp.h>
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
+
+/*
  * The yet supported machines all access the RTC index register via
  * an ISA port access but the way to access the date register differs ...
  */
-#define CMOS_READ(addr) ({ \
-outb_p((addr),RTC_PORT(0)); \
-inb_p(RTC_PORT(1)); \
-})
-#define CMOS_WRITE(val, addr) ({ \
-outb_p((addr),RTC_PORT(0)); \
-outb_p((val),RTC_PORT(1)); \
-})
+#define CMOS_READ(addr) rtc_cmos_read(addr)
+#define CMOS_WRITE(val, addr) rtc_cmos_write(val, addr)
+unsigned char rtc_cmos_read(unsigned char addr);
+void rtc_cmos_write(unsigned char val, unsigned char addr);
 
 #define RTC_IRQ 8
 
Index: linux-2.6.11-rc5-mm1/arch/x86_64/kernel/time.c
===================================================================
--- linux-2.6.11-rc5-mm1.orig/arch/x86_64/kernel/time.c
+++ linux-2.6.11-rc5-mm1/arch/x86_64/kernel/time.c
@@ -50,6 +50,35 @@
 extern int using_apic_timer;
 
 DEFINE_SPINLOCK(rtc_lock);
+
+/*
+ * This is a special lock that is owned by the CPU and holds the index
+ * register we are working with.  It is required for NMI access to the
+ * CMOS/RTC registers.  See include/asm-i386/mc146818rtc.h for details.
+ */
+volatile unsigned long cmos_lock = 0;
+EXPORT_SYMBOL(cmos_lock);
+
+/* Routines for accessing the CMOS RAM/RTC. */
+unsigned char rtc_cmos_read(unsigned char addr)
+{
+	unsigned char val;
+	lock_cmos_prefix(addr);
+	outb_p(addr, RTC_PORT(0));
+	val = inb_p(RTC_PORT(1));
+	lock_cmos_suffix(addr);
+	return val;
+}
+EXPORT_SYMBOL(rtc_cmos_read);
+void rtc_cmos_write(unsigned char val, unsigned char addr)
+{
+	lock_cmos_prefix(addr);
+	outb_p(addr, RTC_PORT(0));
+	outb_p(val, RTC_PORT(1));
+	lock_cmos_suffix(addr);
+}
+EXPORT_SYMBOL(rtc_cmos_write);
+
 DEFINE_SPINLOCK(i8253_lock);
 
 static int nohpet __initdata = 0;
Index: linux-2.6.11-rc5-mm1/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.11-rc5-mm1.orig/arch/x86_64/kernel/traps.c
+++ linux-2.6.11-rc5-mm1/arch/x86_64/kernel/traps.c
@@ -38,6 +38,7 @@
 #include <asm/i387.h>
 #include <asm/kdebug.h>
 #include <asm/processor.h>
+#include <asm/mc146818rtc.h>
 
 #include <asm/smp.h>
 #include <asm/pgalloc.h>
@@ -589,6 +590,7 @@
 asmlinkage void default_do_nmi(struct pt_regs *regs)
 {
 	unsigned char reason = 0;
+	int old_reg = -1;
 
 	/* Only the BSP gets external NMIs from the system.  */
 	if (!smp_processor_id())
@@ -625,10 +627,18 @@
 	 * Reassert NMI in case it became active meanwhile
 	 * as it's edge-triggered.
 	 */
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
 
 asmlinkage void do_int3(struct pt_regs * regs, long error_code)

--------------030004010308070000080305--
