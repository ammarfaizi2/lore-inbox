Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTFQBwa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 21:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTFQBw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 21:52:29 -0400
Received: from palrel12.hp.com ([156.153.255.237]:39107 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264515AbTFQBu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:50:59 -0400
Date: Mon, 16 Jun 2003 19:04:39 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] ir241_qos_param-2.diff
Message-ID: <20030617020439.GC30944@bougret.hpl.hp.com>
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

ir241_qos_param-2.diff :
	o [FEATURE] Fix some comments
	o [FEATURE] printk warning when we detect buggy QoS from peer
	o [CORRECT] Workaround NULL QoS bitfields
	o [CORRECT] Workaround oversized QoS bitfields
	o [FEATURE] Add sysctl "max_tx_window" to limit IrLAP Tx Window


diff -u -p linux/net/irda/qos.d3.c linux/net/irda/qos.c
--- linux/net/irda/qos.d3.c	Thu Sep 26 11:26:04 2002
+++ linux/net/irda/qos.c	Thu Sep 26 11:26:38 2002
@@ -70,13 +70,18 @@ unsigned sysctl_min_tx_turn_time = 10;
  * 1.2, chapt 5.3.2.1, p41). But, this number includes the LAP header
  * (2 bytes), and CRC (32 bits at 4 Mb/s). So, for the I field (LAP
  * payload), that's only 2042 bytes. Oups !
- * I've had trouble trouble transmitting 2048 bytes frames with USB
- * dongles and nsc-ircc at 4 Mb/s, so adjust to 2042... I don't know
- * if this bug applies only for 2048 bytes frames or all negociated
- * frame sizes, but all hardware seem to support "2048 bytes" frames.
- * You can use the sysctl to play with this value anyway.
+ * My nsc-ircc hardware has troubles receiving 2048 bytes frames at 4 Mb/s,
+ * so adjust to 2042... I don't know if this bug applies only for 2048
+ * bytes frames or all negociated frame sizes, but you can use the sysctl
+ * to play with this value anyway.
  * Jean II */
 unsigned sysctl_max_tx_data_size = 2042;
+/*
+ * Maximum transmit window, i.e. number of LAP frames between turn-around.
+ * This allow to override what the peer told us. Some peers are buggy and
+ * don't always support what they tell us.
+ * Jean II */
+unsigned sysctl_max_tx_window = 7;
 
 static int irlap_param_baud_rate(void *instance, irda_param_t *param, int get);
 static int irlap_param_link_disconnect(void *instance, irda_param_t *parm, 
@@ -184,7 +189,19 @@ int msb_index (__u16 word) 
 {
 	__u16 msb = 0x8000;
 	int index = 15;   /* Current MSB */
-	
+
+	/* Check for buggy peers.
+	 * Note : there is a small probability that it could be us, but I
+	 * would expect driver authors to catch that pretty early and be
+	 * able to check precisely what's going on. If a end user sees this,
+	 * it's very likely the peer. - Jean II */
+	if (word == 0) {
+		WARNING("%s(), Detected buggy peer, adjust null PV to 0x1!\n",
+			 __FUNCTION__);
+		/* The only safe choice (we don't know the array size) */
+		word = 0x1;
+	}
+
 	while (msb) {
 		if (word & msb)
 			break;   /* Found it! */
@@ -335,10 +352,14 @@ void irlap_adjust_qos_settings(struct qo
 
 	/*
 	 * Make sure the mintt is sensible.
+	 * Main culprit : Ericsson T39. - Jean II
 	 */
 	if (sysctl_min_tx_turn_time > qos->min_turn_time.value) {
 		int i;
 
+		WARNING("%s(), Detected buggy peer, adjust mtt to %dus!\n",
+			 __FUNCTION__, sysctl_min_tx_turn_time);
+
 		/* We don't really need bits, but easier this way */
 		i = value_highest_bit(sysctl_min_tx_turn_time, min_turn_times,
 				      8, &qos->min_turn_time.bits);
@@ -400,6 +421,11 @@ void irlap_adjust_qos_settings(struct qo
 	if (qos->data_size.value > sysctl_max_tx_data_size)
 		/* Allow non discrete adjustement to avoid loosing capacity */
 		qos->data_size.value = sysctl_max_tx_data_size;
+	/*
+	 * Override Tx window if user request it. - Jean II
+	 */
+	if (qos->window_size.value > sysctl_max_tx_window)
+		qos->window_size.value = sysctl_max_tx_window;
 }
 
 /*
diff -u -p linux/net/irda/irsysctl.d3.c linux/net/irda/irsysctl.c
--- linux/net/irda/irsysctl.d3.c	Thu Sep 26 11:26:14 2002
+++ linux/net/irda/irsysctl.c	Thu Sep 26 11:26:38 2002
@@ -35,7 +35,7 @@
 #define NET_IRDA 412 /* Random number */
 enum { DISCOVERY=1, DEVNAME, DEBUG, FAST_POLL, DISCOVERY_SLOTS,
        DISCOVERY_TIMEOUT, SLOT_TIMEOUT, MAX_BAUD_RATE, MIN_TX_TURN_TIME,
-       MAX_TX_DATA_SIZE, MAX_NOREPLY_TIME, WARN_NOREPLY_TIME,
+       MAX_TX_DATA_SIZE, MAX_TX_WINDOW, MAX_NOREPLY_TIME, WARN_NOREPLY_TIME,
        LAP_KEEPALIVE_TIME };
 
 extern int  sysctl_discovery;
@@ -48,6 +48,7 @@ extern char sysctl_devname[];
 extern int  sysctl_max_baud_rate;
 extern int  sysctl_min_tx_turn_time;
 extern int  sysctl_max_tx_data_size;
+extern int  sysctl_max_tx_window;
 extern int  sysctl_max_noreply_time;
 extern int  sysctl_warn_noreply_time;
 extern int  sysctl_lap_keepalive_time;
@@ -69,6 +70,8 @@ static int max_min_tx_turn_time = 10000;
 static int min_min_tx_turn_time = 0;
 static int max_max_tx_data_size = 2048;		/* See qos.c - IrLAP spec */
 static int min_max_tx_data_size = 64;
+static int max_max_tx_window = 7;		/* See qos.c - IrLAP spec */
+static int min_max_tx_window = 1;
 static int max_max_noreply_time = 40;		/* See qos.c - IrLAP spec */
 static int min_max_noreply_time = 3;
 static int max_warn_noreply_time = 3;		/* 3s == standard */
@@ -125,6 +128,9 @@ static ctl_table irda_table[] = {
 	{ MAX_TX_DATA_SIZE, "max_tx_data_size", &sysctl_max_tx_data_size,
 	  sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec,
 	  NULL, &min_max_tx_data_size, &max_max_tx_data_size },
+	{ MAX_TX_WINDOW, "max_tx_window", &sysctl_max_tx_window,
+	  sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec,
+	  NULL, &min_max_tx_window, &max_max_tx_window },
 	{ MAX_NOREPLY_TIME, "max_noreply_time", &sysctl_max_noreply_time,
 	  sizeof(int), 0644, NULL, &proc_dointvec_minmax, &sysctl_intvec,
 	  NULL, &min_max_noreply_time, &max_max_noreply_time },
diff -u -p linux/net/irda/parameters.d3.c linux/net/irda/parameters.c
--- linux/net/irda/parameters.d3.c	Thu Sep 26 11:26:25 2002
+++ linux/net/irda/parameters.c	Thu Sep 26 11:49:39 2002
@@ -205,11 +205,13 @@ static int irda_extract_integer(void *se
 {
 	irda_param_t p;
 	int n = 0;
+	int extract_len;	/* Real lenght we extract */
 	int err;
 
 	p.pi = pi;     /* In case handler needs to know */
 	p.pl = buf[1]; /* Extract lenght of value */
 	p.pv.i = 0;    /* Clear value */
+	extract_len = p.pl;	/* Default : extract all */
 
 	/* Check if buffer is long enough for parsing */
 	if (len < (2+p.pl)) {
@@ -221,18 +223,30 @@ static int irda_extract_integer(void *se
 	/* 
 	 * Check that the integer length is what we expect it to be. If the
 	 * handler want a 16 bits integer then a 32 bits is not good enough
+	 * PV_INTEGER means that the handler is flexible.
 	 */
 	if (((type & PV_MASK) != PV_INTEGER) && ((type & PV_MASK) != p.pl)) {
 		ERROR(__FUNCTION__ "(), invalid parameter length! "
 		      "Expected %d bytes, but value had %d bytes!\n",
 		      type & PV_MASK, p.pl);
 		
-		/* Skip parameter */
-		return p.pl+2;
+		/* Most parameters are bit/byte fields or little endian,
+		 * so it's ok to only extract a subset of it (the subset
+		 * that the handler expect). This is necessary, as some
+		 * broken implementations seems to add extra undefined bits.
+		 * If the parameter is shorter than we expect or is big
+		 * endian, we can't play those tricks. Jean II */
+		if((p.pl < (type & PV_MASK)) || (type & PV_BIG_ENDIAN)) {
+			/* Skip parameter */
+			return p.pl+2;
+		} else {
+			/* Extract subset of it, fallthrough */
+			extract_len = type & PV_MASK;
+		}
 	}
 
 
-	switch (p.pl) {
+	switch (extract_len) {
 	case 1:
 		n += irda_param_unpack(buf+2, "b", &p.pv.i);
 		break;
