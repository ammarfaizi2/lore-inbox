Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTBXSKW>; Mon, 24 Feb 2003 13:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267329AbTBXSKW>; Mon, 24 Feb 2003 13:10:22 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:30377 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261353AbTBXSKK> convert rfc822-to-8bit; Mon, 24 Feb 2003 13:10:10 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (3/13): ctc network driver.
Date: Mon, 24 Feb 2003 19:08:24 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302241908.24861.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug fixes for the CTC driver

also removes the bogus intparm_t typedef

diff -urN linux-2.5.62/drivers/s390/net/ctcmain.c linux-2.5.62-s390/drivers/s390/net/ctcmain.c
--- linux-2.5.62/drivers/s390/net/ctcmain.c	Mon Feb 17 23:56:11 2003
+++ linux-2.5.62-s390/drivers/s390/net/ctcmain.c	Mon Feb 24 18:23:53 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.30 2002/12/09 13:56:20 aberg Exp $
+ * $Id: ctcmain.c,v 1.35 2003/01/17 13:46:13 cohuck Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.30 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.35 $
  *
  */
 
@@ -105,10 +105,6 @@
 
 #define CTC_ID_SIZE             DEVICE_ID_SIZE+3
 
-/**
- * If running on 64 bit, this must be changed. XXX Why? (bird)
- */
-typedef unsigned long intparm_t;
 
 struct ctc_profile {
 	unsigned long maxmulti;
@@ -270,8 +266,6 @@
 	return test_and_set_bit(0, &((struct ctc_priv *) dev->priv)->tbusy);
 }
 
-#define SET_DEVICE_START(device, value)
-
 /**
  * Print Banner.
  */
@@ -279,7 +273,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.30 $";
+	char vbuf[] = "$Revision: 1.35 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -882,7 +876,7 @@
 		fsm_addtimer(&ch->timer, CTC_TIMEOUT_5SEC, CH_EVENT_TIMER, ch);
 		ch->prof.send_stamp = xtime;
 		rc = ccw_device_start(ch->cdev, &ch->ccw[0],
-				      (intparm_t) ch, 0xff, 0);
+				      (unsigned long) ch, 0xff, 0);
 		ch->prof.doios_multi++;
 		if (rc != 0) {
 			privptr->stats.tx_dropped += i;
@@ -985,7 +979,7 @@
 	if (ctc_checkalloc_buffer(ch, 1))
 		return;
 	ch->ccw[1].count = ch->max_bufsize;
-	rc = ccw_device_start(ch->cdev, &ch->ccw[0], (intparm_t) ch, 0xff, 0);
+	rc = ccw_device_start(ch->cdev, &ch->ccw[0], (unsigned long) ch, 0xff, 0);
 	if (rc != 0)
 		ccw_check_return_code(ch, rc);
 }
@@ -1042,7 +1036,7 @@
 
 	fsm_newstate(fi, (CHANNEL_DIRECTION(ch->flags) == READ)
 		     ? CH_STATE_RXINIT : CH_STATE_TXINIT);
-	rc = ccw_device_start(ch->cdev, &ch->ccw[0], (intparm_t) ch, 0xff, 0);
+	rc = ccw_device_start(ch->cdev, &ch->ccw[0], (unsigned long) ch, 0xff, 0);
 	if (rc != 0) {
 		fsm_deltimer(&ch->timer);
 		fsm_newstate(fi, CH_STATE_SETUPWAIT);
@@ -1089,7 +1083,7 @@
 		ch->ccw[1].count = ch->max_bufsize;
 		fsm_newstate(fi, CH_STATE_RXIDLE);
 		rc = ccw_device_start(ch->cdev, &ch->ccw[0],
-				      (intparm_t) ch, 0xff, 0);
+				      (unsigned long) ch, 0xff, 0);
 		if (rc != 0) {
 			fsm_newstate(fi, CH_STATE_RXINIT);
 			ccw_check_return_code(ch, rc);
@@ -1122,7 +1116,7 @@
 	fsm_newstate(fi, CH_STATE_SETUPWAIT);
 	if (event == CH_EVENT_TIMER)
 		spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
-	rc = ccw_device_start(ch->cdev, &ch->ccw[6], (intparm_t) ch, 0xff, 0);
+	rc = ccw_device_start(ch->cdev, &ch->ccw[6], (unsigned long) ch, 0xff, 0);
 	if (event == CH_EVENT_TIMER)
 		spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
 	if (rc != 0) {
@@ -1198,7 +1192,7 @@
 	fsm_newstate(fi, CH_STATE_STARTWAIT);
 	fsm_addtimer(&ch->timer, 1000, CH_EVENT_TIMER, ch);
 	spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
-	rc = ccw_device_halt(ch->cdev, (intparm_t) ch);
+	rc = ccw_device_halt(ch->cdev, (unsigned long) ch);
 	spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
 	if (rc != 0) {
 		fsm_deltimer(&ch->timer);
@@ -1228,7 +1222,7 @@
 		spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
 	oldstate = fsm_getstate(fi);
 	fsm_newstate(fi, CH_STATE_TERM);
-	rc = ccw_device_halt(ch->cdev, (intparm_t) ch);
+	rc = ccw_device_halt(ch->cdev, (unsigned long) ch);
 	if (event == CH_EVENT_STOP)
 		spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
 	if (rc != 0) {
@@ -1345,7 +1339,7 @@
 		fsm_deltimer(&ch->timer);
 		fsm_addtimer(&ch->timer, CTC_TIMEOUT_5SEC, CH_EVENT_TIMER, ch);
 		if (CHANNEL_DIRECTION(ch->flags) == READ) {
-			int rc = ccw_device_halt(ch->cdev, (intparm_t) ch);
+			int rc = ccw_device_halt(ch->cdev, (unsigned long) ch);
 			if (rc != 0)
 				ccw_check_return_code(ch, rc);
 		}
@@ -1392,7 +1386,7 @@
 	fsm_newstate(fi, CH_STATE_STARTWAIT);
 	if (event == CH_EVENT_TIMER)
 		spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
-	rc = ccw_device_halt(ch->cdev, (intparm_t) ch);
+	rc = ccw_device_halt(ch->cdev, (unsigned long) ch);
 	if (event == CH_EVENT_TIMER)
 		spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
 	if (rc != 0) {
@@ -1480,8 +1474,8 @@
 	ch2 = ((struct ctc_priv *) dev->priv)->channel[WRITE];
 	fsm_newstate(ch2->fsm, CH_STATE_DTERM);
 
-	ccw_device_halt(ch->cdev, (intparm_t) ch);
-	ccw_device_halt(ch2->cdev, (intparm_t) ch2);
+	ccw_device_halt(ch->cdev, (unsigned long) ch);
+	ccw_device_halt(ch2->cdev, (unsigned long) ch2);
 }
 
 /**
@@ -1556,7 +1550,7 @@
 				spin_lock_irqsave(get_ccwdev_lock(ch->cdev),
 						  saveflags);
 			rc = ccw_device_start(ch->cdev, &ch->ccw[3],
-					      (intparm_t) ch, 0xff, 0);
+					      (unsigned long) ch, 0xff, 0);
 			if (event == CH_EVENT_TIMER)
 				spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev),
 						       saveflags);
@@ -1956,23 +1950,36 @@
 {
 	struct channel *ch;
 	struct net_device *dev;
+	struct ctc_priv *priv;
+
+	/* Check for unsolicited interrupts. */
+	if (!cdev->dev.driver_data) {
+		printk(KERN_WARNING
+		       "ctc: Got unsolicited irq: %s c-%02x d-%02x\n",
+		       cdev->dev.bus_id, irb->scsw.cstat,
+		       irb->scsw.dstat);
+		return;
+	}
 	
+	priv = cdev->dev.driver_data;
 	ch = (struct channel *) intparm;
-	/**
-	 * Check for unsolicited interrupts.
-	 * If intparm is NULL, try to get channel from ccw_device.
-	 */
-	if (ch == NULL) {
-		ch = container_of(&cdev, struct channel, cdev);
- 		if (ch == NULL) {
-			printk(KERN_WARNING
-			       "ctc: Got unsolicited irq: %s c-%02x d-%02x\n",
-			       cdev->dev.bus_id, irb->scsw.cstat,
-			       irb->scsw.dstat);
+	if ((ch != priv->channel[READ]) && (ch != priv->channel[WRITE]))
+		ch = NULL;
+	
+	if (!ch) {
+		/* Try to extract channel from driver data. */
+		if (priv->channel[READ]->cdev == cdev)
+			ch = priv->channel[READ];
+		else if (priv->channel[WRITE]->cdev == cdev)
+			ch = priv->channel[READ];
+		else {
+			printk(KERN_ERR
+			       "ctc: Can't determine channel for interrupt, "
+			       "device %s\n", cdev->dev.bus_id);
 			return;
 		}
 	}
-
+	
 	dev = (struct net_device *) (ch->netdev);
 	if (dev == NULL) {
 		printk(KERN_CRIT
@@ -2342,7 +2349,7 @@
 		spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
 		ch->prof.send_stamp = xtime;
 		rc = ccw_device_start(ch->cdev, &ch->ccw[ccw_idx],
-				      (intparm_t) ch, 0xff, 0);
+				      (unsigned long) ch, 0xff, 0);
 		spin_unlock_irqrestore(get_ccwdev_lock(ch->cdev), saveflags);
 		if (ccw_idx == 3)
 			ch->prof.doios_single++;
@@ -2401,7 +2408,6 @@
 static int
 ctc_close(struct net_device * dev)
 {
-	SET_DEVICE_START(dev, 0);
 	fsm_event(((struct ctc_priv *) dev->priv)->fsm, DEV_EVENT_STOP, dev);
 	MOD_DEC_USE_COUNT;
 	return 0;
@@ -2533,7 +2539,7 @@
 	priv = dev->driver_data;
 	if (!priv)
 		return -ENODEV;
-	ndev = container_of((void *) priv, struct net_device, priv);
+	ndev = priv->channel[READ]->netdev;
 	if (!ndev)
 		return -ENODEV;
 	sscanf(buf, "%u", &bs1);
@@ -2755,7 +2761,6 @@
 	dev->addr_len = 0;
 	dev->type = ARPHRD_SLIP;
 	dev->tx_queue_len = 100;
-	SET_DEVICE_START(dev, 1);
 	dev_init_buffers(dev);
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
 	return dev;
@@ -2881,11 +2886,14 @@
 	if (add_channel(cgdev->cdev[1], type))
 		return -ENOMEM;
 
+	ccw_device_set_online(cgdev->cdev[0]);
+	ccw_device_set_online(cgdev->cdev[1]);	
+
 	dev = ctc_init_netdevice(NULL, 1, privptr);
 
 	if (!dev) {
 		printk(KERN_WARNING "ctc_init_netdevice failed\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (privptr->protocol == CTC_PROTO_LINUX_TTY)
@@ -2902,7 +2910,7 @@
 				channel_free(privptr->channel[READ]);
 
 			ctc_free_netdevice(dev, 1);
-			return -ENODEV;
+			goto out;
 		}
 		privptr->channel[direction]->netdev = dev;
 		privptr->channel[direction]->protocol = privptr->protocol;
@@ -2910,7 +2918,7 @@
 	}
 	if (ctc_netdev_register(dev) != 0) {
 		ctc_free_netdevice(dev, 1);
-		return -ENODEV;
+		goto out;
 	}
 
 	ctc_add_attributes(&cgdev->dev);
@@ -2925,6 +2933,11 @@
 	       privptr->channel[WRITE]->id, privptr->protocol);
 
 	return 0;
+out:
+	ccw_device_set_offline(cgdev->cdev[1]);
+	ccw_device_set_offline(cgdev->cdev[0]);
+
+	return -ENODEV;
 }
 
 /**
@@ -2944,7 +2957,7 @@
 	priv = cgdev->dev.driver_data;
 	if (!priv)
 		return -ENODEV;
-	ndev = container_of((void *)priv, struct net_device, priv);
+	ndev = priv->channel[READ]->netdev;
 
 	/* Close the device */
 	ctc_close(ndev);
@@ -2961,6 +2974,9 @@
 
 	kfree_fsm(priv->fsm);
 
+	ccw_device_set_offline(cgdev->cdev[1]);
+	ccw_device_set_offline(cgdev->cdev[0]);
+
 	channel_remove(priv->channel[READ]);
 	channel_remove(priv->channel[WRITE]);
 	
diff -urN linux-2.5.62/drivers/s390/net/cu3088.c linux-2.5.62-s390/drivers/s390/net/cu3088.c
--- linux-2.5.62/drivers/s390/net/cu3088.c	Mon Feb 17 23:56:10 2003
+++ linux-2.5.62-s390/drivers/s390/net/cu3088.c	Mon Feb 24 18:23:53 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: cu3088.c,v 1.22 2002/12/10 09:53:55 cohuck Exp $
+ * $Id: cu3088.c,v 1.26 2003/01/17 13:46:13 cohuck Exp $
  *
  * CTC / LCS ccw_device driver
  *
@@ -25,8 +25,6 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/device.h>
-#include <linux/slab.h>
 
 #include <asm/ccwdev.h>
 #include <asm/ccwgroup.h>
@@ -146,10 +144,8 @@
 	if (rc)
 		return rc;
 	rc = ccw_driver_register(&cu3088_driver);
-	if (rc) {
+	if (rc)
 		device_unregister(&cu3088_root_dev);
-		return rc;
-	}
 
 	return rc;
 }
@@ -168,5 +164,6 @@
 module_init(cu3088_init);
 module_exit(cu3088_exit);
 
+EXPORT_SYMBOL_GPL(cu3088_type);
 EXPORT_SYMBOL_GPL(register_cu3088_discipline);
 EXPORT_SYMBOL_GPL(unregister_cu3088_discipline);

