Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTA1XdY>; Tue, 28 Jan 2003 18:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTA1XdX>; Tue, 28 Jan 2003 18:33:23 -0500
Received: from air-2.osdl.org ([65.172.181.6]:14720 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261874AbTA1XdD>;
	Tue, 28 Jan 2003 18:33:03 -0500
Subject: [PATCH] (1/4) 2.5.59 fast reader/writer lock for gettimeofday
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-ryAw+BB6MTpl2SaQy4wG"
Organization: Open Source Devlopment Lab
Message-Id: <1043797341.10150.300.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Jan 2003 15:42:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ryAw+BB6MTpl2SaQy4wG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is the generic portion of lockless gettimeofday. It defines frlock
and changes locking of xtime_lock from rwlock to frlock.



--=-ryAw+BB6MTpl2SaQy4wG
Content-Disposition: attachment; filename=frlock-xtime.patch
Content-Type: text/x-patch; name=frlock-xtime.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN -X dontdiff linux-2.5.59/include/linux/frlock.h linux-2.5-frlock/include/linux/frlock.h
--- linux-2.5.59/include/linux/frlock.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.5-frlock/include/linux/frlock.h	2003-01-28 14:53:37.000000000 -0800
@@ -0,0 +1,124 @@
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
+#include <linux/preempt.h>
+
+typedef struct {
+	unsigned pre_sequence;
+	unsigned post_sequence;
+	spinlock_t lock;
+} frlock_t;
+
+#define FR_LOCK_UNLOCKED   { 0, 0, SPIN_LOCK_UNLOCKED }
+#define frlock_init(x)	   do { *(x) = (frlock_t) FR_LOCK_UNLOCKED; } while (0)
+
+/* Update sequence count only
+ * Assumes caller is doing own mutual exclusion with other lock
+ * or semaphore.
+ */
+static inline void fr_write_begin(frlock_t *rw)
+{
+	preempt_disable();
+	rw->pre_sequence++;
+	wmb();
+}
+
+static inline void fr_write_end(frlock_t *rw)
+{
+	wmb();
+	rw->post_sequence++;
+	BUG_ON(rw->post_sequence != rw->pre_sequence);
+	preempt_enable();
+}
+
+/* Lock out other writers and update the count.
+ * Acts like a normal spin_lock/unlock.
+ */
+static inline void fr_write_lock(frlock_t *rw)
+{
+	spin_lock(&rw->lock);
+	fr_write_begin(rw);
+}	
+
+static inline void fr_write_unlock(frlock_t *rw) 
+{
+	fr_write_end(rw);
+	spin_unlock(&rw->lock);
+}
+
+static inline int fr_write_trylock(frlock_t *rw)
+{
+	int ret = spin_trylock(&rw->lock);
+
+	if (ret) {
+		++rw->pre_sequence;
+		wmb();
+	}
+	return ret;
+}
+
+/* Start of read calculation -- fetch last complete writer token */
+static inline unsigned fr_read_begin(const frlock_t *rw) 
+{
+	unsigned ret;
+
+	ret = rw->post_sequence;
+	rmb();
+	return ret;
+	
+}
+
+/* End of reader calculation -- fetch last writer start token */
+static inline unsigned fr_read_end(const frlock_t *rw)
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
diff -urN -X dontdiff linux-2.5.59/include/linux/time.h linux-2.5-frlock/include/linux/time.h
--- linux-2.5.59/include/linux/time.h	2003-01-17 09:43:06.000000000 -0800
+++ linux-2.5-frlock/include/linux/time.h	2003-01-24 14:54:17.000000000 -0800
@@ -25,6 +25,7 @@
 #ifdef __KERNEL__
 
 #include <linux/spinlock.h>
+#include <linux/frlock.h>
 
 /*
  * Change timeval to jiffies, trying to avoid the
@@ -120,7 +121,7 @@
 }
 
 extern struct timespec xtime;
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 static inline unsigned long get_seconds(void)
 { 
diff -urN -X dontdiff linux-2.5.59/kernel/time.c linux-2.5-frlock/kernel/time.c
--- linux-2.5.59/kernel/time.c	2003-01-17 09:43:08.000000000 -0800
+++ linux-2.5-frlock/kernel/time.c	2003-01-24 15:05:53.000000000 -0800
@@ -27,7 +27,6 @@
 #include <linux/timex.h>
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
-
 #include <asm/uaccess.h>
 
 /* 
@@ -38,7 +37,7 @@
 
 /* The xtime_lock is not only serializing the xtime read/writes but it's also
    serializing all accesses to the global NTP variables now. */
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern unsigned long last_time_offset;
 
 #if !defined(__alpha__) && !defined(__ia64__)
@@ -80,7 +79,7 @@
 		return -EPERM;
 	if (get_user(value, tptr))
 		return -EFAULT;
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	xtime.tv_sec = value;
 	xtime.tv_nsec = 0;
 	last_time_offset = 0;
@@ -88,7 +87,7 @@
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 	return 0;
 }
 
@@ -96,13 +95,13 @@
 
 asmlinkage long sys_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
-	if (tv) {
+	if (likely(tv != NULL)) {
 		struct timeval ktv;
 		do_gettimeofday(&ktv);
 		if (copy_to_user(tv, &ktv, sizeof(ktv)))
 			return -EFAULT;
 	}
-	if (tz) {
+	if (unlikely(tz != NULL)) {
 		if (copy_to_user(tz, &sys_tz, sizeof(sys_tz)))
 			return -EFAULT;
 	}
@@ -127,10 +126,10 @@
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
@@ -235,7 +234,7 @@
 		    txc->tick > 1100000/USER_HZ)
 			return -EINVAL;
 
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	result = time_state;	/* mostly `TIME_OK' */
 
 	/* Save for later - semantics of adjtime is to return old value */
@@ -386,7 +385,7 @@
 	txc->errcnt	   = pps_errcnt;
 	txc->stbcnt	   = pps_stbcnt;
 	last_time_offset = 0;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 	do_gettimeofday(&txc->time);
 	return(result);
 }
@@ -409,9 +408,13 @@
 struct timespec current_kernel_time(void)
 {
         struct timespec now;
-        unsigned long flags;
-        read_lock_irqsave(&xtime_lock,flags);
-	now = xtime;
-        read_unlock_irqrestore(&xtime_lock,flags);
+        unsigned long seq;
+
+	do {
+		seq = fr_read_begin(&xtime_lock);
+		
+		now = xtime;
+	} while (seq != fr_read_end(&xtime_lock));
+
 	return now; 
 }
diff -urN -X dontdiff linux-2.5.59/kernel/timer.c linux-2.5-frlock/kernel/timer.c
--- linux-2.5.59/kernel/timer.c	2003-01-17 09:43:08.000000000 -0800
+++ linux-2.5-frlock/kernel/timer.c	2003-01-21 13:23:05.000000000 -0800
@@ -758,7 +758,7 @@
  * This read-write spinlock protects us from races in SMP while
  * playing with xtime and avenrun.
  */
-rwlock_t xtime_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
+frlock_t xtime_lock __cacheline_aligned_in_smp = FR_LOCK_UNLOCKED;
 unsigned long last_time_offset;
 
 /*
@@ -798,8 +798,7 @@
 }
   
 /*
- * The 64-bit jiffies value is not atomic - you MUST NOT read it
- * without holding read_lock_irq(&xtime_lock).
+ * The 64-bit jiffies value is not atomic 
  * jiffies is defined in the linker script...
  */
 
@@ -1087,18 +1086,21 @@
 	struct sysinfo val;
 	unsigned long mem_total, sav_total;
 	unsigned int mem_unit, bitcount;
+	unsigned long seq;
 
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
-	read_lock_irq(&xtime_lock);
-	val.uptime = jiffies / HZ;
+	do {
+		seq = fr_read_begin(&xtime_lock);
 
-	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
-	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
-	val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
+		val.uptime = jiffies / HZ;
 
-	val.procs = nr_threads;
-	read_unlock_irq(&xtime_lock);
+		val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
+		val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
+		val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
+
+		val.procs = nr_threads;
+	} while (seq != fr_read_end(&xtime_lock));
 
 	si_meminfo(&val);
 	si_swapinfo(&val);

--=-ryAw+BB6MTpl2SaQy4wG--

