Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTDUVUI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTDUVUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:20:08 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:62085 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP id S262239AbTDUVTw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:19:52 -0400
Message-ID: <3EA46346.3010005@mvista.com>
Date: Mon, 21 Apr 2003 16:31:50 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: IPMI driver version 21
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000504070206080508010300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000504070206080508010300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linus,

Attached is an update to the IPMI driver to bring it to version 21. 
This release fixes some problems in the watchdog, before you had to ping
the watchdog twice before it would actually start.  It also fixes some
interrupt saving flags that were not "unsigned long", and it removes
some cruft.  This is against 2.5.68.

Thanks,

-Corey

--------------000504070206080508010300
Content-Type: text/plain;
 name="linux-ipmi-2.5.68-v21.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-ipmi-2.5.68-v21.diff"

diff -urN linux.orig/drivers/char/ipmi/ipmi_kcs_intf.c linux-main/drivers/char/ipmi/ipmi_kcs_intf.c
--- linux.orig/drivers/char/ipmi/ipmi_kcs_intf.c	Mon Apr 21 11:20:07 2003
+++ linux-main/drivers/char/ipmi/ipmi_kcs_intf.c	Mon Apr 21 13:20:10 2003
@@ -629,18 +629,6 @@
 	atomic_set(&kcs_info->req_events, 1);
 }
 
-static int new_user(void *send_info)
-{
-	if (!try_module_get(THIS_MODULE))
-		return -EBUSY;
-	return 0;
-}
-
-static void user_left(void *send_info)
-{
-	module_put(THIS_MODULE);
-}
-
 static int initialized = 0;
 
 /* Must be called with interrupts off and with the kcs_lock held. */
diff -urN linux.orig/drivers/char/ipmi/ipmi_msghandler.c linux-main/drivers/char/ipmi/ipmi_msghandler.c
--- linux.orig/drivers/char/ipmi/ipmi_msghandler.c	Mon Apr 21 11:20:07 2003
+++ linux-main/drivers/char/ipmi/ipmi_msghandler.c	Mon Apr 21 14:07:59 2003
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
@@ -431,6 +431,7 @@
 	{
 		struct seq_table *ent = &(intf->seq_table[seq]);
 		ent->timeout = ent->orig_timeout;
+		rv = 0;
 	}
 	spin_unlock_irqrestore(&(intf->seq_lock), flags);
 
@@ -1023,7 +1024,7 @@
 	int              rv;
 	ipmi_smi_t       new_intf;
 	struct list_head *entry;
-	unsigned int     flags;
+	unsigned long    flags;
 
 
 	/* Make sure the driver is actually initialized, this handles
@@ -1148,7 +1149,7 @@
 	int              rv = -ENODEV;
 	int              i;
 	struct list_head *entry;
-	unsigned int     flags;
+	unsigned long    flags;
 
 	down_write(&interfaces_sem);
 	if (list_empty(&(intf->users)))
diff -urN linux.orig/drivers/char/ipmi/ipmi_watchdog.c linux-main/drivers/char/ipmi/ipmi_watchdog.c
--- linux.orig/drivers/char/ipmi/ipmi_watchdog.c	Mon Apr 21 11:20:07 2003
+++ linux-main/drivers/char/ipmi/ipmi_watchdog.c	Mon Apr 21 11:28:33 2003
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
 
@@ -1009,7 +1025,7 @@
 
 	/*  Disable the timer. */
 	ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
-	ipmi_set_timeout();
+	ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
 
 	/* Wait to make sure the message makes it out.  The lower layer has
 	   pointers to our buffers, we want to make sure they are done before

--------------000504070206080508010300--

