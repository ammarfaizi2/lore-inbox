Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSHFUqF>; Tue, 6 Aug 2002 16:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSHFUqF>; Tue, 6 Aug 2002 16:46:05 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:13016 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315734AbSHFUqC>;
	Tue, 6 Aug 2002 16:46:02 -0400
Date: Tue, 6 Aug 2002 13:49:39 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] : ir240_trivial_fixes-3.diff
Message-ID: <20020806204939.GB11677@bougret.hpl.hp.com>
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

ir240_trivial_fixes-3.diff :
--------------------------
	o [CORRECT] Handle signals while IrSock is blocked on Tx
	o [CORRECT] Fix race condition in LAP when receiving with pf bit
	o [CRITICA] Prevent queuing Tx data before IrComm is ready
	o [FEATURE] Warn user of common misuse of IrLPT



diff -u -p -r linux/net/irda/af_irda.d5.c linux/net/irda/af_irda.c
--- linux/net/irda/af_irda.d5.c	Thu Jun  6 16:03:50 2002
+++ linux/net/irda/af_irda.c	Thu Jun  6 16:06:17 2002
@@ -1290,6 +1290,9 @@ static int irda_sendmsg(struct socket *s
 		/* Check if we are still connected */
 		if (sk->state != TCP_ESTABLISHED)
 			return -ENOTCONN;
+		/* Handle signals */
+		if (signal_pending(current)) 
+			return -ERESTARTSYS;
 	}
 
 	/* Check that we don't send out to big frames */
diff -u -p -r linux/net/irda/irlap_event.d5.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d5.c	Thu Jun  6 16:04:01 2002
+++ linux/net/irda/irlap_event.c	Thu Jun  6 16:06:17 2002
@@ -174,6 +174,12 @@ static void irlap_poll_timer_expired(voi
 	irlap_do_event(self, POLL_TIMER_EXPIRED, NULL, NULL);
 }
 
+/*
+ * Calculate and set time before we will have to send back the pf bit
+ * to the peer. Use in primary.
+ * Make sure that state is XMIT_P/XMIT_S when calling this function
+ * (and that nobody messed up with the state). - Jean II
+ */
 void irlap_start_poll_timer(struct irlap_cb *self, int timeout)
 {
 	ASSERT(self != NULL, return;);
@@ -1163,15 +1169,26 @@ static int irlap_state_nrm_p(struct irla
 				self->ack_required = TRUE;
 			
 				irlap_wait_min_turn_around(self, &self->qos_tx);
-				/* 
-				 * Important to switch state before calling
-				 * upper layers
-				 */
-				irlap_next_state(self, LAP_XMIT_P);
 
+				/* Call higher layer *before* changing state
+				 * to give them a chance to send data in the
+				 * next LAP frame.
+				 * Jean II */
 				irlap_data_indication(self, skb, FALSE);
 
-				/* This is the last frame */
+				/* XMIT states are the most dangerous state
+				 * to be in, because user requests are
+				 * processed directly and may change state.
+				 * On the other hand, in NDM_P, those
+				 * requests are queued and we will process
+				 * them when we return to irlap_do_event().
+				 * Jean II
+				 */
+				irlap_next_state(self, LAP_XMIT_P);
+
+				/* This is the last frame.
+				 * Make sure it's always called in XMIT state.
+				 * - Jean II */
 				irlap_start_poll_timer(self, self->poll_timeout);
 			}
 			break;
@@ -1309,6 +1326,7 @@ static int irlap_state_nrm_p(struct irla
 		} else {
 			del_timer(&self->final_timer);
 			irlap_data_indication(self, skb, TRUE);
+			irlap_next_state(self, LAP_XMIT_P);
 			printk(__FUNCTION__ "(): RECV_UI_FRAME: next state %s\n", irlap_state[self->state]);
 			irlap_start_poll_timer(self, self->poll_timeout);
 		}
diff -u -p -r linux/include/net/irda/ircomm_tty.d5.h linux/include/net/irda/ircomm_tty.h
--- linux/include/net/irda/ircomm_tty.d5.h	Thu Jun  6 16:04:56 2002
+++ linux/include/net/irda/ircomm_tty.h	Thu Jun  6 16:06:17 2002
@@ -44,6 +44,11 @@
 #define IRCOMM_TTY_MAJOR 161
 #define IRCOMM_TTY_MINOR 0
 
+/* This is used as an initial value to max_header_size before the proper
+ * value is filled in (5 for ttp, 4 for lmp). This allow us to detect
+ * the state of the underlying connection. - Jean II */
+#define IRCOMM_TTY_HDR_UNITIALISED	32
+
 /*
  * IrCOMM TTY driver state
  */
diff -u -p -r linux/net/irda/ircomm/ircomm_tty.d5.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm/ircomm_tty.d5.c	Thu Jun  6 16:05:18 2002
+++ linux/net/irda/ircomm/ircomm_tty.c	Thu Jun  6 16:06:17 2002
@@ -417,7 +417,7 @@ static int ircomm_tty_open(struct tty_st
 		self->line = line;
 		self->tqueue.routine = ircomm_tty_do_softint;
 		self->tqueue.data = self;
-		self->max_header_size = 5;
+		self->max_header_size = IRCOMM_TTY_HDR_UNITIALISED;
 		self->max_data_size = 64-self->max_header_size;
 		self->close_delay = 5*HZ/10;
 		self->closing_wait = 30*HZ;
@@ -696,6 +696,20 @@ static int ircomm_tty_write(struct tty_s
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
 
+	/* We may receive packets from the TTY even before we have finished
+	 * our setup. Not cool.
+	 * The problem is that we would allocate a skb with bogus header and
+	 * data size, and when adding data to it later we would get
+	 * confused.
+	 * Better to not accept data until we are properly setup. Use bogus
+	 * header size to check that (safest way to detect it).
+	 * Jean II */
+	if (self->max_header_size == IRCOMM_TTY_HDR_UNITIALISED) {
+		/* TTY will retry */
+		IRDA_DEBUG(2, __FUNCTION__ "() : not initialised\n");
+		return len;
+	}
+
 	save_flags(flags);
 	cli();
 
@@ -792,8 +806,12 @@ static int ircomm_tty_write_room(struct 
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
 
-	/* Check if we are allowed to transmit any data */
-	if (tty->hw_stopped)
+	/* Check if we are allowed to transmit any data.
+	 * hw_stopped is the regular flow control.
+	 * max_header_size tells us if the channel is initialised or not.
+	 * Jean II */
+	if ((tty->hw_stopped) ||
+	    (self->max_header_size == IRCOMM_TTY_HDR_UNITIALISED))
 		ret = 0;
 	else {
 		save_flags(flags);
diff -u -p -r linux/net/irda/ircomm/ircomm_tty_ioctl.d5.c linux/net/irda/ircomm/ircomm_tty_ioctl.c
--- linux/net/irda/ircomm/ircomm_tty_ioctl.d5.c	Thu Jun  6 16:05:35 2002
+++ linux/net/irda/ircomm/ircomm_tty_ioctl.c	Thu Jun  6 16:06:17 2002
@@ -94,6 +94,9 @@ void ircomm_tty_change_speed(struct irco
 	if (cflag & CRTSCTS) {
 		self->flags |= ASYNC_CTS_FLOW;
 		self->settings.flow_control |= IRCOMM_RTS_CTS_IN;
+		/* This got me. Bummer. Jean II */
+		if (self->service_type == IRCOMM_3_WIRE_RAW)
+			WARNING(__FUNCTION__ "(), enabling RTS/CTS on link that doesn't support it (3-wire-raw)\n");
 	} else {
 		self->flags &= ~ASYNC_CTS_FLOW;
 		self->settings.flow_control &= ~IRCOMM_RTS_CTS_IN;
