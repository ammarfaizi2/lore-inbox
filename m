Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264057AbRFERoI>; Tue, 5 Jun 2001 13:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264059AbRFERn7>; Tue, 5 Jun 2001 13:43:59 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:60124 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S264057AbRFERnv>;
	Tue, 5 Jun 2001 13:43:51 -0400
Date: Tue, 5 Jun 2001 10:43:47 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Gibson <hermes@gibson.dropbear.id.au>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Patch : Orinoco v6
Message-ID: <20010605104347.A29825@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	This is my latest patch for the Orinoco driver. I would be
grateful if it would be applied to the latest kernel.

	This time, the changes are quite minor. It only fixes the
support for Symbol/Intel/3Com cards, most of it contributed by
Red-Hat, and doesn't impact Orinoco cards. Patch has been on my web
pages for a few weeks and tested on all my cards. It applies to kernel
2.4.5.

	Important : I'm transitioning the maintainance of the Orinoco
driver back to David Gibson, the original author of the driver. So,
don't be surprised if the next patch for the driver comes from him.

	For David : Next week I'm in Helsinki (conference), but should
be back after.

	For Alan : this version has a fex bug fixes that *may* help
with your cards (no promises).
	I would recommend :
		priv->has_ibss = 0;
		priv->has_wep = 0;
		priv->has_pm = 0;
	Then, you may try "iwpriv ethX card_reset", that may help the
card to get in a better mood.

	That's it...

	Jean

--------------------------------------------------------------
diff -u -p -r linux/drivers/net/wireless-airo/hermes.c linux/drivers/net/wireless/hermes.c
--- linux/drivers/net/wireless-airo/hermes.c	Tue May 29 14:39:48 2001
+++ linux/drivers/net/wireless/hermes.c	Tue May 29 15:01:03 2001
@@ -32,9 +32,10 @@ static const char *version = "hermes.c: 
 
 #include "hermes.h"
 
+/* These are maximum timeouts. Most often, card wil react much faster */
 #define CMD_BUSY_TIMEOUT (100) /* In iterations of ~1us */
 #define CMD_INIT_TIMEOUT (50000) /* in iterations of ~10us */
-#define CMD_COMPL_TIMEOUT (10000) /* in iterations of ~10us */
+#define CMD_COMPL_TIMEOUT (20000) /* in iterations of ~10us */
 #define ALLOC_COMPL_TIMEOUT (1000) /* in iterations of ~10us */
 #define BAP_BUSY_TIMEOUT (500) /* In iterations of ~1us */
 #define BAP_ERROR_RETRY (10) /* How many times to retry a BAP seek when there is an error */
@@ -141,6 +142,12 @@ int hermes_reset(hermes_t *hw)
 	/* No need to explicitly handle the timeout - hermes_issue_cmd() will
 	   probably return -EBUSY */
 
+	/* According to the documentation, EVSTAT may contain
+	   obsolete event occurrence information.  We have to acknowledge
+	   it by writing EVACK. */
+	reg = hermes_read_regn(hw, EVSTAT);
+	hermes_write_regn(hw, EVACK, reg);
+
 	/* We don't use hermes_docmd_wait here, because the reset wipes
 	   the magic constant in SWSUPPORT0 away, and it gets confused */
 	err = hermes_issue_cmd(hw, HERMES_CMD_INIT, 0);
@@ -323,8 +330,10 @@ static int hermes_bap_seek(hermes_t *hw,
 		reg = hermes_read_reg(hw, oreg);
 	}
 
-	if (reg & HERMES_OFFSET_BUSY)
+	if (reg & HERMES_OFFSET_BUSY) {
+		DEBUG(0,"hermes_bap_seek: returning ETIMEDOUT...\n");
 		return -ETIMEDOUT;
+	}
 
 	/* For some reason, seeking the BAP seems to randomly fail somewhere
 	   (firmware bug?). We retry a few times before giving up. */
diff -u -p -r linux/drivers/net/wireless-airo/hermes.h linux/drivers/net/wireless/hermes.h
--- linux/drivers/net/wireless-airo/hermes.h	Tue May 29 14:39:48 2001
+++ linux/drivers/net/wireless/hermes.h	Tue May 29 16:05:23 2001
@@ -166,7 +166,6 @@
 #define		HERMES_RID_CNF_NICKNAME		(0xfc0e)
 #define		HERMES_RID_CNF_WEP_ON		(0xfc20)
 #define		HERMES_RID_CNF_MWO_ROBUST	(0xfc25)
-#define		HERMES_RID_CNF_PRISM2_WEP_ON	(0xfc28)
 #define		HERMES_RID_CNF_MULTICAST_LIST	(0xfc80)
 #define		HERMES_RID_CNF_CREATEIBSS	(0xfc81)
 #define		HERMES_RID_CNF_FRAG_THRESH	(0xfc82)
@@ -177,6 +176,7 @@
 #define		HERMES_RID_CNF_TX_KEY		(0xfcb1)
 #define		HERMES_RID_CNF_TICKTIME		(0xfce0)
 
+#define		HERMES_RID_CNF_PRISM2_WEP_ON	(0xfc28)
 #define		HERMES_RID_CNF_PRISM2_TX_KEY	(0xfc23)
 #define		HERMES_RID_CNF_PRISM2_KEY0	(0xfc24)
 #define		HERMES_RID_CNF_PRISM2_KEY1	(0xfc25)
diff -u -p -r linux/drivers/net/wireless-airo/orinoco.c linux/drivers/net/wireless/orinoco.c
--- linux/drivers/net/wireless-airo/orinoco.c	Tue May 29 14:39:48 2001
+++ linux/drivers/net/wireless/orinoco.c	Mon Jun  4 19:24:42 2001
@@ -1,4 +1,4 @@
-/* orinoco.c 0.05	- (formerly known as dldwd_cs.c and orinoco_cs.c)
+/* orinoco.c 0.06	- (formerly known as dldwd_cs.c and orinoco_cs.c)
  *
  * A driver for "Hermes" chipset based PCMCIA wireless adaptors, such
  * as the Lucent WavelanIEEE/Orinoco cards and their OEM (Cabletron/
@@ -144,10 +144,32 @@
  *	  (note : the memcmp bug was mine - fixed)
  *	o Remove set_retry stuff, no firmware support it (bloat--).
  *
+ * v0.05d -> v0.06 - 25/5/2001 - Jean II
+ *		Original patch from "Hong Lin" <alin@redhat.com>,
+ *		"Ian Kinner" <ikinner@redhat.com>
+ *		and "David Smith" <dsmith@redhat.com>
+ *	o Init of priv->tx_rate_ctrl in firmware specific section.
+ *	o Prism2/Symbol rate, upto should be 0xF and not 0x15. Doh !
+ *	o Spectrum card always need cor_reset (for every reset)
+ *	o Fix cor_reset to not loose bit 7 in the register
+ *	o flush_stale_links to remove zombie Pcmcia instances
+ *	o Ack previous hermes event before reset
+ *		Me (with my little hands)
+ *	o Allow orinoco.c to call cor_reset via priv->card_reset_handler
+ *	o Add priv->need_card_reset to toggle this feature
+ *	o Fix various buglets when setting WEP in Symbol firmware
+ *	  Now, encryption is fully functional on Symbol cards. Youpi !
+ *
+ * v0.06 -> v0.06b - 25/5/2001 - Jean II
+ *	o IBSS on Symbol use port_mode = 4. Please don't ask...
+ *
+ * v0.06b -> v0.06c - 29/5/2001 - Jean II
+ *	o Show first spy address in /proc/net/wireless for IBSS mode as well
+ *
  * TODO - Jean II
  *	o inline functions (lot's of candidate, need to reorder code)
  *	o Test PrismII/Symbol cards & firmware versions
- *	o Mini-PCI support
+ *	o Mini-PCI support (some people have reported success - JII)
  */
 
 #include <linux/module.h>
@@ -180,7 +202,7 @@
 #include "hermes.h"
 #include "orinoco.h"
 
-static char *version = "orinoco.c 0.05d (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char *version = "orinoco.c 0.06c (David Gibson <hermes@gibson.dropbear.id.au> and others)";
 
 /* Level of debugging. Used in the macros in orinoco.h */
 #ifdef ORINOCO_DEBUG
@@ -369,7 +391,11 @@ set_port_type(dldwd_priv_t *priv)
 			priv->port_type = 3;
 			priv->allow_ibss = 0;
 		} else {
-			priv->port_type = 1;
+			/* Symbol is different here */
+			if (priv->firmware_type == FIRMWARE_TYPE_SYMBOL)
+				priv->port_type = 4;
+			else
+				priv->port_type = 1;
 			priv->allow_ibss = 1;
 		}
 		break;
@@ -441,10 +467,15 @@ dldwd_reset(dldwd_priv_t *priv)
 
 	TRACE_ENTER(priv->ndev.name);
 
+	/* Stop other people bothering us */
 	dldwd_lock(priv);
-
 	__dldwd_stop_irqs(priv);
 
+	/* Check if we need a card reset */
+	if((priv->need_card_reset) && (priv->card_reset_handler != NULL))
+		priv->card_reset_handler(priv);
+
+	/* Do standard firmware reset if we can */
 	err = __dldwd_hw_reset(priv);
 	if (err)
 		goto out;
@@ -594,7 +625,8 @@ static int __dldwd_hw_setup_wep(dldwd_pr
 {
 	hermes_t *hw = &priv->hw;
 	int err = 0;
-	int	extra_wep_flag = 0;
+	int	master_wep_flag;
+	int	auth_flag;
 
 	switch (priv->firmware_type) {
 	case FIRMWARE_TYPE_LUCENT: /* Lucent style WEP */
@@ -614,24 +646,29 @@ static int __dldwd_hw_setup_wep(dldwd_pr
 
 	case FIRMWARE_TYPE_PRISM2: /* Prism II style WEP */
 	case FIRMWARE_TYPE_SYMBOL: /* Symbol style WEP */
+		master_wep_flag = 0;		/* Off */
 		if (priv->wep_on) {
 			char keybuf[LARGE_KEY_SIZE+1];
 			int keylen;
 			int i;
-			
+
+			/* Fudge around firmware weirdness */
+			keylen = priv->keys[priv->tx_key].len;
+
 			/* Write all 4 keys */
 			for(i = 0; i < MAX_KEYS; i++) {
-				keylen = priv->keys[i].len;
-				keybuf[keylen] = '\0';
-				memcpy(keybuf, priv->keys[i].data, keylen);
+				memset(keybuf, 0, sizeof(keybuf));
+				memcpy(keybuf, priv->keys[i].data,
+				       priv->keys[i].len);
 				err = hermes_write_ltv(hw, USER_BAP,
 						       HERMES_RID_CNF_PRISM2_KEY0 + i,
-						       HERMES_BYTES_TO_RECLEN(keylen + 1),
-						       &keybuf);
+						       HERMES_BYTES_TO_RECLEN(keylen),
+						       keybuf);
 				if (err)
 					return err;
 			}
 
+			/* Write the index of the key used in transmission */
 			err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_PRISM2_TX_KEY,
 						   priv->tx_key);
 			if (err)
@@ -642,30 +679,29 @@ static int __dldwd_hw_setup_wep(dldwd_pr
 			if (priv->firmware_type == FIRMWARE_TYPE_SYMBOL) {
 				/* Symbol cards : set the authentication :
 				 * 0 -> no encryption, 1 -> open,
-				 * 2 -> shared key, 3 -> shared key 128bit */
-				if(priv->wep_restrict) {
-					if(priv->keys[priv->tx_key].len >
-					   SMALL_KEY_SIZE)
-						extra_wep_flag = 3;
-					else
-						extra_wep_flag = 2;
-				} else
-					extra_wep_flag = 1;
-				err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_SYMBOL_AUTH_TYPE, priv->wep_restrict);
+				 * 2 -> shared key
+				 * 3 -> shared key 128 -> AP only */
+				if(priv->wep_restrict)
+					auth_flag = 2;
+				else
+					auth_flag = 1;
+				err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_SYMBOL_AUTH_TYPE, auth_flag);
 				if (err)
 					return err;
+				/* Master WEP setting is always 3 */
+				master_wep_flag = 3;
 			} else {
 				/* Prism2 card : we need to modify master
 				 * WEP setting */
 				if(priv->wep_restrict)
-					extra_wep_flag = 2;
+					master_wep_flag = 3;
 				else
-					extra_wep_flag = 0;
+					master_wep_flag = 1;
 			}
 		}
 		
 		/* Master WEP setting : on/off */
-		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_PRISM2_WEP_ON, (priv->wep_on | extra_wep_flag));
+		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_PRISM2_WEP_ON, master_wep_flag);
 		if (err)
 			return err;	
 		break;
@@ -1182,9 +1218,11 @@ dldwd_init(struct net_device *dev)
 	
 	dldwd_lock(priv);
 
+	/* Do standard firmware reset */
 	err = hermes_reset(hw);
 	if (err != 0) {
-		printk(KERN_ERR "%s: failed to reset hardware\n", dev->name);
+		printk(KERN_ERR "%s: failed to reset hardware (err = %d)\n",
+		       dev->name, err);
 		goto out;
 	}
 	
@@ -1209,6 +1247,8 @@ dldwd_init(struct net_device *dev)
 		/* Lucent MAC : 00:60:1D:* & 00:02:2D:* */
 
 		priv->firmware_type = FIRMWARE_TYPE_LUCENT;
+		priv->tx_rate_ctrl = 0x3;	/* 11 Mb/s auto */
+		priv->need_card_reset = 0;
 		priv->broken_reset = 0;
 		priv->broken_allocate = 0;
 		priv->has_port3 = 1;		/* Still works in 7.28 */
@@ -1229,6 +1269,8 @@ dldwd_init(struct net_device *dev)
 		/* Some D-Link cards report vendor 0x02... */
 
 		priv->firmware_type = FIRMWARE_TYPE_PRISM2;
+		priv->tx_rate_ctrl = 0xF;	/* 11 Mb/s auto */
+		priv->need_card_reset = 0;
 		priv->broken_reset = 0;
 		priv->broken_allocate = 0;
 		priv->has_port3 = 1;
@@ -1248,9 +1290,12 @@ dldwd_init(struct net_device *dev)
 			/* Intel MAC : 00:02:B3:* */
 			/* 3Com MAC : 00:50:DA:* */
 
-			/* FIXME : probably need to use SYMBOL_***ARY_VER
-			 * to get proper firmware version */
+			/* FIXME : we need to get Symbol firmware revision.
+			 * I tried to use SYMBOL_***ARY_VER, but it didn't
+			 * returned anything proper... */
 			priv->firmware_type = FIRMWARE_TYPE_SYMBOL;
+			priv->tx_rate_ctrl = 0xF;	/* 11 Mb/s auto */
+			priv->need_card_reset = 1;
 			priv->broken_reset = 0;
 			priv->broken_allocate = 1;
 			priv->has_port3 = 1;
@@ -1268,6 +1313,8 @@ dldwd_init(struct net_device *dev)
 		/* To check - Should cover Samsung & Compaq */
 
 		priv->firmware_type = FIRMWARE_TYPE_PRISM2;
+		priv->tx_rate_ctrl = 0xF;	/* 11 Mb/s auto */
+		priv->need_card_reset = 0;
 		priv->broken_reset = 0;
 		priv->broken_allocate = 0;
 		priv->has_port3 = 1;
@@ -1284,6 +1331,8 @@ dldwd_init(struct net_device *dev)
 		/* D-Link MAC : 00:40:05:* */
 
 		priv->firmware_type = FIRMWARE_TYPE_PRISM2;
+		priv->tx_rate_ctrl = 0xF;	/* 11 Mb/s auto */
+		priv->need_card_reset = 0;
 		priv->broken_reset = 0;
 		priv->broken_allocate = 0;
 		priv->has_port3 = 1;
@@ -1300,6 +1349,8 @@ dldwd_init(struct net_device *dev)
 		vendor_str = "UNKNOWN";
 
 		priv->firmware_type = 0;
+		priv->tx_rate_ctrl = 0x3;		/* Hum... */
+		priv->need_card_reset = 0;
 		priv->broken_reset = 0;
 		priv->broken_allocate = 0;
 		priv->has_port3 = 0;
@@ -1314,7 +1365,7 @@ dldwd_init(struct net_device *dev)
 	printk(KERN_INFO "%s: Firmware ID %02X vendor 0x%x (%s) version %d.%02d\n",
 	       dev->name, priv->firmware_info.id, priv->firmware_info.vendor,
 	       vendor_str, priv->firmware_info.major, priv->firmware_info.minor);
-	
+
 	if (priv->has_port3)
 		printk(KERN_INFO "%s: Ad-hoc demo mode supported.\n", dev->name);
 	if (priv->has_ibss)
@@ -1393,9 +1444,6 @@ dldwd_init(struct net_device *dev)
 		goto out;
 	}
 
-	/* Set initial bitrate control*/
-	priv->tx_rate_ctrl = 3;
-
 	/* Power management setup */
 	if (priv->has_pm) {
 		priv->pm_on = 0;
@@ -1466,7 +1514,7 @@ dldwd_get_wireless_stats(struct net_devi
 
 	dldwd_lock(priv);
 
-	if (priv->port_type == 3) {
+	if (priv->iw_mode == IW_MODE_ADHOC) {
 		memset(&wstats->qual, 0, sizeof(wstats->qual));
 #ifdef WIRELESS_SPY
 		/* If a spy address is defined, we report stats of the
@@ -1709,7 +1757,7 @@ static int dldwd_ioctl_getiwrange(struct
 {
 	dldwd_priv_t *priv = dev->priv;
 	int err = 0;
-	int ptype;
+	int mode;
 	struct iw_range range;
 	int numrates;
 	int i, k;
@@ -1723,7 +1771,7 @@ static int dldwd_ioctl_getiwrange(struct
 	rrq->length = sizeof(range);
 
 	dldwd_lock(priv);
-	ptype = priv->port_type;
+	mode = priv->iw_mode;
 	dldwd_unlock(priv);
 
 	memset(&range, 0, sizeof(range));
@@ -1755,7 +1803,7 @@ static int dldwd_ioctl_getiwrange(struct
 
 	range.sensitivity = 3;
 
-	if ((ptype == 3) && (priv->spy_number == 0)){
+	if ((mode == IW_MODE_ADHOC) && (priv->spy_number == 0)){
 		/* Quality stats meaningless in ad-hoc mode */
 		range.max_qual.qual = 0;
 		range.max_qual.level = 0;
@@ -2253,7 +2301,7 @@ static int dldwd_ioctl_setrate(struct ne
 		switch(brate) {
 		case 0:
 			fixed = 0x0;
-			upto = 0x15;
+			upto = 0xF;
 			break;
 		case 2:
 			fixed = 0x1;
@@ -2269,7 +2317,7 @@ static int dldwd_ioctl_setrate(struct ne
 			break;
 		case 22:
 			fixed = 0x8;
-			upto = 0x15;
+			upto = 0xF;
 			break;
 		default:
 			fixed = 0x0;
@@ -2881,6 +2929,7 @@ dldwd_ioctl(struct net_device *dev, stru
 		if (wrq->u.data.pointer) {
 			struct iw_priv_args privtab[] = {
 				{ SIOCDEVPRIVATE + 0x0, 0, 0, "force_reset" },
+				{ SIOCDEVPRIVATE + 0x1, 0, 0, "card_reset" },
 				{ SIOCDEVPRIVATE + 0x2,
 				  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
 				  0, "set_port3" },
@@ -2917,6 +2966,20 @@ dldwd_ioctl(struct net_device *dev, stru
 		dldwd_reset(priv);
 		break;
 
+	case SIOCDEVPRIVATE + 0x1: /* card_reset */
+		DEBUG(1, "%s: SIOCDEVPRIVATE + 0x1 (card_reset)\n",
+		      dev->name);
+		if (! capable(CAP_NET_ADMIN)) {
+			err = -EPERM;
+			break;
+		}
+		
+		printk(KERN_DEBUG "%s: Forcing card reset!\n", dev->name);
+		if(priv->card_reset_handler != NULL)
+			priv->card_reset_handler(priv);
+		dldwd_reset(priv);
+		break;
+
 	case SIOCDEVPRIVATE + 0x2: /* set_port3 */
 		DEBUG(1, "%s: SIOCDEVPRIVATE + 0x2 (set_port3)\n",
 		      dev->name);
@@ -3495,6 +3558,7 @@ dldwd_setup(dldwd_priv_t* priv)
 	ndev->priv = priv;
 
 	/* Setup up default routines */
+	priv->card_reset_handler = NULL;	/* Caller may override */
 	ndev->init = dldwd_init;
 	ndev->open = NULL;		/* Caller *must* override */
 	ndev->stop = NULL;
diff -u -p -r linux/drivers/net/wireless-airo/orinoco.h linux/drivers/net/wireless/orinoco.h
--- linux/drivers/net/wireless-airo/orinoco.h	Tue May 29 14:39:48 2001
+++ linux/drivers/net/wireless/orinoco.h	Tue May 29 16:25:45 2001
@@ -44,6 +44,8 @@ typedef dldwd_key_t dldwd_keys_t[MAX_KEY
 
 typedef struct dldwd_priv {
 	void* card;	/* Pointer to card dependant structure */
+	/* card dependant extra reset code (i.e. bus/interface specific */
+	int (*card_reset_handler)(struct dldwd_priv *);
 
 	spinlock_t lock;
 	long state;
@@ -72,7 +74,7 @@ typedef struct dldwd_priv {
 	int has_mwo;
 	int has_pm;
 	int has_preamble;
-	int broken_reset, broken_allocate;
+	int need_card_reset, broken_reset, broken_allocate;
 	uint16_t channel_mask;
 
 	/* Current configuration */
diff -u -p -r linux/drivers/net/wireless-airo/orinoco_cs.c linux/drivers/net/wireless/orinoco_cs.c
--- linux/drivers/net/wireless-airo/orinoco_cs.c	Tue May 29 14:39:48 2001
+++ linux/drivers/net/wireless/orinoco_cs.c	Tue May 29 15:01:03 2001
@@ -1,4 +1,4 @@
-/* orinoco_cs.c 0.05	- (formerly known as dldwd_cs.c)
+/* orinoco_cs.c 0.06	- (formerly known as dldwd_cs.c)
  *
  * A driver for "Hermes" chipset based PCMCIA wireless adaptors, such
  * as the Lucent WavelanIEEE/Orinoco cards and their OEM (Cabletron/
@@ -50,7 +50,7 @@ typedef struct dldwd_card {
 	struct dldwd_priv  priv;
 } dldwd_card_t;
 
-static char *version = "orinoco_cs.c 0.05 (David Gibson <hermes@gibson.dropbear.id.au> and others)";
+static char *version = "orinoco_cs.c 0.06 (David Gibson <hermes@gibson.dropbear.id.au> and others)";
 
 /*====================================================================*/
 
@@ -166,6 +166,70 @@ dldwd_cs_stop(struct net_device *dev)
 	return 0;
 }
 
+/*
+ * Do a soft reset of the Pcmcia card using the Configuration Option Register
+ * Can't do any harm, and actually may do some good on some cards...
+ * In fact, this seem necessary for Spectrum cards...
+ */
+static int
+dldwd_cs_cor_reset(dldwd_priv_t *priv)
+{
+	dldwd_card_t* card = (dldwd_card_t *)priv->card;
+	dev_link_t *link = &card->link;
+	conf_reg_t reg;
+	u_long default_cor; 
+
+	TRACE_ENTER(priv->ndev.name);
+
+	/* Doing it if hardware is gone is guaranteed crash */
+	if(!priv->hw_ready)
+		return(0);
+
+	/* Save original COR value */
+	reg.Function = 0;
+	reg.Action = CS_READ;
+	reg.Offset = CISREG_COR;
+	reg.Value = 0;
+	CardServices(AccessConfigurationRegister, link->handle, &reg);
+	default_cor = reg.Value;
+
+	DEBUG(2, "dldwd : dldwd_cs_cor_reset() : cor=0x%lX\n", default_cor);
+
+	/* Soft-Reset card */
+	reg.Action = CS_WRITE;
+	reg.Offset = CISREG_COR;
+	reg.Value = (default_cor | COR_SOFT_RESET);
+	CardServices(AccessConfigurationRegister, link->handle, &reg);
+
+	/* Wait until the card has acknowledged our reset */
+	mdelay(1);
+
+	/* Restore original COR configuration index */
+	reg.Value = (default_cor & ~COR_SOFT_RESET);
+	CardServices(AccessConfigurationRegister, link->handle, &reg);
+
+	/* Wait until the card has finished restarting */
+	mdelay(1);
+
+	TRACE_EXIT(priv->ndev.name);
+
+	return(0);
+}
+
+/* Remove zombie instances (card removed, detach pending) */
+static void
+flush_stale_links(void)
+{
+	dev_link_t *link, *next;
+	TRACE_ENTER("dldwd");
+	for (link = dev_list; link; link = next) {
+		next = link->next;
+		if (link->state & DEV_STALE_LINK)
+			dldwd_cs_detach(link);
+	}
+	TRACE_EXIT("dldwd");
+}
+
 /*======================================================================
   dldwd_cs_attach() creates an "instance" of the driver, allocating
   local data structures for one device.  The device is registered
@@ -187,6 +251,8 @@ dldwd_cs_attach(void)
 	int ret, i;
 
 	TRACE_ENTER("dldwd");
+	/* A bit of cleanup */
+	flush_stale_links();
 
 	/* Allocate space for private device-specific data */
 	card = kmalloc(sizeof(*card), GFP_KERNEL);
@@ -237,6 +303,7 @@ dldwd_cs_attach(void)
 	/* Overrides */
 	ndev->open = dldwd_cs_open;
 	ndev->stop = dldwd_cs_stop;
+	priv->card_reset_handler = dldwd_cs_cor_reset;
 
 	/* Register with Card Services */
 	link->next = dev_list;
@@ -320,45 +387,6 @@ dldwd_cs_detach(dev_link_t * link)
 	TRACE_EXIT("dldwd");
 }				/* dldwd_cs_detach */
 
-/*
- * Do a soft reset of the Pcmcia card using the Configuration Option Register
- * Can't do any harm, and actually may do some good on some cards...
- */
-static int
-dldwd_cs_cor_reset(dev_link_t *link)
-{
-	conf_reg_t reg;
-	u_long default_cor; 
-
-	/* Save original COR value */
-	reg.Function = 0;
-	reg.Action = CS_READ;
-	reg.Offset = CISREG_COR;
-	reg.Value = 0;
-	CardServices(AccessConfigurationRegister, link->handle, &reg);
-	default_cor = reg.Value;
-
-	DEBUG(2, "dldwd : dldwd_cs_cor_reset() : cor=0x%lX\n", default_cor);
-
-	/* Soft-Reset card */
-	reg.Action = CS_WRITE;
-	reg.Offset = CISREG_COR;
-	reg.Value = (default_cor | COR_SOFT_RESET);
-	CardServices(AccessConfigurationRegister, link->handle, &reg);
-
-	/* Wait until the card has acknowledged our reset */
-	mdelay(1);
-
-	/* Restore original COR configuration index */
-	reg.Value = (default_cor & COR_CONFIG_MASK);
-	CardServices(AccessConfigurationRegister, link->handle, &reg);
-
-	/* Wait until the card has finished restarting */
-	mdelay(1);
-
-	return(0);
-}
-
 /*======================================================================
   dldwd_cs_config() is scheduled to run after a CARD_INSERTION event
   is received, to configure the PCMCIA socket, and to make the
@@ -556,10 +584,6 @@ dldwd_cs_config(dev_link_t * link)
 	ndev->base_addr = link->io.BasePort1;
 	ndev->irq = link->irq.AssignedIRQ;
 
-	/* Do a Pcmcia soft reset of the card (optional) */
-	if(reset_cor)
-		dldwd_cs_cor_reset(link);
-
 	/* register_netdev will give us an ethX name */
 	ndev->name[0] = '\0';
 	/* Tell the stack we exist */
@@ -586,9 +610,6 @@ dldwd_cs_config(dev_link_t * link)
 		       link->io.BasePort2 + link->io.NumPorts2 - 1);
 	printk("\n");
 
-	/* Allow /proc & ioctls to act */
-	priv->hw_ready = 1;
-	
 	/* And give us the proc nodes for debugging */
 	if (dldwd_proc_dev_init(priv) != 0) {
 		printk(KERN_ERR "orinoco_cs: Failed to create /proc node for %s\n",
@@ -599,6 +620,13 @@ dldwd_cs_config(dev_link_t * link)
 	/* Note to myself : this replace MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT */
 	SET_MODULE_OWNER(ndev);
 	
+	/* Allow cor_reset, /proc & ioctls to act */
+	priv->hw_ready = 1;
+	
+	/* Do a Pcmcia soft reset of the card (optional) */
+	if(reset_cor)
+		dldwd_cs_cor_reset(priv);
+
 	/*
 	   At this point, the dev_node_t structure(s) need to be
 	   initialized and arranged in a linked list at link->dev.
