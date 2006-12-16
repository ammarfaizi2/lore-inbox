Return-Path: <linux-kernel-owner+w=401wt.eu-S1030711AbWLPH7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030711AbWLPH7L (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 02:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030714AbWLPH7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 02:59:10 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:34150 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030711AbWLPH7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 02:59:09 -0500
Date: Sat, 16 Dec 2006 08:56:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [patch] debugging feature: SysRq-Q to print timers
Message-ID: <20061216075658.GA16116@elte.hu>
References: <20061214225913.3338f677.akpm@osdl.org> <20061216000440.GY3388@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216000440.GY3388@stusta.de>
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


* Adrian Bunk <bunk@stusta.de> wrote:

> On Thu, Dec 14, 2006 at 10:59:13PM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.19-mm1:
> >...
> > +debugging-feature-proc-timer_list.patch
> > 
> >  Refreshed, refactored dynticks/hrtimer queue.
> >...
> 
> I'd assume sysrq_timer_list_show() wasn't intended to be unused?

correct, there's a sysrq side of it, but i forgot to send the patch to 
Andrew. Find it below.

	Ingo

----------------->
Subject: [patch] debugging feature: SysRq-Q to print timers
From: Ingo Molnar <mingo@elte.hu>

add SysRq-Q to print pending timers and other timer info.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/char/sysrq.c    |   14 +++++++++++++-
 include/linux/hrtimer.h |    3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

Index: linux/drivers/char/sysrq.c
===================================================================
--- linux.orig/drivers/char/sysrq.c
+++ linux/drivers/char/sysrq.c
@@ -36,6 +36,7 @@
 #include <linux/workqueue.h>
 #include <linux/kexec.h>
 #include <linux/irq.h>
+#include <linux/hrtimer.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
@@ -159,6 +160,17 @@ static struct sysrq_key_op sysrq_sync_op
 	.enable_mask	= SYSRQ_ENABLE_SYNC,
 };
 
+static void sysrq_handle_show_timers(int key, struct tty_struct *tty)
+{
+	sysrq_timer_list_show();
+}
+
+static struct sysrq_key_op sysrq_show_timers_op = {
+	.handler	= sysrq_handle_show_timers,
+	.help_msg	= "show-all-timers(Q)",
+	.action_msg	= "Show Pending Timers",
+};
+
 static void sysrq_handle_mountro(int key, struct tty_struct *tty)
 {
 	emergency_remount();
@@ -339,7 +351,7 @@ static struct sysrq_key_op *sysrq_key_ta
 	/* This will often be registered as 'Off' at init time */
 	NULL,				/* o */
 	&sysrq_showregs_op,		/* p */
-	NULL,				/* q */
+	&sysrq_show_timers_op,		/* q */
 	&sysrq_unraw_op,			/* r */
 	&sysrq_sync_op,			/* s */
 	&sysrq_showstate_op,		/* t */
Index: linux/include/linux/hrtimer.h
===================================================================
--- linux.orig/include/linux/hrtimer.h
+++ linux/include/linux/hrtimer.h
@@ -364,6 +364,9 @@ static inline void show_no_hz_stats(stru
 /* Bootup initialization: */
 extern void __init hrtimers_init(void);
 
+/* Show pending timers: */
+extern void sysrq_timer_list_show(void);
+
 /*
  * Timer-statistics info:
  */
