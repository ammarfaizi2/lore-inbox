Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVCSR1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVCSR1n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 12:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVCSR07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 12:26:59 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:37286 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261578AbVCSRZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 12:25:10 -0500
Message-ID: <423C6FD1.748BCC89@tv-sign.ru>
Date: Sat, 19 Mar 2005 21:30:41 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Lameter <christoph@lameter.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/5] timers: remove memory barriers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

del_timer() and __run_timers() use smp_wmb() before
clearing timer's pending flag. It was needed because
__mod_timer() did not locked old_base if the timer is
not pending, so __mod_timer()->internal_add_timer()
can race with del_timer()->list_del().

With the previous patch these functions are serialized
through base->lock, so the barrier can be killed.

Still needed in del_timer_sync(), because it clears ->_base.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.12-rc1/kernel/timer.c~4_BARR	2005-03-19 22:26:50.000000000 +0300
+++ 2.6.12-rc1/kernel/timer.c	2005-03-19 22:28:34.000000000 +0300
@@ -337,8 +337,6 @@ repeat:
 		goto repeat;
 	}
 	list_del(&timer->entry);
-	/* Need to make sure that anybody who sees a NULL base also sees the list ops */
-	smp_wmb();
 	__set_base(timer, base, 0);
 	spin_unlock_irqrestore(&base->lock, flags);
 
@@ -496,7 +494,6 @@ repeat:
 
 			list_del(&timer->entry);
 			set_running_timer(base, timer);
-			smp_wmb();
 			__set_base(timer, base, 0);
 			spin_unlock_irq(&base->lock);
 			{
