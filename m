Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283778AbRK3U4Y>; Fri, 30 Nov 2001 15:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283779AbRK3U4M>; Fri, 30 Nov 2001 15:56:12 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:17347 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S283737AbRK3Uzq>;
	Fri, 30 Nov 2001 15:55:46 -0500
Date: Fri, 30 Nov 2001 12:55:41 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [PATCH] : ir245_sysctl-2.diff
Message-ID: <20011130125541.C3938@bougret.hpl.hp.com>
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

ir245_sysctl-2.diff :
-------------------
	o [CORRECT] Check min/max boundary on various sysctl
	o [FEATURE] Add min_tx_turn_time sysctl and make it default to 10
	  This fixes problem with some broken cellular phones
	o [FEATURE] Simplify retry_count tests
	o [FEATURE] Allow to set the "no activity" event timeout via sysctl
	o [FEATURE] "no activity" event generated each multiple of timeout
	  and not only the first time. This allow apps to know is connectivity
	  is restored (they don't receive anymore the event).

diff -u -p linux/net/irda/irsysctl.d3.c linux/net/irda/irsysctl.c
--- linux/net/irda/irsysctl.d3.c	Mon Nov 19 17:25:26 2001
+++ linux/net/irda/irsysctl.c	Tue Nov 20 11:25:46 2001
@@ -10,6 +10,7 @@
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
  * 
  *     Copyright (c) 1997, 1999 Dag Brattli, All Rights Reserved.
+ *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
  *      
  *     This program is free software; you can redistribute it and/or 
  *     modify it under the terms of the GNU General Public License as 
@@ -32,24 +33,47 @@
 #include <net/irda/irias_object.h>
 
 #define NET_IRDA 412 /* Random number */
-enum { DISCOVERY=1, DEVNAME, DEBUG, SLOTS, DISCOVERY_TIMEOUT, 
-       SLOT_TIMEOUT, MAX_BAUD_RATE, MAX_INACTIVE_TIME, LAP_KEEPALIVE_TIME, };
+enum { DISCOVERY=1, DEVNAME, DEBUG, FAST_POLL, DISCOVERY_SLOTS,
+       DISCOVERY_TIMEOUT, SLOT_TIMEOUT, MAX_BAUD_RATE, MIN_TX_TURN_TIME,
+       MAX_NOREPLY_TIME, WARN_NOREPLY_TIME, LAP_KEEPALIVE_TIME };
 
 extern int  sysctl_discovery;
 extern int  sysctl_discovery_slots;
 extern int  sysctl_discovery_timeout;
-extern int  sysctl_slot_timeout;
+extern int  sysctl_slot_timeout;	/* Candidate */
 extern int  sysctl_fast_poll_increase;
 int         sysctl_compression = 0;
 extern char sysctl_devname[];
 extern int  sysctl_max_baud_rate;
-extern int  sysctl_max_inactive_time;
+extern int  sysctl_min_tx_turn_time;
+extern int  sysctl_max_noreply_time;
+extern int  sysctl_warn_noreply_time;
 extern int  sysctl_lap_keepalive_time;
 
 #ifdef CONFIG_IRDA_DEBUG
 extern unsigned int irda_debug;
 #endif
 
+/* this is needed for the proc_dointvec_minmax - Jean II */
+static int max_discovery_slots = 16;		/* ??? */
+static int min_discovery_slots = 1;
+/* IrLAP 6.13.2 says 25ms to 10+70ms - allow higher since some devices
+ * seems to require it. (from Dag's comment) */
+static int max_slot_timeout = 160;
+static int min_slot_timeout = 20;
+static int max_max_baud_rate = 16000000;	/* See qos.c - IrLAP spec */
+static int min_max_baud_rate = 2400;
+static int max_min_tx_turn_time = 10000;	/* See qos.c - IrLAP spec */
+static int min_min_tx_turn_time = 0;
+static int max_max_noreply_time = 40;		/* See qos.c - IrLAP spec */
+static int min_max_noreply_time = 3;
+static int max_warn_noreply_time = 3;		/* 3s == standard */
+static int min_warn_noreply_time = 1;		/* 1s == min WD_TIMER */
+static int max_lap_keepalive_time = 10000;	/* 10s */
+static int min_lap_keepalive_time = 100;	/* 100us */
+/* For other sysctl, I've no idea of the range. Maybe Dag could help
+ * us on that - Jean II */
+
 static int do_devname(ctl_table *table, int write, struct file *filp,
 		      void *buffer, size_t *lenp)
 {
@@ -77,21 +101,32 @@ static ctl_table irda_table[] = {
 	  sizeof(int), 0644, NULL, &proc_dointvec },
 #endif
 #ifdef CONFIG_IRDA_FAST_RR
-        { SLOTS, "fast_poll_increase", &sysctl_fast_poll_increase,
+        { FAST_POLL, "fast_poll_increase", &sysctl_fast_poll_increase,
 	  sizeof(int), 0644, NULL, &proc_dointvec },
 #endif
-	{ SLOTS, "discovery_slots", &sysctl_discovery_slots,
-	  sizeof(int), 0644, NULL, &proc_dointvec },
+	{ DISCOVERY_SLOTS, "discovery_slots", &sysctl_discovery_slots,
+	  sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec,
+	  NULL, &min_discovery_slots, &max_discovery_slots },
 	{ DISCOVERY_TIMEOUT, "discovery_timeout", &sysctl_discovery_timeout,
 	  sizeof(int), 0644, NULL, &proc_dointvec },
 	{ SLOT_TIMEOUT, "slot_timeout", &sysctl_slot_timeout,
-	  sizeof(int), 0644, NULL, &proc_dointvec },
+	  sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec,
+	  NULL, &min_slot_timeout, &max_slot_timeout },
 	{ MAX_BAUD_RATE, "max_baud_rate", &sysctl_max_baud_rate,
-	  sizeof(int), 0644, NULL, &proc_dointvec },
-	{ MAX_INACTIVE_TIME, "max_inactive_time", &sysctl_max_inactive_time,
-	  sizeof(int), 0644, NULL, &proc_dointvec },
+	  sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec,
+	  NULL, &min_max_baud_rate, &max_max_baud_rate },
+	{ MIN_TX_TURN_TIME, "min_tx_turn_time", &sysctl_min_tx_turn_time,
+	  sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec,
+	  NULL, &min_min_tx_turn_time, &max_min_tx_turn_time },
+	{ MAX_NOREPLY_TIME, "max_noreply_time", &sysctl_max_noreply_time,
+	  sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec,
+	  NULL, &min_max_noreply_time, &max_max_noreply_time },
+	{ WARN_NOREPLY_TIME, "warn_noreply_time", &sysctl_warn_noreply_time,
+	  sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec,
+	  NULL, &min_warn_noreply_time, &max_warn_noreply_time },
 	{ LAP_KEEPALIVE_TIME, "lap_keepalive_time", &sysctl_lap_keepalive_time,
-	  sizeof(int), 0644, NULL, &proc_dointvec },
+	  sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec,
+	  NULL, &min_lap_keepalive_time, &max_lap_keepalive_time },
 	{ 0 }
 };
 
diff -u -p linux/net/irda/qos.d3.c linux/net/irda/qos.c
--- linux/net/irda/qos.d3.c	Mon Nov 19 17:28:39 2001
+++ linux/net/irda/qos.c	Mon Nov 19 19:14:50 2001
@@ -51,7 +51,16 @@ int sysctl_max_baud_rate = 16000000;
  * may want to keep the LAP alive longuer or shorter in case of link failure.
  * Remember that the threshold time (early warning) is fixed to 3s...
  */
-int sysctl_max_inactive_time = 12;
+int sysctl_max_noreply_time = 12;
+/*
+ * Minimum turn time to be applied before transmitting to the peer.
+ * Nonzero values (usec) are used as lower limit to the per-connection
+ * mtt value which was announced by the other end during negotiation.
+ * Might be helpful if the peer device provides too short mtt.
+ * Default is 10 which means using the unmodified value given by the peer
+ * except if it's 0 (0 is likely a bug in the other stack).
+ */
+unsigned sysctl_min_tx_turn_time = 10;
 
 static int irlap_param_baud_rate(void *instance, irda_param_t *param, int get);
 static int irlap_param_link_disconnect(void *instance, irda_param_t *parm, 
@@ -184,7 +193,6 @@ static inline __u32 byte_value(__u8 byte
  * Function value_lower_bits (value, array)
  *
  *    Returns a bit field marking all possibility lower than value.
- *    We may need a "value_higher_bits" in the future...
  */
 static inline int value_lower_bits(__u32 value, __u32 *array, int size, __u16 *field)
 {
@@ -207,6 +215,33 @@ static inline int value_lower_bits(__u32
 	return i;
 }
 
+/*
+ * Function value_highest_bit (value, array)
+ *
+ *    Returns a bit field marking the highest possibility lower than value.
+ */
+static inline int value_highest_bit(__u32 value, __u32 *array, int size, __u16 *field)
+{
+	int	i;
+	__u16	mask = 0x1;
+	__u16	result = 0x0;
+
+	for (i=0; i < size; i++) {
+		/* Finished ? */
+		if (array[i] <= value)
+			break;
+		/* Shift mask */
+		mask <<= 1;
+	}
+	/* Set the current value to the bit field */
+	result |= mask;
+	/* Send back a valid index */
+	if(i >= size)
+	  i = size - 1;	/* Last item */
+	*field = result;
+	return i;
+}
+
 /* -------------------------- MAIN CALLS -------------------------- */
 
 /*
@@ -254,9 +289,9 @@ void irda_init_max_qos_capabilies(struct
 	sysctl_max_baud_rate = index_value(i, baud_rates);
 
 	/* Set configured max disc time */
-	i = value_lower_bits(sysctl_max_inactive_time, link_disc_times, 8,
+	i = value_lower_bits(sysctl_max_noreply_time, link_disc_times, 8,
 			     &qos->link_disc_time.bits);
-	sysctl_max_inactive_time = index_value(i, link_disc_times);
+	sysctl_max_noreply_time = index_value(i, link_disc_times);
 
 	/* LSB is first byte, MSB is second byte */
 	qos->baud_rate.bits    &= 0x03ff;
@@ -281,6 +316,19 @@ void irlap_adjust_qos_settings(struct qo
 	int index;
 
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	/*
+	 * Make sure the mintt is sensible.
+	 */
+	if (sysctl_min_tx_turn_time > qos->min_turn_time.value) {
+		int i;
+
+		/* We don't really need bits, but easier this way */
+		i = value_highest_bit(sysctl_min_tx_turn_time, min_turn_times,
+				      8, &qos->min_turn_time.bits);
+		sysctl_min_tx_turn_time = index_value(i, min_turn_times);
+		qos->min_turn_time.value = sysctl_min_tx_turn_time;
+	}
 
 	/* 
 	 * Not allowed to use a max turn time less than 500 ms if the baudrate
diff -u -p linux/net/irda/irlap.d3.c linux/net/irda/irlap.c
--- linux/net/irda/irlap.d3.c	Mon Nov 19 17:24:34 2001
+++ linux/net/irda/irlap.c	Tue Nov 20 11:26:54 2001
@@ -51,6 +51,11 @@
 hashbin_t *irlap = NULL;
 int sysctl_slot_timeout = SLOT_TIMEOUT * 1000 / HZ;
 
+/* This is the delay of missed pf period before generating an event
+ * to the application. The spec mandate 3 seconds, but in some cases
+ * it's way too long. - Jean II */
+int sysctl_warn_noreply_time = 3;
+
 extern void irlap_queue_xmit(struct irlap_cb *self, struct sk_buff *skb);
 static void __irlap_close(struct irlap_cb *self);
 
@@ -527,22 +532,7 @@ void irlap_discovery_request(struct irla
 	self->discovery_cmd = discovery;
 	info.discovery = discovery;
 	
-	/* Check if the slot timeout is within limits */
-	if (sysctl_slot_timeout < 20) {
-		ERROR(__FUNCTION__ 
-		      "(), to low value for slot timeout!\n");
-		sysctl_slot_timeout = 20;
-	}
-	/* 
-	 * Highest value is actually 8, but we allow higher since
-	 * some devices seems to require it.
-	 */
-	if (sysctl_slot_timeout > 160) {
-		ERROR(__FUNCTION__ 
-		      "(), to high value for slot timeout!\n");
-		sysctl_slot_timeout = 160;
-	}
-	
+	/* sysctl_slot_timeout bounds are checked in irsysctl.c - Jean II */
 	self->slot_timeout = sysctl_slot_timeout * HZ / 1000;
 	
 	irlap_do_event(self, DISCOVERY_REQUEST, NULL, &info);
@@ -931,9 +921,6 @@ void irlap_init_qos_capabilities(struct 
 	/* Set data size */
 	/*self->qos_rx.data_size.bits &= 0x03;*/
 
-	/* Set disconnect time -> done properly in qos.c */
-	/*self->qos_rx.link_disc_time.bits &= 0x07;*/
-
 	irda_qos_bits_to_value(&self->qos_rx);
 }
 
@@ -1070,8 +1057,11 @@ void irlap_apply_connection_parameters(s
 	/*
 	 *  Set N1 to 0 if Link Disconnect/Threshold Time = 3 and set it to 
 	 *  3 seconds otherwise. See page 71 in IrLAP for more details.
+	 *  Actually, it's not always 3 seconds, as we allow to set
+	 *  it via sysctl... Max maxtt is 500ms, and N1 need to be multiple
+	 *  of 2, so 1 second is minimum we can allow. - Jean II
 	 */
-	if (self->qos_tx.link_disc_time.value == 3)
+	if (self->qos_tx.link_disc_time.value == sysctl_warn_noreply_time)
 		/* 
 		 * If we set N1 to 0, it will trigger immediately, which is
 		 * not what we want. What we really want is to disable it,
@@ -1079,7 +1069,8 @@ void irlap_apply_connection_parameters(s
 		 */
 		self->N1 = -2; /* Disable - Need to be multiple of 2*/
 	else
-		self->N1 = 3000 / self->qos_rx.max_turn_time.value;
+		self->N1 = sysctl_warn_noreply_time * 1000 /
+		  self->qos_rx.max_turn_time.value;
 	
 	IRDA_DEBUG(4, "Setting N1 = %d\n", self->N1);
 	
diff -u -p linux/net/irda/irlap_event.d3.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d3.c	Mon Nov 19 17:11:42 2001
+++ linux/net/irda/irlap_event.c	Tue Nov 27 16:35:15 2001
@@ -1405,30 +1405,29 @@ static int irlap_state_nrm_p(struct irla
 		}
 		self->add_wait = FALSE;
 
-		if ((self->retry_count < self->N2) && 
-		    (self->retry_count != self->N1)) {
-			
+		/* N2 is the disconnect timer. Until we reach it, we retry */
+		if (self->retry_count < self->N2) {
+			/* Retry sending the pf bit to the secondary */
 			irlap_wait_min_turn_around(self, &self->qos_tx);
 			irlap_send_rr_frame(self, CMD_FRAME);
 			
 			irlap_start_final_timer(self, self->final_timeout);
 		 	self->retry_count++;
-
 			IRDA_DEBUG(4, "irlap_state_nrm_p: FINAL_TIMER_EXPIRED:"
 				   " retry_count=%d\n", self->retry_count);
-			/* Keep state */
-		} else if (self->retry_count == self->N1) {
-			irlap_status_indication(self, STATUS_NO_ACTIVITY);
-			irlap_wait_min_turn_around(self, &self->qos_tx);
-			irlap_send_rr_frame(self, CMD_FRAME);
-			
-			irlap_start_final_timer(self, self->final_timeout);
-			self->retry_count++;
 
-			IRDA_DEBUG(4, "retry count = N1; retry_count=%d\n", 
-				   self->retry_count);
+			/* Early warning event. I'm using a pretty liberal
+			 * interpretation of the spec and generate an event
+			 * every time the timer is multiple of N1 (and not
+			 * only the first time). This allow application
+			 * to know precisely if connectivity restart...
+			 * Jean II */
+			if((self->retry_count % self->N1) == 0)
+				irlap_status_indication(self,
+							STATUS_NO_ACTIVITY);
+
 			/* Keep state */
-		} else if (self->retry_count >= self->N2) {
+		} else {
 			irlap_apply_default_connection_parameters(self);
 
 			/* Always switch state before calling upper layers */
@@ -1991,6 +1990,7 @@ static int irlap_state_nrm_s(struct irla
 		 *  Wait until retry_count * n matches negotiated threshold/
 		 *  disconnect time (note 2 in IrLAP p. 82)
 		 *
+		 * Similar to irlap_state_nrm_p() -> FINAL_TIMER_EXPIRED
 		 * Note : self->wd_timeout = (self->final_timeout * 2),
 		 *   which explain why we use (self->N2 / 2) here !!!
 		 * Jean II
@@ -1998,16 +1998,15 @@ static int irlap_state_nrm_s(struct irla
 		IRDA_DEBUG(1, __FUNCTION__ "(), retry_count = %d\n", 
 			   self->retry_count);
 
-		if ((self->retry_count <  (self->N2 / 2))  && 
-		    (self->retry_count != (self->N1 / 2))) {
-			
+		if (self->retry_count < (self->N2 / 2)) {
+			/* No retry, just wait for primary */
 			irlap_start_wd_timer(self, self->wd_timeout);
 			self->retry_count++;
-		} else if (self->retry_count == (self->N1 / 2)) {
-			irlap_status_indication(self, STATUS_NO_ACTIVITY);
-			irlap_start_wd_timer(self, self->wd_timeout);
-			self->retry_count++;
-		} else if (self->retry_count >= (self->N2 / 2)) {
+
+			if((self->retry_count % (self->N1 / 2)) == 0)
+				irlap_status_indication(self,
+							STATUS_NO_ACTIVITY);
+		} else {
 			irlap_apply_default_connection_parameters(self);
 			
 			/* Always switch state before calling upper layers */
diff -u -p linux/net/irda/irlmp_event.d3.c linux/net/irda/irlmp_event.c
--- linux/net/irda/irlmp_event.d3.c	Tue Nov 20 11:22:32 2001
+++ linux/net/irda/irlmp_event.c	Tue Nov 20 11:25:14 2001
@@ -407,12 +407,7 @@ static void irlmp_state_active(struct la
 		 *  removed later and moved to the list of unconnected LSAPs
 		 */
 		if (HASHBIN_GET_SIZE(self->lsaps) > 0) {
-			/* Make sure the timer has sensible value (the user
-			 * may have set it) - Jean II */
-			if(sysctl_lap_keepalive_time < 100)	/* 100ms */
-				sysctl_lap_keepalive_time = 100;
-			if(sysctl_lap_keepalive_time > 10000)	/* 10s */
-				sysctl_lap_keepalive_time = 10000;
+			/* Timer value is checked in irsysctl - Jean II */
 			irlmp_start_idle_timer(self, sysctl_lap_keepalive_time * HZ / 1000);
 		} else {
 			/* No more connections, so close IrLAP */
