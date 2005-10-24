Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVJXUby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVJXUby (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 16:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVJXUby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 16:31:54 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:34998 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1751260AbVJXUby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 16:31:54 -0400
X-IronPort-AV: i="3.97,245,1125896400"; 
   d="scan'208"; a="312679179:sNHT30641910"
Date: Mon, 24 Oct 2005 15:31:53 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org, minyard@acm.org
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, linux-kernel@vger.kernel.org,
       openipmi-developer@lists.sourceforge.net,
       George Anzinger <george@mvista.com>
Subject: [PATCH 2.6.14-rc5-mm1] ipmi: use kthread API
Message-ID: <20051024203153.GB25854@lists.us.dell.com>
References: <20051021145835.GI19532@i2.minyard.local> <20051023134934.1b81d9c6.akpm@osdl.org> <29495f1d0510231412n41ab2d27y41f13a9c9e62b0c2@mail.gmail.com> <435D4009.2030306@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435D4009.2030306@mvista.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ipmi driver thread to kthread API, only sleep when interface
is idle.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

Index: linux-2.6.ipmi/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.ipmi.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.ipmi/drivers/char/ipmi/ipmi_si_intf.c
@@ -52,6 +52,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/notifier.h>
+#include <linux/kthread.h>
 #include <asm/irq.h>
 #ifdef CONFIG_HIGH_RES_TIMERS
 #include <linux/hrtime.h>
@@ -222,8 +223,7 @@ struct smi_info
 	unsigned long watchdog_pretimeouts;
 	unsigned long incoming_messages;
 
-        struct completion exiting;
-        long              thread_pid;
+        struct task_struct *thread;
 };
 
 static struct notifier_block *xaction_notifier_list;
@@ -785,31 +785,22 @@ static void set_run_to_completion(void *
 static int ipmi_thread(void *data)
 {
 	struct smi_info *smi_info = data;
-	unsigned long flags, last=1;
+	unsigned long flags;
 	enum si_sm_result smi_result;
 
-	daemonize("kipmi%d", smi_info->intf_num);
-	allow_signal(SIGKILL);
 	set_user_nice(current, 19);
-	while (!atomic_read(&smi_info->stop_operation)) {
-		schedule_timeout(last);
+	while (!kthread_should_stop()) {
 		spin_lock_irqsave(&(smi_info->si_lock), flags);
 		smi_result=smi_event_handler(smi_info, 0);
 		spin_unlock_irqrestore(&(smi_info->si_lock), flags);
-		if (smi_result == SI_SM_CALL_WITHOUT_DELAY)
-			last = 0;
-		else if (smi_result == SI_SM_CALL_WITH_DELAY) {
-			udelay(1);
-			last = 0;
-		}
-		else {
-			/* System is idle; go to sleep */
-			last = 1;
-			current->state = TASK_INTERRUPTIBLE;
+		if (smi_result == SI_SM_CALL_WITHOUT_DELAY) {
+			/* do nothing */
 		}
+		else if (smi_result == SI_SM_CALL_WITH_DELAY)
+			udelay(1);
+		else
+			schedule_timeout_interruptible(1);
 	}
-	smi_info->thread_pid = 0;
-	complete_and_exit(&(smi_info->exiting), 0);
 	return 0;
 }
 
@@ -2212,11 +2203,8 @@ static void setup_xaction_handlers(struc
 
 static inline void wait_for_timer_and_thread(struct smi_info *smi_info)
 {
-	if (smi_info->thread_pid > 0) {
-		/* wake the potentially sleeping thread */
-		kill_proc(smi_info->thread_pid, SIGKILL, 0);
-		wait_for_completion(&(smi_info->exiting));
-	}
+	if (smi_info->thread != ERR_PTR(-ENOMEM))
+		kthread_stop(smi_info->thread);
 	del_timer_sync(&smi_info->si_timer);
 }
 
@@ -2348,12 +2336,9 @@ static int init_one_smi(int intf_num, st
 	new_smi->si_timer.expires = jiffies + SI_TIMEOUT_JIFFIES;
 
 	add_timer(&(new_smi->si_timer));
- 	if (new_smi->si_type != SI_BT) {
-		init_completion(&(new_smi->exiting));
-		new_smi->thread_pid = kernel_thread(ipmi_thread, new_smi,
-						    CLONE_FS|CLONE_FILES|
-						    CLONE_SIGHAND);
-	}
+ 	if (new_smi->si_type != SI_BT)
+		new_smi->thread = kthread_run(ipmi_thread, new_smi,
+					      "kipmi%d", new_smi->intf_num);
 
 	rv = ipmi_register_smi(&handlers,
 			       new_smi,
