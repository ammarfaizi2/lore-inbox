Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWCZVro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWCZVro (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWCZVrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:47:43 -0500
Received: from liaag2ac.mx.compuserve.com ([149.174.40.152]:1239 "EHLO
	liaag2ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932143AbWCZVrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:47:43 -0500
Date: Sun, 26 Mar 2006 16:44:45 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] fix delay_tsc (was Re: delay_tsc(): inefficient delay
  loop (2.6.16-mm1))
To: Ray Lee <madrabbit@gmail.com>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>, John Stultz <johnstul@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>
Message-ID: <200603261647_MC3-1-BB98-CB09@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <2c0942db0603240922u7bade58lcf2a6af2af8ec6ae@mail.gmail.com>

On Fri, 24 Mar 2006 09:22:51 -0800, Ray Lee wrote:
> On 3/24/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> > +       loops += bclock;
> [...]
> > -       } while ((now-bclock) < loops);
> > +       } while (now < loops);
> 
> Erm, aren't you introducing an overflow problem here?
> 
> if loops is 2^32-1, bclock is 1, the old version would execute the
> proper number of times, the new one will blow out in one tick.

Yes, but the old version has a bug too.  I don't have 2.6.16-mm1, but
in 2.6.16 it's in arch/i386/kernel/timers/timer_tsc.c and
arch/x86_64/lib/delay.c:

static void delay_tsc(unsigned long loops)
{
        unsigned long bclock, now;

        rdtscl(bclock);
        do
        {
                rep_nop();
                rdtscl(now);
        } while ((now-bclock) < loops);
}

If (loops == 100000) and (bclock == 2^32-1) the loop will terminate
immediately when the low part of the TSC overflows because (now-bclock)
is a large number. That can't be right...

I'm running a system with this applied now.  I think there are still
problems if someone uses huge delays, though.  What keeps someone from
trying to delay for > 2^31 cycles?


i386 delay_tsc() will truncate delays when the TSC is within 'loops'
of overflow.  We must be able to handle TSC overflow both before and
after 'end', i.e. [1], [2] and [3] below.

                                               zero
                                                 |
case A (end < start)       start  [1]            |  [2]  end  [3]
                                                 |
case B (end > start)       start  [1]  end  [2]  |  [3]

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-d2.orig/arch/i386/kernel/timers/timer_tsc.c
+++ 2.6.16-d2/arch/i386/kernel/timers/timer_tsc.c
@@ -170,14 +170,22 @@ unsigned long long sched_clock(void)
 
 static void delay_tsc(unsigned long loops)
 {
-	unsigned long bclock, now;
+	unsigned long start, end, now;
 	
-	rdtscl(bclock);
-	do
-	{
-		rep_nop();
-		rdtscl(now);
-	} while ((now-bclock) < loops);
+	rdtscl(start);
+	end = start + loops;
+
+	if (unlikely(end < start)) {
+		do {
+			rep_nop();
+			rdtscl(now);
+		} while (now > start || now < end);
+	} else {
+		do {
+			rep_nop();
+			rdtscl(now);
+		} while (now > start && now < end);
+	}
 }
 
 #ifdef CONFIG_HPET_TIMER
-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"
