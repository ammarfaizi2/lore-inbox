Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVKZOzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVKZOzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 09:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVKZOzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 09:55:09 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:34947 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964794AbVKZOzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 09:55:05 -0500
Date: Sat, 26 Nov 2005 15:55:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 9/13] Time: i386 Conversion - part 5: Enable Generic Timekeeping
Message-ID: <20051126145509.GI12999@elte.hu>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com> <20051122013614.18537.87345.sendpatchset@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122013614.18537.87345.sendpatchset@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- clean up timeofday-arch-i386-part5.patch

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/lib/delay.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

Index: linux/arch/i386/lib/delay.c
===================================================================
--- linux.orig/arch/i386/lib/delay.c
+++ linux/arch/i386/lib/delay.c
@@ -10,23 +10,25 @@
  *	we have to worry about.
  */
 
+#include <linux/timeofday.h>
+#include <linux/module.h>
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
-#include <linux/timeofday.h>
-#include <linux/module.h>
+
 #include <asm/processor.h>
 #include <asm/delay.h>
 #include <asm/timer.h>
 
 #ifdef CONFIG_SMP
-#include <asm/smp.h>
+# include <asm/smp.h>
 #endif
 
-/* simple loop based delay */
+/* simple loop based delay: */
 static void delay_loop(unsigned long loops)
 {
 	int d0;
+
 	__asm__ __volatile__(
 		"\tjmp 1f\n"
 		".align 16\n"
@@ -37,10 +39,11 @@ static void delay_loop(unsigned long loo
 		:"0" (loops));
 }
 
-/* TSC based delay */
+/* TSC based delay: */
 static void delay_tsc(unsigned long loops)
 {
 	unsigned long bclock, now;
+
 	rdtscl(bclock);
 	do {
 		rep_nop();
@@ -48,7 +51,8 @@ static void delay_tsc(unsigned long loop
 	} while ((now-bclock) < loops);
 }
 
-/* Since we calibrate only once at boot, this
+/*
+ * Since we calibrate only once at boot, this
  * function should be set once at boot and not changed
  */
 static void (*delay_fn)(unsigned long) = delay_loop;
@@ -67,7 +71,6 @@ int read_current_timer(unsigned long *ti
 	return -1;
 }
 
-
 void __delay(unsigned long loops)
 {
 	delay_fn(loops);
@@ -76,21 +79,24 @@ void __delay(unsigned long loops)
 inline void __const_udelay(unsigned long xloops)
 {
 	int d0;
+
 	xloops *= 4;
 	__asm__("mull %0"
 		:"=d" (xloops), "=&a" (d0)
-		:"1" (xloops),"0" (cpu_data[raw_smp_processor_id()].loops_per_jiffy * (HZ/4)));
-        __delay(++xloops);
+		:"1" (xloops), "0"
+		(cpu_data[raw_smp_processor_id()].loops_per_jiffy * (HZ/4)));
+
+	__delay(++xloops);
 }
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x000010c7);  /* 2**32 / 1000000 (rounded up) */
+	__const_udelay(usecs * 0x000010c7); /* 2**32 / 1000000 (rounded up) */
 }
 
 void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(nsecs * 0x00005);  /* 2**32 / 1000000000 (rounded up) */
+	__const_udelay(nsecs * 0x00005); /* 2**32 / 1000000000 (rounded up) */
 }
 
 EXPORT_SYMBOL(__delay);
