Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318873AbSHLXf4>; Mon, 12 Aug 2002 19:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318876AbSHLXf4>; Mon, 12 Aug 2002 19:35:56 -0400
Received: from air-2.osdl.org ([65.172.181.6]:58895 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318873AbSHLXfr>;
	Mon, 12 Aug 2002 19:35:47 -0400
Subject: [PATCH] fast reader/writer lock for gettimeofday 2.5.30
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Aug 2002 16:39:37 -0700
Message-Id: <1029195577.1978.22.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch generalizes Andrea's trick of using sequence numbers
to create a reader region/writer lock. It against the 2.5.30 kernel.

A new composite primitive 'frlock' is defined in include/linux/frlock.h
and used to replace the rwlock xtime_lock enforce consistent access to
the clock time variables.

This should solve the DOS problem when applications spin wildly doing
gettimeofday (or reading sysinfo) and starve the clock tick from ever
getting a write lock on xtime_lock

There is no performance difference for normal loads, although since the
reader does no locking, it should be faster than normal reader locks

The same technique could be used for other rarely updated data that
needs atomic access. Like owner/group of an inode or 64 bit counters.

NOTE: this patch works for i386 only, cause that's what I could test.
Other architectures require trivial changes to time.c to change
xtime_lock from rwlock to frlock and to use a loop when reading.

diff -urN -X dontdiff linux-2.5/arch/i386/kernel/time.c linux-2.5.exp/arch/i386/kernel/time.c
--- linux-2.5/arch/i386/kernel/time.c	Mon Aug 12 10:17:59 2002
+++ linux-2.5.exp/arch/i386/kernel/time.c	Mon Aug 12 10:32:54 2002
@@ -43,6 +43,7 @@
 #include <linux/smp.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/frlock.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -81,7 +82,7 @@
  */
 unsigned long fast_gettimeoffset_quotient;
 
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern unsigned long wall_jiffies;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
@@ -269,19 +270,21 @@
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long flags;
+	unsigned long seq;
 	unsigned long usec, sec;
 
-	read_lock_irqsave(&xtime_lock, flags);
-	usec = do_gettimeoffset();
-	{
-		unsigned long lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * (1000000 / HZ);
-	}
-	sec = xtime.tv_sec;
-	usec += xtime.tv_usec;
-	read_unlock_irqrestore(&xtime_lock, flags);
+	do {
+		seq = fr_read_begin(&xtime_lock);
+		usec = do_gettimeoffset();
+		{
+			unsigned long lost = jiffies - wall_jiffies;
+			if (lost)
+				usec += lost * (1000000 / HZ);
+		}
+		
+		sec = xtime.tv_sec;
+		usec += xtime.tv_usec;
+	} while (seq != fr_read_end(&xtime_lock));
 
 	while (usec >= 1000000) {
 		usec -= 1000000;
@@ -294,7 +297,7 @@
 
 void do_settimeofday(struct timeval *tv)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	/*
 	 * This is revolting. We need to set "xtime" correctly. However, the
 	 * value in this location is the value at the most recent update of
@@ -314,7 +317,7 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 /*
@@ -480,7 +483,7 @@
 	 * the irq version of write_lock because as just said we have irq
 	 * locally disabled. -arca
 	 */
-	write_lock(&xtime_lock);
+	fr_write_lock(&xtime_lock);
 
 	if (use_tsc)
 	{
@@ -513,7 +516,7 @@
  
 	do_timer_interrupt(irq, NULL, regs);
 
-	write_unlock(&xtime_lock);
+	fr_write_unlock(&xtime_lock);
 
 }
 
diff -urN -X dontdiff linux-2.5/include/linux/frlock.h linux-2.5.exp/include/linux/frlock.h
--- linux-2.5/include/linux/frlock.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.exp/include/linux/frlock.h	Mon Aug 12 10:09:56 2002
@@ -0,0 +1,99 @@
+#ifndef __LINUX_FRLOCK_H
+#define __LINUX_FRLOCK_H
+
+/*
+ * Fast read-write spinlocks.
+ *
+ * Fast reader/writer locks without starving writers. This type of
+ * lock for data where the reader wants a consitent set of information
+ * and is willing to retry if the information changes.  Readers never
+ * block but they may have to retry if a writer is in
+ * progress. Writers do not wait for readers. 
+ *
+ * Generalization on sequence variables used for gettimeofday on x86-64 
+ * by Andrea Arcangeli
+ *
+ * This is not as cache friendly as brlock. Also, this will not work
+ * for data that contains pointers, because any writer could
+ * invalidate a pointer that a reader was following.
+ *
+ * 
+ * Expected reader usage:
+ * 	do {
+ *	    seq = fr_read_begin();
+ * 	...
+ *      } while (seq != fr_read_end());
+ *
+ * On non-SMP the spin locks disappear but the writer still needs
+ * to increment the sequence variables because an interrupt routine could
+ * change the state of the data.
+ */
+
+#include <linux/config.h>
+#include <linux/spinlock.h>
+
+typedef struct {
+	spinlock_t lock;
+	unsigned pre_sequence;
+	unsigned post_sequence;
+} frlock_t;
+
+#define FR_LOCK_UNLOCKED	{ SPIN_LOCK_UNLOCKED, 0, 0 }
+#define frlock_init(x)		do { *(x) = FR_LOCK_UNLOCKED; } while (0)
+
+static inline void fr_write_lock(frlock_t *rw)
+{
+	spin_lock(&rw->lock);
+	rw->pre_sequence++;
+	wmb();
+}	
+
+static inline void fr_write_unlock(frlock_t *rw) 
+{
+	wmb();
+	rw->post_sequence++;
+	spin_unlock(&rw->lock);
+}
+
+static inline int fr_write_trylock(frlock_t *rw)
+{
+	int ret  = spin_trylock(&rw->lock);
+
+	if (ret) {
+		++rw->pre_sequence;
+		wmb();
+	}
+	return ret;
+}
+
+static inline unsigned fr_read_begin(frlock_t *rw) 
+{
+	rmb();
+	return rw->post_sequence;
+	
+}
+
+static inline unsigned fr_read_end(frlock_t *rw)
+{
+	rmb();
+	return rw->pre_sequence;
+}
+
+/*
+ * Possible sw/hw IRQ protected versions of the interfaces.
+ */
+#define fr_write_lock_irqsave(lock, flags) \
+	do { local_irq_save(flags);	 fr_write_lock(lock); } while (0)
+#define fr_write_lock_irq(lock) \
+	do { local_irq_disable();	 fr_write_lock(lock); } while (0)
+#define fr_write_lock_bh(lock) \
+        do { local_bh_disable();	 fr_write_lock(lock); } while (0)
+
+#define fr_write_unlock_irqrestore(lock, flags)	\
+	do { fr_write_unlock(lock); local_irq_restore(flags); } while(0)
+#define fr_write_unlock_irq(lock) \
+	do { fr_write_unlock(lock); local_irq_enable(); } while(0)
+#define fr_write_unlock_bh(lock) \
+	do { fr_write_unlock(lock); local_bh_enable(); } while(0)
+
+#endif /* __LINUX_FRLOCK_H */
diff -urN -X dontdiff linux-2.5/kernel/time.c linux-2.5.exp/kernel/time.c
--- linux-2.5/kernel/time.c	Mon Aug 12 10:18:32 2002
+++ linux-2.5.exp/kernel/time.c	Mon Aug 12 10:07:28 2002
@@ -27,6 +27,7 @@
 #include <linux/timex.h>
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
+#include <linux/frlock.h>
 
 #include <asm/uaccess.h>
 
@@ -38,7 +39,7 @@
 
 /* The xtime_lock is not only serializing the xtime read/writes but it's also
    serializing all accesses to the global NTP variables now. */
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern unsigned long last_time_offset;
 
 #if !defined(__alpha__) && !defined(__ia64__)
@@ -80,7 +81,7 @@
 		return -EPERM;
 	if (get_user(value, tptr))
 		return -EFAULT;
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	xtime.tv_sec = value;
 	xtime.tv_usec = 0;
 	last_time_offset = 0;
@@ -88,7 +89,7 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 	return 0;
 }
 
@@ -127,10 +128,10 @@
  */
 inline static void warp_clock(void)
 {
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	xtime.tv_sec += sys_tz.tz_minuteswest * 60;
 	last_time_offset = 0;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 /*
@@ -234,7 +235,7 @@
 		if (txc->tick < 900000/HZ || txc->tick > 1100000/HZ)
 			return -EINVAL;
 
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	result = time_state;	/* mostly `TIME_OK' */
 
 	/* Save for later - semantics of adjtime is to return old value */
@@ -390,7 +391,7 @@
 	txc->errcnt	   = pps_errcnt;
 	txc->stbcnt	   = pps_stbcnt;
 	last_time_offset = 0;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 	do_gettimeofday(&txc->time);
 	return(result);
 }
diff -urN -X dontdiff linux-2.5/kernel/timer.c linux-2.5.exp/kernel/timer.c
--- linux-2.5/kernel/timer.c	Mon Aug 12 10:18:32 2002
+++ linux-2.5.exp/kernel/timer.c	Mon Aug 12 10:26:47 2002
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/tqueue.h>
 #include <linux/kernel_stat.h>
+#include <linux/frlock.h>
 
 #include <asm/uaccess.h>
 
@@ -633,7 +634,7 @@
  * This read-write spinlock protects us from races in SMP while
  * playing with xtime and avenrun.
  */
-rwlock_t xtime_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
+frlock_t xtime_lock __cacheline_aligned_in_smp = FR_LOCK_UNLOCKED;
 unsigned long last_time_offset;
 
 static inline void update_times(void)
@@ -645,7 +646,7 @@
 	 * just know that the irqs are locally enabled and so we don't
 	 * need to save/restore the flags of the local CPU here. -arca
 	 */
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 
 	ticks = jiffies - wall_jiffies;
 	if (ticks) {
@@ -654,7 +655,7 @@
 	}
 	last_time_offset = 0;
 	calc_load(ticks);
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 }
 
 void timer_bh(void)
@@ -922,20 +923,23 @@
 asmlinkage long sys_sysinfo(struct sysinfo *info)
 {
 	struct sysinfo val;
+	unsigned long seq;
 	unsigned long mem_total, sav_total;
 	unsigned int mem_unit, bitcount;
 
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
-	read_lock_irq(&xtime_lock);
-	val.uptime = jiffies / HZ;
+	do {
+		seq = fr_read_begin(&xtime_lock);
+
+		val.uptime = jiffies / HZ;
 
-	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
-	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
-	val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
+		val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
+		val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
+		val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
 
-	val.procs = nr_threads;
-	read_unlock_irq(&xtime_lock);
+		val.procs = nr_threads;
+	} while (seq != fr_read_end(&xtime_lock));
 
 	si_meminfo(&val);
 	si_swapinfo(&val);
@@ -980,7 +984,7 @@
 	val.totalhigh <<= bitcount;
 	val.freehigh <<= bitcount;
 
-out:
+ out:
 	if (copy_to_user(info, &val, sizeof(struct sysinfo)))
 		return -EFAULT;
 

