Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270287AbUJTBUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270287AbUJTBUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270277AbUJTBSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 21:18:10 -0400
Received: from palrel10.hp.com ([156.153.255.245]:15520 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S270272AbUJTBJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 21:09:09 -0400
Date: Tue, 19 Oct 2004 18:09:09 -0700
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Stir netdev and messages cleanups
Message-ID: <20041020010909.GL12932@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_stid_netdev_priv.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] stir4200: netdev_priv and message cleanup
Stir4200 driver cleanup's:
        * use netdev_priv
        * make sure messages identify the driver
        * get rid of unneeded message
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>



diff -Nru a/drivers/net/irda/stir4200.c b/drivers/net/irda/stir4200.c
--- a/drivers/net/irda/stir4200.c	2004-10-08 14:02:25 -07:00
+++ b/drivers/net/irda/stir4200.c	2004-10-08 14:02:25 -07:00
@@ -570,7 +570,7 @@
  */
 static int stir_hard_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
-	struct stir_cb *stir = netdev->priv;
+	struct stir_cb *stir = netdev_priv(netdev);
 
 	netif_stop_queue(netdev);
 
@@ -871,7 +871,7 @@
  */
 static int stir_net_open(struct net_device *netdev)
 {
-	struct stir_cb *stir = netdev->priv;
+	struct stir_cb *stir = netdev_priv(netdev);
 	int err;
 	char hwname[16];
 
@@ -924,7 +924,7 @@
 	sprintf(hwname, "usb#%d", stir->usbdev->devnum);
 	stir->irlap = irlap_open(netdev, &stir->qos, hwname);
 	if (!stir->irlap) {
-		err("irlap_open failed");
+		err("stir4200: irlap_open failed");
 		goto err_out5;
 	}
 
@@ -933,7 +933,7 @@
 				      CLONE_FS|CLONE_FILES);
 	if (stir->thr_pid < 0) {
 		err = stir->thr_pid;
-		err("unable to start kernel thread");
+		err("stir4200: unable to start kernel thread");
 		goto err_out6;
 	}
 
@@ -963,7 +963,7 @@
  */
 static int stir_net_close(struct net_device *netdev)
 {
-	struct stir_cb *stir = netdev->priv;
+	struct stir_cb *stir = netdev_priv(netdev);
 
 	/* Stop transmit processing */
 	netif_stop_queue(netdev);
@@ -992,10 +992,10 @@
 /*
  * IOCTLs : Extra out-of-band network commands...
  */
-static int stir_net_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+static int stir_net_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
 {
 	struct if_irda_req *irq = (struct if_irda_req *) rq;
-	struct stir_cb *stir = dev->priv;
+	struct stir_cb *stir = netdev_priv(netdev);
 	int ret = 0;
 
 	switch (cmd) {
@@ -1032,9 +1032,9 @@
 /*
  * Get device stats (for /proc/net/dev and ifconfig)
  */
-static struct net_device_stats *stir_net_get_stats(struct net_device *dev)
+static struct net_device_stats *stir_net_get_stats(struct net_device *netdev)
 {
-	struct stir_cb *stir = dev->priv;
+	struct stir_cb *stir = netdev_priv(netdev);
 	return &stir->stats;
 }
 
@@ -1060,13 +1060,13 @@
 
 	SET_MODULE_OWNER(net);
 	SET_NETDEV_DEV(net, &intf->dev);
-	stir = net->priv;
+	stir = netdev_priv(net);
 	stir->netdev = net;
 	stir->usbdev = dev;
 
 	ret = usb_reset_configuration(dev);
 	if (ret != 0) {
-		err("usb reset configuration failed");
+		err("stir4200: usb reset configuration failed");
 		goto err_out2;
 	}
 
@@ -1099,7 +1099,7 @@
 	if (ret != 0)
 		goto err_out2;
 
-	MESSAGE("IrDA: Registered SigmaTel device %s\n", net->name);
+	info("IrDA: Registered SigmaTel device %s", net->name);
 
 	usb_set_intfdata(intf, stir);
 
@@ -1169,11 +1169,7 @@
  */
 static int __init stir_init(void)
 {
-	if (usb_register(&irda_driver) < 0)
-		return -1;
-
-	MESSAGE("SigmaTel support registered\n");
-	return 0;
+	return usb_register(&irda_driver);
 }
 module_init(stir_init);
 


