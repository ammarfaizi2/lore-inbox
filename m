Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275178AbRJaW5u>; Wed, 31 Oct 2001 17:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275126AbRJaW5l>; Wed, 31 Oct 2001 17:57:41 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:60427 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S275110AbRJaW51>; Wed, 31 Oct 2001 17:57:27 -0500
Date: Wed, 31 Oct 2001 23:58:03 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <linux-kernel@vger.kernel.org>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>, J Sloan <jjs@lexus.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <7DFB419183D@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.30.0110312341150.30534-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Petr Vandrovec wrote:

> Hi,
>   this reminds me. Year or so ago there was patch from someone, which
> detected jiffies overflow in /proc/uptime proc_read() code, so only thing
> you had to do was run 'uptime', 'w', 'top' or something like that
> every 497 days - you can schedule it as cron job for Jan 1, 0:00:00,
> to find some workoholics.
>
>   Patch was something like:
>
> ...

OK, to summarize and to not loose the patch again, I made up a final
version.

Anyone wanting to donate the stability of his box for linux
kernel-development may feel free to try out this patch.

It moves forward the wraparound of the jiffies counter on 32 bit boxes
from about 1.3 years after boot to approx 2 min after boot, which seemed
to somehow affect stability for my intel box.

As a side effect, if your box does not crash within the next 497.1 days,
this patch will allow it to still display correct uptime.

Next step would be to decide what to do with the start_time field of
struct task_struct, which is still 32 bit and stores seconds times HZ.
Other uses for 64 bit jiffies might be identified as well.

Thanks to all that contributed to the discussion.

Tim


--- linux-2.4.14-pre6/fs/proc/proc_misc.c	Thu Oct 11 19:46:57 2001
+++ linux-2.4.14-pre6-jiffies64/fs/proc/proc_misc.c	Wed Oct 31 22:53:55 2001
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
+	u64 uptime;
+	unsigned long remainder;
 	unsigned long idle;
 	int len;

-	uptime = jiffies;
+	uptime = get_jiffies64() - INITIAL_JIFFIES;
+	remainder = (unsigned long) do_div(uptime, HZ);
+
 	idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime;

-	/* The formula for the fraction parts really is ((t * 100) / HZ) % 100, but
-	   that would overflow about every five days at HZ == 100.
+	/* The formula for the fraction part of the idle time really is
+	   ((t * 100) / HZ) % 100, but that would overflow about
+	    every five days at HZ == 100.
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
+		(remainder * 100) / HZ,
 		idle / HZ,
 		(((idle % HZ) * 100) / HZ) % 100);
 #else
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		uptime % HZ,
+		(unsigned long) uptime,
+		remainder,
 		idle / HZ,
 		idle % HZ);
 #endif
--- linux-2.4.14-pre6/kernel/timer.c	Mon Oct  8 19:41:41 2001
+++ linux-2.4.14-pre6-jiffies64/kernel/timer.c	Wed Oct 31 22:49:20 2001
@@ -65,7 +65,7 @@

 extern int do_setitimer(int, struct itimerval *, struct itimerval *);

-unsigned long volatile jiffies;
+unsigned long volatile jiffies = INITIAL_JIFFIES;

 unsigned int * prof_buffer;
 unsigned long prof_len;
@@ -117,7 +117,7 @@
 		INIT_LIST_HEAD(tv1.vec + i);
 }

-static unsigned long timer_jiffies;
+static unsigned long timer_jiffies = INITIAL_JIFFIES;

 static inline void internal_add_timer(struct timer_list *timer)
 {
@@ -638,7 +638,7 @@
 }

 /* jiffies at the most recent update of wall time */
-unsigned long wall_jiffies;
+unsigned long wall_jiffies = INITIAL_JIFFIES;

 /*
  * This spinlock protect us from races in SMP while playing with xtime. -arca
@@ -683,6 +683,35 @@
 	if (TQ_ACTIVE(tq_timer))
 		mark_bh(TQUEUE_BH);
 }
+
+
+#if BITS_PER_LONG < 48
+
+u64 get_jiffies64(void)
+{
+	static unsigned long jiffies_hi = 0;
+	static unsigned long jiffies_last = INITIAL_JIFFIES;
+	static unsigned long jiffies_tmp;
+
+	jiffies_tmp = jiffies;   /* avoid races */
+	if (jiffies_tmp < jiffies_last) {   /* We have a wrap */
+		jiffies_hi++;
+		jiffies_last = jiffies_tmp;
+	}
+
+	return (jiffies_tmp | ((u64)jiffies_hi) << BITS_PER_LONG);
+}
+
+#else
+ /* jiffies is wide enough to not wrap for 8716 years at HZ==1024 */
+
+static inline u64 get_jiffies64(void)
+{
+	return (u64)jiffies;
+}
+
+#endif /* BITS_PER_LONG < 48 */
+

 #if !defined(__alpha__) && !defined(__ia64__)

--- linux-2.4.14-pre6/kernel/info.c	Sat Apr 21 01:15:40 2001
+++ linux-2.4.14-pre6-jiffies64/kernel/info.c	Wed Oct 31 23:12:56 2001
@@ -12,15 +12,19 @@
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
+	uptime = get_jiffies64() - INITIAL_JIFFIES;
+	do_div(uptime, HZ);
+	val.uptime = (unsigned long) uptime;

 	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
 	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
--- linux-2.4.14-pre6/include/linux/sched.h	Wed Oct 31 23:06:23 2001
+++ linux-2.4.14-pre6-jiffies64/include/linux/sched.h	Wed Oct 31 22:50:34 2001
@@ -543,7 +543,10 @@

 #include <asm/current.h>

+#define INITIAL_JIFFIES 0xFFFFD000ul
 extern unsigned long volatile jiffies;
+extern u64 get_jiffies64(void);
+
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern struct timeval xtime;

