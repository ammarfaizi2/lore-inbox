Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUFPQiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUFPQiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbUFPQh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:37:28 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:21455 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264191AbUFPQgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:36:08 -0400
Message-ID: <40D076F5.6040801@acm.org>
Date: Wed, 16 Jun 2004 11:36:05 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: IPMI base patch to fix channel handling and add polling
Content-Type: multipart/mixed;
 boundary="------------050209040006010600090909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050209040006010600090909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes some problems with handling of channel detection
in the driver.  Some systems that are IPMI 1.5 do not implement
the channel query command.  Also, the interface has to be fully
up before the command is ready.

This patch also adds a polling interface; this is required for
situations where interrupts are not running, but the system must
still issue IPMI commands, like when taking a crash dump.

It also updates the driver version to v32.


This patch is relative to 2.6.7-rc3-mm2.  Please apply.

Signed-off-by: Corey Minyard <minyard@acm.org>

Thanks,

-Corey (recovering from vacation) Minyard


--------------050209040006010600090909
Content-Type: text/plain;
 name="linux-ipmi-2.6.7-base.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-ipmi-2.6.7-base.diff"

diff -urN linux.orig/drivers/char/ipmi/ipmi_bt_sm.c linux/drivers/char/ipmi/ipmi_bt_sm.c
--- linux.orig/drivers/char/ipmi/ipmi_bt_sm.c	2004-06-14 22:32:03.000000000 -0500
+++ linux/drivers/char/ipmi/ipmi_bt_sm.c	2004-06-16 09:30:07.000000000 -0500
@@ -31,7 +31,7 @@
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
-#define IPMI_BT_VERSION "v31"
+#define IPMI_BT_VERSION "v32"
 
 static int bt_debug = 0x00;	/* Production value 0, see following flags */
 
diff -urN linux.orig/drivers/char/ipmi/ipmi_devintf.c linux/drivers/char/ipmi/ipmi_devintf.c
--- linux.orig/drivers/char/ipmi/ipmi_devintf.c	2004-06-14 22:33:31.000000000 -0500
+++ linux/drivers/char/ipmi/ipmi_devintf.c	2004-06-16 09:30:10.000000000 -0500
@@ -45,7 +45,7 @@
 #include <asm/semaphore.h>
 #include <linux/init.h>
 
-#define IPMI_DEVINTF_VERSION "v31"
+#define IPMI_DEVINTF_VERSION "v32"
 
 struct ipmi_file_private
 {
diff -urN linux.orig/drivers/char/ipmi/ipmi_kcs_sm.c linux/drivers/char/ipmi/ipmi_kcs_sm.c
--- linux.orig/drivers/char/ipmi/ipmi_kcs_sm.c	2004-05-21 11:48:44.000000000 -0500
+++ linux/drivers/char/ipmi/ipmi_kcs_sm.c	2004-06-16 09:30:15.000000000 -0500
@@ -42,7 +42,7 @@
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
-#define IPMI_KCS_VERSION "v31"
+#define IPMI_KCS_VERSION "v32"
 
 /* Set this if you want a printout of why the state machine was hosed
    when it gets hosed. */
diff -urN linux.orig/drivers/char/ipmi/ipmi_msghandler.c linux/drivers/char/ipmi/ipmi_msghandler.c
--- linux.orig/drivers/char/ipmi/ipmi_msghandler.c	2004-06-14 22:32:03.000000000 -0500
+++ linux/drivers/char/ipmi/ipmi_msghandler.c	2004-06-16 09:35:55.000000000 -0500
@@ -46,7 +46,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 
-#define IPMI_MSGHANDLER_VERSION "v31"
+#define IPMI_MSGHANDLER_VERSION "v32"
 
 struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
 static int ipmi_init_msghandler(void);
@@ -1648,6 +1648,22 @@
 		/* It's the one we want */
 		if (msg->rsp[2] != 0) {
 			/* Got an error from the channel, just go on. */
+
+			if (msg->rsp[2] == IPMI_INVALID_COMMAND_ERR) {
+				/* If the MC does not support this
+				   command, that is legal.  We just
+				   assume it has one IPMB at channel
+				   zero. */
+				intf->channels[0].medium
+					= IPMI_CHANNEL_MEDIUM_IPMB;
+				intf->channels[0].protocol
+					= IPMI_CHANNEL_PROTOCOL_IPMB;
+				rv = -ENOSYS;
+
+				intf->curr_channel = IPMI_MAX_CHANNELS;
+				wake_up(&intf->waitq);
+				goto out;
+			}
 			goto next_channel;
 		}
 		if (msg->rsp_size < 6) {
@@ -1671,10 +1687,20 @@
 			wake_up(&intf->waitq);
 
 			printk(KERN_WARNING "ipmi_msghandler: Error sending"
-			       "channel information: 0x%x\n",
+			       "channel information: %d\n",
 			       rv);
 		}
 	}
+ out:
+	return;
+}
+
+void ipmi_poll_interface(ipmi_user_t user)
+{
+	ipmi_smi_t intf = user->intf;
+
+	if (intf->handlers->poll)
+		intf->handlers->poll(intf->send_info);
 }
 
 int ipmi_register_smi(struct ipmi_smi_handlers *handlers,
@@ -3154,6 +3180,7 @@
 EXPORT_SYMBOL(ipmi_request_settime);
 EXPORT_SYMBOL(ipmi_request_supply_msgs);
 EXPORT_SYMBOL(ipmi_request_with_source);
+EXPORT_SYMBOL(ipmi_poll_interface);
 EXPORT_SYMBOL(ipmi_register_smi);
 EXPORT_SYMBOL(ipmi_unregister_smi);
 EXPORT_SYMBOL(ipmi_register_for_cmd);
diff -urN linux.orig/drivers/char/ipmi/ipmi_si_intf.c linux/drivers/char/ipmi/ipmi_si_intf.c
--- linux.orig/drivers/char/ipmi/ipmi_si_intf.c	2004-06-14 22:32:03.000000000 -0500
+++ linux/drivers/char/ipmi/ipmi_si_intf.c	2004-06-16 09:37:15.000000000 -0500
@@ -76,7 +76,7 @@
 #include "ipmi_si_sm.h"
 #include <linux/init.h>
 
-#define IPMI_SI_VERSION "v31"
+#define IPMI_SI_VERSION "v32"
 
 /* Measure times between events in the driver. */
 #undef DEBUG_TIMING
@@ -712,6 +712,13 @@
 	spin_unlock_irqrestore(&(smi_info->si_lock), flags);
 }
 
+static void poll(void *send_info)
+{
+	struct smi_info *smi_info = (struct smi_info *) send_info;
+
+	smi_event_handler(smi_info, 0);
+}
+
 static void request_events(void *send_info)
 {
 	struct smi_info *smi_info = send_info;
@@ -851,7 +858,8 @@
 	.owner                  = THIS_MODULE,
 	.sender			= sender,
 	.request_events		= request_events,
-	.set_run_to_completion  = set_run_to_completion
+	.set_run_to_completion  = set_run_to_completion,
+	.poll			= poll,
 };
 
 /* There can be 4 IO ports passed in (with or without IRQs), 4 addresses,
@@ -1848,6 +1856,21 @@
 	atomic_set(&new_smi->req_events, 0);
 	new_smi->run_to_completion = 0;
 
+	new_smi->interrupt_disabled = 0;
+	new_smi->timer_stopped = 0;
+	new_smi->stop_operation = 0;
+
+	/* The ipmi_register_smi() code does some operations to
+	   determine the channel information, so we must be ready to
+	   handle operations before it is called.  This means we have
+	   to stop the timer if we get an error after this point. */
+	init_timer(&(new_smi->si_timer));
+	new_smi->si_timer.data = (long) new_smi;
+	new_smi->si_timer.function = smi_timeout;
+	new_smi->last_timeout_jiffies = jiffies;
+	new_smi->si_timer.expires = jiffies + SI_TIMEOUT_JIFFIES;
+	add_timer(&(new_smi->si_timer));
+
 	rv = ipmi_register_smi(&handlers,
 			       new_smi,
 			       new_smi->ipmi_version_major,
@@ -1857,7 +1880,7 @@
 		printk(KERN_ERR
 		       "ipmi_si: Unable to register device: error %d\n",
 		       rv);
-		goto out_err;
+		goto out_err_stop_timer;
 	}
 
 	rv = ipmi_smi_add_proc_entry(new_smi->intf, "type",
@@ -1867,7 +1890,7 @@
 		printk(KERN_ERR
 		       "ipmi_si: Unable to create proc entry: %d\n",
 		       rv);
-		goto out_err;
+		goto out_err_stop_timer;
 	}
 
 	rv = ipmi_smi_add_proc_entry(new_smi->intf, "si_stats",
@@ -1877,7 +1900,7 @@
 		printk(KERN_ERR
 		       "ipmi_si: Unable to create proc entry: %d\n",
 		       rv);
-		goto out_err;
+		goto out_err_stop_timer;
 	}
 
 	start_clear_flags(new_smi);
@@ -1886,34 +1909,40 @@
 	if (new_smi->irq)
 		new_smi->si_state = SI_CLEARING_FLAGS_THEN_SET_IRQ;
 
-	new_smi->interrupt_disabled = 0;
-	new_smi->timer_stopped = 0;
-	new_smi->stop_operation = 0;
-
-	init_timer(&(new_smi->si_timer));
-	new_smi->si_timer.data = (long) new_smi;
-	new_smi->si_timer.function = smi_timeout;
-	new_smi->last_timeout_jiffies = jiffies;
-	new_smi->si_timer.expires = jiffies + SI_TIMEOUT_JIFFIES;
-	add_timer(&(new_smi->si_timer));
-
 	*smi = new_smi;
 
 	printk(" IPMI %s interface initialized\n", si_type[intf_num]);
 
 	return 0;
 
+ out_err_stop_timer:
+	new_smi->stop_operation = 1;
+
+	/* Wait for the timer to stop.  This avoids problems with race
+	   conditions removing the timer here. */
+	while (!new_smi->timer_stopped) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
+	}
+
  out_err:
 	if (new_smi->intf)
 		ipmi_unregister_smi(new_smi->intf);
 
 	new_smi->irq_cleanup(new_smi);
+
+	/* Wait until we know that we are out of any interrupt
+	   handlers might have been running before we freed the
+	   interrupt. */
+	synchronize_kernel();
+
 	if (new_smi->si_sm) {
 		if (new_smi->handlers)
 			new_smi->handlers->cleanup(new_smi->si_sm);
 		kfree(new_smi->si_sm);
 	}
 	new_smi->io_cleanup(new_smi);
+
 	return rv;
 }
 
diff -urN linux.orig/drivers/char/ipmi/ipmi_smic_sm.c linux/drivers/char/ipmi/ipmi_smic_sm.c
--- linux.orig/drivers/char/ipmi/ipmi_smic_sm.c	2004-05-21 11:48:44.000000000 -0500
+++ linux/drivers/char/ipmi/ipmi_smic_sm.c	2004-06-16 09:30:49.000000000 -0500
@@ -46,7 +46,7 @@
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
-#define IPMI_SMIC_VERSION "v31"
+#define IPMI_SMIC_VERSION "v32"
 
 /* smic_debug is a bit-field
  *	SMIC_DEBUG_ENABLE -	turned on for now
diff -urN linux.orig/drivers/char/ipmi/ipmi_watchdog.c linux/drivers/char/ipmi/ipmi_watchdog.c
--- linux.orig/drivers/char/ipmi/ipmi_watchdog.c	2004-05-21 11:48:44.000000000 -0500
+++ linux/drivers/char/ipmi/ipmi_watchdog.c	2004-06-16 09:30:52.000000000 -0500
@@ -51,7 +51,7 @@
 #include <asm/apic.h>
 #endif
 
-#define IPMI_WATCHDOG_VERSION "v31"
+#define IPMI_WATCHDOG_VERSION "v32"
 
 /*
  * The IPMI command/response information for the watchdog timer.
@@ -883,14 +883,12 @@
 
 	/* On a panic, if we have a panic timeout, make sure that the thing
 	   reboots, even if it hangs during that panic. */
-	if (watchdog_user && !panic_event_handled && (panic_timeout > 0)) {
+	if (watchdog_user && !panic_event_handled) {
 		/* Make sure the panic doesn't hang, and make sure we
 		   do this only once. */
 		panic_event_handled = 1;
 	    
-		timeout = panic_timeout + 120;
-		if (timeout > 255)
-			timeout = 255;
+		timeout = 255;
 		pretimeout = 0;
 		ipmi_watchdog_state = WDOG_TIMEOUT_RESET;
 		panic_halt_ipmi_set_timeout();
diff -urN linux.orig/include/linux/ipmi.h linux/include/linux/ipmi.h
--- linux.orig/include/linux/ipmi.h	2004-05-21 11:49:05.000000000 -0500
+++ linux/include/linux/ipmi.h	2004-06-16 09:34:59.000000000 -0500
@@ -373,6 +373,16 @@
 			     int                  priority);
 
 /*
+ * Do polling on the IPMI interface the user is attached to.  This
+ * causes the IPMI code to do an immediate check for information from
+ * the driver and handle anything that is immediately pending.  This
+ * will not block in anyway.  This is useful if you need to implement
+ * polling from the user like you need to send periodic watchdog pings
+ * from a crash dump, or something like that.
+ */
+void ipmi_poll_interface(ipmi_user_t user);
+
+/*
  * When commands come in to the SMS, the user can register to receive
  * them.  Only one user can be listening on a specific netfn/cmd pair
  * at a time, you will get an EBUSY error if the command is already
diff -urN linux.orig/include/linux/ipmi_msgdefs.h linux/include/linux/ipmi_msgdefs.h
--- linux.orig/include/linux/ipmi_msgdefs.h	2004-05-21 11:49:05.000000000 -0500
+++ linux/include/linux/ipmi_msgdefs.h	2004-06-16 09:04:26.000000000 -0500
@@ -71,6 +71,7 @@
 
 #define IPMI_CC_NO_ERROR		0x00
 #define IPMI_NODE_BUSY_ERR		0xc0
+#define IPMI_INVALID_COMMAND_ERR	0xc1
 #define IPMI_ERR_MSG_TRUNCATED		0xc6
 #define IPMI_LOST_ARBITRATION_ERR	0x81
 #define IPMI_ERR_UNSPECIFIED		0xff
diff -urN linux.orig/include/linux/ipmi_smi.h linux/include/linux/ipmi_smi.h
--- linux.orig/include/linux/ipmi_smi.h	2004-05-21 11:49:05.000000000 -0500
+++ linux/include/linux/ipmi_smi.h	2004-06-16 09:34:22.000000000 -0500
@@ -100,6 +100,10 @@
 	   out and that none are pending, and any new requests are run
 	   to completion immediately. */
 	void (*set_run_to_completion)(void *send_info, int run_to_completion);
+
+	/* Called to poll for work to do.  This is so upper layers can
+	   poll for operations during things like crash dumps. */
+	void (*poll)(void *send_info);
 };
 
 /* Add a low-level interface to the IPMI driver. */

--------------050209040006010600090909--

