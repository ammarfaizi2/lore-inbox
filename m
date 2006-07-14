Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161247AbWGND6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbWGND6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 23:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWGND6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 23:58:18 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:60856 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161247AbWGND6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 23:58:18 -0400
Subject: [PATCH] remove unnecessary barrier in rtc_get_rtc_time
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Joseph Fannin <jfannin@gmail.com>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       John Stultz <johnstul@us.ibm.com>,
       Chase Venters <chase.venters@clientec.com>
In-Reply-To: <20060711074541.GA5263@elte.hu>
References: <20060709050525.GA1149@nineveh.rivenstone.net>
	 <20060708232512.12b59269.akpm@osdl.org> <20060709074543.GA4444@elte.hu>
	 <20060711051108.GA13574@nineveh.rivenstone.net>
	 <20060711074541.GA5263@elte.hu>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 23:57:53 -0400
Message-Id: <1152849473.1883.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 09:45 +0200, Ingo Molnar wrote:

> 
> ouch! That's another HPET bug i believe. AFAICS rtc_get_rtc_time() is 
> really not meant to be called from any sort of timer interrupt! In 
> particular this looping code:
> 
>         while (rtc_is_updating() != 0 && jiffies - uip_watchdog < 2*HZ/100) {
>                 barrier();
>                 cpu_relax();
>         }

Seeing this after reading the volatile thread and then Chase's patch:

([PATCH] Make cpu_relax() imply barrier() on all arches)
http://marc.theaimsgroup.com/?l=linux-kernel&m=115237514517594&w=2

(yes I'm a bit behind in my LKML reading... 1663 messages to go)

There's no reason to have a barrier in this loop.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rc1/drivers/char/rtc.c
===================================================================
--- linux-2.6.18-rc1.orig/drivers/char/rtc.c	2006-07-13 23:40:58.000000000 -0400
+++ linux-2.6.18-rc1/drivers/char/rtc.c	2006-07-13 23:41:06.000000000 -0400
@@ -1238,10 +1238,8 @@ void rtc_get_rtc_time(struct rtc_time *r
 	 * Once the read clears, read the RTC time (again via ioctl). Easy.
 	 */
 
-	while (rtc_is_updating() != 0 && jiffies - uip_watchdog < 2*HZ/100) {
-		barrier();
+	while (rtc_is_updating() != 0 && jiffies - uip_watchdog < 2*HZ/100)
 		cpu_relax();
-	}
 
 	/*
 	 * Only the values that we read from the RTC are set. We leave


