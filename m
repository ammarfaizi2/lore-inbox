Return-Path: <linux-kernel-owner+w=401wt.eu-S932138AbXAQJOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbXAQJOM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbXAQJOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:14:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39463 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932138AbXAQJOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:14:10 -0500
Date: Wed, 17 Jan 2007 10:13:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix emergency reboot: call reboot notifier list if possible
Message-ID: <20070117091319.GA30036@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] call reboot notifier list when doing an emergency reboot
From: Ingo Molnar <mingo@elte.hu>

my laptop (Lenovo T60) hangs during reboot if the shutdown notifiers are 
not called. So the following command, which on other systems i use as a 
quick way to reboot into a new kernel:

   echo b > /proc/sysrq-trigger

just hangs indefinitely after the kernel prints "Restarting system".

we dont call the reboot notifiers during emergency reboot mainly because 
it could be called from atomic context and reboot notifiers are a 
blocking notifier list. But actually the kernel is often perfectly 
reschedulable in this stage, so we could as well process the 
reboot_notifier_list.

(furthermore, on -rt kernels this place is preemptable even during 
SysRq-b)

So just process the reboot notifier list if we are preemptable. This 
will shut disk caches and chipsets off.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/sys.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux/kernel/sys.c
===================================================================
--- linux.orig/kernel/sys.c
+++ linux/kernel/sys.c
@@ -710,6 +710,13 @@ out_unlock:
  */
 void emergency_restart(void)
 {
+	/*
+	 * Call the notifier chain if we are not in an
+	 * atomic context:
+	 */
+	if (!preempt_count() && !irqs_disabled())
+		blocking_notifier_call_chain(&reboot_notifier_list,
+					     SYS_RESTART, NULL);
 	machine_emergency_restart();
 }
 EXPORT_SYMBOL_GPL(emergency_restart);
