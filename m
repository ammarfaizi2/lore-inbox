Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUHWPKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUHWPKO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUHWPKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:10:13 -0400
Received: from [212.209.10.220] ([212.209.10.220]:51364 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264923AbUHWPCE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:02:04 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] CRIS architecture update
Date: Mon, 23 Aug 2004 17:02:02 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F50F@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains changes related to ethernet.

  * An overrun caused the interface to be unusable when padding was
disabled.

diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/drivers/ethernet.c
linux/arch/cris/drivers/ethernet.c
--- ../linux/arch/cris/drivers/ethernet.c	Wed Feb 18 14:36:30 2004
+++ linux/arch/cris/drivers/ethernet.c	Mon Aug 23 15:48:45 2004
@@ -1,4 +1,4 @@
-/* $Id: ethernet.c,v 1.48 2003/12/03 13:44:39 starvik Exp $
+/* $Id: ethernet.c,v 1.52 2004/08/23 13:48:45 starvik Exp $
  *
  * e100net.c: A network driver for the ETRAX 100LX network controller.
  *
@@ -7,6 +7,20 @@
  * The outline of this driver comes from skeleton.c.
  *
  * $Log: ethernet.c,v $
+ * Revision 1.52  2004/08/23 13:48:45  starvik
+ * Make use of generic MDIO interface and constants.
+ *
+ * Revision 1.51  2004/08/20 09:29:32  starvik
+ * Added support for Intel LXT972A. Creds to Randy Scarborough.
+ *
+ * Revision 1.50  2004/06/09 05:02:57  starvik
+ * Avoid any race where R_DMA_CH1_FIRST is NULL (may trigger the cache
bug).
+ *
+ * Revision 1.49  2004/01/28 19:15:54  henriken
+ * Use a shadow register for R_NETWORK_TR_CTRL.
+ * Don't destroy R_NETWORK_TR_CTRL setting in under-/over-run irq handler
+ * (e100nw_interrupt).
+ *
  * Revision 1.48  2003/12/03 13:44:39  starvik
  * Use hardware pad for short packets. This prevents information leakage
  * reported by Nessus.
@@ -261,6 +275,7 @@
 /* Information that need to be kept for each board. */
 struct net_local {
 	struct net_device_stats stats;
+	struct mii_if_info mii_if;
 
 	/* Tx control lock.  This protects the transmit buffer ring
 	 * state along with the "tx full" state of the driver.  This
@@ -280,8 +295,8 @@
 struct transceiver_ops
 {
 	unsigned int oui;
-	void (*check_speed)(void);
-	void (*check_duplex)(void);
+	void (*check_speed)(struct net_device* dev);
+	void (*check_duplex)(struct net_device* dev);
 };
 
 struct transceiver_ops* transceiver;
@@ -304,25 +319,6 @@
 /* 
 ** MDIO constants.
 */
-#define MDIO_BASE_STATUS_REG                0x1
-#define MDIO_BASE_CONTROL_REG               0x0
-#define MDIO_PHY_ID_HIGH_REG                0x2
-#define MDIO_PHY_ID_LOW_REG                 0x3
-#define MDIO_BC_NEGOTIATE                0x0200
-#define MDIO_BC_FULL_DUPLEX_MASK         0x0100
-#define MDIO_BC_AUTO_NEG_MASK            0x1000
-#define MDIO_BC_SPEED_SELECT_MASK        0x2000
-#define MDIO_STATUS_100_FD               0x4000
-#define MDIO_STATUS_100_HD               0x2000
-#define MDIO_STATUS_10_FD                0x1000
-#define MDIO_STATUS_10_HD                0x0800
-#define MDIO_STATUS_SPEED_DUPLEX_MASK	 0x7800
-#define MDIO_ADVERTISMENT_REG               0x4
-#define MDIO_ADVERT_100_FD                0x100
-#define MDIO_ADVERT_100_HD                0x080
-#define MDIO_ADVERT_10_FD                 0x040
-#define MDIO_ADVERT_10_HD                 0x020
-#define MDIO_LINK_UP_MASK                   0x4
 #define MDIO_START                          0x1
 #define MDIO_READ                           0x2
 #define MDIO_WRITE                          0x1
@@ -338,6 +334,11 @@
 #define MDIO_TDK_DIAGNOSTIC_RATE          0x400
 #define MDIO_TDK_DIAGNOSTIC_DPLX          0x800
 
+/*Intel LXT972A specific*/
+#define MDIO_INT_STATUS_REG_2			0x0011
+#define MDIO_INT_FULL_DUPLEX_IND		( 0x0001 << 9  )
+#define MDIO_INT_SPEED					( 0x0001 << 14 )
+
 /* Network flash constants */
 #define NET_FLASH_TIME                  (HZ/50) /* 20 ms */
 #define NET_FLASH_PAUSE                (HZ/100) /* 10 ms */
@@ -382,6 +383,8 @@
 static unsigned int network_rec_config_shadow = 0;
 static unsigned int mdio_phy_addr; /* Transciever address */
 
+static unsigned int network_tr_ctrl_shadow = 0;
+
 /* Network speed indication. */
 static struct timer_list speed_timer;
 static struct timer_list clear_led_timer;
@@ -415,36 +418,40 @@
 static void e100_hardware_send_packet(char *buf, int length);
 static void update_rx_stats(struct net_device_stats *);
 static void update_tx_stats(struct net_device_stats *);
-static int e100_probe_transceiver(void);
+static int e100_probe_transceiver(struct net_device* dev);
 
-static void e100_check_speed(unsigned long dummy);
-static void e100_set_speed(unsigned long speed);
-static void e100_check_duplex(unsigned long dummy);
-static void e100_set_duplex(enum duplex);
-static void e100_negotiate(void);
+static void e100_check_speed(unsigned long priv);
+static void e100_set_speed(struct net_device* dev, unsigned long speed);
+static void e100_check_duplex(unsigned long priv);
+static void e100_set_duplex(struct net_device* dev, enum duplex);
+static void e100_negotiate(struct net_device* dev);
+
+static int e100_get_mdio_reg(struct net_device *dev, int phy_id, int
location);
+static void e100_set_mdio_reg(struct net_device *dev, int phy_id, int
location, int value);
 
-static unsigned short e100_get_mdio_reg(unsigned char reg_num);
-static void e100_set_mdio_reg(unsigned char reg, unsigned short data);
 static void e100_send_mdio_cmd(unsigned short cmd, int write_cmd);
 static void e100_send_mdio_bit(unsigned char bit);
 static unsigned char e100_receive_mdio_bit(void);
-static void e100_reset_transceiver(void);
+static void e100_reset_transceiver(struct net_device* dev);
 
 static void e100_clear_network_leds(unsigned long dummy);
 static void e100_set_network_leds(int active);
 
-static void broadcom_check_speed(void);
-static void broadcom_check_duplex(void);
-static void tdk_check_speed(void);
-static void tdk_check_duplex(void);
-static void generic_check_speed(void);
-static void generic_check_duplex(void);
+static void broadcom_check_speed(struct net_device* dev);
+static void broadcom_check_duplex(struct net_device* dev);
+static void tdk_check_speed(struct net_device* dev);
+static void tdk_check_duplex(struct net_device* dev);
+static void intel_check_speed(struct net_device* dev);
+static void intel_check_duplex(struct net_device* dev);
+static void generic_check_speed(struct net_device* dev);
+static void generic_check_duplex(struct net_device* dev);
 
 struct transceiver_ops transceivers[] = 
 {
 	{0x1018, broadcom_check_speed, broadcom_check_duplex},  /* Broadcom
*/
 	{0xC039, tdk_check_speed, tdk_check_duplex},            /* TDK 2120
*/
 	{0x039C, tdk_check_speed, tdk_check_duplex},            /* TDK 2120C
*/
+	{0x04de, intel_check_speed, intel_check_duplex},     	/* Intel
LXT972A*/
 	{0x0000, generic_check_speed, generic_check_duplex}     /* Generic,
must be last */
 };
 
@@ -462,6 +469,7 @@
 etrax_ethernet_init(struct net_device *dev)
 {
 	int i;
+	struct net_local* np;
 
 	printk(KERN_INFO
 	       "ETRAX 100LX 10/100MBit ethernet v2.0 (c) 2000-2001 Axis
Communications AB\n");
@@ -486,7 +494,7 @@
 
 	/* make room for the local structure containing stats etc */
 
-	dev->priv = kmalloc(sizeof(struct net_local), GFP_KERNEL);
+	dev->priv = np = kmalloc(sizeof(struct net_local), GFP_KERNEL);
 	if (dev->priv == NULL)
 		return -ENOMEM;
 	memset(dev->priv, 0, sizeof(struct net_local));
@@ -566,11 +574,20 @@
         
 	clear_led_timer.function = e100_clear_network_leds;
         
-	full_duplex = 0;
+	full_duplex = 0;	
 	current_duplex = autoneg;
 	duplex_timer.expires = jiffies + NET_DUPLEX_CHECK_INTERVAL;

+	duplex_timer.data = (unsigned long)dev;
 	duplex_timer.function = e100_check_duplex;
 
+	/* Initialize mii interface */
+	np->mii_if.phy_id = mdio_phy_addr;
+	np->mii_if.phy_id_mask = 0x1f;
+	np->mii_if.reg_num_mask = 0x1f;
+	np->mii_if.dev = dev;
+	np->mii_if.mdio_read = e100_get_mdio_reg;
+	np->mii_if.mdio_write = e100_set_mdio_reg;
+
         /* Initialize group address registers to make sure that no */
         /* unwanted addresses are matched */
 	*R_NETWORK_GA_0 = 0x00000000;
@@ -711,14 +728,14 @@
 		IO_STATE(R_NETWORK_GEN_CONFIG, phy,    mii_clk) |
 		IO_STATE(R_NETWORK_GEN_CONFIG, enable, on);
 
-	*R_NETWORK_TR_CTRL = 
-		IO_STATE(R_NETWORK_TR_CTRL, clr_error, clr) |
-		IO_STATE(R_NETWORK_TR_CTRL, delay, none) |
-		IO_STATE(R_NETWORK_TR_CTRL, cancel, dont) |
-		IO_STATE(R_NETWORK_TR_CTRL, cd, enable) |
-		IO_STATE(R_NETWORK_TR_CTRL, retry, enable) |
-		IO_STATE(R_NETWORK_TR_CTRL, pad, enable) |
-		IO_STATE(R_NETWORK_TR_CTRL, crc, enable);
+	SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, clr_error, clr);
+	SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, delay, none);
+	SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, cancel, dont);
+	SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, cd, enable);
+	SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, retry, enable);
+	SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, pad, enable);
+	SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, crc, enable);
+	*R_NETWORK_TR_CTRL = network_tr_ctrl_shadow;
 
 	save_flags(flags);
 	cli();
@@ -757,7 +774,7 @@
 	restore_flags(flags);
 	
 	/* Probe for transceiver */
-	if (e100_probe_transceiver())
+	if (e100_probe_transceiver(dev))
 		goto grace_exit4;
 
 	/* Start duplex/speed timers */
@@ -784,45 +801,54 @@
 }
 
 static void
-generic_check_speed(void)
+generic_check_speed(struct net_device* dev)
 {
 	unsigned long data;
-	data = e100_get_mdio_reg(MDIO_ADVERTISMENT_REG);
-	if ((data & MDIO_ADVERT_100_FD) ||
-	    (data & MDIO_ADVERT_100_HD))
+	data = e100_get_mdio_reg(dev, mdio_phy_addr, MII_ADVERTISE);
+	if ((data & ADVERTISE_100FULL) ||
+	    (data & ADVERTISE_100HALF))
 		current_speed = 100;
 	else
 		current_speed = 10;
 }
 
 static void
-tdk_check_speed(void)
+tdk_check_speed(struct net_device* dev)
 {
 	unsigned long data;
-	data = e100_get_mdio_reg(MDIO_TDK_DIAGNOSTIC_REG);
+	data = e100_get_mdio_reg(dev, mdio_phy_addr,
MDIO_TDK_DIAGNOSTIC_REG);
 	current_speed = (data & MDIO_TDK_DIAGNOSTIC_RATE ? 100 : 10);
 }
 
 static void
-broadcom_check_speed(void)
+broadcom_check_speed(struct net_device* dev)
 {
 	unsigned long data;
-	data = e100_get_mdio_reg(MDIO_AUX_CTRL_STATUS_REG);
+	data = e100_get_mdio_reg(dev, mdio_phy_addr,
MDIO_AUX_CTRL_STATUS_REG);
 	current_speed = (data & MDIO_BC_SPEED ? 100 : 10);
 }
 
 static void
-e100_check_speed(unsigned long dummy)
+intel_check_speed(struct net_device* dev)
 {
+	unsigned long data;
+	data = e100_get_mdio_reg(dev, mdio_phy_addr, MDIO_INT_STATUS_REG_2);
+	current_speed = (data & MDIO_INT_SPEED ? 100 : 10);
+}
+
+static void
+e100_check_speed(unsigned long priv)
+{
+	struct net_device* dev = (struct net_device*)priv;
 	static int led_initiated = 0;
 	unsigned long data;
 	int old_speed = current_speed;
 
-	data = e100_get_mdio_reg(MDIO_BASE_STATUS_REG);
-	if (!(data & MDIO_LINK_UP_MASK)) {
+	data = e100_get_mdio_reg(dev, mdio_phy_addr, MII_BMSR);
+	if (!(data & BMSR_LSTATUS)) {
 		current_speed = 0;
 	} else {
-		transceiver->check_speed();
+		transceiver->check_speed(dev);
 	}
 	
 	if ((old_speed != current_speed) || !led_initiated) {
@@ -836,70 +862,73 @@
 }
 
 static void
-e100_negotiate(void)
+e100_negotiate(struct net_device* dev)
 {
-	unsigned short data = e100_get_mdio_reg(MDIO_ADVERTISMENT_REG);
+	unsigned short data = e100_get_mdio_reg(dev, mdio_phy_addr,
MII_ADVERTISE);
 
 	/* Discard old speed and duplex settings */
-	data &= ~(MDIO_ADVERT_100_HD | MDIO_ADVERT_100_FD | 
-	          MDIO_ADVERT_10_FD | MDIO_ADVERT_10_HD);
+	data &= ~(ADVERTISE_100HALF | ADVERTISE_100FULL | 
+	          ADVERTISE_10HALF | ADVERTISE_10FULL);
   
 	switch (current_speed_selection) {
 		case 10 :
 			if (current_duplex == full)
-				data |= MDIO_ADVERT_10_FD;
+				data |= ADVERTISE_10FULL;
 			else if (current_duplex == half)
-				data |= MDIO_ADVERT_10_HD;
+				data |= ADVERTISE_10HALF;
 			else
-				data |= MDIO_ADVERT_10_HD |
MDIO_ADVERT_10_FD;
+				data |= ADVERTISE_10HALF | ADVERTISE_10FULL;
 			break;
 
 		case 100 :
 			 if (current_duplex == full)
-				data |= MDIO_ADVERT_100_FD;
+				data |= ADVERTISE_100FULL;
 			else if (current_duplex == half)
-				data |= MDIO_ADVERT_100_HD;
+				data |= ADVERTISE_100HALF;
 			else
-				data |= MDIO_ADVERT_100_HD |
MDIO_ADVERT_100_FD;
+				data |= ADVERTISE_100HALF |
ADVERTISE_100FULL;
 			break;
 
 		case 0 : /* Auto */
 			 if (current_duplex == full)
-				data |= MDIO_ADVERT_100_FD |
MDIO_ADVERT_10_FD;
+				data |= ADVERTISE_100FULL |
ADVERTISE_10FULL;
 			else if (current_duplex == half)
-				data |= MDIO_ADVERT_100_HD |
MDIO_ADVERT_10_HD;
+				data |= ADVERTISE_100HALF |
ADVERTISE_10HALF;
 			else
-				data |= MDIO_ADVERT_100_HD |
MDIO_ADVERT_100_FD | MDIO_ADVERT_10_FD | MDIO_ADVERT_10_HD;
+				data |= ADVERTISE_10HALF | ADVERTISE_10FULL
|
+				  ADVERTISE_100HALF | ADVERTISE_100FULL;
 			break;
 
 		default : /* assume autoneg speed and duplex */
-			data |= MDIO_ADVERT_100_HD | MDIO_ADVERT_100_FD | 
-			        MDIO_ADVERT_10_FD | MDIO_ADVERT_10_HD;
+			data |= ADVERTISE_10HALF | ADVERTISE_10FULL |
+				  ADVERTISE_100HALF | ADVERTISE_100FULL;
 	}
 
-	e100_set_mdio_reg(MDIO_ADVERTISMENT_REG, data);
+	e100_set_mdio_reg(dev, mdio_phy_addr, MII_ADVERTISE, data);
 
 	/* Renegotiate with link partner */
-	data = e100_get_mdio_reg(MDIO_BASE_CONTROL_REG);
-	data |= MDIO_BC_NEGOTIATE;
+	data = e100_get_mdio_reg(dev, mdio_phy_addr, MII_BMCR);
+	data |= BMCR_ANENABLE | BMCR_ANRESTART;
 
-	e100_set_mdio_reg(MDIO_BASE_CONTROL_REG, data);
+	e100_set_mdio_reg(dev, mdio_phy_addr, MII_BMCR, data);
 }
 
 static void
-e100_set_speed(unsigned long speed)
+e100_set_speed(struct net_device* dev, unsigned long speed)
 {
 	if (speed != current_speed_selection) {
 		current_speed_selection = speed;
-		e100_negotiate();
+		e100_negotiate(dev);
 	}
 }
 
 static void
-e100_check_duplex(unsigned long dummy)
+e100_check_duplex(unsigned long priv)
 {
+	struct net_device *dev = (struct net_device *)priv;
+	struct net_local *np = (struct net_local *)dev->priv;
 	int old_duplex = full_duplex;
-	transceiver->check_duplex();
+	transceiver->check_duplex(dev);
 	if (old_duplex != full_duplex) { 
 		/* Duplex changed */
 		SETF(network_rec_config_shadow, R_NETWORK_REC_CONFIG,
duplex, full_duplex);
@@ -909,47 +938,56 @@
 	/* Reinitialize the timer. */
 	duplex_timer.expires = jiffies + NET_DUPLEX_CHECK_INTERVAL;
 	add_timer(&duplex_timer);
+	np->mii_if.full_duplex = full_duplex;
 }
 
 static void
-generic_check_duplex(void)
+generic_check_duplex(struct net_device* dev)
 {
 	unsigned long data;
-	data = e100_get_mdio_reg(MDIO_ADVERTISMENT_REG);
-	if ((data & MDIO_ADVERT_100_FD) ||
-	    (data & MDIO_ADVERT_10_FD))
+	data = e100_get_mdio_reg(dev, mdio_phy_addr, MII_ADVERTISE);
+	if ((data & ADVERTISE_10FULL) ||
+	    (data & ADVERTISE_100FULL))
 		full_duplex = 1;
 	else
 		full_duplex = 0;
 }
 
 static void
-tdk_check_duplex(void)
+tdk_check_duplex(struct net_device* dev)
 {
 	unsigned long data;
-	data = e100_get_mdio_reg(MDIO_TDK_DIAGNOSTIC_REG);
+	data = e100_get_mdio_reg(dev, mdio_phy_addr,
MDIO_TDK_DIAGNOSTIC_REG);
 	full_duplex = (data & MDIO_TDK_DIAGNOSTIC_DPLX) ? 1 : 0;
 }
 
 static void
-broadcom_check_duplex(void)
+broadcom_check_duplex(struct net_device* dev)
 {
 	unsigned long data;
-	data = e100_get_mdio_reg(MDIO_AUX_CTRL_STATUS_REG);        
+	data = e100_get_mdio_reg(dev, mdio_phy_addr,
MDIO_AUX_CTRL_STATUS_REG);        
 	full_duplex = (data & MDIO_BC_FULL_DUPLEX_IND) ? 1 : 0;
 }
 
+static void
+intel_check_duplex(struct net_device* dev)
+{
+	unsigned long data;
+	data = e100_get_mdio_reg(dev, mdio_phy_addr, MDIO_INT_STATUS_REG_2);

+	full_duplex = (data & MDIO_INT_FULL_DUPLEX_IND) ? 1 : 0;
+}
+
 static void 
-e100_set_duplex(enum duplex new_duplex)
+e100_set_duplex(struct net_device* dev, enum duplex new_duplex)
 {
 	if (new_duplex != current_duplex) {
 		current_duplex = new_duplex;
-		e100_negotiate();
+		e100_negotiate(dev);
 	}
 }
 
 static int 
-e100_probe_transceiver(void)
+e100_probe_transceiver(struct net_device* dev)
 {
 	unsigned int phyid_high;
 	unsigned int phyid_low;
@@ -958,15 +996,15 @@
 
 	/* Probe MDIO physical address */
 	for (mdio_phy_addr = 0; mdio_phy_addr <= 31; mdio_phy_addr++) {
-		if (e100_get_mdio_reg(MDIO_BASE_STATUS_REG) != 0xffff)
+		if (e100_get_mdio_reg(dev, mdio_phy_addr, MII_BMSR) !=
0xffff)
 			break;
 	}
 	if (mdio_phy_addr == 32)
 		 return -ENODEV;
 
 	/* Get manufacturer */
-	phyid_high = e100_get_mdio_reg(MDIO_PHY_ID_HIGH_REG);
-	phyid_low = e100_get_mdio_reg(MDIO_PHY_ID_LOW_REG);
+	phyid_high = e100_get_mdio_reg(dev, mdio_phy_addr, MII_PHYSID1);
+	phyid_low = e100_get_mdio_reg(dev, mdio_phy_addr, MII_PHYSID2);
 	oui = (phyid_high << 6) | (phyid_low >> 10);
 	
 	for (ops = &transceivers[0]; ops->oui; ops++) {
@@ -978,16 +1016,16 @@
 	return 0;
 }
 
-static unsigned short
-e100_get_mdio_reg(unsigned char reg_num)
+static int
+e100_get_mdio_reg(struct net_device *dev, int phy_id, int location)
 {
 	unsigned short cmd;    /* Data to be sent on MDIO port */
-	unsigned short data;   /* Data read from MDIO */
+	int data;   /* Data read from MDIO */
 	int bitCounter;
 	
 	/* Start of frame, OP Code, Physical Address, Register Address */
-	cmd = (MDIO_START << 14) | (MDIO_READ << 12) | (mdio_phy_addr << 7)
|
-		(reg_num << 2);
+	cmd = (MDIO_START << 14) | (MDIO_READ << 12) | (phy_id << 7) |
+		(location << 2);
 	
 	e100_send_mdio_cmd(cmd, 0);
 	
@@ -1002,19 +1040,19 @@
 }
 
 static void
-e100_set_mdio_reg(unsigned char reg, unsigned short data)
+e100_set_mdio_reg(struct net_device *dev, int phy_id, int location, int
value)
 {
 	int bitCounter;
 	unsigned short cmd;
 
-	cmd = (MDIO_START << 14) | (MDIO_WRITE << 12) | (mdio_phy_addr << 7)
|
-	      (reg << 2);
+	cmd = (MDIO_START << 14) | (MDIO_WRITE << 12) | (phy_id << 7) |
+	      (location << 2);
 
 	e100_send_mdio_cmd(cmd, 1);
 
 	/* Data... */
 	for (bitCounter=15; bitCounter>=0 ; bitCounter--) {
-		e100_send_mdio_bit(GET_BIT(bitCounter, data));
+		e100_send_mdio_bit(GET_BIT(bitCounter, value));
 	}
 
 }
@@ -1067,15 +1105,15 @@
 }
 
 static void 
-e100_reset_transceiver(void)
+e100_reset_transceiver(struct net_device* dev)
 {
 	unsigned short cmd;
 	unsigned short data;
 	int bitCounter;
 
-	data = e100_get_mdio_reg(MDIO_BASE_CONTROL_REG);
+	data = e100_get_mdio_reg(dev, mdio_phy_addr, MII_BMCR);
 
-	cmd = (MDIO_START << 14) | (MDIO_WRITE << 12) | (mdio_phy_addr << 7)
| (MDIO_BASE_CONTROL_REG << 2);
+	cmd = (MDIO_START << 14) | (MDIO_WRITE << 12) | (mdio_phy_addr << 7)
| (MII_BMCR << 2);
 
 	e100_send_mdio_cmd(cmd, 1);
 	
@@ -1109,7 +1147,7 @@
 	
 	/* Reset the transceiver. */
 	
-	e100_reset_transceiver();
+	e100_reset_transceiver(dev);
 	
 	/* and get rid of the packets that never got an interrupt */
 	while (myFirstTxDesc != myNextTxDesc)
@@ -1189,7 +1227,8 @@
 
 		/* check if one or more complete packets were indeed
received */
 
-		while (*R_DMA_CH1_FIRST != virt_to_phys(myNextRxDesc)) {
+		while ((*R_DMA_CH1_FIRST != virt_to_phys(myNextRxDesc)) &&
+		       (myNextRxDesc != myLastRxDesc)) {
 			/* Take out the buffer and give it to the OS, then
 			 * allocate a new buffer to put a packet in.
 			 */
@@ -1241,8 +1280,10 @@
 	unsigned long irqbits = *R_IRQ_MASK0_RD;
 
 	/* check for underrun irq */
-	if (irqbits & IO_STATE(R_IRQ_MASK0_RD, underrun, active)) { 
-		*R_NETWORK_TR_CTRL = IO_STATE(R_NETWORK_TR_CTRL, clr_error,
clr);
+	if (irqbits & IO_STATE(R_IRQ_MASK0_RD, underrun, active)) {
+		SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, clr_error,
clr);	
+		*R_NETWORK_TR_CTRL = network_tr_ctrl_shadow;
+		SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, clr_error,
nop);
 		np->stats.tx_errors++;
 		D(printk("ethernet receiver underrun!\n"));
 	}
@@ -1254,7 +1295,9 @@
 	}
 	/* check for excessive collision irq */
 	if (irqbits & IO_STATE(R_IRQ_MASK0_RD, excessive_col, active)) { 
-		*R_NETWORK_TR_CTRL = IO_STATE(R_NETWORK_TR_CTRL, clr_error,
clr);
+		SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, clr_error,
clr);
+		*R_NETWORK_TR_CTRL = network_tr_ctrl_shadow;
+		SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, clr_error,
nop);
 		np->stats.tx_errors++;
 		D(printk("ethernet excessive collisions!\n"));
 	}
@@ -1419,30 +1462,30 @@
 			data->phy_id = mdio_phy_addr;
 			break;
 		case SIOCGMIIREG: /* Read MII register */
-			data->val_out = e100_get_mdio_reg(data->reg_num);
+			data->val_out = e100_get_mdio_reg(dev,
mdio_phy_addr, data->reg_num);
 			break;
 		case SIOCSMIIREG: /* Write MII register */
-			e100_set_mdio_reg(data->reg_num, data->val_in);
+			e100_set_mdio_reg(dev, mdio_phy_addr, data->reg_num,
data->val_in);
 			break;
 		/* The ioctls below should be considered obsolete but are */
 		/* still present for compatability with old scripts/apps  */

 		case SET_ETH_SPEED_10:                  /* 10 Mbps */
-			e100_set_speed(10);
+			e100_set_speed(dev, 10);
 			break;
 		case SET_ETH_SPEED_100:                /* 100 Mbps */
-			e100_set_speed(100);
+			e100_set_speed(dev, 100);
 			break;
 		case SET_ETH_SPEED_AUTO:              /* Auto negotiate
speed */
-			e100_set_speed(0);
+			e100_set_speed(dev, 0);
 			break;
 		case SET_ETH_DUPLEX_HALF:              /* Half duplex. */
-			e100_set_duplex(half);
+			e100_set_duplex(dev, half);
 			break;
 		case SET_ETH_DUPLEX_FULL:              /* Full duplex. */
-			e100_set_duplex(full);
+			e100_set_duplex(dev, full);
 			break;
 		case SET_ETH_DUPLEX_AUTO:             /* Autonegotiate
duplex*/
-			e100_set_duplex(autoneg);
+			e100_set_duplex(dev, autoneg);
 			break;
 		default:
 			return -EINVAL;
@@ -1498,11 +1541,11 @@
 				return -EPERM;
 			}
 			if (ecmd.autoneg == AUTONEG_ENABLE) {
-				e100_set_duplex(autoneg);
-				e100_set_speed(0);
+				e100_set_duplex(dev, autoneg);
+				e100_set_speed(dev, 0);
 			} else {
-				e100_set_duplex(ecmd.duplex == DUPLEX_HALF ?
half : full);
-				e100_set_speed(ecmd.speed == SPEED_10 ? 10:
100);
+				e100_set_duplex(dev, ecmd.duplex ==
DUPLEX_HALF ? half : full);
+				e100_set_speed(dev, ecmd.speed == SPEED_10 ?
10: 100);
 			}
 		}
 		break;
@@ -1511,7 +1554,7 @@
 			struct ethtool_drvinfo info;
 			memset((void *) &info, 0, sizeof (info));
 			strncpy(info.driver, "ETRAX 100LX",
sizeof(info.driver) - 1);
-			strncpy(info.version, "$Revision: 1.48 $",
sizeof(info.version) - 1);
+			strncpy(info.version, "$Revision: 1.52 $",
sizeof(info.version) - 1);
 			strncpy(info.fw_version, "N/A",
sizeof(info.fw_version) - 1);
 			strncpy(info.bus_info, "N/A", sizeof(info.bus_info)
- 1);
 			info.regdump_len = 0;
@@ -1523,7 +1566,7 @@
 		break;
 		case ETHTOOL_NWAY_RST:
 			if (current_duplex == autoneg &&
current_speed_selection == 0)
-				e100_negotiate();
+				e100_negotiate(dev);
 		break;
 		default:
 			return -EOPNOTSUPP;

