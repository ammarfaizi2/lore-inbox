Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTFQBuq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 21:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTFQBuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 21:50:46 -0400
Received: from palrel13.hp.com ([156.153.255.238]:56478 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264509AbTFQBuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:50:05 -0400
Date: Mon, 16 Jun 2003 19:03:53 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] IrCOMM chat fixes
Message-ID: <20030617020353.GB30944@bougret.hpl.hp.com>
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

ir241_ircomm_uninit_fix-6.diff :
	o [FEATURE] Fix spelling UNITIALISED => UNINITIALISED
	o [CORRECT] Accept data from TTY before link initialisation
		This seems necessary to avoid chat (via pppd) dropping chars
	o [CRITICA] Remember allocated skb size to avoid to over-write it
	o [FEATURE] Remove  LM-IAS object once connected
	o [CORRECT] Avoid declaring link ready when it's not true


diff -u -p linux/include/net/irda/ircomm_tty.d3.h linux/include/net/irda/ircomm_tty.h
--- linux/include/net/irda/ircomm_tty.d3.h	Mon Aug 26 11:20:23 2002
+++ linux/include/net/irda/ircomm_tty.h	Tue Aug 27 16:42:34 2002
@@ -47,7 +47,9 @@
 /* This is used as an initial value to max_header_size before the proper
  * value is filled in (5 for ttp, 4 for lmp). This allow us to detect
  * the state of the underlying connection. - Jean II */
-#define IRCOMM_TTY_HDR_UNITIALISED	32
+#define IRCOMM_TTY_HDR_UNINITIALISED	16
+/* Same for payload size. See qos.c for the smallest max data size */
+#define IRCOMM_TTY_DATA_UNINITIALISED	(64 - IRCOMM_TTY_HDR_UNINITIALISED)
 
 /*
  * IrCOMM TTY driver state
@@ -82,6 +84,7 @@ struct ircomm_tty_cb {
 
 	__u32 max_data_size;   /* Max data we can transmit in one packet */
 	__u32 max_header_size; /* The amount of header space we must reserve */
+	__u32 tx_data_size;	/* Max data size of current tx_skb */
 
 	struct iriap_cb *iriap; /* Instance used for querying remote IAS */
 	struct ias_object* obj;
diff -u -p linux/net/irda/ircomm-d3/ircomm_tty.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm-d3/ircomm_tty.c	Thu Sep 12 10:31:43 2002
+++ linux/net/irda/ircomm/ircomm_tty.c	Thu Sep 12 11:37:06 2002
@@ -417,8 +417,8 @@ static int ircomm_tty_open(struct tty_st
 		self->line = line;
 		self->tqueue.routine = ircomm_tty_do_softint;
 		self->tqueue.data = self;
-		self->max_header_size = IRCOMM_TTY_HDR_UNITIALISED;
-		self->max_data_size = 64-self->max_header_size;
+		self->max_header_size = IRCOMM_TTY_HDR_UNINITIALISED;
+		self->max_data_size = IRCOMM_TTY_DATA_UNINITIALISED;
 		self->close_delay = 5*HZ/10;
 		self->closing_wait = 30*HZ;
 
@@ -696,16 +696,26 @@ static int ircomm_tty_write(struct tty_s
 
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
-		IRDA_DEBUG(2, __FUNCTION__ "() : not initialised\n");
-		return len;
+	if (self->max_header_size == IRCOMM_TTY_HDR_UNINITIALISED) {
+		IRDA_DEBUG(1, "%s() : not initialised\n", __FUNCTION__);
+#ifdef IRCOMM_NO_TX_BEFORE_INIT
+		/* We didn't consume anything, TTY will retry */
+		return 0;
+#endif
 	}
 
 	save_flags(flags);
@@ -739,8 +749,11 @@ static int ircomm_tty_write(struct tty_s
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
@@ -761,6 +774,9 @@ static int ircomm_tty_write(struct tty_s
 			}
 			skb_reserve(skb, self->max_header_size);
 			self->tx_skb = skb;
+			/* Remember skb size because max_data_size may
+			 * change later on - Jean II */
+			self->tx_data_size = self->max_data_size;
 		}
 		
 		/* Copy data */
@@ -804,18 +820,23 @@ static int ircomm_tty_write_room(struct 
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
 		save_flags(flags);
 		cli();
 		if (self->tx_skb)
-			ret = self->max_data_size - self->tx_skb->len;
+			ret = self->tx_data_size - self->tx_skb->len;
 		else
 			ret = self->max_data_size;
 		restore_flags(flags);
diff -u -p linux/net/irda/ircomm-d3/ircomm_tty_attach.c linux/net/irda/ircomm/ircomm_tty_attach.c
--- linux/net/irda/ircomm-d3/ircomm_tty_attach.c	Wed Sep 11 15:23:04 2002
+++ linux/net/irda/ircomm/ircomm_tty_attach.c	Thu Sep 12 11:39:13 2002
@@ -515,6 +515,23 @@ void ircomm_tty_link_established(struct 
 	
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
@@ -522,10 +539,10 @@ void ircomm_tty_link_established(struct 
 	 * line.  
 	 */
 	if ((self->flags & ASYNC_CTS_FLOW) && ((self->settings.dce & IRCOMM_CTS) == 0)) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), waiting for CTS ...\n");
+		IRDA_DEBUG(0, "%s(), waiting for CTS ...\n", __FUNCTION__);
 		return;
 	} else {
-		IRDA_DEBUG(2, __FUNCTION__ "(), starting hardware!\n");
+		IRDA_DEBUG(1, "%s(), starting hardware!\n", __FUNCTION__);
 
 		self->tty->hw_stopped = 0;
 	
diff -u -p linux/net/irda/ircomm-d3/ircomm_param.c linux/net/irda/ircomm/ircomm_param.c
--- linux/net/irda/ircomm-d3/ircomm_param.c	Fri Nov  9 14:22:17 2001
+++ linux/net/irda/ircomm/ircomm_param.c	Thu Sep 12 11:37:06 2002
@@ -219,9 +219,16 @@ static int ircomm_param_service_type(voi
 
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
