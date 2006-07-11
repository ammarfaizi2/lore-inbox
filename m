Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWGKHvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWGKHvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWGKHvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:51:22 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:20133 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750705AbWGKHvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:51:21 -0400
Date: Tue, 11 Jul 2006 09:45:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>, Joseph Fannin <jfannin@gmail.com>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       John Stultz <johnstul@us.ibm.com>
Cc: John Stultz <johnstul@us.ibm.com>
Subject: [patch] lockdep: HPET/RTC fix
Message-ID: <20060711074541.GA5263@elte.hu>
References: <20060709050525.GA1149@nineveh.rivenstone.net> <20060708232512.12b59269.akpm@osdl.org> <20060709074543.GA4444@elte.hu> <20060711051108.GA13574@nineveh.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711051108.GA13574@nineveh.rivenstone.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5003]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Joseph Fannin <jfannin@gmail.com> wrote:

>     2.6.18-rc1-mm1, which includes this change, is printing this at 
> the same point I used to get the lockdep message:
> 
> [   25.628000] BUG: warning at kernel/lockdep.c:1803/trace_hardirqs_on()
> [   25.628000]  [<c0104a18>] show_trace_log_lvl+0x148/0x170
> [   25.628000]  [<c0105cab>] show_trace+0x1b/0x20
> [   25.628000]  [<c0105cd4>] dump_stack+0x24/0x30
> [   25.628000]  [<c014af4e>] trace_hardirqs_on+0xce/0x200
> [   25.628000]  [<c036cf21>] _spin_unlock_irq+0x31/0x70
> [   25.628000]  [<c0296584>] rtc_get_rtc_time+0x44/0x1a0
> [   25.628000]  [<c01198bb>] hpet_rtc_interrupt+0x21b/0x280
> [   25.628000]  [<c0161141>] handle_IRQ_event+0x31/0x70
> [   25.628000]  [<c0162d37>] handle_edge_irq+0xe7/0x210
> [   25.628000]  [<c0106192>] do_IRQ+0x92/0x120
> [   25.628000]  [<c0104121>] common_interrupt+0x25/0x2c
> [   25.628000]  [<b7f15410>] 0xb7f15410

ouch! That's another HPET bug i believe. AFAICS rtc_get_rtc_time() is 
really not meant to be called from any sort of timer interrupt! In 
particular this looping code:

        while (rtc_is_updating() != 0 && jiffies - uip_watchdog < 2*HZ/100) {
                barrier();
                cpu_relax();
        }

it utterly bad in any hardirq context. Also, the locking isnt 
hardirq-safe either:

        spin_lock_irq(&rtc_lock);
	...
        spin_unlock_irq(&rtc_lock);

as it will enable interrupts unconditionally - even if we are in a 
irqs-off hardirq.

John, how is this supposed to work?

	Ingo

---------------->
Subject: lockdep: HPET/RTC fix
From: Ingo Molnar <mingo@elte.hu>

Joseph Fannin reported that hpet_rtc_interrupt() enables hardirqs
in irq context:

[   25.628000]  [<c014af4e>] trace_hardirqs_on+0xce/0x200
[   25.628000]  [<c036cf21>] _spin_unlock_irq+0x31/0x70
[   25.628000]  [<c0296584>] rtc_get_rtc_time+0x44/0x1a0
[   25.628000]  [<c01198bb>] hpet_rtc_interrupt+0x21b/0x280
[   25.628000]  [<c0161141>] handle_IRQ_event+0x31/0x70
[   25.628000]  [<c0162d37>] handle_edge_irq+0xe7/0x210
[   25.628000]  [<c0106192>] do_IRQ+0x92/0x120
[   25.628000]  [<c0104121>] common_interrupt+0x25/0x2c

the call of rtc_get_rtc_time() is highly suspect. At a minimum we
need the patch below to save/restore hardirq state.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/char/rtc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux/drivers/char/rtc.c
===================================================================
--- linux.orig/drivers/char/rtc.c
+++ linux/drivers/char/rtc.c
@@ -1222,7 +1222,7 @@ static int rtc_proc_open(struct inode *i
 
 void rtc_get_rtc_time(struct rtc_time *rtc_tm)
 {
-	unsigned long uip_watchdog = jiffies;
+	unsigned long uip_watchdog = jiffies, flags;
 	unsigned char ctrl;
 #ifdef CONFIG_MACH_DECSTATION
 	unsigned int real_year;
@@ -1249,7 +1249,7 @@ void rtc_get_rtc_time(struct rtc_time *r
 	 * RTC has RTC_DAY_OF_WEEK, we should usually ignore it, as it is
 	 * only updated by the RTC when initially set to a non-zero value.
 	 */
-	spin_lock_irq(&rtc_lock);
+	spin_lock_irqsave(&rtc_lock, flags);
 	rtc_tm->tm_sec = CMOS_READ(RTC_SECONDS);
 	rtc_tm->tm_min = CMOS_READ(RTC_MINUTES);
 	rtc_tm->tm_hour = CMOS_READ(RTC_HOURS);
@@ -1263,7 +1263,7 @@ void rtc_get_rtc_time(struct rtc_time *r
 	real_year = CMOS_READ(RTC_DEC_YEAR);
 #endif
 	ctrl = CMOS_READ(RTC_CONTROL);
-	spin_unlock_irq(&rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	if (!(ctrl & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
 	{
