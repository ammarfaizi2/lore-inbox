Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTKKWqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 17:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTKKWqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 17:46:21 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:36337 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263787AbTKKWqF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 17:46:05 -0500
Message-ID: <3FB166A1.7060105@mvista.com>
Date: Tue, 11 Nov 2003 14:45:53 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Denis <vda@port.imtp.ilyichevsk.odessa.ua>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: [PATCH]  2.6-test6: nanosleep+SIGCONT weirdness
References: <Pine.LNX.4.44.0311081043440.1834-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311081043440.1834-100000@home.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------020304020701030007070908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------020304020701030007070908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The problem was that the address of the users return timespec was being saved at 
the wrong place.  In needs to be saved in the sys call interface code rather 
than the do_clock_nanosleep().  My tests were a bit weak as they only did one 
signal rather than two or more which were required to break it.

The attached patch fixes the problem and reverts the removal of the 
FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP code.  This code meets the standard WRT 
signal interruption AND WRT being able to sleep for longer than MAX_LONG jiffies 
(something the move to HZ=1000 makes more pressing).


Change log:

Revert the FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP code.  Fix both nanosleep() and 
clock_nanosleep() signal restart code.

Added a few comments about how restart works.

Add my name to the MAINTAINERS list.





Linus Torvalds wrote:
> On Sat, 8 Nov 2003, Linus Torvalds wrote:
> 
>>That nanosleep restart seems to be broken, and quite frankly, looking at 
>>the mess in kernel/posix-timers.c I'm not all that surprised. The code is 
>>total and absolute crap. I have no idea how it's even supposed to work.
> 
> 
> I'd suggest just removing the regular nanosleep() emulation from there. 
> The clock_nanosleep() restart is likely still broken, but at least this 
> way the _regular_ nanosleep() system call works correctly, and fixing 
> clock_nanosleep() is likely easier since the restart stuff doesn't have to 
> worry about _which_ system call it should restart.
> 
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------020304020701030007070908
Content-Type: text/plain;
 name="hrtimers-2.6.0-t9-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-2.6.0-t9-fix.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.6.0-test9-kb/MAINTAINERS linux/MAINTAINERS
--- linux-2.6.0-test9-kb/MAINTAINERS	2003-11-10 16:01:26.000000000 -0800
+++ linux/MAINTAINERS	2003-11-10 16:50:25.000000000 -0800
@@ -1575,6 +1575,12 @@
 L:	linux-net@vger.kernel.org
 S:	Maintained
 
+POSIX CLOCKS and TIMERS
+P:	George Anzinger
+M:	george@mvista.com
+L:	linux-net@vger.kernel.org
+S:	Supported
+
 PNP SUPPORT
 P:	Adam Belay
 M:	ambx1@neo.rr.com
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.6.0-test9-kb/include/linux/signal.h linux/include/linux/signal.h
--- linux-2.6.0-test9-kb/include/linux/signal.h	2003-11-10 16:13:59.000000000 -0800
+++ linux/include/linux/signal.h	2003-06-30 15:37:10.000000000 -0700
@@ -214,7 +214,7 @@
 struct pt_regs;
 extern int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie);
 #endif
-
+#define FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_SIGNAL_H */
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.6.0-test9-kb/kernel/posix-timers.c linux/kernel/posix-timers.c
--- linux-2.6.0-test9-kb/kernel/posix-timers.c	2003-11-10 16:13:59.000000000 -0800
+++ linux/kernel/posix-timers.c	2003-11-11 14:17:41.000000000 -0800
@@ -1104,12 +1104,43 @@
 extern long do_clock_nanosleep(clockid_t which_clock, int flags,
 			       struct timespec *t);
 
+#ifdef FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
+
+asmlinkage long
+sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp)
+{
+	struct timespec t;
+	struct restart_block *restart_block =
+	    &(current_thread_info()->restart_block);
+	long ret;
+
+	if (copy_from_user(&t, rqtp, sizeof (t)))
+		return -EFAULT;
+
+	if ((unsigned) t.tv_nsec >= NSEC_PER_SEC || t.tv_sec < 0)
+		return -EINVAL;
+
+	ret = do_clock_nanosleep(CLOCK_REALTIME, 0, &t);
+	/*
+	 * Do this here as do_clock_nanosleep does not have the real address
+	 */
+	restart_block->arg1 = (unsigned long)rmtp;
+
+	if (ret == -ERESTART_RESTARTBLOCK && rmtp &&
+					copy_to_user(rmtp, &t, sizeof (t)))
+		return -EFAULT;
+	return ret;
+}
+#endif				// ! FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
+
 asmlinkage long
 sys_clock_nanosleep(clockid_t which_clock, int flags,
 		    const struct timespec __user *rqtp,
 		    struct timespec __user *rmtp)
 {
 	struct timespec t;
+	struct restart_block *restart_block =
+	    &(current_thread_info()->restart_block);
 	int ret;
 
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
@@ -1123,6 +1154,10 @@
 		return -EINVAL;
 
 	ret = do_clock_nanosleep(which_clock, flags, &t);
+	/*
+	 * Do this here as do_clock_nanosleep does not have the real address
+	 */
+	restart_block->arg1 = (unsigned long)rmtp;
 
 	if ((ret == -ERESTART_RESTARTBLOCK) && rmtp &&
 					copy_to_user(rmtp, &t, sizeof (t)))
@@ -1152,7 +1187,7 @@
 	if (restart_block->fn == clock_nanosleep_restart) {
 		/*
 		 * Interrupted by a non-delivered signal, pick up remaining
-		 * time and continue.
+		 * time and continue.  Remaining time is in arg2 & 3.
 		 */
 		restart_block->fn = do_no_restart_syscall;
 
@@ -1209,9 +1244,20 @@
 		tsave->tv_sec = div_long_long_rem(left, 
 						  NSEC_PER_SEC, 
 						  &tsave->tv_nsec);
+		/*
+		 * Restart works by saving the time remaing in 
+		 * arg2 & 3 (it is 64-bits of jiffies).  The other
+		 * info we need is the clock_id (saved in arg0). 
+		 * The sys_call interface needs the users 
+		 * timespec return address which _it_ saves in arg1.
+		 * Since we have cast the nanosleep call to a clock_nanosleep
+		 * both can be restarted with the same code.
+		 */
 		restart_block->fn = clock_nanosleep_restart;
 		restart_block->arg0 = which_clock;
-		restart_block->arg1 = (unsigned long)tsave;
+		/*
+		 * Caller sets arg1
+		 */
 		restart_block->arg2 = rq_time & 0xffffffffLL;
 		restart_block->arg3 = rq_time >> 32;
 
@@ -1221,7 +1267,7 @@
 	return 0;
 }
 /*
- * This will restart clock_nanosleep. Incorrectly, btw.
+ * This will restart either clock_nanosleep or clock_nanosleep
  */
 long
 clock_nanosleep_restart(struct restart_block *restart_block)
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.6.0-test9-kb/kernel/timer.c linux/kernel/timer.c
--- linux-2.6.0-test9-kb/kernel/timer.c	2003-11-10 16:13:59.000000000 -0800
+++ linux/kernel/timer.c	2003-11-10 16:00:09.000000000 -0800
@@ -1059,6 +1059,7 @@
 {
 	return current->pid;
 }
+#ifndef FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
 
 static long nanosleep_restart(struct restart_block *restart)
 {
@@ -1117,6 +1118,7 @@
 	}
 	return ret;
 }
+#endif // ! FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
 
 /*
  * sys_sysinfo - fill in sysinfo struct
Binary files linux-2.6.0-test9-kb/scripts/bin2c and linux/scripts/bin2c differ

--------------020304020701030007070908--

