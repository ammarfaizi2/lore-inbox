Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267849AbUHESJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267849AbUHESJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267842AbUHESJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:09:37 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:745 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S267859AbUHESEh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:04:37 -0400
Date: Thu, 5 Aug 2004 20:04:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, linux-390@vm.marist.edu
Cc: arjanv@redhat.com, tim.bird@am.sony.com, mulix@mulix.org, alan@redhat.com,
       crisw@osdl.org, jan.glauber@de.ibm.com
Subject: [PATCH] cputime (3/6): move jiffies stuff to jiffies.h
Message-ID: <20040805180438.GD9240@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] cputime (3/6): move jiffies stuff to jiffies.h

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Move all that lovely jiffies related functions into ONE file,
include/linux/jiffies.h. Since times.h is almost empty after the
jiffies conversion functions have been moved, move the remaining
definition of struct tms to include/linux/time.h. Replace all
includes of <linux/times.h> with <linux/time.h> and kill times.h.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/ia64/ia32/sys_ia32.c         |    2 
 arch/mips/kernel/linux32.c        |    1 
 arch/mips/kernel/sysirix.c        |    1 
 arch/parisc/kernel/sys_parisc32.c |    1 
 arch/ppc64/kernel/sys_ppc32.c     |    2 
 arch/s390/kernel/compat_linux.c   |    2 
 arch/sparc64/kernel/sys_sparc32.c |    2 
 arch/x86_64/ia32/sys_ia32.c       |    2 
 drivers/block/scsi_ioctl.c        |    2 
 drivers/cdrom/cdrom.c             |    2 
 fs/proc/array.c                   |    1 
 fs/proc/proc_misc.c               |    1 
 include/linux/jiffies.h           |  291 ++++++++++++++++++++++++++++++++++++++
 include/linux/time.h              |  261 +---------------------------------
 include/linux/times.h             |   65 --------
 kernel/acct.c                     |    2 
 kernel/sys.c                      |    2 
 kernel/sysctl.c                   |    2 
 net/bridge/br_fdb.c               |    2 
 net/bridge/br_ioctl.c             |    2 
 net/bridge/br_stp_timer.c         |    2 
 net/bridge/br_sysfs_br.c          |    2 
 net/core/neighbour.c              |    2 
 net/decnet/dn_route.c             |    2 
 net/ipv4/igmp.c                   |    2 
 net/ipv4/route.c                  |    2 
 net/ipv4/tcp_ipv4.c               |    2 
 net/ipv6/mcast.c                  |    2 
 net/ipv6/route.c                  |    2 
 net/ipv6/tcp_ipv6.c               |    2 
 30 files changed, 324 insertions(+), 342 deletions(-)

diff -urN linux-2.6.8-rc3/arch/ia64/ia32/sys_ia32.c linux-2.6.8-s390/arch/ia64/ia32/sys_ia32.c
--- linux-2.6.8-rc3/arch/ia64/ia32/sys_ia32.c	Thu Aug  5 18:39:49 2004
+++ linux-2.6.8-s390/arch/ia64/ia32/sys_ia32.c	Thu Aug  5 18:40:23 2004
@@ -23,7 +23,7 @@
 #include <linux/file.h>
 #include <linux/signal.h>
 #include <linux/resource.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <linux/utsname.h>
 #include <linux/timex.h>
 #include <linux/smp.h>
diff -urN linux-2.6.8-rc3/arch/mips/kernel/linux32.c linux-2.6.8-s390/arch/mips/kernel/linux32.c
--- linux-2.6.8-rc3/arch/mips/kernel/linux32.c	Wed Jun 16 07:19:37 2004
+++ linux-2.6.8-s390/arch/mips/kernel/linux32.c	Thu Aug  5 18:40:23 2004
@@ -16,7 +16,6 @@
 #include <linux/resource.h>
 #include <linux/highmem.h>
 #include <linux/time.h>
-#include <linux/times.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/skbuff.h>
diff -urN linux-2.6.8-rc3/arch/mips/kernel/sysirix.c linux-2.6.8-s390/arch/mips/kernel/sysirix.c
--- linux-2.6.8-rc3/arch/mips/kernel/sysirix.c	Thu Aug  5 18:39:49 2004
+++ linux-2.6.8-s390/arch/mips/kernel/sysirix.c	Thu Aug  5 18:40:23 2004
@@ -17,7 +17,6 @@
 #include <linux/errno.h>
 #include <linux/time.h>
 #include <linux/timex.h>
-#include <linux/times.h>
 #include <linux/elf.h>
 #include <linux/msg.h>
 #include <linux/shm.h>
diff -urN linux-2.6.8-rc3/arch/parisc/kernel/sys_parisc32.c linux-2.6.8-s390/arch/parisc/kernel/sys_parisc32.c
--- linux-2.6.8-rc3/arch/parisc/kernel/sys_parisc32.c	Wed Jun 16 07:19:11 2004
+++ linux-2.6.8-s390/arch/parisc/kernel/sys_parisc32.c	Thu Aug  5 18:40:23 2004
@@ -18,7 +18,6 @@
 #include <linux/file.h> 
 #include <linux/signal.h>
 #include <linux/resource.h>
-#include <linux/times.h>
 #include <linux/utsname.h>
 #include <linux/time.h>
 #include <linux/timex.h>
diff -urN linux-2.6.8-rc3/arch/ppc64/kernel/sys_ppc32.c linux-2.6.8-s390/arch/ppc64/kernel/sys_ppc32.c
--- linux-2.6.8-rc3/arch/ppc64/kernel/sys_ppc32.c	Thu Aug  5 18:39:50 2004
+++ linux-2.6.8-s390/arch/ppc64/kernel/sys_ppc32.c	Thu Aug  5 18:40:23 2004
@@ -22,7 +22,7 @@
 #include <linux/file.h> 
 #include <linux/signal.h>
 #include <linux/resource.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <linux/utsname.h>
 #include <linux/timex.h>
 #include <linux/smp.h>
diff -urN linux-2.6.8-rc3/arch/s390/kernel/compat_linux.c linux-2.6.8-s390/arch/s390/kernel/compat_linux.c
--- linux-2.6.8-rc3/arch/s390/kernel/compat_linux.c	Wed Jun 16 07:19:51 2004
+++ linux-2.6.8-s390/arch/s390/kernel/compat_linux.c	Thu Aug  5 18:40:23 2004
@@ -24,7 +24,7 @@
 #include <linux/file.h> 
 #include <linux/signal.h>
 #include <linux/resource.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <linux/utsname.h>
 #include <linux/timex.h>
 #include <linux/smp.h>
diff -urN linux-2.6.8-rc3/arch/sparc64/kernel/sys_sparc32.c linux-2.6.8-s390/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.6.8-rc3/arch/sparc64/kernel/sys_sparc32.c	Thu Aug  5 18:39:51 2004
+++ linux-2.6.8-s390/arch/sparc64/kernel/sys_sparc32.c	Thu Aug  5 18:40:23 2004
@@ -16,7 +16,7 @@
 #include <linux/file.h> 
 #include <linux/signal.h>
 #include <linux/resource.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <linux/utsname.h>
 #include <linux/timex.h>
 #include <linux/smp.h>
diff -urN linux-2.6.8-rc3/arch/x86_64/ia32/sys_ia32.c linux-2.6.8-s390/arch/x86_64/ia32/sys_ia32.c
--- linux-2.6.8-rc3/arch/x86_64/ia32/sys_ia32.c	Thu Aug  5 18:39:51 2004
+++ linux-2.6.8-s390/arch/x86_64/ia32/sys_ia32.c	Thu Aug  5 18:40:23 2004
@@ -28,7 +28,7 @@
 #include <linux/signal.h>
 #include <linux/syscalls.h>
 #include <linux/resource.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <linux/utsname.h>
 #include <linux/timex.h>
 #include <linux/smp.h>
diff -urN linux-2.6.8-rc3/drivers/block/scsi_ioctl.c linux-2.6.8-s390/drivers/block/scsi_ioctl.c
--- linux-2.6.8-rc3/drivers/block/scsi_ioctl.c	Thu Aug  5 18:39:52 2004
+++ linux-2.6.8-s390/drivers/block/scsi_ioctl.c	Thu Aug  5 18:40:23 2004
@@ -24,7 +24,7 @@
 #include <linux/completion.h>
 #include <linux/cdrom.h>
 #include <linux/slab.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <asm/uaccess.h>
 
 #include <scsi/scsi.h>
diff -urN linux-2.6.8-rc3/drivers/cdrom/cdrom.c linux-2.6.8-s390/drivers/cdrom/cdrom.c
--- linux-2.6.8-rc3/drivers/cdrom/cdrom.c	Thu Aug  5 18:39:52 2004
+++ linux-2.6.8-s390/drivers/cdrom/cdrom.c	Thu Aug  5 18:40:23 2004
@@ -274,7 +274,7 @@
 #include <linux/init.h>
 #include <linux/fcntl.h>
 #include <linux/blkdev.h>
-#include <linux/times.h>
+#include <linux/time.h>
 
 #include <asm/uaccess.h>
 
diff -urN linux-2.6.8-rc3/fs/proc/array.c linux-2.6.8-s390/fs/proc/array.c
--- linux-2.6.8-rc3/fs/proc/array.c	Wed Jun 16 07:19:36 2004
+++ linux-2.6.8-s390/fs/proc/array.c	Thu Aug  5 18:40:23 2004
@@ -72,7 +72,6 @@
 #include <linux/signal.h>
 #include <linux/highmem.h>
 #include <linux/file.h>
-#include <linux/times.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -urN linux-2.6.8-rc3/fs/proc/proc_misc.c linux-2.6.8-s390/fs/proc/proc_misc.c
--- linux-2.6.8-rc3/fs/proc/proc_misc.c	Thu Aug  5 18:40:01 2004
+++ linux-2.6.8-s390/fs/proc/proc_misc.c	Thu Aug  5 18:40:23 2004
@@ -37,7 +37,6 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
-#include <linux/times.h>
 #include <linux/profile.h>
 #include <linux/blkdev.h>
 #include <linux/hugetlb.h>
diff -urN linux-2.6.8-rc3/include/linux/jiffies.h linux-2.6.8-s390/include/linux/jiffies.h
--- linux-2.6.8-rc3/include/linux/jiffies.h	Wed Jun 16 07:18:53 2004
+++ linux-2.6.8-s390/include/linux/jiffies.h	Thu Aug  5 18:40:23 2004
@@ -5,8 +5,17 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>
+#include <linux/time.h>
 #include <asm/system.h>
 #include <asm/param.h>			/* for HZ */
+#include <asm/div64.h>
+
+#ifndef div_long_long_rem
+#define div_long_long_rem(dividend,divisor,remainder) ({ \
+		       u64 result = dividend;		\
+		       *remainder = do_div(result,divisor); \
+		       result; })
+#endif
 
 /*
  * The 64-bit value is not volatile - you MUST NOT read it
@@ -50,4 +59,286 @@
 	 ((long)(a) - (long)(b) >= 0))
 #define time_before_eq(a,b)	time_after_eq(b,a)
 
+/*
+ * Have the 32 bit jiffies value wrap 5 minutes after boot
+ * so jiffies wrap bugs show up earlier.
+ */
+#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
+
+/*
+ * Change timeval to jiffies, trying to avoid the
+ * most obvious overflows..
+ *
+ * And some not so obvious.
+ *
+ * Note that we don't want to return MAX_LONG, because
+ * for various timeout reasons we often end up having
+ * to wait "jiffies+1" in order to guarantee that we wait
+ * at _least_ "jiffies" - so "jiffies+1" had better still
+ * be positive.
+ */
+#define MAX_JIFFY_OFFSET ((~0UL >> 1)-1)
+
+/*
+ * We want to do realistic conversions of time so we need to use the same
+ * values the update wall clock code uses as the jiffies size.  This value
+ * is: TICK_NSEC (which is defined in timex.h).  This
+ * is a constant and is in nanoseconds.  We will used scaled math
+ * with a set of scales defined here as SEC_JIFFIE_SC,  USEC_JIFFIE_SC and
+ * NSEC_JIFFIE_SC.  Note that these defines contain nothing but
+ * constants and so are computed at compile time.  SHIFT_HZ (computed in
+ * timex.h) adjusts the scaling for different HZ values.
+
+ * Scaled math???  What is that?
+ *
+ * Scaled math is a way to do integer math on values that would,
+ * otherwise, either overflow, underflow, or cause undesired div
+ * instructions to appear in the execution path.  In short, we "scale"
+ * up the operands so they take more bits (more precision, less
+ * underflow), do the desired operation and then "scale" the result back
+ * by the same amount.  If we do the scaling by shifting we avoid the
+ * costly mpy and the dastardly div instructions.
+
+ * Suppose, for example, we want to convert from seconds to jiffies
+ * where jiffies is defined in nanoseconds as NSEC_PER_JIFFIE.  The
+ * simple math is: jiff = (sec * NSEC_PER_SEC) / NSEC_PER_JIFFIE; We
+ * observe that (NSEC_PER_SEC / NSEC_PER_JIFFIE) is a constant which we
+ * might calculate at compile time, however, the result will only have
+ * about 3-4 bits of precision (less for smaller values of HZ).
+ *
+ * So, we scale as follows:
+ * jiff = (sec) * (NSEC_PER_SEC / NSEC_PER_JIFFIE);
+ * jiff = ((sec) * ((NSEC_PER_SEC * SCALE)/ NSEC_PER_JIFFIE)) / SCALE;
+ * Then we make SCALE a power of two so:
+ * jiff = ((sec) * ((NSEC_PER_SEC << SCALE)/ NSEC_PER_JIFFIE)) >> SCALE;
+ * Now we define:
+ * #define SEC_CONV = ((NSEC_PER_SEC << SCALE)/ NSEC_PER_JIFFIE))
+ * jiff = (sec * SEC_CONV) >> SCALE;
+ *
+ * Often the math we use will expand beyond 32-bits so we tell C how to
+ * do this and pass the 64-bit result of the mpy through the ">> SCALE"
+ * which should take the result back to 32-bits.  We want this expansion
+ * to capture as much precision as possible.  At the same time we don't
+ * want to overflow so we pick the SCALE to avoid this.  In this file,
+ * that means using a different scale for each range of HZ values (as
+ * defined in timex.h).
+ *
+ * For those who want to know, gcc will give a 64-bit result from a "*"
+ * operator if the result is a long long AND at least one of the
+ * operands is cast to long long (usually just prior to the "*" so as
+ * not to confuse it into thinking it really has a 64-bit operand,
+ * which, buy the way, it can do, but it take more code and at least 2
+ * mpys).
+
+ * We also need to be aware that one second in nanoseconds is only a
+ * couple of bits away from overflowing a 32-bit word, so we MUST use
+ * 64-bits to get the full range time in nanoseconds.
+
+ */
+
+/*
+ * Here are the scales we will use.  One for seconds, nanoseconds and
+ * microseconds.
+ *
+ * Within the limits of cpp we do a rough cut at the SEC_JIFFIE_SC and
+ * check if the sign bit is set.  If not, we bump the shift count by 1.
+ * (Gets an extra bit of precision where we can use it.)
+ * We know it is set for HZ = 1024 and HZ = 100 not for 1000.
+ * Haven't tested others.
+
+ * Limits of cpp (for #if expressions) only long (no long long), but
+ * then we only need the most signicant bit.
+ */
+
+#define SEC_JIFFIE_SC (31 - SHIFT_HZ)
+#if !((((NSEC_PER_SEC << 2) / TICK_NSEC) << (SEC_JIFFIE_SC - 2)) & 0x80000000)
+#undef SEC_JIFFIE_SC
+#define SEC_JIFFIE_SC (32 - SHIFT_HZ)
+#endif
+#define NSEC_JIFFIE_SC (SEC_JIFFIE_SC + 29)
+#define USEC_JIFFIE_SC (SEC_JIFFIE_SC + 19)
+#define SEC_CONVERSION ((unsigned long)((((u64)NSEC_PER_SEC << SEC_JIFFIE_SC) +\
+                                TICK_NSEC -1) / (u64)TICK_NSEC))
+
+#define NSEC_CONVERSION ((unsigned long)((((u64)1 << NSEC_JIFFIE_SC) +\
+                                        TICK_NSEC -1) / (u64)TICK_NSEC))
+#define USEC_CONVERSION  \
+                    ((unsigned long)((((u64)NSEC_PER_USEC << USEC_JIFFIE_SC) +\
+                                        TICK_NSEC -1) / (u64)TICK_NSEC))
+/*
+ * USEC_ROUND is used in the timeval to jiffie conversion.  See there
+ * for more details.  It is the scaled resolution rounding value.  Note
+ * that it is a 64-bit value.  Since, when it is applied, we are already
+ * in jiffies (albit scaled), it is nothing but the bits we will shift
+ * off.
+ */
+#define USEC_ROUND (u64)(((u64)1 << USEC_JIFFIE_SC) - 1)
+/*
+ * The maximum jiffie value is (MAX_INT >> 1).  Here we translate that
+ * into seconds.  The 64-bit case will overflow if we are not careful,
+ * so use the messy SH_DIV macro to do it.  Still all constants.
+ */
+#if BITS_PER_LONG < 64
+# define MAX_SEC_IN_JIFFIES \
+	(long)((u64)((u64)MAX_JIFFY_OFFSET * TICK_NSEC) / NSEC_PER_SEC)
+#else	/* take care of overflow on 64 bits machines */
+# define MAX_SEC_IN_JIFFIES \
+	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 1) - 1)
+
+#endif
+
+/*
+ * Convert jiffies to milliseconds and back.
+ *
+ * Avoid unnecessary multiplications/divisions in the
+ * two most common HZ cases:
+ */
+static inline unsigned int jiffies_to_msecs(const unsigned long j)
+{
+#if HZ <= 1000 && !(1000 % HZ)
+	return (1000 / HZ) * j;
+#elif HZ > 1000 && !(HZ % 1000)
+	return (j + (HZ / 1000) - 1)/(HZ / 1000);
+#else
+	return (j * 1000) / HZ;
+#endif
+}
+static inline unsigned long msecs_to_jiffies(const unsigned int m)
+{
+#if HZ <= 1000 && !(1000 % HZ)
+	return (m + (1000 / HZ) - 1) / (1000 / HZ);
+#elif HZ > 1000 && !(HZ % 1000)
+	return m * (HZ / 1000);
+#else
+	return (m * HZ + 999) / 1000;
+#endif
+}
+
+/*
+ * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
+ * that a remainder subtract here would not do the right thing as the
+ * resolution values don't fall on second boundries.  I.e. the line:
+ * nsec -= nsec % TICK_NSEC; is NOT a correct resolution rounding.
+ *
+ * Rather, we just shift the bits off the right.
+ *
+ * The >> (NSEC_JIFFIE_SC - SEC_JIFFIE_SC) converts the scaled nsec
+ * value to a scaled second value.
+ */
+static __inline__ unsigned long
+timespec_to_jiffies(const struct timespec *value)
+{
+	unsigned long sec = value->tv_sec;
+	long nsec = value->tv_nsec + TICK_NSEC - 1;
+
+	if (sec >= MAX_SEC_IN_JIFFIES){
+		sec = MAX_SEC_IN_JIFFIES;
+		nsec = 0;
+	}
+	return (((u64)sec * SEC_CONVERSION) +
+		(((u64)nsec * NSEC_CONVERSION) >>
+		 (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
+
+}
+
+static __inline__ void
+jiffies_to_timespec(const unsigned long jiffies, struct timespec *value)
+{
+	/*
+	 * Convert jiffies to nanoseconds and separate with
+	 * one divide.
+	 */
+	u64 nsec = (u64)jiffies * TICK_NSEC; 
+	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
+}
+
+/* Same for "timeval"
+ *
+ * Well, almost.  The problem here is that the real system resolution is
+ * in nanoseconds and the value being converted is in micro seconds.
+ * Also for some machines (those that use HZ = 1024, in-particular),
+ * there is a LARGE error in the tick size in microseconds.
+
+ * The solution we use is to do the rounding AFTER we convert the
+ * microsecond part.  Thus the USEC_ROUND, the bits to be shifted off.
+ * Instruction wise, this should cost only an additional add with carry
+ * instruction above the way it was done above.
+ */
+static __inline__ unsigned long
+timeval_to_jiffies(const struct timeval *value)
+{
+	unsigned long sec = value->tv_sec;
+	long usec = value->tv_usec;
+
+	if (sec >= MAX_SEC_IN_JIFFIES){
+		sec = MAX_SEC_IN_JIFFIES;
+		usec = 0;
+	}
+	return (((u64)sec * SEC_CONVERSION) +
+		(((u64)usec * USEC_CONVERSION + USEC_ROUND) >>
+		 (USEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
+}
+
+static __inline__ void
+jiffies_to_timeval(const unsigned long jiffies, struct timeval *value)
+{
+	/*
+	 * Convert jiffies to nanoseconds and separate with
+	 * one divide.
+	 */
+	u64 nsec = (u64)jiffies * TICK_NSEC; 
+	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_usec);
+	value->tv_usec /= NSEC_PER_USEC;
+}
+
+/*
+ * Convert jiffies/jiffies_64 to clock_t and back.
+ */
+static inline clock_t jiffies_to_clock_t(long x)
+{
+#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
+	return x / (HZ / USER_HZ);
+#else
+	u64 tmp = (u64)x * TICK_NSEC;
+	do_div(tmp, (NSEC_PER_SEC / USER_HZ));
+	return (long)tmp;
+#endif
+}
+
+static inline unsigned long clock_t_to_jiffies(unsigned long x)
+{
+#if (HZ % USER_HZ)==0
+	if (x >= ~0UL / (HZ / USER_HZ))
+		return ~0UL;
+	return x * (HZ / USER_HZ);
+#else
+	u64 jif;
+
+	/* Don't worry about loss of precision here .. */
+	if (x >= ~0UL / HZ * USER_HZ)
+		return ~0UL;
+
+	/* .. but do try to contain it here */
+	jif = x * (u64) HZ;
+	do_div(jif, USER_HZ);
+	return jif;
+#endif
+}
+
+static inline u64 jiffies_64_to_clock_t(u64 x)
+{
+#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
+	do_div(x, HZ / USER_HZ);
+#else
+	/*
+	 * There are better ways that don't overflow early,
+	 * but even this doesn't overflow in hundreds of years
+	 * in 64 bits, so..
+	 */
+	x *= TICK_NSEC;
+	do_div(x, (NSEC_PER_SEC / USER_HZ));
+#endif
+	return x;
+}
+
 #endif
diff -urN linux-2.6.8-rc3/include/linux/time.h linux-2.6.8-s390/include/linux/time.h
--- linux-2.6.8-rc3/include/linux/time.h	Wed Jun 16 07:19:37 2004
+++ linux-2.6.8-s390/include/linux/time.h	Thu Aug  5 18:40:23 2004
@@ -4,13 +4,10 @@
 #include <asm/param.h>
 #include <linux/types.h>
 
-#ifndef _STRUCT_TIMESPEC
-#define _STRUCT_TIMESPEC
 struct timespec {
 	time_t	tv_sec;		/* seconds */
 	long	tv_nsec;	/* nanoseconds */
 };
-#endif /* _STRUCT_TIMESPEC */
 
 struct timeval {
 	time_t		tv_sec;		/* seconds */
@@ -22,40 +19,18 @@
 	int	tz_dsttime;	/* type of dst correction */
 };
 
+struct tms {
+	clock_t tms_utime;
+	clock_t tms_stime;
+	clock_t tms_cutime;
+	clock_t tms_cstime;
+};
+
 #ifdef __KERNEL__
 
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>
 #include <linux/timex.h>
-#include <asm/div64.h>
-#ifndef div_long_long_rem
-
-#define div_long_long_rem(dividend,divisor,remainder) ({ \
-		       u64 result = dividend;		\
-		       *remainder = do_div(result,divisor); \
-		       result; })
-
-#endif
-
-/*
- * Have the 32 bit jiffies value wrap 5 minutes after boot
- * so jiffies wrap bugs show up earlier.
- */
-#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
-
-/*
- * Change timeval to jiffies, trying to avoid the
- * most obvious overflows..
- *
- * And some not so obvious.
- *
- * Note that we don't want to return MAX_LONG, because
- * for various timeout reasons we often end up having
- * to wait "jiffies+1" in order to guarantee that we wait
- * at _least_ "jiffies" - so "jiffies+1" had better still
- * be positive.
- */
-#define MAX_JIFFY_OFFSET ((~0UL >> 1)-1)
 
 /* Parameters used to convert the timespec values */
 #ifndef USEC_PER_SEC
@@ -70,218 +45,6 @@
 #define NSEC_PER_USEC (1000L)
 #endif
 
-/*
- * We want to do realistic conversions of time so we need to use the same
- * values the update wall clock code uses as the jiffies size.  This value
- * is: TICK_NSEC (which is defined in timex.h).  This
- * is a constant and is in nanoseconds.  We will used scaled math
- * with a set of scales defined here as SEC_JIFFIE_SC,  USEC_JIFFIE_SC and
- * NSEC_JIFFIE_SC.  Note that these defines contain nothing but
- * constants and so are computed at compile time.  SHIFT_HZ (computed in
- * timex.h) adjusts the scaling for different HZ values.
-
- * Scaled math???  What is that?
- *
- * Scaled math is a way to do integer math on values that would,
- * otherwise, either overflow, underflow, or cause undesired div
- * instructions to appear in the execution path.  In short, we "scale"
- * up the operands so they take more bits (more precision, less
- * underflow), do the desired operation and then "scale" the result back
- * by the same amount.  If we do the scaling by shifting we avoid the
- * costly mpy and the dastardly div instructions.
-
- * Suppose, for example, we want to convert from seconds to jiffies
- * where jiffies is defined in nanoseconds as NSEC_PER_JIFFIE.  The
- * simple math is: jiff = (sec * NSEC_PER_SEC) / NSEC_PER_JIFFIE; We
- * observe that (NSEC_PER_SEC / NSEC_PER_JIFFIE) is a constant which we
- * might calculate at compile time, however, the result will only have
- * about 3-4 bits of precision (less for smaller values of HZ).
- *
- * So, we scale as follows:
- * jiff = (sec) * (NSEC_PER_SEC / NSEC_PER_JIFFIE);
- * jiff = ((sec) * ((NSEC_PER_SEC * SCALE)/ NSEC_PER_JIFFIE)) / SCALE;
- * Then we make SCALE a power of two so:
- * jiff = ((sec) * ((NSEC_PER_SEC << SCALE)/ NSEC_PER_JIFFIE)) >> SCALE;
- * Now we define:
- * #define SEC_CONV = ((NSEC_PER_SEC << SCALE)/ NSEC_PER_JIFFIE))
- * jiff = (sec * SEC_CONV) >> SCALE;
- *
- * Often the math we use will expand beyond 32-bits so we tell C how to
- * do this and pass the 64-bit result of the mpy through the ">> SCALE"
- * which should take the result back to 32-bits.  We want this expansion
- * to capture as much precision as possible.  At the same time we don't
- * want to overflow so we pick the SCALE to avoid this.  In this file,
- * that means using a different scale for each range of HZ values (as
- * defined in timex.h).
- *
- * For those who want to know, gcc will give a 64-bit result from a "*"
- * operator if the result is a long long AND at least one of the
- * operands is cast to long long (usually just prior to the "*" so as
- * not to confuse it into thinking it really has a 64-bit operand,
- * which, buy the way, it can do, but it take more code and at least 2
- * mpys).
-
- * We also need to be aware that one second in nanoseconds is only a
- * couple of bits away from overflowing a 32-bit word, so we MUST use
- * 64-bits to get the full range time in nanoseconds.
-
- */
-
-/*
- * Here are the scales we will use.  One for seconds, nanoseconds and
- * microseconds.
- *
- * Within the limits of cpp we do a rough cut at the SEC_JIFFIE_SC and
- * check if the sign bit is set.  If not, we bump the shift count by 1.
- * (Gets an extra bit of precision where we can use it.)
- * We know it is set for HZ = 1024 and HZ = 100 not for 1000.
- * Haven't tested others.
-
- * Limits of cpp (for #if expressions) only long (no long long), but
- * then we only need the most signicant bit.
- */
-
-#define SEC_JIFFIE_SC (31 - SHIFT_HZ)
-#if !((((NSEC_PER_SEC << 2) / TICK_NSEC) << (SEC_JIFFIE_SC - 2)) & 0x80000000)
-#undef SEC_JIFFIE_SC
-#define SEC_JIFFIE_SC (32 - SHIFT_HZ)
-#endif
-#define NSEC_JIFFIE_SC (SEC_JIFFIE_SC + 29)
-#define USEC_JIFFIE_SC (SEC_JIFFIE_SC + 19)
-#define SEC_CONVERSION ((unsigned long)((((u64)NSEC_PER_SEC << SEC_JIFFIE_SC) +\
-                                TICK_NSEC -1) / (u64)TICK_NSEC))
-
-#define NSEC_CONVERSION ((unsigned long)((((u64)1 << NSEC_JIFFIE_SC) +\
-                                        TICK_NSEC -1) / (u64)TICK_NSEC))
-#define USEC_CONVERSION  \
-                    ((unsigned long)((((u64)NSEC_PER_USEC << USEC_JIFFIE_SC) +\
-                                        TICK_NSEC -1) / (u64)TICK_NSEC))
-/*
- * USEC_ROUND is used in the timeval to jiffie conversion.  See there
- * for more details.  It is the scaled resolution rounding value.  Note
- * that it is a 64-bit value.  Since, when it is applied, we are already
- * in jiffies (albit scaled), it is nothing but the bits we will shift
- * off.
- */
-#define USEC_ROUND (u64)(((u64)1 << USEC_JIFFIE_SC) - 1)
-/*
- * The maximum jiffie value is (MAX_INT >> 1).  Here we translate that
- * into seconds.  The 64-bit case will overflow if we are not careful,
- * so use the messy SH_DIV macro to do it.  Still all constants.
- */
-#if BITS_PER_LONG < 64
-# define MAX_SEC_IN_JIFFIES \
-	(long)((u64)((u64)MAX_JIFFY_OFFSET * TICK_NSEC) / NSEC_PER_SEC)
-#else	/* take care of overflow on 64 bits machines */
-# define MAX_SEC_IN_JIFFIES \
-	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 1) - 1)
-
-#endif
-
-/*
- * Convert jiffies to milliseconds and back.
- *
- * Avoid unnecessary multiplications/divisions in the
- * two most common HZ cases:
- */
-static inline unsigned int jiffies_to_msecs(const unsigned long j)
-{
-#if HZ <= 1000 && !(1000 % HZ)
-	return (1000 / HZ) * j;
-#elif HZ > 1000 && !(HZ % 1000)
-	return (j + (HZ / 1000) - 1)/(HZ / 1000);
-#else
-	return (j * 1000) / HZ;
-#endif
-}
-static inline unsigned long msecs_to_jiffies(const unsigned int m)
-{
-#if HZ <= 1000 && !(1000 % HZ)
-	return (m + (1000 / HZ) - 1) / (1000 / HZ);
-#elif HZ > 1000 && !(HZ % 1000)
-	return m * (HZ / 1000);
-#else
-	return (m * HZ + 999) / 1000;
-#endif
-}
-
-/*
- * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
- * that a remainder subtract here would not do the right thing as the
- * resolution values don't fall on second boundries.  I.e. the line:
- * nsec -= nsec % TICK_NSEC; is NOT a correct resolution rounding.
- *
- * Rather, we just shift the bits off the right.
- *
- * The >> (NSEC_JIFFIE_SC - SEC_JIFFIE_SC) converts the scaled nsec
- * value to a scaled second value.
- */
-static __inline__ unsigned long
-timespec_to_jiffies(const struct timespec *value)
-{
-	unsigned long sec = value->tv_sec;
-	long nsec = value->tv_nsec + TICK_NSEC - 1;
-
-	if (sec >= MAX_SEC_IN_JIFFIES){
-		sec = MAX_SEC_IN_JIFFIES;
-		nsec = 0;
-	}
-	return (((u64)sec * SEC_CONVERSION) +
-		(((u64)nsec * NSEC_CONVERSION) >>
-		 (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
-
-}
-
-static __inline__ void
-jiffies_to_timespec(const unsigned long jiffies, struct timespec *value)
-{
-	/*
-	 * Convert jiffies to nanoseconds and separate with
-	 * one divide.
-	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC; 
-	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
-}
-
-/* Same for "timeval"
- *
- * Well, almost.  The problem here is that the real system resolution is
- * in nanoseconds and the value being converted is in micro seconds.
- * Also for some machines (those that use HZ = 1024, in-particular),
- * there is a LARGE error in the tick size in microseconds.
-
- * The solution we use is to do the rounding AFTER we convert the
- * microsecond part.  Thus the USEC_ROUND, the bits to be shifted off.
- * Instruction wise, this should cost only an additional add with carry
- * instruction above the way it was done above.
- */
-static __inline__ unsigned long
-timeval_to_jiffies(const struct timeval *value)
-{
-	unsigned long sec = value->tv_sec;
-	long usec = value->tv_usec;
-
-	if (sec >= MAX_SEC_IN_JIFFIES){
-		sec = MAX_SEC_IN_JIFFIES;
-		usec = 0;
-	}
-	return (((u64)sec * SEC_CONVERSION) +
-		(((u64)usec * USEC_CONVERSION + USEC_ROUND) >>
-		 (USEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
-}
-
-static __inline__ void
-jiffies_to_timeval(const unsigned long jiffies, struct timeval *value)
-{
-	/*
-	 * Convert jiffies to nanoseconds and separate with
-	 * one divide.
-	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC; 
-	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_usec);
-	value->tv_usec /= NSEC_PER_USEC;
-}
-
 static __inline__ int timespec_equal(struct timespec *a, struct timespec *b) 
 { 
 	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
@@ -333,11 +96,6 @@
 
 #define CURRENT_TIME (current_kernel_time())
 
-#endif /* __KERNEL__ */
-
-#define NFDBITS			__NFDBITS
-
-#ifdef __KERNEL__
 extern void do_gettimeofday(struct timeval *tv);
 extern int do_settimeofday(struct timespec *tv);
 extern int do_sys_settimeofday(struct timespec *tv, struct timezone *tz);
@@ -363,7 +121,10 @@
 	ts->tv_sec = sec;
 	ts->tv_nsec = nsec;
 }
-#endif
+
+#endif /* __KERNEL__ */
+
+#define NFDBITS			__NFDBITS
 
 #define FD_SETSIZE		__FD_SETSIZE
 #define FD_SET(fd,fdsetp)	__FD_SET(fd,fdsetp)
diff -urN linux-2.6.8-rc3/include/linux/times.h linux-2.6.8-s390/include/linux/times.h
--- linux-2.6.8-rc3/include/linux/times.h	Wed Jun 16 07:18:57 2004
+++ linux-2.6.8-s390/include/linux/times.h	Thu Jan  1 01:00:00 1970
@@ -1,65 +0,0 @@
-#ifndef _LINUX_TIMES_H
-#define _LINUX_TIMES_H
-
-#ifdef __KERNEL__
-#include <linux/timex.h>
-#include <asm/div64.h>
-#include <asm/types.h>
-#include <asm/param.h>
-
-static inline clock_t jiffies_to_clock_t(long x)
-{
-#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
-	return x / (HZ / USER_HZ);
-#else
-	u64 tmp = (u64)x * TICK_NSEC;
-	do_div(tmp, (NSEC_PER_SEC / USER_HZ));
-	return (long)tmp;
-#endif
-}
-
-static inline unsigned long clock_t_to_jiffies(unsigned long x)
-{
-#if (HZ % USER_HZ)==0
-	if (x >= ~0UL / (HZ / USER_HZ))
-		return ~0UL;
-	return x * (HZ / USER_HZ);
-#else
-	u64 jif;
-
-	/* Don't worry about loss of precision here .. */
-	if (x >= ~0UL / HZ * USER_HZ)
-		return ~0UL;
-
-	/* .. but do try to contain it here */
-	jif = x * (u64) HZ;
-	do_div(jif, USER_HZ);
-	return jif;
-#endif
-}
-
-static inline u64 jiffies_64_to_clock_t(u64 x)
-{
-#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
-	do_div(x, HZ / USER_HZ);
-#else
-	/*
-	 * There are better ways that don't overflow early,
-	 * but even this doesn't overflow in hundreds of years
-	 * in 64 bits, so..
-	 */
-	x *= TICK_NSEC;
-	do_div(x, (NSEC_PER_SEC / USER_HZ));
-#endif
-	return x;
-}
-#endif
-
-struct tms {
-	clock_t tms_utime;
-	clock_t tms_stime;
-	clock_t tms_cutime;
-	clock_t tms_cstime;
-};
-
-#endif
diff -urN linux-2.6.8-rc3/kernel/acct.c linux-2.6.8-s390/kernel/acct.c
--- linux-2.6.8-rc3/kernel/acct.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/kernel/acct.c	Thu Aug  5 18:40:23 2004
@@ -52,7 +52,7 @@
 #include <linux/security.h>
 #include <linux/vfs.h>
 #include <linux/jiffies.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <linux/blkdev.h> /* sector_div */
diff -urN linux-2.6.8-rc3/kernel/sys.c linux-2.6.8-s390/kernel/sys.c
--- linux-2.6.8-rc3/kernel/sys.c	Wed Jun 16 07:18:58 2004
+++ linux-2.6.8-s390/kernel/sys.c	Thu Aug  5 18:40:23 2004
@@ -19,7 +19,7 @@
 #include <linux/fs.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
diff -urN linux-2.6.8-rc3/kernel/sysctl.c linux-2.6.8-s390/kernel/sysctl.c
--- linux-2.6.8-rc3/kernel/sysctl.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/kernel/sysctl.c	Thu Aug  5 18:40:23 2004
@@ -37,7 +37,7 @@
 #include <linux/hugetlb.h>
 #include <linux/security.h>
 #include <linux/initrd.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <linux/limits.h>
 #include <linux/dcache.h>
 
diff -urN linux-2.6.8-rc3/net/bridge/br_fdb.c linux-2.6.8-s390/net/bridge/br_fdb.c
--- linux-2.6.8-rc3/net/bridge/br_fdb.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/net/bridge/br_fdb.c	Thu Aug  5 18:40:23 2004
@@ -16,7 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <asm/atomic.h>
diff -urN linux-2.6.8-rc3/net/bridge/br_ioctl.c linux-2.6.8-s390/net/bridge/br_ioctl.c
--- linux-2.6.8-rc3/net/bridge/br_ioctl.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/net/bridge/br_ioctl.c	Thu Aug  5 18:40:23 2004
@@ -16,7 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/if_bridge.h>
 #include <linux/netdevice.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <asm/uaccess.h>
 #include "br_private.h"
 
diff -urN linux-2.6.8-rc3/net/bridge/br_stp_timer.c linux-2.6.8-s390/net/bridge/br_stp_timer.c
--- linux-2.6.8-rc3/net/bridge/br_stp_timer.c	Wed Jun 16 07:19:23 2004
+++ linux-2.6.8-s390/net/bridge/br_stp_timer.c	Thu Aug  5 18:40:23 2004
@@ -14,7 +14,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <linux/smp_lock.h>
 
 #include "br_private.h"
diff -urN linux-2.6.8-rc3/net/bridge/br_sysfs_br.c linux-2.6.8-s390/net/bridge/br_sysfs_br.c
--- linux-2.6.8-rc3/net/bridge/br_sysfs_br.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/net/bridge/br_sysfs_br.c	Thu Aug  5 18:40:23 2004
@@ -16,7 +16,7 @@
 #include <linux/if_bridge.h>
 #include <linux/rtnetlink.h>
 #include <linux/spinlock.h>
-#include <linux/times.h>
+#include <linux/time.h>
 
 #include "br_private.h"
 
diff -urN linux-2.6.8-rc3/net/core/neighbour.c linux-2.6.8-s390/net/core/neighbour.c
--- linux-2.6.8-rc3/net/core/neighbour.c	Wed Jun 16 07:18:56 2004
+++ linux-2.6.8-s390/net/core/neighbour.c	Thu Aug  5 18:40:23 2004
@@ -24,7 +24,7 @@
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 #endif
-#include <linux/times.h>
+#include <linux/time.h>
 #include <net/neighbour.h>
 #include <net/dst.h>
 #include <net/sock.h>
diff -urN linux-2.6.8-rc3/net/decnet/dn_route.c linux-2.6.8-s390/net/decnet/dn_route.c
--- linux-2.6.8-rc3/net/decnet/dn_route.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/net/decnet/dn_route.c	Thu Aug  5 18:40:23 2004
@@ -77,7 +77,7 @@
 #include <linux/string.h>
 #include <linux/netfilter_decnet.h>
 #include <linux/rcupdate.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <asm/errno.h>
 #include <net/neighbour.h>
 #include <net/dst.h>
diff -urN linux-2.6.8-rc3/net/ipv4/igmp.c linux-2.6.8-s390/net/ipv4/igmp.c
--- linux-2.6.8-rc3/net/ipv4/igmp.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/net/ipv4/igmp.c	Thu Aug  5 18:40:23 2004
@@ -90,7 +90,7 @@
 #include <linux/igmp.h>
 #include <linux/if_arp.h>
 #include <linux/rtnetlink.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <net/ip.h>
 #include <net/protocol.h>
 #include <net/route.h>
diff -urN linux-2.6.8-rc3/net/ipv4/route.c linux-2.6.8-s390/net/ipv4/route.c
--- linux-2.6.8-rc3/net/ipv4/route.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/net/ipv4/route.c	Thu Aug  5 18:40:23 2004
@@ -89,7 +89,7 @@
 #include <linux/random.h>
 #include <linux/jhash.h>
 #include <linux/rcupdate.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <net/protocol.h>
 #include <net/ip.h>
 #include <net/route.h>
diff -urN linux-2.6.8-rc3/net/ipv4/tcp_ipv4.c linux-2.6.8-s390/net/ipv4/tcp_ipv4.c
--- linux-2.6.8-rc3/net/ipv4/tcp_ipv4.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/net/ipv4/tcp_ipv4.c	Thu Aug  5 18:40:23 2004
@@ -61,7 +61,7 @@
 #include <linux/cache.h>
 #include <linux/jhash.h>
 #include <linux/init.h>
-#include <linux/times.h>
+#include <linux/time.h>
 
 #include <net/icmp.h>
 #include <net/tcp.h>
diff -urN linux-2.6.8-rc3/net/ipv6/mcast.c linux-2.6.8-s390/net/ipv6/mcast.c
--- linux-2.6.8-rc3/net/ipv6/mcast.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/net/ipv6/mcast.c	Thu Aug  5 18:40:23 2004
@@ -36,7 +36,7 @@
 #include <linux/socket.h>
 #include <linux/sockios.h>
 #include <linux/jiffies.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <linux/net.h>
 #include <linux/in.h>
 #include <linux/in6.h>
diff -urN linux-2.6.8-rc3/net/ipv6/route.c linux-2.6.8-s390/net/ipv6/route.c
--- linux-2.6.8-rc3/net/ipv6/route.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/net/ipv6/route.c	Thu Aug  5 18:40:23 2004
@@ -27,7 +27,7 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/types.h>
-#include <linux/times.h>
+#include <linux/time.h>
 #include <linux/socket.h>
 #include <linux/sockios.h>
 #include <linux/net.h>
diff -urN linux-2.6.8-rc3/net/ipv6/tcp_ipv6.c linux-2.6.8-s390/net/ipv6/tcp_ipv6.c
--- linux-2.6.8-rc3/net/ipv6/tcp_ipv6.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/net/ipv6/tcp_ipv6.c	Thu Aug  5 18:40:23 2004
@@ -39,7 +39,7 @@
 #include <linux/init.h>
 #include <linux/jhash.h>
 #include <linux/ipsec.h>
-#include <linux/times.h>
+#include <linux/time.h>
 
 #include <linux/ipv6.h>
 #include <linux/icmpv6.h>
