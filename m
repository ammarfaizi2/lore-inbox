Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVCLPUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVCLPUu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 10:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVCLPUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 10:20:50 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:61575 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261934AbVCLPUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:20:35 -0500
Date: Sat, 12 Mar 2005 08:21:29 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "J. Bruce Fields" <bfields@fieldses.org>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] APM: fix interrupts enabled in device_power_up
In-Reply-To: <20050312131143.GA31038@fieldses.org>
Message-ID: <Pine.LNX.4.61.0503120806001.17127@montezuma.fsmlabs.com>
References: <20050312131143.GA31038@fieldses.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2005, J. Bruce Fields wrote:

> On APM resume this morning on my Thinkpad X31, I got a "spin_lock is
> already locked" error; see below.  This doesn't happen on every resume,
> though it's happened before.  The kernel is 2.6.11 plus a bunch of
> (hopefully unrelated...) NFS patches.
>
> Mar 12 07:07:31 puzzle kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
> Mar 12 07:07:31 puzzle kernel: arch/i386/kernel/time.c:179: spin_lock(arch/i386/kernel/time.c:c0603c28) already locked by arch/i386/kernel/time.c/309
> Mar 12 07:07:31 puzzle kernel: arch/i386/kernel/time.c:316: spin_unlock(arch/i386/kernel/time.c:c0603c28) not locked

APM was calling device_power_down and device_power_up with interrupts 
enabled, resulting in a few calls to get_cmos_time being done with 
interrupts enabled (rtc_lock needs to be acquired with interrupts 
disabled).

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

===== arch/i386/kernel/apm.c 1.72 vs edited =====
--- 1.72/arch/i386/kernel/apm.c	2005-01-20 22:02:11 -07:00
+++ edited/arch/i386/kernel/apm.c	2005-03-12 08:17:52 -07:00
@@ -1202,10 +1202,11 @@
 	}
 
 	device_suspend(PMSG_SUSPEND);
+	local_irq_disable();
 	device_power_down(PMSG_SUSPEND);
 
 	/* serialize with the timer interrupt */
-	write_seqlock_irq(&xtime_lock);
+	write_seqlock(&xtime_lock);
 
 	/* protect against access to timer chip registers */
 	spin_lock(&i8253_lock);
@@ -1216,20 +1217,22 @@
 	 * We'll undo any timer changes due to interrupts below.
 	 */
 	spin_unlock(&i8253_lock);
-	write_sequnlock_irq(&xtime_lock);
+	write_sequnlock(&xtime_lock);
+	local_irq_enable();
 
 	save_processor_state();
 	err = set_system_power_state(APM_STATE_SUSPEND);
 	restore_processor_state();
 
-	write_seqlock_irq(&xtime_lock);
+	local_irq_disable();
+	write_seqlock(&xtime_lock);
 	spin_lock(&i8253_lock);
 	reinit_timer();
 	set_time();
 	ignore_normal_resume = 1;
 
 	spin_unlock(&i8253_lock);
-	write_sequnlock_irq(&xtime_lock);
+	write_sequnlock(&xtime_lock);
 
 	if (err == APM_NO_ERROR)
 		err = APM_SUCCESS;
@@ -1237,6 +1240,7 @@
 		apm_error("suspend", err);
 	err = (err == APM_SUCCESS) ? 0 : -EIO;
 	device_power_up();
+	local_irq_enable();
 	device_resume();
 	pm_send_all(PM_RESUME, (void *)0);
 	queue_event(APM_NORMAL_RESUME, NULL);
@@ -1255,17 +1259,22 @@
 {
 	int	err;
 
+	local_irq_disable();
 	device_power_down(PMSG_SUSPEND);
 	/* serialize with the timer interrupt */
-	write_seqlock_irq(&xtime_lock);
+	write_seqlock(&xtime_lock);
 	/* If needed, notify drivers here */
 	get_time_diff();
-	write_sequnlock_irq(&xtime_lock);
+	write_sequnlock(&xtime_lock);
+	local_irq_enable();
 
 	err = set_system_power_state(APM_STATE_STANDBY);
 	if ((err != APM_SUCCESS) && (err != APM_NO_ERROR))
 		apm_error("standby", err);
+
+	local_irq_disable();	
 	device_power_up();
+	local_irq_enable();
 }
 
 static apm_event_t get_event(void)
