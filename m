Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbVKSXF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbVKSXF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 18:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVKSXF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 18:05:56 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:3561 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751029AbVKSXFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 18:05:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MLjuX0V0OnHtajBGFBY/8MOzHXsrK6TxbHohh9Ulg/xzP/xnKytg8YCrHxVZJyr387wPdnRAd2fNYoc1vM39SIya7wFl6EDZPkZrkGC8MDE/KwoXqgLnmMiSpZ9hp8qehKvB/LuHduj0xmUUqda81hpYQPjbXDBWv6HYZaHcgQU=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386, nmi: signed vs unsigned mixup
Date: Sun, 20 Nov 2005 00:10:33 +0100
User-Agent: KMail/1.8.92
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511200010.33658.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/i386/kernel/nmi.c::nmi_watchdog_tick(), the variable `sum' is 
of type "int" but it's used to store the result of 
per_cpu(irq_stat, cpu).apic_timer_irqs which is an "unsigned int", it's
also later compared to last_irq_sums[cpu] which is also an 
"unsigned int", so `sum' really ought to be unsigned itself.
This small patch makes that change.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/i386/kernel/nmi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.15-rc1-git7-orig/arch/i386/kernel/nmi.c	2005-11-12 18:07:14.000000000 +0100
+++ linux-2.6.15-rc1-git7/arch/i386/kernel/nmi.c	2005-11-19 23:58:17.000000000 +0100
@@ -528,9 +528,10 @@ void nmi_watchdog_tick (struct pt_regs *
 	 * Since current_thread_info()-> is always on the stack, and we
 	 * always switch the stack NMI-atomically, it's safe to use
 	 * smp_processor_id().
 	 */
-	int sum, cpu = smp_processor_id();
+	unsigned int sum;
+	int cpu = smp_processor_id();
 
 	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
 
 	if (last_irq_sums[cpu] == sum) {



