Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263942AbUFPOWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUFPOWs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 10:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUFPOWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 10:22:47 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:56480 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263942AbUFPOVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 10:21:47 -0400
Message-ID: <40D05779.9080203@acm.org>
Date: Wed, 16 Jun 2004 09:21:45 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: Alex Williamson <alex.williamson@hp.com>,
       Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: IPMI hangup in 2.6.6-rc3
References: <Pine.LNX.4.58.R0405040649310.15047@praktifix.dwd.de>  <20040525165335.GA28905@titan.lahn.de>  <40C0E2BF.3040705@acm.org> <1086887543.4182.46.camel@tdi> <Pine.LNX.4.58.0406161225210.17908@praktifix.dwd.de> <40D056E2.4010605@acm.org>
In-Reply-To: <40D056E2.4010605@acm.org>
Content-Type: multipart/mixed;
 boundary="------------010009030400020105020700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010009030400020105020700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I missed a part of the patch, here is a new one with the include file 
changes.

-Corey

Corey Minyard wrote:

> Unfortuantely, that fix has some problems, but it was on the right 
> track.  I have a new patch attached; can you try it out?  Also, the 
> kernel interface has not changed.  It should be exactly the same as 
> before.
>
> -Corey


--------------010009030400020105020700
Content-Type: text/plain;
 name="ipmi-fixhang.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-fixhang.diff"

diff -ur linux.orig/drivers/char/ipmi/ipmi_msghandler.c linux/drivers/char/ipmi/ipmi_msghandler.c
--- linux.orig/drivers/char/ipmi/ipmi_msghandler.c	2004-06-14 22:32:03.000000000 -0500
+++ linux/drivers/char/ipmi/ipmi_msghandler.c	2004-06-16 09:13:07.000000000 -0500
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
@@ -1671,10 +1687,12 @@
 			wake_up(&intf->waitq);
 
 			printk(KERN_WARNING "ipmi_msghandler: Error sending"
-			       "channel information: 0x%x\n",
+			       "channel information: %d\n",
 			       rv);
 		}
 	}
+ out:
+	return;
 }
 
 int ipmi_register_smi(struct ipmi_smi_handlers *handlers,
diff -ur linux.orig/drivers/char/ipmi/ipmi_si_intf.c linux/drivers/char/ipmi/ipmi_si_intf.c
--- linux.orig/drivers/char/ipmi/ipmi_si_intf.c	2004-06-14 22:32:03.000000000 -0500
+++ linux/drivers/char/ipmi/ipmi_si_intf.c	2004-06-16 08:51:29.000000000 -0500
@@ -1848,6 +1848,21 @@
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
@@ -1857,7 +1872,7 @@
 		printk(KERN_ERR
 		       "ipmi_si: Unable to register device: error %d\n",
 		       rv);
-		goto out_err;
+		goto out_err_stop_timer;
 	}
 
 	rv = ipmi_smi_add_proc_entry(new_smi->intf, "type",
@@ -1867,7 +1882,7 @@
 		printk(KERN_ERR
 		       "ipmi_si: Unable to create proc entry: %d\n",
 		       rv);
-		goto out_err;
+		goto out_err_stop_timer;
 	}
 
 	rv = ipmi_smi_add_proc_entry(new_smi->intf, "si_stats",
@@ -1877,7 +1892,7 @@
 		printk(KERN_ERR
 		       "ipmi_si: Unable to create proc entry: %d\n",
 		       rv);
-		goto out_err;
+		goto out_err_stop_timer;
 	}
 
 	start_clear_flags(new_smi);
@@ -1886,34 +1901,40 @@
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
 
--- linux.orig/include/linux/ipmi_msgdefs.h	2004-05-21 11:49:05.000000000 -0500
+++ linux/include/linux/ipmi_msgdefs.h	2004-06-16 09:04:26.000000000 -0500
@@ -71,6 +71,7 @@
 
 #define IPMI_CC_NO_ERROR		0x00
 #define IPMI_NODE_BUSY_ERR		0xc0
+#define IPMI_INVALID_COMMAND_ERR	0xc1
 #define IPMI_ERR_MSG_TRUNCATED		0xc6
 #define IPMI_LOST_ARBITRATION_ERR	0x81
 #define IPMI_ERR_UNSPECIFIED		0xff

--------------010009030400020105020700--

