Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUHBRGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUHBRGd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 13:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266661AbUHBRGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 13:06:30 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:27411 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S266643AbUHBRFs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 13:05:48 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Corey Minyard <minyard@acm.org>
Subject: Re: IPMI watchdog question
Date: Mon, 2 Aug 2004 19:05:28 +0200
User-Agent: KMail/1.6.2
Cc: Holger Kiehl <Holger.Kiehl@dwd.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0407280901330.31636@praktifix.dwd.de> <200408021829.18228.arekm@pld-linux.org> <410E710E.20004@acm.org>
In-Reply-To: <410E710E.20004@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408021905.28112.arekm@pld-linux.org>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Points assigned by spam scoring system to this email. Note that message
	is treated as spam ONLY if X-Spam-Flag header is set to YES.
	If you have any report questions, see report postmaster@beep.pl for details.
	Content analysis details:   (0.0 points, 25.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 of August 2004 18:51, Corey Minyard wrote:

> Your patch looks very good.  Could you add the test and set change,
> too?  Then I think it is ready to go in.
Added.

- support disabling watchdog by writting ,,V'' to device.
- unify printk()
- use atomic bit operations on ipmi_wdog_open

Signed-off-by: Arkadiusz Miskiewicz <arekm@pld-linux.org>

--- linux.org/drivers/char/ipmi/ipmi_watchdog.c.org	2004-08-02 18:03:52.400100664 +0200
+++ linux/drivers/char/ipmi/ipmi_watchdog.c	2004-08-02 19:00:14.149996536 +0200
@@ -51,6 +51,8 @@
 #include <asm/apic.h>
 #endif
 
+#define	PFX "IPMI Watchdog: "
+
 #define IPMI_WATCHDOG_VERSION "v32"
 
 /*
@@ -160,6 +162,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(read_q);
 static struct fasync_struct *fasync_q = NULL;
 static char pretimeout_since_last_heartbeat = 0;
+static char expect_close;
 
 /* If true, the driver will start running as soon as it is configured
    and ready. */
@@ -191,7 +194,7 @@
 static int ipmi_ignore_heartbeat = 0;
 
 /* Is someone using the watchdog?  Only one user is allowed. */
-static int ipmi_wdog_open = 0;
+static unsigned long ipmi_wdog_open = 0;
 
 /* If set to 1, the heartbeat command will set the state to reset and
    start the timer.  The timer doesn't normally run when the driver is
@@ -287,7 +290,7 @@
 				      recv_msg,
 				      1);
 	if (rv) {
-		printk(KERN_WARNING "IPMI Watchdog, set timeout error: %d\n",
+		printk(KERN_WARNING PFX "set timeout error: %d\n",
 		       rv);
 	}
 
@@ -464,7 +467,7 @@
 				      1);
 	if (rv) {
 		up(&heartbeat_lock);
-		printk(KERN_WARNING "IPMI Watchdog, heartbeat failure: %d\n",
+		printk(KERN_WARNING PFX "heartbeat failure: %d\n",
 		       rv);
 		return rv;
 	}
@@ -603,6 +606,21 @@
 		return -ESPIPE;
 
 	if (len) {
+	    	if (!nowayout) {
+		    	size_t i;
+
+			/* In case it was set long ago */
+			expect_close = 0;
+			
+    			for (i = 0; i != len; i++) {
+				char c;
+
+				if (get_user(c, buf + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_close = 42;
+			}
+		}
 		rv = ipmi_heartbeat();
 		if (rv)
 			return rv;
@@ -670,11 +688,9 @@
         switch (iminor(ino))
         {
                 case WATCHDOG_MINOR:
-                    if (ipmi_wdog_open)
+		    if(test_and_set_bit(0, &ipmi_wdog_open))
                         return -EBUSY;
 
-                    ipmi_wdog_open = 1;
-
 		    /* Don't start the timer now, let it start on the
 		       first heartbeat. */
 		    ipmi_start_timer_on_heartbeat = 1;
@@ -712,14 +728,18 @@
 {
 	if (iminor(ino)==WATCHDOG_MINOR)
 	{
-		if (!nowayout) {
+		if (expect_close == 42) {
 			ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
 			ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
+			clear_bit(0, &ipmi_wdog_open);
+		} else {
+			printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
+			ipmi_heartbeat();
 		}
-	        ipmi_wdog_open = 0;
 	}
 
 	ipmi_fasync (-1, filep, 0);
+	expect_close = 0;
 
 	return 0;
 }
@@ -747,7 +767,7 @@
 				  void                 *handler_data)
 {
 	if (msg->msg.data[0] != 0) {
-		printk(KERN_ERR "IPMI Watchdog response: Error %x on cmd %x\n",
+		printk(KERN_ERR PFX "response: Error %x on cmd %x\n",
 		       msg->msg.data[0],
 		       msg->msg.cmd);
 	}
@@ -792,7 +812,7 @@
 
 	rv = ipmi_create_user(ipmi_intf, &ipmi_hndlrs, NULL, &watchdog_user);
 	if (rv < 0) {
-		printk("IPMI watchdog: Unable to register with ipmi\n");
+		printk(KERN_CRIT PFX "Unable to register with ipmi\n");
 		goto out;
 	}
 
@@ -804,7 +824,7 @@
 	if (rv < 0) {
 		ipmi_destroy_user(watchdog_user);
 		watchdog_user = NULL;
-		printk("IPMI watchdog: Unable to register misc device\n");
+		printk(KERN_CRIT PFX "Unable to register misc device\n");
 	}
 
  out:
@@ -815,7 +835,7 @@
 		start_now = 0; /* Disable this function after first startup. */
 		ipmi_watchdog_state = action_val;
 		ipmi_set_timeout(IPMI_SET_TIMEOUT_FORCE_HB);
-		printk("Starting IPMI Watchdog now!\n");
+		printk(KERN_INFO PFX "Starting now!\n");
 	}
 }
 
@@ -826,7 +846,7 @@
 	/* If no one else handled the NMI, we assume it was the IPMI
            watchdog. */
 	if ((!handled) && (preop_val == WDOG_PREOP_PANIC))
-		panic("IPMI watchdog pre-timeout");
+		panic(PFX "pre-timeout");
 
 	/* On some machines, the heartbeat will give
 	   an error and not work unless we re-enable
@@ -932,7 +952,7 @@
 {
 	int rv;
 
-	printk(KERN_INFO "IPMI watchdog driver version "
+	printk(KERN_INFO PFX "driver version "
 	       IPMI_WATCHDOG_VERSION "\n");
 
 	if (strcmp(action, "reset") == 0) {
@@ -945,7 +965,7 @@
 		action_val = WDOG_TIMEOUT_POWER_DOWN;
 	} else {
 		action_val = WDOG_TIMEOUT_RESET;
-		printk("ipmi_watchdog: Unknown action '%s', defaulting to"
+		printk(KERN_INFO PFX "Unknown action '%s', defaulting to"
 		       " reset\n", action);
 	}
 
@@ -961,7 +981,7 @@
 		preaction_val = WDOG_PRETIMEOUT_MSG_INT;
 	} else {
 		preaction_val = WDOG_PRETIMEOUT_NONE;
-		printk("ipmi_watchdog: Unknown preaction '%s', defaulting to"
+		printk(KERN_INFO PFX "Unknown preaction '%s', defaulting to"
 		       " none\n", preaction);
 	}
 
@@ -973,23 +993,21 @@
 		preop_val = WDOG_PREOP_GIVE_DATA;
 	} else {
 		preop_val = WDOG_PREOP_NONE;
-		printk("ipmi_watchdog: Unknown preop '%s', defaulting to"
+		printk(KERN_INFO PFX "Unknown preop '%s', defaulting to"
 		       " none\n", preop);
 	}
 
 #ifdef HAVE_NMI_HANDLER
 	if (preaction_val == WDOG_PRETIMEOUT_NMI) {
 		if (preop_val == WDOG_PREOP_GIVE_DATA) {
-			printk(KERN_WARNING
-			       "ipmi_watchdog: Pretimeout op is to give data"
+			printk(KERN_WARNING PFX "Pretimeout op is to give data"
 			       " but NMI pretimeout is enabled, setting"
 			       " pretimeout op to none\n");
 			preop_val = WDOG_PREOP_NONE;
 		}
 #ifdef CONFIG_X86_LOCAL_APIC
 		if (nmi_watchdog == NMI_IO_APIC) {
-			printk(KERN_WARNING
-			       "ipmi_watchdog: nmi_watchdog is set to IO APIC"
+			printk(KERN_WARNING PFX "nmi_watchdog is set to IO APIC"
 			       " mode (value is %d), that is incompatible"
 			       " with using NMI in the IPMI watchdog."
 			       " Disabling IPMI nmi pretimeout.\n",
@@ -999,8 +1017,7 @@
 #endif
 		rv = request_nmi(&ipmi_nmi_handler);
 		if (rv) {
-			printk(KERN_WARNING
-			       "ipmi_watchdog: Can't register nmi handler\n");
+			printk(KERN_WARNING PFX "Can't register nmi handler\n");
 			return rv;
 		}
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -1015,8 +1032,7 @@
 		if (preaction_val == WDOG_PRETIMEOUT_NMI)
 			release_nmi(&ipmi_nmi_handler);
 #endif
-		printk(KERN_WARNING
-		       "ipmi_watchdog: can't register smi watcher\n");
+		printk(KERN_WARNING PFX "can't register smi watcher\n");
 		return rv;
 	}
 
@@ -1061,8 +1077,7 @@
 	/* Disconnect from IPMI. */
 	rv = ipmi_destroy_user(watchdog_user);
 	if (rv) {
-		printk(KERN_WARNING
-		       "IPMI Watchdog, error unlinking from IPMI: %d\n",
+		printk(KERN_WARNING PFX "error unlinking from IPMI: %d\n",
 		       rv);
 	}
 	watchdog_user = NULL;

> -Corey

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
