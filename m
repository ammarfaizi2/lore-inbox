Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272878AbRIMXWr>; Thu, 13 Sep 2001 19:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272847AbRIMXWm>; Thu, 13 Sep 2001 19:22:42 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:8387 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S272901AbRIMXVc>;
	Thu, 13 Sep 2001 19:21:32 -0400
Date: Thu, 13 Sep 2001 16:21:51 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [IrDA patch] ir249_hw_name.diff
Message-ID: <20010913162151.H7470@bougret.hpl.hp.com>
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

ir249_hw_name.diff :
------------------
	<Patch has been around for 6 months, I keep updating with new drivers>
	<Hard dependency on ir249_irda-usb_reorg.diff>
	o [FEATURE] Show net-device name in /proc/net/irda/irlap
		- Allow user to match /proc info with output of ifconfig
	o [FEATURE] Show hardware name and port in /proc/net/irda/irlap
		- Allow user to match /proc info to real IrDA dongle hw

diff -u -p linux/include/net/irda/irlap.j2.h linux/include/net/irda/irlap.h
--- linux/include/net/irda/irlap.j2.h	Thu Sep 13 14:23:48 2001
+++ linux/include/net/irda/irlap.h	Thu Sep 13 14:28:01 2001
@@ -66,7 +66,9 @@ struct irlap_cb {
 	irda_queue_t q;     /* Must be first */
 	magic_t magic;
 
+	/* Device we are attached to */
 	struct net_device  *netdev;
+	char		hw_name[2*IFNAMSIZ + 1];
 
 	/* Connection state */
 	volatile IRLAP_STATE state;       /* Current state */
@@ -163,7 +165,8 @@ extern hashbin_t *irlap;
 int irlap_init(void);
 void irlap_cleanup(void);
 
-struct irlap_cb *irlap_open(struct net_device *dev, struct qos_info *qos);
+struct irlap_cb *irlap_open(struct net_device *dev, struct qos_info *qos,
+			    char *	hw_name);
 void irlap_close(struct irlap_cb *self);
 
 void irlap_connect_request(struct irlap_cb *self, __u32 daddr, 
diff -u -p linux/net/irda/irlap.j2.c linux/net/irda/irlap.c
--- linux/net/irda/irlap.j2.c	Thu Sep 13 14:25:15 2001
+++ linux/net/irda/irlap.c	Thu Sep 13 14:28:01 2001
@@ -94,7 +94,8 @@ void irlap_cleanup(void)
  *    Initialize IrLAP layer
  *
  */
-struct irlap_cb *irlap_open(struct net_device *dev, struct qos_info *qos)
+struct irlap_cb *irlap_open(struct net_device *dev, struct qos_info *qos,
+			    char *	hw_name)
 {
 	struct irlap_cb *self;
 
@@ -111,6 +112,13 @@ struct irlap_cb *irlap_open(struct net_d
 	/* Make a binding between the layers */
 	self->netdev = dev;
 	self->qos_dev = qos;
+	/* Copy hardware name */
+	if(hw_name != NULL) {
+		strncpy(self->hw_name, hw_name, 2*IFNAMSIZ);
+		self->hw_name[2*IFNAMSIZ] = '\0';
+	} else {
+		self->hw_name[0] = '\0';
+	}
 
 	/* FIXME: should we get our own field? */
 	dev->atalk_ptr = self;
@@ -1101,6 +1109,10 @@ int irlap_proc_read(char *buf, char **st
 		len += sprintf(buf+len, "state: %s\n", 
 			       irlap_state[self->state]);
 		
+		len += sprintf(buf+len, "  device name: %s, ",
+			       (self->netdev) ? self->netdev->name : "bug");
+		len += sprintf(buf+len, "hardware name: %s\n", self->hw_name);
+
 		len += sprintf(buf+len, "  caddr: %#02x, ", self->caddr);
 		len += sprintf(buf+len, "saddr: %#08x, ", self->saddr);
 		len += sprintf(buf+len, "daddr: %#08x\n", self->daddr);
diff -u -p linux/drivers/net/irda/irtty.j2.c linux/drivers/net/irda/irtty.c
--- linux/drivers/net/irda/irtty.j2.c	Thu Sep 13 14:25:49 2001
+++ linux/drivers/net/irda/irtty.c	Thu Sep 13 14:28:01 2001
@@ -895,6 +895,8 @@ static int irtty_net_init(struct net_dev
 static int irtty_net_open(struct net_device *dev)
 {
 	struct irtty_cb *self = (struct irtty_cb *) dev->priv;
+	struct tty_struct *tty = self->tty;
+	char hwname[16];
 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRTTY_MAGIC, return -1;);
@@ -907,11 +909,16 @@ static int irtty_net_open(struct net_dev
 	/* Make sure we can receive more data */
 	irtty_stop_receiver(self, FALSE);
 
+	/* Give self a hardware name */
+	sprintf(hwname, "%s%d", tty->driver.name,
+		MINOR(tty->device) - tty->driver.minor_start +
+		tty->driver.name_base);
+
 	/* 
 	 * Open new IrLAP layer instance, now that everything should be
 	 * initialized properly 
 	 */
-	self->irlap = irlap_open(dev, &self->qos);
+	self->irlap = irlap_open(dev, &self->qos, hwname);
 
 	MOD_INC_USE_COUNT;
 
diff -u -p linux/drivers/net/irda/irport.j2.c linux/drivers/net/irda/irport.c
--- linux/drivers/net/irda/irport.j2.c	Thu Sep 13 14:25:58 2001
+++ linux/drivers/net/irda/irport.c	Thu Sep 13 14:28:01 2001
@@ -774,6 +774,7 @@ int irport_net_open(struct net_device *d
 {
 	struct irport_cb *self;
 	int iobase;
+	char hwname[16];
 
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
 	
@@ -792,11 +793,14 @@ int irport_net_open(struct net_device *d
 	irport_start(self);
 
 
+	/* Give self a hardware name */
+	sprintf(hwname, "SIR @ 0x%03x", self->io.sir_base);
+
 	/* 
 	 * Open new IrLAP layer instance, now that everything should be
 	 * initialized properly 
 	 */
-	self->irlap = irlap_open(dev, &self->qos);
+	self->irlap = irlap_open(dev, &self->qos, hwname);
 
 	/* FIXME: change speed of dongle */
 	/* Ready to play! */
diff -u -p linux/drivers/net/irda/nsc-ircc.j2.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda/nsc-ircc.j2.c	Thu Sep 13 14:26:23 2001
+++ linux/drivers/net/irda/nsc-ircc.c	Thu Sep 13 14:28:01 2001
@@ -1836,6 +1836,7 @@ static int nsc_ircc_net_open(struct net_
 {
 	struct nsc_ircc_cb *self;
 	int iobase;
+	char hwname[32];
 	__u8 bank;
 	
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
@@ -1874,14 +1875,16 @@ static int nsc_ircc_net_open(struct net_
 	outb(bank, iobase+BSR);
 
 	/* Ready to play! */
-
 	netif_start_queue(dev);
 	
+	/* Give self a hardware name */
+	sprintf(hwname, "NSC-FIR @ 0x%03x", self->io.fir_base);
+
 	/* 
 	 * Open new IrLAP layer instance, now that everything should be
 	 * initialized properly 
 	 */
-	self->irlap = irlap_open(dev, &self->qos);
+	self->irlap = irlap_open(dev, &self->qos, hwname);
 
 	MOD_INC_USE_COUNT;
 
diff -u -p linux/drivers/net/irda/toshoboe.j2.c linux/drivers/net/irda/toshoboe.c
--- linux/drivers/net/irda/toshoboe.j2.c	Thu Sep 13 14:26:38 2001
+++ linux/drivers/net/irda/toshoboe.c	Thu Sep 13 14:28:01 2001
@@ -510,6 +510,7 @@ static int
 toshoboe_net_open (struct net_device *dev)
 {
   struct toshoboe_cb *self;
+  char hwname[32];
 
   IRDA_DEBUG (4, __FUNCTION__ "()\n");
 
@@ -537,11 +538,13 @@ toshoboe_net_open (struct net_device *de
 
   /* Ready to play! */
   netif_start_queue(dev);  
+  /* Give self a hardware name */
+  sprintf(hwname, "Toshiba-FIR @ 0x%03x", self->base);
   /* 
    * Open new IrLAP layer instance, now that everything should be
    * initialized properly 
    */
-  self->irlap = irlap_open(dev, &self->qos);	
+  self->irlap = irlap_open(dev, &self->qos, hwname);	
 
   self->open = 1;
 	
diff -u -p linux/drivers/net/irda/w83977af_ir.j2.c linux/drivers/net/irda/w83977af_ir.c
--- linux/drivers/net/irda/w83977af_ir.j2.c	Thu Sep 13 14:26:58 2001
+++ linux/drivers/net/irda/w83977af_ir.c	Thu Sep 13 14:28:01 2001
@@ -1210,6 +1210,7 @@ static int w83977af_net_open(struct net_
 {
 	struct w83977af_ir *self;
 	int iobase;
+	char hwname[32];
 	__u8 set;
 	
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
@@ -1251,11 +1252,14 @@ static int w83977af_net_open(struct net_
 	/* Ready to play! */
 	netif_start_queue(dev);
 	
+	/* Give self a hardware name */
+	sprintf(hwname, "w83977af @ 0x%03x", self->io.fir_base);
+
 	/* 
 	 * Open new IrLAP layer instance, now that everything should be
 	 * initialized properly 
 	 */
-	self->irlap = irlap_open(dev, &self->qos);
+	self->irlap = irlap_open(dev, &self->qos, hwname);
 
 	MOD_INC_USE_COUNT;
 
diff -u -p linux/drivers/net/irda/ali-ircc.j2.c linux/drivers/net/irda/ali-ircc.c
--- linux/drivers/net/irda/ali-ircc.j2.c	Thu Sep 13 14:27:11 2001
+++ linux/drivers/net/irda/ali-ircc.c	Thu Sep 13 14:28:01 2001
@@ -1344,6 +1344,7 @@ static int ali_ircc_net_open(struct net_
 {
 	struct ali_ircc_cb *self;
 	int iobase;
+	char hwname[32];
 		
 	IRDA_DEBUG(2, __FUNCTION__ "(), ---------------- Start ----------------\n");
 	
@@ -1380,11 +1381,14 @@ static int ali_ircc_net_open(struct net_
 	/* Ready to play! */
 	netif_start_queue(dev); //benjamin by irport
 	
+	/* Give self a hardware name */
+	sprintf(hwname, "ALI-FIR @ 0x%03x", self->io.fir_base);
+
 	/* 
 	 * Open new IrLAP layer instance, now that everything should be
 	 * initialized properly 
 	 */
-	self->irlap = irlap_open(dev, &self->qos);
+	self->irlap = irlap_open(dev, &self->qos, hwname);
 		
 	MOD_INC_USE_COUNT;
 
diff -u -p linux/drivers/net/irda/irda-usb.j2.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda/irda-usb.j2.c	Thu Sep 13 14:27:34 2001
+++ linux/drivers/net/irda/irda-usb.c	Thu Sep 13 14:28:50 2001
@@ -959,7 +959,7 @@ static int irda_usb_net_open(struct net_
 	 * Note : will send immediately a speed change...
 	 */
 	sprintf(hwname, "usb#%d", self->usbdev->devnum);
-	self->irlap = irlap_open(netdev, &self->qos);
+	self->irlap = irlap_open(netdev, &self->qos, hwname);
 	ASSERT(self->irlap != NULL, return -1;);
 
 	/* Allow IrLAP to send data to us */
diff -u -p linux/drivers/net/irda/vlsi_ir.j2.c linux/drivers/net/irda/vlsi_ir.c
--- linux/drivers/net/irda/vlsi_ir.j2.c	Thu Sep 13 14:27:44 2001
+++ linux/drivers/net/irda/vlsi_ir.c	Thu Sep 13 14:33:43 2001
@@ -776,6 +776,7 @@ static int vlsi_open(struct net_device *
 {
 	vlsi_irda_dev_t *idev = ndev->priv;
 	struct pci_dev *pdev = idev->pdev;
+	char	hwname[32];
 	int	err;
 
 	MOD_INC_USE_COUNT;		/* still needed? - we have SET_MODULE_OWNER! */
@@ -824,7 +825,8 @@ static int vlsi_open(struct net_device *
 		(idev->mode==IFF_SIR)?"SIR":((idev->mode==IFF_MIR)?"MIR":"FIR"),
 		(sirpulse)?"3/16 bittime":"short");
 
-	idev->irlap = irlap_open(ndev,&idev->qos);
+	sprintf(hwname, "VLSI-FIR");
+	idev->irlap = irlap_open(ndev,&idev->qos,hwname);
 
 	netif_start_queue(ndev);
 
