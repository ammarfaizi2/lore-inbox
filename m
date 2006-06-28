Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWF1T2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWF1T2F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWF1T2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:28:04 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:7382 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751060AbWF1T2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:28:03 -0400
From: "amatus@ocgnet.org" <amatus@ocgnet.org>
Date: Wed, 28 Jun 2006 14:28:05 -0500
To: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI: Support registering for a command per-channel
Message-ID: <20060628192805.GA32766@login.ocgnet.org>
References: <20060623150705.GA14245@login.ocgnet.org> <449FF130.3010601@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449FF130.3010601@acm.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 09:37:36AM -0500, Corey Minyard wrote:
> amatus@ocgnet.org wrote:
> > From: David Barksdale <amatus@ocgnet.org>
> >
> > This patch adds the ability to register for a command per-channel.
> >
> > If your BMC supports multiple channels, incoming messages can be
> > differentiated by the channel on which they arrived. In this case it's
> > useful to have the ability to register to receive commands on a
> > specific channel instead the current behaviour of all channels.
> Sorry for the long delay on this.  I like the patch in general, there
> are a few things I'd like to fix in it, though:
> 
> * Instead of naming the IOCTLs xxx_CMD2, could you name
>   them xxx_CMD_CHANNEL, or something that conveys a
>   little more meaning?
Done.
> 
> * The command unregister function needs to use a different
>   matching function now that you have to allow non-exact
>   matches for the channels.  You still need an exact match
>   for unregistering.
It behaves more reasonably now that the channels are specified as
bitmasks. It will unregister all channels you specify and only report an
error if it couldn't find anything to unregister.
> 
> * Someone mentioned using a bitmask for the channels
>   you are registering.  I think that's a good idea.  IPMI
>   only allows 16 channels max, so an unsigned int should
>   be plenty.  Add a define for all channels and for setting
>   a specific channel.
Done.
> 
> Thanks,
> 
> -Corey

Please consider this updated patch. Thanks.

--
This patch is to be used in place of the last one.

diff -rup linux-2.6.17.1.orig/drivers/char/ipmi/ipmi_devintf.c linux-2.6.17.1/drivers/char/ipmi/ipmi_devintf.c
--- linux-2.6.17.1.orig/drivers/char/ipmi/ipmi_devintf.c	2006-06-20 04:31:55.000000000 -0500
+++ linux-2.6.17.1/drivers/char/ipmi/ipmi_devintf.c	2006-06-28 12:05:07.000000000 -0500
@@ -379,7 +379,8 @@ static int ipmi_ioctl(struct inode  *ino
 			break;
 		}
 
-		rv = ipmi_register_for_cmd(priv->user, val.netfn, val.cmd);
+		rv = ipmi_register_for_cmd(priv->user, val.netfn, val.cmd,
+			IPMI_CHAN_ALL);
 		break;
 	}
 
@@ -392,7 +393,36 @@ static int ipmi_ioctl(struct inode  *ino
 			break;
 		}
 
-		rv = ipmi_unregister_for_cmd(priv->user, val.netfn, val.cmd);
+		rv = ipmi_unregister_for_cmd(priv->user, val.netfn, val.cmd,
+			IPMI_CHAN_ALL);
+		break;
+	}
+
+	case IPMICTL_REGISTER_FOR_CMD_CHANS:
+	{
+		struct ipmi_cmdspec_chans val;
+
+		if (copy_from_user(&val, arg, sizeof(val))) {
+			rv = -EFAULT;
+			break;
+		}
+
+		rv = ipmi_register_for_cmd(priv->user, val.netfn, val.cmd,
+			val.chans);
+		break;
+	}
+
+	case IPMICTL_UNREGISTER_FOR_CMD_CHANS:
+	{
+		struct ipmi_cmdspec_chans val;
+
+		if (copy_from_user(&val, arg, sizeof(val))) {
+			rv = -EFAULT;
+			break;
+		}
+
+		rv = ipmi_unregister_for_cmd(priv->user, val.netfn, val.cmd,
+			val.chans);
 		break;
 	}
 
diff -rup linux-2.6.17.1.orig/drivers/char/ipmi/ipmi_msghandler.c linux-2.6.17.1/drivers/char/ipmi/ipmi_msghandler.c
--- linux-2.6.17.1.orig/drivers/char/ipmi/ipmi_msghandler.c	2006-06-20 04:31:55.000000000 -0500
+++ linux-2.6.17.1/drivers/char/ipmi/ipmi_msghandler.c	2006-06-28 13:31:24.000000000 -0500
@@ -98,6 +98,7 @@ struct cmd_rcvr
 	ipmi_user_t   user;
 	unsigned char netfn;
 	unsigned char cmd;
+	unsigned int  chans;
 
 	/*
 	 * This is used to form a linked lised during mass deletion.
@@ -958,24 +959,41 @@ int ipmi_set_gets_events(ipmi_user_t use
 
 static struct cmd_rcvr *find_cmd_rcvr(ipmi_smi_t    intf,
 				      unsigned char netfn,
-				      unsigned char cmd)
+				      unsigned char cmd,
+				      unsigned char chan)
 {
 	struct cmd_rcvr *rcvr;
 
 	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
-		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd))
+		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
+			&& (rcvr->chans & (1 << chan)))
 			return rcvr;
 	}
 	return NULL;
 }
 
+static int is_cmd_rcvr_exclusive(ipmi_smi_t    intf,
+				 unsigned char netfn,
+				 unsigned char cmd,
+				 unsigned int  chans)
+{
+	struct cmd_rcvr *rcvr;
+
+	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
+		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
+			&& (rcvr->chans & chans))
+			return 0;
+	}
+	return 1;
+}
+
 int ipmi_register_for_cmd(ipmi_user_t   user,
 			  unsigned char netfn,
-			  unsigned char cmd)
+			  unsigned char cmd,
+			  unsigned int  chans)
 {
 	ipmi_smi_t      intf = user->intf;
 	struct cmd_rcvr *rcvr;
-	struct cmd_rcvr *entry;
 	int             rv = 0;
 
 
@@ -984,12 +1002,12 @@ int ipmi_register_for_cmd(ipmi_user_t   
 		return -ENOMEM;
 	rcvr->cmd = cmd;
 	rcvr->netfn = netfn;
+	rcvr->chans = chans;
 	rcvr->user = user;
 
 	mutex_lock(&intf->cmd_rcvrs_mutex);
 	/* Make sure the command/netfn is not already registered. */
-	entry = find_cmd_rcvr(intf, netfn, cmd);
-	if (entry) {
+	if (!is_cmd_rcvr_exclusive(intf, netfn, cmd, chans)) {
 		rv = -EBUSY;
 		goto out_unlock;
 	}
@@ -1006,24 +1024,39 @@ int ipmi_register_for_cmd(ipmi_user_t   
 
 int ipmi_unregister_for_cmd(ipmi_user_t   user,
 			    unsigned char netfn,
-			    unsigned char cmd)
+			    unsigned char cmd,
+			    unsigned int  chans)
 {
 	ipmi_smi_t      intf = user->intf;
 	struct cmd_rcvr *rcvr;
+	struct cmd_rcvr *rcvrs = NULL;
+	int i, rv = -ENOENT;
 
 	mutex_lock(&intf->cmd_rcvrs_mutex);
-	/* Make sure the command/netfn is not already registered. */
-	rcvr = find_cmd_rcvr(intf, netfn, cmd);
-	if ((rcvr) && (rcvr->user == user)) {
-		list_del_rcu(&rcvr->link);
-		mutex_unlock(&intf->cmd_rcvrs_mutex);
-		synchronize_rcu();
+	for (i = 0; i < IPMI_NUM_CHANNELS; i++) {
+		if ((( 1 << i ) & chans ) == 0)
+			continue;
+		rcvr = find_cmd_rcvr(intf, netfn, cmd, i);
+		if (rcvr == NULL)
+			continue;
+		if (rcvr->user == user) {
+			rv = 0;
+			rcvr->chans &= ~chans;
+			if (rcvr->chans == 0) {
+				list_del_rcu(&rcvr->link);
+				rcvr->next = rcvrs;
+				rcvrs = rcvr;
+			}
+		}
+	}
+	mutex_unlock(&intf->cmd_rcvrs_mutex);
+	synchronize_rcu();
+	while (rcvrs) {
+		rcvr = rcvrs;
+		rcvrs = rcvr->next;
 		kfree(rcvr);
-		return 0;
-	} else {
-		mutex_unlock(&intf->cmd_rcvrs_mutex);
-		return -ENOENT;
 	}
+	return rv;
 }
 
 void ipmi_user_set_run_to_completion(ipmi_user_t user, int val)
@@ -2553,6 +2586,7 @@ static int handle_ipmb_get_msg_cmd(ipmi_
 	int                      rv = 0;
 	unsigned char            netfn;
 	unsigned char            cmd;
+	unsigned char            chan;
 	ipmi_user_t              user = NULL;
 	struct ipmi_ipmb_addr    *ipmb_addr;
 	struct ipmi_recv_msg     *recv_msg;
@@ -2573,9 +2607,10 @@ static int handle_ipmb_get_msg_cmd(ipmi_
 
 	netfn = msg->rsp[4] >> 2;
 	cmd = msg->rsp[8];
+	chan = msg->rsp[3] & 0xf;
 
 	rcu_read_lock();
-	rcvr = find_cmd_rcvr(intf, netfn, cmd);
+	rcvr = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if (rcvr) {
 		user = rcvr->user;
 		kref_get(&user->refcount);
@@ -2733,6 +2768,7 @@ static int handle_lan_get_msg_cmd(ipmi_s
 	int                      rv = 0;
 	unsigned char            netfn;
 	unsigned char            cmd;
+	unsigned char            chan;
 	ipmi_user_t              user = NULL;
 	struct ipmi_lan_addr     *lan_addr;
 	struct ipmi_recv_msg     *recv_msg;
@@ -2753,9 +2789,10 @@ static int handle_lan_get_msg_cmd(ipmi_s
 
 	netfn = msg->rsp[6] >> 2;
 	cmd = msg->rsp[10];
+	chan = msg->rsp[3] & 0xf;
 
 	rcu_read_lock();
-	rcvr = find_cmd_rcvr(intf, netfn, cmd);
+	rcvr = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if (rcvr) {
 		user = rcvr->user;
 		kref_get(&user->refcount);
diff -rup linux-2.6.17.1.orig/include/linux/ipmi.h linux-2.6.17.1/include/linux/ipmi.h
--- linux-2.6.17.1.orig/include/linux/ipmi.h	2006-06-20 04:31:55.000000000 -0500
+++ linux-2.6.17.1/include/linux/ipmi.h	2006-06-28 12:04:14.000000000 -0500
@@ -148,6 +148,7 @@ struct ipmi_lan_addr
  */
 #define IPMI_BMC_CHANNEL  0xf
 #define IPMI_NUM_CHANNELS 0x10
+#define IPMI_CHAN_ALL     (( 1 << IPMI_NUM_CHANNELS ) - 1 )
 
 
 /*
@@ -354,18 +355,21 @@ int ipmi_request_supply_msgs(ipmi_user_t
 
 /*
  * When commands come in to the SMS, the user can register to receive
- * them.  Only one user can be listening on a specific netfn/cmd pair
+ * them.  Only one user can be listening on a specific netfn/cmd/chan tuple
  * at a time, you will get an EBUSY error if the command is already
  * registered.  If a command is received that does not have a user
  * registered, the driver will automatically return the proper
- * error.
+ * error.  Channels are specified as a bitfield, use IPMI_CHAN_ALL to
+ * mean all channels.
  */
 int ipmi_register_for_cmd(ipmi_user_t   user,
 			  unsigned char netfn,
-			  unsigned char cmd);
+			  unsigned char cmd,
+			  unsigned int  chans);
 int ipmi_unregister_for_cmd(ipmi_user_t   user,
 			    unsigned char netfn,
-			    unsigned char cmd);
+			    unsigned char cmd,
+			    unsigned int  chans);
 
 /*
  * Allow run-to-completion mode to be set for the interface of
@@ -575,6 +579,30 @@ struct ipmi_cmdspec
 #define IPMICTL_UNREGISTER_FOR_CMD	_IOR(IPMI_IOC_MAGIC, 15,	\
 					     struct ipmi_cmdspec)
 
+/* Register to get commands from other entities on specific channels. */
+struct ipmi_cmdspec_chans
+{
+	unsigned char netfn;
+	unsigned char cmd;
+	unsigned int  chans;
+};
+
+/* 
+ * Register to receive a specific command on specific channels.  error values:
+ *   - EFAULT - an address supplied was invalid.
+ *   - EBUSY - One of the netfn/cmd/chans supplied was already in use.
+ *   - ENOMEM - could not allocate memory for the entry.
+ */
+#define IPMICTL_REGISTER_FOR_CMD_CHANS	_IOR(IPMI_IOC_MAGIC, 28,	\
+					     struct ipmi_cmdspec_chans)
+/*
+ * Unregister some netfn/cmd/chans.  error values:
+ *  - EFAULT - an address supplied was invalid.
+ *  - ENOENT - None of the netfn/cmd/chans were found registered for this user.
+ */
+#define IPMICTL_UNREGISTER_FOR_CMD_CHANS _IOR(IPMI_IOC_MAGIC, 29,	\
+					     struct ipmi_cmdspec_chans)
+
 /* 
  * Set whether this interface receives events.  Note that the first
  * user registered for events will get all pending events for the
