Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWC0Reu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWC0Reu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWC0Reu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:34:50 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:12739 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750731AbWC0Ret (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:34:49 -0500
Date: Mon, 27 Mar 2006 11:34:48 -0600
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 2/3] IPMI: tidy up various things
Message-ID: <20060327173448.GB14601@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tidy up various coding standard things, mostly removing the
space after !, but also break some long lines and fix a few
other spacing inconsistencies.  Also fixes some bad error
reporting when deleting an IPMI user.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.16/drivers/char/ipmi/ipmi_kcs_sm.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_kcs_sm.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_kcs_sm.c
@@ -227,7 +227,7 @@ static inline int check_ibf(struct si_sm
 static inline int check_obf(struct si_sm_data *kcs, unsigned char status,
 			    long time)
 {
-	if (! GET_STATUS_OBF(status)) {
+	if (!GET_STATUS_OBF(status)) {
 		kcs->obf_timeout -= time;
 		if (kcs->obf_timeout < 0) {
 		    start_error_recovery(kcs, "OBF not ready in time");
@@ -407,7 +407,7 @@ static enum si_sm_result kcs_event(struc
 		}
 
 		if (state == KCS_READ_STATE) {
-			if (! check_obf(kcs, status, time))
+			if (!check_obf(kcs, status, time))
 				return SI_SM_CALL_WITH_DELAY;
 			read_next_byte(kcs);
 		} else {
@@ -447,7 +447,7 @@ static enum si_sm_result kcs_event(struc
 					     "Not in read state for error2");
 			break;
 		}
-		if (! check_obf(kcs, status, time))
+		if (!check_obf(kcs, status, time))
 			return SI_SM_CALL_WITH_DELAY;
 
 		clear_obf(kcs, status);
@@ -462,7 +462,7 @@ static enum si_sm_result kcs_event(struc
 			break;
 		}
 
-		if (! check_obf(kcs, status, time))
+		if (!check_obf(kcs, status, time))
 			return SI_SM_CALL_WITH_DELAY;
 
 		clear_obf(kcs, status);
Index: linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_msghandler.c
@@ -557,7 +557,7 @@ unsigned int ipmi_addr_length(int addr_t
 
 static void deliver_response(struct ipmi_recv_msg *msg)
 {
-	if (! msg->user) {
+	if (!msg->user) {
 		ipmi_smi_t    intf = msg->user_msg_data;
 		unsigned long flags;
 
@@ -598,11 +598,11 @@ static int intf_next_seq(ipmi_smi_t     
 	     (i+1)%IPMI_IPMB_NUM_SEQ != intf->curr_seq;
 	     i = (i+1)%IPMI_IPMB_NUM_SEQ)
 	{
-		if (! intf->seq_table[i].inuse)
+		if (!intf->seq_table[i].inuse)
 			break;
 	}
 
-	if (! intf->seq_table[i].inuse) {
+	if (!intf->seq_table[i].inuse) {
 		intf->seq_table[i].recv_msg = recv_msg;
 
 		/* Start with the maximum timeout, when the send response
@@ -763,7 +763,7 @@ int ipmi_create_user(unsigned int       
 	}
 
 	new_user = kmalloc(sizeof(*new_user), GFP_KERNEL);
-	if (! new_user)
+	if (!new_user)
 		return -ENOMEM;
 
 	spin_lock_irqsave(&interfaces_lock, flags);
@@ -819,14 +819,13 @@ static void free_user(struct kref *ref)
 
 int ipmi_destroy_user(ipmi_user_t user)
 {
-	int              rv = -ENODEV;
 	ipmi_smi_t       intf = user->intf;
 	int              i;
 	unsigned long    flags;
 	struct cmd_rcvr  *rcvr;
 	struct cmd_rcvr  *rcvrs = NULL;
 
-	user->valid = 1;
+	user->valid = 0;
 
 	/* Remove the user from the interface's sequence table. */
 	spin_lock_irqsave(&intf->seq_lock, flags);
@@ -871,7 +870,7 @@ int ipmi_destroy_user(ipmi_user_t user)
 
 	kref_put(&user->refcount, free_user);
 
-	return rv;
+	return 0;
 }
 
 void ipmi_get_version(ipmi_user_t   user,
@@ -936,7 +935,8 @@ int ipmi_set_gets_events(ipmi_user_t use
 
 	if (val) {
 		/* Deliver any queued events. */
-		list_for_each_entry_safe(msg, msg2, &intf->waiting_events, link) {
+		list_for_each_entry_safe(msg, msg2, &intf->waiting_events,
+					 link) {
 			list_del(&msg->link);
 			list_add_tail(&msg->link, &msgs);
 		}
@@ -978,7 +978,7 @@ int ipmi_register_for_cmd(ipmi_user_t   
 
 
 	rcvr = kmalloc(sizeof(*rcvr), GFP_KERNEL);
-	if (! rcvr)
+	if (!rcvr)
 		return -ENOMEM;
 	rcvr->cmd = cmd;
 	rcvr->netfn = netfn;
@@ -1514,7 +1514,7 @@ int ipmi_request_settime(ipmi_user_t    
 	unsigned char saddr, lun;
 	int           rv;
 
-	if (! user)
+	if (!user)
 		return -EINVAL;
 	rv = check_addr(user->intf, addr, &saddr, &lun);
 	if (rv)
@@ -1545,7 +1545,7 @@ int ipmi_request_supply_msgs(ipmi_user_t
 	unsigned char saddr, lun;
 	int           rv;
 
-	if (! user)
+	if (!user)
 		return -EINVAL;
 	rv = check_addr(user->intf, addr, &saddr, &lun);
 	if (rv)
@@ -1570,7 +1570,7 @@ static int ipmb_file_read_proc(char *pag
 	char       *out = (char *) page;
 	ipmi_smi_t intf = data;
 	int        i;
-	int        rv= 0;
+	int        rv = 0;
 
 	for (i = 0; i < IPMI_MAX_CHANNELS; i++)
 		rv += sprintf(out+rv, "%x ", intf->channels[i].address);
@@ -1990,7 +1990,7 @@ static int ipmi_bmc_register(ipmi_smi_t 
 	} else {
 		bmc->dev = platform_device_alloc("ipmi_bmc",
 						 bmc->id.device_id);
-		if (! bmc->dev) {
+		if (!bmc->dev) {
 			printk(KERN_ERR
 			       "ipmi_msghandler:"
 			       " Unable to allocate platform device\n");
@@ -2622,7 +2622,7 @@ static int handle_ipmb_get_msg_cmd(ipmi_
 		spin_unlock_irqrestore(&intf->counter_lock, flags);
 
 		recv_msg = ipmi_alloc_recv_msg();
-		if (! recv_msg) {
+		if (!recv_msg) {
 			/* We couldn't allocate memory for the
                            message, so requeue it for handling
                            later. */
@@ -2777,7 +2777,7 @@ static int handle_lan_get_msg_cmd(ipmi_s
 		spin_unlock_irqrestore(&intf->counter_lock, flags);
 
 		recv_msg = ipmi_alloc_recv_msg();
-		if (! recv_msg) {
+		if (!recv_msg) {
 			/* We couldn't allocate memory for the
                            message, so requeue it for handling
                            later. */
@@ -2869,13 +2869,14 @@ static int handle_read_event_rsp(ipmi_sm
 	   events. */
 	rcu_read_lock();
 	list_for_each_entry_rcu(user, &intf->users, link) {
-		if (! user->gets_events)
+		if (!user->gets_events)
 			continue;
 
 		recv_msg = ipmi_alloc_recv_msg();
-		if (! recv_msg) {
+		if (!recv_msg) {
 			rcu_read_unlock();
-			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs, link) {
+			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
+						 link) {
 				list_del(&recv_msg->link);
 				ipmi_free_recv_msg(recv_msg);
 			}
@@ -2905,7 +2906,7 @@ static int handle_read_event_rsp(ipmi_sm
 		/* No one to receive the message, put it in queue if there's
 		   not already too many things in the queue. */
 		recv_msg = ipmi_alloc_recv_msg();
-		if (! recv_msg) {
+		if (!recv_msg) {
 			/* We couldn't allocate memory for the
                            message, so requeue it for handling
                            later. */
@@ -3190,7 +3191,7 @@ void ipmi_smi_watchdog_pretimeout(ipmi_s
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(user, &intf->users, link) {
-		if (! user->handler->ipmi_watchdog_pretimeout)
+		if (!user->handler->ipmi_watchdog_pretimeout)
 			continue;
 
 		user->handler->ipmi_watchdog_pretimeout(user->handler_data);
@@ -3278,7 +3279,7 @@ static void check_msg_timeout(ipmi_smi_t
 
 		smi_msg = smi_from_recv_msg(intf, ent->recv_msg, slot,
 					    ent->seqid);
-		if (! smi_msg)
+		if (!smi_msg)
 			return;
 
 		spin_unlock_irqrestore(&intf->seq_lock, *flags);
@@ -3314,8 +3315,9 @@ static void ipmi_timeout_handler(long ti
 
 		/* See if any waiting messages need to be processed. */
 		spin_lock_irqsave(&intf->waiting_msgs_lock, flags);
-		list_for_each_entry_safe(smi_msg, smi_msg2, &intf->waiting_msgs, link) {
-			if (! handle_new_recv_msg(intf, smi_msg)) {
+		list_for_each_entry_safe(smi_msg, smi_msg2,
+					 &intf->waiting_msgs, link) {
+			if (!handle_new_recv_msg(intf, smi_msg)) {
 				list_del(&smi_msg->link);
 				ipmi_free_smi_msg(smi_msg);
 			} else {
Index: linux-2.6.16/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_poweroff.c
@@ -346,7 +346,7 @@ static int ipmi_dell_chassis_detect (ipm
 {
 	const char ipmi_version_major = ipmi_version & 0xF;
 	const char ipmi_version_minor = (ipmi_version >> 4) & 0xF;
-	const char mfr[3]=DELL_IANA_MFR_ID;
+	const char mfr[3] = DELL_IANA_MFR_ID;
 	if (!memcmp(mfr, &mfg_id, sizeof(mfr)) &&
 	    ipmi_version_major <= 1 &&
 	    ipmi_version_minor < 5)
Index: linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_si_intf.c
@@ -802,7 +802,7 @@ static int ipmi_thread(void *data)
 	set_user_nice(current, 19);
 	while (!kthread_should_stop()) {
 		spin_lock_irqsave(&(smi_info->si_lock), flags);
-		smi_result=smi_event_handler(smi_info, 0);
+		smi_result = smi_event_handler(smi_info, 0);
 		spin_unlock_irqrestore(&(smi_info->si_lock), flags);
 		if (smi_result == SI_SM_CALL_WITHOUT_DELAY) {
 			/* do nothing */
Index: linux-2.6.16/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.16.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.16/drivers/char/ipmi/ipmi_watchdog.c
@@ -589,7 +589,7 @@ static void panic_halt_ipmi_heartbeat(vo
 				 1);
 }
 
-static struct watchdog_info ident=
+static struct watchdog_info ident =
 {
 	.options	= 0,	/* WDIOF_SETTIMEOUT, */
 	.firmware_version = 1,
@@ -790,13 +790,13 @@ static int ipmi_fasync(int fd, struct fi
 
 static int ipmi_close(struct inode *ino, struct file *filep)
 {
-	if (iminor(ino)==WATCHDOG_MINOR)
-	{
+	if (iminor(ino) == WATCHDOG_MINOR) {
 		if (expect_close == 42) {
 			ipmi_watchdog_state = WDOG_TIMEOUT_NONE;
 			ipmi_set_timeout(IPMI_SET_TIMEOUT_NO_HB);
 		} else {
-			printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
+			printk(KERN_CRIT PFX
+			       "Unexpected close, not stopping watchdog!\n");
 			ipmi_heartbeat();
 		}
 		clear_bit(0, &ipmi_wdog_open);
