Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbUCAIzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbUCAIyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:54:14 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:61073 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262288AbUCAIvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:51:54 -0500
Date: Mon, 1 Mar 2004 09:51:45 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (3/5): sclp console.
Message-ID: <20040301085144.GD675@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sclp console fixes:
  - Add signal-quiesce bug-fix from 2.4.
  - Add irq_enter/irq_exit to sclp_sync_wait to prevent the softirqs from
    processing after the external interrupt.

diffstat:
 drivers/s390/char/sclp.c |   44 ++++++++++++++++++++++++++++++++------------
 1 files changed, 32 insertions(+), 12 deletions(-)

diff -urN linux-2.6/drivers/s390/char/sclp.c linux-2.6-s390/drivers/s390/char/sclp.c
--- linux-2.6/drivers/s390/char/sclp.c	Wed Feb 18 04:58:33 2004
+++ linux-2.6-s390/drivers/s390/char/sclp.c	Fri Feb 27 20:05:03 2004
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/init.h>
+#include <linux/cpumask.h>
 #include <asm/s390_ext.h>
 #include <asm/processor.h>
 
@@ -334,6 +335,8 @@
 	unsigned long psw_mask;
 	unsigned long cr0, cr0_sync;
 
+	/* Need to irq_enter() to prevent BH from executing. */
+	irq_enter();
 	/*
 	 * save cr0
 	 * enable service signal external interruption (cr0.22)
@@ -362,6 +365,7 @@
 
 	/* restore cr0 */
 	__ctl_load(cr0, 0, 0);
+	irq_exit();
 }
 
 /*
@@ -467,29 +471,45 @@
  * SCLP quiesce event handler
  */
 #ifdef CONFIG_SMP
-static cpumask_t cpu_quiesce_map;
-
 static void
 do_load_quiesce_psw(void * __unused)
 {
 	psw_t quiesce_psw;
+	unsigned long status;
+	int i;
 
-	cpu_clear(smp_processor_id(), cpu_quiesce_map);
-	if (smp_processor_id() == 0) {
-		/* Wait for all other cpus to enter do_load_quiesce_psw */
-		while (!cpus_empty(cpu_quiesce_map));
-		/* Quiesce the last cpu with the special psw */
-		quiesce_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
-		quiesce_psw.addr = 0xfff;
-		__load_psw(quiesce_psw);
+	if (smp_processor_id() != 0)
+		signal_processor(smp_processor_id(), sigp_stop);
+	/* Wait for all other cpus to enter stopped state */
+	i = 1;
+	while (i < NR_CPUS) {
+		if (!cpu_online(i)) {
+			i++;
+			continue;
+		}
+		switch (signal_processor_ps(&status, 0, i, sigp_sense)) {
+		case sigp_order_code_accepted:
+		case sigp_status_stored:
+			/* Check for stopped and check stop state */
+			if (test_bit(6, &status) || test_bit(4, &status))
+				i++;
+			break;
+		case sigp_busy:
+			break;
+		case sigp_not_operational:
+			i++;
+			break;
+		}
 	}
-	signal_processor(smp_processor_id(), sigp_stop);
+	/* Quiesce the last cpu with the special psw */
+	quiesce_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
+	quiesce_psw.addr = 0xfff;
+	__load_psw(quiesce_psw);
 }
 
 static void
 do_machine_quiesce(void)
 {
-	cpu_quiesce_map = cpu_online_map;
 	on_each_cpu(do_load_quiesce_psw, NULL, 0, 0);
 }
 #else
