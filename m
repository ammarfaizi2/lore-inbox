Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVJUO6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVJUO6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVJUO6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:58:38 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:45303 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964973AbVJUO6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:58:37 -0400
Date: Fri, 21 Oct 2005 09:58:35 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: Matt_Domsch@dell.com
Subject: [PATCH 9/9] ipmi: add timer thread
Message-ID: <20051021145835.GI19532@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We must poll for responses to commands when interrupts aren't in use.
The default poll interval is based on using a kernel timer, which
varies with HZ.  For character-based interfaces like KCS and SMIC
though, that can be way too slow (>15 minutes to flash a new firmware
with KCS, >20 seconds to retrieve the sensor list).

This creates a low-priority kernel thread to poll more often.  If the
state machine is idle, so is the kernel thread.  But if there's an
active command, it polls quite rapidly.  This decrease a firmware
flash time from 15 minutes to 1.5 minutes, and the sensor list time to
4.5 seconds, on a Dell PowerEdge x8x system.

The timer-based polling remains, to ensure some amount of
responsiveness even under high user process CPU load.

Checking for a stopped timer at rmmod now uses atomics and
del_timer_sync() to ensure safe stoppage.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.14-rc4/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.14-rc4.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.14-rc4/drivers/char/ipmi/ipmi_si_intf.c
@@ -126,6 +126,7 @@ struct ipmi_device_id {
 
 struct smi_info
 {
+	int                    intf_num;
 	ipmi_smi_t             intf;
 	struct si_sm_data      *si_sm;
 	struct si_sm_handlers  *handlers;
@@ -193,8 +194,7 @@ struct smi_info
 	unsigned long       last_timeout_jiffies;
 
 	/* Used to gracefully stop the timer without race conditions. */
-	volatile int        stop_operation;
-	volatile int        timer_stopped;
+	atomic_t            stop_operation;
 
 	/* The driver will disable interrupts when it gets into a
 	   situation where it cannot handle messages due to lack of
@@ -221,6 +221,9 @@ struct smi_info
 	unsigned long events;
 	unsigned long watchdog_pretimeouts;
 	unsigned long incoming_messages;
+
+        struct completion exiting;
+        long              thread_pid;
 };
 
 static struct notifier_block *xaction_notifier_list;
@@ -779,6 +782,38 @@ static void set_run_to_completion(void *
 	spin_unlock_irqrestore(&(smi_info->si_lock), flags);
 }
 
+static int ipmi_thread(void *data)
+{
+	struct smi_info *smi_info = data;
+	unsigned long flags, last=1;
+	enum si_sm_result smi_result;
+
+	daemonize("kipmi%d", smi_info->intf_num);
+	allow_signal(SIGKILL);
+	set_user_nice(current, 19);
+	while (!atomic_read(&smi_info->stop_operation)) {
+		schedule_timeout(last);
+		spin_lock_irqsave(&(smi_info->si_lock), flags);
+		smi_result=smi_event_handler(smi_info, 0);
+		spin_unlock_irqrestore(&(smi_info->si_lock), flags);
+		if (smi_result == SI_SM_CALL_WITHOUT_DELAY)
+			last = 0;
+		else if (smi_result == SI_SM_CALL_WITH_DELAY) {
+			udelay(1);
+			last = 0;
+		}
+		else {
+			/* System is idle; go to sleep */
+			last = 1;
+			current->state = TASK_INTERRUPTIBLE;
+		}
+	}
+	smi_info->thread_pid = 0;
+	complete_and_exit(&(smi_info->exiting), 0);
+	return 0;
+}
+
+
 static void poll(void *send_info)
 {
 	struct smi_info *smi_info = send_info;
@@ -837,10 +872,8 @@ static void smi_timeout(unsigned long da
 	struct timeval    t;
 #endif
 
-	if (smi_info->stop_operation) {
-		smi_info->timer_stopped = 1;
+	if (atomic_read(&smi_info->stop_operation))
 		return;
-	}
 
 	spin_lock_irqsave(&(smi_info->si_lock), flags);
 #ifdef DEBUG_TIMING
@@ -913,7 +946,7 @@ static irqreturn_t si_irq_handler(int ir
 	smi_info->interrupts++;
 	spin_unlock(&smi_info->count_lock);
 
-	if (smi_info->stop_operation)
+	if (atomic_read(&smi_info->stop_operation))
 		goto out;
 
 #ifdef DEBUG_TIMING
@@ -1432,7 +1465,7 @@ static u32 ipmi_acpi_gpe(void *context)
 	smi_info->interrupts++;
 	spin_unlock(&smi_info->count_lock);
 
-	if (smi_info->stop_operation)
+	if (atomic_read(&smi_info->stop_operation))
 		goto out;
 
 #ifdef DEBUG_TIMING
@@ -2177,6 +2210,16 @@ static void setup_xaction_handlers(struc
 	setup_dell_poweredge_bt_xaction_handler(smi_info);
 }
 
+static inline void wait_for_timer_and_thread(struct smi_info *smi_info)
+{
+	if (smi_info->thread_pid > 0) {
+		/* wake the potentially sleeping thread */
+		kill_proc(smi_info->thread_pid, SIGKILL, 0);
+		wait_for_completion(&(smi_info->exiting));
+	}
+	del_timer_sync(&smi_info->si_timer);
+}
+
 /* Returns 0 if initialized, or negative on an error. */
 static int init_one_smi(int intf_num, struct smi_info **smi)
 {
@@ -2284,8 +2327,8 @@ static int init_one_smi(int intf_num, st
 	new_smi->run_to_completion = 0;
 
 	new_smi->interrupt_disabled = 0;
-	new_smi->timer_stopped = 0;
-	new_smi->stop_operation = 0;
+	atomic_set(&new_smi->stop_operation, 0);
+	new_smi->intf_num = intf_num;
 
 	/* Start clearing the flags before we enable interrupts or the
 	   timer to avoid racing with the timer. */
@@ -2303,7 +2346,14 @@ static int init_one_smi(int intf_num, st
 	new_smi->si_timer.function = smi_timeout;
 	new_smi->last_timeout_jiffies = jiffies;
 	new_smi->si_timer.expires = jiffies + SI_TIMEOUT_JIFFIES;
+
 	add_timer(&(new_smi->si_timer));
+ 	if (new_smi->si_type != SI_BT) {
+		init_completion(&(new_smi->exiting));
+		new_smi->thread_pid = kernel_thread(ipmi_thread, new_smi,
+						    CLONE_FS|CLONE_FILES|
+						    CLONE_SIGHAND);
+	}
 
 	rv = ipmi_register_smi(&handlers,
 			       new_smi,
@@ -2345,12 +2395,8 @@ static int init_one_smi(int intf_num, st
 	return 0;
 
  out_err_stop_timer:
-	new_smi->stop_operation = 1;
-
-	/* Wait for the timer to stop.  This avoids problems with race
-	   conditions removing the timer here. */
-	while (!new_smi->timer_stopped)
-		schedule_timeout_uninterruptible(1);
+	atomic_inc(&new_smi->stop_operation);
+	wait_for_timer_and_thread(new_smi);
 
  out_err:
 	if (new_smi->intf)
@@ -2456,8 +2502,7 @@ static void __exit cleanup_one_si(struct
 	spin_lock_irqsave(&(to_clean->si_lock), flags);
 	spin_lock(&(to_clean->msg_lock));
 
-	to_clean->stop_operation = 1;
-
+	atomic_inc(&to_clean->stop_operation);
 	to_clean->irq_cleanup(to_clean);
 
 	spin_unlock(&(to_clean->msg_lock));
@@ -2468,10 +2513,7 @@ static void __exit cleanup_one_si(struct
 	   interrupt. */
 	synchronize_sched();
 
-	/* Wait for the timer to stop.  This avoids problems with race
-	   conditions removing the timer here. */
-	while (!to_clean->timer_stopped)
-		schedule_timeout_uninterruptible(1);
+	wait_for_timer_and_thread(to_clean);
 
 	/* Interrupts and timeouts are stopped, now make sure the
 	   interface is in a clean state. */
