Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271753AbTHHTDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271807AbTHHTBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:01:36 -0400
Received: from palrel11.hp.com ([156.153.255.246]:41098 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S271742AbTHHSyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:54:49 -0400
Date: Fri, 8 Aug 2003 11:54:48 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] tekram-sir driver fix
Message-ID: <20030808185448.GG13274@bougret.hpl.hp.com>
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

ir260_tekram-sir.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
	o [CORRECT] Update tekram-sir dongle driver to common power-settling


diff -u -p linux/drivers/net/irda/tekram-sir.d2.c linux/drivers/net/irda/tekram-sir.c
--- linux/drivers/net/irda/tekram-sir.d2.c	Fri Aug  8 10:29:24 2003
+++ linux/drivers/net/irda/tekram-sir.c	Fri Aug  8 10:32:46 2003
@@ -71,38 +71,20 @@ void __exit tekram_sir_cleanup(void)
 	irda_unregister_dongle(&tekram);
 }
 
-#define TEKRAM_STATE_POWERED	(SIRDEV_STATE_DONGLE_OPEN + 1)
-
 static int tekram_open(struct sir_dev *dev)
 {
-	unsigned delay = 0;
-	unsigned next_state = dev->fsm.substate;
 	struct qos_info *qos = &dev->qos;
 
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
-	switch(dev->fsm.substate) {
-
-	case SIRDEV_STATE_DONGLE_OPEN:
-		dev->set_dtr_rts(dev, TRUE, TRUE);
-		next_state = TEKRAM_STATE_POWERED;
-		delay = 50;
-		break;
-
-	case TEKRAM_STATE_POWERED:
-		qos->baud_rate.bits &= IR_9600|IR_19200|IR_38400|IR_57600|IR_115200;
-		qos->min_turn_time.bits = 0x01; /* Needs at least 10 ms */	
-		irda_qos_bits_to_value(qos);
-		return 0;
-
-	default:
-		ERROR("%s - undefined state\n", __FUNCTION__);
-		return -EINVAL;
-	}
+	dev->set_dtr_rts(dev, TRUE, TRUE);
+	qos->baud_rate.bits &= IR_9600|IR_19200|IR_38400|IR_57600|IR_115200;
+	qos->min_turn_time.bits = 0x01; /* Needs at least 10 ms */	
+	irda_qos_bits_to_value(qos);
 
-	dev->fsm.substate = next_state;
+	/* irda thread waits 50 msec for power settling */
 
-	return delay;
+	return 0;
 }
 
 static int tekram_close(struct sir_dev *dev)
