Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWJFO4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWJFO4k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWJFO4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:56:40 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:37171 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932413AbWJFO4f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:56:35 -0400
Date: Fri, 6 Oct 2006 16:56:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20061006145636.GG26371@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/Kconfig              |    3 +
 arch/s390/defconfig            |    1 
 arch/s390/kernel/s390_ext.c    |    9 ++-
 arch/s390/kernel/smp.c         |    2 -
 arch/s390/kernel/time.c        |  103 +++++++++++-----------------------------
 arch/s390/kernel/traps.c       |    2 -
 arch/s390/kernel/vtime.c       |    5 +-
 arch/s390/mm/fault.c           |    2 -
 drivers/char/sysrq.c           |    1 
 drivers/s390/block/dasd_diag.c |    2 -
 drivers/s390/char/ctrlchar.c   |    2 -
 drivers/s390/char/keyboard.c   |    2 -
 drivers/s390/char/monwriter.c  |   10 ++--
 drivers/s390/char/sclp.c       |    4 +-
 drivers/s390/cio/chsc.c        |   25 ++++++----
 drivers/s390/cio/cio.c         |    6 ++
 drivers/s390/crypto/ap_bus.c   |    2 -
 drivers/s390/net/iucv.c        |    4 +-
 include/asm-s390/hardirq.h     |    2 -
 include/asm-s390/irq_regs.h    |    1 
 include/asm-s390/s390_ext.h    |    2 -
 21 files changed, 83 insertions(+), 107 deletions(-)
 create mode 100644 include/asm-s390/irq_regs.h

Christian Borntraeger:
      [S390] ap bus poll thread priority.

Cornelia Huck:
      [S390] cio: 0 is a valid chpid.

Heiko Carstens:
      [S390] irq change build fixes.
      sysrq: irq change build fix.

Martin Schwidefsky:
      [S390] Use CONFIG_GENERIC_TIME and define TOD clock source.

Melissa Howland:
      [S390] monwriter buffer limit.

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 51c2dfe..608193c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -30,6 +30,9 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
+config GENERIC_TIME
+	def_bool y
+
 config GENERIC_BUST_SPINLOCK
 	bool
 
diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index b6cad75..a325739 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -9,6 +9,7 @@ CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_TIME=y
 CONFIG_S390=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
diff --git a/arch/s390/kernel/s390_ext.c b/arch/s390/kernel/s390_ext.c
index c1b3835..c49ab8c 100644
--- a/arch/s390/kernel/s390_ext.c
+++ b/arch/s390/kernel/s390_ext.c
@@ -16,6 +16,7 @@ #include <linux/interrupt.h>
 
 #include <asm/lowcore.h>
 #include <asm/s390_ext.h>
+#include <asm/irq_regs.h>
 #include <asm/irq.h>
 
 /*
@@ -114,26 +115,28 @@ void do_extint(struct pt_regs *regs, uns
 {
         ext_int_info_t *p;
         int index;
+	struct pt_regs *old_regs;
 
 	irq_enter();
+	old_regs = set_irq_regs(regs);
 	asm volatile ("mc 0,0");
 	if (S390_lowcore.int_clock >= S390_lowcore.jiffy_timer)
 		/**
 		 * Make sure that the i/o interrupt did not "overtake"
 		 * the last HZ timer interrupt.
 		 */
-		account_ticks(regs);
+		account_ticks();
 	kstat_cpu(smp_processor_id()).irqs[EXTERNAL_INTERRUPT]++;
         index = ext_hash(code);
 	for (p = ext_int_hash[index]; p; p = p->next) {
 		if (likely(p->code == code)) {
 			if (likely(p->handler))
-				p->handler(regs, code);
+				p->handler(code);
 		}
 	}
+	set_irq_regs(old_regs);
 	irq_exit();
 }
 
 EXPORT_SYMBOL(register_external_interrupt);
 EXPORT_SYMBOL(unregister_external_interrupt);
-
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index a8e6199..6282224 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -339,7 +339,7 @@ void machine_power_off_smp(void)
  * cpus are handled.
  */
 
-void do_ext_call_interrupt(struct pt_regs *regs, __u16 code)
+void do_ext_call_interrupt(__u16 code)
 {
         unsigned long bits;
 
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 4bf66cc..6cceed4 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -28,12 +28,14 @@ #include <linux/types.h>
 #include <linux/profile.h>
 #include <linux/timex.h>
 #include <linux/notifier.h>
+#include <linux/clocksource.h>
 
 #include <asm/uaccess.h>
 #include <asm/delay.h>
 #include <asm/s390_ext.h>
 #include <asm/div64.h>
 #include <asm/irq.h>
+#include <asm/irq_regs.h>
 #include <asm/timer.h>
 
 /* change this if you have some constant time drift */
@@ -81,78 +83,10 @@ void tod_to_timeval(__u64 todval, struct
 	xtime->tv_nsec = ((todval * 1000) >> 12);
 }
 
-static inline unsigned long do_gettimeoffset(void) 
-{
-	__u64 now;
-
-	now = (get_clock() - jiffies_timer_cc) >> 12;
-	now -= (__u64) jiffies * USECS_PER_JIFFY;
-	return (unsigned long) now;
-}
-
-/*
- * This version of gettimeofday has microsecond resolution.
- */
-void do_gettimeofday(struct timeval *tv)
-{
-	unsigned long flags;
-	unsigned long seq;
-	unsigned long usec, sec;
-
-	do {
-		seq = read_seqbegin_irqsave(&xtime_lock, flags);
-
-		sec = xtime.tv_sec;
-		usec = xtime.tv_nsec / 1000 + do_gettimeoffset();
-	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
-
-	while (usec >= 1000000) {
-		usec -= 1000000;
-		sec++;
-	}
-
-	tv->tv_sec = sec;
-	tv->tv_usec = usec;
-}
-
-EXPORT_SYMBOL(do_gettimeofday);
-
-int do_settimeofday(struct timespec *tv)
-{
-	time_t wtm_sec, sec = tv->tv_sec;
-	long wtm_nsec, nsec = tv->tv_nsec;
-
-	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
-		return -EINVAL;
-
-	write_seqlock_irq(&xtime_lock);
-	/* This is revolting. We need to set the xtime.tv_nsec
-	 * correctly. However, the value in this location is
-	 * is value at the last tick.
-	 * Discover what correction gettimeofday
-	 * would have done, and then undo it!
-	 */
-	nsec -= do_gettimeoffset() * 1000;
-
-	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
-	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
-
-	set_normalized_timespec(&xtime, sec, nsec);
-	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
-
-	ntp_clear();
-	write_sequnlock_irq(&xtime_lock);
-	clock_was_set();
-	return 0;
-}
-
-EXPORT_SYMBOL(do_settimeofday);
-
-
 #ifdef CONFIG_PROFILING
-#define s390_do_profile(regs)	profile_tick(CPU_PROFILING, regs)
+#define s390_do_profile()	profile_tick(CPU_PROFILING)
 #else
-#define s390_do_profile(regs)  do { ; } while(0)
+#define s390_do_profile()	do { ; } while(0)
 #endif /* CONFIG_PROFILING */
 
 
@@ -160,7 +94,7 @@ #endif /* CONFIG_PROFILING */
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-void account_ticks(struct pt_regs *regs)
+void account_ticks(void)
 {
 	__u64 tmp;
 	__u32 ticks;
@@ -221,10 +155,10 @@ #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	account_tick_vtime(current);
 #else
 	while (ticks--)
-		update_process_times(user_mode(regs));
+		update_process_times(user_mode(get_irq_regs()));
 #endif
 
-	s390_do_profile(regs);
+	s390_do_profile();
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
@@ -285,9 +219,11 @@ static inline void stop_hz_timer(void)
  */
 static inline void start_hz_timer(void)
 {
+	BUG_ON(!in_interrupt());
+
 	if (!cpu_isset(smp_processor_id(), nohz_cpu_mask))
 		return;
-	account_ticks(task_pt_regs(current));
+	account_ticks();
 	cpu_clear(smp_processor_id(), nohz_cpu_mask);
 }
 
@@ -337,6 +273,22 @@ void init_cpu_timer(void)
 
 extern void vtime_init(void);
 
+static cycle_t read_tod_clock(void)
+{
+	return get_clock();
+}
+
+static struct clocksource clocksource_tod = {
+	.name		= "tod",
+	.rating		= 100,
+	.read		= read_tod_clock,
+	.mask		= -1ULL,
+	.mult		= 1000,
+	.shift		= 12,
+	.is_continuous	= 1,
+};
+
+
 /*
  * Initialize the TOD clock and the CPU timer of
  * the boot cpu.
@@ -381,6 +333,9 @@ void __init time_init(void)
 					      &ext_int_info_cc) != 0)
                 panic("Couldn't request external interrupt 0x1004");
 
+	if (clocksource_register(&clocksource_tod) != 0)
+		panic("Could not register TOD clock source");
+
         init_cpu_timer();
 
 #ifdef CONFIG_NO_IDLE_HZ
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 3eb4fab..05bf3cc 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -61,7 +61,7 @@ extern pgm_check_handler_t do_dat_except
 #ifdef CONFIG_PFAULT
 extern int pfault_init(void);
 extern void pfault_fini(void);
-extern void pfault_interrupt(struct pt_regs *regs, __u16 error_code);
+extern void pfault_interrupt(__u16 error_code);
 static ext_int_info_t ext_int_pfault;
 #endif
 extern pgm_check_handler_t do_monitor_call;
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 2306cd8..1d7d393 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -22,6 +22,7 @@ #include <linux/posix-timers.h>
 
 #include <asm/s390_ext.h>
 #include <asm/timer.h>
+#include <asm/irq_regs.h>
 
 static ext_int_info_t ext_int_info_timer;
 DEFINE_PER_CPU(struct vtimer_queue, virt_cpu_timer);
@@ -241,7 +242,7 @@ static void do_callbacks(struct list_hea
 /*
  * Handler for the virtual CPU timer.
  */
-static void do_cpu_timer_interrupt(struct pt_regs *regs, __u16 error_code)
+static void do_cpu_timer_interrupt(__u16 error_code)
 {
 	int cpu;
 	__u64 next, delta;
@@ -274,7 +275,7 @@ static void do_cpu_timer_interrupt(struc
 		list_move_tail(&event->entry, &cb_list);
 	}
 	spin_unlock(&vt_list->lock);
-	do_callbacks(&cb_list, regs);
+	do_callbacks(&cb_list, get_irq_regs());
 
 	/* next event is first in list */
 	spin_lock(&vt_list->lock);
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 9c3c19f..1c323bb 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -451,7 +451,7 @@ void pfault_fini(void)
 }
 
 asmlinkage void
-pfault_interrupt(struct pt_regs *regs, __u16 error_code)
+pfault_interrupt(__u16 error_code)
 {
 	struct task_struct *tsk;
 	__u16 subcode;
diff --git a/drivers/char/sysrq.c b/drivers/char/sysrq.c
index 4c0e086..5f49280 100644
--- a/drivers/char/sysrq.c
+++ b/drivers/char/sysrq.c
@@ -38,6 +38,7 @@ #include <linux/kexec.h>
 #include <linux/irq.h>
 
 #include <asm/ptrace.h>
+#include <asm/irq_regs.h>
 
 /* Whether we react on sysrq keys or just ignore them */
 int sysrq_enabled = 1;
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 222a8a7..53db58a 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -218,7 +218,7 @@ dasd_diag_term_IO(struct dasd_ccw_req * 
 
 /* Handle external interruption. */
 static void
-dasd_ext_handler(struct pt_regs *regs, __u16 code)
+dasd_ext_handler(__u16 code)
 {
 	struct dasd_ccw_req *cqr, *next;
 	struct dasd_device *device;
diff --git a/drivers/s390/char/ctrlchar.c b/drivers/s390/char/ctrlchar.c
index d83eb63..49e9628 100644
--- a/drivers/s390/char/ctrlchar.c
+++ b/drivers/s390/char/ctrlchar.c
@@ -20,7 +20,7 @@ static int ctrlchar_sysrq_key;
 static void
 ctrlchar_handle_sysrq(void *tty)
 {
-	handle_sysrq(ctrlchar_sysrq_key, NULL, (struct tty_struct *) tty);
+	handle_sysrq(ctrlchar_sysrq_key, (struct tty_struct *) tty);
 }
 
 static DECLARE_WORK(ctrlchar_work, ctrlchar_handle_sysrq, NULL);
diff --git a/drivers/s390/char/keyboard.c b/drivers/s390/char/keyboard.c
index 3be0656..e3491a5 100644
--- a/drivers/s390/char/keyboard.c
+++ b/drivers/s390/char/keyboard.c
@@ -304,7 +304,7 @@ #ifdef CONFIG_MAGIC_SYSRQ	       /* Hand
 		if (kbd->sysrq) {
 			if (kbd->sysrq == K(KT_LATIN, '-')) {
 				kbd->sysrq = 0;
-				handle_sysrq(value, NULL, kbd->tty);
+				handle_sysrq(value, kbd->tty);
 				return;
 			}
 			if (value == '-') {
diff --git a/drivers/s390/char/monwriter.c b/drivers/s390/char/monwriter.c
index 1e3939a..4362ff2 100644
--- a/drivers/s390/char/monwriter.c
+++ b/drivers/s390/char/monwriter.c
@@ -26,6 +26,7 @@ #include <asm/monwriter.h>
 #define MONWRITE_MAX_DATALEN	4024
 
 static int mon_max_bufs = 255;
+static int mon_buf_count;
 
 struct mon_buf {
 	struct list_head list;
@@ -40,7 +41,6 @@ struct mon_private {
 	size_t hdr_to_read;
 	size_t data_to_read;
 	struct mon_buf *current_buf;
-	int mon_buf_count;
 };
 
 /*
@@ -99,13 +99,13 @@ static int monwrite_new_hdr(struct mon_p
 			rc = monwrite_diag(monhdr, monbuf->data,
 					   APPLDATA_STOP_REC);
 			list_del(&monbuf->list);
-			monpriv->mon_buf_count--;
+			mon_buf_count--;
 			kfree(monbuf->data);
 			kfree(monbuf);
 			monbuf = NULL;
 		}
 	} else {
-		if (monpriv->mon_buf_count >= mon_max_bufs)
+		if (mon_buf_count >= mon_max_bufs)
 			return -ENOSPC;
 		monbuf = kzalloc(sizeof(struct mon_buf), GFP_KERNEL);
 		if (!monbuf)
@@ -118,7 +118,7 @@ static int monwrite_new_hdr(struct mon_p
 		}
 		monbuf->hdr = *monhdr;
 		list_add_tail(&monbuf->list, &monpriv->list);
-		monpriv->mon_buf_count++;
+		mon_buf_count++;
 	}
 	monpriv->current_buf = monbuf;
 	return 0;
@@ -186,7 +186,7 @@ static int monwrite_close(struct inode *
 		if (entry->hdr.mon_function != MONWRITE_GEN_EVENT)
 			monwrite_diag(&entry->hdr, entry->data,
 				      APPLDATA_STOP_REC);
-		monpriv->mon_buf_count--;
+		mon_buf_count--;
 		list_del(&entry->list);
 		kfree(entry->data);
 		kfree(entry);
diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 31e3357..8a056df 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -324,7 +324,7 @@ __sclp_find_req(u32 sccb)
  * Prepare read event data request if necessary. Start processing of next
  * request on queue. */
 static void
-sclp_interrupt_handler(struct pt_regs *regs, __u16 code)
+sclp_interrupt_handler(__u16 code)
 {
 	struct sclp_req *req;
 	u32 finished_sccb;
@@ -743,7 +743,7 @@ EXPORT_SYMBOL(sclp_reactivate);
 /* Handler for external interruption used during initialization. Modify
  * request state to done. */
 static void
-sclp_check_handler(struct pt_regs *regs, __u16 code)
+sclp_check_handler(__u16 code)
 {
 	u32 finished_sccb;
 
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 3bb4e47..07c7f19 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -200,11 +200,13 @@ css_get_ssd_info(struct subchannel *sch)
 	spin_unlock_irq(&sch->lock);
 	free_page((unsigned long)page);
 	if (!ret) {
-		int j, chpid;
+		int j, chpid, mask;
 		/* Allocate channel path structures, if needed. */
 		for (j = 0; j < 8; j++) {
+			mask = 0x80 >> j;
 			chpid = sch->ssd_info.chpid[j];
-			if (chpid && (get_chp_status(chpid) < 0))
+			if ((sch->schib.pmcw.pim & mask) &&
+			    (get_chp_status(chpid) < 0))
 			    new_channel_path(chpid);
 		}
 	}
@@ -222,13 +224,15 @@ s390_subchannel_remove_chpid(struct devi
 
 	sch = to_subchannel(dev);
 	chpid = data;
-	for (j = 0; j < 8; j++)
-		if (sch->schib.pmcw.chpid[j] == chpid->id)
+	for (j = 0; j < 8; j++) {
+		mask = 0x80 >> j;
+		if ((sch->schib.pmcw.pim & mask) &&
+		    (sch->schib.pmcw.chpid[j] == chpid->id))
 			break;
+	}
 	if (j >= 8)
 		return 0;
 
-	mask = 0x80 >> j;
 	spin_lock_irq(&sch->lock);
 
 	stsch(sch->schid, &schib);
@@ -620,7 +624,7 @@ __chp_add_new_sch(struct subchannel_id s
 static int
 __chp_add(struct subchannel_id schid, void *data)
 {
-	int i;
+	int i, mask;
 	struct channel_path *chp;
 	struct subchannel *sch;
 
@@ -630,8 +634,10 @@ __chp_add(struct subchannel_id schid, vo
 		/* Check if the subchannel is now available. */
 		return __chp_add_new_sch(schid);
 	spin_lock_irq(&sch->lock);
-	for (i=0; i<8; i++)
-		if (sch->schib.pmcw.chpid[i] == chp->id) {
+	for (i=0; i<8; i++) {
+		mask = 0x80 >> i;
+		if ((sch->schib.pmcw.pim & mask) &&
+		    (sch->schib.pmcw.chpid[i] == chp->id)) {
 			if (stsch(sch->schid, &sch->schib) != 0) {
 				/* Endgame. */
 				spin_unlock_irq(&sch->lock);
@@ -639,6 +645,7 @@ __chp_add(struct subchannel_id schid, vo
 			}
 			break;
 		}
+	}
 	if (i==8) {
 		spin_unlock_irq(&sch->lock);
 		return 0;
@@ -646,7 +653,7 @@ __chp_add(struct subchannel_id schid, vo
 	sch->lpm = ((sch->schib.pmcw.pim &
 		     sch->schib.pmcw.pam &
 		     sch->schib.pmcw.pom)
-		    | 0x80 >> i) & sch->opm;
+		    | mask) & sch->opm;
 
 	if (sch->driver && sch->driver->verify)
 		sch->driver->verify(&sch->dev);
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 2e2882d..f18b162 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -19,6 +19,7 @@ #include <linux/interrupt.h>
 #include <asm/cio.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
+#include <asm/irq_regs.h>
 #include <asm/setup.h>
 #include "airq.h"
 #include "cio.h"
@@ -606,15 +607,17 @@ do_IRQ (struct pt_regs *regs)
 	struct tpi_info *tpi_info;
 	struct subchannel *sch;
 	struct irb *irb;
+	struct pt_regs *old_regs;
 
 	irq_enter ();
+	old_regs = set_irq_regs(regs);
 	asm volatile ("mc 0,0");
 	if (S390_lowcore.int_clock >= S390_lowcore.jiffy_timer)
 		/**
 		 * Make sure that the i/o interrupt did not "overtake"
 		 * the last HZ timer interrupt.
 		 */
-		account_ticks(regs);
+		account_ticks();
 	/*
 	 * Get interrupt information from lowcore
 	 */
@@ -652,6 +655,7 @@ do_IRQ (struct pt_regs *regs)
 		 * out of the sie which costs more cycles than it saves.
 		 */
 	} while (!MACHINE_IS_VM && tpi (NULL) != 0);
+	set_irq_regs(old_regs);
 	irq_exit ();
 }
 
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index cd30f37..c5ccd20 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1062,7 +1062,7 @@ static int ap_poll_thread(void *data)
 	unsigned long flags;
 	int requests;
 
-	set_user_nice(current, -20);
+	set_user_nice(current, 19);
 	while (1) {
 		if (need_resched()) {
 			schedule();
diff --git a/drivers/s390/net/iucv.c b/drivers/s390/net/iucv.c
index 809dd8d..1476ce2 100644
--- a/drivers/s390/net/iucv.c
+++ b/drivers/s390/net/iucv.c
@@ -116,7 +116,7 @@ static DEFINE_SPINLOCK(iucv_irq_queue_lo
  *Internal function prototypes
  */
 static void iucv_tasklet_handler(unsigned long);
-static void iucv_irq_handler(struct pt_regs *, __u16);
+static void iucv_irq_handler(__u16);
 
 static DECLARE_TASKLET(iucv_tasklet,iucv_tasklet_handler,0);
 
@@ -2251,7 +2251,7 @@ iucv_sever(__u16 pathid, __u8 user_data[
  * Places the interrupt buffer on a queue and schedules iucv_tasklet_handler().
  */
 static void
-iucv_irq_handler(struct pt_regs *regs, __u16 code)
+iucv_irq_handler(__u16 code)
 {
 	iucv_irqdata *irqdata;
 
diff --git a/include/asm-s390/hardirq.h b/include/asm-s390/hardirq.h
index e84b7ef..c2f6a87 100644
--- a/include/asm-s390/hardirq.h
+++ b/include/asm-s390/hardirq.h
@@ -32,6 +32,6 @@ #define __ARCH_HAS_DO_SOFTIRQ
 
 #define HARDIRQ_BITS	8
 
-extern void account_ticks(struct pt_regs *);
+extern void account_ticks(void);
 
 #endif /* __ASM_HARDIRQ_H */
diff --git a/include/asm-s390/irq_regs.h b/include/asm-s390/irq_regs.h
new file mode 100644
index 0000000..3dd9c0b
--- /dev/null
+++ b/include/asm-s390/irq_regs.h
@@ -0,0 +1 @@
+#include <asm-generic/irq_regs.h>
diff --git a/include/asm-s390/s390_ext.h b/include/asm-s390/s390_ext.h
index e9a2862..df9b101 100644
--- a/include/asm-s390/s390_ext.h
+++ b/include/asm-s390/s390_ext.h
@@ -10,7 +10,7 @@ #define _S390_EXTINT_H
  *               Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 
-typedef void (*ext_int_handler_t)(struct pt_regs *regs, __u16 code);
+typedef void (*ext_int_handler_t)(__u16 code);
 
 /*
  * Warning: if you change ext_int_info_t you have to change the
