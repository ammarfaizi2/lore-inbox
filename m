Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbUKBNw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUKBNw1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 08:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUKBNw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:52:26 -0500
Received: from [212.209.10.221] ([212.209.10.221]:26580 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S262922AbUKBNFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:05:01 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: [PATCH 3/10] CRIS architecture update - Ethernet
Date: Tue, 2 Nov 2004 14:04:36 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C7487@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01D1_01C4C0E4.E3679770"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01D1_01C4C0E4.E3679770
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update ethernet driver to use generic mii interface.

Signed-Off-By: starvik@axis.com

/Mikael

------=_NextPart_000_01D1_01C4C0E4.E3679770
Content-Type: application/octet-stream;
	name="cris269_3.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cris269_3.patch"

diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/drivers/ethernet.c =
lx25/arch/cris/arch-v10/drivers/ethernet.c=0A=
--- ../linux/arch/cris/arch-v10/drivers/ethernet.c	Mon Oct 18 23:54:07 =
2004=0A=
+++ lx25/arch/cris/arch-v10/drivers/ethernet.c	Mon Oct 18 16:49:03 2004=0A=
@@ -1,4 +1,4 @@=0A=
-/* $Id: ethernet.c,v 1.22 2004/05/14 07:58:03 starvik Exp $=0A=
+/* $Id: ethernet.c,v 1.31 2004/10/18 14:49:03 starvik Exp $=0A=
  *=0A=
  * e100net.c: A network driver for the ETRAX 100LX network controller.=0A=
  *=0A=
@@ -7,6 +7,27 @@=0A=
  * The outline of this driver comes from skeleton.c.=0A=
  *=0A=
  * $Log: ethernet.c,v $=0A=
+ * Revision 1.31  2004/10/18 14:49:03  starvik=0A=
+ * Use RX interrupt as random source=0A=
+ *=0A=
+ * Revision 1.30  2004/09/29 10:44:04  starvik=0A=
+ * Enabed MAC-address output again=0A=
+ *=0A=
+ * Revision 1.29  2004/08/24 07:14:05  starvik=0A=
+ * Make use of generic MDIO interface and constants.=0A=
+ *=0A=
+ * Revision 1.28  2004/08/20 09:37:11  starvik=0A=
+ * Added support for Intel LXT972A. Creds to Randy Scarborough.=0A=
+ *=0A=
+ * Revision 1.27  2004/08/16 12:37:22  starvik=0A=
+ * Merge of Linux 2.6.8=0A=
+ *=0A=
+ * Revision 1.25  2004/06/21 10:29:57  starvik=0A=
+ * Merge of Linux 2.6.7=0A=
+ *=0A=
+ * Revision 1.23  2004/06/09 05:29:22  starvik=0A=
+ * Avoid any race where R_DMA_CH1_FIRST is NULL (may trigger cache bug).=0A=
+ *=0A=
  * Revision 1.22  2004/05/14 07:58:03  starvik=0A=
  * Merge of changes from 2.4=0A=
  *=0A=
@@ -252,6 +273,7 @@=0A=
 /* Information that need to be kept for each board. */=0A=
 struct net_local {=0A=
 	struct net_device_stats stats;=0A=
+	struct mii_if_info mii_if;=0A=
 =0A=
 	/* Tx control lock.  This protects the transmit buffer ring=0A=
 	 * state along with the "tx full" state of the driver.  This=0A=
@@ -271,8 +293,8 @@=0A=
 struct transceiver_ops=0A=
 {=0A=
 	unsigned int oui;=0A=
-	void (*check_speed)(void);=0A=
-	void (*check_duplex)(void);=0A=
+	void (*check_speed)(struct net_device* dev);=0A=
+	void (*check_duplex)(struct net_device* dev);=0A=
 };=0A=
 =0A=
 struct transceiver_ops* transceiver;=0A=
@@ -295,25 +317,6 @@=0A=
 /* =0A=
 ** MDIO constants.=0A=
 */=0A=
-#define MDIO_BASE_STATUS_REG                0x1=0A=
-#define MDIO_BASE_CONTROL_REG               0x0=0A=
-#define MDIO_PHY_ID_HIGH_REG                0x2=0A=
-#define MDIO_PHY_ID_LOW_REG                 0x3=0A=
-#define MDIO_BC_NEGOTIATE                0x0200=0A=
-#define MDIO_BC_FULL_DUPLEX_MASK         0x0100=0A=
-#define MDIO_BC_AUTO_NEG_MASK            0x1000=0A=
-#define MDIO_BC_SPEED_SELECT_MASK        0x2000=0A=
-#define MDIO_STATUS_100_FD               0x4000=0A=
-#define MDIO_STATUS_100_HD               0x2000=0A=
-#define MDIO_STATUS_10_FD                0x1000=0A=
-#define MDIO_STATUS_10_HD                0x0800=0A=
-#define MDIO_STATUS_SPEED_DUPLEX_MASK	 0x7800=0A=
-#define MDIO_ADVERTISMENT_REG               0x4=0A=
-#define MDIO_ADVERT_100_FD                0x100=0A=
-#define MDIO_ADVERT_100_HD                0x080=0A=
-#define MDIO_ADVERT_10_FD                 0x040=0A=
-#define MDIO_ADVERT_10_HD                 0x020=0A=
-#define MDIO_LINK_UP_MASK                   0x4=0A=
 #define MDIO_START                          0x1=0A=
 #define MDIO_READ                           0x2=0A=
 #define MDIO_WRITE                          0x1=0A=
@@ -329,6 +332,11 @@=0A=
 #define MDIO_TDK_DIAGNOSTIC_RATE          0x400=0A=
 #define MDIO_TDK_DIAGNOSTIC_DPLX          0x800=0A=
 =0A=
+/*Intel LXT972A specific*/=0A=
+#define MDIO_INT_STATUS_REG_2			0x0011=0A=
+#define MDIO_INT_FULL_DUPLEX_IND		( 1 << 9 )=0A=
+#define MDIO_INT_SPEED				( 1 << 14 )=0A=
+=0A=
 /* Network flash constants */=0A=
 #define NET_FLASH_TIME                  (HZ/50) /* 20 ms */=0A=
 #define NET_FLASH_PAUSE                (HZ/100) /* 10 ms */=0A=
@@ -409,36 +417,40 @@=0A=
 static void e100_hardware_send_packet(char *buf, int length);=0A=
 static void update_rx_stats(struct net_device_stats *);=0A=
 static void update_tx_stats(struct net_device_stats *);=0A=
-static int e100_probe_transceiver(void);=0A=
+static int e100_probe_transceiver(struct net_device* dev);=0A=
+=0A=
+static void e100_check_speed(unsigned long priv);=0A=
+static void e100_set_speed(struct net_device* dev, unsigned long speed);=0A=
+static void e100_check_duplex(unsigned long priv);=0A=
+static void e100_set_duplex(struct net_device* dev, enum duplex);=0A=
+static void e100_negotiate(struct net_device* dev);=0A=
 =0A=
-static void e100_check_speed(unsigned long dummy);=0A=
-static void e100_set_speed(unsigned long speed);=0A=
-static void e100_check_duplex(unsigned long dummy);=0A=
-static void e100_set_duplex(enum duplex);=0A=
-static void e100_negotiate(void);=0A=
+static int e100_get_mdio_reg(struct net_device *dev, int phy_id, int =
location);=0A=
+static void e100_set_mdio_reg(struct net_device *dev, int phy_id, int =
location, int value);=0A=
 =0A=
-static unsigned short e100_get_mdio_reg(unsigned char reg_num);=0A=
-static void e100_set_mdio_reg(unsigned char reg, unsigned short data);=0A=
 static void e100_send_mdio_cmd(unsigned short cmd, int write_cmd);=0A=
 static void e100_send_mdio_bit(unsigned char bit);=0A=
 static unsigned char e100_receive_mdio_bit(void);=0A=
-static void e100_reset_transceiver(void);=0A=
+static void e100_reset_transceiver(struct net_device* net);=0A=
 =0A=
 static void e100_clear_network_leds(unsigned long dummy);=0A=
 static void e100_set_network_leds(int active);=0A=
 =0A=
-static void broadcom_check_speed(void);=0A=
-static void broadcom_check_duplex(void);=0A=
-static void tdk_check_speed(void);=0A=
-static void tdk_check_duplex(void);=0A=
-static void generic_check_speed(void);=0A=
-static void generic_check_duplex(void);=0A=
+static void broadcom_check_speed(struct net_device* dev);=0A=
+static void broadcom_check_duplex(struct net_device* dev);=0A=
+static void tdk_check_speed(struct net_device* dev);=0A=
+static void tdk_check_duplex(struct net_device* dev);=0A=
+static void intel_check_speed(struct net_device* dev);=0A=
+static void intel_check_duplex(struct net_device* dev);=0A=
+static void generic_check_speed(struct net_device* dev);=0A=
+static void generic_check_duplex(struct net_device* dev);=0A=
 =0A=
-struct transceiver_ops transceivers[] =3D=0A=
+struct transceiver_ops transceivers[] =3D =0A=
 {=0A=
 	{0x1018, broadcom_check_speed, broadcom_check_duplex},  /* Broadcom */=0A=
 	{0xC039, tdk_check_speed, tdk_check_duplex},            /* TDK 2120 */=0A=
 	{0x039C, tdk_check_speed, tdk_check_duplex},            /* TDK 2120C */=0A=
+        {0x04de, intel_check_speed, intel_check_duplex},     	/* Intel =
LXT972A*/=0A=
 	{0x0000, generic_check_speed, generic_check_duplex}     /* Generic, =
must be last */=0A=
 };=0A=
 =0A=
@@ -456,12 +468,15 @@=0A=
 etrax_ethernet_init(void)=0A=
 {=0A=
 	struct net_device *dev;=0A=
+        struct net_local* np;=0A=
 	int i, err;=0A=
 =0A=
-	printk(KERN_INFO=0A=
+	printk(KERN_INFO =0A=
 	       "ETRAX 100LX 10/100MBit ethernet v2.0 (c) 2000-2003 Axis =
Communications AB\n");=0A=
 =0A=
 	dev =3D alloc_etherdev(sizeof(struct net_local));=0A=
+	np =3D dev->priv;=0A=
+=0A=
 	if (!dev)=0A=
 		return -ENOMEM;=0A=
 =0A=
@@ -545,6 +560,7 @@=0A=
 	current_speed =3D 10;=0A=
 	current_speed_selection =3D 0; /* Auto */=0A=
 	speed_timer.expires =3D jiffies + NET_LINK_UP_CHECK_INTERVAL;=0A=
+        duplex_timer.data =3D (unsigned long)dev;=0A=
 	speed_timer.function =3D e100_check_speed;=0A=
         =0A=
 	clear_led_timer.function =3D e100_clear_network_leds;=0A=
@@ -552,8 +568,17 @@=0A=
 	full_duplex =3D 0;=0A=
 	current_duplex =3D autoneg;=0A=
 	duplex_timer.expires =3D jiffies + NET_DUPLEX_CHECK_INTERVAL;		=0A=
+        duplex_timer.data =3D (unsigned long)dev;=0A=
 	duplex_timer.function =3D e100_check_duplex;=0A=
 =0A=
+        /* Initialize mii interface */=0A=
+	np->mii_if.phy_id =3D mdio_phy_addr;=0A=
+	np->mii_if.phy_id_mask =3D 0x1f;=0A=
+	np->mii_if.reg_num_mask =3D 0x1f;=0A=
+	np->mii_if.dev =3D dev;=0A=
+	np->mii_if.mdio_read =3D e100_get_mdio_reg;=0A=
+	np->mii_if.mdio_write =3D e100_set_mdio_reg;=0A=
+=0A=
 	/* Initialize group address registers to make sure that no */=0A=
 	/* unwanted addresses are matched */=0A=
 	*R_NETWORK_GA_0 =3D 0x00000000;=0A=
@@ -644,8 +669,8 @@=0A=
 =0A=
 	/* allocate the irq corresponding to the receiving DMA */=0A=
 =0A=
-	if (request_irq(NETWORK_DMA_RX_IRQ_NBR, e100rxtx_interrupt, 0,=0A=
-			cardname, (void *)dev)) {=0A=
+	if (request_irq(NETWORK_DMA_RX_IRQ_NBR, e100rxtx_interrupt, =0A=
+			SA_SAMPLE_RANDOM, cardname, (void *)dev)) {=0A=
 		goto grace_exit0;=0A=
 	}=0A=
 =0A=
@@ -733,7 +758,7 @@=0A=
 	restore_flags(flags);=0A=
 	=0A=
 	/* Probe for transceiver */=0A=
-	if (e100_probe_transceiver())=0A=
+	if (e100_probe_transceiver(dev))=0A=
 		goto grace_exit3;=0A=
 =0A=
 	/* Start duplex/speed timers */=0A=
@@ -759,45 +784,54 @@=0A=
 =0A=
 =0A=
 static void=0A=
-generic_check_speed(void)=0A=
+generic_check_speed(struct net_device* dev)=0A=
 {=0A=
 	unsigned long data;=0A=
-	data =3D e100_get_mdio_reg(MDIO_ADVERTISMENT_REG);=0A=
-	if ((data & MDIO_ADVERT_100_FD) ||=0A=
-	    (data & MDIO_ADVERT_100_HD))=0A=
+	data =3D e100_get_mdio_reg(dev, mdio_phy_addr, MII_ADVERTISE);=0A=
+	if ((data & ADVERTISE_100FULL) ||=0A=
+	    (data & ADVERTISE_100HALF))=0A=
 		current_speed =3D 100;=0A=
 	else=0A=
 		current_speed =3D 10;=0A=
 }=0A=
 =0A=
 static void=0A=
-tdk_check_speed(void)=0A=
+tdk_check_speed(struct net_device* dev)=0A=
 {=0A=
 	unsigned long data;=0A=
-	data =3D e100_get_mdio_reg(MDIO_TDK_DIAGNOSTIC_REG);=0A=
+	data =3D e100_get_mdio_reg(dev, mdio_phy_addr, =
MDIO_TDK_DIAGNOSTIC_REG);=0A=
 	current_speed =3D (data & MDIO_TDK_DIAGNOSTIC_RATE ? 100 : 10);=0A=
 }=0A=
 =0A=
 static void=0A=
-broadcom_check_speed(void)=0A=
+broadcom_check_speed(struct net_device* dev)=0A=
 {=0A=
 	unsigned long data;=0A=
-	data =3D e100_get_mdio_reg(MDIO_AUX_CTRL_STATUS_REG);=0A=
+	data =3D e100_get_mdio_reg(dev, mdio_phy_addr, =
MDIO_AUX_CTRL_STATUS_REG);=0A=
 	current_speed =3D (data & MDIO_BC_SPEED ? 100 : 10);=0A=
 }=0A=
 =0A=
 static void=0A=
-e100_check_speed(unsigned long dummy)=0A=
+intel_check_speed(struct net_device* dev)=0A=
+{=0A=
+	unsigned long data;=0A=
+	data =3D e100_get_mdio_reg(dev, mdio_phy_addr, MDIO_INT_STATUS_REG_2);=0A=
+	current_speed =3D (data & MDIO_INT_SPEED ? 100 : 10);=0A=
+}=0A=
+=0A=
+static void=0A=
+e100_check_speed(unsigned long priv)=0A=
 {=0A=
+	struct net_device* dev =3D (struct net_device*)priv;=0A=
 	static int led_initiated =3D 0;=0A=
 	unsigned long data;=0A=
 	int old_speed =3D current_speed;=0A=
 =0A=
-	data =3D e100_get_mdio_reg(MDIO_BASE_STATUS_REG);=0A=
-	if (!(data & MDIO_LINK_UP_MASK)) {=0A=
+	data =3D e100_get_mdio_reg(dev, mdio_phy_addr, MII_BMSR);=0A=
+	if (!(data & BMSR_LSTATUS)) {=0A=
 		current_speed =3D 0;=0A=
 	} else {=0A=
-		transceiver->check_speed();=0A=
+		transceiver->check_speed(dev);=0A=
 	}=0A=
 	=0A=
 	if ((old_speed !=3D current_speed) || !led_initiated) {=0A=
@@ -811,71 +845,74 @@=0A=
 }=0A=
 =0A=
 static void=0A=
-e100_negotiate(void)=0A=
+e100_negotiate(struct net_device* dev)=0A=
 {=0A=
-	unsigned short data =3D e100_get_mdio_reg(MDIO_ADVERTISMENT_REG);=0A=
+	unsigned short data =3D e100_get_mdio_reg(dev, mdio_phy_addr, =
MII_ADVERTISE);=0A=
 =0A=
 	/* Discard old speed and duplex settings */=0A=
-	data &=3D ~(MDIO_ADVERT_100_HD | MDIO_ADVERT_100_FD | =0A=
-	          MDIO_ADVERT_10_FD | MDIO_ADVERT_10_HD);=0A=
+	data &=3D ~(ADVERTISE_100HALF | ADVERTISE_100FULL | =0A=
+	          ADVERTISE_10HALF | ADVERTISE_10FULL);=0A=
   =0A=
 	switch (current_speed_selection) {=0A=
 		case 10 :=0A=
 			if (current_duplex =3D=3D full)=0A=
-				data |=3D MDIO_ADVERT_10_FD;=0A=
+				data |=3D ADVERTISE_10FULL;=0A=
 			else if (current_duplex =3D=3D half)=0A=
-				data |=3D MDIO_ADVERT_10_HD;=0A=
+				data |=3D ADVERTISE_10HALF;=0A=
 			else=0A=
-				data |=3D MDIO_ADVERT_10_HD |  MDIO_ADVERT_10_FD;=0A=
+				data |=3D ADVERTISE_10HALF | ADVERTISE_10FULL;=0A=
 			break;=0A=
 =0A=
 		case 100 :=0A=
 			 if (current_duplex =3D=3D full)=0A=
-				data |=3D MDIO_ADVERT_100_FD;=0A=
+				data |=3D ADVERTISE_100FULL;=0A=
 			else if (current_duplex =3D=3D half)=0A=
-				data |=3D MDIO_ADVERT_100_HD;=0A=
+				data |=3D ADVERTISE_100HALF;=0A=
 			else=0A=
-				data |=3D MDIO_ADVERT_100_HD |  MDIO_ADVERT_100_FD;=0A=
+				data |=3D ADVERTISE_100HALF | ADVERTISE_100FULL;=0A=
 			break;=0A=
 =0A=
 		case 0 : /* Auto */=0A=
 			 if (current_duplex =3D=3D full)=0A=
-				data |=3D MDIO_ADVERT_100_FD | MDIO_ADVERT_10_FD;=0A=
+				data |=3D ADVERTISE_100FULL | ADVERTISE_10FULL;=0A=
 			else if (current_duplex =3D=3D half)=0A=
-				data |=3D MDIO_ADVERT_100_HD | MDIO_ADVERT_10_HD;=0A=
+				data |=3D ADVERTISE_100HALF | ADVERTISE_10HALF;=0A=
 			else=0A=
-				data |=3D MDIO_ADVERT_100_HD | MDIO_ADVERT_100_FD | =
MDIO_ADVERT_10_FD | MDIO_ADVERT_10_HD;=0A=
+				data |=3D ADVERTISE_10HALF | ADVERTISE_10FULL |=0A=
+				  ADVERTISE_100HALF | ADVERTISE_100FULL;=0A=
 			break;=0A=
 =0A=
 		default : /* assume autoneg speed and duplex */=0A=
-			data |=3D MDIO_ADVERT_100_HD | MDIO_ADVERT_100_FD | =0A=
-			        MDIO_ADVERT_10_FD | MDIO_ADVERT_10_HD;=0A=
+			data |=3D ADVERTISE_10HALF | ADVERTISE_10FULL |=0A=
+				  ADVERTISE_100HALF | ADVERTISE_100FULL;=0A=
 	}=0A=
 =0A=
-	e100_set_mdio_reg(MDIO_ADVERTISMENT_REG, data);=0A=
+	e100_set_mdio_reg(dev, mdio_phy_addr, MII_ADVERTISE, data);=0A=
 =0A=
 	/* Renegotiate with link partner */=0A=
-	data =3D e100_get_mdio_reg(MDIO_BASE_CONTROL_REG);=0A=
-	data |=3D MDIO_BC_NEGOTIATE;=0A=
+	data =3D e100_get_mdio_reg(dev, mdio_phy_addr, MII_BMCR);=0A=
+	data |=3D BMCR_ANENABLE | BMCR_ANRESTART;=0A=
 =0A=
-	e100_set_mdio_reg(MDIO_BASE_CONTROL_REG, data);=0A=
+	e100_set_mdio_reg(dev, mdio_phy_addr, MII_BMCR, data);=0A=
 }=0A=
 =0A=
 static void=0A=
-e100_set_speed(unsigned long speed)=0A=
+e100_set_speed(struct net_device* dev, unsigned long speed)=0A=
 {=0A=
 	if (speed !=3D current_speed_selection) {=0A=
 		current_speed_selection =3D speed;=0A=
-		e100_negotiate();=0A=
+		e100_negotiate(dev);=0A=
 	}=0A=
 }=0A=
 =0A=
 static void=0A=
-e100_check_duplex(unsigned long dummy)=0A=
+e100_check_duplex(unsigned long priv)=0A=
 {=0A=
+	struct net_device *dev =3D (struct net_device *)priv;=0A=
+	struct net_local *np =3D (struct net_local *)dev->priv;=0A=
 	int old_duplex =3D full_duplex;=0A=
-	transceiver->check_duplex();=0A=
-	if (old_duplex !=3D full_duplex) {=0A=
+	transceiver->check_duplex(dev);=0A=
+	if (old_duplex !=3D full_duplex) { =0A=
 		/* Duplex changed */=0A=
 		SETF(network_rec_config_shadow, R_NETWORK_REC_CONFIG, duplex, =
full_duplex);=0A=
 		*R_NETWORK_REC_CONFIG =3D network_rec_config_shadow;=0A=
@@ -884,47 +921,56 @@=0A=
 	/* Reinitialize the timer. */=0A=
 	duplex_timer.expires =3D jiffies + NET_DUPLEX_CHECK_INTERVAL;=0A=
 	add_timer(&duplex_timer);=0A=
+	np->mii_if.full_duplex =3D full_duplex;=0A=
 }=0A=
 =0A=
 static void=0A=
-generic_check_duplex(void)=0A=
+generic_check_duplex(struct net_device* dev)=0A=
 {=0A=
 	unsigned long data;=0A=
-	data =3D e100_get_mdio_reg(MDIO_ADVERTISMENT_REG);=0A=
-	if ((data & MDIO_ADVERT_100_FD) ||=0A=
-	    (data & MDIO_ADVERT_10_FD))=0A=
+	data =3D e100_get_mdio_reg(dev, mdio_phy_addr, MII_ADVERTISE);=0A=
+	if ((data & ADVERTISE_10FULL) ||=0A=
+	    (data & ADVERTISE_100FULL))=0A=
 		full_duplex =3D 1;=0A=
 	else=0A=
 		full_duplex =3D 0;=0A=
 }=0A=
 =0A=
 static void=0A=
-tdk_check_duplex(void)=0A=
+tdk_check_duplex(struct net_device* dev)=0A=
 {=0A=
 	unsigned long data;=0A=
-	data =3D e100_get_mdio_reg(MDIO_TDK_DIAGNOSTIC_REG);=0A=
+	data =3D e100_get_mdio_reg(dev, mdio_phy_addr, =
MDIO_TDK_DIAGNOSTIC_REG);=0A=
 	full_duplex =3D (data & MDIO_TDK_DIAGNOSTIC_DPLX) ? 1 : 0;=0A=
 }=0A=
 =0A=
 static void=0A=
-broadcom_check_duplex(void)=0A=
+broadcom_check_duplex(struct net_device* dev)=0A=
 {=0A=
 	unsigned long data;=0A=
-	data =3D e100_get_mdio_reg(MDIO_AUX_CTRL_STATUS_REG);=0A=
+	data =3D e100_get_mdio_reg(dev, mdio_phy_addr, =
MDIO_AUX_CTRL_STATUS_REG);        =0A=
 	full_duplex =3D (data & MDIO_BC_FULL_DUPLEX_IND) ? 1 : 0;=0A=
 }=0A=
 =0A=
+static void=0A=
+intel_check_duplex(struct net_device* dev)=0A=
+{=0A=
+	unsigned long data;=0A=
+	data =3D e100_get_mdio_reg(dev, mdio_phy_addr, MDIO_INT_STATUS_REG_2); =
       =0A=
+	full_duplex =3D (data & MDIO_INT_FULL_DUPLEX_IND) ? 1 : 0;=0A=
+}=0A=
+=0A=
 static void =0A=
-e100_set_duplex(enum duplex new_duplex)=0A=
+e100_set_duplex(struct net_device* dev, enum duplex new_duplex)=0A=
 {=0A=
 	if (new_duplex !=3D current_duplex) {=0A=
 		current_duplex =3D new_duplex;=0A=
-		e100_negotiate();=0A=
+		e100_negotiate(dev);=0A=
 	}=0A=
 }=0A=
 =0A=
-static int=0A=
-e100_probe_transceiver(void)=0A=
+static int =0A=
+e100_probe_transceiver(struct net_device* dev)=0A=
 {=0A=
 	unsigned int phyid_high;=0A=
 	unsigned int phyid_low;=0A=
@@ -933,17 +979,17 @@=0A=
 =0A=
 	/* Probe MDIO physical address */=0A=
 	for (mdio_phy_addr =3D 0; mdio_phy_addr <=3D 31; mdio_phy_addr++) {=0A=
-		if (e100_get_mdio_reg(MDIO_BASE_STATUS_REG) !=3D 0xffff)=0A=
+		if (e100_get_mdio_reg(dev, mdio_phy_addr, MII_BMSR) !=3D 0xffff)=0A=
 			break;=0A=
 	}=0A=
 	if (mdio_phy_addr =3D=3D 32)=0A=
 		 return -ENODEV;=0A=
 =0A=
 	/* Get manufacturer */=0A=
-	phyid_high =3D e100_get_mdio_reg(MDIO_PHY_ID_HIGH_REG);=0A=
-	phyid_low =3D e100_get_mdio_reg(MDIO_PHY_ID_LOW_REG);=0A=
+	phyid_high =3D e100_get_mdio_reg(dev, mdio_phy_addr, MII_PHYSID1);=0A=
+	phyid_low =3D e100_get_mdio_reg(dev, mdio_phy_addr, MII_PHYSID2);=0A=
 	oui =3D (phyid_high << 6) | (phyid_low >> 10);=0A=
-=0A=
+	=0A=
 	for (ops =3D &transceivers[0]; ops->oui; ops++) {=0A=
 		if (ops->oui =3D=3D oui)=0A=
 			break;=0A=
@@ -953,16 +999,16 @@=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-static unsigned short=0A=
-e100_get_mdio_reg(unsigned char reg_num)=0A=
+static int=0A=
+e100_get_mdio_reg(struct net_device *dev, int phy_id, int location)=0A=
 {=0A=
 	unsigned short cmd;    /* Data to be sent on MDIO port */=0A=
-	unsigned short data;   /* Data read from MDIO */=0A=
+	int data;   /* Data read from MDIO */=0A=
 	int bitCounter;=0A=
 	=0A=
 	/* Start of frame, OP Code, Physical Address, Register Address */=0A=
-	cmd =3D (MDIO_START << 14) | (MDIO_READ << 12) | (mdio_phy_addr << 7) |=0A=
-		(reg_num << 2);=0A=
+	cmd =3D (MDIO_START << 14) | (MDIO_READ << 12) | (phy_id << 7) |=0A=
+		(location << 2);=0A=
 	=0A=
 	e100_send_mdio_cmd(cmd, 0);=0A=
 	=0A=
@@ -977,19 +1023,19 @@=0A=
 }=0A=
 =0A=
 static void=0A=
-e100_set_mdio_reg(unsigned char reg, unsigned short data)=0A=
+e100_set_mdio_reg(struct net_device *dev, int phy_id, int location, int =
value)=0A=
 {=0A=
 	int bitCounter;=0A=
 	unsigned short cmd;=0A=
 =0A=
-	cmd =3D (MDIO_START << 14) | (MDIO_WRITE << 12) | (mdio_phy_addr << 7) =
|=0A=
-	      (reg << 2);=0A=
+	cmd =3D (MDIO_START << 14) | (MDIO_WRITE << 12) | (phy_id << 7) |=0A=
+	      (location << 2);=0A=
 =0A=
 	e100_send_mdio_cmd(cmd, 1);=0A=
 =0A=
 	/* Data... */=0A=
 	for (bitCounter=3D15; bitCounter>=3D0 ; bitCounter--) {=0A=
-		e100_send_mdio_bit(GET_BIT(bitCounter, data));=0A=
+		e100_send_mdio_bit(GET_BIT(bitCounter, value));=0A=
 	}=0A=
 =0A=
 }=0A=
@@ -1042,15 +1088,15 @@=0A=
 }=0A=
 =0A=
 static void =0A=
-e100_reset_transceiver(void)=0A=
+e100_reset_transceiver(struct net_device* dev)=0A=
 {=0A=
 	unsigned short cmd;=0A=
 	unsigned short data;=0A=
 	int bitCounter;=0A=
 =0A=
-	data =3D e100_get_mdio_reg(MDIO_BASE_CONTROL_REG);=0A=
+	data =3D e100_get_mdio_reg(dev, mdio_phy_addr, MII_BMCR);=0A=
 =0A=
-	cmd =3D (MDIO_START << 14) | (MDIO_WRITE << 12) | (mdio_phy_addr << 7) =
| (MDIO_BASE_CONTROL_REG << 2);=0A=
+	cmd =3D (MDIO_START << 14) | (MDIO_WRITE << 12) | (mdio_phy_addr << 7) =
| (MII_BMCR << 2);=0A=
 =0A=
 	e100_send_mdio_cmd(cmd, 1);=0A=
 	=0A=
@@ -1087,7 +1133,7 @@=0A=
 	=0A=
 	/* Reset the transceiver. */=0A=
 	=0A=
-	e100_reset_transceiver();=0A=
+	e100_reset_transceiver(dev);=0A=
 	=0A=
 	/* and get rid of the packets that never got an interrupt */=0A=
 	while (myFirstTxDesc !=3D myNextTxDesc)=0A=
@@ -1157,7 +1203,7 @@=0A=
 	unsigned long irqbits =3D *R_IRQ_MASK2_RD;=0A=
  =0A=
 	/* Disable RX/TX IRQs to avoid reentrancy */=0A=
-	*R_IRQ_MASK2_CLR =3D=0A=
+	*R_IRQ_MASK2_CLR =3D =0A=
 	  IO_STATE(R_IRQ_MASK2_CLR, dma0_eop, clr) |=0A=
 	  IO_STATE(R_IRQ_MASK2_CLR, dma1_eop, clr);=0A=
 =0A=
@@ -1169,7 +1215,8 @@=0A=
 =0A=
 		/* check if one or more complete packets were indeed received */=0A=
 =0A=
-		while (*R_DMA_CH1_FIRST !=3D virt_to_phys(myNextRxDesc)) {=0A=
+		while ((*R_DMA_CH1_FIRST !=3D virt_to_phys(myNextRxDesc)) &&=0A=
+		       (myNextRxDesc !=3D myLastRxDesc)) {=0A=
 			/* Take out the buffer and give it to the OS, then=0A=
 			 * allocate a new buffer to put a packet in.=0A=
 			 */=0A=
@@ -1208,7 +1255,7 @@=0A=
 	}=0A=
 =0A=
 	/* Enable RX/TX IRQs again */=0A=
-	*R_IRQ_MASK2_SET =3D=0A=
+	*R_IRQ_MASK2_SET =3D =0A=
 	  IO_STATE(R_IRQ_MASK2_SET, dma0_eop, set) |=0A=
 	  IO_STATE(R_IRQ_MASK2_SET, dma1_eop, set);=0A=
 =0A=
@@ -1224,7 +1271,7 @@=0A=
 =0A=
 	/* check for underrun irq */=0A=
 	if (irqbits & IO_STATE(R_IRQ_MASK0_RD, underrun, active)) { =0A=
-		SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, clr_error, clr);=0A=
+		SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, clr_error, clr);	=0A=
 		*R_NETWORK_TR_CTRL =3D network_tr_ctrl_shadow;=0A=
 		SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, clr_error, nop);=0A=
 		np->stats.tx_errors++;=0A=
@@ -1238,7 +1285,7 @@=0A=
 	}=0A=
 	/* check for excessive collision irq */=0A=
 	if (irqbits & IO_STATE(R_IRQ_MASK0_RD, excessive_col, active)) { =0A=
-		SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, clr_error, clr);=0A=
+		SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, clr_error, clr);	=0A=
 		*R_NETWORK_TR_CTRL =3D network_tr_ctrl_shadow;=0A=
 		SETS(network_tr_ctrl_shadow, R_NETWORK_TR_CTRL, clr_error, nop);=0A=
 		*R_NETWORK_TR_CTRL =3D IO_STATE(R_NETWORK_TR_CTRL, clr_error, clr);=0A=
@@ -1407,30 +1454,30 @@=0A=
 			data->phy_id =3D mdio_phy_addr;=0A=
 			break;=0A=
 		case SIOCGMIIREG: /* Read MII register */=0A=
-			data->val_out =3D e100_get_mdio_reg(data->reg_num);=0A=
+			data->val_out =3D e100_get_mdio_reg(dev, mdio_phy_addr, =
data->reg_num);=0A=
 			break;=0A=
 		case SIOCSMIIREG: /* Write MII register */=0A=
-			e100_set_mdio_reg(data->reg_num, data->val_in);=0A=
+			e100_set_mdio_reg(dev, mdio_phy_addr, data->reg_num, data->val_in);=0A=
 			break;=0A=
 		/* The ioctls below should be considered obsolete but are */=0A=
 		/* still present for compatability with old scripts/apps  */	=0A=
 		case SET_ETH_SPEED_10:                  /* 10 Mbps */=0A=
-			e100_set_speed(10);=0A=
+			e100_set_speed(dev, 10);=0A=
 			break;=0A=
 		case SET_ETH_SPEED_100:                /* 100 Mbps */=0A=
-			e100_set_speed(100);=0A=
+			e100_set_speed(dev, 100);=0A=
 			break;=0A=
 		case SET_ETH_SPEED_AUTO:              /* Auto negotiate speed */=0A=
-			e100_set_speed(0);=0A=
+			e100_set_speed(dev, 0);=0A=
 			break;=0A=
 		case SET_ETH_DUPLEX_HALF:              /* Half duplex. */=0A=
-			e100_set_duplex(half);=0A=
+			e100_set_duplex(dev, half);=0A=
 			break;=0A=
 		case SET_ETH_DUPLEX_FULL:              /* Full duplex. */=0A=
-			e100_set_duplex(full);=0A=
+			e100_set_duplex(dev, full);=0A=
 			break;=0A=
 		case SET_ETH_DUPLEX_AUTO:             /* Autonegotiate duplex*/=0A=
-			e100_set_duplex(autoneg);=0A=
+			e100_set_duplex(dev, autoneg);=0A=
 			break;=0A=
 		default:=0A=
 			return -EINVAL;=0A=
@@ -1487,11 +1534,11 @@=0A=
 				return -EPERM;=0A=
 			}=0A=
 			if (ecmd.autoneg =3D=3D AUTONEG_ENABLE) {=0A=
-				e100_set_duplex(autoneg);=0A=
-				e100_set_speed(0);=0A=
+				e100_set_duplex(dev, autoneg);=0A=
+				e100_set_speed(dev, 0);=0A=
 			} else {=0A=
-				e100_set_duplex(ecmd.duplex =3D=3D DUPLEX_HALF ? half : full);=0A=
-				e100_set_speed(ecmd.speed =3D=3D SPEED_10 ? 10: 100);=0A=
+				e100_set_duplex(dev, ecmd.duplex =3D=3D DUPLEX_HALF ? half : full);=0A=
+				e100_set_speed(dev, ecmd.speed =3D=3D SPEED_10 ? 10: 100);=0A=
 			}=0A=
 		}=0A=
 		break;=0A=
@@ -1500,7 +1547,7 @@=0A=
 			struct ethtool_drvinfo info;=0A=
 			memset((void *) &info, 0, sizeof (info));=0A=
 			strncpy(info.driver, "ETRAX 100LX", sizeof(info.driver) - 1);=0A=
-			strncpy(info.version, "$Revision: 1.22 $", sizeof(info.version) - 1);=0A=
+			strncpy(info.version, "$Revision: 1.31 $", sizeof(info.version) - 1);=0A=
 			strncpy(info.fw_version, "N/A", sizeof(info.fw_version) - 1);=0A=
 			strncpy(info.bus_info, "N/A", sizeof(info.bus_info) - 1);=0A=
 			info.regdump_len =3D 0;=0A=
@@ -1512,7 +1559,7 @@=0A=
 		break;=0A=
 		case ETHTOOL_NWAY_RST:=0A=
 			if (current_duplex =3D=3D autoneg && current_speed_selection =3D=3D =
0)=0A=
-				e100_negotiate();=0A=
+				e100_negotiate(dev);=0A=
 		break;=0A=
 		default:=0A=
 			return -EOPNOTSUPP;=0A=
@@ -1530,17 +1577,17 @@=0A=
 	switch(map->port) {=0A=
 		case IF_PORT_UNKNOWN:=0A=
 			/* Use autoneg */=0A=
-			e100_set_speed(0);=0A=
-			e100_set_duplex(autoneg);=0A=
+			e100_set_speed(dev, 0);=0A=
+			e100_set_duplex(dev, autoneg);=0A=
 			break;=0A=
 		case IF_PORT_10BASET:=0A=
-			e100_set_speed(10);=0A=
-			e100_set_duplex(autoneg);=0A=
+			e100_set_speed(dev, 10);=0A=
+			e100_set_duplex(dev, autoneg);=0A=
 			break;=0A=
 		case IF_PORT_100BASET:=0A=
 		case IF_PORT_100BASETX:=0A=
-			e100_set_speed(100);=0A=
-			e100_set_duplex(autoneg);=0A=
+			e100_set_speed(dev, 100);=0A=
+			e100_set_duplex(dev, autoneg);=0A=
 			break;=0A=
 		case IF_PORT_100BASEFX:=0A=
 		case IF_PORT_10BASE2:=0A=
@@ -1742,9 +1789,9 @@=0A=
 		/* Make LED red, link is down */=0A=
 #if defined(CONFIG_ETRAX_NETWORK_RED_ON_NO_CONNECTION)=0A=
 		LED_NETWORK_SET(LED_RED);=0A=
-#else=0A=
+#else		=0A=
 		LED_NETWORK_SET(LED_OFF);=0A=
-#endif=0A=
+#endif		=0A=
 	}=0A=
 	else if (light_leds) {=0A=
 		if (current_speed =3D=3D 10) {=0A=
@@ -1778,7 +1825,7 @@=0A=
 			return 0;=0A=
 		}=0A=
 		sa.sa_data[i] =3D (char)tmp;=0A=
-	}=0A=
+	}	=0A=
 =0A=
 	default_mac =3D sa;=0A=
 	return 1;=0A=

------=_NextPart_000_01D1_01C4C0E4.E3679770--

