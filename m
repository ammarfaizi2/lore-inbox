Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265247AbSLBXkH>; Mon, 2 Dec 2002 18:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbSLBXig>; Mon, 2 Dec 2002 18:38:36 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:55807 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265228AbSLBXfm>;
	Mon, 2 Dec 2002 18:35:42 -0500
Date: Mon, 2 Dec 2002 15:41:40 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: [PATCH 2.4] : ir241_checker.diff
Message-ID: <20021202234140.GI16284@bougret.hpl.hp.com>
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

ir241_checker.diff :
------------------
	<Need to apply after ir241_flow_sched_XXX.diff to avoid "offset">
	o [CORRECT] Fix two bugs found by the Stanford checker in IrDA
	o [CORRECT] Fix two bugs found by the Stanford checker in IrCOMM
	o [CORRECT] Fix one bug found by the Stanford checker in ali driver


diff -u -p -r linux/net/irda/irlap.d2.c linux/net/irda/irlap.c
--- linux/net/irda/irlap.d2.c	Tue Aug  6 18:22:38 2002
+++ linux/net/irda/irlap.c	Tue Aug  6 18:23:24 2002
@@ -1101,8 +1101,8 @@ int irlap_proc_read(char *buf, char **st
 
 	self = (struct irlap_cb *) hashbin_get_first(irlap);
 	while (self != NULL) {
-		ASSERT(self != NULL, return -ENODEV;);
-		ASSERT(self->magic == LAP_MAGIC, return -EBADR;);
+		ASSERT(self != NULL, break;);
+		ASSERT(self->magic == LAP_MAGIC, break;);
 
 		len += sprintf(buf+len, "irlap%d ", i++);
 		len += sprintf(buf+len, "state: %s\n", 
diff -u -p -r linux/net/irda/irlmp.d2.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d2.c	Tue Aug  6 18:22:46 2002
+++ linux/net/irda/irlmp.c	Tue Aug  6 18:23:24 2002
@@ -1750,7 +1750,7 @@ int irlmp_proc_read(char *buf, char **st
 	len += sprintf( buf+len, "Unconnected LSAPs:\n");
 	self = (struct lsap_cb *) hashbin_get_first( irlmp->unconnected_lsaps);
 	while (self != NULL) {
-		ASSERT(self->magic == LMP_LSAP_MAGIC, return 0;);
+		ASSERT(self->magic == LMP_LSAP_MAGIC, break;);
 		len += sprintf(buf+len, "lsap state: %s, ", 
 			       irlsap_state[ self->lsap_state]);
 		len += sprintf(buf+len, 
@@ -1779,7 +1779,7 @@ int irlmp_proc_read(char *buf, char **st
 		len += sprintf(buf+len, "\n  Connected LSAPs:\n");
 		self = (struct lsap_cb *) hashbin_get_first(lap->lsaps);
 		while (self != NULL) {
-			ASSERT(self->magic == LMP_LSAP_MAGIC, return 0;);
+			ASSERT(self->magic == LMP_LSAP_MAGIC, break;);
 			len += sprintf(buf+len, "  lsap state: %s, ", 
 				       irlsap_state[ self->lsap_state]);
 			len += sprintf(buf+len, 
diff -u -p linux/net/irda/ircomm/ircomm_core.d0.c linux/net/irda/ircomm/ircomm_core.c
--- linux/net/irda/ircomm/ircomm_core.d0.c	Tue Aug  6 18:23:01 2002
+++ linux/net/irda/ircomm/ircomm_core.c	Tue Aug  6 18:23:24 2002
@@ -498,7 +498,7 @@ int ircomm_proc_read(char *buf, char **s
 
 	self = (struct ircomm_cb *) hashbin_get_first(ircomm);
 	while (self != NULL) {
-		ASSERT(self->magic == IRCOMM_MAGIC, return len;);
+		ASSERT(self->magic == IRCOMM_MAGIC, break;);
 
 		if(self->line < 0x10)
 			len += sprintf(buf+len, "ircomm%d", self->line);
diff -u -p linux/net/irda/ircomm/ircomm_tty.d0.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm/ircomm_tty.d0.c	Tue Aug  6 18:23:12 2002
+++ linux/net/irda/ircomm/ircomm_tty.c	Tue Aug  6 18:23:24 2002
@@ -512,6 +512,9 @@ static void ircomm_tty_close(struct tty_
 	if (!tty)
 		return;
 
+	ASSERT(self != NULL, return;);
+	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
+
 	save_flags(flags); 
 	cli();
 
@@ -522,9 +525,6 @@ static void ircomm_tty_close(struct tty_
 		IRDA_DEBUG(0, "%s(), returning 1\n", __FUNCTION__);
 		return;
 	}
-
-	ASSERT(self != NULL, return;);
-	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
 
 	if ((tty->count == 1) && (self->open_count != 1)) {
 		/*
diff -u -p linux/drivers/net/irda/ali-ircc.d2.c  linux/drivers/net/irda/ali-ircc.c
--- linux/drivers/net/irda/ali-ircc.d2.c	Mon Dec  2 15:03:38 2002
+++ linux/drivers/net/irda/ali-ircc.c	Mon Dec  2 15:03:44 2002
@@ -2017,22 +2017,19 @@ static int ali_ircc_net_ioctl(struct net
 
 	IRDA_DEBUG(2, "%s(), %s, (cmd=0x%X)\n", __FUNCTION__, dev->name, cmd);
 	
-	/* Disable interrupts & save flags */
-	save_flags(flags);
-	cli();	
-	
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
 		IRDA_DEBUG(1, "%s(), SIOCSBANDWIDTH\n", __FUNCTION__);
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
 		IRDA_DEBUG(1, "%s(), SIOCSMEDIABUSY\n", __FUNCTION__);
@@ -2042,14 +2039,17 @@ static int ali_ircc_net_ioctl(struct net
 		break;
 	case SIOCGRECEIVING: /* Check if we are receiving right now */
 		IRDA_DEBUG(2, "%s(), SIOCGRECEIVING\n", __FUNCTION__);
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
-	
+
 	IRDA_DEBUG(2, "%s(), ----------------- End ------------------\n", __FUNCTION__);	
 	
 	return ret;
