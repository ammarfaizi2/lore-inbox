Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbSJKAM5>; Thu, 10 Oct 2002 20:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262241AbSJKALf>; Thu, 10 Oct 2002 20:11:35 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:33753 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262230AbSJKAKs>;
	Thu, 10 Oct 2002 20:10:48 -0400
Date: Thu, 10 Oct 2002 17:16:34 -0700
To: irda-users@lists.sourceforge.net, Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : ir251_ircomm_uninit_fix-6.diff
Message-ID: <20021011001633.GE6645@bougret.hpl.hp.com>
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

ir251_ircomm_uninit_fix-6.diff :
------------------------------
	o [FEATURE] Fix spelling UNITIALISED => UNINITIALISED
	o [CORRECT] Accept data from TTY before link initialisation
		This seems necessary to avoid chat (via pppd) dropping chars
	o [CRITICA] Remember allocated skb size to avoid to over-write it
	o [FEATURE] Remove  LM-IAS object once connected
	o [CORRECT] Avoid declaring link ready when it's not true



diff -u -p linux/include/net/irda/ircomm_tty.d3.h linux/include/net/irda/ircomm_tty.h
--- linux/include/net/irda/ircomm_tty.d3.h	Thu Oct 10 14:15:17 2002
+++ linux/include/net/irda/ircomm_tty.h	Thu Oct 10 14:16:17 2002
@@ -48,7 +48,9 @@
 /* This is used as an initial value to max_header_size before the proper
  * value is filled in (5 for ttp, 4 for lmp). This allow us to detect
  * the state of the underlying connection. - Jean II */
-#define IRCOMM_TTY_HDR_UNITIALISED	32
+#define IRCOMM_TTY_HDR_UNINITIALISED	16
+/* Same for payload size. See qos.c for the smallest max data size */
+#define IRCOMM_TTY_DATA_UNINITIALISED	(64 - IRCOMM_TTY_HDR_UNINITIALISED)
 
 /*
  * IrCOMM TTY driver state
@@ -83,6 +85,7 @@ struct ircomm_tty_cb {
 
 	__u32 max_data_size;   /* Max data we can transmit in one packet */
 	__u32 max_header_size; /* The amount of header space we must reserve */
+	__u32 tx_data_size;	/* Max data size of current tx_skb */
 
 	struct iriap_cb *iriap; /* Instance used for querying remote IAS */
 	struct ias_object* obj;
diff -u -p linux/net/irda/ircomm-d3/ircomm_tty.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm-d3/ircomm_tty.c	Thu Oct 10 11:48:24 2002
+++ linux/net/irda/ircomm/ircomm_tty.c	Thu Oct 10 14:22:03 2002
@@ -421,8 +421,8 @@ static int ircomm_tty_open(struct tty_st
 
 		self->line = line;
 		INIT_WORK(&self->tqueue, ircomm_tty_do_softint, self);
-		self->max_header_size = IRCOMM_TTY_HDR_UNITIALISED;
-		self->max_data_size = 64-self->max_header_size;
+		self->max_header_size = IRCOMM_TTY_HDR_UNINITIALISED;
+		self->max_data_size = IRCOMM_TTY_DATA_UNINITIALISED;
 		self->close_delay = 5*HZ/10;
 		self->closing_wait = 30*HZ;
 
@@ -719,16 +719,26 @@ static int ircomm_tty_write(struct tty_s
 
 	/* We may receive packets from the TTY even before we have finished
 	 * our setup. Not cool.
-	 * The problem is that we would allocate a skb with bogus header and
-	 * data size, and when adding data to it later we would get
-	 * confused.
-	 * Better to not accept data until we are properly setup. Use bogus
-	 * header size to check that (safest way to detect it).
+	 * The problem is that we don't know the final header and data size
+	 * to create the proper skb, so any skb we would create would have
+	 * bogus header and data size, so need care.
+	 * We use a bogus header size to safely detect this condition.
+	 * Another problem is that hw_stopped was set to 0 way before it
+	 * should be, so we would drop this skb. It should now be fixed.
+	 * One option is to not accept data until we are properly setup.
+	 * But, I suspect that when it happens, the ppp line discipline
+	 * just "drops" the data, which might screw up connect scripts.
+	 * The second option is to create a "safe skb", with large header
+	 * and small size (see ircomm_tty_open() for values).
+	 * We just need to make sure that when the real values get filled,
+	 * we don't mess up the original "safe skb" (see tx_data_size).
 	 * Jean II */
-	if (self->max_header_size == IRCOMM_TTY_HDR_UNITIALISED) {
-		/* TTY will retry */
-		IRDA_DEBUG(2, "%s() : not initialised\n", __FUNCTION__ );
-		return len;
+	if (self->max_header_size == IRCOMM_TTY_HDR_UNINITIALISED) {
+		IRDA_DEBUG(1, "%s() : not initialised\n", __FUNCTION__);
+#ifdef IRCOMM_NO_TX_BEFORE_INIT
+		/* We didn't consume anything, TTY will retry */
+		return 0;
+#endif
 	}
 
 	spin_lock_irqsave(&self->spinlock, flags);
@@ -761,8 +771,11 @@ static int ircomm_tty_write(struct tty_s
 			 * transmit buffer? Cannot use skb_tailroom, since
 			 * dev_alloc_skb gives us a larger skb than we 
 			 * requested
+			 * Note : use tx_data_size, because max_data_size
+			 * may have changed and we don't want to overwrite
+			 * the skb. - Jean II
 			 */
-			if ((tailroom = (self->max_data_size-skb->len)) > 0) {
+			if ((tailroom = (self->tx_data_size - skb->len)) > 0) {
 				/* Adjust data to tailroom */
 				if (size > tailroom)
 					size = tailroom;
@@ -783,6 +796,9 @@ static int ircomm_tty_write(struct tty_s
 			}
 			skb_reserve(skb, self->max_header_size);
 			self->tx_skb = skb;
+			/* Remember skb size because max_data_size may
+			 * change later on - Jean II */
+			self->tx_data_size = self->max_data_size;
 		}
 		
 		/* Copy data */
@@ -825,17 +841,22 @@ static int ircomm_tty_write_room(struct 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
 
+#ifdef IRCOMM_NO_TX_BEFORE_INIT
+	/* max_header_size tells us if the channel is initialised or not. */
+	if (self->max_header_size == IRCOMM_TTY_HDR_UNINITIALISED)
+		/* Don't bother us yet */
+		return 0;
+#endif
+
 	/* Check if we are allowed to transmit any data.
 	 * hw_stopped is the regular flow control.
-	 * max_header_size tells us if the channel is initialised or not.
 	 * Jean II */
-	if ((tty->hw_stopped) ||
-	    (self->max_header_size == IRCOMM_TTY_HDR_UNITIALISED))
+	if (tty->hw_stopped)
 		ret = 0;
 	else {
 		spin_lock_irqsave(&self->spinlock, flags);
 		if (self->tx_skb)
-			ret = self->max_data_size - self->tx_skb->len;
+			ret = self->tx_data_size - self->tx_skb->len;
 		else
 			ret = self->max_data_size;
 		spin_unlock_irqrestore(&self->spinlock, flags);
diff -u -p linux/net/irda/ircomm-d3/ircomm_tty_attach.c linux/net/irda/ircomm/ircomm_tty_attach.c
--- linux/net/irda/ircomm-d3/ircomm_tty_attach.c	Thu Oct 10 11:48:24 2002
+++ linux/net/irda/ircomm/ircomm_tty_attach.c	Thu Oct 10 14:23:42 2002
@@ -517,6 +517,23 @@ void ircomm_tty_link_established(struct 
 	
 	del_timer(&self->watchdog_timer);
 
+	/* Remove LM-IAS object now so it is not reused.
+	 * IrCOMM deals very poorly with multiple incomming connections.
+	 * It should looks a lot more like IrNET, and "dup" a server TSAP
+	 * to the application TSAP (based on various rules).
+	 * This is a cheap workaround allowing multiple clients to
+	 * connect to us. It will not always work.
+	 * Each IrCOMM socket has an IAS entry. Incomming connection will
+	 * pick the first one found. So, when we are fully connected,
+	 * we remove our IAS entries so that the next IAS entry is used.
+	 * We do that for *both* client and server, because a server
+	 * can also create client instances.
+	 * Jean II */
+	if (self->obj) {
+		irias_delete_object(self->obj);
+		self->obj = NULL;
+	}
+
 	/* 
 	 * IrCOMM link is now up, and if we are not using hardware
 	 * flow-control, then declare the hardware as running. Otherwise we
@@ -527,7 +544,7 @@ void ircomm_tty_link_established(struct 
 		IRDA_DEBUG(0, "%s(), waiting for CTS ...\n", __FUNCTION__ );
 		return;
 	} else {
-		IRDA_DEBUG(2, "%s(), starting hardware!\n", __FUNCTION__ );
+		IRDA_DEBUG(1, "%s(), starting hardware!\n", __FUNCTION__ );
 
 		self->tty->hw_stopped = 0;
 	
diff -u -p linux/net/irda/ircomm-d3/ircomm_param.c linux/net/irda/ircomm/ircomm_param.c
--- linux/net/irda/ircomm-d3/ircomm_param.c	Thu Oct 10 11:48:24 2002
+++ linux/net/irda/ircomm/ircomm_param.c	Thu Oct 10 14:16:17 2002
@@ -220,9 +220,16 @@ static int ircomm_param_service_type(voi
 
 	/* 
 	 * Now the line is ready for some communication. Check if we are a
-         * server, and send over some initial parameters 
+         * server, and send over some initial parameters.
+	 * Client do it in ircomm_tty_state_setup().
+	 * Note : we may get called from ircomm_tty_getvalue_confirm(),
+	 * therefore before we even have open any socket. And self->client
+	 * is initialised to TRUE only later. So, we check if the link is
+	 * really initialised. - Jean II
 	 */
-	if (!self->client && (self->settings.service_type != IRCOMM_3_WIRE_RAW))
+	if ((self->max_header_size != IRCOMM_TTY_HDR_UNINITIALISED) &&
+	    (!self->client) &&
+	    (self->settings.service_type != IRCOMM_3_WIRE_RAW))
 	{
 		/* Init connection */
 		ircomm_tty_send_initial_parameters(self);
