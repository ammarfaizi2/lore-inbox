Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267628AbTA3VFB>; Thu, 30 Jan 2003 16:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267633AbTA3VFB>; Thu, 30 Jan 2003 16:05:01 -0500
Received: from packet.digeo.com ([12.110.80.53]:11958 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267628AbTA3VE7>;
	Thu, 30 Jan 2003 16:04:59 -0500
Message-ID: <3E3995A9.E44AD77A@digeo.com>
Date: Thu, 30 Jan 2003 13:14:17 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: john stultz <johnstul@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make lost-tick detection more informative
References: <3E39756F.6080400@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jan 2003 21:14:17.0738 (UTC) FILETIME=[8C82F6A0:01C2C8A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> The new lost-tick detection code is pretty cool,

I've actually disabled it in -mmnext, because I get too
much mail already.

If you want to slap this on top of that and some new
kernel-hacking debug config option, that would be neat.



 arch/i386/kernel/time.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+)

diff -puN arch/i386/kernel/time.c~lost-tick arch/i386/kernel/time.c
--- 25/arch/i386/kernel/time.c~lost-tick	Wed Jan 29 14:12:23 2003
+++ 25-akpm/arch/i386/kernel/time.c	Wed Jan 29 14:39:52 2003
@@ -266,6 +266,41 @@ static inline void do_timer_interrupt(in
 }
 
 /*
+ * Lost tick detection and compensation
+ */
+static inline void detect_lost_tick(void)
+{
+	/* read time since last interrupt */
+	unsigned long delta = timer->get_offset();
+	static unsigned long dbg_print;
+	
+	/* check if delta is greater then two ticks */
+	if(delta >= 2*(1000000/HZ)){
+
+		/*
+		 * only print debug info first 5 times
+		 */
+		/*
+		 * AKPM: disable this for now; it's nice, but irritating.
+		 */
+		if (0 && dbg_print < 5) {
+			printk(KERN_WARNING "\nWarning! Detected %lu "
+				"micro-second gap between interrupts.\n",
+				delta);
+			printk(KERN_WARNING "  Compensating for %lu lost "
+				"ticks.\n",
+				delta/(1000000/HZ)-1);
+			dump_stack();
+			dbg_print++;
+		}
+		/* calculate number of missed ticks */
+		delta = delta/(1000000/HZ)-1;
+		jiffies += delta;
+	}
+		
+}
+
+/*
  * This is the same as the above, except we _also_ save the current
  * Time Stamp Counter value at the time of the timer interrupt, so that
  * we later on can estimate the time of day more exactly.
@@ -281,6 +316,7 @@ void timer_interrupt(int irq, void *dev_
 	 */
 	write_lock(&xtime_lock);
 
+	detect_lost_tick();
 	timer->mark_offset();
  
 	do_timer_interrupt(irq, NULL, regs);

_
