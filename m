Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWC0Rdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWC0Rdv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWC0Rdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:33:51 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:40163 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750715AbWC0Rdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:33:51 -0500
Date: Mon, 27 Mar 2006 11:33:49 -0600
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: Matt Domsch <Matt_Domsch@dell.com>
Subject: [PATCH 1/3] IPMI: fix startup race condition
Message-ID: <20060327173349.GA14601@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matt Domsch noticed a startup race with the IPMI kernel thread, it was
possible (though extraordinarly unlikely) that a message could come in
before the upper layer was ready to handle it.  This patch splits the
startup processing of an IPMI interface into two parts, one to get
ready and one to actually start the processes to receive messages from
the interface.

Signed-off-by: Corey Minyard <minyard@acm.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>

Index: linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
@@ -2306,8 +2306,7 @@ int ipmi_register_smi(struct ipmi_smi_ha
 		      void		       *send_info,
 		      struct ipmi_device_id    *device_id,
 		      struct device            *si_dev,
-		      unsigned char            slave_addr,
-		      ipmi_smi_t               *new_intf)
+		      unsigned char            slave_addr)
 {
 	int              i, j;
 	int              rv;
@@ -2389,9 +2388,9 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	if (rv)
 		goto out;
 
-	/* FIXME - this is an ugly kludge, this sets the intf for the
-	   caller before sending any messages with it. */
-	*new_intf = intf;
+	rv = handlers->start_processing(send_info, intf);
+	if (rv)
+		goto out;
 
 	get_guid(intf);
 
Index: linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
@@ -971,10 +971,40 @@ static irqreturn_t si_bt_irq_handler(int
 	return si_irq_handler(irq, data, regs);
 }
 
+static int smi_start_processing(void       *send_info,
+				ipmi_smi_t intf)
+{
+	struct smi_info *new_smi = send_info;
+
+	new_smi->intf = intf;
+
+	/* Set up the timer that drives the interface. */
+	init_timer(&new_smi->si_timer);
+	new_smi->si_timer.data = (long) new_smi;
+	new_smi->si_timer.function = smi_timeout;
+	new_smi->last_timeout_jiffies = jiffies;
+	new_smi->si_timer.expires = jiffies + SI_TIMEOUT_JIFFIES;
+	add_timer(&new_smi->si_timer);
+
+ 	if (new_smi->si_type != SI_BT) {
+		new_smi->thread = kthread_run(ipmi_thread, new_smi,
+					      "kipmi%d", new_smi->intf_num);
+		if (IS_ERR(new_smi->thread)) {
+			printk(KERN_NOTICE "ipmi_si_intf: Could not start"
+			       " kernel thread due to error %ld, only using"
+			       " timers to drive the interface\n",
+			       PTR_ERR(new_smi->thread));
+			new_smi->thread = NULL;
+		}
+	}
+
+	return 0;
+}
 
 static struct ipmi_smi_handlers handlers =
 {
 	.owner                  = THIS_MODULE,
+	.start_processing       = smi_start_processing,
 	.sender			= sender,
 	.request_events		= request_events,
 	.set_run_to_completion  = set_run_to_completion,
@@ -2161,9 +2191,13 @@ static void setup_xaction_handlers(struc
 
 static inline void wait_for_timer_and_thread(struct smi_info *smi_info)
 {
-	if (smi_info->thread != NULL && smi_info->thread != ERR_PTR(-ENOMEM))
-		kthread_stop(smi_info->thread);
-	del_timer_sync(&smi_info->si_timer);
+	if (smi_info->intf) {
+		/* The timer and thread are only running if the
+		   interface has been started up and registered. */
+		if (smi_info->thread != NULL)
+			kthread_stop(smi_info->thread);
+		del_timer_sync(&smi_info->si_timer);
+	}
 }
 
 static struct ipmi_default_vals
@@ -2340,21 +2374,6 @@ static int try_smi_init(struct smi_info 
 	if (new_smi->irq)
 		new_smi->si_state = SI_CLEARING_FLAGS_THEN_SET_IRQ;
 
-	/* The ipmi_register_smi() code does some operations to
-	   determine the channel information, so we must be ready to
-	   handle operations before it is called.  This means we have
-	   to stop the timer if we get an error after this point. */
-	init_timer(&(new_smi->si_timer));
-	new_smi->si_timer.data = (long) new_smi;
-	new_smi->si_timer.function = smi_timeout;
-	new_smi->last_timeout_jiffies = jiffies;
-	new_smi->si_timer.expires = jiffies + SI_TIMEOUT_JIFFIES;
-
-	add_timer(&(new_smi->si_timer));
- 	if (new_smi->si_type != SI_BT)
-		new_smi->thread = kthread_run(ipmi_thread, new_smi,
-					      "kipmi%d", new_smi->intf_num);
-
 	if (!new_smi->dev) {
 		/* If we don't already have a device from something
 		 * else (like PCI), then register a new one. */
@@ -2364,7 +2383,7 @@ static int try_smi_init(struct smi_info 
 			printk(KERN_ERR
 			       "ipmi_si_intf:"
 			       " Unable to allocate platform device\n");
-			goto out_err_stop_timer;
+			goto out_err;
 		}
 		new_smi->dev = &new_smi->pdev->dev;
 		new_smi->dev->driver = &ipmi_driver;
@@ -2376,7 +2395,7 @@ static int try_smi_init(struct smi_info 
 			       " Unable to register system interface device:"
 			       " %d\n",
 			       rv);
-			goto out_err_stop_timer;
+			goto out_err;
 		}
 		new_smi->dev_registered = 1;
 	}
@@ -2385,8 +2404,7 @@ static int try_smi_init(struct smi_info 
 			       new_smi,
 			       &new_smi->device_id,
 			       new_smi->dev,
-			       new_smi->slave_addr,
-			       &(new_smi->intf));
+			       new_smi->slave_addr);
 	if (rv) {
 		printk(KERN_ERR
 		       "ipmi_si: Unable to register device: error %d\n",
Index: linux-2.6.16/include/linux/ipmi_smi.h
===================================================================
--- linux-2.6.16.orig/include/linux/ipmi_smi.h
+++ linux-2.6.16/include/linux/ipmi_smi.h
@@ -82,6 +82,13 @@ struct ipmi_smi_handlers
 {
 	struct module *owner;
 
+	/* The low-level interface cannot start sending messages to
+	   the upper layer until this function is called.  This may
+	   not be NULL, the lower layer must take the interface from
+	   this call. */
+	int (*start_processing)(void       *send_info,
+				ipmi_smi_t new_intf);
+
 	/* Called to enqueue an SMI message to be sent.  This
 	   operation is not allowed to fail.  If an error occurs, it
 	   should report back the error in a received message.  It may
@@ -157,13 +164,16 @@ static inline void ipmi_demangle_device_
 }
 
 /* Add a low-level interface to the IPMI driver.  Note that if the
-   interface doesn't know its slave address, it should pass in zero. */
+   interface doesn't know its slave address, it should pass in zero.
+   The low-level interface should not deliver any messages to the
+   upper layer until the start_processing() function in the handlers
+   is called, and the lower layer must get the interface from that
+   call. */
 int ipmi_register_smi(struct ipmi_smi_handlers *handlers,
 		      void                     *send_info,
 		      struct ipmi_device_id    *device_id,
 		      struct device            *dev,
-		      unsigned char            slave_addr,
-		      ipmi_smi_t               *intf);
+		      unsigned char            slave_addr);
 
 /*
  * Remove a low-level interface from the IPMI driver.  This will
