Return-Path: <linux-kernel-owner+w=401wt.eu-S932119AbXAQJkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbXAQJkp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbXAQJkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:40:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:59953 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119AbXAQJko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:40:44 -0500
Date: Wed, 17 Jan 2007 10:39:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] fix emergency reboot: call reboot notifier list if possible
Message-ID: <20070117093917.GA7538@elte.hu>
References: <20070117091319.GA30036@elte.hu> <20070117092233.GA30197@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117092233.GA30197@flint.arm.linux.org.uk>
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


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Wed, Jan 17, 2007 at 10:13:19AM +0100, Ingo Molnar wrote:
> > we dont call the reboot notifiers during emergency reboot mainly because 
> > it could be called from atomic context and reboot notifiers are a 
> > blocking notifier list. But actually the kernel is often perfectly 
> > reschedulable in this stage, so we could as well process the 
> > reboot_notifier_list.
> 
> My experience has been that when there has been the need to use this
> facility, the kernel hasn't been reschedulable. [...]

this decision is totally automatic - so if your situation happens and 
the kernel isnt reschedulable, then the notifier chain wont be called 
and nothing changes from your perspective. Hm, perhaps this should be 
dependent on CONFIG_PREEMPT, to make sure preempt_count() is reliable?

but from my perspective this patch fixes a real regression.

updated patch attached below.

	Ingo

-------------------->
Subject: [patch] call reboot notifier list when doing an emergency reboot
From: Ingo Molnar <mingo@elte.hu>

my laptop does not reboot unless the shutdown notifiers are called
first. So the following command, which i use as a fast way to reboot
into a new kernel:

 echo b > /proc/sysrq-trigger

just hangs indefinitely after the kernel prints "System rebooting".

the thing is, that the kernel is actually reschedulable in this stage,
so we could as well process the reboot_notifier_list. (furthermore,
on -rt kernels this place is preemptable even during SysRq-b)

So just process the reboot notifier list if we are preemptable. This
will shut disk caches and chipsets off.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/sys.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux/kernel/sys.c
===================================================================
--- linux.orig/kernel/sys.c
+++ linux/kernel/sys.c
@@ -29,6 +29,7 @@
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
 #include <linux/getcpu.h>
+#include <linux/hardirq.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -710,6 +711,15 @@ out_unlock:
  */
 void emergency_restart(void)
 {
+	/*
+	 * Call the notifier chain if we are not in an
+	 * atomic context:
+	 */
+#ifdef CONFIG_PREEMPT
+	if (!in_atomic() && !irqs_disabled())
+		blocking_notifier_call_chain(&reboot_notifier_list,
+					     SYS_RESTART, NULL);
+#endif
 	machine_emergency_restart();
 }
 EXPORT_SYMBOL_GPL(emergency_restart);
