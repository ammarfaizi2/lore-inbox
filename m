Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262113AbRE0UBZ>; Sun, 27 May 2001 16:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262112AbRE0UBQ>; Sun, 27 May 2001 16:01:16 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:47937
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S262099AbRE0UBD>; Sun, 27 May 2001 16:01:03 -0400
Date: Sun, 27 May 2001 22:00:56 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: dag@brattli.net
Cc: linux-kernel@vger.kernel.org, linux-irda@pasta.cs.uit.no
Subject: [PATCH] Fix interrupt flag bug(s) in irtty.c (244-ac18)
Message-ID: <20010527220056.N857@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch fixes an interrupt flag bug in irtty.c
as per the stanford team's report way back. Applies against
224-ac18.


--- linux-244-ac18-clean/drivers/net/irda/irtty.c	Sat May 19 20:59:17 2001
+++ linux-244-ac18/drivers/net/irda/irtty.c	Sun May 27 21:56:14 2001
@@ -971,13 +971,17 @@
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
 		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		irda_task_execute(self, irtty_change_speed, NULL, NULL, 
-				  (void *) irq->ifr_baudrate);
+			ret = -EPERM;
+		else
+			irda_task_execute(self, irtty_change_speed, NULL, NULL, 
+					  (void *) irq->ifr_baudrate);
 		break;
 	case SIOCSDONGLE: /* Set dongle */
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
+		if (!capable(CAP_NET_ADMIN)) {
+			ret = -EPERM;
+			break;
+		}
+
 		/* Initialize dongle */
 		dongle = irda_device_dongle_init(dev, irq->ifr_dongle);
 		if (!dongle)
@@ -999,21 +1003,24 @@
 		break;
 	case SIOCSMEDIABUSY: /* Set media busy */
 		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		irda_device_set_media_busy(self->netdev, TRUE);
+			ret = -EPERM;
+		else
+			irda_device_set_media_busy(self->netdev, TRUE);
 		break;
 	case SIOCGRECEIVING: /* Check if we are receiving right now */
 		irq->ifr_receiving = irtty_is_receiving(self);
 		break;
 	case SIOCSDTRRTS:
 		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		irtty_set_dtr_rts(dev, irq->ifr_dtr, irq->ifr_rts);
+			ret = -EPERM;
+		else
+			irtty_set_dtr_rts(dev, irq->ifr_dtr, irq->ifr_rts);
 		break;
 	case SIOCSMODE:
 		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		irtty_set_mode(dev, irq->ifr_mode);
+			ret = -EPERM;
+		else
+			irtty_set_mode(dev, irq->ifr_mode);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Things are more like they are now than they ever were before.
-Former U.S. President Dwight D. Eisenhower
