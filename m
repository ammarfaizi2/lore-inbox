Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWI0CX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWI0CX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 22:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWI0CX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 22:23:28 -0400
Received: from sccrmhc11.comcast.net ([204.127.200.81]:40438 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750777AbWI0CX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 22:23:27 -0400
Date: Tue, 26 Sep 2006 21:25:24 -0500
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       David Barksdale <amatus@ocgnet.org>
Subject: Re: [PATCH] IPMI: per-channel command registration
Message-ID: <20060927022524.GA16144@localdomain>
Reply-To: minyard@acm.org
References: <20060925140941.GA6364@localdomain> <20060926173711.ea3c877e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060926173711.ea3c877e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 05:37:11PM -0700, Andrew Morton wrote:
> > +struct ipmi_cmdspec_chans
> > +{
> > +	unsigned char netfn;
> > +	unsigned char cmd;
> > +	unsigned int  chans;
> > +};
> 
> Has it been tested with 32-bit userspace and a 64-bit kernel?

I'll try to do that sometime soon, when I can get access to a 64-bit
machine with IPMI.

> 
> Even if it has, I'd be a bit worried that it depends upon the user's
> compiler laying this structure out in the same manner as did his
> kernel-provider's compiler.
> 
> Turning this into three u32's sounds safer?

Yes, it does.  Here's another pass (or you can change the "chars" to
"ints" in that structure).  Thanks.

-Corey


This patch adds the ability to register for a command per-channel in
the IPMI driver.

If your BMC supports multiple channels, incoming messages can be
differentiated by the channel on which they arrived. In this case it's
useful to have the ability to register to receive commands on a
specific channel instead the current behaviour of all channels.

Signed-off-by: David Barksdale <amatus@ocgnet.org>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.18/drivers/char/ipmi/ipmi_devintf.c
===================================================================
--- linux-2.6.18.orig/drivers/char/ipmi/ipmi_devintf.c
+++ linux-2.6.18/drivers/char/ipmi/ipmi_devintf.c
@@ -377,7 +377,8 @@ static int ipmi_ioctl(struct inode  *ino
 			break;
 		}
 
-		rv = ipmi_register_for_cmd(priv->user, val.netfn, val.cmd);
+		rv = ipmi_register_for_cmd(priv->user, val.netfn, val.cmd,
+					   IPMI_CHAN_ALL);
 		break;
 	}
 
@@ -390,7 +391,36 @@ static int ipmi_ioctl(struct inode  *ino
 			break;
 		}
 
-		rv = ipmi_unregister_for_cmd(priv->user, val.netfn, val.cmd);
+		rv = ipmi_unregister_for_cmd(priv->user, val.netfn, val.cmd,
+					     IPMI_CHAN_ALL);
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
+					   val.chans);
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
+					     val.chans);
 		break;
 	}
 
Index: linux-2.6.18/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.18.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.18/drivers/char/ipmi/ipmi_msghandler.c
@@ -96,6 +96,7 @@ struct cmd_rcvr
 	ipmi_user_t   user;
 	unsigned char netfn;
 	unsigned char cmd;
+	unsigned int  chans;
 
 	/*
 	 * This is used to form a linked lised during mass deletion.
@@ -953,24 +954,41 @@ int ipmi_set_gets_events(ipmi_user_t use
 
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
+					&& (rcvr->chans & (1 << chan)))
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
+					&& (rcvr->chans & chans))
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
 
 
@@ -979,12 +997,12 @@ int ipmi_register_for_cmd(ipmi_user_t   
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
@@ -1001,24 +1019,39 @@ int ipmi_register_for_cmd(ipmi_user_t   
 
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
+		if (((1 << i) & chans) == 0)
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
@@ -2548,6 +2581,7 @@ static int handle_ipmb_get_msg_cmd(ipmi_
 	int                      rv = 0;
 	unsigned char            netfn;
 	unsigned char            cmd;
+	unsigned char            chan;
 	ipmi_user_t              user = NULL;
 	struct ipmi_ipmb_addr    *ipmb_addr;
 	struct ipmi_recv_msg     *recv_msg;
@@ -2568,9 +2602,10 @@ static int handle_ipmb_get_msg_cmd(ipmi_
 
 	netfn = msg->rsp[4] >> 2;
 	cmd = msg->rsp[8];
+	chan = msg->rsp[3] & 0xf;
 
 	rcu_read_lock();
-	rcvr = find_cmd_rcvr(intf, netfn, cmd);
+	rcvr = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if (rcvr) {
 		user = rcvr->user;
 		kref_get(&user->refcount);
@@ -2728,6 +2763,7 @@ static int handle_lan_get_msg_cmd(ipmi_s
 	int                      rv = 0;
 	unsigned char            netfn;
 	unsigned char            cmd;
+	unsigned char            chan;
 	ipmi_user_t              user = NULL;
 	struct ipmi_lan_addr     *lan_addr;
 	struct ipmi_recv_msg     *recv_msg;
@@ -2748,9 +2784,10 @@ static int handle_lan_get_msg_cmd(ipmi_s
 
 	netfn = msg->rsp[6] >> 2;
 	cmd = msg->rsp[10];
+	chan = msg->rsp[3] & 0xf;
 
 	rcu_read_lock();
-	rcvr = find_cmd_rcvr(intf, netfn, cmd);
+	rcvr = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if (rcvr) {
 		user = rcvr->user;
 		kref_get(&user->refcount);
Index: linux-2.6.18/include/linux/ipmi.h
===================================================================
--- linux-2.6.18.orig/include/linux/ipmi.h
+++ linux-2.6.18/include/linux/ipmi.h
@@ -148,6 +148,13 @@ struct ipmi_lan_addr
 #define IPMI_BMC_CHANNEL  0xf
 #define IPMI_NUM_CHANNELS 0x10
 
+/*
+ * Used to signify an "all channel" bitmask.  This is more than the
+ * actual number of channels because this is used in userland and
+ * will cover us if the number of channels is extended.
+ */
+#define IPMI_CHAN_ALL     (~0)
+
 
 /*
  * A raw IPMI message without any addressing.  This covers both
@@ -350,18 +357,21 @@ int ipmi_request_supply_msgs(ipmi_user_t
 
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
@@ -571,6 +581,36 @@ struct ipmi_cmdspec
 #define IPMICTL_UNREGISTER_FOR_CMD	_IOR(IPMI_IOC_MAGIC, 15,	\
 					     struct ipmi_cmdspec)
 
+/*
+ * Register to get commands from other entities on specific channels.
+ * This way, you can only listen on specific channels, or have messages
+ * from some channels go to one place and other channels to someplace
+ * else.  The chans field is a bitmask, (1 << channel) for each channel.
+ * It may be IPMI_CHAN_ALL for all channels.
+ */
+struct ipmi_cmdspec_chans
+{
+	unsigned int netfn;
+	unsigned int cmd;
+	unsigned int chans;
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
Index: linux-2.6.18/Documentation/IPMI.txt
===================================================================
--- linux-2.6.18.orig/Documentation/IPMI.txt
+++ linux-2.6.18/Documentation/IPMI.txt
@@ -326,9 +326,12 @@ for events, they will all receive all ev
 
 For receiving commands, you have to individually register commands you
 want to receive.  Call ipmi_register_for_cmd() and supply the netfn
-and command name for each command you want to receive.  Only one user
-may be registered for each netfn/cmd, but different users may register
-for different commands.
+and command name for each command you want to receive.  You also
+specify a bitmask of the channels you want to receive the command from
+(or use IPMI_CHAN_ALL for all channels if you don't care).  Only one
+user may be registered for each netfn/cmd/channel, but different users
+may register for different commands, or the same command if the
+channel bitmasks do not overlap.
 
 From userland, equivalent IOCTLs are provided to do these functions.
 
