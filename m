Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSHFUrD>; Tue, 6 Aug 2002 16:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSHFUrC>; Tue, 6 Aug 2002 16:47:02 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:63450 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315762AbSHFUqy>;
	Tue, 6 Aug 2002 16:46:54 -0400
Date: Tue, 6 Aug 2002 13:50:31 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] : ir240_sys_max_tx-2.diff
Message-ID: <20020806205031.GC11677@bougret.hpl.hp.com>
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

ir240_sys_max_tx-2.diff :
-----------------------
	o [FEATURE] Allow tuning of Max Tx MTU to workaround spec contradiction


diff -u -p linux/net/irda/irsysctl.d5.c linux/net/irda/irsysctl.c
--- linux/net/irda/irsysctl.d5.c	Thu Jun  6 16:10:51 2002
+++ linux/net/irda/irsysctl.c	Thu Jun  6 16:11:21 2002
@@ -35,17 +35,19 @@
 #define NET_IRDA 412 /* Random number */
 enum { DISCOVERY=1, DEVNAME, DEBUG, FAST_POLL, DISCOVERY_SLOTS,
        DISCOVERY_TIMEOUT, SLOT_TIMEOUT, MAX_BAUD_RATE, MIN_TX_TURN_TIME,
-       MAX_NOREPLY_TIME, WARN_NOREPLY_TIME, LAP_KEEPALIVE_TIME };
+       MAX_TX_DATA_SIZE, MAX_NOREPLY_TIME, WARN_NOREPLY_TIME,
+       LAP_KEEPALIVE_TIME };
 
 extern int  sysctl_discovery;
 extern int  sysctl_discovery_slots;
 extern int  sysctl_discovery_timeout;
-extern int  sysctl_slot_timeout;	/* Candidate */
+extern int  sysctl_slot_timeout;
 extern int  sysctl_fast_poll_increase;
 int         sysctl_compression = 0;
 extern char sysctl_devname[];
 extern int  sysctl_max_baud_rate;
 extern int  sysctl_min_tx_turn_time;
+extern int  sysctl_max_tx_data_size;
 extern int  sysctl_max_noreply_time;
 extern int  sysctl_warn_noreply_time;
 extern int  sysctl_lap_keepalive_time;
@@ -65,6 +67,8 @@ static int max_max_baud_rate = 16000000;
 static int min_max_baud_rate = 2400;
 static int max_min_tx_turn_time = 10000;	/* See qos.c - IrLAP spec */
 static int min_min_tx_turn_time = 0;
+static int max_max_tx_data_size = 2048;		/* See qos.c - IrLAP spec */
+static int min_max_tx_data_size = 64;
 static int max_max_noreply_time = 40;		/* See qos.c - IrLAP spec */
 static int min_max_noreply_time = 3;
 static int max_warn_noreply_time = 3;		/* 3s == standard */
@@ -118,6 +122,9 @@ static ctl_table irda_table[] = {
 	{ MIN_TX_TURN_TIME, "min_tx_turn_time", &sysctl_min_tx_turn_time,
 	  sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec,
 	  NULL, &min_min_tx_turn_time, &max_min_tx_turn_time },
+	{ MAX_TX_DATA_SIZE, "max_tx_data_size", &sysctl_max_tx_data_size,
+	  sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec,
+	  NULL, &min_max_tx_data_size, &max_max_tx_data_size },
 	{ MAX_NOREPLY_TIME, "max_noreply_time", &sysctl_max_noreply_time,
 	  sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec,
 	  NULL, &min_max_noreply_time, &max_max_noreply_time },
diff -u -p linux/net/irda/qos.d5.c linux/net/irda/qos.c
--- linux/net/irda/qos.d5.c	Thu Jun  6 16:11:01 2002
+++ linux/net/irda/qos.c	Thu Jun  6 16:11:21 2002
@@ -57,10 +57,26 @@ int sysctl_max_noreply_time = 12;
  * Nonzero values (usec) are used as lower limit to the per-connection
  * mtt value which was announced by the other end during negotiation.
  * Might be helpful if the peer device provides too short mtt.
- * Default is 10 which means using the unmodified value given by the peer
- * except if it's 0 (0 is likely a bug in the other stack).
+ * Default is 10us which means using the unmodified value given by the
+ * peer except if it's 0 (0 is likely a bug in the other stack).
  */
 unsigned sysctl_min_tx_turn_time = 10;
+/*
+ * Maximum data size to be used in transmission in payload of LAP frame.
+ * There is a bit of confusion in the IrDA spec :
+ * The LAP spec defines the payload of a LAP frame (I field) to be
+ * 2048 bytes max (IrLAP 1.1, chapt 6.6.5, p40).
+ * On the other hand, the PHY mention frames of 2048 bytes max (IrPHY
+ * 1.2, chapt 5.3.2.1, p41). But, this number includes the LAP header
+ * (2 bytes), and CRC (32 bits at 4 Mb/s). So, for the I field (LAP
+ * payload), that's only 2042 bytes. Oups !
+ * I've had trouble trouble transmitting 2048 bytes frames with USB
+ * dongles and nsc-ircc at 4 Mb/s, so adjust to 2042... I don't know
+ * if this bug applies only for 2048 bytes frames or all negociated
+ * frame sizes, but all hardware seem to support "2048 bytes" frames.
+ * You can use the sysctl to play with this value anyway.
+ * Jean II */
+unsigned sysctl_max_tx_data_size = 2042;
 
 static int irlap_param_baud_rate(void *instance, irda_param_t *param, int get);
 static int irlap_param_link_disconnect(void *instance, irda_param_t *parm, 
@@ -355,10 +371,10 @@ void irlap_adjust_qos_settings(struct qo
 	while ((qos->data_size.value > line_capacity) && (index > 0)) {
 		qos->data_size.value = data_sizes[index--];
 		IRDA_DEBUG(2, __FUNCTION__ 
-			   "(), redusing data size to %d\n",
+			   "(), reducing data size to %d\n",
 			   qos->data_size.value);
 	}
-#else /* Use method descibed in section 6.6.11 of IrLAP */
+#else /* Use method described in section 6.6.11 of IrLAP */
 	while (irlap_requested_line_capacity(qos) > line_capacity) {
 		ASSERT(index != 0, return;);
 
@@ -366,18 +382,24 @@ void irlap_adjust_qos_settings(struct qo
 		if (qos->window_size.value > 1) {
 			qos->window_size.value--;
 			IRDA_DEBUG(2, __FUNCTION__ 
-				   "(), redusing window size to %d\n",
+				   "(), reducing window size to %d\n",
 				   qos->window_size.value);
 		} else if (index > 1) {
 			qos->data_size.value = data_sizes[index--];
 			IRDA_DEBUG(2, __FUNCTION__ 
-				   "(), redusing data size to %d\n",
+				   "(), reducing data size to %d\n",
 				   qos->data_size.value);
 		} else {
 			WARNING(__FUNCTION__ "(), nothing more we can do!\n");
 		}
 	}
 #endif /* CONFIG_IRDA_DYNAMIC_WINDOW */
+	/*
+	 * Fix tx data size according to user limits - Jean II
+	 */
+	if (qos->data_size.value > sysctl_max_tx_data_size)
+		/* Allow non discrete adjustement to avoid loosing capacity */
+		qos->data_size.value = sysctl_max_tx_data_size;
 }
 
 /*
