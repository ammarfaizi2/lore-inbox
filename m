Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbUKFW3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbUKFW3t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 17:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbUKFW3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 17:29:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13062 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261489AbUKFW3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 17:29:14 -0500
Date: Sat, 6 Nov 2004 23:28:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Corey Minyard <minyard@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: RFC: [2.6 patch] small IPMI cleanup
Message-ID: <20041106222839.GS1295@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following changes to the IPMI code:
- remove some completely unused code
- make some needlessly global code static

This inlcldes the removal of some EXPORT_SYMBOL'ed code with zero users.

Is this patch OK or are in-kernel users for these functions pending?


diffstat output:
 drivers/char/ipmi/ipmi_msghandler.c |   99 ----------------------------
 drivers/char/ipmi/ipmi_poweroff.c   |    6 -
 drivers/char/ipmi/ipmi_si_intf.c    |    4 -
 drivers/char/ipmi/ipmi_watchdog.c   |   17 ----
 include/linux/ipmi.h                |   63 -----------------
 5 files changed, 7 insertions(+), 182 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/include/linux/ipmi.h.old	2004-11-06 22:09:50.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/linux/ipmi.h	2004-11-06 22:10:56.000000000 +0100
@@ -253,7 +253,6 @@
 {
 	msg->done(msg);
 }
-struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
 
 struct ipmi_user_hndl
 {
@@ -303,32 +302,6 @@
 unsigned char ipmi_get_my_LUN(ipmi_user_t user);
 
 /*
- * Send a command request from the given user.  The address is the
- * proper address for the channel type.  If this is a command, then
- * the message response comes back, the receive handler for this user
- * will be called with the given msgid value in the recv msg.  If this
- * is a response to a command, then the msgid will be used as the
- * sequence number for the response (truncated if necessary), so when
- * sending a response you should use the sequence number you received
- * in the msgid field of the received command.  If the priority is >
- * 0, the message will go into a high-priority queue and be sent
- * first.  Otherwise, it goes into a normal-priority queue.
- * The user_msg_data field will be returned in any response to this
- * message.
- *
- * Note that if you send a response (with the netfn lower bit set),
- * you *will* get back a SEND_MSG response telling you what happened
- * when the response was sent.  You will not get back a response to
- * the message itself.
- */
-int ipmi_request(ipmi_user_t      user,
-		 struct ipmi_addr *addr,
-		 long             msgid,
-		 struct kernel_ipmi_msg *msg,
-		 void             *user_msg_data,
-		 int              priority);
-
-/*
  * Like ipmi_request, but lets you specify the number of retries and
  * the retry time.  The retries is the number of times the message
  * will be resent if no reply is received.  If set to -1, the default
@@ -351,18 +324,6 @@
 			 unsigned int     retry_time_ms);
 
 /*
- * Like ipmi_request, but lets you specify the slave return address.
- */
-int ipmi_request_with_source(ipmi_user_t      user,
-			     struct ipmi_addr *addr,
-			     long             msgid,
-			     struct kernel_ipmi_msg  *msg,
-			     void             *user_msg_data,
-			     int              priority,
-			     unsigned char    source_address,
-			     unsigned char    source_lun);
-
-/*
  * Like ipmi_request, but with messages supplied.  This will not
  * allocate any memory, and the messages may be statically allocated
  * (just make sure to do the "done" handling on them).  Note that this
@@ -381,16 +342,6 @@
 			     int                  priority);
 
 /*
- * Do polling on the IPMI interface the user is attached to.  This
- * causes the IPMI code to do an immediate check for information from
- * the driver and handle anything that is immediately pending.  This
- * will not block in anyway.  This is useful if you need to implement
- * polling from the user like you need to send periodic watchdog pings
- * from a crash dump, or something like that.
- */
-void ipmi_poll_interface(ipmi_user_t user);
-
-/*
  * When commands come in to the SMS, the user can register to receive
  * them.  Only one user can be listening on a specific netfn/cmd pair
  * at a time, you will get an EBUSY error if the command is already
@@ -420,17 +371,6 @@
 int ipmi_set_gets_events(ipmi_user_t user, int val);
 
 /*
- * Register the given user to handle all received IPMI commands.  This
- * will fail if anyone is registered as a command receiver or if
- * another is already registered to receive all commands.  NOTE THAT
- * THIS IS FOR EMULATION USERS ONLY, DO NOT USER THIS FOR NORMAL
- * STUFF.
- */
-int ipmi_register_all_cmd_rcvr(ipmi_user_t user);
-int ipmi_unregister_all_cmd_rcvr(ipmi_user_t user);
-
-
-/*
  * Called when a new SMI is registered.  This will also be called on
  * every existing interface when a new watcher is registered with
  * ipmi_smi_watcher_register().
@@ -463,9 +403,6 @@
 /* Validate that the given IPMI address is valid. */
 int ipmi_validate_addr(struct ipmi_addr *addr, int len);
 
-/* Return 1 if the given addresses are equal, 0 if not. */
-int ipmi_addr_equal(struct ipmi_addr *addr1, struct ipmi_addr *addr2);
-
 #endif /* __KERNEL__ */
 
 
--- linux-2.6.10-rc1-mm3-full/drivers/char/ipmi/ipmi_msghandler.c.old	2004-11-06 22:11:18.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ipmi/ipmi_msghandler.c	2004-11-06 22:12:58.000000000 +0100
@@ -49,7 +49,7 @@
 #define PFX "IPMI message handler: "
 #define IPMI_MSGHANDLER_VERSION "v33"
 
-struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
+static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
 static int ipmi_init_msghandler(void);
 
 static int initialized = 0;
@@ -294,44 +294,6 @@
 	unsigned int events;
 };
 
-int
-ipmi_register_all_cmd_rcvr(ipmi_user_t user)
-{
-	unsigned long flags;
-	int           rv = -EBUSY;
-
-	write_lock_irqsave(&(user->intf->users_lock), flags);
-	write_lock(&(user->intf->cmd_rcvr_lock));
-	if ((user->intf->all_cmd_rcvr == NULL)
-	    && (list_empty(&(user->intf->cmd_rcvrs))))
-	{
-		user->intf->all_cmd_rcvr = user;
-		rv = 0;
-	}
-	write_unlock(&(user->intf->cmd_rcvr_lock));
-	write_unlock_irqrestore(&(user->intf->users_lock), flags);
-	return rv;
-}
-
-int
-ipmi_unregister_all_cmd_rcvr(ipmi_user_t user)
-{
-	unsigned long flags;
-	int           rv = -EINVAL;
-
-	write_lock_irqsave(&(user->intf->users_lock), flags);
-	write_lock(&(user->intf->cmd_rcvr_lock));
-	if (user->intf->all_cmd_rcvr == user)
-	{
-		user->intf->all_cmd_rcvr = NULL;
-		rv = 0;
-	}
-	write_unlock(&(user->intf->cmd_rcvr_lock));
-	write_unlock_irqrestore(&(user->intf->users_lock), flags);
-	return rv;
-}
-
-
 #define MAX_IPMI_INTERFACES 4
 static ipmi_smi_t ipmi_interfaces[MAX_IPMI_INTERFACES];
 
@@ -389,7 +351,7 @@
 	up_read(&smi_watchers_sem);
 }
 
-int
+static int
 ipmi_addr_equal(struct ipmi_addr *addr1, struct ipmi_addr *addr2)
 {
 	if (addr1->addr_type != addr2->addr_type)
@@ -1360,26 +1322,6 @@
 	return rv;
 }
 
-int ipmi_request(ipmi_user_t      user,
-		 struct ipmi_addr *addr,
-		 long             msgid,
-		 struct kernel_ipmi_msg  *msg,
-		 void             *user_msg_data,
-		 int              priority)
-{
-	return i_ipmi_request(user,
-			      user->intf,
-			      addr,
-			      msgid,
-			      msg,
-			      user_msg_data,
-			      NULL, NULL,
-			      priority,
-			      user->intf->my_address,
-			      user->intf->my_lun,
-			      -1, 0);
-}
-
 int ipmi_request_settime(ipmi_user_t      user,
 			 struct ipmi_addr *addr,
 			 long             msgid,
@@ -1426,28 +1368,6 @@
 			      -1, 0);
 }
 
-int ipmi_request_with_source(ipmi_user_t      user,
-			     struct ipmi_addr *addr,
-			     long             msgid,
-			     struct kernel_ipmi_msg  *msg,
-			     void             *user_msg_data,
-			     int              priority,
-			     unsigned char    source_address,
-			     unsigned char    source_lun)
-{
-	return i_ipmi_request(user,
-			      user->intf,
-			      addr,
-			      msgid,
-			      msg,
-			      user_msg_data,
-			      NULL, NULL,
-			      priority,
-			      source_address,
-			      source_lun,
-			      -1, 0);
-}
-
 static int ipmb_file_read_proc(char *page, char **start, off_t off,
 			       int count, int *eof, void *data)
 {
@@ -1702,14 +1622,6 @@
 	return;
 }
 
-void ipmi_poll_interface(ipmi_user_t user)
-{
-	ipmi_smi_t intf = user->intf;
-
-	if (intf->handlers->poll)
-		intf->handlers->poll(intf->send_info);
-}
-
 int ipmi_register_smi(struct ipmi_smi_handlers *handlers,
 		      void		       *send_info,
 		      unsigned char            version_major,
@@ -3211,15 +3123,11 @@
 module_init(ipmi_init_msghandler_mod);
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(ipmi_alloc_recv_msg);
 EXPORT_SYMBOL(ipmi_create_user);
 EXPORT_SYMBOL(ipmi_destroy_user);
 EXPORT_SYMBOL(ipmi_get_version);
-EXPORT_SYMBOL(ipmi_request);
 EXPORT_SYMBOL(ipmi_request_settime);
 EXPORT_SYMBOL(ipmi_request_supply_msgs);
-EXPORT_SYMBOL(ipmi_request_with_source);
-EXPORT_SYMBOL(ipmi_poll_interface);
 EXPORT_SYMBOL(ipmi_register_smi);
 EXPORT_SYMBOL(ipmi_unregister_smi);
 EXPORT_SYMBOL(ipmi_register_for_cmd);
@@ -3227,12 +3135,9 @@
 EXPORT_SYMBOL(ipmi_smi_msg_received);
 EXPORT_SYMBOL(ipmi_smi_watchdog_pretimeout);
 EXPORT_SYMBOL(ipmi_alloc_smi_msg);
-EXPORT_SYMBOL(ipmi_register_all_cmd_rcvr);
-EXPORT_SYMBOL(ipmi_unregister_all_cmd_rcvr);
 EXPORT_SYMBOL(ipmi_addr_length);
 EXPORT_SYMBOL(ipmi_validate_addr);
 EXPORT_SYMBOL(ipmi_set_gets_events);
-EXPORT_SYMBOL(ipmi_addr_equal);
 EXPORT_SYMBOL(ipmi_smi_watcher_register);
 EXPORT_SYMBOL(ipmi_smi_watcher_unregister);
 EXPORT_SYMBOL(ipmi_set_my_address);
--- linux-2.6.10-rc1-mm3-full/drivers/char/ipmi/ipmi_poweroff.c.old	2004-11-06 22:14:05.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ipmi/ipmi_poweroff.c	2004-11-06 22:14:32.000000000 +0100
@@ -45,9 +45,9 @@
 extern void (*pm_power_off)(void);
 
 /* Stuff from the get device id command. */
-unsigned int mfg_id;
-unsigned int prod_id;
-unsigned char capabilities;
+static unsigned int mfg_id;
+static unsigned int prod_id;
+static unsigned char capabilities;
 
 /* We use our own messages for this operation, we don't let the system
    allocate them, since we may be in a panic situation.  The whole
--- linux-2.6.10-rc1-mm3-full/drivers/char/ipmi/ipmi_si_intf.c.old	2004-11-06 22:15:03.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ipmi/ipmi_si_intf.c	2004-11-06 22:15:27.000000000 +0100
@@ -1331,7 +1331,7 @@
 static int acpi_failure = 0;
 
 /* For GPE-type interrupts. */
-void ipmi_acpi_gpe(void *context)
+static void ipmi_acpi_gpe(void *context)
 {
 	struct smi_info *smi_info = context;
 	unsigned long   flags;
@@ -2251,7 +2251,7 @@
 }
 module_init(init_ipmi_si);
 
-void __exit cleanup_one_si(struct smi_info *to_clean)
+static void __exit cleanup_one_si(struct smi_info *to_clean)
 {
 	int           rv;
 	unsigned long flags;
--- linux-2.6.10-rc1-mm3-full/drivers/char/ipmi/ipmi_watchdog.c.old	2004-11-06 22:15:42.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/ipmi/ipmi_watchdog.c	2004-11-06 22:16:04.000000000 +0100
@@ -366,20 +366,6 @@
 	}
 }
 
-/* Do a delayed shutdown, with the delay in milliseconds.  If power_off is
-   false, do a reset.  If power_off is true, do a power down.  This is
-   primarily for the IMB code's shutdown. */
-void ipmi_delayed_shutdown(long delay, int power_off)
-{
-	ipmi_ignore_heartbeat = 1;
-	if (power_off) 
-		ipmi_watchdog_state = WDOG_TIMEOUT_POWER_DOWN;
-	else
-		ipmi_watchdog_state = WDOG_TIMEOUT_RESET;
-	timeout = delay;
-	ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
-}
-
 /* We use a semaphore to make sure that only one thing can send a
    heartbeat at one time, because we only have one copy of the data.
    The semaphore is claimed when the set_timeout is sent and freed
@@ -1084,8 +1070,5 @@
 	ipmi_unregister_watchdog();
 }
 module_exit(ipmi_wdog_exit);
-
-EXPORT_SYMBOL(ipmi_delayed_shutdown);
-
 module_init(ipmi_wdog_init);
 MODULE_LICENSE("GPL");

