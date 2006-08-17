Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWHQJUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWHQJUU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWHQJUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:20:20 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:44557 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932453AbWHQJUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:20:17 -0400
Subject: Re: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever
	clock
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, takata@linux-m32r.org,
       davem@davemloft.net, wli@holomorphy.com,
       Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <1155768332.6785.58.camel@localhost.localdomain>
References: <1155768332.6785.58.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 17 Aug 2006 11:20:08 +0200
Message-Id: <1155806408.10261.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 15:45 -0700, john stultz wrote:
> My first pass at this can be found below. There are a few arches
> (specifically: m32r, s390, sparc, sparc64) where I just didn't know
> what
> to do, or where I suspect I didn't get it right, so I've CC'ed those
> maintainers for suggestions.

But it is sooo easy ;-)
See patch below.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.

---

 arch/s390/kernel/time.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/time.c linux-2.6-clock/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2006-08-17 10:34:58.000000000 +0200
+++ linux-2.6-clock/arch/s390/kernel/time.c	2006-08-17 11:05:28.000000000 +0200
@@ -40,6 +40,9 @@
 #define USECS_PER_JIFFY     ((unsigned long) 1000000/HZ)
 #define CLK_TICKS_PER_JIFFY ((unsigned long) USECS_PER_JIFFY << 12)
 
+/* The value of the TOD clock for 1.1.1970. */
+#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
+
 /*
  * Create a small time difference between the timer interrupts
  * on the different cpus to avoid lock contention.
@@ -343,8 +346,9 @@ extern void vtime_init(void);
 
 unsigned long read_persistent_clock(void)
 {
-	/* XXX I have no clue here. s390 folks, help! */
-	return 0;
+	__u64 tod = (get_clock() - TOD_UNIX_EPOCH) >> 12;
+	do_div(tod, 1000000);
+	return (unsigned long) tod;
 }
 
 /*
@@ -353,7 +357,6 @@ unsigned long read_persistent_clock(void
  */
 void __init time_init(void)
 {
-	__u64 set_time_cc;
 	int cc;
 
         /* kick the TOD clock */
@@ -378,9 +381,7 @@ void __init time_init(void)
 
 	/* set xtime */
 	xtime_cc = init_timer_cc + CLK_TICKS_PER_JIFFY;
-	set_time_cc = init_timer_cc - 0x8126d60e46000000LL +
-		(0x3c26700LL*1000000*4096);
-        tod_to_timeval(set_time_cc, &xtime);
+        tod_to_timeval(init_timer_cc - TOD_UNIX_EPOCH, &xtime);
         set_normalized_timespec(&wall_to_monotonic,
                                 -xtime.tv_sec, -xtime.tv_nsec);
 


