Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280164AbRJaLgk>; Wed, 31 Oct 2001 06:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280170AbRJaLgb>; Wed, 31 Oct 2001 06:36:31 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:7177 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S280164AbRJaLet>; Wed, 31 Oct 2001 06:34:49 -0500
Date: Wed, 31 Oct 2001 12:35:24 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <linux-kernel@vger.kernel.org>
cc: <george@mvista.com>, <jjs@lexus.com>
Subject: [Patch] Re: Nasty suprise with uptime
Message-ID: <Pine.LNX.4.30.0110311218470.28509-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The appended patch enables 32 bit linux boxes to display more than
497.1 days of uptime. No user land application changes are needed.

Credit is due to George Anzinger and the High-res-timers project
at https://sourceforge.net/projects/high-res-timers/, where I ripped
out the 64 bit jiffies patch. However, I do claim ownership on
all misdesign and bugs since this is my first kernel patch.

My Intel box just now displays a (faked, of course) uptime of 497 days,
2:38 hours, so the 32 jiffies value has wrapped without problems about 10
minutes ago.

Next step would be to decide what to do with the start_time field of
struct task_struct, which is still 32 bit, so ps on my box believes some
processes to have started 497 days ago. Probably there are tons of other
uses for the upper 32 bit of jiffies as well.

Tim



--- fs/proc/proc_misc.c.orig	Wed Oct 31 04:14:05 2001
+++ fs/proc/proc_misc.c	Wed Oct 31 11:07:31 2001
@@ -39,6 +39,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <asm/div64.h>


 #define LOAD_INT(x) ((x) >> FSHIFT)
@@ -103,15 +104,19 @@
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	unsigned long uptime;
-	unsigned long idle;
+	u64 uptime;
+	unsigned long idle, remainder;
 	int len;

-	uptime = jiffies;
+	/* On 32 bit platforms there is a tiny window here
+	 * for a race condition every 497.1 days */
+	uptime = jiffies_64;
+	remainder = (unsigned long) do_div(uptime, HZ);
 	idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime;

-	/* The formula for the fraction parts really is ((t * 100) / HZ) % 100, but
-	   that would overflow about every five days at HZ == 100.
+	/* The formula for the fraction part of the idle time really is
+           ((t * 100) / HZ) % 100, but that would overflow about
+           every five days at HZ == 100.
 	   Therefore the identity a = (a / b) * b + a % b is used so that it is
 	   calculated as (((t / HZ) * 100) + ((t % HZ) * 100) / HZ) % 100.
 	   The part in front of the '+' always evaluates as 0 (mod 100). All divisions
@@ -121,14 +126,14 @@
 	 */
 #if HZ!=100
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		(((uptime % HZ) * 100) / HZ) % 100,
+		(unsigned long) uptime,
+		((remainder * 100) / HZ) % 100,
 		idle / HZ,
 		(((idle % HZ) * 100) / HZ) % 100);
 #else
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		uptime % HZ,
+	        (unsigned long) uptime,
+	        remainder,
 		idle / HZ,
 		idle % HZ);
 #endif
--- kernel/itimer.c.orig	Wed Oct 31 01:14:19 2001
+++ kernel/itimer.c	Wed Oct 31 01:15:38 2001
@@ -34,10 +34,10 @@
 	return HZ*sec+usec;
 }

-static void jiffiestotv(unsigned long jiffies, struct timeval *value)
+static void jiffiestotv(unsigned long _jiffies, struct timeval *value)
 {
-	value->tv_usec = (jiffies % HZ) * (1000000 / HZ);
-	value->tv_sec = jiffies / HZ;
+	value->tv_usec = (_jiffies % HZ) * (1000000 / HZ);
+	value->tv_sec = _jiffies / HZ;
 }

 int do_getitimer(int which, struct itimerval *value)
--- kernel/timer.c.orig	Tue Oct 30 23:35:44 2001
+++ kernel/timer.c	Wed Oct 31 03:25:12 2001
@@ -65,7 +65,8 @@

 extern int do_setitimer(int, struct itimerval *, struct itimerval *);

-unsigned long volatile jiffies;
+#define INITIAL_JIFFIES 0
+volatile u64 jiffies_64 = INITIAL_JIFFIES;

 unsigned int * prof_buffer;
 unsigned long prof_len;
@@ -117,7 +118,7 @@
 		INIT_LIST_HEAD(tv1.vec + i);
 }

-static unsigned long timer_jiffies;
+static unsigned long timer_jiffies = INITIAL_JIFFIES;

 static inline void internal_add_timer(struct timer_list *timer)
 {
@@ -638,7 +639,7 @@
 }

 /* jiffies at the most recent update of wall time */
-unsigned long wall_jiffies;
+unsigned long wall_jiffies = INITIAL_JIFFIES;

 /*
  * This spinlock protect us from races in SMP while playing with xtime. -arca
@@ -673,7 +674,7 @@

 void do_timer(struct pt_regs *regs)
 {
-	(*(unsigned long *)&jiffies)++;
+	(*(u64 *)&jiffies_64)++;
 #ifndef CONFIG_SMP
 	/* SMP process accounting uses the local APIC timer */

--- kernel/ksyms.c.orig	Wed Oct 31 00:53:08 2001
+++ kernel/ksyms.c	Wed Oct 31 02:22:20 2001
@@ -435,7 +435,7 @@
 EXPORT_SYMBOL(interruptible_sleep_on_timeout);
 EXPORT_SYMBOL(schedule);
 EXPORT_SYMBOL(schedule_timeout);
-EXPORT_SYMBOL(jiffies);
+EXPORT_SYMBOL(jiffies_64);
 EXPORT_SYMBOL(xtime);
 EXPORT_SYMBOL(do_gettimeofday);
 EXPORT_SYMBOL(do_settimeofday);
--- kernel/info.c.orig	Wed Oct 31 00:57:24 2001
+++ kernel/info.c	Wed Oct 31 10:38:50 2001
@@ -12,15 +12,21 @@
 #include <linux/smp_lock.h>

 #include <asm/uaccess.h>
+#include <asm/div64.h>

 asmlinkage long sys_sysinfo(struct sysinfo *info)
 {
 	struct sysinfo val;
+	u64 uptime;

 	memset((char *)&val, 0, sizeof(struct sysinfo));

 	cli();
-	val.uptime = jiffies / HZ;
+	/* On 32 bit platforms there is a tiny window here
+	 * for a race condition every 497.1 days */
+	uptime = jiffies_64;
+	do_div(uptime, HZ);
+	val.uptime = (unsigned long) uptime;

 	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
 	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
--- include/linux/time.h.orig	Wed Oct 31 01:40:39 2001
+++ include/linux/time.h	Wed Oct 31 01:41:33 2001
@@ -42,10 +42,10 @@
 }

 static __inline__ void
-jiffies_to_timespec(unsigned long jiffies, struct timespec *value)
+jiffies_to_timespec(unsigned long _jiffies, struct timespec *value)
 {
-	value->tv_nsec = (jiffies % HZ) * (1000000000L / HZ);
-	value->tv_sec = jiffies / HZ;
+	value->tv_nsec = (_jiffies % HZ) * (1000000000L / HZ);
+	value->tv_sec = _jiffies / HZ;
 }


--- include/linux/sched.h.orig	Wed Oct 31 00:48:44 2001
+++ include/linux/sched.h	Wed Oct 31 01:49:53 2001
@@ -550,7 +550,15 @@

 #include <asm/current.h>

-extern unsigned long volatile jiffies;
+/*
+ * you MUST NOT read jiffies_64 without holding read_lock_irq(&xtime_lock)
+ */
+#if defined(__LITTLE_ENDIAN) || (BITS_PER_LONG > 32)
+#define jiffies (((volatile unsigned long *)&jiffies_64)[0])
+#else
+#define jiffies (((volatile unsigned long *)&jiffies_64)[1])
+#endif
+extern u64 volatile jiffies_64;
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern struct timeval xtime;
--- include/linux/coda_proc.h.orig	Wed Oct 31 01:29:56 2001
+++ include/linux/coda_proc.h	Wed Oct 31 01:30:24 2001
@@ -14,7 +14,7 @@

 void coda_sysctl_init(void);
 void coda_sysctl_clean(void);
-void coda_upcall_stats(int opcode, unsigned long jiffies);
+void coda_upcall_stats(int opcode, unsigned long _jiffies);

 #include <linux/sysctl.h>
 #include <linux/coda_fs_i.h>
--- net/ipv4/ipconfig.c.orig	Wed Oct 31 01:44:35 2001
+++ net/ipv4/ipconfig.c	Wed Oct 31 01:45:29 2001
@@ -630,7 +630,7 @@
 /*
  *  Send DHCP/BOOTP request to single interface.
  */
-static void __init ic_bootp_send_if(struct ic_device *d, u32 jiffies)
+static void __init ic_bootp_send_if(struct ic_device *d, u32 _jiffies)
 {
 	struct net_device *dev = d->dev;
 	struct sk_buff *skb;
@@ -677,7 +677,7 @@
 	b->your_ip = INADDR_NONE;
 	b->server_ip = INADDR_NONE;
 	memcpy(b->hw_addr, dev->dev_addr, dev->addr_len);
-	b->secs = htons(jiffies / HZ);
+	b->secs = htons(_jiffies / HZ);
 	b->xid = d->xid;

 	/* add DHCP options or BOOTP extensions */
--- drivers/net/wan/dscc4.c.orig	Wed Oct 31 01:45:49 2001
+++ drivers/net/wan/dscc4.c	Wed Oct 31 01:46:23 2001
@@ -123,7 +123,7 @@
 	u32 next;
 	u32 data;
 	u32 complete;
-	u32 jiffies; /* more hack to come :o) */
+	u32 _jiffies; /* more hack to come :o) */
 };

 struct RxFD {
--- drivers/block/floppy.c.orig	Wed Oct 31 01:16:05 2001
+++ drivers/block/floppy.c	Wed Oct 31 01:18:17 2001
@@ -635,7 +635,7 @@
 static struct output_log {
 	unsigned char data;
 	unsigned char status;
-	unsigned long jiffies;
+	unsigned long _jiffies;
 } output_log[OLOGSIZE];

 static int output_log_pos;
@@ -1163,7 +1163,7 @@
 #ifdef FLOPPY_SANITY_CHECK
 		output_log[output_log_pos].data = byte;
 		output_log[output_log_pos].status = status;
-		output_log[output_log_pos].jiffies = jiffies;
+		output_log[output_log_pos]._jiffies = jiffies;
 		output_log_pos = (output_log_pos + 1) % OLOGSIZE;
 #endif
 		return 0;
@@ -1851,7 +1851,7 @@
 		printk("%2x %2x %lu\n",
 		       output_log[(i+output_log_pos) % OLOGSIZE].data,
 		       output_log[(i+output_log_pos) % OLOGSIZE].status,
-		       output_log[(i+output_log_pos) % OLOGSIZE].jiffies);
+		       output_log[(i+output_log_pos) % OLOGSIZE]._jiffies);
 	printk("last result at %lu\n", resultjiffies);
 	printk("last redo_fd_request at %lu\n", lastredo);
 	for (i=0; i<resultsize; i++){

