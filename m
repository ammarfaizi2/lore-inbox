Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265106AbUF1R66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbUF1R66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 13:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbUF1R66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 13:58:58 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:22796 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265106AbUF1R6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 13:58:52 -0400
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       tim@physik3.uni-rostock.de, george@mvista.com, johnstul@us.ibm.com,
       david+powerix@blue-labs.org, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: boot time, process start time, and NOW time
References: <1087948634.9831.1154.camel@cube>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 29 Jun 2004 02:56:52 +0900
In-Reply-To: <1087948634.9831.1154.camel@cube>
Message-ID: <87smcf5zx7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sf.net> writes:

> Even with the 2.6.7 kernel, I'm still getting reports of process
> start times wandering. Here is an example:
> 
>    "About 12 hours since reboot to 2.6.7 there was already a
>    difference of about 7 seconds between the real start time
>    and the start time reported by ps. Now, 24 hours since reboot
>    the difference is 10 seconds."
> 
> The calculation used is:
> 
>    now - uptime + time_from_boot_to_process_start

Start-time and uptime is using different source. Looks like the
jiffies was added bogus lost counts.

quick hack. Does this change the behavior?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

---

 arch/i386/kernel/smpboot.c          |   16 +++++++++-------
 arch/i386/kernel/timers/timer_tsc.c |    8 ++++++--
 include/linux/time.h                |    2 +-
 3 files changed, 16 insertions(+), 10 deletions(-)

diff -puN arch/i386/kernel/timers/timer_tsc.c~uptime-fix arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.7/arch/i386/kernel/timers/timer_tsc.c~uptime-fix	2004-06-29 01:21:26.000000000 +0900
+++ linux-2.6.7-hirofumi/arch/i386/kernel/timers/timer_tsc.c	2004-06-29 01:21:26.000000000 +0900
@@ -467,8 +467,6 @@ static int __init init_tsc(char* overrid
  	 *	moaned if you have the only one in the world - you fix it!
  	 */
 
-	count2 = LATCH; /* initialize counter for mark_offset_tsc() */
-
 	if (cpu_has_tsc) {
 		unsigned long tsc_quotient;
 #ifdef CONFIG_HPET_TIMER
@@ -512,6 +510,12 @@ static int __init init_tsc(char* overrid
 				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
 			}
 			set_cyc2ns_scale(cpu_khz/1000);
+
+			/* initialize for mark_offset_tsc() */
+			count2 = LATCH;
+			rdtsc(last_tsc_low, last_tsc_high);
+			printk("initial tsc: %lu.%lu\n",
+				last_tsc_high, last_tsc_low);
 			return 0;
 		}
 	}
diff -puN include/linux/time.h~uptime-fix include/linux/time.h
--- linux-2.6.7/include/linux/time.h~uptime-fix	2004-06-29 01:21:26.000000000 +0900
+++ linux-2.6.7-hirofumi/include/linux/time.h	2004-06-29 01:21:26.000000000 +0900
@@ -41,7 +41,7 @@ struct timezone {
  * Have the 32 bit jiffies value wrap 5 minutes after boot
  * so jiffies wrap bugs show up earlier.
  */
-#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
+#define INITIAL_JIFFIES		(-300L*HZ)
 
 /*
  * Change timeval to jiffies, trying to avoid the
diff -puN arch/i386/kernel/smpboot.c~uptime-fix arch/i386/kernel/smpboot.c
--- linux-2.6.7/arch/i386/kernel/smpboot.c~uptime-fix	2004-06-29 01:25:59.000000000 +0900
+++ linux-2.6.7-hirofumi/arch/i386/kernel/smpboot.c	2004-06-29 01:34:55.000000000 +0900
@@ -210,6 +210,8 @@ static unsigned long long __init div64 (
 	return res;
 }
 
+static unsigned long __initdata sync_tsc_high, sync_tsc_low;
+
 static void __init synchronize_tsc_bp (void)
 {
 	int i;
@@ -251,11 +253,6 @@ static void __init synchronize_tsc_bp (v
 		atomic_inc(&tsc_count_start);
 
 		rdtscll(tsc_values[smp_processor_id()]);
-		/*
-		 * We clear the TSC in the last loop:
-		 */
-		if (i == NR_LOOPS-1)
-			write_tsc(0, 0);
 
 		/*
 		 * Wait for all APs to leave the synchronization point:
@@ -264,8 +261,14 @@ static void __init synchronize_tsc_bp (v
 			mb();
 		atomic_set(&tsc_count_start, 0);
 		wmb();
+
+		/* We save the TSC in the last loop: */
+		if (i == NR_LOOPS-1)
+			rdtsc(sync_tsc_low, sync_tsc_high);
+
 		atomic_inc(&tsc_count_stop);
 	}
+	write_tsc(sync_tsc_low, sync_tsc_high);
 
 	sum = 0;
 	for (i = 0; i < NR_CPUS; i++) {
@@ -323,12 +326,11 @@ static void __init synchronize_tsc_ap (v
 			mb();
 
 		rdtscll(tsc_values[smp_processor_id()]);
-		if (i == NR_LOOPS-1)
-			write_tsc(0, 0);
 
 		atomic_inc(&tsc_count_stop);
 		while (atomic_read(&tsc_count_stop) != num_booting_cpus()) mb();
 	}
+	write_tsc(sync_tsc_low, sync_tsc_high);
 }
 #undef NR_LOOPS
 

_
