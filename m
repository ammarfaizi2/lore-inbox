Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422635AbWG2Flh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbWG2Flh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 01:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161471AbWG2Flh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 01:41:37 -0400
Received: from havoc.gtf.org ([69.61.125.42]:20135 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161379AbWG2Flg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 01:41:36 -0400
Date: Sat, 29 Jul 2006 01:36:42 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] net driver fixes
Message-ID: <20060729053642.GA32299@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git upstream-linus

to receive the following updates:

 drivers/net/myri10ge/myri10ge.c               |    2 -
 drivers/net/skge.c                            |    5 ----
 drivers/net/via-velocity.c                    |   17 ++++++++++++---
 drivers/net/wireless/Kconfig                  |    1 
 drivers/net/wireless/bcm43xx/bcm43xx_main.c   |    2 -
 drivers/net/wireless/orinoco.c                |    4 +--
 drivers/net/wireless/zd1201.c                 |    2 +
 net/ieee80211/Kconfig                         |    1 
 net/ieee80211/softmac/ieee80211softmac_auth.c |   28 ++++++++++++++++++++------
 9 files changed, 44 insertions(+), 18 deletions(-)

Brice Goglin:
      myri10ge - Always do a dummy RDMA after loading the firmware

Chuck Ebbert:
      ieee80211: TKIP requires CRC32

Dan Williams:
      orinoco: fix setting transmit key only

Daniel Drake:
      softmac: do shared key auth in workqueue

Jay Cliburn:
      via-velocity: fix speed and link status reported by ethtool

Pavel Machek:
      zd1201: workaround interference problem

Robert Schulze:
      airo: should select crypto_aes

Stephen Hemminger:
      skge: chip clock rate typo

diff --git a/drivers/net/myri10ge/myri10ge.c b/drivers/net/myri10ge/myri10ge.c
index 07ca948..c3e52c8 100644
--- a/drivers/net/myri10ge/myri10ge.c
+++ b/drivers/net/myri10ge/myri10ge.c
@@ -620,7 +620,7 @@ static int myri10ge_load_firmware(struct
 		return -ENXIO;
 	}
 	dev_info(&mgp->pdev->dev, "handoff confirmed\n");
-	myri10ge_dummy_rdma(mgp, mgp->tx.boundary != 4096);
+	myri10ge_dummy_rdma(mgp, 1);
 
 	return 0;
 }
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index 82200bf..7de9a07 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -516,10 +516,7 @@ static int skge_set_pauseparam(struct ne
 /* Chip internal frequency for clock calculations */
 static inline u32 hwkhz(const struct skge_hw *hw)
 {
-	if (hw->chip_id == CHIP_ID_GENESIS)
-		return 53215; /* or:  53.125 MHz */
-	else
-		return 78215; /* or:  78.125 MHz */
+	return (hw->chip_id == CHIP_ID_GENESIS) ? 53125 : 78125;
 }
 
 /* Chip HZ to microseconds */
diff --git a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
index f5b0078..aa9cd92 100644
--- a/drivers/net/via-velocity.c
+++ b/drivers/net/via-velocity.c
@@ -2742,7 +2742,7 @@ static u32 check_connection_type(struct 
 
 	if (PHYSR0 & PHYSR0_SPDG)
 		status |= VELOCITY_SPEED_1000;
-	if (PHYSR0 & PHYSR0_SPD10)
+	else if (PHYSR0 & PHYSR0_SPD10)
 		status |= VELOCITY_SPEED_10;
 	else
 		status |= VELOCITY_SPEED_100;
@@ -2851,8 +2851,17 @@ static int velocity_get_settings(struct 
 	u32 status;
 	status = check_connection_type(vptr->mac_regs);
 
-	cmd->supported = SUPPORTED_TP | SUPPORTED_Autoneg | SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full | SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full | SUPPORTED_1000baseT_Half | SUPPORTED_1000baseT_Full;
-	if (status & VELOCITY_SPEED_100)
+	cmd->supported = SUPPORTED_TP |
+			SUPPORTED_Autoneg |
+			SUPPORTED_10baseT_Half |
+			SUPPORTED_10baseT_Full |
+			SUPPORTED_100baseT_Half |
+			SUPPORTED_100baseT_Full |
+			SUPPORTED_1000baseT_Half |
+			SUPPORTED_1000baseT_Full;
+	if (status & VELOCITY_SPEED_1000)
+		cmd->speed = SPEED_1000;
+	else if (status & VELOCITY_SPEED_100)
 		cmd->speed = SPEED_100;
 	else
 		cmd->speed = SPEED_10;
@@ -2896,7 +2905,7 @@ static u32 velocity_get_link(struct net_
 {
 	struct velocity_info *vptr = netdev_priv(dev);
 	struct mac_regs __iomem * regs = vptr->mac_regs;
-	return BYTE_REG_BITS_IS_ON(PHYSR0_LINKGD, &regs->PHYSR0)  ? 0 : 1;
+	return BYTE_REG_BITS_IS_ON(PHYSR0_LINKGD, &regs->PHYSR0) ? 1 : 0;
 }
 
 static void velocity_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index fa9d2c4..2e8ac99 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -447,6 +447,7 @@ config AIRO_CS
 	tristate "Cisco/Aironet 34X/35X/4500/4800 PCMCIA cards"
 	depends on NET_RADIO && PCMCIA && (BROKEN || !M32R)
 	select CRYPTO
+	select CRYPTO_AES
 	---help---
 	  This is the standard Linux driver to support Cisco/Aironet PCMCIA
 	  802.11 wireless cards.  This driver is the same as the Aironet
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
index 3889f79..df317c1 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -3701,7 +3701,7 @@ static void bcm43xx_ieee80211_set_securi
 	}
 	if (sec->flags & SEC_AUTH_MODE) {
 		secinfo->auth_mode = sec->auth_mode;
-		dprintk(", .auth_mode = %d\n", sec->auth_mode);
+		dprintk(", .auth_mode = %d", sec->auth_mode);
 	}
 	dprintk("\n");
 	if (bcm43xx_status(bcm) == BCM43xx_STAT_INITIALIZED &&
diff --git a/drivers/net/wireless/orinoco.c b/drivers/net/wireless/orinoco.c
index d6ed578..317ace7 100644
--- a/drivers/net/wireless/orinoco.c
+++ b/drivers/net/wireless/orinoco.c
@@ -2875,7 +2875,7 @@ static int orinoco_ioctl_setiwencode(str
 	if (orinoco_lock(priv, &flags) != 0)
 		return -EBUSY;
 
-	if (erq->pointer) {
+	if (erq->length > 0) {
 		if ((index < 0) || (index >= ORINOCO_MAX_KEYS))
 			index = priv->tx_key;
 
@@ -2918,7 +2918,7 @@ static int orinoco_ioctl_setiwencode(str
 	if (erq->flags & IW_ENCODE_RESTRICTED)
 		restricted = 1;
 
-	if (erq->pointer) {
+	if (erq->pointer && erq->length > 0) {
 		priv->keys[index].len = cpu_to_le16(xlen);
 		memset(priv->keys[index].data, 0,
 		       sizeof(priv->keys[index].data));
diff --git a/drivers/net/wireless/zd1201.c b/drivers/net/wireless/zd1201.c
index 662ecc8..c52e9bc 100644
--- a/drivers/net/wireless/zd1201.c
+++ b/drivers/net/wireless/zd1201.c
@@ -1820,6 +1820,8 @@ static int zd1201_probe(struct usb_inter
 	    zd->dev->name);
 
 	usb_set_intfdata(interface, zd);
+	zd1201_enable(zd);	/* zd1201 likes to startup enabled, */
+	zd1201_disable(zd);	/* interfering with all the wifis in range */
 	return 0;
 
 err_net:
diff --git a/net/ieee80211/Kconfig b/net/ieee80211/Kconfig
index dbb0852..f7e84e9 100644
--- a/net/ieee80211/Kconfig
+++ b/net/ieee80211/Kconfig
@@ -58,6 +58,7 @@ config IEEE80211_CRYPT_TKIP
 	depends on IEEE80211 && NET_RADIO
 	select CRYPTO
 	select CRYPTO_MICHAEL_MIC
+	select CRC32
 	---help---
 	Include software based cipher suites in support of IEEE 802.11i
 	(aka TGi, WPA, WPA2, WPA-PSK, etc.) for use with TKIP enabled
diff --git a/net/ieee80211/softmac/ieee80211softmac_auth.c b/net/ieee80211/softmac/ieee80211softmac_auth.c
index ebc33ca..4cef39e 100644
--- a/net/ieee80211/softmac/ieee80211softmac_auth.c
+++ b/net/ieee80211/softmac/ieee80211softmac_auth.c
@@ -116,6 +116,16 @@ ieee80211softmac_auth_queue(void *data)
 	kfree(auth);
 }
 
+/* Sends a response to an auth challenge (for shared key auth). */
+static void
+ieee80211softmac_auth_challenge_response(void *_aq)
+{
+	struct ieee80211softmac_auth_queue_item *aq = _aq;
+
+	/* Send our response */
+	ieee80211softmac_send_mgt_frame(aq->mac, aq->net, IEEE80211_STYPE_AUTH, aq->state);
+}
+
 /* Handle the auth response from the AP
  * This should be registered with ieee80211 as handle_auth 
  */
@@ -197,24 +207,30 @@ ieee80211softmac_auth_resp(struct net_de
 		case IEEE80211SOFTMAC_AUTH_SHARED_CHALLENGE:
 			/* Check to make sure we have a challenge IE */
 			data = (u8 *)auth->info_element;
-			if(*data++ != MFIE_TYPE_CHALLENGE){
+			if (*data++ != MFIE_TYPE_CHALLENGE) {
 				printkl(KERN_NOTICE PFX "Shared Key Authentication failed due to a missing challenge.\n");
 				break;	
 			}
 			/* Save the challenge */
 			spin_lock_irqsave(&mac->lock, flags);
 			net->challenge_len = *data++; 	
-			if(net->challenge_len > WLAN_AUTH_CHALLENGE_LEN)
+			if (net->challenge_len > WLAN_AUTH_CHALLENGE_LEN)
 				net->challenge_len = WLAN_AUTH_CHALLENGE_LEN;
-			if(net->challenge != NULL)
+			if (net->challenge != NULL)
 				kfree(net->challenge);
 			net->challenge = kmalloc(net->challenge_len, GFP_ATOMIC);
 			memcpy(net->challenge, data, net->challenge_len);
 			aq->state = IEEE80211SOFTMAC_AUTH_SHARED_RESPONSE; 
-			spin_unlock_irqrestore(&mac->lock, flags);
 
-			/* Send our response */
-			ieee80211softmac_send_mgt_frame(mac, aq->net, IEEE80211_STYPE_AUTH, aq->state);
+			/* We reuse the work struct from the auth request here.
+			 * It is safe to do so as each one is per-request, and
+			 * at this point (dealing with authentication response)
+			 * we have obviously already sent the initial auth
+			 * request. */
+			cancel_delayed_work(&aq->work);
+			INIT_WORK(&aq->work, &ieee80211softmac_auth_challenge_response, (void *)aq);
+			schedule_work(&aq->work);
+			spin_unlock_irqrestore(&mac->lock, flags);
 			return 0;
 		case IEEE80211SOFTMAC_AUTH_SHARED_PASS:
 			kfree(net->challenge);
