Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUAXCW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 21:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbUAXCW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 21:22:56 -0500
Received: from palrel13.hp.com ([156.153.255.238]:13255 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266850AbUAXCUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 21:20:55 -0500
Date: Fri, 23 Jan 2004 18:20:54 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] 4/11: tekram-sir: dongle api change
Message-ID: <20040124022054.GE22410@bougret.hpl.hp.com>
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

ir262_dongles-4_tekram-sir-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
* increase default write-delay to 150msec
* convert to de-virtualized sirdev helpers


diff -u -p linux/drivers/net/irda.d6/tekram-sir.c  linux/drivers/net/irda/tekram-sir.c
--- linux/drivers/net/irda.d6/tekram-sir.c	Wed Dec 17 18:58:30 2003
+++ linux/drivers/net/irda/tekram-sir.c	Thu Jan 22 16:43:26 2004
@@ -34,7 +34,7 @@
 
 MODULE_PARM(tekram_delay, "i");
 MODULE_PARM_DESC(tekram_delay, "tekram dongle write complete delay");
-static int tekram_delay = 50;		/* default is 50 ms */
+static int tekram_delay = 150;		/* default is 150 ms */
 
 static int tekram_open(struct sir_dev *);
 static int tekram_close(struct sir_dev *);
@@ -61,8 +61,10 @@ static struct dongle_driver tekram = {
 
 int __init tekram_sir_init(void)
 {
-	if (tekram_delay < 1  ||  tekram_delay>500)
+	if (tekram_delay < 1  ||  tekram_delay > 500)
 		tekram_delay = 200;
+	IRDA_DEBUG(1, "%s - using %d ms delay\n",
+		tekram.driver_name, tekram_delay);
 	return irda_register_dongle(&tekram);
 }
 
@@ -77,7 +79,8 @@ static int tekram_open(struct sir_dev *d
 
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
-	dev->set_dtr_rts(dev, TRUE, TRUE);
+	sirdev_set_dtr_rts(dev, TRUE, TRUE);
+
 	qos->baud_rate.bits &= IR_9600|IR_19200|IR_38400|IR_57600|IR_115200;
 	qos->min_turn_time.bits = 0x01; /* Needs at least 10 ms */	
 	irda_qos_bits_to_value(qos);
@@ -92,7 +95,7 @@ static int tekram_close(struct sir_dev *
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	/* Power off dongle */
-	dev->set_dtr_rts(dev, FALSE, FALSE);
+	sirdev_set_dtr_rts(dev, FALSE, FALSE);
 
 	return 0;
 }
@@ -122,19 +125,20 @@ static int tekram_close(struct sir_dev *
 
 static int tekram_change_speed(struct sir_dev *dev, unsigned speed)
 {
+	unsigned state = dev->fsm.substate;
 	unsigned delay = 0;
-	unsigned next_state = dev->fsm.substate;
 	u8 byte;
+	static int ret = 0;
 	
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
-	switch(dev->fsm.substate) {
-
+	switch(state) {
 	case SIRDEV_STATE_DONGLE_SPEED:
 
 		switch (speed) {
 		default:
 			speed = 9600;
+			ret = -EINVAL;
 			/* fall thru */
 		case 9600:
 			byte = TEKRAM_PW|TEKRAM_9600;
@@ -154,36 +158,34 @@ static int tekram_change_speed(struct si
 		}
 
 		/* Set DTR, Clear RTS */
-		dev->set_dtr_rts(dev, TRUE, FALSE);
+		sirdev_set_dtr_rts(dev, TRUE, FALSE);
 	
 		/* Wait at least 7us */
 		udelay(14);
 
 		/* Write control byte */
-		dev->write(dev, &byte, 1);
+		sirdev_raw_write(dev, &byte, 1);
 		
 		dev->speed = speed;
 
-		next_state = TEKRAM_STATE_WAIT_SPEED;
-		delay = tekram_delay;		/* default: 50 ms */
+		state = TEKRAM_STATE_WAIT_SPEED;
+		delay = tekram_delay;
 		break;
 
 	case TEKRAM_STATE_WAIT_SPEED:
 		/* Set DTR, Set RTS */
-		dev->set_dtr_rts(dev, TRUE, TRUE);
-
+		sirdev_set_dtr_rts(dev, TRUE, TRUE);
 		udelay(50);
-
-		return 0;
+		break;
 
 	default:
-		ERROR("%s - undefined state\n", __FUNCTION__);
-		return -EINVAL;
+		ERROR("%s - undefined state %d\n", __FUNCTION__, state);
+		ret = -EINVAL;
+		break;
 	}
 
-	dev->fsm.substate = next_state;
-
-	return delay;
+	dev->fsm.substate = state;
+	return (delay > 0) ? delay : ret;
 }
 
 /*
@@ -200,43 +202,26 @@ static int tekram_change_speed(struct si
  *         operation
  */
 
-
-#define TEKRAM_STATE_WAIT_RESET	(SIRDEV_STATE_DONGLE_RESET + 1)
-
 static int tekram_reset(struct sir_dev *dev)
 {
-	unsigned delay = 0;
-	unsigned next_state = dev->fsm.substate;
-
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
-	switch(dev->fsm.substate) {
-
-	case SIRDEV_STATE_DONGLE_RESET:
-		/* Clear DTR, Set RTS */
-		dev->set_dtr_rts(dev, FALSE, TRUE); 
+	/* Clear DTR, Set RTS */
+	sirdev_set_dtr_rts(dev, FALSE, TRUE); 
 
-		next_state = TEKRAM_STATE_WAIT_RESET;
-		delay = 1;		/* Should sleep 1 ms */
-		break;
+	/* Should sleep 1 ms */
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(MSECS_TO_JIFFIES(1));
 
-	case TEKRAM_STATE_WAIT_RESET:
-		/* Set DTR, Set RTS */
-		dev->set_dtr_rts(dev, TRUE, TRUE);
+	/* Set DTR, Set RTS */
+	sirdev_set_dtr_rts(dev, TRUE, TRUE);
 	
-		/* Wait at least 50 us */
-		udelay(75);
+	/* Wait at least 50 us */
+	udelay(75);
 
-		return 0;
+	dev->speed = 9600;
 
-	default:
-		ERROR("%s - undefined state\n", __FUNCTION__);
-		return -EINVAL;
-	}
-
-	dev->fsm.substate = next_state;
-
-	return delay;
+	return 0;
 }
 
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
