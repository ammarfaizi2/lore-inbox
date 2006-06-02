Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWFBS3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWFBS3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 14:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWFBS3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 14:29:14 -0400
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79]:46706 "HELO
	smtp010.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751443AbWFBS3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 14:29:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Message-Id;
  b=wz+cMDDfX1KXp4RIJNiQ22CDFd2hkf514rcOY7B6mfVT3OEh2gEk12bJIj15+nAhk1HwtTRQBvxNrM6xnF2705h8qq1Al/AXhhfVRP1Urh0g8ixqTVKNu1/kaabO3ff7G+Z0FCI7P9+h3qW91f73a/AR6KbAR9CbeNfTv2YCaYM=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] non-scalar ktime addition and subtraction broken
Date: Fri, 2 Jun 2006 20:28:37 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org,
       "Christopher S. Aker" <caker@theshore.net>
References: <20060602030825.GA8006@ccure.user-mode-linux.org> <1149231262.20582.119.camel@localhost.localdomain> <20060602151916.GC4708@ccure.user-mode-linux.org>
In-Reply-To: <20060602151916.GC4708@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WNIgEUbKzTwCRT/"
Message-Id: <200606022028.38510.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_WNIgEUbKzTwCRT/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 02 June 2006 17:19, Jeff Dike wrote:
> On Fri, Jun 02, 2006 at 08:54:22AM +0200, Thomas Gleixner wrote:
> > NAK. ktime_t is defined that ist must be normalized the same way as
> > timespecs. The nsec part must be >= 0 and < NSEC_PER_SEC. Fix the part
> > which is feeding non normalized values.
>
> Aha, that would be me, initializing wall_to_monotonic incorrectly.  Thanks
> for the clue.
Ok, since I now I'll never finish it:
$ ll old-patch-scripts/patches/uml-fix-timers.patch
-rw-r--r-- 1 paolo paolo 6763 2005-07-24 06:41 
old-patch-scripts/patches/uml-fix-timers.patch

I'm attaching this incomplete patch. It won't apply (it was written likely 
before 2.6.13 but surely after git was born), it likely introduces bugs and I 
don't remember which ones, but it does point out some theoretical issues 
about timekeeping (including this one):

+       set_normalized_timespec(&wall_to_monotonic, -now.tv_sec, 
-now.tv_nsec);

(I likely was fighting against the loadavg >= 1.0 bug but I went looking for 
every kind of things).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_WNIgEUbKzTwCRT/
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-fix-timers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fix-timers.patch"



*) Rename timer() since it's a global and such a name is a "shooting offense".
Also, it's difficult to find the def with ctags currently, because people miss
fantasy.

*) do_timer must be called with xtime_lock held. I'm not sure
boot_timer_handler needs this, however I don't think it hurts: it simply
disables irq and takes a spinlock.

*) wall_to_monotonic must be normalized and have a posititive ts_nsec part,
see wall_to_monotonic definition and i386 usage in arch/i386/kernel/time.c.
Otherwise you can get negative tv_nsec results with
do_posix_clock_monotonic_gettime and its callers, including sys_timer_gettime.

*) Remove um_time() and um_stime() syscalls since they are identical to
system-wide ones.

*) Move clock_was_set() from do_gettimeofday to do_settimeofday. Not only from
the name you guess this is needed, but I indeed verified that for i386 it's in
arch/i386/kernel/time.c:do_settimeofday().

*) XXX: Probably do_settimeofday should be copied from i386 to replace the
current version.

*) XXX: do_[gs]ettimeofday() should use seqlocks like in i386, instead of
timer_lock() like they do. They also don't synchronize with the rest, beyond
the performance problems!

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/include/time_user.h        |    2 
 linux-2.6.git-paolo/arch/um/kernel/time.c              |   13 ++---
 linux-2.6.git-paolo/arch/um/kernel/time_kern.c         |   42 ++++++-----------
 linux-2.6.git-paolo/arch/um/sys-i386/sys_call_table.S  |    2 
 linux-2.6.git-paolo/arch/um/sys-x86_64/syscall_table.c |    7 --
 5 files changed, 23 insertions(+), 43 deletions(-)

diff -puN arch/um/kernel/time.c~uml-fix-timers arch/um/kernel/time.c
--- linux-2.6.git/arch/um/kernel/time.c~uml-fix-timers	2005-05-21 18:38:18.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/time.c	2005-05-21 18:38:18.000000000 +0200
@@ -27,7 +27,7 @@ extern struct timeval xtime;
 
 struct timeval local_offset = { 0, 0 };
 
-void timer(void)
+void userspace_timer(void)
 {
 	gettimeofday(&xtime, NULL);
 	timeradd(&xtime, &local_offset, &xtime);
@@ -97,19 +97,16 @@ void uml_idle_timer(void)
 	set_interval(ITIMER_REAL);
 }
 
-extern int do_posix_clock_monotonic_gettime(struct timespec *tp);
+extern void time_init_kern(void);
 
+/* This is called by init/main.c during early boot. */
 void time_init(void)
 {
-	struct timespec now;
-
 	if(signal(SIGVTALRM, boot_timer_handler) == SIG_ERR)
 		panic("Couldn't set SIGVTALRM handler");
 	set_interval(ITIMER_VIRTUAL);
 
-	do_posix_clock_monotonic_gettime(&now);
-	wall_to_monotonic.tv_sec = -now.tv_sec;
-	wall_to_monotonic.tv_nsec = -now.tv_nsec;
+	time_init_kern();
 }
 
 /* Declared in linux/time.h, which can't be included here */
@@ -123,7 +120,6 @@ void do_gettimeofday(struct timeval *tv)
 	gettimeofday(tv, NULL);
 	timeradd(tv, &local_offset, tv);
 	time_unlock(flags);
-	clock_was_set();
 }
 
 int do_settimeofday(struct timespec *tv)
@@ -142,6 +138,7 @@ int do_settimeofday(struct timespec *tv)
 	gettimeofday(&now, NULL);
 	timersub(&tv_in, &now, &local_offset);
 	time_unlock(flags);
+	clock_was_set();
 
 	return(0);
 }
diff -puN arch/um/kernel/time_kern.c~uml-fix-timers arch/um/kernel/time_kern.c
--- linux-2.6.git/arch/um/kernel/time_kern.c~uml-fix-timers	2005-05-21 18:38:18.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/time_kern.c	2005-05-21 18:38:18.000000000 +0200
@@ -88,52 +88,40 @@ void timer_irq(union uml_pt_regs *regs)
 	}
 }
 
+void time_init_kern(void)
+{
+	struct timespec now;
+
+	do_posix_clock_monotonic_gettime(&now);
+	set_normalized_timespec(&wall_to_monotonic, -now.tv_sec, -now.tv_nsec);
+}
+
+/* This is used during boot only, later it's replaced by
+ * user_time_init_{tt,skas} with alarm_handler, during timer_init() */
 void boot_timer_handler(int sig)
 {
+	unsigned long flags;
 	struct pt_regs regs;
 
 	CHOOSE_MODE((void) 
 		    (UPT_SC(&regs.regs) = (struct sigcontext *) (&sig + 1)),
 		    (void) (regs.regs.skas.is_user = 0));
+	write_seqlock_irqsave(&xtime_lock, flags);
 	do_timer(&regs);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
 }
 
 irqreturn_t um_timer(int irq, void *dev, struct pt_regs *regs)
 {
 	unsigned long flags;
 
-	do_timer(regs);
 	write_seqlock_irqsave(&xtime_lock, flags);
-	timer();
+	do_timer(regs);
+	userspace_timer();
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 	return(IRQ_HANDLED);
 }
 
-long um_time(int __user *tloc)
-{
-	struct timeval now;
-
-	do_gettimeofday(&now);
-	if (tloc) {
- 		if (put_user(now.tv_sec, tloc))
-			now.tv_sec = -EFAULT;
-	}
-	return now.tv_sec;
-}
-
-long um_stime(int __user *tptr)
-{
-	int value;
-	struct timespec new;
-
-	if (get_user(value, tptr))
-                return -EFAULT;
-	new.tv_sec = value;
-	new.tv_nsec = 0;
-	do_settimeofday(&new);
-	return 0;
-}
-
 void timer_handler(int sig, union uml_pt_regs *regs)
 {
 	local_irq_disable();
diff -puN arch/um/include/time_user.h~uml-fix-timers arch/um/include/time_user.h
--- linux-2.6.git/arch/um/include/time_user.h~uml-fix-timers	2005-05-21 18:38:18.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/include/time_user.h	2005-05-21 18:38:18.000000000 +0200
@@ -6,7 +6,7 @@
 #ifndef __TIME_USER_H__
 #define __TIME_USER_H__
 
-extern void timer(void);
+extern void userspace_timer(void);
 extern void switch_timers(int to_real);
 extern void set_interval(int timer_type);
 extern void idle_sleep(int secs);
diff -puN arch/um/sys-i386/sys_call_table.S~uml-fix-timers arch/um/sys-i386/sys_call_table.S
--- linux-2.6.git/arch/um/sys-i386/sys_call_table.S~uml-fix-timers	2005-05-21 18:38:18.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-i386/sys_call_table.S	2005-05-21 18:38:18.000000000 +0200
@@ -7,8 +7,6 @@
 #define sys_vm86old sys_ni_syscall
 #define sys_vm86 sys_ni_syscall
 
-#define sys_stime um_stime
-#define sys_time um_time
 #define old_mmap old_mmap_i386
 
 #include "../../i386/kernel/syscall_table.S"
diff -puN arch/um/sys-x86_64/syscall_table.c~uml-fix-timers arch/um/sys-x86_64/syscall_table.c
--- linux-2.6.git/arch/um/sys-x86_64/syscall_table.c~uml-fix-timers	2005-05-21 18:38:18.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-x86_64/syscall_table.c	2005-05-21 18:38:18.000000000 +0200
@@ -20,11 +20,8 @@
 /*#define sys_set_thread_area sys_ni_syscall
 #define sys_get_thread_area sys_ni_syscall*/
 
-/* For __NR_time. The x86-64 name hopefully will change from sys_time64 to
- * sys_time (since the current situation is bogus). I've sent a patch to cleanup
- * this. Remove below the obsoleted line. */
-#define sys_time64 um_time
-#define sys_time um_time
+/*To remove when x86_64 fixes the syscall name.*/
+#define sys_time64 sys_time
 
 /* On UML we call it this way ("old" means it's not mmap2) */
 #define sys_mmap old_mmap
_

--Boundary-00=_WNIgEUbKzTwCRT/--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
