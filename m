Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVAXCrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVAXCrx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 21:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVAXCrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 21:47:53 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:63961 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261422AbVAXCrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 21:47:39 -0500
Message-ID: <41F461C9.3070602@acm.org>
Date: Sun, 23 Jan 2005 20:47:37 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch to fix race between the NMI code and the CMOS clock
References: <41F18A52.9040703@acm.org> <20050123001806.53140e54.akpm@osdl.org>
In-Reply-To: <20050123001806.53140e54.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------080006070300040406080508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080006070300040406080508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>Corey Minyard <minyard@acm.org> wrote:
>  
>
>>This patch fixes a race between the CMOS clock setting and the NMI
>> code.  The NMI code indiscriminatly sets index registers and values
>> in the same place the CMOS clock is set.  If you are setting the
>> CMOS clock and an NMI occurs, Bad values could be written to or
>> read from the CMOS RAM, or the NMI operation might not occur
>> correctly.
>>
>> Fixing this requires creating a special lock so the NMI code can
>> know its CPU owns the lock an "do the right thing" in that case.
>>    
>>
>
>hm, tricky patch.  I can't see any holes in it.  The volatile variable is
>awkward but should be OK on x86 and I can see the need for it.
>
>There's a preposterous amount of inlining happening in this code.  Hence
>your patch took the size of drivers/char/rtc.o from
>
>   text    data     bss     dec     hex filename
>   3657     540       8    4205    106d drivers/char/rtc.o
>to
>   5419     540       8    5967    174f drivers/char/rtc.o
>
>Do you think you could take a look at uninlining everything sometime?
>  
>
Ok, done.  With the attached patch I get ~2300 bytes less text in that 
file.  It makes CMOS_READ and CMOS_WRITE functions.  They were used all 
over the place in drivers/char/rtc.o, and the extra locking stuff took a 
lot of space.  I also fixed some comment grammer and I discovered that 
linux/smp.h needed to be included, since smp_processor_id() was being 
called.

-Corey

--------------080006070300040406080508
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
--- linux-2.6.11-rc1.orig/arch/i386/kernel/time.c	2005-01-23 13:23:01.000000000 -0600
+++ linux-2.6.11-rc1/arch/i386/kernel/time.c	2005-01-23 13:56:13.000000000 -0600
@@ -83,6 +83,34 @@
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
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
 spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
 EXPORT_SYMBOL(i8253_lock);
 
Index: linux-2.6.11-rc1/include/asm-i386/mach-default/mach_traps.h
===================================================================
--- linux-2.6.11-rc1.orig/include/asm-i386/mach-default/mach_traps.h	2005-01-23 13:23:01.000000000 -0600
+++ linux-2.6.11-rc1/include/asm-i386/mach-default/mach_traps.h	2005-01-23 13:23:04.000000000 -0600
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
--- linux-2.6.11-rc1.orig/include/asm-i386/mc146818rtc.h	2005-01-23 13:23:01.000000000 -0600
+++ linux-2.6.11-rc1/include/asm-i386/mc146818rtc.h	2005-01-23 14:03:09.000000000 -0600
@@ -5,24 +5,89 @@
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
 

--------------080006070300040406080508--
