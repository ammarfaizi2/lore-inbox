Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280495AbRJaUsA>; Wed, 31 Oct 2001 15:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280499AbRJaUrv>; Wed, 31 Oct 2001 15:47:51 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:23819 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S280495AbRJaUrh>; Wed, 31 Oct 2001 15:47:37 -0500
Date: Wed, 31 Oct 2001 21:47:52 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Andreas Dilger <adilger@turbolabs.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <01103121070200.01262@nemo>
Message-ID: <Pine.LNX.4.30.0110312138040.30038-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, vda wrote:

> On Wednesday 31 October 2001 18:40, Andreas Dilger wrote:
> > On Oct 31, 2001  19:16 +0100, Tim Schmielau wrote:
> > > The idea was that all drivers that use the 32 bit jiffies counter have to
> > > be aware of the wraparound anyways, and won't see a difference.
> >
> > Agreed.  I also like the change that you initialize jiffies to a pre-wrap
> > value, so the jiffies wrap bugs can more easily be found/fixed.
>
> Yes indeed.  We should chase bugs, not run away from them :-)
> I seriously suggest setting juffy to close to wrap value
> if kernel hacking is enabled.
>
> > I would say that the race is so rare that it should not be handled,
> > especially since it adds extra code in the timer interrupt.
>
> Race will be handled by readers of 64bit jiffy. There won't be many of them.
>
> > > +	/* We need to make sure jiffies_high does not change while
> > > +	 * reading jiffies and jiffies_high */
> > > +	do {
> > > +		jiffies_high_tmp = jiffies_high_shadow;
> > > +		barrier();
> > > +		jiffies_tmp = jiffies;
> > > +		barrier();
> > > +	} while (jiffies_high != jiffies_high_tmp);
> >
> > Maybe this could be condensed into a macro/inline, so that people don't
> > screw it up (and it looks cleaner).  Like get_jiffies64() or so, for
>
> Inline! Inline! Don't use macro unless you must!
>
> // extern or static? which is correct?
> // I see both types in kernel .h :-(
> extern inline u64 get_jiffies64() {
> 	unsigned long hi,lo;
> 	do {
> 		hi = jiffies_hi;
> 		barrier();
> 		lo = jiffies;
> 		barrier();
> 	} while (hi != jiffies_hi);
> 	return lo + (((u64)hi) << 32);
> }
>

OK, I introduced get_jiffies64, corrected my 64 bit mistake and
subtract INITIAL_JIFFIES to obtain uptime, while leaving it at at pre-wrap
value for error-chasing.
Still this patch introduces jiffies_high on 64 bit platforms which will be
useless until the year 571234830.

************************************************************
* DISCLAIMER: This patch WILL make your linux box unstable *
* unless you set INITIAL_JIFFIES to zero!!!                *
************************************************************

btw.: can someone please explain to me why do_timer uses
	(*(unsigned long *)&jiffies)++;
instead of just doing jiffies++ ?

Tim



--- fs/proc/proc_misc.c.orig	Wed Oct 31 17:45:08 2001
+++ fs/proc/proc_misc.c	Wed Oct 31 21:07:11 2001
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
+		((remainder * 100) / HZ) % 100,
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
--- kernel/timer.c.orig	Wed Oct 31 17:24:36 2001
+++ kernel/timer.c	Wed Oct 31 21:10:39 2001
@@ -65,7 +65,8 @@

 extern int do_setitimer(int, struct itimerval *, struct itimerval *);

-unsigned long volatile jiffies;
+unsigned long volatile jiffies = INITIAL_JIFFIES;
+unsigned long volatile jiffies_hi, jiffies_hi_shadow;

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
@@ -673,7 +674,22 @@

 void do_timer(struct pt_regs *regs)
 {
-	(*(unsigned long *)&jiffies)++;
+	/* we assume that two calls to do_timer can never overlap
+	 * since they are one jiffie apart in time */
+	if (jiffies != (unsigned long)(-1)) {
+		jiffies++;
+	} else {
+		/* We still need to care about the race with readers of
+		 * jiffies_hi. Readers have to discard the values if
+		 * jiffies_hi != jiffies_hi_shadow when read with
+		 * proper barriers in between. */
+		jiffies_hi++;
+		barrier();
+		jiffies++;
+		barrier();
+		jiffies_hi_shadow = jiffies_hi;
+		barrier();
+	}
 #ifndef CONFIG_SMP
 	/* SMP process accounting uses the local APIC timer */

--- kernel/info.c.orig	Wed Oct 31 17:58:25 2001
+++ kernel/info.c	Wed Oct 31 21:07:28 2001
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
+	val.uptime = uptime;

 	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
 	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
--- include/linux/sched.h.orig	Wed Oct 31 17:42:41 2001
+++ include/linux/sched.h	Wed Oct 31 21:09:21 2001
@@ -543,7 +543,21 @@

 #include <asm/current.h>

-extern unsigned long volatile jiffies, jiffies_high, jiffies_high_shadow;
+#define INITIAL_JIFFIES 0xFFFFD000ul
+extern unsigned long volatile jiffies, jiffies_hi, jiffies_hi_shadow;
+static inline u64 get_jiffies64() {
+	unsigned long hi,lo;
+	/* We need to make sure jiffies_hi does not change while
+	 * reading jiffies and jiffies_hi */
+	do {
+	        hi = jiffies_hi;
+	        barrier();
+	        lo = jiffies;
+	        barrier();
+	} while (hi != jiffies_hi);
+	return lo + (((u64)hi) << BITS_PER_LONG);
+}
+
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern struct timeval xtime;

