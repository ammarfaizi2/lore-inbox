Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbTEAL5v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 07:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbTEAL5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 07:57:51 -0400
Received: from oker.escape.de ([194.120.234.254]:12466 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id S261227AbTEAL5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 07:57:44 -0400
To: linux-kernel@vger.kernel.org
Subject: tiny patch for sys_time() and sys_stime()
From: Urs Thuermann <urs@isnogud.escape.de>
Date: 01 May 2003 14:09:36 +0200
Message-ID: <m2of2m3m2n.fsf@isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of years ago, when some 2.0.x kernel was current, I did a
patch for the time() and stime() system call, which I also sent for
inclusion, AFAIR to LKML.  However I didn't get any response to it.

Now I see that the patch went partially in, i.e. for the sys_time()
syscall but not sys_stime().

These syscalls were implemented as they are still in 2.0.40-rc6 and
2.2.25 like this


    asmlinkage int sys_time(int * tloc)
    {
    	    int i;
    
    	    /* SMP: This is fairly trivial. We grab CURRENT_TIME and 
    	       stuff it to user space. No side effects */
    	    i = CURRENT_TIME;
    	    if (tloc) {
    		    if (put_user(i,tloc))
    			    i = -EFAULT;
    	    }
    	    return i;
    }

where CURRENT_TIME is defined as xtime.tv_sec and
    
    asmlinkage int sys_stime(int * tptr)
    {
    	    int value;
    
    	    if (!capable(CAP_SYS_TIME))
    		    return -EPERM;
    	    if (get_user(value, tptr))
    		    return -EFAULT;
    	    write_lock_irq(&xtime_lock);
    	    xtime.tv_sec = value;
    	    xtime.tv_usec = 0;
    	    time_adjust = 0;	/* stop active adjtime() */
    	    time_status |= STA_UNSYNC;
    	    time_maxerror = NTP_PHASE_LIMIT;
    	    time_esterror = NTP_PHASE_LIMIT;
    	    write_unlock_irq(&xtime_lock);
    	    return 0;
    }

Both calls do not take into account the hardware timer, which may
cause the time read or set to be offset by almost one tick.
sys_settimeofday() and sys_gettimeofday() do take into account the
value of the hardware timer (i8254 or tsc on x86).

My patch was to make sys_time() and sys_stime() to be just wrappers to
do_gettimeofday() and do_settimeofday().  In 2.4.17 this was done
for sys_time() but not sys_stime().  In 2.5.x the macro CURRENT_TIME
was replaced by an inline function get_seconds() which also only does
return the value of xtime.tv_sec.

I append patches for 2.0.40-rc6, 2.2.25, 2.4.20-rc1 and 2.5.68 which
make both, sys_time() and sys_stime() just wrappers for the
do_{get,set}timeofday() calls.  This looks cleaner, eliminates a small
amount of code duplication of code already present in
do_{get,set}timeofday, and it reduces the possibility of overseeing
necessary changes, like the call to clock_was_set() in the 2.5.x
version of do_settimeofday() for some architectures.

For 2.5.x and 2.6 kernels I'd actually like too see these calls
eliminated completely, as is the case for alpha and ia64 already.


urs


diff -ru linux-2.0.40-rc6/kernel/time.c linux-2.0.40-rc6-ut/kernel/time.c
--- linux-2.0.40-rc6/kernel/time.c	1998-06-04 00:17:50.000000000 +0200
+++ linux-2.0.40-rc6-ut/kernel/time.c	2003-04-04 20:14:48.000000000 +0200
@@ -52,9 +52,11 @@
  */
 asmlinkage int sys_time(int * tloc)
 {
+	struct timeval now;
 	int i;
 
-	i = CURRENT_TIME;
+	do_gettimeofday(&now);
+	i = now.tv_sec;
 	if (tloc) {
 		int error = verify_area(VERIFY_WRITE, tloc, sizeof(*tloc));
 		if (error)
@@ -73,6 +75,7 @@
 asmlinkage int sys_stime(int * tptr)
 {
 	int error, value;
+	struct timeval new_tv;
 
 	if (!suser())
 		return -EPERM;
@@ -80,15 +83,9 @@
 	if (error)
 		return error;
 	value = get_user(tptr);
-	cli();
-	xtime.tv_sec = value;
-	xtime.tv_usec = 0;
-	time_adjust = 0;	/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_state = TIME_ERROR;	/* p. 24, (a) */
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
-	sti();
+	new_tv.tv_sec  = value;
+	new_tv.tv_usec = 0;
+	do_settimeofday(&new_tv);
 	return 0;
 }
 





diff -ru linux-2.2.25/kernel/time.c linux-2.2.25-ut/kernel/time.c
--- linux-2.2.25/kernel/time.c	2001-03-25 18:31:02.000000000 +0200
+++ linux-2.2.25-ut/kernel/time.c	2003-04-04 18:18:17.000000000 +0200
@@ -73,11 +73,11 @@
  */
 asmlinkage int sys_time(int * tloc)
 {
+	struct timeval now;
 	int i;
 
-	/* SMP: This is fairly trivial. We grab CURRENT_TIME and 
-	   stuff it to user space. No side effects */
-	i = CURRENT_TIME;
+	do_gettimeofday(&now);
+	i = now.tv_sec;
 	if (tloc) {
 		if (put_user(i,tloc))
 			i = -EFAULT;
@@ -95,19 +95,15 @@
 asmlinkage int sys_stime(int * tptr)
 {
 	int value;
+	struct timeval new_tv;
 
 	if (!capable(CAP_SYS_TIME))
 		return -EPERM;
 	if (get_user(value, tptr))
 		return -EFAULT;
-	write_lock_irq(&xtime_lock);
-	xtime.tv_sec = value;
-	xtime.tv_usec = 0;
-	time_adjust = 0;	/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	new_tv.tv_sec  = value;
+	new_tv.tv_usec = 0;
+	do_settimeofday(&new_tv);
 	return 0;
 }
 





diff -ru linux-2.4.20-rc1/kernel/time.c linux-2.4.20-rc1-ut/kernel/time.c
--- linux-2.4.20-rc1/kernel/time.c	2003-04-04 17:41:41.000000000 +0200
+++ linux-2.4.20-rc1-ut/kernel/time.c	2003-04-04 20:39:14.000000000 +0200
@@ -74,21 +74,15 @@
 asmlinkage long sys_stime(int * tptr)
 {
 	int value;
+	struct timeval new_tv;
 
 	if (!capable(CAP_SYS_TIME))
 		return -EPERM;
 	if (get_user(value, tptr))
 		return -EFAULT;
-	write_lock_irq(&xtime_lock);
-	vxtime_lock();
-	xtime.tv_sec = value;
-	xtime.tv_usec = 0;
-	vxtime_unlock();
-	time_adjust = 0;	/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
-	write_unlock_irq(&xtime_lock);
+	new_tv.tv_sec  = value;
+	new_tv.tv_usec = 0;
+	do_settimeofday(&new_tv);
 	return 0;
 }
 





diff -ru linux-2.5.68/kernel/time.c linux-2.5.68-ut/kernel/time.c
--- linux-2.5.68/kernel/time.c	2003-05-01 12:26:40.000000000 +0200
+++ linux-2.5.68-ut/kernel/time.c	2003-05-01 12:29:10.000000000 +0200
@@ -49,11 +49,11 @@
  */
 asmlinkage long sys_time(int * tloc)
 {
+	struct timeval now; 
 	int i;
 
-	/* SMP: This is fairly trivial. We grab CURRENT_TIME and 
-	   stuff it to user space. No side effects */
-	i = get_seconds();
+	do_gettimeofday(&now);
+	i = now.tv_sec;
 	if (tloc) {
 		if (put_user(i,tloc))
 			i = -EFAULT;
@@ -71,20 +71,15 @@
 asmlinkage long sys_stime(int * tptr)
 {
 	int value;
+	struct timeval new_tv;
 
 	if (!capable(CAP_SYS_TIME))
 		return -EPERM;
 	if (get_user(value, tptr))
 		return -EFAULT;
-	write_seqlock_irq(&xtime_lock);
-	xtime.tv_sec = value;
-	xtime.tv_nsec = 0;
-	last_time_offset = 0;
-	time_adjust = 0;	/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
-	write_sequnlock_irq(&xtime_lock);
+	new_tv.tv_sec  = value;
+	new_tv.tv_usec = 0;
+	do_settimeofday(&new_tv);
 	return 0;
 }
 
