Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287816AbSBRVbw>; Mon, 18 Feb 2002 16:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSBRVbn>; Mon, 18 Feb 2002 16:31:43 -0500
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:61202 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S287816AbSBRVbe>; Mon, 18 Feb 2002 16:31:34 -0500
Date: Mon, 18 Feb 2002 21:30:49 +0000
From: Nick Craig-Wood <ncw@axis.demon.co.uk>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: time goes backwards periodically on laptop if booted in low-power mode
Message-ID: <20020218213049.A28604@axis.demon.co.uk>
In-Reply-To: <3C6FDB8C.9B033134@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C6FDB8C.9B033134@kegel.com>; from dank@kegel.com on Sun, Feb 17, 2002 at 08:34:20AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2002 at 08:34:20AM -0800, Dan Kegel wrote:
> My Toshiba laptop (running stock Red Hat 7.2, kernel 2.4.7-10) 
> appears to suffer from a power management-related time hiccup: when
> I boot in low-power mode, then switch to high-power mode,
> time goes backwards by 10ms several times a second.
> According to the thread
>  Subject:  [PATCH]: allow notsc option for buggy cpus
>  From:     Anton Blanchard <anton@linuxcare.com.au>
>  Date:     2001-03-10 0:58:29
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=98418670406359&w=2
> this can be fixed by disabling the TSC option, but there
> ought to be a runtime fix.  Was a runtime fix ever put
> together for this situation?

All the IBM thinkpads we have in the office have exactly this problem.
The major symptom is that ALT-TAB goes wrong in the sawfish window
manager oddly!

I made a patch to fix this (this is its first outing).  It stops
do_gettimeofday reporting a time less than it reported last time.
This isn't fixing the root cause of the problem which is interactions
between the BIOS power management and the kernel I believe, but it
does fix the problem and is really quite cheap so perhaps might be
appropriate for the main kernel.

I'd be interested to know if it fixes your problem too!

--- linux/arch/i386/kernel/time.c.orig	Sat Dec 22 10:08:04 2001
+++ linux/arch/i386/kernel/time.c	Wed Jan 23 09:14:56 2002
@@ -28,6 +28,10 @@
  * 1998-12-24 Copyright (C) 1998  Andrea Arcangeli
  *	Fixed a xtime SMP race (we need the xtime_lock rw spinlock to
  *	serialize accesses to xtime/lost_ticks).
+ * 2002-01-22    Nick Craig-Wood
+ *	Fix do_gettimeofday so that the time offset definitely won't
+ *	cause the clock to go backwards as observed previously on IBM
+ *	thinkpads with variable clock rate
  */
 
 #include <linux/errno.h>
@@ -267,9 +271,23 @@
 {
 	unsigned long flags;
 	unsigned long usec, sec;
+	static unsigned long old_usec;
+	static unsigned long old_jiffies = ~1UL;
 
 	read_lock_irqsave(&xtime_lock, flags);
 	usec = do_gettimeoffset();
+	/* make sure we don't let the time offset go backwards to fix
+           machines with variable clock rates like the IBM thinkpad -
+           Nick Craig-Wood */
+	if (jiffies == old_jiffies) {
+		if (usec < old_usec)
+			usec = old_usec;
+		else
+			old_usec = usec;
+	} else {
+		old_jiffies = jiffies;
+		old_usec = usec;
+	}
 	{
 		unsigned long lost = jiffies - wall_jiffies;
 		if (lost)



-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
