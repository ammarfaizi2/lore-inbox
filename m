Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVDUC6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVDUC6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 22:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVDUC6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 22:58:50 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:45806 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261194AbVDUC6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 22:58:45 -0400
Subject: [PATCH] Bad rounding in timeval_to_jiffies [was: Re: Odd Timer
	behavior in 2.6 vs 2.4  (1 extra tick)]
From: Steven Rostedt <rostedt@goodmis.org>
To: jdavis@accessline.com
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com>
References: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 20 Apr 2005 22:58:35 -0400
Message-Id: <1114052315.5058.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked into the problem that jdavis had and found that the conversion
of the timeval_to_jiffies was off by one. 

To convert tv.tv_sec = 0, tv.tv_usec = 10000 to jiffies, you come up
with an answer of 11 (assuming 1000 HZ).  

Here's the patch:

--- ./include/linux/jiffies.h.orig	2005-04-20 22:30:34.000000000 -0400
+++ ./include/linux/jiffies.h	2005-04-20 22:39:42.000000000 -0400
@@ -231,7 +231,7 @@
  * in jiffies (albit scaled), it is nothing but the bits we will shift
  * off.
  */
-#define USEC_ROUND (u64)(((u64)1 << USEC_JIFFIE_SC) - 1)
+#define USEC_ROUND (u64)(((u64)1 << (USEC_JIFFIE_SC - 1)))
 /*
  * The maximum jiffie value is (MAX_INT >> 1).  Here we translate that
  * into seconds.  The 64-bit case will overflow if we are not careful,


I wrote a user program that copies all of the jiffies.h and shows the
output of the conversion.  Without this patch you get:

usec=10000  jiffies = 11
usec=10010  jiffies = 11
usec=10020  jiffies = 11
   .
   .
   .
usec=10980  jiffies = 11
usec=10990  jiffies = 11
usec=11000  jiffies = 12


With the patch, you get:

usec=10000  jiffies = 10
usec=10010  jiffies = 10
usec=10020  jiffies = 10
   .
   .
   .
usec=10480  jiffies = 10
usec=10490  jiffies = 10
usec=10500  jiffies = 11
usec=10510  jiffies = 11
   .
   .
   .
usec=10990  jiffies = 11
usec=11000  jiffies = 11

Which I believe is the more desired result.

I've kept jdavis original email to show where this was discovered.

-- Steve



On Fri, 2005-04-08 at 10:39 -0700, jdavis@accessline.com wrote:
> 
> Hello, 
> 
> I've created a pretty straight forward timer using setitimer, and noticed
> some odd differences between 2.4 and 2.6, I wonder if I could get a
> clarification if this is the way it should work, or if I should continue to
> try to "fix" it.
> 
> I create a RealTime Thread( SCHED_FIFO, maxPriority-1 ) (also tried
> SCHED_RR) ...
> 
> that creates a timer ...setitimer( ITIMER_REAL, SIGALRM) with a 10 milli
> period. (I've also tried timer_create with CLOCK_REALTIME and SIGRTMIN)
> 
> and then the thread does a sem_wait() on a semaphore. 
> 
> the signal handler does a sem_post() .
> 
> 
> on 2.4.X the (idle) worst case latency is ~40 microseconds, 
> on 2.6.X the (idle) latency is about the same plus 1 tick of the scheduler
> ~1000 micro seconds... Always.. Every time.
> So to work around this on 2.6 I simply subtract 1 millisecond from my timer
> as a fudge factor and everything works as expected.
> 
> I've tried compiling various kernels (2.6.9, 2.6.11) with kernel pre-empting
> on, etc..
> 
> Is this the correct behavior? If so I'm curious who is using up the extra
> Tick?
> Does the asynch signal handler use up the whole tick even though it only has
> to sem_post()?
> 
> I am not subscribed to the list, so I would appreciate a CC.
> Thanks,
> -JD
> -

