Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262557AbREZUc7>; Sat, 26 May 2001 16:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262554AbREZUcs>; Sat, 26 May 2001 16:32:48 -0400
Received: from [213.237.12.194] ([213.237.12.194]:26932 "HELO
	firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S262532AbREZUcg>; Sat, 26 May 2001 16:32:36 -0400
Date: Sat, 26 May 2001 22:05:46 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: dag@brattli.net
Cc: linux-irda@pasta.cs.uit.no, linux-kernel@vger.kernel.org
Subject: [PATCH] fix interrupt flag bugs in irport.c (2.4.4-ac18)
Message-ID: <20010526220546.C857@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch tries to correct the interrupt bugs found
by the stanford team a long time ago in drivers/net/irda/irport.c.
Applies against 2.4.4-ac18.


--- linux-244-ac18-clean/drivers/net/irda/irport.c	Sat May 19 20:59:17 2001
+++ linux-244-ac18/drivers/net/irda/irport.c	Sat May 26 21:35:59 2001
@@ -951,13 +951,17 @@
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
 		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		irda_task_execute(self, __irport_change_speed, NULL, NULL, 
-				  (void *) irq->ifr_baudrate);
+			ret = -EPERM;
+                else
+			irda_task_execute(self, __irport_change_speed, NULL, 
+					  NULL, (void *) irq->ifr_baudrate);
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
@@ -978,16 +982,22 @@
 				  NULL);	
 		break;
 	case SIOCSMEDIABUSY: /* Set media busy */
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
+		if (!capable(CAP_NET_ADMIN)) {
+			ret = -EPERM;
+			break;
+		}
+
 		irda_device_set_media_busy(self->netdev, TRUE);
 		break;
 	case SIOCGRECEIVING: /* Check if we are receiving right now */
 		irq->ifr_receiving = irport_is_receiving(self);
 		break;
 	case SIOCSDTRRTS:
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
+		if (!capable(CAP_NET_ADMIN)) {
+			ret = -EPERM;
+			break;
+		}
+
 		irport_set_dtr_rts(dev, irq->ifr_dtr, irq->ifr_rts);
 		break;
 	default:

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

A great many people think they are thinking when they are merely 
rearranging their prejudices. -- William James 
