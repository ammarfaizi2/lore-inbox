Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161430AbWJKVVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161430AbWJKVVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161425AbWJKVVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:21:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:17314 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161430AbWJKVIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:08:06 -0400
Date: Wed, 11 Oct 2006 14:07:19 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, mingo@elte.hu, a.p.zijlstra@chello.nl,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 41/67] rtc: lockdep fix/workaround
Message-ID: <20061011210719.GP16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="rtc-lockdep-fix-workaround.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Peter Zijlstra <a.p.zijlstra@chello.nl>

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
Acked-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/rtc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.18.orig/drivers/char/rtc.c
+++ linux-2.6.18/drivers/char/rtc.c
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
 

--
