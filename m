Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbTAZLN5>; Sun, 26 Jan 2003 06:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266810AbTAZLN4>; Sun, 26 Jan 2003 06:13:56 -0500
Received: from packet.digeo.com ([12.110.80.53]:8331 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266809AbTAZLNv>;
	Sun, 26 Jan 2003 06:13:51 -0500
Date: Sun, 26 Jan 2003 03:23:01 -0800
From: Andrew Morton <akpm@digeo.com>
To: Anton Blanchard <anton@samba.org>
Cc: green@namesys.com, linux-kernel@vger.kernel.org, hch@lst.de, jack@suse.cz,
       mason@suse.com, shemminger@osdl.org
Subject: Re: ext2 FS corruption with 2.5.59.
Message-Id: <20030126032301.4e0f8dc9.akpm@digeo.com>
In-Reply-To: <20030126111108.GB25001@krispykreme>
References: <20030123153832.A860@namesys.com>
	<20030124023213.63d93156.akpm@digeo.com>
	<20030124153929.A894@namesys.com>
	<20030124225320.5d387993.akpm@digeo.com>
	<20030125153607.A10590@namesys.com>
	<20030125190410.7c91e640.akpm@digeo.com>
	<20030126111108.GB25001@krispykreme>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jan 2003 11:23:00.0084 (UTC) FILETIME=[48879340:01C2C52D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
>  
> Hi,
> 
> > +static inline void i_size_write(struct inode * inode, loff_t i_size)
> > +{
> > +#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
> > +#ifdef __ARCH_HAS_GET_SET_64BIT
> > +	set_64bit((unsigned long long *) &inode->i_size, (unsigned long long) i_size);
> > +#else
> > +	inode->i_size_version2++;
> > +	wmb();
> > +	inode->i_size = i_size;
> > +	wmb();
> > +	inode->i_size_version1++;
> > +	wmb(); /* make it visible ASAP */
> > +#endif
> > +#elif BITS_PER_LONG==64 || !defined(CONFIG_SMP)
> > +	inode->i_size = i_size;
> > +#endif
> > +}
> 
> That last wmb is suspect. We dont put an wmb after a spinlock to "make it
> visible". If you think of an wmb as an ordering tag that propagates out
> through the cpu and storage hierarchy then wmb is not going to help us here.

OK.

> I guess the store could get reordered (and so delayed) a bit, but an wmb
> is relatively expensive on some architectures.
> 
> > This is actually fairly pointless, because these fields are write-mostly and
> > read-rarely.  But we need a spinlock anyway because of the concurrent
> > modifiers problem.
> 
> It would be interesting to compare a spinlock or rwlock against a frlock
> in a write mostly situation. Actually isnt it going to be slower because
> we have to take a spinlock to serialise around the frlock write path?

A little bit, if it it very write-mostly.  But the gains on the read side
will compensate.

Here is Stephen's implementation:



 linux/frlock.h |  100 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 linux/time.h   |    3 +
 time.c         |   31 +++++++++--------
 timer.c        |   22 ++++++------
 4 files changed, 131 insertions(+), 25 deletions(-)

diff -puN /dev/null include/linux/frlock.h
--- /dev/null	2002-08-30 16:31:37.000000000 -0700
+++ linux-hype-akpm/include/linux/frlock.h	2003-01-25 18:35:14.000000000 -0800
@@ -0,0 +1,100 @@
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
+#define FR_LOCK_UNLOCKED	(frlock_t) { SPIN_LOCK_UNLOCKED, 0, 0 }
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
+	unsigned ret = rw->post_sequence;
+	rmb();
+	return ret;
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
diff -puN include/linux/time.h~frlock-xtime include/linux/time.h
--- linux-hype/include/linux/time.h~frlock-xtime	2003-01-25 18:11:45.000000000 -0800
+++ linux-hype-akpm/include/linux/time.h	2003-01-25 18:11:45.000000000 -0800
@@ -25,6 +25,7 @@ struct timezone {
 #ifdef __KERNEL__
 
 #include <linux/spinlock.h>
+#include <linux/frlock.h>
 
 /*
  * Change timeval to jiffies, trying to avoid the
@@ -120,7 +121,7 @@ mktime (unsigned int year, unsigned int 
 }
 
 extern struct timespec xtime;
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 
 static inline unsigned long get_seconds(void)
 { 
diff -puN kernel/time.c~frlock-xtime kernel/time.c
--- linux-hype/kernel/time.c~frlock-xtime	2003-01-25 18:11:45.000000000 -0800
+++ linux-hype-akpm/kernel/time.c	2003-01-25 18:11:45.000000000 -0800
@@ -27,7 +27,6 @@
 #include <linux/timex.h>
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
-
 #include <asm/uaccess.h>
 
 /* 
@@ -38,7 +37,7 @@ struct timezone sys_tz;
 
 /* The xtime_lock is not only serializing the xtime read/writes but it's also
    serializing all accesses to the global NTP variables now. */
-extern rwlock_t xtime_lock;
+extern frlock_t xtime_lock;
 extern unsigned long last_time_offset;
 
 #if !defined(__alpha__) && !defined(__ia64__)
@@ -80,7 +79,7 @@ asmlinkage long sys_stime(int * tptr)
 		return -EPERM;
 	if (get_user(value, tptr))
 		return -EFAULT;
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	xtime.tv_sec = value;
 	xtime.tv_nsec = 0;
 	last_time_offset = 0;
@@ -88,7 +87,7 @@ asmlinkage long sys_stime(int * tptr)
 	time_status |= STA_UNSYNC;
 	time_maxerror = NTP_PHASE_LIMIT;
 	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 	return 0;
 }
 
@@ -96,13 +95,13 @@ asmlinkage long sys_stime(int * tptr)
 
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
@@ -127,10 +126,10 @@ asmlinkage long sys_gettimeofday(struct 
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
@@ -235,7 +234,7 @@ int do_adjtimex(struct timex *txc)
 		    txc->tick > 1100000/USER_HZ)
 			return -EINVAL;
 
-	write_lock_irq(&xtime_lock);
+	fr_write_lock_irq(&xtime_lock);
 	result = time_state;	/* mostly `TIME_OK' */
 
 	/* Save for later - semantics of adjtime is to return old value */
@@ -386,7 +385,7 @@ leave:	if ((time_status & (STA_UNSYNC|ST
 	txc->errcnt	   = pps_errcnt;
 	txc->stbcnt	   = pps_stbcnt;
 	last_time_offset = 0;
-	write_unlock_irq(&xtime_lock);
+	fr_write_unlock_irq(&xtime_lock);
 	do_gettimeofday(&txc->time);
 	return(result);
 }
@@ -409,9 +408,13 @@ asmlinkage long sys_adjtimex(struct time
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
diff -puN kernel/timer.c~frlock-xtime kernel/timer.c
--- linux-hype/kernel/timer.c~frlock-xtime	2003-01-25 18:11:45.000000000 -0800
+++ linux-hype-akpm/kernel/timer.c	2003-01-25 18:11:45.000000000 -0800
@@ -758,7 +758,7 @@ unsigned long wall_jiffies;
  * This read-write spinlock protects us from races in SMP while
  * playing with xtime and avenrun.
  */
-rwlock_t xtime_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
+frlock_t xtime_lock __cacheline_aligned_in_smp = FR_LOCK_UNLOCKED;
 unsigned long last_time_offset;
 
 /*
@@ -798,8 +798,7 @@ static inline void update_times(void)
 }
   
 /*
- * The 64-bit jiffies value is not atomic - you MUST NOT read it
- * without holding read_lock_irq(&xtime_lock).
+ * The 64-bit jiffies value is not atomic 
  * jiffies is defined in the linker script...
  */
 
@@ -1087,18 +1086,21 @@ asmlinkage long sys_sysinfo(struct sysin
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

_

