Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVL2LMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVL2LMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbVL2LMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:12:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6476 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964968AbVL2LMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:12:31 -0500
Date: Thu, 29 Dec 2005 12:14:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Zhu Yi <yi.zhu@intel.com>, jketreno@linux.intel.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipw2200 stack reduction
Message-ID: <20051229111414.GI2772@suse.de>
References: <20051228212934.GA2772@suse.de> <1135847228.9670.69.camel@debian.sh.intel.com> <20051229091940.GD2772@suse.de> <84144f020512290239t6192b344g63e4a71e44e8dfaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020512290239t6192b344g63e4a71e44e8dfaa@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29 2005, Pekka Enberg wrote:
> Hi,
> 
> On 12/29/05, Jens Axboe <axboe@suse.de> wrote:
> > Well you could do that if you wanted, but 500 bytes of dynamic
> > allocation is not a big issue. But it could be an optimization on top of
> > this patch, indeed. The downside is that you then have to do 2
> > allocations for each command, so whether it would be a win or not I
> > don't know.
> 
> The allocation shouldn't make much difference but for the implicit
> memset() smaller size is a win maybe?

Good point. With the payload dynamic, the host_cmd is really small (only
8 bytes). If we put that back on the stack, we can just use the buffer
that the caller passes in. Net result: zero extra allocations.

Applied on top of the two other patches. Zhu, let me know if you just
want 1 patch instead. It is just one change, so...

Signed-off-by: Jens Axboe <axboe@suse.de>

--- linux-2.6.git/drivers/net/wireless/ipw2200.c~	2005-12-29 11:46:46.000000000 +0100
+++ linux-2.6.git/drivers/net/wireless/ipw2200.c	2005-12-29 12:11:33.000000000 +0100
@@ -1871,10 +1871,6 @@
 
 #define HOST_COMPLETE_TIMEOUT HZ
 
-/*
- * Note: this function frees the cmd, so it must not be touched by the callee
- * after submitting it.
- */
 static int __ipw_send_cmd(struct ipw_priv *priv, struct host_cmd *cmd)
 {
 	int rc = 0;
@@ -1885,8 +1881,7 @@
 		IPW_ERROR("Failed to send %s: Already sending a command.\n",
 			  get_cmd_string(cmd->cmd));
 		spin_unlock_irqrestore(&priv->lock, flags);
-		rc = -EAGAIN;
-		goto out;
+		return -EAGAIN;
 	}
 
 	priv->status |= STATUS_HCMD_ACTIVE;
@@ -1905,7 +1900,7 @@
 		     priv->status);
 	printk_buf(IPW_DL_HOST_COMMAND, (u8 *) cmd->param, cmd->len);
 
-	rc = ipw_queue_tx_hcmd(priv, cmd->cmd, &cmd->param, cmd->len, 0);
+	rc = ipw_queue_tx_hcmd(priv, cmd->cmd, cmd->param, cmd->len, 0);
 	if (rc) {
 		priv->status &= ~STATUS_HCMD_ACTIVE;
 		IPW_ERROR("Failed to send %s: Reason %d\n",
@@ -1945,49 +1940,28 @@
 		priv->cmdlog[priv->cmdlog_pos++].retcode = rc;
 		priv->cmdlog_pos %= priv->cmdlog_len;
 	}
-out:
-	kfree(cmd);
 	return rc;
 }
 
-static struct host_cmd *ipw_host_cmd_get(u8 command, u8 len)
-{
-	struct host_cmd *cmd;
-
-	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
-	if (cmd) {
-		cmd->cmd = command;
-		cmd->len = len;
-	}
-
-	return cmd;
-}
-
 static int ipw_send_cmd_simple(struct ipw_priv *priv, u8 command)
 {
-	struct host_cmd *cmd;
-
-	cmd = ipw_host_cmd_get(command, 0);
-	if (cmd)
-		return __ipw_send_cmd(priv, cmd);
+	struct host_cmd cmd = {
+		.cmd = command,
+	};
 
-	IPW_ERROR("Out of memory for cmd %x\n", command);
-	return -1;
+	return __ipw_send_cmd(priv, &cmd);
 }
 
 static int ipw_send_cmd_pdu(struct ipw_priv *priv, u8 command, u8 len,
 			    void *data)
 {
-	struct host_cmd *cmd;
-
-	cmd = ipw_host_cmd_get(command, len);
-	if (cmd) {
-		memcpy(cmd->param, data, len);
-		return __ipw_send_cmd(priv, cmd);
-	}
+	struct host_cmd cmd = {
+		.cmd = command,
+		.len = len,
+		.param = data,
+	};
 
-	IPW_ERROR("Out of memory for cmd %x\n", command);
-	return -1;
+	return __ipw_send_cmd(priv, &cmd);
 }
 
 static int ipw_send_host_complete(struct ipw_priv *priv)
diff --git a/drivers/net/wireless/ipw2200.h b/drivers/net/wireless/ipw2200.h
index 1c98db0..dab1dcd 100644
--- a/drivers/net/wireless/ipw2200.h
+++ b/drivers/net/wireless/ipw2200.h
@@ -1860,7 +1860,7 @@ struct host_cmd {
 	u8 cmd;
 	u8 len;
 	u16 reserved;
-	u32 param[TFD_CMD_IMMEDIATE_PAYLOAD_LENGTH];
+	u32 *param;
 } __attribute__ ((packed));
 
 struct ipw_cmd_log {


-- 
Jens Axboe

