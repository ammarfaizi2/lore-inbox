Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270706AbVBEOfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270706AbVBEOfq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 09:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbVBEOfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 09:35:46 -0500
Received: from mx1.elte.hu ([157.181.1.137]:45752 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270706AbVBEOf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 09:35:26 -0500
Date: Sat, 5 Feb 2005 15:35:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.11-rc3-mm1: softlockup and suspend/resume
Message-ID: <20050205143511.GA28656@elte.hu>
References: <20050204103350.241a907a.akpm@osdl.org> <200502051411.16194.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502051411.16194.rjw@sisk.pl>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> It looks like softlockup is not happy with suspend/resume:

Does it happen while writing out state to disk? I've attached a patch
for touch_softlockup_watchdog() below - but i think what we really need
is another mechanism. I'm wondering what the primary reason for the
lockup-detection is - did swsuspend stop the the softlockup threads?

	Ingo

--- linux/kernel/softlockup.c.orig
+++ linux/kernel/softlockup.c
@@ -20,6 +20,11 @@ static DEFINE_PER_CPU(unsigned long, tim
 static DEFINE_PER_CPU(unsigned long, print_timestamp) = 0;
 static DEFINE_PER_CPU(struct task_struct *, watchdog_task);
 
+void touch_softlockup_watchdog(void)
+{
+	per_cpu(timestamp, _smp_processor_id()) = jiffies;
+}
+
 /*
  * This callback runs from the timer interrupt, and checks
  * whether the watchdog thread has hung or not:
@@ -66,7 +71,7 @@ static int watchdog(void * __bind_cpu)
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		msleep_interruptible(HZ);
-		per_cpu(timestamp, this_cpu) = jiffies;
+		touch_softlockup_watchdog();
 	}
 	__set_current_state(TASK_RUNNING);
 
--- linux/include/linux/sched.h.orig
+++ linux/include/linux/sched.h
@@ -179,6 +179,7 @@ extern unsigned long cache_decay_ticks;
 #ifdef CONFIG_DETECT_SOFTLOCKUP
 extern void softlockup_tick(struct pt_regs *regs);
 extern void spawn_softlockup_task(void);
+extern void touch_softlockup_watchdog(void);
 #else
 static inline void softlockup_tick(struct pt_regs *regs)
 {
@@ -186,6 +187,9 @@ static inline void softlockup_tick(struc
 static inline void spawn_softlockup_task(void)
 {
 }
+static inline void touch_softlockup_watchdog(void)
+{
+}
 #endif
 
 
