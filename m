Return-Path: <linux-kernel-owner+w=401wt.eu-S1750914AbXAICL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbXAICL0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 21:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbXAICL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 21:11:26 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:44460 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbXAICL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 21:11:26 -0500
Message-Id: <200701090205.l0925lMt024381@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/7] UML - Make time data per-cpu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2007 21:05:47 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

prev_nsecs and delta need to be arrays, and indexed by CPU number.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/time.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

Index: linux-2.6.18-mm/arch/um/kernel/time.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/time.c	2007-01-08 14:55:49.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/time.c	2007-01-08 16:14:01.000000000 -0500
@@ -35,31 +35,31 @@ unsigned long long sched_clock(void)
 	return (unsigned long long)jiffies_64 * (1000000000 / HZ);
 }
 
-static unsigned long long prev_nsecs;
+static unsigned long long prev_nsecs[NR_CPUS];
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
-static long long delta;   		/* Deviation per interval */
+static long long delta[NR_CPUS];		/* Deviation per interval */
 #endif
 
 void timer_irq(union uml_pt_regs *regs)
 {
 	unsigned long long ticks = 0;
-
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
-	if(prev_nsecs){
+	int c = cpu();
+	if(prev_nsecs[c]){
 		/* We've had 1 tick */
 		unsigned long long nsecs = os_nsecs();
 
-		delta += nsecs - prev_nsecs;
-		prev_nsecs = nsecs;
+		delta[c] += nsecs - prev_nsecs[c];
+		prev_nsecs[c] = nsecs;
 
 		/* Protect against the host clock being set backwards */
-		if(delta < 0)
-			delta = 0;
+		if(delta[c] < 0)
+			delta[c] = 0;
 
-		ticks += (delta * HZ) / BILLION;
-		delta -= (ticks * BILLION) / HZ;
+		ticks += (delta[c] * HZ) / BILLION;
+		delta[c] -= (ticks * BILLION) / HZ;
 	}
-	else prev_nsecs = os_nsecs();
+	else prev_nsecs[c] = os_nsecs();
 #else
 	ticks = 1;
 #endif
@@ -69,8 +69,8 @@ void timer_irq(union uml_pt_regs *regs)
 	}
 }
 
+/* Protects local_offset */
 static DEFINE_SPINLOCK(timer_spinlock);
-
 static unsigned long long local_offset = 0;
 
 static inline unsigned long long get_time(void)

