Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVBXEaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVBXEaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVBXE3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:29:42 -0500
Received: from ozlabs.org ([203.10.76.45]:17590 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261796AbVBXENZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:13:25 -0500
Date: Thu, 24 Feb 2005 15:04:09 +1100
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [13/14] Orinoco driver updates - update firmware detection
Message-ID: <20050224040409.GO32001@localhost.localdomain>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20050224035650.GD32001@localhost.localdomain> <20050224035718.GE32001@localhost.localdomain> <20050224035804.GF32001@localhost.localdomain> <20050224035957.GH32001@localhost.localdomain> <20050224040024.GI32001@localhost.localdomain> <20050224040052.GJ32001@localhost.localdomain> <20050224040153.GK32001@localhost.localdomain> <20050224040228.GL32001@localhost.localdomain> <20050224040258.GM32001@localhost.localdomain> <20050224040319.GN32001@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224040319.GN32001@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update firmware detection code.  This will now reliably detect
Intersil firmwares past verison 1.x, a serious flaw in the previous
code.  It cleans up the code, and reduces the size of the private
structure by using single bits for the various firmware feature flags.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2005-02-24 14:50:57.300439064 +1100
+++ working-2.6/drivers/net/wireless/orinoco.c	2005-02-24 14:50:59.879047056 +1100
@@ -2047,39 +2047,54 @@
 /* Initialization                                                   */
 /********************************************************************/
 
-struct sta_id {
+struct comp_id {
 	u16 id, variant, major, minor;
 } __attribute__ ((packed));
 
-static int determine_firmware_type(struct net_device *dev, struct sta_id *sta_id)
+static inline fwtype_t determine_firmware_type(struct comp_id *nic_id)
 {
-	/* FIXME: this is fundamentally broken */
-	unsigned int firmver = ((u32)sta_id->major << 16) | sta_id->minor;
-	
-	if (sta_id->variant == 1)
+	if (nic_id->id < 0x8000)
 		return FIRMWARE_TYPE_AGERE;
-	else if ((sta_id->variant == 2) &&
-		   ((firmver == 0x10001) || (firmver == 0x20001)))
+	else if (nic_id->id == 0x8000 && nic_id->major == 0)
 		return FIRMWARE_TYPE_SYMBOL;
 	else
 		return FIRMWARE_TYPE_INTERSIL;
 }
 
-static void determine_firmware(struct net_device *dev)
+/* Set priv->firmware type, determine firmware properties */
+static int determine_firmware(struct net_device *dev)
 {
 	struct orinoco_private *priv = netdev_priv(dev);
 	hermes_t *hw = &priv->hw;
 	int err;
-	struct sta_id sta_id;
+	struct comp_id nic_id, sta_id;
 	unsigned int firmver;
 	char tmp[SYMBOL_MAX_VER_LEN+1];
 
+	/* Get the hardware version */
+	err = HERMES_READ_RECORD(hw, USER_BAP, HERMES_RID_NICID, &nic_id);
+	if (err) {
+		printk(KERN_ERR "%s: Cannot read hardware identity: error %d\n",
+		       dev->name, err);
+		return err;
+	}
+
+	le16_to_cpus(&nic_id.id);
+	le16_to_cpus(&nic_id.variant);
+	le16_to_cpus(&nic_id.major);
+	le16_to_cpus(&nic_id.minor);
+	printk(KERN_DEBUG "%s: Hardware identity %04x:%04x:%04x:%04x\n",
+	       dev->name, nic_id.id, nic_id.variant,
+	       nic_id.major, nic_id.minor);
+
+	priv->firmware_type = determine_firmware_type(&nic_id);
+
 	/* Get the firmware version */
 	err = HERMES_READ_RECORD(hw, USER_BAP, HERMES_RID_STAID, &sta_id);
 	if (err) {
-		printk(KERN_WARNING "%s: Error %d reading firmware info. Wildly guessing capabilities...\n",
+		printk(KERN_ERR "%s: Cannot read station identity: error %d\n",
 		       dev->name, err);
-		memset(&sta_id, 0, sizeof(sta_id));
+		return err;
 	}
 
 	le16_to_cpus(&sta_id.id);
@@ -2090,8 +2105,23 @@
 	       dev->name, sta_id.id, sta_id.variant,
 	       sta_id.major, sta_id.minor);
 
-	if (! priv->firmware_type)
-		priv->firmware_type = determine_firmware_type(dev, &sta_id);
+	switch (sta_id.id) {
+	case 0x15:
+		printk(KERN_ERR "%s: Primary firmware is active\n",
+		       dev->name);
+		return -ENODEV;
+	case 0x14b:
+		printk(KERN_ERR "%s: Tertiary firmware is active\n",
+		       dev->name);
+		return -ENODEV;
+	case 0x1f:	/* Intersil, Agere, Symbol Spectrum24 */
+	case 0x21:	/* Symbol Spectrum24 Trilogy */
+		break;
+	default:
+		printk(KERN_NOTICE "%s: Unknown station ID, please report\n",
+		       dev->name);
+		break;
+	}
 
 	/* Default capabilities */
 	priv->has_sensitivity = 1;
@@ -2107,9 +2137,8 @@
 	case FIRMWARE_TYPE_AGERE:
 		/* Lucent Wavelan IEEE, Lucent Orinoco, Cabletron RoamAbout,
 		   ELSA, Melco, HP, IBM, Dell 1150, Compaq 110/210 */
-		printk(KERN_DEBUG "%s: Looks like a Lucent/Agere firmware "
-		       "version %d.%02d\n", dev->name,
-		       sta_id.major, sta_id.minor);
+		snprintf(priv->fw_name, sizeof(priv->fw_name) - 1,
+			 "Lucent/Agere %d.%02d", sta_id.major, sta_id.minor);
 
 		firmver = ((unsigned long)sta_id.major << 16) | sta_id.minor;
 
@@ -2152,14 +2181,15 @@
 			tmp[SYMBOL_MAX_VER_LEN] = '\0';
 		}
 
-		printk(KERN_DEBUG "%s: Looks like a Symbol firmware "
-		       "version [%s] (parsing to %X)\n", dev->name,
-		       tmp, firmver);
+		snprintf(priv->fw_name, sizeof(priv->fw_name) - 1,
+			 "Symbol %s", tmp);
 
 		priv->has_ibss = (firmver >= 0x20000);
 		priv->has_wep = (firmver >= 0x15012);
 		priv->has_big_wep = (firmver >= 0x20000);
-		priv->has_pm = (firmver >= 0x20000) && (firmver < 0x22000);
+		priv->has_pm = (firmver >= 0x20000 && firmver < 0x22000) || 
+			       (firmver >= 0x29000 && firmver < 0x30000) ||
+			       firmver >= 0x31000;
 		priv->has_preamble = (firmver >= 0x20000);
 		priv->ibss_port = 4;
 		/* Tested with Intel firmware : 0x20015 => Jean II */
@@ -2171,9 +2201,9 @@
 		 * different and less well tested */
 		/* D-Link MAC : 00:40:05:* */
 		/* Addtron MAC : 00:90:D1:* */
-		printk(KERN_DEBUG "%s: Looks like an Intersil firmware "
-		       "version %d.%d.%d\n", dev->name,
-		       sta_id.major, sta_id.minor, sta_id.variant);
+		snprintf(priv->fw_name, sizeof(priv->fw_name) - 1,
+			 "Intersil %d.%d.%d", sta_id.major, sta_id.minor,
+			 sta_id.variant);
 
 		firmver = ((unsigned long)sta_id.major << 16) |
 			((unsigned long)sta_id.minor << 8) | sta_id.variant;
@@ -2191,9 +2221,11 @@
 			priv->ibss_port = 1;
 		}
 		break;
-	default:
-		break;
 	}
+	printk(KERN_DEBUG "%s: Firmware determined as %s\n", dev->name,
+	       priv->fw_name);
+
+	return 0;
 }
 
 static int orinoco_init(struct net_device *dev)
@@ -2219,7 +2251,12 @@
 		goto out;
 	}
 
-	determine_firmware(dev);
+	err = determine_firmware(dev);
+	if (err != 0) {
+		printk(KERN_ERR "%s: Incompatible firmware, aborting\n",
+		       dev->name);
+		goto out;
+	}
 
 	if (priv->has_port3)
 		printk(KERN_DEBUG "%s: Ad-hoc demo mode supported\n", dev->name);
Index: working-2.6/drivers/net/wireless/orinoco.h
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.h	2005-02-24 14:50:53.167067432 +1100
+++ working-2.6/drivers/net/wireless/orinoco.h	2005-02-24 14:50:59.879047056 +1100
@@ -30,6 +30,12 @@
 	char data[ORINOCO_MAX_KEY_SIZE];
 } __attribute__ ((packed));
 
+typedef enum {
+	FIRMWARE_TYPE_AGERE,
+	FIRMWARE_TYPE_INTERSIL,
+	FIRMWARE_TYPE_SYMBOL
+} fwtype_t;
+
 struct orinoco_private {
 	void *card;	/* Pointer to card dependent structure */
 	int (*hard_reset)(struct orinoco_private *);
@@ -53,19 +59,22 @@
 	u16 txfid;
 
 	/* Capabilities of the hardware/firmware */
-	int firmware_type;
-#define FIRMWARE_TYPE_AGERE 1
-#define FIRMWARE_TYPE_INTERSIL 2
-#define FIRMWARE_TYPE_SYMBOL 3
-	int has_ibss, has_port3, ibss_port;
-	int has_wep, has_big_wep;
-	int has_mwo;
-	int has_pm;
-	int has_preamble;
-	int has_sensitivity;
+	fwtype_t firmware_type;
+	char fw_name[32];
+	int ibss_port;
 	int nicbuf_size;
 	u16 channel_mask;
-	int broken_disableport;
+
+	/* Boolean capabilities */
+	unsigned int has_ibss:1;
+	unsigned int has_port3:1;
+	unsigned int has_wep:1;
+	unsigned int has_big_wep:1;
+	unsigned int has_mwo:1;
+	unsigned int has_pm:1;
+	unsigned int has_preamble:1;
+	unsigned int has_sensitivity:1;
+	unsigned int broken_disableport:1;
 
 	/* Configuration paramaters */
 	u32 iw_mode;
Index: working-2.6/drivers/net/wireless/orinoco_pci.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco_pci.c	2005-02-24 14:50:47.830878656 +1100
+++ working-2.6/drivers/net/wireless/orinoco_pci.c	2005-02-24 14:50:59.880046904 +1100
@@ -251,10 +251,6 @@
 		goto fail;
 	}
 
-	/* Override the normal firmware detection - the Prism 2.5 PCI
-	 * cards look like Lucent firmware but are actually Intersil */
-	priv->firmware_type = FIRMWARE_TYPE_INTERSIL;
-
 	err = register_netdev(dev);
 	if (err) {
 		printk(KERN_ERR PFX "Failed to register net device\n");

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
