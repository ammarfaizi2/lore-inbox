Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266292AbUHBS2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUHBS2L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 14:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266302AbUHBS2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 14:28:11 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:28384 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266292AbUHBS1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 14:27:44 -0400
Message-ID: <410E8797.70708@acm.org>
Date: Mon, 02 Aug 2004 13:27:35 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: IPMI Watchdog patch
Content-Type: multipart/mixed;
 boundary="------------090708070902060008080301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090708070902060008080301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

The following patch is ready for inclusion; it makes the IPMI
watchdog more consistent with the other watchdog drivers.

I have tested this and it seems to work correctly.  I also added docs
for the interface change.

- support disabling watchdog by writing 'V' to device.
- unify printk()
- use atomic bit operations on ipmi_wdog_open

Signed-off-by: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Signed-off-by: Corey Minyard <minyard@acm.org>


--------------090708070902060008080301
Content-Type: text/plain;
 name="ipmi_wdog_consistify.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_wdog_consistify.diff"


Index: linux-ipmi/Documentation/IPMI.txt
===================================================================
--- linux-ipmi.orig/Documentation/IPMI.txt	2004-08-02 12:47:34.000000000 -0500
+++ linux-ipmi/Documentation/IPMI.txt	2004-08-02 13:25:53.000000000 -0500
@@ -496,3 +496,8 @@
 Note that if you use the NMI preaction for the watchdog, you MUST
 NOT use nmi watchdog mode 1.  If you use the NMI watchdog, you
 must use mode 2.
+
+Once you open the watchdog timer, you must write a 'V' character to the
+device to close it, or the timer will not stop.  This is a new semantic
+for the driver, but makes it consistent with the rest of the watchdog
+drivers in Linux.
Index: linux-ipmi/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-ipmi.orig/drivers/char/ipmi/ipmi_watchdog.c	2004-08-02 13:22:46.000000000 -0500
+++ linux-ipmi/drivers/char/ipmi/ipmi_watchdog.c	2004-08-02 13:22:51.000000000 -0500
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
@@ -606,6 +609,21 @@
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
@@ -673,11 +691,9 @@
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
@@ -715,14 +731,18 @@
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
@@ -750,7 +770,7 @@
 				  void                 *handler_data)
 {
 	if (msg->msg.data[0] != 0) {
-		printk(KERN_ERR "IPMI Watchdog response: Error %x on cmd %x\n",
+		printk(KERN_ERR PFX "response: Error %x on cmd %x\n",
 		       msg->msg.data[0],
 		       msg->msg.cmd);
 	}
@@ -795,7 +815,7 @@
 
 	rv = ipmi_create_user(ipmi_intf, &ipmi_hndlrs, NULL, &watchdog_user);
 	if (rv < 0) {
-		printk("IPMI watchdog: Unable to register with ipmi\n");
+		printk(KERN_CRIT PFX "Unable to register with ipmi\n");
 		goto out;
 	}
 
@@ -807,7 +827,7 @@
 	if (rv < 0) {
 		ipmi_destroy_user(watchdog_user);
 		watchdog_user = NULL;
-		printk("IPMI watchdog: Unable to register misc device\n");
+		printk(KERN_CRIT PFX "Unable to register misc device\n");
 	}
 
  out:
@@ -818,7 +838,7 @@
 		start_now = 0; /* Disable this function after first startup. */
 		ipmi_watchdog_state = action_val;
 		ipmi_set_timeout(IPMI_SET_TIMEOUT_FORCE_HB);
-		printk("Starting IPMI Watchdog now!\n");
+		printk(KERN_INFO PFX "Starting now!\n");
 	}
 }
 
@@ -829,7 +849,7 @@
 	/* If no one else handled the NMI, we assume it was the IPMI
            watchdog. */
 	if ((!handled) && (preop_val == WDOG_PREOP_PANIC))
-		panic("IPMI watchdog pre-timeout");
+		panic(PFX "pre-timeout");
 
 	/* On some machines, the heartbeat will give
 	   an error and not work unless we re-enable
@@ -935,7 +955,7 @@
 {
 	int rv;
 
-	printk(KERN_INFO "IPMI watchdog driver version "
+	printk(KERN_INFO PFX "driver version "
 	       IPMI_WATCHDOG_VERSION "\n");
 
 	if (strcmp(action, "reset") == 0) {
@@ -948,7 +968,7 @@
 		action_val = WDOG_TIMEOUT_POWER_DOWN;
 	} else {
 		action_val = WDOG_TIMEOUT_RESET;
-		printk("ipmi_watchdog: Unknown action '%s', defaulting to"
+		printk(KERN_INFO PFX "Unknown action '%s', defaulting to"
 		       " reset\n", action);
 	}
 
@@ -964,7 +984,7 @@
 		preaction_val = WDOG_PRETIMEOUT_MSG_INT;
 	} else {
 		preaction_val = WDOG_PRETIMEOUT_NONE;
-		printk("ipmi_watchdog: Unknown preaction '%s', defaulting to"
+		printk(KERN_INFO PFX "Unknown preaction '%s', defaulting to"
 		       " none\n", preaction);
 	}
 
@@ -976,23 +996,21 @@
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
@@ -1002,8 +1020,7 @@
 #endif
 		rv = request_nmi(&ipmi_nmi_handler);
 		if (rv) {
-			printk(KERN_WARNING
-			       "ipmi_watchdog: Can't register nmi handler\n");
+			printk(KERN_WARNING PFX "Can't register nmi handler\n");
 			return rv;
 		}
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -1018,8 +1035,7 @@
 		if (preaction_val == WDOG_PRETIMEOUT_NMI)
 			release_nmi(&ipmi_nmi_handler);
 #endif
-		printk(KERN_WARNING
-		       "ipmi_watchdog: can't register smi watcher\n");
+		printk(KERN_WARNING PFX "can't register smi watcher\n");
 		return rv;
 	}
 
@@ -1064,8 +1080,7 @@
 	/* Disconnect from IPMI. */
 	rv = ipmi_destroy_user(watchdog_user);
 	if (rv) {
-		printk(KERN_WARNING
-		       "IPMI Watchdog, error unlinking from IPMI: %d\n",
+		printk(KERN_WARNING PFX "error unlinking from IPMI: %d\n",
 		       rv);
 	}
 	watchdog_user = NULL;

--------------090708070902060008080301--

