Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTDVCsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 22:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTDVCsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 22:48:22 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:13787 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP id S262883AbTDVCsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 22:48:10 -0400
Message-ID: <3EA4B038.7000509@acm.org>
Date: Mon, 21 Apr 2003 22:00:08 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050708020107050301030701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050708020107050301030701
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch brings the IPMI driver in 2.4.21-rc1 up to the most
current version.

-Corey

Marcelo Tosatti wrote:

>Here goes the first candidate for 2.4.21.
>
>Please test it extensively.
>
>  
>

--------------050708020107050301030701
Content-Type: text/plain;
 name="linux-ipmi-2.4.21-rc1-v21.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-ipmi-2.4.21-rc1-v21.diff"

diff -urN linux.orig/drivers/char/ipmi/ipmi_devintf.c linux-main/drivers/char/ipmi/ipmi_devintf.c
--- linux.orig/drivers/char/ipmi/ipmi_devintf.c	Mon Apr 21 21:10:44 2003
+++ linux-main/drivers/char/ipmi/ipmi_devintf.c	Mon Apr 21 21:16:37 2003
@@ -81,9 +81,9 @@
 	unsigned int             mask = 0;
 	unsigned long            flags;
 
-	spin_lock_irqsave(&priv->recv_msg_lock, flags);
-
 	poll_wait(file, &priv->wait, wait);
+
+	spin_lock_irqsave(&priv->recv_msg_lock, flags);
 
 	if (! list_empty(&(priv->recv_msgs)))
 		mask |= (POLLIN | POLLRDNORM);
diff -urN linux.orig/drivers/char/ipmi/ipmi_kcs_intf.c linux-main/drivers/char/ipmi/ipmi_kcs_intf.c
--- linux.orig/drivers/char/ipmi/ipmi_kcs_intf.c	Mon Apr 21 21:10:44 2003
+++ linux-main/drivers/char/ipmi/ipmi_kcs_intf.c	Mon Apr 21 21:16:37 2003
@@ -60,6 +60,14 @@
 /* Measure times between events in the driver. */
 #undef DEBUG_TIMING
 
+/* Timing parameters.  Call every 10 ms when not doing anything,
+   otherwise call every KCS_SHORT_TIMEOUT_USEC microseconds. */
+#define KCS_TIMEOUT_TIME_USEC	10000
+#define KCS_USEC_PER_JIFFY	(1000000/HZ)
+#define KCS_TIMEOUT_JIFFIES	(KCS_TIMEOUT_TIME_USEC/KCS_USEC_PER_JIFFY)
+#define KCS_SHORT_TIMEOUT_USEC  250 /* .25ms when the SM request a
+                                       short timeout */
+
 #ifdef CONFIG_IPMI_KCS
 /* This forces a dependency to the config file for this option. */
 #endif
@@ -131,6 +139,8 @@
 	int                 interrupt_disabled;
 };
 
+static void kcs_restart_short_timer(struct kcs_info *kcs_info);
+
 static void deliver_recv_msg(struct kcs_info *kcs_info, struct ipmi_smi_msg *msg)
 {
 	/* Deliver the message to the upper layer with the lock
@@ -308,6 +318,9 @@
 #endif
 	switch (kcs_info->kcs_state) {
 	case KCS_NORMAL:
+		if (!kcs_info->curr_msg)
+			break;
+			
 		kcs_info->curr_msg->rsp_size
 			= kcs_get_result(kcs_info->kcs_sm,
 					 kcs_info->curr_msg->rsp,
@@ -562,8 +575,9 @@
 		spin_lock_irqsave(&(kcs_info->kcs_lock), flags);
 		result = kcs_event_handler(kcs_info, 0);
 		while (result != KCS_SM_IDLE) {
-			udelay(500);
-			result = kcs_event_handler(kcs_info, 500);
+			udelay(KCS_SHORT_TIMEOUT_USEC);
+			result = kcs_event_handler(kcs_info,
+						   KCS_SHORT_TIMEOUT_USEC);
 		}
 		spin_unlock_irqrestore(&(kcs_info->kcs_lock), flags);
 		return;
@@ -581,6 +595,7 @@
 	    && (kcs_info->curr_msg == NULL))
 	{
 		start_next_msg(kcs_info);
+		kcs_restart_short_timer(kcs_info);
 	}
 	spin_unlock_irqrestore(&(kcs_info->kcs_lock), flags);
 }
@@ -597,8 +612,9 @@
 	if (i_run_to_completion) {
 		result = kcs_event_handler(kcs_info, 0);
 		while (result != KCS_SM_IDLE) {
-			udelay(500);
-			result = kcs_event_handler(kcs_info, 500);
+			udelay(KCS_SHORT_TIMEOUT_USEC);
+			result = kcs_event_handler(kcs_info,
+						   KCS_SHORT_TIMEOUT_USEC);
 		}
 	}
 
@@ -624,14 +640,40 @@
 	MOD_DEC_USE_COUNT;
 }
 
-/* Call every 10 ms. */
-#define KCS_TIMEOUT_TIME_USEC	10000
-#define KCS_USEC_PER_JIFFY	(1000000/HZ)
-#define KCS_TIMEOUT_JIFFIES	(KCS_TIMEOUT_TIME_USEC/KCS_USEC_PER_JIFFY)
-#define KCS_SHORT_TIMEOUT_USEC  500 /* .5ms when the SM request a
-                                       short timeout */
 static int initialized = 0;
 
+/* Must be called with interrupts off and with the kcs_lock held. */
+static void kcs_restart_short_timer(struct kcs_info *kcs_info)
+{
+#ifdef CONFIG_HIGH_RES_TIMERS
+	unsigned long jiffies_now;
+
+	if (del_timer(&(kcs_info->kcs_timer))) {
+		/* If we don't delete the timer, then it will go off
+		   immediately, anyway.  So we only process if we
+		   actually delete the timer. */
+
+		/* We already have irqsave on, so no need for it
+                   here. */
+		read_lock(&xtime_lock);
+		jiffies_now = jiffies;
+		kcs_info->kcs_timer.expires = jiffies_now;
+
+		kcs_info->kcs_timer.sub_expires
+			= quick_update_jiffies_sub(jiffies_now);
+		read_unlock(&xtime_lock);
+
+		kcs_info->kcs_timer.sub_expires
+			+= usec_to_arch_cycles(KCS_SHORT_TIMEOUT_USEC);
+		while (kcs_info->kcs_timer.sub_expires >= cycles_per_jiffies) {
+			kcs_info->kcs_timer.expires++;
+			kcs_info->kcs_timer.sub_expires -= cycles_per_jiffies;
+		}
+		add_timer(&(kcs_info->kcs_timer));
+	}
+#endif
+}
+
 static void kcs_timeout(unsigned long data)
 {
 	struct kcs_info *kcs_info = (struct kcs_info *) data;
@@ -654,12 +696,11 @@
 	printk("**Timer: %d.%9.9d\n", t.tv_sec, t.tv_usec);
 #endif
 	jiffies_now = jiffies;
+
 	time_diff = ((jiffies_now - kcs_info->last_timeout_jiffies)
 		     * KCS_USEC_PER_JIFFY);
 	kcs_result = kcs_event_handler(kcs_info, time_diff);
 
-	spin_unlock_irqrestore(&(kcs_info->kcs_lock), flags);
-
 	kcs_info->last_timeout_jiffies = jiffies_now;
 
 	if ((kcs_info->irq) && (! kcs_info->interrupt_disabled)) {
@@ -680,6 +721,7 @@
 		}
 	} else {
 		kcs_info->kcs_timer.expires = jiffies + KCS_TIMEOUT_JIFFIES;
+		kcs_info->kcs_timer.sub_expires = 0;
 	}
 #else
 	/* If requested, take the shortest delay possible */
@@ -692,6 +734,7 @@
 
  do_add_timer:
 	add_timer(&(kcs_info->kcs_timer));
+	spin_unlock_irqrestore(&(kcs_info->kcs_lock), flags);
 }
 
 static void kcs_irq_handler(int irq, void *data, struct pt_regs *regs)
@@ -838,7 +881,7 @@
 	if (kcs_port && kcs_physaddr)
 		return -EINVAL;
 
-	new_kcs = kmalloc(kcs_size(), GFP_KERNEL);
+	new_kcs = kmalloc(sizeof(*new_kcs), GFP_KERNEL);
 	if (!new_kcs) {
 		printk(KERN_ERR "ipmi_kcs: out of memory\n");
 		return -ENOMEM;
diff -urN linux.orig/drivers/char/ipmi/ipmi_kcs_sm.c linux-main/drivers/char/ipmi/ipmi_kcs_sm.c
--- linux.orig/drivers/char/ipmi/ipmi_kcs_sm.c	Mon Apr 21 21:10:44 2003
+++ linux-main/drivers/char/ipmi/ipmi_kcs_sm.c	Mon Apr 21 21:16:37 2003
@@ -468,7 +468,7 @@
 		break;
 			
 	case KCS_HOSED:
-		return KCS_SM_HOSED;
+		break;
 	}
 
 	if (kcs->state == KCS_HOSED) {
diff -urN linux.orig/drivers/char/ipmi/ipmi_msghandler.c linux-main/drivers/char/ipmi/ipmi_msghandler.c
--- linux.orig/drivers/char/ipmi/ipmi_msghandler.c	Mon Apr 21 21:10:44 2003
+++ linux-main/drivers/char/ipmi/ipmi_msghandler.c	Mon Apr 21 21:16:37 2003
@@ -174,8 +174,8 @@
 int
 ipmi_register_all_cmd_rcvr(ipmi_user_t user)
 {
-	int flags;
-	int rv = -EBUSY;
+	unsigned long flags;
+	int           rv = -EBUSY;
 
 	write_lock_irqsave(&(user->intf->users_lock), flags);
 	write_lock(&(user->intf->cmd_rcvr_lock));
@@ -193,8 +193,8 @@
 int
 ipmi_unregister_all_cmd_rcvr(ipmi_user_t user)
 {
-	int flags;
-	int rv = -EINVAL;
+	unsigned long flags;
+	int           rv = -EINVAL;
 
 	write_lock_irqsave(&(user->intf->users_lock), flags);
 	write_lock(&(user->intf->cmd_rcvr_lock));
@@ -1022,7 +1022,7 @@
 	int              rv;
 	ipmi_smi_t       new_intf;
 	struct list_head *entry;
-	unsigned int     flags;
+	unsigned long    flags;
 
 
 	/* Make sure the driver is actually initialized, this handles
@@ -1156,7 +1156,7 @@
 	int              rv = -ENODEV;
 	int              i;
 	struct list_head *entry;
-	unsigned int     flags;
+	unsigned long    flags;
 
 	down_write(&interfaces_sem);
 	if (list_empty(&(intf->users)))
@@ -1773,9 +1773,13 @@
 }
 
 
+static atomic_t smi_msg_inuse_count = ATOMIC_INIT(0);
+static atomic_t recv_msg_inuse_count = ATOMIC_INIT(0);
+
 /* FIXME - convert these to slabs. */
 static void free_smi_msg(struct ipmi_smi_msg *msg)
 {
+	atomic_dec(&smi_msg_inuse_count);
 	kfree(msg);
 }
 
@@ -1783,13 +1787,16 @@
 {
 	struct ipmi_smi_msg *rv;
 	rv = kmalloc(sizeof(struct ipmi_smi_msg), GFP_ATOMIC);
-	if (rv)
+	if (rv) {
 		rv->done = free_smi_msg;
+		atomic_inc(&smi_msg_inuse_count);
+	}
 	return rv;
 }
 
 static void free_recv_msg(struct ipmi_recv_msg *msg)
 {
+	atomic_dec(&recv_msg_inuse_count);
 	kfree(msg);
 }
 
@@ -1798,8 +1805,10 @@
 	struct ipmi_recv_msg *rv;
 
 	rv = kmalloc(sizeof(struct ipmi_recv_msg), GFP_ATOMIC);
-	if (rv)
+	if (rv) {
 		rv->done = free_recv_msg;
+		atomic_inc(&recv_msg_inuse_count);
+	}
 	return rv;
 }
 
@@ -1932,6 +1941,8 @@
 
 static __exit void cleanup_ipmi(void)
 {
+	int count;
+
 	if (!initialized)
 		return;
 
@@ -1948,6 +1959,16 @@
 	}
 
 	initialized = 0;
+
+	/* Check for buffer leaks. */
+	count = atomic_read(&smi_msg_inuse_count);
+	if (count != 0)
+		printk("ipmi_msghandler: SMI message count %d at exit\n",
+		       count);
+	count = atomic_read(&recv_msg_inuse_count);
+	if (count != 0)
+		printk("ipmi_msghandler: recv message count %d at exit\n",
+		       count);
 }
 module_exit(cleanup_ipmi);
 
diff -urN linux.orig/drivers/char/ipmi/ipmi_watchdog.c linux-main/drivers/char/ipmi/ipmi_watchdog.c
--- linux.orig/drivers/char/ipmi/ipmi_watchdog.c	Mon Apr 21 21:10:44 2003
+++ linux-main/drivers/char/ipmi/ipmi_watchdog.c	Mon Apr 21 21:16:37 2003
@@ -215,13 +215,13 @@
 			      struct ipmi_recv_msg *recv_msg,
 			      int                  *send_heartbeat_now)
 {
-	struct ipmi_msg    msg;
-	unsigned char      data[6];
-	int                rv;
+	struct ipmi_msg                   msg;
+	unsigned char                     data[6];
+	int                               rv;
 	struct ipmi_system_interface_addr addr;
+	int                               hbnow = 0;
 
 
-	*send_heartbeat_now = 0;
 	data[0] = 0;
 	WDOG_SET_TIMER_USE(data[0], WDOG_TIMER_USE_SMS_OS);
 
@@ -233,7 +233,7 @@
 	} else if (ipmi_watchdog_state != WDOG_TIMEOUT_NONE) {
 		/* In ipmi 1.0, setting the timer stops the watchdog, we
 		   need to start it back up again. */
-		*send_heartbeat_now = 1;
+		hbnow = 1;
 	}
 
 	data[1] = 0;
@@ -268,10 +268,18 @@
 		       rv);
 	}
 
+	if (send_heartbeat_now)
+	    *send_heartbeat_now = hbnow;
+
 	return rv;
 }
 
-static int ipmi_set_timeout(void)
+/* Parameters to ipmi_set_timeout */
+#define IPMI_SET_TIMEOUT_NO_HB			0
+#define IPMI_SET_TIMEOUT_HB_IF_NECESSARY	1
+#define IPMI_SET_TIMEOUT_FORCE_HB		2
+
+static int ipmi_set_timeout(int do_heartbeat)
 {
 	int send_heartbeat_now;
 	int rv;
@@ -288,8 +296,12 @@
 	if (rv) {
 		up(&set_timeout_lock);
 	} else {
-		if (send_heartbeat_now)
+		if ((do_heartbeat == IPMI_SET_TIMEOUT_FORCE_HB)
+		    || ((send_heartbeat_now)
+			&& (do_heartbeat == IPMI_SET_TIMEOUT_HB_IF_NECESSARY)))
+		{
 			rv = ipmi_heartbeat();
+		}
 	}
 
 	return rv;
@@ -312,7 +324,7 @@
 
 /* Special call, doesn't claim any locks.  This is only to be called
    at panic or halt time, in run-to-completion mode, when the caller
-   is the only CPU and the only thing that will be going IPMI
+   is the only CPU and the only thing that will be going is these IPMI
    calls. */
 static void panic_halt_ipmi_set_timeout(void)
 {
@@ -339,7 +351,7 @@
 	else
 		ipmi_watchdog_state = WDOG_TIMEOUT_RESET;
 	timeout = delay;
-	ipmi_set_timeout();
+	ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
 }
 
 /* We use a semaphore to make sure that only one thing can send a
@@ -390,16 +402,14 @@
 	if (ipmi_start_timer_on_heartbeat) {
 		ipmi_start_timer_on_heartbeat = 0;
 		ipmi_watchdog_state = action_val;
-		return ipmi_set_timeout();
-	}
-
-	if (pretimeout_since_last_heartbeat) {
+		return ipmi_set_timeout(IPMI_SET_TIMEOUT_FORCE_HB);
+	} else if (pretimeout_since_last_heartbeat) {
 		/* A pretimeout occurred, make sure we set the timeout.
 		   We don't want to set the action, though, we want to
 		   leave that alone (thus it can't be combined with the
 		   above operation. */
 		pretimeout_since_last_heartbeat = 0;
-		return ipmi_set_timeout();
+		return ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
 	}
 
 	down(&heartbeat_lock);
@@ -501,7 +511,7 @@
 		if (i)
 			return -EFAULT;
 		timeout = val;
-		return ipmi_set_timeout();
+		return ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
 
 	case WDIOC_GETTIMEOUT:
 		i = copy_to_user((void *) arg,
@@ -516,7 +526,7 @@
 		if (i)
 			return -EFAULT;
 		pretimeout = val;
-		return ipmi_set_timeout();
+		return ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
 
 	case WDIOC_GET_PRETIMEOUT:
 		i = copy_to_user((void *) arg,
@@ -536,14 +546,14 @@
 		if (val & WDIOS_DISABLECARD)
 		{
 			ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
-			ipmi_set_timeout();
+			ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
 			ipmi_start_timer_on_heartbeat = 0;
 		}
 
 		if (val & WDIOS_ENABLECARD)
 		{
 			ipmi_watchdog_state = action_val;
-			ipmi_set_timeout();
+			ipmi_set_timeout(IPMI_SET_TIMEOUT_FORCE_HB);
 		}
 		return 0;
 
@@ -679,7 +689,7 @@
 	{
 #ifndef CONFIG_WATCHDOG_NOWAYOUT	
 		ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
-		ipmi_set_timeout();
+		ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
 #endif		
 	        ipmi_wdog_open = 0;
 	}
@@ -731,14 +741,14 @@
 			wake_up_interruptible(&read_q);
 			kill_fasync(&fasync_q, SIGIO, POLL_IN);
 
-			/* On some machines, the heartbeat will give
-			   an error and not work unless we re-enable
-			   the timer.   So do so. */
-			pretimeout_since_last_heartbeat = 1;
-
 			spin_unlock(&ipmi_read_lock);
 		}
 	}
+
+	/* On some machines, the heartbeat will give
+	   an error and not work unless we re-enable
+	   the timer.   So do so. */
+	pretimeout_since_last_heartbeat = 1;
 }
 
 static struct ipmi_user_hndl ipmi_hndlrs =
@@ -751,7 +761,7 @@
 {
 	int rv = -EBUSY;
 
-	down_read(&register_sem);
+	down_write(&register_sem);
 	if (watchdog_user)
 		goto out;
 
@@ -779,7 +789,7 @@
 		/* Run from startup, so start the timer now. */
 		start_now = 0; /* Disable this function after first startup. */
 		ipmi_watchdog_state = action_val;
-		ipmi_set_timeout();
+		ipmi_set_timeout(IPMI_SET_TIMEOUT_FORCE_HB);
 		printk("Starting IPMI Watchdog now!\n");
 	}
 }
@@ -792,6 +802,12 @@
            watchdog. */
 	if ((!handled) && (preop_val == WDOG_PREOP_PANIC))
 		panic("IPMI watchdog pre-timeout");
+
+	/* On some machines, the heartbeat will give
+	   an error and not work unless we re-enable
+	   the timer.   So do so. */
+	pretimeout_since_last_heartbeat = 1;
+
 	return NOTIFY_DONE;
 }
 
@@ -916,7 +932,7 @@
 	} else if (strcmp(preaction, "pre_int") == 0) {
 		preaction_val = WDOG_PRETIMEOUT_MSG_INT;
 	} else {
-		action_val = WDOG_PRETIMEOUT_NONE;
+		preaction_val = WDOG_PRETIMEOUT_NONE;
 		printk("ipmi_watchdog: Unknown preaction '%s', defaulting to"
 		       " none\n", preaction);
 	}
@@ -928,7 +944,7 @@
 	} else if (strcmp(preop, "preop_give_data") == 0) {
 		preop_val = WDOG_PREOP_GIVE_DATA;
 	} else {
-		action_val = WDOG_PREOP_NONE;
+		preop_val = WDOG_PREOP_NONE;
 		printk("ipmi_watchdog: Unknown preop '%s', defaulting to"
 		       " none\n", preop);
 	}
@@ -1008,7 +1024,7 @@
 
 	/*  Disable the timer. */
 	ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
-	ipmi_set_timeout();
+	ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
 
 	/* Wait to make sure the message makes it out.  The lower layer has
 	   pointers to our buffers, we want to make sure they are done before
--- linux.orig/kernel/ksyms.c	Mon Apr 21 21:11:04 2003
+++ linux-main/kernel/ksyms.c	Mon Apr 21 21:55:11 2003
@@ -65,6 +65,7 @@
 extern int request_dma(unsigned int dmanr, char * deviceID);
 extern void free_dma(unsigned int dmanr);
 extern spinlock_t dma_spin_lock;
+extern int panic_timeout;
 
 #ifdef CONFIG_MODVERSIONS
 const struct module_symbol __export_Using_Versions
@@ -471,6 +472,8 @@
 
 /* misc */
 EXPORT_SYMBOL(panic);
+EXPORT_SYMBOL(panic_notifier_list);
+EXPORT_SYMBOL(panic_timeout);
 EXPORT_SYMBOL(__out_of_line_bug);
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(snprintf);

--------------050708020107050301030701--

