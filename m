Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262532AbTCIQSq>; Sun, 9 Mar 2003 11:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262533AbTCIQSq>; Sun, 9 Mar 2003 11:18:46 -0500
Received: from dhcp024-166-093-246.neo.rr.com ([24.166.93.246]:58502 "EHLO
	tsiar.dyndns.org") by vger.kernel.org with ESMTP id <S262532AbTCIQSo>;
	Sun, 9 Mar 2003 11:18:44 -0500
Subject: [PATCH] Re: Runaway cron task on 2.5.63/4 bk?
From: Todd Mokros <tmokros@neo.rr.com>
To: Andrew Morton <akpm@digeo.com>
Cc: cobra@compuserve.com, linux-kernel@vger.kernel.org,
       george anzinger <george@mvista.com>
In-Reply-To: <20030309001706.75467db1.akpm@digeo.com>
References: <3E6AEDA5.D4C0FC83@compuserve.com>
	 <20030309000839.31041e3e.akpm@digeo.com>
	 <20030309001706.75467db1.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047227310.1958.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 09 Mar 2003 11:28:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-09 at 03:17, Andrew Morton wrote:
> Andrew Morton <akpm@digeo.com> wrote:
> >
> > errr, OK.  This returns -EINVAL:
> > 
> > #include <time.h>
> > 
> > main()
> > {
> > 	struct timespec req;
> > 	struct timespec rem;
> > 	int ret;
> > 
> > 	req.tv_sec = 5000000;
> > 	req.tv_nsec = 0;
> > 
> > 	ret = nanosleep(&req, &rem);
> > 	if (ret)
> > 		perror("nanosleep");
> > }
> > 
> 
> OK, I give up.
> 
> 			/*
> 			 * This is a considered response, not exactly in
> 			 * line with the standard (in fact it is silent on
> 			 * possible overflows).  We assume such a large 
> 			 * value is ALMOST always a programming error and
> 			 * try not to compound it by setting a really dumb
> 			 * value.
> 			 */
> 			return -EINVAL;
> 
> George, RH7.3 and RH8.0 cron daemons are triggering this (trying to sleep
> for 4,500,000 seconds) and it causes them to go into a busy loop.
> 
> I think we need to just sleep for as long as we can and return an
> appropriate partial result.

Cron really isn't at fault, I saw sleep(52) return 4500000, which it
just passed into another sleep call.
The problem is a bug in do_clock_nanosleep. If it gets interrupted by a
signal, when it calculates the amount of time left, it doesn't check if
jiffies has advanced past the expire time, and can pass a negative value
to jiffies_to_timespec, which results in values around 4,500,000
((unsigned int)-1)/HZ, which ends up as sleep's return value.  The
following trivial patch appears to have fixed the problem on my system.
Hopefully this isn't wrapped.


--- 2.5-merge/kernel/posix-timers.c	Sun Mar  9 08:49:11 2003
+++ 2.5-snapshot/kernel/posix-timers.c	Sun Mar  9 08:49:11 2003
@@ -1282,6 +1282,9 @@
 		if (abs)
 			return -ERESTARTNOHAND;
 
+		if (time_after_eq(jiffies_f, new_timer.expires))
+			return 0;
+
 		jiffies_to_timespec(new_timer.expires - jiffies_f, tsave);
 
 		while (tsave->tv_nsec < 0) {



-- 
Todd Mokros <tmokros@neo.rr.com>
