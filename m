Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317985AbSGPUzc>; Tue, 16 Jul 2002 16:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317986AbSGPUyu>; Tue, 16 Jul 2002 16:54:50 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:40151 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317982AbSGPUxM>;
	Tue, 16 Jul 2002 16:53:12 -0400
Date: Tue, 16 Jul 2002 13:56:08 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir255_checker.diff-2
Message-ID: <20020716135608.E28412@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir255_checker.diff-2 :
--------------------
	o [CORRECT] Fix two bugs found by the Stanford checker


diff -u -p -r linux/net/irda/irlap.d2.c linux/net/irda/irlap.c
--- linux/net/irda/irlap.d2.c	Tue Jul 16 13:36:28 2002
+++ linux/net/irda/irlap.c	Tue Jul 16 13:36:51 2002
@@ -1091,8 +1091,8 @@ int irlap_proc_read(char *buf, char **st
 
 	self = (struct irlap_cb *) hashbin_get_first(irlap);
 	while (self != NULL) {
-		ASSERT(self != NULL, return -ENODEV;);
-		ASSERT(self->magic == LAP_MAGIC, return -EBADR;);
+		ASSERT(self != NULL, break;);
+		ASSERT(self->magic == LAP_MAGIC, break;);
 
 		len += sprintf(buf+len, "irlap%d ", i++);
 		len += sprintf(buf+len, "state: %s\n",
diff -u -p -r linux/net/irda/irlmp.d2.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d2.c	Tue Jul 16 13:36:34 2002
+++ linux/net/irda/irlmp.c	Tue Jul 16 13:36:51 2002
@@ -1735,7 +1735,7 @@ int irlmp_proc_read(char *buf, char **st
 	len += sprintf( buf+len, "Unconnected LSAPs:\n");
 	self = (struct lsap_cb *) hashbin_get_first( irlmp->unconnected_lsaps);
 	while (self != NULL) {
-		ASSERT(self->magic == LMP_LSAP_MAGIC, return 0;);
+		ASSERT(self->magic == LMP_LSAP_MAGIC, break;);
 		len += sprintf(buf+len, "lsap state: %s, ",
 			       irlsap_state[ self->lsap_state]);
 		len += sprintf(buf+len,
@@ -1764,7 +1764,7 @@ int irlmp_proc_read(char *buf, char **st
 		len += sprintf(buf+len, "\n  Connected LSAPs:\n");
 		self = (struct lsap_cb *) hashbin_get_first(lap->lsaps);
 		while (self != NULL) {
-			ASSERT(self->magic == LMP_LSAP_MAGIC, return 0;);
+			ASSERT(self->magic == LMP_LSAP_MAGIC, break;);
 			len += sprintf(buf+len, "  lsap state: %s, ",
 				       irlsap_state[ self->lsap_state]);
 			len += sprintf(buf+len,
diff -u -p linux/drivers/net/irda/ali-ircc.d2.c  linux/drivers/net/irda/ali-ircc.c
--- linux/drivers/net/irda/ali-ircc.d2.c	Tue Jul 16 13:36:48 2002
+++ linux/drivers/net/irda/ali-ircc.c	Tue Jul 16 13:36:51 2002
@@ -2028,22 +2028,20 @@ static int ali_ircc_net_ioctl(struct net
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
 	
-	/* Disable interrupts & save flags */
-	save_flags(flags);
-	cli();	
 	
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
 		IRDA_DEBUG(1, __FUNCTION__ "(), SIOCSBANDWIDTH\n");
-		/*
-		 * This function will also be used by IrLAP to change the
-		 * speed, so we still must allow for speed change within
-		 * interrupt context.
-		 */
-		if (!in_interrupt() && !capable(CAP_NET_ADMIN))
+		/* Root only */
+		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
 		
+		/* Is it really needed ? And what about spinlock ? */
+		save_flags(flags);
+		cli();	
+
 		ali_ircc_change_speed(self, irq->ifr_baudrate);		
+		restore_flags(flags);
 		break;
 	case SIOCSMEDIABUSY: /* Set media busy */
 		IRDA_DEBUG(1, __FUNCTION__ "(), SIOCSMEDIABUSY\n");
@@ -2053,13 +2051,16 @@ static int ali_ircc_net_ioctl(struct net
 		break;
 	case SIOCGRECEIVING: /* Check if we are receiving right now */
 		IRDA_DEBUG(2, __FUNCTION__ "(), SIOCGRECEIVING\n");
+		/* Is it really needed ? And what about spinlock ? */
+		save_flags(flags);
+		cli();	
+
 		irq->ifr_receiving = ali_ircc_is_receiving(self);
+		restore_flags(flags);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
 	}
-	
-	restore_flags(flags);
 	
 	IRDA_DEBUG(2, __FUNCTION__ "(), ----------------- End ------------------\n");	
 	
