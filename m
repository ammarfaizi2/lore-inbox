Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTKHSpw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 13:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTKHSpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 13:45:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:43433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261967AbTKHSpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 13:45:50 -0500
Date: Sat, 8 Nov 2003 10:45:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Denis <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6-test6: nanosleep+SIGCONT weirdness
In-Reply-To: <Pine.LNX.4.44.0311081022030.2240-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311081043440.1834-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Nov 2003, Linus Torvalds wrote:
> 
> That nanosleep restart seems to be broken, and quite frankly, looking at 
> the mess in kernel/posix-timers.c I'm not all that surprised. The code is 
> total and absolute crap. I have no idea how it's even supposed to work.

I'd suggest just removing the regular nanosleep() emulation from there. 
The clock_nanosleep() restart is likely still broken, but at least this 
way the _regular_ nanosleep() system call works correctly, and fixing 
clock_nanosleep() is likely easier since the restart stuff doesn't have to 
worry about _which_ system call it should restart.

Denis, does this work for you?

		Linus

-----
===== include/linux/signal.h 1.13 vs edited =====
--- 1.13/include/linux/signal.h	Mon Jun  2 04:13:33 2003
+++ edited/include/linux/signal.h	Sat Nov  8 10:42:20 2003
@@ -214,7 +214,7 @@
 struct pt_regs;
 extern int get_signal_to_deliver(siginfo_t *info, struct pt_regs *regs, void *cookie);
 #endif
-#define FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_SIGNAL_H */
===== kernel/posix-timers.c 1.21 vs edited =====
--- 1.21/kernel/posix-timers.c	Sun Sep 21 14:50:25 2003
+++ edited/kernel/posix-timers.c	Sat Nov  8 10:41:57 2003
@@ -1104,29 +1104,6 @@
 extern long do_clock_nanosleep(clockid_t which_clock, int flags,
 			       struct timespec *t);
 
-#ifdef FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
-
-asmlinkage long
-sys_nanosleep(struct timespec __user *rqtp, struct timespec __user *rmtp)
-{
-	struct timespec t;
-	long ret;
-
-	if (copy_from_user(&t, rqtp, sizeof (t)))
-		return -EFAULT;
-
-	if ((unsigned) t.tv_nsec >= NSEC_PER_SEC || t.tv_sec < 0)
-		return -EINVAL;
-
-	ret = do_clock_nanosleep(CLOCK_REALTIME, 0, &t);
-
-	if (ret == -ERESTART_RESTARTBLOCK && rmtp &&
-					copy_to_user(rmtp, &t, sizeof (t)))
-		return -EFAULT;
-	return ret;
-}
-#endif				// ! FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
-
 asmlinkage long
 sys_clock_nanosleep(clockid_t which_clock, int flags,
 		    const struct timespec __user *rqtp,
@@ -1244,7 +1221,7 @@
 	return 0;
 }
 /*
- * This will restart either clock_nanosleep or clock_nanosleep
+ * This will restart clock_nanosleep
  */
 long
 clock_nanosleep_restart(struct restart_block *restart_block)
===== kernel/timer.c 1.72 vs edited =====
--- 1.72/kernel/timer.c	Tue Oct 21 22:09:54 2003
+++ edited/kernel/timer.c	Sat Nov  8 10:42:37 2003
@@ -1059,7 +1059,6 @@
 {
 	return current->pid;
 }
-#ifndef FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
 
 static long nanosleep_restart(struct restart_block *restart)
 {
@@ -1118,7 +1117,6 @@
 	}
 	return ret;
 }
-#endif // ! FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP
 
 /*
  * sys_sysinfo - fill in sysinfo struct

