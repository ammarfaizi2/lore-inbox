Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266819AbUAXCTv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 21:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUAXCTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 21:19:51 -0500
Received: from palrel12.hp.com ([156.153.255.237]:60057 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266819AbUAXCTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 21:19:40 -0500
Date: Fri, 23 Jan 2004 18:19:38 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] 2/11: actisys-sir: dongle api change
Message-ID: <20040124021938.GC22410@bougret.hpl.hp.com>
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

ir262_dongles-2_actisys-sir.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* convert to de-virtualized sirdev helpers
* improve error path during speed change


diff -u -p linux/drivers/net/irda.d6/actisys-sir.c  linux/drivers/net/irda/actisys-sir.c
--- linux/drivers/net/irda.d6/actisys-sir.c	Wed Dec 17 18:58:57 2003
+++ linux/drivers/net/irda/actisys-sir.c	Thu Jan 22 16:43:16 2004
@@ -65,7 +65,7 @@ static int actisys_reset(struct sir_dev 
 
 /* These are the baudrates supported, in the order available */
 /* Note : the 220L doesn't support 38400, but we will fix that below */
-static __u32 baud_rates[] = { 9600, 19200, 57600, 115200, 38400 };
+static unsigned baud_rates[] = { 9600, 19200, 57600, 115200, 38400 };
 
 #define MAX_SPEEDS (sizeof(baud_rates)/sizeof(baud_rates[0]))
 
@@ -118,7 +118,7 @@ static int actisys_open(struct sir_dev *
 {
 	struct qos_info *qos = &dev->qos;
 
-	dev->set_dtr_rts(dev, TRUE, TRUE);
+	sirdev_set_dtr_rts(dev, TRUE, TRUE);
 
 	/* Set the speeds we can accept */
 	qos->baud_rate.bits &= IR_9600|IR_19200|IR_38400|IR_57600|IR_115200;
@@ -130,13 +130,15 @@ static int actisys_open(struct sir_dev *
 	qos->min_turn_time.bits = 0x7f; /* Needs 0.01 ms */
 	irda_qos_bits_to_value(qos);
 
+	/* irda thread waits 50 msec for power settling */
+
 	return 0;
 }
 
 static int actisys_close(struct sir_dev *dev)
 {
 	/* Power off the dongle */
-	dev->set_dtr_rts(dev, FALSE, FALSE);
+	sirdev_set_dtr_rts(dev, FALSE, FALSE);
 
 	return 0;
 }
@@ -174,23 +176,25 @@ static int actisys_change_speed(struct s
 	 * Now, we can set the speed requested. Send RTS pulses until we
          * reach the target speed 
 	 */
-	for (i=0; i<MAX_SPEEDS; i++) {
+	for (i = 0; i < MAX_SPEEDS; i++) {
 		if (speed == baud_rates[i]) {
-			dev->speed = baud_rates[i];
+			dev->speed = speed;
 			break;
 		}
 		/* Set RTS low for 10 us */
-		dev->set_dtr_rts(dev, TRUE, FALSE);
+		sirdev_set_dtr_rts(dev, TRUE, FALSE);
 		udelay(MIN_DELAY);
 
 		/* Set RTS high for 10 us */
-		dev->set_dtr_rts(dev, TRUE, TRUE);
+		sirdev_set_dtr_rts(dev, TRUE, TRUE);
 		udelay(MIN_DELAY);
 	}
 
 	/* Check if life is sweet... */
-	if (i >= MAX_SPEEDS)
-		ret = -1;  /* This should not happen */
+	if (i >= MAX_SPEEDS) {
+		actisys_reset(dev);
+		ret = -EINVAL;  /* This should not happen */
+	}
 
 	/* Basta lavoro, on se casse d'ici... */
 	return ret;
@@ -221,11 +225,11 @@ static int actisys_change_speed(struct s
 static int actisys_reset(struct sir_dev *dev)
 {
 	/* Reset the dongle : set DTR low for 10 us */
-	dev->set_dtr_rts(dev, FALSE, TRUE);
+	sirdev_set_dtr_rts(dev, FALSE, TRUE);
 	udelay(MIN_DELAY);
 
 	/* Go back to normal mode */
-	dev->set_dtr_rts(dev, TRUE, TRUE);
+	sirdev_set_dtr_rts(dev, TRUE, TRUE);
 	
 	dev->speed = 9600;	/* That's the default */
 
