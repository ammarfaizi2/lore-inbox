Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129977AbQLWNZJ>; Sat, 23 Dec 2000 08:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbQLWNZA>; Sat, 23 Dec 2000 08:25:00 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:18624 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129977AbQLWNYn>; Sat, 23 Dec 2000 08:24:43 -0500
Message-ID: <3A44A114.2A277D95@uow.edu.au>
Date: Sat, 23 Dec 2000 23:56:52 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: vmabraham@hotmail.com, Steve.Ralston@lsil.com,
        Auvo.Hakkinen@cs.Helsinki.FI, Juha.Sievanen@cs.Helsinki.FI,
        Taneli.Vahakangas@cs.Helsinki.FI, deepak@plexity.net,
        lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: [patch] remove init_fcdev
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

the patch removes use of the unsafe init_fcdev() and replaces it with
the new prepare_fcdev()/publish_netdev() API as described at

	http://www.uow.edu.au/~andrewm/linux/netdevice2.txt

I changed drivers/i2o/i2o_lan.c:i2o_lan_register_device() to use prepare_fddidev().  Not sure why it wasn't using init_fddidev()
initially?

I also migrated a couple of these drivers over to use
SET_MODULE_OWNER.

Files affected:

drivers/net/fc/iph5526.c
drivers/block/fusion/mptlan.c
drivers/i2o/i2o_lan.c

This all went in pretty cleanly.

A patch for rrunner.c has been sent to Jes so init_hippi_dev() is
done too.



--- linux-2.4.0-test13pre4-ac2/drivers/net/fc/iph5526.c	Sat Dec 23 17:24:20 2000
+++ linux-akpm/drivers/net/fc/iph5526.c	Sat Dec 23 22:02:21 2000
@@ -25,6 +25,7 @@
 07.07.99 Can be loaded as part of the Kernel. Changed semaphores. Added
          more checks before invalidating SEST entries.
 07.08.99 Added Broadcast IP stuff and fixed an unicast timeout bug.
+23Dec00  Use new publish_netdev interface.  Use SET_MODULE_OWNER. (andrewm@uow.edu.au)
 ***********************************************************************/
 /* TODO:
 	R_T_TOV set to 15msec in Loop topology. Need to be 100 msec.
@@ -33,7 +34,7 @@
 */	
 
 static const char *version =
-    "iph5526.c:v1.0 07.08.99 Vineet Abraham (vmabraham@hotmail.com)\n";
+    "iph5526.c:v1.0 23Dec00 Vineet Abraham (vmabraham@hotmail.com)\n";
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -245,7 +246,7 @@
  
 	if(fc[count] != NULL) {
 		if (dev == NULL) {
-			dev = init_fcdev(NULL, 0);
+			dev = prepare_fcdev(NULL, 0);
 			if (dev == NULL)
 				return -ENOMEM;
 		}
@@ -266,6 +267,7 @@
 		dev->dev_addr[4] = (fi->g.my_port_name_low & 0x0000FF00) >> 8;
 		dev->dev_addr[5] = fi->g.my_port_name_low;
 #ifndef MODULE
+		publish_netdev(dev);
 		count++;
 	}
 	else
@@ -2916,14 +2918,12 @@
 static int iph5526_open(struct net_device *dev)
 {
 	netif_start_queue(dev);
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
 static int iph5526_close(struct net_device *dev)
 {
 	netif_stop_queue(dev);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -4543,7 +4543,7 @@
 
 	while(fc[i] != NULL) {
 		dev_fc[i] = NULL;
-		dev_fc[i] = init_fcdev(dev_fc[i], 0);	
+		dev_fc[i] = prepare_fcdev(dev_fc[i], 0);	
 		if (dev_fc[i] == NULL) {
 			printk("iph5526.c: init_fcdev failed for card #%d\n", i+1);
 			break;
@@ -4551,16 +4551,20 @@
 		dev_fc[i]->irq = irq;
 		dev_fc[i]->mem_end = bad;
 		dev_fc[i]->base_addr = io;
-		dev_fc[i]->init = iph5526_probe;
+//		dev_fc[i]->init = iph5526_probe;
 		dev_fc[i]->priv = fc[i];
 		fc[i]->dev = dev_fc[i];
-		if (register_fcdev(dev_fc[i]) != 0) {
+		if (iph5526_probe(dev_fc[i]) != 0) {
+			withdraw_netdev(dev_fc[i]);
 			kfree(dev_fc[i]);
 			dev_fc[i] = NULL;
 			if (i == 0) {
 				printk("iph5526.c: IP registeration failed!!!\n");
 				return -ENODEV;
 			}
+		} else {
+			SET_MODULE_OWNER(dev_fc[i]);
+			publish_netdev(dev_fc[i]);
 		}
 		i++;
 	}
@@ -4578,7 +4582,7 @@
 	void *priv = dev->priv;
 		fc[i]->g.dont_init = TRUE;
 		take_tachyon_offline(fc[i]);
-		unregister_fcdev(dev);
+		unregister_netdev(dev);
 		clean_up_memory(fc[i]);
 		if (dev->priv)
 			kfree(priv);
--- linux-2.4.0-test13pre4-ac2/drivers/block/fusion/mptlan.c	Sat Dec 23 17:24:19 2000
+++ linux-akpm/drivers/block/fusion/mptlan.c	Sat Dec 23 22:02:21 2000
@@ -1306,7 +1306,7 @@
 	struct mpt_lan_priv *priv = NULL;
 	u8 HWaddr[FC_ALEN], *a;
 
-	dev = init_fcdev(NULL, sizeof(struct mpt_lan_priv));
+	dev = prepare_fcdev(NULL, sizeof(struct mpt_lan_priv));
 	if (!dev)
 		return (NULL);
 	dev->mtu = MPT_LAN_MTU;
@@ -1378,7 +1378,8 @@
 		"and setting initial values\n"));
 
 	SET_MODULE_OWNER(dev);
-	
+	publish_netdev(dev);
+
 	return dev;
 }
 
@@ -1460,7 +1461,7 @@
 
 		printk (KERN_INFO MYNAM ": %s/%s: Fusion MPT LAN device unregistered.\n",
 			       IOC_AND_NETDEV_NAMES_s_s(dev));
-		unregister_fcdev(dev);
+		unregister_netdev(dev);
 		mpt_landev[i] = (struct net_device *) 0xdeadbeef; /* Debug */
 	}
 
--- linux-2.4.0-test13pre4-ac2/drivers/i2o/i2o_lan.c	Sat Dec 23 17:24:20 2000
+++ linux-akpm/drivers/i2o/i2o_lan.c	Sat Dec 23 22:28:37 2000
@@ -744,11 +744,8 @@
 	struct i2o_controller *iop = i2o_dev->controller;
 	u32 mc_addr_group[64];
 
-	MOD_INC_USE_COUNT;
-
 	if (i2o_claim_device(i2o_dev, &i2o_lan_handler)) {
 		printk(KERN_WARNING "%s: Unable to claim the I2O LAN device.\n", dev->name);
-		MOD_DEC_USE_COUNT;
 		return -EAGAIN;
 	}
 	dprintk(KERN_INFO "%s: I2O LAN device (tid=%d) claimed by LAN OSM.\n",
@@ -765,7 +762,6 @@
 	if (i2o_query_scalar(iop, i2o_dev->lct_data.tid, 0x0001, -1,
 			     &mc_addr_group, sizeof(mc_addr_group)) < 0 ) {
 		printk(KERN_WARNING "%s: Unable to query LAN_MAC_ADDRESS group.\n", dev->name);
-		MOD_DEC_USE_COUNT;
 		return -EAGAIN;
 	}
 	priv->max_size_mc_table = mc_addr_group[8];
@@ -775,7 +771,6 @@
 	priv->i2o_fbl = kmalloc(priv->max_buckets_out * sizeof(struct sk_buff *),
 				GFP_KERNEL);
 	if (priv->i2o_fbl == NULL) {
-		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 	priv->i2o_fbl_tail = -1;
@@ -818,8 +813,6 @@
 		ret = -EBUSY;
 	}
 
-	MOD_DEC_USE_COUNT;
-
 	return ret;
 }
 
@@ -1281,15 +1274,13 @@
 	u8 hw_addr[8];
 	u32 tx_max_out = 0;
 	unsigned short (*type_trans)(struct sk_buff *, struct net_device *);
-	void (*unregister_dev)(struct net_device *dev);
 
 	switch (i2o_dev->lct_data.sub_class) {
 	case I2O_LAN_ETHERNET:
-		dev = init_etherdev(NULL, sizeof(struct i2o_lan_local));
+		dev = prepare_etherdev(NULL, sizeof(struct i2o_lan_local));
 		if (dev == NULL)
 			return NULL;
 		type_trans = eth_type_trans;
-		unregister_dev = unregister_netdev;
 		break;
 
 #ifdef CONFIG_ANYLAN
@@ -1304,40 +1295,25 @@
 		dev = prepare_trdev(NULL, sizeof(struct i2o_lan_local));
 		if (dev==NULL)
 			return NULL;
-		publish_netdev(dev);		/* AKPM: racy */
 		type_trans = tr_type_trans;
-		unregister_dev = unregister_netdev;
 		break;
 #endif
 
 #ifdef CONFIG_FDDI
 	case I2O_LAN_FDDI:
 	{
-		int size = sizeof(struct net_device) + sizeof(struct i2o_lan_local);
-
-		dev = (struct net_device *) kmalloc(size, GFP_KERNEL);
+		dev = prepare_fddidev(NULL, sizeof(struct i2o_lan_local));
 		if (dev == NULL)
 			return NULL;
-		memset((char *)dev, 0, size);
-	    	dev->priv = (void *)(dev + 1);
-
-		if (dev_alloc_name(dev, "fddi%d") < 0) {
-			printk(KERN_WARNING "i2o_lan: Too many FDDI devices.\n");
-			kfree(dev);
-			return NULL;
-		}
 		type_trans = fddi_type_trans;
-		unregister_dev = (void *)unregister_netdev;
-
 		fddi_setup(dev);
-		register_netdev(dev);
 	}
 	break;
 #endif
 
 #ifdef CONFIG_NET_FC
 	case I2O_LAN_FIBRE_CHANNEL:
-		dev = init_fcdev(NULL, sizeof(struct i2o_lan_local));
+		dev = prepare_fcdev(NULL, sizeof(struct i2o_lan_local));
 		if (dev == NULL)
 			return NULL;
 		type_trans = NULL;
@@ -1345,7 +1321,6 @@
  * and export it in include/linux/fcdevice.h
  *		type_trans = fc_type_trans;
  */
-		unregister_dev = (void *)unregister_fcdev;
 		break;
 #endif
 
@@ -1382,7 +1357,7 @@
 			     0x0001, 0, &hw_addr, sizeof(hw_addr)) < 0) {
 		printk(KERN_ERR "%s: Unable to query hardware address.\n", dev->name);
 		unit--;
-		unregister_dev(dev);
+		withdraw_netdev(dev);
 		kfree(dev);
 		return NULL;
 	}
@@ -1397,7 +1372,7 @@
 			     0x0007, 2, &tx_max_out, sizeof(tx_max_out)) < 0) {
 		printk(KERN_ERR "%s: Unable to query max TX queue.\n", dev->name);
 		unit--;
-		unregister_dev(dev);
+		withdraw_netdev(dev);
 		kfree(dev);
 		return NULL;
 	}
@@ -1428,6 +1403,8 @@
 	if (i2o_dev->lct_data.sub_class == I2O_LAN_ETHERNET)
 		dev->change_mtu	= i2o_lan_change_mtu;
 
+	SET_MODULE_OWNER(dev);
+	publish_netdev(dev);
 	return dev;
 }
 
@@ -1533,7 +1510,7 @@
 			break;
 #ifdef CONFIG_FDDI
 		case I2O_LAN_FDDI:
-			unregister_netdevice(dev);
+			unregister_netdev(dev);
 			break;
 #endif
 #ifdef CONFIG_TR
@@ -1543,7 +1520,7 @@
 #endif
 #ifdef CONFIG_NET_FC
 		case I2O_LAN_FIBRE_CHANNEL:
-			unregister_fcdev(dev);
+			unregister_netdev(dev);
 			break;
 #endif
 		default:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
