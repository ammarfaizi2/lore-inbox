Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbUL3JEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbUL3JEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 04:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUL3JD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 04:03:57 -0500
Received: from smtp.knology.net ([24.214.63.101]:61151 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261591AbUL3Isi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:38 -0500
Date: Thu, 30 Dec 2004 03:48:37 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 19/22] typhoon: add loading of xfrm_states to hardware
Message-Id: <20041230035000.28@ori.thedillows.org>
References: <20041230035000.27@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 01:02:32-05:00 dave@thedillows.org 
#   Teach the Typhoon driver how to add and remove xfrm_states to
#   the 3XP for later packet processing.
#   
#   When the first xfrm_state is added, we turn on IPSEC offloads
#   for the 3XP, and we turn it off when the last one is removed.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# drivers/net/typhoon.c
#   2004/12/30 01:02:14-05:00 dave@thedillows.org +167 -0
#   Teach the Typhoon driver how to add and remove xfrm_states to
#   the 3XP for later packet processing.
#   
#   When the first xfrm_state is added, we turn on IPSEC offloads
#   for the 3XP, and we turn it off when the last one is removed.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	2004-12-30 01:08:19 -05:00
+++ b/drivers/net/typhoon.c	2004-12-30 01:08:19 -05:00
@@ -2420,6 +2420,173 @@
 #undef REQUIRED
 #undef UNSUPPORTED
 
+static struct xfrm_offload *
+typhoon_offload_ipsec(struct typhoon *tp, struct xfrm_state *x)
+{
+	struct cmd_desc xp_cmd[5];
+	struct resp_desc xp_resp;
+	struct sa_descriptor *sa = (struct sa_descriptor *)xp_cmd;
+	struct xfrm_offload *xol;
+	struct typhoon_xfrm_offload *txo;
+	u16 *dir_sa_avail = &tp->rx_sa_avail;
+	u16 cookie;
+	int keylen, err;
+
+	if(!typhoon_validate_xfrm(tp, x))
+		goto error;
+
+	memset(xp_cmd, 0, 5 * sizeof(xp_cmd[0]));
+	INIT_COMMAND_WITH_RESPONSE(xp_cmd, TYPHOON_CMD_CREATE_SA);
+	sa->numDesc = 4;
+
+	sa->mode = TYPHOON_SA_MODE_AH;
+	if(x->type->proto == IPPROTO_ESP)
+		sa->mode = TYPHOON_SA_MODE_ESP;
+
+	if(x->dir == XFRM_STATE_DIR_OUT) {
+		sa->direction = TYPHOON_SA_DIR_TX;
+		dir_sa_avail = &tp->tx_sa_avail;
+	}
+
+	spin_lock_bh(&tp->offload_lock);
+	if(!*dir_sa_avail) {
+		spin_unlock_bh(&tp->offload_lock);
+		goto error;
+	}
+	*dir_sa_avail--;
+	if(!tp->sa_count++) {
+		tp->offload |= TYPHOON_OFFLOAD_IPSEC;
+		err = typhoon_set_offload(tp);
+		if(err < 0) {
+			spin_unlock_bh(&tp->offload_lock);
+			printk(KERN_ERR "%s: unable to enable IPSEC "
+					"offload (%d)\n", tp->name, -err);
+			goto error_counted;
+		}
+	}
+	spin_unlock_bh(&tp->offload_lock);
+
+	if(x->props.aalgo != SADB_X_AALG_NULL && x->aalg) {
+		keylen = (x->aalg->alg_key_len + 7) / 8;
+
+		sa->hashFlags = TYPHOON_SA_HASH_SHA1;
+		if(x->props.aalgo == SADB_AALG_MD5HMAC)
+			sa->hashFlags = TYPHOON_SA_HASH_MD5;
+		sa->hashFlags |= TYPHOON_SA_HASH_ENABLE;
+
+		memcpy(sa->integKey, x->aalg->alg_key, keylen);
+	}
+
+	if(x->props.ealgo != SADB_EALG_NULL && x->ealg) {
+		keylen = (x->ealg->alg_key_len + 7) / 8;
+
+		sa->encryptionFlags = TYPHOON_SA_ENCRYPT_ENABLE |
+						TYPHOON_SA_ENCRYPT_CBC;
+		if(x->props.ealgo == SADB_EALG_DESCBC)
+			sa->encryptionFlags |= TYPHOON_SA_ENCRYPT_DES;
+		else if(x->ealg->alg_key_len == 192)
+			sa->encryptionFlags |= TYPHOON_SA_ENCRYPT_3DES_3KEY;
+		else {
+			sa->encryptionFlags |= TYPHOON_SA_ENCRYPT_3DES_2KEY;
+			memcpy(&sa->confKey[16], x->ealg->alg_key, 8);
+		}
+
+		memcpy(sa->confKey, x->ealg->alg_key, keylen);
+	}
+
+	/* The 3XP expects the SPI to be in host order, litte endian.
+	 * It expects the address to be in network order.
+	 */
+	sa->SPI = cpu_to_le32(ntohl(x->id.spi));
+	sa->destAddr = x->id.daddr.a4;
+	sa->destMask = (u32) ~0UL;
+
+	err = typhoon_issue_command(tp, 5, xp_cmd, 1, &xp_resp);
+	cookie = le16_to_cpu(xp_resp.parm1);
+	if(err < 0 || !cookie || cookie == 0xffff)
+		goto error_counted;
+
+	xol = xfrm_offload_alloc(sizeof(*txo), tp->dev);
+	if(!xol)
+		goto error_cookie;
+
+	txo = xfrm_offload_priv(xol);
+	txo->sa_cookie = cookie;
+	txo->tunnel = !!x->props.mode;
+	txo->ah = (x->id.proto == IPPROTO_AH);
+	txo->inbound = (x->dir == XFRM_STATE_DIR_IN);
+
+	xfrm_state_offload_add(x, xol);
+
+	return xol;
+
+error_cookie:
+	INIT_COMMAND_NO_RESPONSE(xp_cmd, TYPHOON_CMD_DELETE_SA);
+	xp_cmd[0].parm1 = xp_resp.parm1;
+	typhoon_issue_command(tp, 1, xp_cmd, 0, NULL);
+
+error_counted:
+	spin_lock_bh(&tp->offload_lock);
+	*dir_sa_avail++;
+	tp->sa_count--;
+	if(!tp->sa_count) {
+		tp->offload &= ~TYPHOON_OFFLOAD_IPSEC;
+		err = typhoon_set_offload(tp);
+		if(err < 0)
+			printk(KERN_ERR "%s: unable to disable IPSEC "
+					"offload (%d)\n", tp->name, -err);
+	}
+	spin_unlock_bh(&tp->offload_lock);
+
+error:
+	return NULL;
+}
+
+static void
+typhoon_xfrm_state_add(struct net_device *dev, struct xfrm_state *x)
+{
+	struct typhoon *tp = netdev_priv(dev);
+
+	smp_rmb();
+	if(tp->card_state == Running)
+		typhoon_offload_ipsec(tp, x);
+}
+
+static void
+typhoon_xfrm_state_del(struct net_device *dev, struct xfrm_offload *xol)
+{
+	struct typhoon *tp = netdev_priv(dev);
+	struct typhoon_xfrm_offload *txo = xfrm_offload_priv(xol);
+	struct cmd_desc xp_cmd;
+	int err;
+
+	smp_rmb();
+	if(tp->card_state != Running)
+		return;
+
+	INIT_COMMAND_NO_RESPONSE(&xp_cmd, TYPHOON_CMD_DELETE_SA);
+	xp_cmd.parm1 = cpu_to_le16(txo->sa_cookie);
+	if(typhoon_issue_command(tp, 1, &xp_cmd, 0, NULL) < 0) {
+		printk(KERN_ERR "%s: unable to remove offloaded SA 0x%04x\n",
+				tp->name,  txo->sa_cookie);
+	}
+
+	spin_lock_bh(&tp->offload_lock);
+	if(txo->inbound)
+		tp->rx_sa_avail++;
+	else
+		tp->tx_sa_avail++;
+	tp->sa_count--;
+	if(!tp->sa_count) {
+		tp->offload &= ~TYPHOON_OFFLOAD_IPSEC;
+		err = typhoon_set_offload(tp);
+		if(err < 0)
+			printk(KERN_ERR "%s: unable to disable IPSEC "
+					"offload (%d)\n", tp->name, -err);
+	}
+	spin_unlock_bh(&tp->offload_lock);
+}
+
 static void
 typhoon_tx_timeout(struct net_device *dev)
 {
