Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVG2CHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVG2CHH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 22:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVG2CHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 22:07:07 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:13202 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262040AbVG2CHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 22:07:00 -0400
From: Con Kolivas <kernel@kolivas.org>
To: tony@atomide.com
Subject: [PATCH] remove i386 dynamic ticks ifdefs
Date: Fri, 29 Jul 2005 12:06:43 +1000
User-Agent: KMail/1.8.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
X-Length: 15664
Content-Type: multipart/signed;
  boundary="nextPart1222797.8mvlOlJvPf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507291206.46261.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1222797.8mvlOlJvPf
Content-Type: multipart/mixed;
  boundary="Boundary-01=_08Y6CtmHH7AAu/M"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_08Y6CtmHH7AAu/M
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Tony

I assume you're maintaining the dyn tick patches for i386 posted on the mur=
u=20
website as your email is listed there. I thought you might be interested in=
=20
this patch for dyn-ticks which removes most of the #ifdefs out of common co=
de=20
paths as per linux kernel style and moves more code into dyn-tick.c. Most o=
f=20
it is straight forward code reorganisation, but to keep do_timer_interrupt=
=20
inlined I'd have to move it's code around somewhat. That may be a better=20
option but I've tried to fiddle with the mainline code as little as possibl=
e.

Patch applies to 2.6.12 with patch-dynamic-tick-2.6.12-rc6-050610-1 applied

cc'ed lkml just for public record of the patch.

Cheers,
Con

--Boundary-01=_08Y6CtmHH7AAu/M
Content-Type: text/x-diff;
  charset="us-ascii";
  name="dt-tweaks.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="dt-tweaks.patch"

Move most of the dynamic ticks code that is #ifdef'd out of code paths and
put it into dyn-tick.c

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 arch/i386/kernel/Makefile   |    2
 arch/i386/kernel/apic.c     |   36 ----------
 arch/i386/kernel/dyn-tick.c |  146 +++++++++++++++++++++++++++++++++++++++=
+++++
 arch/i386/kernel/irq.c      |    5 -
 arch/i386/kernel/time.c     |   72 ---------------------
 include/asm/dyn-tick.h      |    4 -
 include/linux/dyn-tick.h    |   12 +++
 7 files changed, 165 insertions(+), 112 deletions(-)

Index: linux-2.6.12-dt/arch/i386/kernel/apic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-dt.orig/arch/i386/kernel/apic.c	2005-07-29 01:43:15.0000=
00000 +1000
+++ linux-2.6.12-dt/arch/i386/kernel/apic.c	2005-07-29 01:49:05.000000000 +=
1000
@@ -932,11 +932,8 @@ static void __setup_APIC_LVTT(unsigned i
=20
 	apic_timer_val =3D clocks/APIC_DIVISOR;
=20
=2D#ifdef CONFIG_NO_IDLE_HZ
=2D	/* Local APIC timer is 24-bit */
 	if (apic_timer_val)
=2D		dyn_tick->max_skip =3D 0xffffff / apic_timer_val;
=2D#endif
+		set_dyn_tick_max_skip(apic_timer_val);
=20
 	apic_write_around(APIC_TMICT, apic_timer_val);
 }
@@ -1051,12 +1048,7 @@ void __init setup_boot_APIC_clock(void)
 	 */
 	setup_APIC_timer(calibration_result);
=20
=2D#ifdef CONFIG_NO_IDLE_HZ
=2D	if (calibration_result)
=2D		dyn_tick->state |=3D DYN_TICK_USE_APIC;
=2D	else
=2D		printk(KERN_INFO "dyn-tick: Cannot use local APIC\n");
=2D#endif
+	setup_dyn_tick_use_apic(calibration_result);
=20
 	local_irq_enable();
 }
@@ -1086,18 +1078,6 @@ void enable_APIC_timer(void)
 	}
 }
=20
=2D#if defined(CONFIG_NO_IDLE_HZ)
=2Dvoid reprogram_apic_timer(unsigned int count)
=2D{
=2D	unsigned long flags;
=2D
=2D	count *=3D apic_timer_val;
=2D	local_irq_save(flags);
=2D	apic_write_around(APIC_TMICT, count);
=2D	local_irq_restore(flags);
=2D}
=2D#endif
=2D
 /*
  * the frequency of the profiling timer can be changed
  * by writing a multiplier value into /proc/profile.
@@ -1210,21 +1190,11 @@ fastcall void smp_apic_timer_interrupt(s
 	 */
 	irq_enter();
=20
=2D#ifdef CONFIG_NO_IDLE_HZ
 	/*
 	 * Check if we need to wake up PIT interrupt handler.
 	 * Otherwise just wake up local APIC timer.
 	 */
=2D	do {
=2D		seq =3D read_seqbegin(&xtime_lock);
=2D		if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING)) {
=2D			if (dyn_tick->skip_cpu =3D=3D cpu && dyn_tick->skip > DYN_TICK_MIN_SK=
IP)
=2D				dyn_tick->interrupt(99, NULL, regs);
=2D			else
=2D				reprogram_apic_timer(1);
=2D		}
=2D	} while (read_seqretry(&xtime_lock, seq));
=2D#endif
+	wakeup_pit_or_apic(seq, cpu, &regs);
=20
 	smp_local_timer_interrupt(regs);
 	irq_exit();
Index: linux-2.6.12-dt/arch/i386/kernel/dyn-tick.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-dt.orig/arch/i386/kernel/dyn-tick.c	2005-07-29 01:43:15.=
000000000 +1000
+++ linux-2.6.12-dt/arch/i386/kernel/dyn-tick.c	2005-07-29 11:46:48.0000000=
00 +1000
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/dyn-tick.h>
=20
+#ifdef CONFIG_NO_IDLE_HZ
 void arch_reprogram_timer(void)
 {
 	if (cpu_has_local_apic()) {
@@ -43,3 +44,148 @@ int __init dyn_tick_init(void)
 	return 0;
 }
 arch_initcall(dyn_tick_init);
+
+static unsigned long long last_tick;
+
+/*
+ * This interrupt handler updates the time based on number of jiffies skip=
ped
+ * It would be somewhat more optimized to have a customa handler in each t=
imer
+ * using hardware ticks instead of nanoseconds. Note that CONFIG_NO_IDLE_HZ
+ * currently disables timer fallback on skipped jiffies.
+ */
+irqreturn_t dyn_tick_timer_interrupt(int irq, void *dev_id, struct pt_regs=
 *regs)
+{
+	unsigned long flags;
+	volatile unsigned long long now;
+	unsigned int skipped =3D 0;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	now =3D cur_timer->monotonic_clock();
+	while (now - last_tick >=3D NS_TICK_LEN) {
+		last_tick +=3D NS_TICK_LEN;
+		cur_timer->mark_offset();
+		do_timer_interrupt(irq, NULL, regs);
+		skipped++;
+	}
+	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING)) {
+		dyn_tick->skip =3D 1;
+		if (cpu_has_local_apic())
+			reprogram_apic_timer(dyn_tick->skip);
+		reprogram_pit_timer(dyn_tick->skip);
+		dyn_tick->state |=3D DYN_TICK_ENABLED;
+		dyn_tick->state &=3D ~DYN_TICK_SKIPPING;
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+int __init dyn_tick_arch_init(void)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	last_tick =3D cur_timer->monotonic_clock();
+	dyn_tick->skip =3D 1;
+	if (!(dyn_tick->state & DYN_TICK_USE_APIC) || !cpu_has_local_apic())
+		dyn_tick->max_skip =3D 0xffff/LATCH;	/* PIT timer length */
+	printk(KERN_INFO "dyn-tick: Maximum ticks to skip limited to %i\n",
+	       dyn_tick->max_skip);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	dyn_tick->interrupt =3D dyn_tick_timer_interrupt;
+	replace_timer_interrupt(dyn_tick->interrupt);
+
+	return 0;
+}
+
+/* Reproduced functions below here */
+inline void set_dyn_tick_max_skip(u32 apic_timer_val)
+{
+	dyn_tick->max_skip =3D 0xffffff / apic_timer_val;
+}
+
+inline void setup_dyn_tick_use_apic(unsigned int calibration_result)
+{
+	if (calibration_result)
+		dyn_tick->state |=3D DYN_TICK_USE_APIC;
+	else
+		printk(KERN_INFO "dyn-tick: Cannot use local APIC\n");
+}
+
+void wakeup_pit_or_apic(unsigned long seq, int cpu, struct pt_regs *regs)
+{
+	do {
+		seq =3D read_seqbegin(&xtime_lock);
+		if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING)) {
+			if (dyn_tick->skip_cpu =3D=3D cpu && dyn_tick->skip > DYN_TICK_MIN_SKIP)
+				dyn_tick->interrupt(99, NULL, regs);
+			else
+				reprogram_apic_timer(1);
+		}
+	} while (read_seqretry(&xtime_lock, seq));
+}
+
+void dyn_tick_interrupt(int irq, struct pt_regs *regs)
+{
+	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING) && irq !=3D =
0)
+		dyn_tick->interrupt(irq, NULL, regs);
+}
+
+void dyn_tick_time_init(struct timer_opts *cur_timer)
+{
+	if (strncmp(cur_timer->name, "tsc", 3) =3D=3D 0 ||
+	    strncmp(cur_timer->name, "pmtmr", 3) =3D=3D 0) {
+		dyn_tick->state |=3D DYN_TICK_SUITABLE;
+		printk(KERN_INFO "dyn-tick: Found suitable timer: %s\n",
+		       cur_timer->name);
+	} else
+		printk(KERN_ERR "dyn-tick: Cannot use timer %s\n",
+		       cur_timer->name);
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+void reprogram_apic_timer(unsigned int count)
+{
+	unsigned long flags;
+
+	count *=3D apic_timer_val;
+	local_irq_save(flags);
+	apic_write_around(APIC_TMICT, count);
+	local_irq_restore(flags);
+}
+#else
+void reprogram_apic_timer(unsigned int count)
+{
+}
+
+#endif
+
+#else
+inline void set_dyn_tick_max_skip(u32 apic_timer_val)
+{
+}
+
+void reprogram_apic_timer(unsigned int count)
+{
+}
+
+inline void setup_dyn_tick_use_apic(unsigned int calibration_result)
+{
+}
+
+void wakeup_pit_or_apic(unsigned long seq, int cpu, struct pt_regs *regs)
+{
+}
+
+void dyn_tick_interrupt(int irq, struct pt_regs *regs)
+{
+}
+
+void dyn_tick_time_init(struct timer_opts *cur_timer)
+{
+}
+
+#endif
+
+
Index: linux-2.6.12-dt/arch/i386/kernel/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-dt.orig/arch/i386/kernel/irq.c	2005-07-29 01:43:15.00000=
0000 +1000
+++ linux-2.6.12-dt/arch/i386/kernel/irq.c	2005-07-29 02:03:33.000000000 +1=
000
@@ -74,10 +74,7 @@ fastcall unsigned int do_IRQ(struct pt_r
 	}
 #endif
=20
=2D#ifdef CONFIG_NO_IDLE_HZ
=2D	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING) && irq !=
=3D 0)
=2D		dyn_tick->interrupt(irq, NULL, regs);
=2D#endif
+	dyn_tick_interrupt(irq, regs);
=20
 #ifdef CONFIG_4KSTACKS
=20
Index: linux-2.6.12-dt/arch/i386/kernel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-dt.orig/arch/i386/kernel/Makefile	2005-07-29 00:06:26.00=
0000000 +1000
+++ linux-2.6.12-dt/arch/i386/kernel/Makefile	2005-07-29 02:05:54.000000000=
 +1000
@@ -31,7 +31,7 @@ obj-$(CONFIG_MODULES)		+=3D module.o
 obj-y				+=3D sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+=3D srat.o
 obj-$(CONFIG_HPET_TIMER) 	+=3D time_hpet.o
=2Dobj-$(CONFIG_NO_IDLE_HZ) 	+=3D dyn-tick.o
+obj-y			 	+=3D dyn-tick.o
 obj-$(CONFIG_EFI) 		+=3D efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+=3D early_printk.o
=20
Index: linux-2.6.12-dt/arch/i386/kernel/time.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-dt.orig/arch/i386/kernel/time.c	2005-07-29 01:43:15.0000=
00000 +1000
+++ linux-2.6.12-dt/arch/i386/kernel/time.c	2005-07-29 11:53:52.000000000 +=
1000
@@ -248,7 +248,7 @@ EXPORT_SYMBOL(profile_pc);
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
=2Dstatic inline void do_timer_interrupt(int irq, void *dev_id,
+void do_timer_interrupt(int irq, void *dev_id,
 					struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_IO_APIC
@@ -309,43 +309,6 @@ irqreturn_t timer_interrupt(int irq, voi
 	return IRQ_HANDLED;
 }
=20
=2D#ifdef CONFIG_NO_IDLE_HZ
=2Dstatic unsigned long long last_tick;
=2D
=2D/*
=2D * This interrupt handler updates the time based on number of jiffies sk=
ipped
=2D * It would be somewhat more optimized to have a customa handler in each=
 timer
=2D * using hardware ticks instead of nanoseconds. Note that CONFIG_NO_IDLE=
_HZ
=2D * currently disables timer fallback on skipped jiffies.
=2D */
=2Dirqreturn_t dyn_tick_timer_interrupt(int irq, void *dev_id, struct pt_re=
gs *regs)
=2D{
=2D	unsigned long flags;
=2D	volatile unsigned long long now;
=2D	unsigned int skipped =3D 0;
=2D
=2D	write_seqlock_irqsave(&xtime_lock, flags);
=2D	now =3D cur_timer->monotonic_clock();
=2D	while (now - last_tick >=3D NS_TICK_LEN) {
=2D		last_tick +=3D NS_TICK_LEN;
=2D		cur_timer->mark_offset();
=2D		do_timer_interrupt(irq, NULL, regs);
=2D		skipped++;
=2D	}
=2D	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING)) {
=2D		dyn_tick->skip =3D 1;
=2D		if (cpu_has_local_apic())
=2D			reprogram_apic_timer(dyn_tick->skip);
=2D		reprogram_pit_timer(dyn_tick->skip);
=2D		dyn_tick->state |=3D DYN_TICK_ENABLED;
=2D		dyn_tick->state &=3D ~DYN_TICK_SKIPPING;
=2D	}
=2D	write_sequnlock_irqrestore(&xtime_lock, flags);
=2D
=2D	return IRQ_HANDLED;
=2D}
=2D#endif	/* CONFIG_NO_IDLE_HZ */
=2D
 /* not static: needed by APM */
 unsigned long get_cmos_time(void)
 {
@@ -490,28 +453,6 @@ static void __init hpet_time_init(void)
 }
 #endif
=20
=2D#ifdef CONFIG_NO_IDLE_HZ
=2D
=2Dint __init dyn_tick_arch_init(void)
=2D{
=2D	unsigned long flags;
=2D
=2D	write_seqlock_irqsave(&xtime_lock, flags);
=2D	last_tick =3D cur_timer->monotonic_clock();
=2D	dyn_tick->skip =3D 1;
=2D	if (!(dyn_tick->state & DYN_TICK_USE_APIC) || !cpu_has_local_apic())
=2D		dyn_tick->max_skip =3D 0xffff/LATCH;	/* PIT timer length */
=2D	printk(KERN_INFO "dyn-tick: Maximum ticks to skip limited to %i\n",
=2D	       dyn_tick->max_skip);
=2D	write_sequnlock_irqrestore(&xtime_lock, flags);
=2D
=2D	dyn_tick->interrupt =3D dyn_tick_timer_interrupt;
=2D	replace_timer_interrupt(dyn_tick->interrupt);
=2D
=2D	return 0;
=2D}
=2D#endif	/* CONFIG_NO_IDLE_HZ */
=2D
 void __init time_init(void)
 {
 #ifdef CONFIG_HPET_TIMER
@@ -532,16 +473,7 @@ void __init time_init(void)
 	cur_timer =3D select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
=20
=2D#ifdef CONFIG_NO_IDLE_HZ
=2D	if (strncmp(cur_timer->name, "tsc", 3) =3D=3D 0 ||
=2D	    strncmp(cur_timer->name, "pmtmr", 3) =3D=3D 0) {
=2D		dyn_tick->state |=3D DYN_TICK_SUITABLE;
=2D		printk(KERN_INFO "dyn-tick: Found suitable timer: %s\n",
=2D		       cur_timer->name);
=2D	} else
=2D		printk(KERN_ERR "dyn-tick: Cannot use timer %s\n",
=2D		       cur_timer->name);
=2D#endif
+	dyn_tick_time_init(cur_timer);
=20
 	time_init_hook();
 }
Index: linux-2.6.12-dt/include/asm/dyn-tick.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-dt.orig/include/asm/dyn-tick.h	2005-07-29 01:43:15.00000=
0000 +1000
+++ linux-2.6.12-dt/include/asm/dyn-tick.h	2005-07-29 01:58:54.000000000 +1=
000
@@ -19,11 +19,7 @@ extern void reprogram_pit_timer(int jiff
 extern void reprogram_apic_timer(unsigned int count);
 extern void replace_timer_interrupt(void * new_handler);
=20
=2D#if defined(CONFIG_NO_IDLE_HZ) && defined(CONFIG_X86_LOCAL_APIC)
 extern void reprogram_apic_timer(unsigned int count);
=2D#else
=2D#define reprogram_apic_timer(x)	do {} while (0)
=2D#endif
=20
 #if defined(CONFIG_DYN_TICK_USE_APIC) && (defined(CONFIG_SMP) || defined(C=
ONFIG_X86_UP_APIC))
 #define cpu_has_local_apic()	(dyn_tick->state & DYN_TICK_USE_APIC)
Index: linux-2.6.12-dt/include/linux/dyn-tick.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.12-dt.orig/include/linux/dyn-tick.h	2005-07-29 01:43:15.000=
000000 +1000
+++ linux-2.6.12-dt/include/linux/dyn-tick.h	2005-07-29 11:41:48.000000000 =
+1000
@@ -14,6 +14,7 @@
 #define _DYN_TICK_TIMER_H
=20
 #include <linux/interrupt.h>
+#include <asm/timer.h>
=20
 #define DYN_TICK_TIMER_INT	(1 << 4)
 #define DYN_TICK_USE_APIC	(1 << 3)
@@ -39,6 +40,14 @@ struct dyn_tick_timer {
=20
 extern struct dyn_tick_state * dyn_tick;
 extern void dyn_tick_register(struct dyn_tick_timer * new_timer);
+extern inline void set_dyn_tick_max_skip(u32 apic_timer_val);
+extern void reprogram_apic_timer(unsigned int count);
+extern inline void setup_dyn_tick_use_apic(unsigned int calibration_result=
);
+extern void wakeup_pit_or_apic(unsigned long seq, int cpu, struct pt_regs =
*regs);
+extern void dyn_tick_interrupt(int irq, struct pt_regs *regs);
+extern void dyn_tick_time_init(struct timer_opts *cur_timer);
+extern void do_timer_interrupt(int irq, void *dev_id,
+					struct pt_regs *regs);
=20
 #define NS_TICK_LEN		((1 * 1000000000)/HZ)
 #define DYN_TICK_MIN_SKIP	2
@@ -47,6 +56,9 @@ extern void dyn_tick_register(struct dyn
 #ifdef CONFIG_NO_IDLE_HZ
=20
 extern unsigned long dyn_tick_reprogram_timer(void);
+extern irqreturn_t dyn_tick_timer_interrupt(int irq, void *dev_id, struct =
pt_regs *regs);
+extern int __init dyn_tick_arch_init(void);
+
 #define dyn_tick_enabled()		(dyn_tick->state & DYN_TICK_ENABLED)
=20
 #else

--Boundary-01=_08Y6CtmHH7AAu/M--

--nextPart1222797.8mvlOlJvPf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC6Y82ZUg7+tp6mRURApXdAKCJaIwjxyJx4bHfYCWue2GhP+P8OgCfXWUB
0A5TFvAah+cv3XekgiANBm4=
=DESP
-----END PGP SIGNATURE-----

--nextPart1222797.8mvlOlJvPf--
