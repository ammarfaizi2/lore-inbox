Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbTHSVsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbTHSVsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:48:54 -0400
Received: from fmr04.intel.com ([143.183.121.6]:35526 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261677AbTHSVrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:47:23 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C36686.EF71D5A8"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH][2.6][5/5]Support for HPET based timer
Date: Tue, 19 Aug 2003 12:20:22 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1C7@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6][5/5]Support for HPET based timer
Thread-Index: AcNmhu8qqRFkdSVwTYqywEKkEAJ+Xw==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@osdl.org>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 19 Aug 2003 19:20:23.0127 (UTC) FILETIME=[EFCBD670:01C36686]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C36686.EF71D5A8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

5/5 - hpet5.patch - This can be a standalone patch. Without this
                    patch we loose interrupt generation capability
                    of RTC (/dev/rtc), due to HPET. With this patch
                    we basically try to emulate RTC interrupt
                    functions in software using HPET counter 1.






diff -purN linux-2.6.0-test1-hpet/arch/i386/kernel/time_hpet.c =
linux-2.6.0-test1-hpet-rtc/arch/i386/kernel/time_hpet.c
--- linux-2.6.0-test1-hpet/arch/i386/kernel/time_hpet.c	2003-08-18 =
20:22:06.000000000 -0700
+++ linux-2.6.0-test1-hpet-rtc/arch/i386/kernel/time_hpet.c	2003-08-18 =
20:25:14.000000000 -0700
@@ -151,3 +151,225 @@ static int __init hpet_setup(char* str)
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
+	 * Stop the timers and reset the main counter.
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
+
diff -purN linux-2.6.0-test1-hpet/include/asm-i386/hpet.h =
linux-2.6.0-test1-hpet-rtc/include/asm-i386/hpet.h
--- linux-2.6.0-test1-hpet/include/asm-i386/hpet.h	2003-08-18 =
20:22:40.000000000 -0700
+++ linux-2.6.0-test1-hpet-rtc/include/asm-i386/hpet.h	2003-08-18 =
20:25:32.000000000 -0700
@@ -100,5 +100,15 @@ extern unsigned long hpet_virt_address;=09
 extern int hpet_enable(void);
 extern int is_hpet_enabled(void);
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
diff -purN linux-2.6.0-test1-hpet/include/asm-i386/mc146818rtc.h =
linux-2.6.0-test1-hpet-rtc/include/asm-i386/mc146818rtc.h
--- linux-2.6.0-test1-hpet/include/asm-i386/mc146818rtc.h	2003-08-18 =
20:23:43.000000000 -0700
+++ linux-2.6.0-test1-hpet-rtc/include/asm-i386/mc146818rtc.h	2003-08-18 =
20:25:44.000000000 -0700
@@ -24,10 +24,6 @@ outb_p((addr),RTC_PORT(0)); \
 outb_p((val),RTC_PORT(1)); \
 })
=20
-#ifdef CONFIG_HPET_TIMER
 #define RTC_IRQ 0
-#else
-#define RTC_IRQ 8
-#endif
=20
 #endif /* _ASM_MC146818RTC_H */
diff -purN linux-2.6.0-test1/drivers/char/rtc.c =
linux-2.6.0-test1-hpet/drivers/char/rtc.c
--- linux-2.6.0-test1/drivers/char/rtc.c	2003-07-13 20:33:12.000000000 =
-0700
+++ linux-2.6.0-test1-hpet/drivers/char/rtc.c	2003-08-18 =
20:08:12.000000000 -0700
@@ -43,6 +43,8 @@
  *	1.10e	Maciej W. Rozycki: Handle DECstation's year weirdness.
  *      1.11    Takashi Iwai: Kernel access functions
  *			      rtc_register/rtc_unregister/rtc_control
+ *              Venkatesh Pallipadi: Hooks for emulating rtc on HPET =
base-timer
+ *              CONFIG_HPET_EMULATE_RTC
  */
=20
 #define RTC_VERSION		"1.11"
@@ -78,6 +80,10 @@
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
@@ -118,7 +124,7 @@ static int rtc_ioctl(struct inode *inode
 static unsigned int rtc_poll(struct file *file, poll_table *wait);
 #endif
=20
-static void get_rtc_time (struct rtc_time *rtc_tm);
+void get_rtc_time (struct rtc_time *rtc_tm);
 static void get_rtc_alm_time (struct rtc_time *alm_tm);
 #if RTC_IRQ
 static void rtc_dropped_irq(unsigned long data);
@@ -180,7 +186,7 @@ static const unsigned char days_in_mo[]=20
  *	(See ./arch/XXXX/kernel/time.c for the set_rtc_mmss() function.)
  */
=20
-static irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs =
*regs)
+irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	/*
 	 *	Can be an alarm interrupt, update complete interrupt,
@@ -192,7 +198,19 @@ static irqreturn_t rtc_interrupt(int irq
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
@@ -427,6 +445,14 @@ static int rtc_do_ioctl(unsigned int cmd
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
@@ -580,6 +606,12 @@ static int rtc_do_ioctl(unsigned int cmd
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
@@ -665,6 +697,9 @@ static int rtc_release(struct inode *ino
 	 */
=20
 	spin_lock_irq(&rtc_lock);
+#ifdef CONFIG_HPET_EMULATE_RTC
+	hpet_mask_rtc_irq_bit(RTC_PIE | RTC_AIE | RTC_UIE);
+#endif
 	tmp =3D CMOS_READ(RTC_CONTROL);
 	tmp &=3D  ~RTC_PIE;
 	tmp &=3D  ~RTC_AIE;
@@ -754,6 +789,9 @@ int rtc_unregister(rtc_task_t *task)
 	unsigned char tmp;
=20
 	spin_lock_irq(&rtc_lock);
+#ifdef CONFIG_HPET_EMULATE_RTC
+	hpet_mask_rtc_irq_bit(RTC_PIE | RTC_AIE | RTC_UIE);
+#endif
 	spin_lock(&rtc_task_lock);
 	if (rtc_callback !=3D task) {
 		spin_unlock(&rtc_task_lock);
@@ -820,6 +858,8 @@ static struct miscdevice rtc_dev=3D
 	&rtc_fops
 };
=20
+static irqreturn_t (*rtc_int_handler_ptr)(int irq, void *dev_id, struct =
pt_regs *regs);
+
 static int __init rtc_init(void)
 {
 #if defined(__alpha__) || defined(__mips__)
@@ -888,17 +928,30 @@ no_irq:
 	}
=20
 #if RTC_IRQ
-	if(request_irq(RTC_IRQ, rtc_interrupt, SA_INTERRUPT, "rtc", NULL))
+#ifdef CONFIG_HPET_EMULATE_RTC
+	if (is_hpet_enabled()) {
+		rtc_int_handler_ptr =3D hpet_rtc_interrupt;
+	} else
+#endif
+	{
+		rtc_int_handler_ptr =3D rtc_interrupt;
+	}
+=09
+	if(request_irq(RTC_IRQ, rtc_int_handler_ptr, SA_INTERRUPT, "rtc", =
NULL))
 	{
 		/* Yeah right, seeing as irq 8 doesn't even hit the bus. */
 		printk(KERN_ERR "rtc: IRQ %d is not free.\n", RTC_IRQ);
 		release_region(RTC_PORT(0), RTC_IO_EXTENT);
 		return -EIO;
 	}
+#ifdef CONFIG_HPET_EMULATE_RTC
+	hpet_rtc_timer_init();
+#endif
 #endif
=20
 #endif /* __sparc__ vs. others */
=20
+	printk("rtc_timier_init() init\n");
 	if (misc_register(&rtc_dev))
 		{
 #if RTC_IRQ
@@ -961,8 +1014,11 @@ no_irq:
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
@@ -1013,6 +1069,13 @@ static void rtc_dropped_irq(unsigned lon
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
@@ -1142,7 +1205,7 @@ static inline unsigned char rtc_is_updat
 	return uip;
 }
=20
-static void get_rtc_time(struct rtc_time *rtc_tm)
+void get_rtc_time(struct rtc_time *rtc_tm)
 {
 	unsigned long uip_watchdog =3D jiffies;
 	unsigned char ctrl;
@@ -1248,6 +1311,12 @@ static void mask_rtc_irq_bit(unsigned ch
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
@@ -1262,6 +1331,12 @@ static void set_rtc_irq_bit(unsigned cha
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



------_=_NextPart_001_01C36686.EF71D5A8
Content-Type: application/x-zip-compressed;
	name="hpet5.ZIP"
Content-Transfer-Encoding: base64
Content-Description: hpet5.ZIP
Content-Disposition: attachment;
	filename="hpet5.ZIP"

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

------_=_NextPart_001_01C36686.EF71D5A8--
