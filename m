Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266855AbUAXCZS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 21:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266854AbUAXCXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 21:23:16 -0500
Received: from palrel10.hp.com ([156.153.255.245]:27286 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S266702AbUAXCUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 21:20:17 -0500
Date: Fri, 23 Jan 2004 18:20:16 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] 3/11: esi-sir: dongle api change
Message-ID: <20040124022016.GD22410@bougret.hpl.hp.com>
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

ir262_dongles-3_esi-sir.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* convert to de-virtualized sirdev helpers
* add probably missing dongle power-up operation


diff -u -p linux/drivers/net/irda.d6/esi-sir.c  linux/drivers/net/irda/esi-sir.c
--- linux/drivers/net/irda.d6/esi-sir.c	Wed Dec 17 18:59:18 2003
+++ linux/drivers/net/irda/esi-sir.c	Thu Jan 22 16:43:22 2004
@@ -68,11 +68,14 @@ static int esi_open(struct sir_dev *dev)
 {
 	struct qos_info *qos = &dev->qos;
 
+	/* Power up and set dongle to 9600 baud */
+	sirdev_set_dtr_rts(dev, FALSE, TRUE);
+
 	qos->baud_rate.bits &= IR_9600|IR_19200|IR_115200;
 	qos->min_turn_time.bits = 0x01; /* Needs at least 10 ms */
 	irda_qos_bits_to_value(qos);
 
-	/* shouldn't we do set_dtr_rts(FALSE, TRUE) here (power up at 9600)? */
+	/* irda thread waits 50 msec for power settling */
 
 	return 0;
 }
@@ -80,7 +83,7 @@ static int esi_open(struct sir_dev *dev)
 static int esi_close(struct sir_dev *dev)
 {
 	/* Power off dongle */
-	dev->set_dtr_rts(dev, FALSE, FALSE);
+	sirdev_set_dtr_rts(dev, FALSE, FALSE);
 
 	return 0;
 }
@@ -88,11 +91,13 @@ static int esi_close(struct sir_dev *dev
 /*
  * Function esi_change_speed (task)
  *
- *    Set the speed for the Extended Systems JetEye PC ESI-9680 type dongle
+ * Set the speed for the Extended Systems JetEye PC ESI-9680 type dongle
+ * Apparently (see old esi-driver) no delays are needed here...
  *
  */
 static int esi_change_speed(struct sir_dev *dev, unsigned speed)
 {
+	int ret = 0;
 	int dtr, rts;
 	
 	switch (speed) {
@@ -104,6 +109,7 @@ static int esi_change_speed(struct sir_d
 		dtr = rts = TRUE;
 		break;
 	default:
+		ret = -EINVAL;
 		speed = 9600;
 		/* fall through */
 	case 9600:
@@ -113,12 +119,10 @@ static int esi_change_speed(struct sir_d
 	}
 
 	/* Change speed of dongle */
-	dev->set_dtr_rts(dev, dtr, rts);
+	sirdev_set_dtr_rts(dev, dtr, rts);
 	dev->speed = speed;
 
-	/* do we need some delay for power stabilization? */
-
-	return 0;
+	return ret;
 }
 
 /*
@@ -129,9 +133,18 @@ static int esi_change_speed(struct sir_d
  */
 static int esi_reset(struct sir_dev *dev)
 {
-	dev->set_dtr_rts(dev, FALSE, FALSE);
+	sirdev_set_dtr_rts(dev, FALSE, FALSE);
+
+	/* Hm, the old esi-driver left the dongle unpowered relying on
+	 * the following speed change to repower. This might work for
+	 * the esi because we only need the modem lines. However, now the
+	 * general rule is reset must bring the dongle to some working
+	 * well-known state because speed change might write to registers.
+	 * The old esi-driver didn't any delay here - let's hope it' fine.
+	 */
 
-	/* Hm, probably repower to 9600 and some delays? */
+	sirdev_set_dtr_rts(dev, FALSE, TRUE);
+	dev->speed = 9600;
 
 	return 0;
 }
