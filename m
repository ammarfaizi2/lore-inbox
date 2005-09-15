Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVIOIv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVIOIv2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 04:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVIOIv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 04:51:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:30157 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932237AbVIOIv0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 04:51:26 -0400
Date: Thu, 15 Sep 2005 14:21:10 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, george@mvista.com, johnstul@us.ibm.com,
       nacc@us.ibm.com, schwidefsky@de.ibm.com
Subject: [PATCH 2/3] NO_IDLE_HZ support patches - add_timer_on needs a check
Message-ID: <20050915085110.GC10191@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add_timer_on needs to check if the target CPU was sleeping. If
so it should wakeup the CPU.

Patch below is against 2.6.14-rc1.


Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.14-rc1-root/kernel/timer.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN kernel/timer.c~add_timer_on kernel/timer.c
--- linux-2.6.14-rc1/kernel/timer.c~add_timer_on	2005-09-15 12:48:47.000000000 +0530
+++ linux-2.6.14-rc1-root/kernel/timer.c	2005-09-15 13:33:34.000000000 +0530
@@ -290,6 +290,11 @@ void add_timer_on(struct timer_list *tim
 	timer->base = &base->t_base;
 	internal_add_timer(base, timer);
 	spin_unlock_irqrestore(&base->t_base.lock, flags);
+#ifdef CONFIG_NO_IDLE_HZ
+	/* Wake up any sleeping CPU */
+	if (cpu_isset(cpu, nohz_cpu_mask))
+		smp_send_reschedule(cpu);
+#endif
 }
 
 

_
-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
