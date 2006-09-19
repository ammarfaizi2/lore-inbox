Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752027AbWISTyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbWISTyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbWISTyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:54:40 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:3091 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1752027AbWISTyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:54:39 -0400
Subject: [PATCH] rtc: lockdep fix/workaround
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 21:54:35 +0200
Message-Id: <1158695676.28174.21.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BUG: warning at kernel/lockdep.c:1816/trace_hardirqs_on() (Not tainted)
 [<c04051ee>] show_trace_log_lvl+0x58/0x171
 [<c0405802>] show_trace+0xd/0x10
 [<c040591b>] dump_stack+0x19/0x1b
 [<c043abee>] trace_hardirqs_on+0xa2/0x11e
 [<c06143c3>] _spin_unlock_irq+0x22/0x26
 [<c0541540>] rtc_get_rtc_time+0x32/0x176
 [<c0419ba4>] hpet_rtc_interrupt+0x92/0x14d
 [<c0450f94>] handle_IRQ_event+0x20/0x4d
 [<c0451055>] __do_IRQ+0x94/0xef
 [<c040678d>] do_IRQ+0x9e/0xbd
 [<c0404a49>] common_interrupt+0x25/0x2c
DWARF2 unwinder stuck at common_interrupt+0x25/0x2c

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 drivers/char/rtc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.17.noarch/drivers/char/rtc.c
===================================================================
--- linux-2.6.17.noarch.orig/drivers/char/rtc.c	2006-09-18 21:34:11.000000000 +0200
+++ linux-2.6.17.noarch/drivers/char/rtc.c	2006-09-18 21:35:03.000000000 +0200
@@ -209,11 +209,12 @@ static const unsigned char days_in_mo[] 
  */
 static inline unsigned char rtc_is_updating(void)
 {
+	unsigned long flags;
 	unsigned char uip;
 
-	spin_lock_irq(&rtc_lock);
+	spin_lock_irqsave(&rtc_lock, flags);
 	uip = (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
-	spin_unlock_irq(&rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 	return uip;
 }
 


