Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbTHVBR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 21:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbTHVBR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 21:17:26 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:5789 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S262994AbTHVBRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 21:17:23 -0400
Date: Fri, 22 Aug 2003 10:18:40 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Andrea Arcangeli <andrea@suse.de>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: Possible race condition in i386 global_irq_lock handling.
Message-ID: <20030822011840.GA14540@atj.dyndns.org>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Andrea Arcangeli <andrea@suse.de>, manfred@colorfullife.com,
	linux-kernel@vger.kernel.org, zwane@linuxpower.ca
References: <3F44FAF3.8020707@colorfullife.com> <20030821172721.GI29612@dualathlon.random> <20030821234824.37497c08.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821234824.37497c08.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I'm attaching patch for i386. It makes three changes.

 1. add smp_mb() between local_irq_count++ and global_irq_lock test
    in irq_enter().
 2. add smp_mb__after_clear_bit() before irqs_running() test in
    wait_on_irq().
 3. remove irqs_running() test from synchronize_irq()

 Removing irqs_running() test from synchronize_irq() is needed for the
same reason. Other interrupts might be running on successful return
from synchronize_irq().

 smp_mb__after_clear_bit() should be smp_mb__after_test_and_set_bit()
which doesn't exist. Should I add this?

 After determining smp_mb__after_clear_bit(), I'll make a patch for
every affected architecture. Please comment.

# ------------ patch follows --------------

diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Fri Aug 22 10:07:50 2003
+++ b/arch/i386/kernel/irq.c	Fri Aug 22 10:07:50 2003
@@ -271,6 +271,8 @@
 		 * for bottom half handlers unless we're
 		 * already executing in one..
 		 */
+		smp_mb__after_clear_bit(); /* Synchronize with irq_enter() */
+
 		if (!irqs_running())
 			if (local_bh_count(cpu) || !spin_is_locked(&global_bh_lock))
 				break;
@@ -307,11 +309,9 @@
  */
 void synchronize_irq(void)
 {
-	if (irqs_running()) {
-		/* Stupid approach */
-		cli();
-		sti();
-	}
+	/* Stupid approach */
+	cli();
+	sti();
 }
 
 static inline void get_irqlock(int cpu)
diff -Nru a/include/asm-i386/hardirq.h b/include/asm-i386/hardirq.h
--- a/include/asm-i386/hardirq.h	Fri Aug 22 10:07:50 2003
+++ b/include/asm-i386/hardirq.h	Fri Aug 22 10:07:50 2003
@@ -67,6 +67,8 @@
 {
 	++local_irq_count(cpu);
 
+	smp_mb(); /* Synchronize with wait_on_irq() */
+
 	while (test_bit(0,&global_irq_lock)) {
 		cpu_relax();
 	}
