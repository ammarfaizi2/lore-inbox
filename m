Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTEXEVd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 00:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTEXEVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 00:21:33 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:63457 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP id S263245AbTEXEV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 00:21:26 -0400
Message-ID: <3ECEF651.5020705@acm.org>
Date: Fri, 23 May 2003 23:34:25 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: IPMI patch for current bitkeeper (CVS, really)
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090900030403020106020204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090900030403020106020204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

A patch is attached relative to what came out of the
bitkeeper-cvs converter, primarily to clean up some
things in IPMI.

It consists of:

* little cleanups to make the spacing consistent
* modifications to the watchdog so it starts the first time
  you hit it, not the second.
* Fix for returning the proper value when starting the
  sequence number timer.
* Fix a parameter name in the watchdog.

Linus, please apply.

Thanks,

-Corey

--------------090900030403020106020204
Content-Type: text/plain;
 name="linux-2.5.69-ipmi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.5.69-ipmi.diff"

Index: linux-2.5/drivers/char/ipmi/ipmi_kcs_intf.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/char/ipmi/ipmi_kcs_intf.c,v
retrieving revision 1.8
diff -u -r1.8 ipmi_kcs_intf.c
--- linux-2.5/drivers/char/ipmi/ipmi_kcs_intf.c	21 Apr 2003 17:39:45 -0000	1.8
+++ linux-2.5/drivers/char/ipmi/ipmi_kcs_intf.c	24 May 2003 03:04:35 -0000
@@ -629,20 +629,6 @@
 	atomic_set(&kcs_info->req_events, 1);
 }
 
-#if 0
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
-#endif
-
 static int initialized = 0;
 
 /* Must be called with interrupts off and with the kcs_lock held. */
Index: linux-2.5/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/char/ipmi/ipmi_msghandler.c,v
retrieving revision 1.6
diff -u -r1.6 ipmi_msghandler.c
--- linux-2.5/drivers/char/ipmi/ipmi_msghandler.c	15 May 2003 16:00:28 -0000	1.6
+++ linux-2.5/drivers/char/ipmi/ipmi_msghandler.c	24 May 2003 03:04:44 -0000
@@ -175,7 +175,7 @@
 ipmi_register_all_cmd_rcvr(ipmi_user_t user)
 {
 	unsigned long flags;
-	int rv = -EBUSY;
+	int           rv = -EBUSY;
 
 	write_lock_irqsave(&(user->intf->users_lock), flags);
 	write_lock(&(user->intf->cmd_rcvr_lock));
@@ -194,7 +194,7 @@
 ipmi_unregister_all_cmd_rcvr(ipmi_user_t user)
 {
 	unsigned long flags;
-	int rv = -EINVAL;
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
-	unsigned long     flags;
+	unsigned long    flags;
 
 
 	/* Make sure the driver is actually initialized, this handles
Index: linux-2.5/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/char/ipmi/ipmi_watchdog.c,v
retrieving revision 1.3
diff -u -r1.3 ipmi_watchdog.c
--- linux-2.5/drivers/char/ipmi/ipmi_watchdog.c	17 Apr 2003 23:30:41 -0000	1.3
+++ linux-2.5/drivers/char/ipmi/ipmi_watchdog.c	24 May 2003 03:04:46 -0000
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
@@ -1096,7 +1112,7 @@
 		else if (strcmp(option, "preop_panic") == 0) {
 			preop = "preop_panic";
 		}
-		else if (strcmp(option, "preop_none") == 0) {
+		else if (strcmp(option, "preop_give_data") == 0) {
 			preop = "preop_give_data";
 		} else {
 		    printk("Unknown IPMI watchdog option: '%s'\n", option);

--------------090900030403020106020204--

