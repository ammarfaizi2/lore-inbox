Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbUL3JXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbUL3JXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 04:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUL3JCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 04:02:07 -0500
Received: from smtp.knology.net ([24.214.63.101]:26549 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261589AbUL3Isi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:38 -0500
Date: Thu, 30 Dec 2004 03:48:37 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 16/22] typhoon: collect crypto offload capabilities
Message-Id: <20041230035000.25@ori.thedillows.org>
References: <20041230035000.24@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 00:56:40-05:00 dave@thedillows.org 
#   Collect some information about the Typhoon's offload capabilities,
#   and store it for future use.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# drivers/net/typhoon.h
#   2004/12/30 00:56:22-05:00 dave@thedillows.org +14 -0
#   Add the reply message format for the crypto capability query command.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# drivers/net/typhoon.c
#   2004/12/30 00:56:22-05:00 dave@thedillows.org +56 -0
#   Collect some information about the Typhoon's offload capabilities,
#   and store it for future use.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	2004-12-30 01:08:58 -05:00
+++ b/drivers/net/typhoon.c	2004-12-30 01:08:58 -05:00
@@ -305,6 +305,12 @@
 	u16			wol_events;
 	u32			offload;
 
+	u16			tx_sa_max;
+	u16			rx_sa_max;
+	u16			tx_sa_avail;
+	u16			rx_sa_avail;
+	int			sa_count;
+
 	/* unused stuff (future use) */
 	int			capabilities;
 	struct transmit_ring 	txHiRing;
@@ -2105,6 +2111,53 @@
 	return 0;
 }
 
+static inline int
+typhoon_ipsec_init(struct typhoon *tp)
+{
+	struct cmd_desc xp_cmd;
+	struct resp_desc xp_resp;
+	struct ipsec_info_desc *info = (struct ipsec_info_desc *) &xp_resp;
+	u16 last_tx, last_rx, last_cap;
+	int err;
+
+	last_tx = tp->tx_sa_max;
+	last_rx = tp->rx_sa_max;
+	last_cap = tp->capabilities;
+
+	INIT_COMMAND_WITH_RESPONSE(&xp_cmd, TYPHOON_CMD_READ_IPSEC_INFO);
+	err = typhoon_issue_command(tp, 1, &xp_cmd, 1, &xp_resp);
+	if(err < 0)
+		goto out;
+
+	/* We're not up yet, so no need to lock this -- we cannot modify
+	 * these fields yet.
+	 */
+	tp->tx_sa_avail = tp->tx_sa_max = le16_to_cpu(info->tx_sa_max);
+	tp->rx_sa_avail = tp->rx_sa_max = le16_to_cpu(info->rx_sa_max);
+	tp->sa_count = 0;
+
+	/* Typhoon2 was originally going to have variable crypto capabilities,
+	 * subject to registration with 3Com. It appears they have decided
+	 * to just enable 3DES as well.
+	 */
+	if(tp->capabilities & TYPHOON_CRYPTO_VARIABLE) {
+		tp->capabilities &= ~TYPHOON_CRYPTO_VARIABLE;
+		tp->capabilities |= TYPHOON_CRYPTO_DES | TYPHOON_CRYPTO_3DES;
+	}
+
+	if(last_tx != tp->tx_sa_max || last_rx != tp->rx_sa_max ||
+					last_cap != tp->capabilities) {
+		printk(KERN_INFO "%s: IPSEC offload %s%s %d Tx %d Rx\n",
+			tp->name,
+			tp->capabilities & TYPHOON_CRYPTO_DES ? "DES " : "",
+			tp->capabilities & TYPHOON_CRYPTO_3DES ? "3DES" : "",
+			tp->tx_sa_max, tp->rx_sa_max);
+	}
+
+out:
+	return err;
+}
+
 static int
 typhoon_start_runtime(struct typhoon *tp)
 {
@@ -2127,6 +2180,9 @@
 		err = -EIO;
 		goto error_out;
 	}
+
+	if(typhoon_ipsec_init(tp))
+		goto error_out;
 
 	INIT_COMMAND_NO_RESPONSE(&xp_cmd, TYPHOON_CMD_SET_MAX_PKT_SIZE);
 	xp_cmd.parm1 = cpu_to_le16(PKT_BUF_SZ);
diff -Nru a/drivers/net/typhoon.h b/drivers/net/typhoon.h
--- a/drivers/net/typhoon.h	2004-12-30 01:08:58 -05:00
+++ b/drivers/net/typhoon.h	2004-12-30 01:08:58 -05:00
@@ -487,6 +487,20 @@
 	u32 unused2;
 } __attribute__ ((packed));
 
+/* TYPHOON_CMD_READ_IPSEC_INFO response descriptor
+ */
+struct ipsec_info_desc {
+	u8  flags;
+	u8  numDesc;
+	u16 cmd;
+	u16 seqNo;
+	u16 des_enabled;
+	u16 tx_sa_max;
+	u16 rx_sa_max;
+	u16 tx_sa_count;
+	u16 rx_sa_count;
+} __attribute__ ((packed));
+
 /* TYPHOON_CMD_SET_OFFLOAD_TASKS bits (cmd.parm2 (Tx) & cmd.parm3 (Rx))
  * This is all for IPv4.
  */
