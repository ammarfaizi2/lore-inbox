Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266670AbUAXCTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 21:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266702AbUAXCTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 21:19:13 -0500
Received: from palrel13.hp.com ([156.153.255.238]:27590 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266670AbUAXCTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 21:19:02 -0500
Date: Fri, 23 Jan 2004 18:19:01 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] 1/11: de-virtualize dongle api helpers
Message-ID: <20040124021901.GB22410@bougret.hpl.hp.com>
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

ir262_dongles-1_sir-dev.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Needed by all subsequent patches>
		<Patch from Martin Diehl>
* change dongle api such that raw r/w and modem line helpers are directly
  called, not virtual callbacks.


diff -u -p linux/drivers/net/irda.d6/sir-dev.h  linux/drivers/net/irda/sir-dev.h
--- linux/drivers/net/irda.d6/sir-dev.h	Wed Jan 21 17:43:43 2004
+++ linux/drivers/net/irda/sir-dev.h	Thu Jan 22 16:42:59 2004
@@ -121,15 +121,17 @@ extern int sirdev_set_dongle(struct sir_
 extern void sirdev_write_complete(struct sir_dev *dev);
 extern int sirdev_receive(struct sir_dev *dev, const unsigned char *cp, size_t count);
 
+/* low level helpers for SIR device/dongle setup */
+extern int sirdev_raw_write(struct sir_dev *dev, const char *buf, int len);
+extern int sirdev_raw_read(struct sir_dev *dev, char *buf, int len);
+extern int sirdev_set_dtr_rts(struct sir_dev *dev, int dtr, int rts);
+
 /* not exported */
 
 extern int sirdev_get_dongle(struct sir_dev *self, IRDA_DONGLE type);
 extern int sirdev_put_dongle(struct sir_dev *self);
 
-extern int sirdev_raw_write(struct sir_dev *dev, const char *buf, int len);
-extern int sirdev_raw_read(struct sir_dev *dev, char *buf, int len);
 extern void sirdev_enable_rx(struct sir_dev *dev);
-
 extern int sirdev_schedule_request(struct sir_dev *dev, int state, unsigned param);
 extern int __init irda_thread_create(void);
 extern void __exit irda_thread_join(void);
@@ -195,10 +197,6 @@ struct sir_dev {
 	const struct sir_driver * drv;
 	void *priv;
 
-	/* dongle callbacks to the SIR device */
-	int (*read)(struct sir_dev *, char *buf, int len);
-	int (*write)(struct sir_dev *, const char *buf, int len);
-	int (*set_dtr_rts)(struct sir_dev *, int dtr, int rts);
 };
 
 #endif	/* IRDA_SIR_H */
diff -u -p linux/drivers/net/irda.d6/sir_core.c  linux/drivers/net/irda/sir_core.c
--- linux/drivers/net/irda.d6/sir_core.c	Wed Dec 17 18:58:38 2003
+++ linux/drivers/net/irda/sir_core.c	Thu Jan 22 16:42:59 2004
@@ -37,6 +37,10 @@ EXPORT_SYMBOL(sirdev_set_dongle);
 EXPORT_SYMBOL(sirdev_write_complete);
 EXPORT_SYMBOL(sirdev_receive);
 
+EXPORT_SYMBOL(sirdev_raw_write);
+EXPORT_SYMBOL(sirdev_raw_read);
+EXPORT_SYMBOL(sirdev_set_dtr_rts);
+
 static int __init sir_core_init(void)
 {
 	return irda_thread_create();
diff -u -p linux/drivers/net/irda.d6/sir_dev.c  linux/drivers/net/irda/sir_dev.c
--- linux/drivers/net/irda.d6/sir_dev.c	Wed Jan 21 17:43:43 2004
+++ linux/drivers/net/irda/sir_dev.c	Thu Jan 22 16:42:59 2004
@@ -117,6 +117,14 @@ int sirdev_raw_read(struct sir_dev *dev,
 	return count;
 }
 
+int sirdev_set_dtr_rts(struct sir_dev *dev, int dtr, int rts)
+{
+	int ret = -ENXIO;
+	if (dev->drv->set_dtr_rts != 0)
+		ret =  dev->drv->set_dtr_rts(dev, dtr, rts);
+	return ret;
+}
+	
 /**********************************************************************/
 
 /* called from client driver - likely with bh-context - to indicate
diff -u -p linux/drivers/net/irda.d6/sir_dongle.c  linux/drivers/net/irda/sir_dongle.c
--- linux/drivers/net/irda.d6/sir_dongle.c	Wed Dec 17 18:58:17 2003
+++ linux/drivers/net/irda/sir_dongle.c	Thu Jan 22 16:42:59 2004
@@ -102,12 +102,6 @@ int sirdev_get_dongle(struct sir_dev *de
 		err = -ESTALE;
 		goto out_unlock;	/* rmmod already pending */
 	}
-
-	/* Initialize dongle driver callbacks */
-	dev->read        = sirdev_raw_read;
-	dev->write       = sirdev_raw_write;
-	dev->set_dtr_rts = dev->drv->set_dtr_rts;
-
 	dev->dongle_drv = drv;
 
 	if (!drv->open  ||  (err=drv->open(dev))!=0)
diff -u -p linux/drivers/net/irda.d6/sir_kthread.c  linux/drivers/net/irda/sir_kthread.c
--- linux/drivers/net/irda.d6/sir_kthread.c	Wed Jan 21 17:43:43 2004
+++ linux/drivers/net/irda/sir_kthread.c	Thu Jan 22 16:42:59 2004
@@ -311,15 +311,9 @@ static void irda_config_fsm(void *data)
 			break;
 
 		case SIRDEV_STATE_SET_DTR_RTS:
-			if (dev->drv->set_dtr_rts) {
-				int	dtr, rts;
-
-				dtr = (fsm->param&0x02) ? TRUE : FALSE;
-				rts = (fsm->param&0x01) ? TRUE : FALSE;
-				ret = dev->drv->set_dtr_rts(dev,dtr,rts);
-			}
-			else
-				ret = -EINVAL;
+			ret = sirdev_set_dtr_rts(dev,
+				(fsm->param&0x02) ? TRUE : FALSE,
+				(fsm->param&0x01) ? TRUE : FALSE);
 			next_state = SIRDEV_STATE_DONE;
 			break;
 
