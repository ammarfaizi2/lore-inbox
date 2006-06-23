Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWFWPHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWFWPHG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWFWPHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:07:06 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:49855 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751349AbWFWPHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:07:04 -0400
From: "amatus@ocgnet.org" <amatus@ocgnet.org>
Date: Fri, 23 Jun 2006 10:07:05 -0500
To: openipmi-developer@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] IPMI: Support registering for a command per-channel
Message-ID: <20060623150705.GA14245@login.ocgnet.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: David Barksdale <amatus@ocgnet.org>

This patch adds the ability to register for a command per-channel.

If your BMC supports multiple channels, incoming messages can be
differentiated by the channel on which they arrived. In this case it's
useful to have the ability to register to receive commands on a
specific channel instead the current behaviour of all channels.

Signed-off-by: David Barksdale <amatus@ocgnet.org>

---

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ipmi_channels.patch"


--- drivers/char/ipmi/ipmi_devintf.c	2006-06-14 15:40:12.000000000 -0500
+++ drivers/char/ipmi/ipmi_devintf.c.keep	2006-06-14 15:42:51.000000000 -0500
@@ -379,7 +379,7 @@
 			break;
 		}
 
-		rv = ipmi_register_for_cmd(priv->user, val.netfn, val.cmd);
+		rv = ipmi_register_for_cmd(priv->user, val.netfn, val.cmd, 255);
 		break;
 	}
 
@@ -392,7 +392,36 @@
 			break;
 		}
 
-		rv = ipmi_unregister_for_cmd(priv->user, val.netfn, val.cmd);
+		rv = ipmi_unregister_for_cmd(priv->user, val.netfn, val.cmd,
+			255);
+		break;
+	}
+
+	case IPMICTL_REGISTER_FOR_CMD2:
+	{
+		struct ipmi_cmdspec2 val;
+
+		if (copy_from_user(&val, arg, sizeof(val))) {
+			rv = -EFAULT;
+			break;
+		}
+
+		rv = ipmi_register_for_cmd(priv->user, val.netfn, val.cmd,
+			val.chan);
+		break;
+	}
+
+	case IPMICTL_UNREGISTER_FOR_CMD2:
+	{
+		struct ipmi_cmdspec2 val;
+
+		if (copy_from_user(&val, arg, sizeof(val))) {
+			rv = -EFAULT;
+			break;
+		}
+
+		rv = ipmi_unregister_for_cmd(priv->user, val.netfn, val.cmd,
+			val.chan);
 		break;
 	}
 
--- drivers/char/ipmi/ipmi_msghandler.c	2006-06-14 15:40:20.000000000 -0500
+++ drivers/char/ipmi/ipmi_msghandler.c.keep	2006-06-14 17:00:27.000000000 -0500
@@ -96,6 +96,7 @@
 	ipmi_user_t   user;
 	unsigned char netfn;
 	unsigned char cmd;
+	unsigned char chan;
 
 	/*
 	 * This is used to form a linked lised during mass deletion.
@@ -921,12 +922,15 @@
 
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
+			&& ((chan == 255) || (rcvr->chan == 255)
+			|| (rcvr->chan == chan)))
 			return rcvr;
 	}
 	return NULL;
@@ -934,7 +938,8 @@
 
 int ipmi_register_for_cmd(ipmi_user_t   user,
 			  unsigned char netfn,
-			  unsigned char cmd)
+			  unsigned char cmd,
+			  unsigned char chan)
 {
 	ipmi_smi_t      intf = user->intf;
 	struct cmd_rcvr *rcvr;
@@ -947,11 +952,12 @@
 		return -ENOMEM;
 	rcvr->cmd = cmd;
 	rcvr->netfn = netfn;
+	rcvr->chan = chan;
 	rcvr->user = user;
 
 	down(&intf->cmd_rcvrs_lock);
-	/* Make sure the command/netfn is not already registered. */
-	entry = find_cmd_rcvr(intf, netfn, cmd);
+	/* Make sure the command/netfn/chan is not already registered. */
+	entry = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if (entry) {
 		rv = -EBUSY;
 		goto out_unlock;
@@ -969,14 +975,15 @@
 
 int ipmi_unregister_for_cmd(ipmi_user_t   user,
 			    unsigned char netfn,
-			    unsigned char cmd)
+			    unsigned char cmd,
+			    unsigned char chan)
 {
 	ipmi_smi_t      intf = user->intf;
 	struct cmd_rcvr *rcvr;
 
 	down(&intf->cmd_rcvrs_lock);
-	/* Make sure the command/netfn is not already registered. */
-	rcvr = find_cmd_rcvr(intf, netfn, cmd);
+	/* Make sure the command/netfn/chan is already registered. */
+	rcvr = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if ((rcvr) && (rcvr->user == user)) {
 		list_del_rcu(&rcvr->link);
 		up(&intf->cmd_rcvrs_lock);
@@ -2036,6 +2043,7 @@
 	int                      rv = 0;
 	unsigned char            netfn;
 	unsigned char            cmd;
+	unsigned char            chan;
 	ipmi_user_t              user = NULL;
 	struct ipmi_ipmb_addr    *ipmb_addr;
 	struct ipmi_recv_msg     *recv_msg;
@@ -2056,9 +2064,10 @@
 
 	netfn = msg->rsp[4] >> 2;
 	cmd = msg->rsp[8];
+	chan = msg->rsp[3] & 0xf;
 
 	rcu_read_lock();
-	rcvr = find_cmd_rcvr(intf, netfn, cmd);
+	rcvr = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if (rcvr) {
 		user = rcvr->user;
 		kref_get(&user->refcount);
@@ -2216,6 +2225,7 @@
 	int                      rv = 0;
 	unsigned char            netfn;
 	unsigned char            cmd;
+	unsigned char            chan;
 	ipmi_user_t              user = NULL;
 	struct ipmi_lan_addr     *lan_addr;
 	struct ipmi_recv_msg     *recv_msg;
@@ -2236,9 +2246,10 @@
 
 	netfn = msg->rsp[6] >> 2;
 	cmd = msg->rsp[10];
+	chan = msg->rsp[3] & 0xf;
 
 	rcu_read_lock();
-	rcvr = find_cmd_rcvr(intf, netfn, cmd);
+	rcvr = find_cmd_rcvr(intf, netfn, cmd, chan);
 	if (rcvr) {
 		user = rcvr->user;
 		kref_get(&user->refcount);
--- include/linux/ipmi.h	2006-06-14 15:47:32.000000000 -0500
+++ include/linux/ipmi.h.keep	2006-06-14 15:52:41.000000000 -0500
@@ -353,18 +353,20 @@
 
 /*
  * When commands come in to the SMS, the user can register to receive
- * them.  Only one user can be listening on a specific netfn/cmd pair
+ * them.  Only one user can be listening on a specific netfn/cmd/chan tuple
  * at a time, you will get an EBUSY error if the command is already
- * registered.  If a command is received that does not have a user
- * registered, the driver will automatically return the proper
- * error.
+ * registered.  A channel number of 255 signifies listening on all channels.
+ * If a command is received that does not have a user registered, the driver
+ * will automatically return the proper error.
  */
 int ipmi_register_for_cmd(ipmi_user_t   user,
 			  unsigned char netfn,
-			  unsigned char cmd);
+			  unsigned char cmd,
+			  unsigned char chan);
 int ipmi_unregister_for_cmd(ipmi_user_t   user,
 			    unsigned char netfn,
-			    unsigned char cmd);
+			    unsigned char cmd,
+			    unsigned char chan);
 
 /*
  * Allow run-to-completion mode to be set for the interface of
@@ -558,6 +560,14 @@
 	unsigned char cmd;
 };
 
+/* Register to get commands from other entities on a particular channel. */
+struct ipmi_cmdspec2
+{
+	unsigned char netfn;
+	unsigned char cmd;
+	unsigned char chan;
+};
+
 /* 
  * Register to receive a specific command.  error values:
  *   - EFAULT - an address supplied was invalid.
@@ -575,6 +585,22 @@
 					     struct ipmi_cmdspec)
 
 /* 
+ * Register to receive a specific command on a specific channel.  error values:
+ *   - EFAULT - an address supplied was invalid.
+ *   - EBUSY - The netfn/cmd/chan supplied was already in use.
+ *   - ENOMEM - could not allocate memory for the entry.
+ */
+#define IPMICTL_REGISTER_FOR_CMD2	_IOR(IPMI_IOC_MAGIC, 28,	\
+					     struct ipmi_cmdspec2)
+/*
+ * Unregister a regsitered command.  error values:
+ *  - EFAULT - an address supplied was invalid.
+ *  - ENOENT - The netfn/cmd/chan was not found registered for this user.
+ */
+#define IPMICTL_UNREGISTER_FOR_CMD2	_IOR(IPMI_IOC_MAGIC, 29,	\
+					     struct ipmi_cmdspec2)
+
+/* 
  * Set whether this interface receives events.  Note that the first
  * user registered for events will get all pending events for the
  * interface.  error values:

--pWyiEgJYm5f9v55/--
