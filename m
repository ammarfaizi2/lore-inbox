Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162770AbWLBEd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162770AbWLBEd6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162771AbWLBEd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:33:58 -0500
Received: from mta11.adelphia.net ([68.168.78.205]:15064 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S1162770AbWLBEd5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:33:57 -0500
Date: Fri, 1 Dec 2006 22:33:55 -0600
From: Corey Minyard <minyard@acm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>
Subject: [PATCH 5/12] IPMI: Add maintenance mode
Message-ID: <20061202043355.GA30531@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some commands and operations on a BMC can cause the BMC to
"go away" for a while.  This can cause the automatic flag
processing and other things of that nature to timeout and
generate annoying logs, or possibly cause other bad things
to happen when in firmware update mode.

This patch adds detection of those commands (cold reset,
warm reset, and any firmware command) and turns off automatic
processing for 30 seconds.  It also add a manual override
either way.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_devintf.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_devintf.c
@@ -596,6 +596,31 @@ static int ipmi_ioctl(struct inode  *ino
 		rv = 0;
 		break;
 	}
+
+	case IPMICTL_GET_MAINTENANCE_MODE_CMD:
+	{
+		int mode;
+
+		mode = ipmi_get_maintenance_mode(priv->user);
+		if (copy_to_user(arg, &mode, sizeof(mode))) {
+			rv = -EFAULT;
+			break;
+		}
+		rv = 0;
+		break;
+	}
+
+	case IPMICTL_SET_MAINTENANCE_MODE_CMD:
+	{
+		int mode;
+
+		if (copy_from_user(&mode, arg, sizeof(mode))) {
+			rv = -EFAULT;
+			break;
+		}
+		rv = ipmi_set_maintenance_mode(priv->user, mode);
+		break;
+	}
 	}
   
 	return rv;
Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_msghandler.c
@@ -48,7 +48,7 @@
 
 #define PFX "IPMI message handler: "
 
-#define IPMI_DRIVER_VERSION "39.0"
+#define IPMI_DRIVER_VERSION "39.1"
 
 static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
 static int ipmi_init_msghandler(void);
@@ -59,6 +59,9 @@ static int initialized = 0;
 static struct proc_dir_entry *proc_ipmi_root = NULL;
 #endif /* CONFIG_PROC_FS */
 
+/* Remain in auto-maintenance mode for this amount of time (in ms). */
+#define IPMI_MAINTENANCE_MODE_TIMEOUT 30000
+
 #define MAX_EVENTS_IN_QUEUE	25
 
 /* Don't let a message sit in a queue forever, always time it with at lest
@@ -262,6 +265,12 @@ struct ipmi_smi
 	unsigned char local_sel_device;
 	unsigned char local_event_generator;
 
+	/* For handling of maintenance mode. */
+	int maintenance_mode;
+	int maintenance_mode_enable;
+	int auto_maintenance_timeout;
+	spinlock_t maintenance_mode_lock; /* Used in a timer... */
+
 	/* A cheap hack, if this is non-null and a message to an
 	   interface comes in with a NULL user, call this routine with
 	   it.  Note that the message will still be freed by the
@@ -985,6 +994,65 @@ int ipmi_get_my_LUN(ipmi_user_t   user,
 	return 0;
 }
 
+int ipmi_get_maintenance_mode(ipmi_user_t user)
+{
+	int           mode;
+	unsigned long flags;
+
+	spin_lock_irqsave(&user->intf->maintenance_mode_lock, flags);
+	mode = user->intf->maintenance_mode;
+	spin_unlock_irqrestore(&user->intf->maintenance_mode_lock, flags);
+
+	return mode;
+}
+EXPORT_SYMBOL(ipmi_get_maintenance_mode);
+
+static void maintenance_mode_update(ipmi_smi_t intf)
+{
+	if (intf->handlers->set_maintenance_mode)
+		intf->handlers->set_maintenance_mode(
+			intf->send_info, intf->maintenance_mode_enable);
+}
+
+int ipmi_set_maintenance_mode(ipmi_user_t user, int mode)
+{
+	int           rv = 0;
+	unsigned long flags;
+	ipmi_smi_t    intf = user->intf;
+
+	spin_lock_irqsave(&intf->maintenance_mode_lock, flags);
+	if (intf->maintenance_mode != mode) {
+		switch (mode) {
+		case IPMI_MAINTENANCE_MODE_AUTO:
+			intf->maintenance_mode = mode;
+			intf->maintenance_mode_enable
+				= (intf->auto_maintenance_timeout > 0);
+			break;
+
+		case IPMI_MAINTENANCE_MODE_OFF:
+			intf->maintenance_mode = mode;
+			intf->maintenance_mode_enable = 0;
+			break;
+
+		case IPMI_MAINTENANCE_MODE_ON:
+			intf->maintenance_mode = mode;
+			intf->maintenance_mode_enable = 1;
+			break;
+
+		default:
+			rv = -EINVAL;
+			goto out_unlock;
+		}
+
+		maintenance_mode_update(intf);
+	}
+ out_unlock:
+	spin_unlock_irqrestore(&intf->maintenance_mode_lock, flags);
+
+	return rv;
+}
+EXPORT_SYMBOL(ipmi_set_maintenance_mode);
+
 int ipmi_set_gets_events(ipmi_user_t user, int val)
 {
 	unsigned long        flags;
@@ -1322,6 +1390,24 @@ static int i_ipmi_request(ipmi_user_t   
 			goto out_err;
 		}
 
+		if (((msg->netfn == IPMI_NETFN_APP_REQUEST)
+		      && ((msg->cmd == IPMI_COLD_RESET_CMD)
+			  || (msg->cmd == IPMI_WARM_RESET_CMD)))
+		     || (msg->netfn == IPMI_NETFN_FIRMWARE_REQUEST))
+		{
+			spin_lock_irqsave(&intf->maintenance_mode_lock, flags);
+			intf->auto_maintenance_timeout
+				= IPMI_MAINTENANCE_MODE_TIMEOUT;
+			if (!intf->maintenance_mode
+			    && !intf->maintenance_mode_enable)
+			{
+				intf->maintenance_mode_enable = 1;
+				maintenance_mode_update(intf);
+			}
+			spin_unlock_irqrestore(&intf->maintenance_mode_lock,
+					       flags);
+		}
+
 		if ((msg->data_len + 2) > IPMI_MAX_MSG_LENGTH) {
 			spin_lock_irqsave(&intf->counter_lock, flags);
 			intf->sent_invalid_commands++;
@@ -2605,6 +2691,7 @@ int ipmi_register_smi(struct ipmi_smi_ha
 	INIT_LIST_HEAD(&intf->waiting_events);
 	intf->waiting_events_count = 0;
 	mutex_init(&intf->cmd_rcvrs_mutex);
+	spin_lock_init(&intf->maintenance_mode_lock);
 	INIT_LIST_HEAD(&intf->cmd_rcvrs);
 	init_waitqueue_head(&intf->waitq);
 
@@ -3593,6 +3680,30 @@ static void ipmi_timeout_handler(long ti
 
 		list_for_each_entry_safe(msg, msg2, &timeouts, link)
 			deliver_err_response(msg, IPMI_TIMEOUT_COMPLETION_CODE);
+
+		/*
+		 * Maintenance mode handling.  Check the timeout
+		 * optimistically before we claim the lock.  It may
+		 * mean a timeout gets missed occasionally, but that
+		 * only means the timeout gets extended by one period
+		 * in that case.  No big deal, and it avoids the lock
+		 * most of the time.
+		 */
+		if (intf->auto_maintenance_timeout > 0) {
+			spin_lock_irqsave(&intf->maintenance_mode_lock, flags);
+			if (intf->auto_maintenance_timeout > 0) {
+				intf->auto_maintenance_timeout
+					-= timeout_period;
+				if (!intf->maintenance_mode
+				    && (intf->auto_maintenance_timeout <= 0))
+				{
+					intf->maintenance_mode_enable = 0;
+					maintenance_mode_update(intf);
+				}
+			}
+			spin_unlock_irqrestore(&intf->maintenance_mode_lock,
+					       flags);
+		}
 	}
 	rcu_read_unlock();
 }
@@ -3606,6 +3717,10 @@ static void ipmi_request_event(void)
 	/* Called from the timer, no need to check if handlers is
 	 * valid. */
 	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+		/* No event requests when in maintenance mode. */
+		if (intf->maintenance_mode_enable)
+			continue;
+
 		handlers = intf->handlers;
 		if (handlers)
 			handlers->request_events(intf->send_info);
Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
@@ -949,12 +949,21 @@ static int smi_start_processing(void    
 	return 0;
 }
 
+static void set_maintenance_mode(void *send_info, int enable)
+{
+	struct smi_info   *smi_info = send_info;
+
+	if (!enable)
+		atomic_set(&smi_info->req_events, 0);
+}
+
 static struct ipmi_smi_handlers handlers =
 {
 	.owner                  = THIS_MODULE,
 	.start_processing       = smi_start_processing,
 	.sender			= sender,
 	.request_events		= request_events,
+	.set_maintenance_mode   = set_maintenance_mode,
 	.set_run_to_completion  = set_run_to_completion,
 	.poll			= poll,
 };
Index: linux-2.6.19-rc6/include/linux/ipmi.h
===================================================================
--- linux-2.6.19-rc6.orig/include/linux/ipmi.h
+++ linux-2.6.19-rc6/include/linux/ipmi.h
@@ -208,6 +208,15 @@ struct kernel_ipmi_msg
    code as the first byte of the incoming data, unlike a response. */
 
 
+/*
+ * Modes for ipmi_set_maint_mode() and the userland IOCTL.  The AUTO
+ * setting is the default and means it will be set on certain
+ * commands.  Hard setting it on and off will override automatic
+ * operation.
+ */
+#define IPMI_MAINTENANCE_MODE_AUTO	0
+#define IPMI_MAINTENANCE_MODE_OFF	1
+#define IPMI_MAINTENANCE_MODE_ON	2
 
 #ifdef __KERNEL__
 
@@ -374,6 +383,35 @@ int ipmi_unregister_for_cmd(ipmi_user_t 
 			    unsigned int  chans);
 
 /*
+ * Go into a mode where the driver will not autonomously attempt to do
+ * things with the interface.  It will still respond to attentions and
+ * interrupts, and it will expect that commands will complete.  It
+ * will not automatcially check for flags, events, or things of that
+ * nature.
+ *
+ * This is primarily used for firmware upgrades.  The idea is that
+ * when you go into firmware upgrade mode, you do this operation
+ * and the driver will not attempt to do anything but what you tell
+ * it or what the BMC asks for.
+ *
+ * Note that if you send a command that resets the BMC, the driver
+ * will still expect a response from that command.  So the BMC should
+ * reset itself *after* the response is sent.  Resetting before the
+ * response is just silly.
+ *
+ * If in auto maintenance mode, the driver will automatically go into
+ * maintenance mode for 30 seconds if it sees a cold reset, a warm
+ * reset, or a firmware NetFN.  This means that code that uses only
+ * firmware NetFN commands to do upgrades will work automatically
+ * without change, assuming it sends a message every 30 seconds or
+ * less.
+ *
+ * See the IPMI_MAINTENANCE_MODE_xxx defines for what the mode means.
+ */
+int ipmi_get_maintenance_mode(ipmi_user_t user);
+int ipmi_set_maintenance_mode(ipmi_user_t user, int mode);
+
+/*
  * Allow run-to-completion mode to be set for the interface of
  * a specific user.
  */
@@ -656,4 +694,11 @@ struct ipmi_timing_parms
 #define IPMICTL_GET_TIMING_PARMS_CMD	_IOR(IPMI_IOC_MAGIC, 23, \
 					     struct ipmi_timing_parms)
 
+/*
+ * Set the maintenance mode.  See ipmi_set_maintenance_mode() above
+ * for a description of what this does.
+ */
+#define IPMICTL_GET_MAINTENANCE_MODE_CMD	_IOR(IPMI_IOC_MAGIC, 30, int)
+#define IPMICTL_SET_MAINTENANCE_MODE_CMD	_IOW(IPMI_IOC_MAGIC, 31, int)
+
 #endif /* __LINUX_IPMI_H */
Index: linux-2.6.19-rc6/include/linux/ipmi_msgdefs.h
===================================================================
--- linux-2.6.19-rc6.orig/include/linux/ipmi_msgdefs.h
+++ linux-2.6.19-rc6/include/linux/ipmi_msgdefs.h
@@ -46,6 +46,8 @@
 #define IPMI_NETFN_APP_REQUEST			0x06
 #define IPMI_NETFN_APP_RESPONSE			0x07
 #define IPMI_GET_DEVICE_ID_CMD		0x01
+#define IPMI_COLD_RESET_CMD		0x02
+#define IPMI_WARM_RESET_CMD		0x03
 #define IPMI_CLEAR_MSG_FLAGS_CMD	0x30
 #define IPMI_GET_DEVICE_GUID_CMD	0x08
 #define IPMI_GET_MSG_FLAGS_CMD		0x31
@@ -60,6 +62,9 @@
 #define IPMI_NETFN_STORAGE_RESPONSE		0x0b
 #define IPMI_ADD_SEL_ENTRY_CMD		0x44
 
+#define IPMI_NETFN_FIRMWARE_REQUEST		0x08
+#define IPMI_NETFN_FIRMWARE_RESPONSE		0x09
+
 /* The default slave address */
 #define IPMI_BMC_SLAVE_ADDR	0x20
 
Index: linux-2.6.19-rc6/include/linux/ipmi_smi.h
===================================================================
--- linux-2.6.19-rc6.orig/include/linux/ipmi_smi.h
+++ linux-2.6.19-rc6/include/linux/ipmi_smi.h
@@ -115,6 +115,13 @@ struct ipmi_smi_handlers
 	   poll for operations during things like crash dumps. */
 	void (*poll)(void *send_info);
 
+	/* Enable/disable firmware maintenance mode.  Note that this
+	   is *not* the modes defined, this is simply an on/off
+	   setting.  The message handler does the mode handling.  Note
+	   that this is called from interupt context, so it cannot
+	   block. */
+	void (*set_maintenance_mode)(void *send_info, int enable);
+
 	/* Tell the handler that we are using it/not using it.  The
 	   message handler get the modules that this handler belongs
 	   to; this function lets the SMI claim any modules that it
