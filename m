Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264470AbTH1XtG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTH1Xs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:48:58 -0400
Received: from fmr09.intel.com ([192.52.57.35]:52460 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S264485AbTH1Xpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:45:45 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C36DBE.7869AEF4"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH][2.6-test4][6/6]Support for HPET based timer
Date: Thu, 28 Aug 2003 16:45:32 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D217@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6-test4][6/6]Support for HPET based timer
Thread-Index: AcNtvnhQtUa0cV8lQr6dpyNUj5eu6Q==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <torvalds@osdl.org>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 28 Aug 2003 23:45:34.0016 (UTC) FILETIME=[79249400:01C36DBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C36DBE.7869AEF4
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

6/6 - hpet6.patch - This can be a standalone patch. With this patch
                    we basically try to emulate RTC interrupt
                    functions in software using HPET counter 1.




diff -purN linux-2.6.0-test4/arch/i386/kernel/time_hpet.c =
linux-2.6.0-test4-hpet/arch/i386/kernel/time_hpet.c
--- linux-2.6.0-test4/arch/i386/kernel/time_hpet.c	2003-08-28 =
12:20:34.000000000 -0700
+++ linux-2.6.0-test4-hpet/arch/i386/kernel/time_hpet.c	2003-08-27 =
18:45:09.000000000 -0700
@@ -168,4 +168,225 @@ static int __init hpet_setup(char* str)
=20
 __setup("hpet=3D", hpet_setup);
=20
+#ifdef CONFIG_HPET_EMULATE_RTC
+/* HPET in LegacyReplacement Mode eats up RTC interrupt line. When, =
HPET=20
+ * is enabled, we support RTC interrupt functionality in software.=20
+ * RTC has 3 kinds of interrupts:
+ * 1) Update Interrupt - generate an interrupt, every sec, when RTC =
clock
+ *    is updated
+ * 2) Alarm Interrupt - generate an interrupt at a specific time of day
+ * 3) Periodic Interrupt - generate periodic interrupt, with =
frequencies
+ *    2Hz-8192Hz (2Hz-64Hz for non-root user) (all freqs in powers of =
2)
+ * (1) and (2) above are implemented using polling at a frequency of=20
+ * 64 Hz. The exact frequency is a tradeoff between accuracy and =
interrupt
+ * overhead. (DEFAULT_RTC_INT_FREQ)
+ * For (3), we use interrupts at 64Hz or user specified periodic=20
+ * frequency, whichever is higher.
+ */
+#include <linux/mc146818rtc.h>
+#include <linux/rtc.h>
+
+extern irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs =
*regs);
+extern void get_rtc_time(struct rtc_time *rtc_tm);
+
+#define DEFAULT_RTC_INT_FREQ 	64
+#define RTC_NUM_INTS 		1
+
+static unsigned long UIE_on;
+static unsigned long prev_update_sec;
+
+static unsigned long AIE_on;
+static struct rtc_time alarm_time;
+
+static unsigned long PIE_on;
+static unsigned long PIE_freq =3D DEFAULT_RTC_INT_FREQ;
+static unsigned long PIE_count;
+
+static unsigned long hpet_rtc_int_freq; /* RTC interrupt frequency */
+
+/*
+ * Timer 1 for RTC, we do not use periodic interrupt feature,=20
+ * even if HPET supports periodic interrupts on Timer 1.
+ * The reason being, to set up a periodic interrupt in HPET, we need to =

+ * stop the main counter. And if we do that everytime someone =
diables/enables
+ * RTC, we will have adverse effect on main kernel timer running on =
Timer 0.
+ * So, for the time being, simulate the periodic interrupt in software.
+ *=20
+ * hpet_rtc_timer_init() is called for the first time and during =
subsequent=20
+ * interuppts reinit happens through hpet_rtc_timer_reinit().
+ */
+int hpet_rtc_timer_init(void)
+{
+	unsigned int cfg, cnt;
+	unsigned long flags;
+
+	if (!is_hpet_enabled())
+		return 0;
+	/*
+	 * Set the counter 1 and enable the interrupts.
+	 */
+	if (PIE_on && (PIE_freq > DEFAULT_RTC_INT_FREQ))
+		hpet_rtc_int_freq =3D PIE_freq;
+	else
+		hpet_rtc_int_freq =3D DEFAULT_RTC_INT_FREQ;
+
+	local_irq_save(flags);
+	cnt =3D hpet_readl(HPET_COUNTER);
+	cnt +=3D ((hpet_tick*HZ)/hpet_rtc_int_freq);
+	hpet_writel(cnt, HPET_T1_CMP);
+	local_irq_restore(flags);
+
+	cfg =3D hpet_readl(HPET_T1_CFG);
+	cfg |=3D HPET_TN_ENABLE | HPET_TN_SETVAL | HPET_TN_32BIT;
+	hpet_writel(cfg, HPET_T1_CFG);
+
+	return 1;
+}
+
+static void hpet_rtc_timer_reinit(void)
+{
+	unsigned int cfg, cnt;
+
+	if (!(PIE_on | AIE_on | UIE_on))
+		return;
+
+	if (PIE_on && (PIE_freq > DEFAULT_RTC_INT_FREQ))
+		hpet_rtc_int_freq =3D PIE_freq;
+	else
+		hpet_rtc_int_freq =3D DEFAULT_RTC_INT_FREQ;
+
+	/* It is more accurate to use the comparator value than current =
count.*/
+	cnt =3D hpet_readl(HPET_T1_CMP);
+	cnt +=3D hpet_tick*HZ/hpet_rtc_int_freq;
+	hpet_writel(cnt, HPET_T1_CMP);
+
+	cfg =3D hpet_readl(HPET_T1_CFG);
+	cfg |=3D HPET_TN_ENABLE | HPET_TN_SETVAL | HPET_TN_32BIT;
+	hpet_writel(cfg, HPET_T1_CFG);
+
+	return;
+}
+
+/*=20
+ * The functions below are called from rtc driver.=20
+ * Return 0 if HPET is not being used.
+ * Otherwise do the necessary changes and return 1.
+ */
+int hpet_mask_rtc_irq_bit(unsigned long bit_mask)
+{
+	if (!is_hpet_enabled())
+		return 0;
+
+	if (bit_mask & RTC_UIE)
+		UIE_on =3D 0;
+	if (bit_mask & RTC_PIE)
+		PIE_on =3D 0;
+	if (bit_mask & RTC_AIE)
+		AIE_on =3D 0;
+
+	return 1;
+}
+
+int hpet_set_rtc_irq_bit(unsigned long bit_mask)
+{
+	int timer_init_reqd =3D 0;
+
+	if (!is_hpet_enabled())
+		return 0;
+
+	if (!(PIE_on | AIE_on | UIE_on))
+		timer_init_reqd =3D 1;
+
+	if (bit_mask & RTC_UIE) {
+		UIE_on =3D 1;
+	}
+	if (bit_mask & RTC_PIE) {
+		PIE_on =3D 1;
+		PIE_count =3D 0;
+	}
+	if (bit_mask & RTC_AIE) {
+		AIE_on =3D 1;
+	}
+
+	if (timer_init_reqd)
+		hpet_rtc_timer_init();
+
+	return 1;
+}
+
+int hpet_set_alarm_time(unsigned char hrs, unsigned char min, unsigned =
char sec)
+{
+	if (!is_hpet_enabled())
+		return 0;
+
+	alarm_time.tm_hour =3D hrs;
+	alarm_time.tm_min =3D min;
+	alarm_time.tm_sec =3D sec;
+
+	return 1;
+}
+
+int hpet_set_periodic_freq(unsigned long freq)
+{
+	if (!is_hpet_enabled())
+		return 0;
+
+	PIE_freq =3D freq;
+	PIE_count =3D 0;
+
+	return 1;
+}
+
+int hpet_rtc_dropped_irq(void)
+{
+	if (!is_hpet_enabled())
+		return 0;
+
+	return 1;
+}
+
+irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id, struct pt_regs =
*regs)
+{
+	struct rtc_time curr_time;
+	unsigned long rtc_int_flag =3D 0;
+	int call_rtc_interrupt =3D 0;
+
+	hpet_rtc_timer_reinit();
+
+	if (UIE_on | AIE_on) {
+		get_rtc_time(&curr_time);
+	}
+	if (UIE_on) {
+		if (curr_time.tm_sec !=3D prev_update_sec) {
+			/* Set update int info, call real rtc int routine */
+			call_rtc_interrupt =3D 1;
+			rtc_int_flag =3D RTC_UF;
+			prev_update_sec =3D curr_time.tm_sec;
+		}
+	}
+	if (PIE_on) {
+		PIE_count++;
+		if (PIE_count >=3D hpet_rtc_int_freq/PIE_freq) {
+			/* Set periodic int info, call real rtc int routine */
+			call_rtc_interrupt =3D 1;
+			rtc_int_flag |=3D RTC_PF;
+			PIE_count =3D 0;
+		}
+	}
+	if (AIE_on) {
+		if ((curr_time.tm_sec =3D=3D alarm_time.tm_sec) &&
+		    (curr_time.tm_min =3D=3D alarm_time.tm_min) &&
+		    (curr_time.tm_hour =3D=3D alarm_time.tm_hour)) {
+			/* Set alarm int info, call real rtc int routine */
+			call_rtc_interrupt =3D 1;
+			rtc_int_flag |=3D RTC_AF;
+		}
+	}
+	if (call_rtc_interrupt) {
+		rtc_int_flag |=3D (RTC_IRQF | (RTC_NUM_INTS << 8));
+		rtc_interrupt(rtc_int_flag, dev_id, regs);
+	}
+	return IRQ_HANDLED;
+}
+#endif
=20
diff -purN linux-2.6.0-test4/drivers/char/rtc.c =
linux-2.6.0-test4-hpet/drivers/char/rtc.c
--- linux-2.6.0-test4/drivers/char/rtc.c	2003-08-28 12:22:36.000000000 =
-0700
+++ linux-2.6.0-test4-hpet/drivers/char/rtc.c	2003-08-27 =
13:21:18.000000000 -0700
@@ -44,10 +44,12 @@
  *      1.11    Takashi Iwai: Kernel access functions
  *			      rtc_register/rtc_unregister/rtc_control
  *      1.11a   Daniele Bellucci: Audit create_proc_read_entry in =
rtc_init
+ *	1.12	Venkatesh Pallipadi: Hooks for emulating rtc on HPET base-timer
+ *		CONFIG_HPET_EMULATE_RTC
  *
  */
=20
-#define RTC_VERSION		"1.11a"
+#define RTC_VERSION		"1.12"
=20
 #define RTC_IO_EXTENT	0x8
=20
@@ -80,6 +82,10 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
=20
+#if defined(__i386__)
+#include <asm/hpet.h>
+#endif
+
 #ifdef __sparc__
 #include <linux/pci.h>
 #include <asm/ebus.h>
@@ -120,7 +126,7 @@ static int rtc_ioctl(struct inode *inode
 static unsigned int rtc_poll(struct file *file, poll_table *wait);
 #endif
=20
-static void get_rtc_time (struct rtc_time *rtc_tm);
+void get_rtc_time (struct rtc_time *rtc_tm);
 static void get_rtc_alm_time (struct rtc_time *alm_tm);
 #if RTC_IRQ
 static void rtc_dropped_irq(unsigned long data);
@@ -182,7 +188,7 @@ static const unsigned char days_in_mo[]=20
  *	(See ./arch/XXXX/kernel/time.c for the set_rtc_mmss() function.)
  */
=20
-static irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs =
*regs)
+irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	/*
 	 *	Can be an alarm interrupt, update complete interrupt,
@@ -194,7 +200,19 @@ static irqreturn_t rtc_interrupt(int irq
 	spin_lock (&rtc_lock);
 	rtc_irq_data +=3D 0x100;
 	rtc_irq_data &=3D ~0xff;
-	rtc_irq_data |=3D (CMOS_READ(RTC_INTR_FLAGS) & 0xF0);
+#ifdef CONFIG_HPET_EMULATE_RTC
+	if (is_hpet_enabled()) {
+		/*
+		 * In this case it is HPET RTC interrupt handler
+		 * calling us, with the interrupt information
+		 * passed as arg1, instead of irq.
+		 */
+		rtc_irq_data |=3D (unsigned long)irq & 0xF0;
+	} else
+#endif
+	{
+		rtc_irq_data |=3D (CMOS_READ(RTC_INTR_FLAGS) & 0xF0);
+	}
=20
 	if (rtc_status & RTC_TIMER_ON)
 		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
@@ -429,6 +447,14 @@ static int rtc_do_ioctl(unsigned int cmd
 		sec =3D alm_tm.tm_sec;
=20
 		spin_lock_irq(&rtc_lock);
+#ifdef CONFIG_HPET_EMULATE_RTC
+		if (hpet_set_alarm_time(hrs, min, sec)) {
+			/*
+			 * Fallthru and set alarm time in CMOS too,=20
+			 * so that we will get proper value in RTC_ALM_READ
+			 */
+		}
+#endif
 		if (!(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) ||
 		    RTC_ALWAYS_BCD)
 		{
@@ -582,6 +608,12 @@ static int rtc_do_ioctl(unsigned int cmd
 			return -EINVAL;
=20
 		spin_lock_irq(&rtc_lock);
+#ifdef CONFIG_HPET_EMULATE_RTC
+		if (hpet_set_periodic_freq(arg)) {
+			spin_unlock_irq(&rtc_lock);
+			return 0;
+		}
+#endif
 		rtc_freq =3D arg;
=20
 		val =3D CMOS_READ(RTC_FREQ_SELECT) & 0xf0;
@@ -667,6 +699,9 @@ static int rtc_release(struct inode *ino
 	 */
=20
 	spin_lock_irq(&rtc_lock);
+#ifdef CONFIG_HPET_EMULATE_RTC
+	hpet_mask_rtc_irq_bit(RTC_PIE | RTC_AIE | RTC_UIE);
+#endif
 	tmp =3D CMOS_READ(RTC_CONTROL);
 	tmp &=3D  ~RTC_PIE;
 	tmp &=3D  ~RTC_AIE;
@@ -756,6 +791,9 @@ int rtc_unregister(rtc_task_t *task)
 	unsigned char tmp;
=20
 	spin_lock_irq(&rtc_lock);
+#ifdef CONFIG_HPET_EMULATE_RTC
+	hpet_mask_rtc_irq_bit(RTC_PIE | RTC_AIE | RTC_UIE);
+#endif
 	spin_lock(&rtc_task_lock);
 	if (rtc_callback !=3D task) {
 		spin_unlock(&rtc_task_lock);
@@ -822,6 +860,10 @@ static struct miscdevice rtc_dev=3D
 	&rtc_fops
 };
=20
+#if RTC_IRQ
+static irqreturn_t (*rtc_int_handler_ptr)(int irq, void *dev_id, struct =
pt_regs *regs);
+#endif
+
 static int __init rtc_init(void)
 {
 #if defined(__alpha__) || defined(__mips__)
@@ -889,12 +931,25 @@ no_irq:
 	}
=20
 #if RTC_IRQ
-	if (request_irq(RTC_IRQ, rtc_interrupt, SA_INTERRUPT, "rtc", NULL)) {
+#ifdef CONFIG_HPET_EMULATE_RTC
+	if (is_hpet_enabled()) {
+		rtc_int_handler_ptr =3D hpet_rtc_interrupt;
+	} else
+#endif
+	{
+		rtc_int_handler_ptr =3D rtc_interrupt;
+	}
+
+	if(request_irq(RTC_IRQ, rtc_int_handler_ptr, SA_INTERRUPT, "rtc", =
NULL)) {
 		/* Yeah right, seeing as irq 8 doesn't even hit the bus. */
 		printk(KERN_ERR "rtc: IRQ %d is not free.\n", RTC_IRQ);
 		release_region(RTC_PORT(0), RTC_IO_EXTENT);
 		return -EIO;
 	}
+#ifdef CONFIG_HPET_EMULATE_RTC
+	hpet_rtc_timer_init();
+#endif
+
 #endif
=20
 #endif /* __sparc__ vs. others */
@@ -967,8 +1022,11 @@ no_irq:
 	spin_lock_irq(&rtc_lock);
 	/* Initialize periodic freq. to CMOS reset default, which is 1024Hz */
 	CMOS_WRITE(((CMOS_READ(RTC_FREQ_SELECT) & 0xF0) | 0x06), =
RTC_FREQ_SELECT);
-	spin_unlock_irq(&rtc_lock);
 	rtc_freq =3D 1024;
+#ifdef CONFIG_HPET_EMULATE_RTC
+	hpet_set_periodic_freq(rtc_freq);
+#endif
+	spin_unlock_irq(&rtc_lock);
 no_irq2:
 #endif
=20
@@ -1019,6 +1077,13 @@ static void rtc_dropped_irq(unsigned lon
=20
 	spin_lock_irq (&rtc_lock);
=20
+#ifdef CONFIG_HPET_EMULATE_RTC
+	if (hpet_rtc_dropped_irq()) {
+		spin_unlock_irq(&rtc_lock);
+		return;
+	}
+#endif
+
 	/* Just in case someone disabled the timer from behind our back... */
 	if (rtc_status & RTC_TIMER_ON)
 		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
@@ -1148,7 +1213,7 @@ static inline unsigned char rtc_is_updat
 	return uip;
 }
=20
-static void get_rtc_time(struct rtc_time *rtc_tm)
+void get_rtc_time(struct rtc_time *rtc_tm)
 {
 	unsigned long uip_watchdog =3D jiffies;
 	unsigned char ctrl;
@@ -1254,6 +1319,12 @@ static void mask_rtc_irq_bit(unsigned ch
 	unsigned char val;
=20
 	spin_lock_irq(&rtc_lock);
+#ifdef CONFIG_HPET_EMULATE_RTC
+	if (hpet_mask_rtc_irq_bit(bit)) {
+		spin_unlock_irq(&rtc_lock);
+		return;
+	}
+#endif
 	val =3D CMOS_READ(RTC_CONTROL);
 	val &=3D  ~bit;
 	CMOS_WRITE(val, RTC_CONTROL);
@@ -1268,6 +1339,12 @@ static void set_rtc_irq_bit(unsigned cha
 	unsigned char val;
=20
 	spin_lock_irq(&rtc_lock);
+#ifdef CONFIG_HPET_EMULATE_RTC
+	if (hpet_set_rtc_irq_bit(bit)) {
+		spin_unlock_irq(&rtc_lock);
+		return;
+	}
+#endif
 	val =3D CMOS_READ(RTC_CONTROL);
 	val |=3D bit;
 	CMOS_WRITE(val, RTC_CONTROL);
diff -purN linux-2.6.0-test4/include/asm-i386/hpet.h =
linux-2.6.0-test4-hpet/include/asm-i386/hpet.h
--- linux-2.6.0-test4/include/asm-i386/hpet.h	2003-08-28 =
12:21:19.000000000 -0700
+++ linux-2.6.0-test4-hpet/include/asm-i386/hpet.h	2003-08-27 =
15:24:54.000000000 -0700
@@ -102,5 +102,15 @@ extern int is_hpet_capable(void);
 extern int hpet_readl(unsigned long a);
 extern void hpet_writel(unsigned long d, unsigned long a);
=20
+#ifdef CONFIG_RTC
+#define CONFIG_HPET_EMULATE_RTC 	1
+extern int hpet_mask_rtc_irq_bit(unsigned long bit_mask);
+extern int hpet_set_rtc_irq_bit(unsigned long bit_mask);
+extern int hpet_set_alarm_time(unsigned char hrs, unsigned char min, =
unsigned char sec);
+extern int hpet_set_periodic_freq(unsigned long freq);
+extern int hpet_rtc_dropped_irq(void);
+extern int hpet_rtc_timer_init(void);
+extern irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id, struct =
pt_regs *regs);
+#endif /* CONFIG_RTC */
 #endif /* CONFIG_HPET_TIMER */
 #endif /* _I386_HPET_H */
diff -purN linux-2.6.0-test4/include/asm-i386/mc146818rtc.h =
linux-2.6.0-test4-hpet/include/asm-i386/mc146818rtc.h
--- linux-2.6.0-test4/include/asm-i386/mc146818rtc.h	2003-08-28 =
12:22:14.000000000 -0700
+++ linux-2.6.0-test4-hpet/include/asm-i386/mc146818rtc.h	2003-08-28 =
12:02:28.000000000 -0700
@@ -24,10 +24,6 @@ outb_p((addr),RTC_PORT(0)); \
 outb_p((val),RTC_PORT(1)); \
 })
=20
-#ifdef CONFIG_HPET_TIMER
-#define RTC_IRQ 0
-#else
 #define RTC_IRQ 8
-#endif
=20
 #endif /* _ASM_MC146818RTC_H */



------_=_NextPart_001_01C36DBE.7869AEF4
Content-Type: application/x-zip-compressed;
	name="hpet06.ZIP"
Content-Transfer-Encoding: base64
Content-Description: hpet06.ZIP
Content-Disposition: attachment;
	filename="hpet06.ZIP"

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

------_=_NextPart_001_01C36DBE.7869AEF4--
