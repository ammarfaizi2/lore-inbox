Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266334AbUG0O4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUG0O4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 10:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUG0O4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 10:56:19 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:43466 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S266334AbUG0Oxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 10:53:31 -0400
Date: Tue, 27 Jul 2004 16:53:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: network driver changes.
Message-ID: <20040727145339.GB8126@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: network driver changes.

From: Ursula Braun-Krahl <braunu@de.ibm.com>
From: Thomas Spatzier <tspat@de.ibm.com>
From: Peter Tiedemann <ptiedem@de.ibm.com>

network driver changes.
 - iucv: add missing symbolic links between /sys/bus/iucv/drivers/netiucv
   and /sys/class/net.
 - iucv: make use of the debug feature.
 - iucv: 0 vs. NULL cleanup, avoid build warnings.
 - iucv: remove unnecessary -ENODEV check after call to iucv_declare_buffer.
 - ctc: adjust debug feature log levels.
 - lcs: replace broken schedule_timeout call with msleep.
 - qeth: add missing link type.
 - qeth: treat add_hhlen attribute as decimal value.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/ctcdbug.c   |    6 
 drivers/s390/net/ctcdbug.h   |    6 
 drivers/s390/net/ctcmain.c   |   94 ++++----
 drivers/s390/net/ctctty.c    |   45 ++--
 drivers/s390/net/iucv.c      |    9 
 drivers/s390/net/iucv.h      |   88 ++++++++
 drivers/s390/net/lcs.c       |    6 
 drivers/s390/net/netiucv.c   |  466 ++++++++++++++++++++++++++++---------------
 drivers/s390/net/qeth_fs.h   |    4 
 drivers/s390/net/qeth_main.c |    9 
 drivers/s390/net/qeth_sys.c  |    6 
 drivers/s390/scsi/zfcp_fsf.c |    1 
 12 files changed, 499 insertions(+), 241 deletions(-)

diff -urN linux-2.6/drivers/s390/net/ctcdbug.c linux-2.6-s390/drivers/s390/net/ctcdbug.c
--- linux-2.6/drivers/s390/net/ctcdbug.c	Tue Jul 27 16:35:49 2004
+++ linux-2.6-s390/drivers/s390/net/ctcdbug.c	Tue Jul 27 16:36:27 2004
@@ -1,15 +1,15 @@
 /*
  *
- * linux/drivers/s390/net/ctcdbug.c ($Revision: 1.1 $)
+ * linux/drivers/s390/net/ctcdbug.c ($Revision: 1.2 $)
  *
- * Linux on zSeries OSA Express and HiperSockets support
+ * CTC / ESCON network driver - s390 dbf exploit.
  *
  * Copyright 2000,2003 IBM Corporation
  *
  *    Author(s): Original Code written by
  *			  Peter Tiedemann (ptiedem@de.ibm.com)
  *
- *    $Revision: 1.1 $	 $Date: 2004/07/02 16:31:22 $
+ *    $Revision: 1.2 $	 $Date: 2004/07/15 16:03:08 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff -urN linux-2.6/drivers/s390/net/ctcdbug.h linux-2.6-s390/drivers/s390/net/ctcdbug.h
--- linux-2.6/drivers/s390/net/ctcdbug.h	Tue Jul 27 16:35:49 2004
+++ linux-2.6-s390/drivers/s390/net/ctcdbug.h	Tue Jul 27 16:36:27 2004
@@ -1,15 +1,15 @@
 /*
  *
- * linux/drivers/s390/net/ctcdbug.h ($Revision: 1.1 $)
+ * linux/drivers/s390/net/ctcdbug.h ($Revision: 1.2 $)
  *
- * Linux on zSeries OSA Express and HiperSockets support
+ * CTC / ESCON network driver - s390 dbf exploit.
  *
  * Copyright 2000,2003 IBM Corporation
  *
  *    Author(s): Original Code written by
  *			  Peter Tiedemann (ptiedem@de.ibm.com)
  *
- *    $Revision: 1.1 $	 $Date: 2004/07/02 16:31:22 $
+ *    $Revision: 1.2 $	 $Date: 2004/07/15 16:03:08 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-s390/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	Tue Jul 27 16:35:49 2004
+++ linux-2.6-s390/drivers/s390/net/ctcmain.c	Tue Jul 27 16:36:27 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.61 2004/07/02 16:31:22 ptiedem Exp $
+ * $Id: ctcmain.c,v 1.62 2004/07/15 16:03:08 ptiedem Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.61 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.62 $
  *
  */
 
@@ -320,7 +320,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.61 $";
+	char vbuf[] = "$Revision: 1.62 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -619,7 +619,7 @@
 	struct ctc_priv *privptr = (struct ctc_priv *) dev->priv;
 	__u16 len = *((__u16 *) pskb->data);
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	skb_put(pskb, 2 + LL_HEADER_LENGTH);
 	skb_pull(pskb, 2);
 	pskb->dev = dev;
@@ -724,7 +724,7 @@
 		if (ch->protocol == CTC_PROTO_LINUX_TTY)
 			ctc_tty_netif_rx(skb);
 		else
-			netif_rx(skb);
+			netif_rx_ni(skb);
 		/**
 		 * Successful rx; reset logflags
 		 */
@@ -761,7 +761,7 @@
 static void inline
 ccw_check_return_code(struct channel *ch, int return_code, char *msg)
 {
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	switch (return_code) {
 		case 0:
 			fsm_event(ch->fsm, CH_EVENT_IO_SUCCESS, ch);
@@ -796,7 +796,7 @@
 static void inline
 ccw_unit_check(struct channel *ch, unsigned char sense)
 {
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	if (sense & SNS0_INTERVENTION_REQ) {
 		if (sense & 0x01) {
 			if (ch->protocol != CTC_PROTO_LINUX_TTY)
@@ -842,7 +842,7 @@
 {
 	struct sk_buff *skb;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 
 	while ((skb = skb_dequeue(q))) {
 		atomic_dec(&skb->users);
@@ -853,7 +853,7 @@
 static __inline__ int
 ctc_checkalloc_buffer(struct channel *ch, int warn)
 {
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	if ((ch->trans_skb == NULL) ||
 	    (ch->flags & CHANNEL_FLAGS_BUFSIZE_CHANGED)) {
 		if (ch->trans_skb != NULL)
@@ -923,7 +923,7 @@
 	unsigned long duration;
 	struct timespec done_stamp = xtime;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 
 	duration =
 	    (done_stamp.tv_sec - ch->prof.send_stamp.tv_sec) * 1000000 +
@@ -1006,7 +1006,7 @@
 {
 	struct channel *ch = (struct channel *) arg;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	fsm_newstate(fi, CH_STATE_TXIDLE);
 	fsm_event(((struct ctc_priv *) ch->netdev->priv)->fsm, DEV_EVENT_TXUP,
@@ -1033,7 +1033,7 @@
 	int check_len;
 	int rc;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	if (len < 8) {
 		ctc_pr_debug("%s: got packet with length %d < 8\n",
@@ -1104,7 +1104,7 @@
 	struct channel *ch = (struct channel *) arg;
 	int rc;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 
 	if (fsm_getstate(fi) == CH_STATE_TXIDLE)
 		ctc_pr_debug("%s: remote side issued READ?, init ...\n", ch->id);
@@ -1180,7 +1180,7 @@
 	__u16 buflen;
 	int rc;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	buflen = *((__u16 *) ch->trans_skb->data);
 #ifdef DEBUG
@@ -1220,7 +1220,7 @@
 	int rc;
 	unsigned long saveflags;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	fsm_addtimer(&ch->timer, CTC_TIMEOUT_5SEC, CH_EVENT_TIMER, ch);
 	fsm_newstate(fi, CH_STATE_SETUPWAIT);
@@ -1252,7 +1252,7 @@
 	int rc;
 	struct net_device *dev;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	if (ch == NULL) {
 		ctc_pr_warn("ch_action_start ch=NULL\n");
 		return;
@@ -1332,7 +1332,7 @@
 	int rc;
 	int oldstate;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	fsm_addtimer(&ch->timer, CTC_TIMEOUT_5SEC, CH_EVENT_TIMER, ch);
 	if (event == CH_EVENT_STOP)
@@ -1365,7 +1365,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	fsm_newstate(fi, CH_STATE_STOPPED);
 	if (ch->trans_skb != NULL) {
@@ -1417,7 +1417,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	fsm_newstate(fi, CH_STATE_NOTOP);
 	if (CHANNEL_DIRECTION(ch->flags) == READ) {
@@ -1448,7 +1448,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
-	DBF_TEXT(setup, 2, __FUNCTION__);
+	DBF_TEXT(setup, 3, __FUNCTION__);
 	/**
 	 * Special case: Got UC_RCRESET on setmode.
 	 * This means that remote side isn't setup. In this case
@@ -1501,7 +1501,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	ctc_pr_debug("%s: %s channel restart\n", dev->name,
 		     (CHANNEL_DIRECTION(ch->flags) == READ) ? "RX" : "TX");
@@ -1536,7 +1536,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
-	DBF_TEXT(setup, 2, __FUNCTION__);
+	DBF_TEXT(setup, 3, __FUNCTION__);
 	if (event == CH_EVENT_TIMER) {
 		fsm_deltimer(&ch->timer);
 		ctc_pr_debug("%s: Timeout during RX init handshake\n", dev->name);
@@ -1565,7 +1565,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
-	DBF_TEXT(setup, 2, __FUNCTION__);
+	DBF_TEXT(setup, 3, __FUNCTION__);
 	fsm_newstate(fi, CH_STATE_RXERR);
 	ctc_pr_warn("%s: RX initialization failed\n", dev->name);
 	ctc_pr_warn("%s: RX <-> RX connection detected\n", dev->name);
@@ -1586,7 +1586,7 @@
 	struct channel *ch2;
 	struct net_device *dev = ch->netdev;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	ctc_pr_debug("%s: Got remote disconnect, re-initializing ...\n",
 		     dev->name);
@@ -1647,7 +1647,7 @@
 	struct net_device *dev = ch->netdev;
 	unsigned long saveflags;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	if (ch->retry++ > 3) {
 		ctc_pr_debug("%s: TX retry failed, restarting channel\n",
@@ -1705,7 +1705,7 @@
 	struct channel *ch = (struct channel *) arg;
 	struct net_device *dev = ch->netdev;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	if (CHANNEL_DIRECTION(ch->flags) == READ) {
 		ctc_pr_debug("%s: RX I/O error\n", dev->name);
@@ -1727,7 +1727,7 @@
  	struct net_device *dev = ch->netdev;
  	struct ctc_priv *privptr = dev->priv;
  
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
  	ch_action_iofatal(fi, event, arg);
  	fsm_addtimer(&privptr->restart_timer, 1000, DEV_EVENT_RESTART, dev);
 }
@@ -2021,7 +2021,7 @@
 {
 	struct channel *ch = channels;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 #ifdef DEBUG
 	ctc_pr_debug("ctc: %s(): searching for ch with id %s and type %d\n",
 		     __func__, id, type);
@@ -2117,7 +2117,7 @@
 	struct net_device *dev;
 	struct ctc_priv *priv;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	if (__ctc_check_irb_error(cdev, irb))
 		return;
 
@@ -2211,7 +2211,7 @@
 	struct ctc_priv *privptr = dev->priv;
 	int direction;
 
-	DBF_TEXT(setup, 2, __FUNCTION__);
+	DBF_TEXT(setup, 3, __FUNCTION__);
 	fsm_deltimer(&privptr->restart_timer);
 	fsm_newstate(fi, DEV_STATE_STARTWAIT_RXTX);
 	for (direction = READ; direction <= WRITE; direction++) {
@@ -2234,7 +2234,7 @@
 	struct ctc_priv *privptr = dev->priv;
 	int direction;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	fsm_newstate(fi, DEV_STATE_STOPWAIT_RXTX);
 	for (direction = READ; direction <= WRITE; direction++) {
 		struct channel *ch = privptr->channel[direction];
@@ -2247,7 +2247,7 @@
 	struct net_device *dev = (struct net_device *)arg;
 	struct ctc_priv *privptr = dev->priv;
 	
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	ctc_pr_debug("%s: Restarting\n", dev->name);
 	dev_action_stop(fi, event, arg);
 	fsm_event(privptr->fsm, DEV_EVENT_STOP, dev);
@@ -2269,7 +2269,7 @@
 	struct net_device *dev = (struct net_device *) arg;
 	struct ctc_priv *privptr = dev->priv;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	switch (fsm_getstate(fi)) {
 		case DEV_STATE_STARTWAIT_RXTX:
 			if (event == DEV_EVENT_RXUP)
@@ -2322,7 +2322,7 @@
 	struct net_device *dev = (struct net_device *) arg;
 	struct ctc_priv *privptr = dev->priv;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	switch (fsm_getstate(fi)) {
 		case DEV_STATE_RUNNING:
 			if (privptr->protocol == CTC_PROTO_LINUX_TTY)
@@ -2424,7 +2424,7 @@
 	struct ll_header header;
 	int rc = 0;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	if (fsm_getstate(ch->fsm) != CH_STATE_TXIDLE) {
 		int l = skb->len + LL_HEADER_LENGTH;
 
@@ -2561,6 +2561,7 @@
 static int
 ctc_open(struct net_device * dev)
 {
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	fsm_event(((struct ctc_priv *) dev->priv)->fsm, DEV_EVENT_START, dev);
 	return 0;
 }
@@ -2576,6 +2577,7 @@
 static int
 ctc_close(struct net_device * dev)
 {
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	fsm_event(((struct ctc_priv *) dev->priv)->fsm, DEV_EVENT_STOP, dev);
 	return 0;
 }
@@ -2597,7 +2599,7 @@
 	int rc = 0;
 	struct ctc_priv *privptr = (struct ctc_priv *) dev->priv;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	/**
 	 * Some sanity checks ...
 	 */
@@ -2655,7 +2657,7 @@
 {
 	struct ctc_priv *privptr = (struct ctc_priv *) dev->priv;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	if ((new_mtu < 576) || (new_mtu > 65527) ||
 	    (new_mtu > (privptr->channel[READ]->max_bufsize -
 			LL_HEADER_LENGTH - 2)))
@@ -2700,7 +2702,7 @@
 	struct net_device *ndev;
 	int bs1;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	priv = dev->driver_data;
 	if (!priv)
 		return -ENODEV;
@@ -2745,7 +2747,7 @@
 	struct ctc_priv *priv;
 	int ll1;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	priv = dev->driver_data;
 	if (!priv)
 		return -ENODEV;
@@ -2763,7 +2765,7 @@
 	char *sbuf;
 	char *p;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	if (!priv)
 		return;
 	sbuf = (char *)kmalloc(2048, GFP_KERNEL);
@@ -2893,7 +2895,7 @@
 	if (!privptr)
 		return NULL;
 
-	DBF_TEXT(setup, 2, __FUNCTION__);
+	DBF_TEXT(setup, 3, __FUNCTION__);
 	if (alloc_device) {
 		dev = kmalloc(sizeof (struct net_device), GFP_KERNEL);
 		if (!dev)
@@ -2945,7 +2947,7 @@
 	struct ctc_priv *priv;
 	int value;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	pr_debug("%s() called\n", __FUNCTION__);
 
 	priv = dev->driver_data;
@@ -3017,7 +3019,7 @@
 	int rc;
 
 	pr_debug("%s() called\n", __FUNCTION__);
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 
 	if (!get_device(&cgdev->dev))
 		return -ENODEV;
@@ -3064,7 +3066,7 @@
 	int ret;
 
 	pr_debug("%s() called\n", __FUNCTION__);
-	DBF_TEXT(setup, 2, __FUNCTION__);
+	DBF_TEXT(setup, 3, __FUNCTION__);
 
 	privptr = cgdev->dev.driver_data;
 	if (!privptr)
@@ -3158,7 +3160,7 @@
 	struct ctc_priv *priv;
 	struct net_device *ndev;
 		
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	pr_debug("%s() called\n", __FUNCTION__);
 
 	priv = cgdev->dev.driver_data;
@@ -3209,7 +3211,7 @@
 	struct ctc_priv *priv;
 
 	pr_debug("%s() called\n", __FUNCTION__);
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 
 	priv = cgdev->dev.driver_data;
 	if (!priv)
diff -urN linux-2.6/drivers/s390/net/ctctty.c linux-2.6-s390/drivers/s390/net/ctctty.c
--- linux-2.6/drivers/s390/net/ctctty.c	Tue Jul 27 16:35:49 2004
+++ linux-2.6-s390/drivers/s390/net/ctctty.c	Tue Jul 27 16:36:27 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: ctctty.c,v 1.21 2004/07/02 16:31:22 ptiedem Exp $
+ * $Id: ctctty.c,v 1.24 2004/07/15 16:03:08 ptiedem Exp $
  *
  * CTC / ESCON network driver, tty interface.
  *
@@ -104,7 +104,7 @@
 	int len;
 	struct tty_struct *tty;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	if ((tty = info->tty)) {
 		if (info->mcr & UART_MCR_RTS) {
 			c = TTY_FLIPBUF_SIZE - tty->flip.count;
@@ -134,7 +134,7 @@
 	int ret = 1;
 	struct tty_struct *tty;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	if ((tty = info->tty)) {
 		if (info->mcr & UART_MCR_RTS) {
 			int c = TTY_FLIPBUF_SIZE - tty->flip.count;
@@ -168,7 +168,7 @@
 {
 	int i;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	if ((!driver) || ctc_tty_shuttingdown)
 		return;
 	for (i = 0; i < CTC_TTY_MAX_DEVICES; i++)
@@ -189,7 +189,7 @@
 	int i;
 	ctc_tty_info *info = NULL;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	if (!skb)
 		return;
 	if ((!skb->dev) || (!driver) || ctc_tty_shuttingdown) {
@@ -254,7 +254,7 @@
 	int wake = 1;
 	int rc;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	if (!info->netdev) {
 		if (skb)
 			kfree_skb(skb);
@@ -347,7 +347,7 @@
 	int skb_res;
 	struct sk_buff *skb;
 	
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	if (ctc_tty_shuttingdown)
 		return;
 	skb_res = info->netdev->hard_header_len + sizeof(info->mcr) +
@@ -368,7 +368,7 @@
 static void
 ctc_tty_transmit_status(ctc_tty_info *info)
 {
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	if (ctc_tty_shuttingdown)
 		return;
 	info->flags |= CTC_ASYNC_TX_LINESTAT;
@@ -382,7 +382,7 @@
 	unsigned int quot;
 	int i;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	if (!info->tty || !info->tty->termios)
 		return;
 	cflag = info->tty->termios->c_cflag;
@@ -421,7 +421,7 @@
 static int
 ctc_tty_startup(ctc_tty_info * info)
 {
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	if (info->flags & CTC_ASYNC_INITIALIZED)
 		return 0;
 #ifdef CTC_DEBUG_MODEM_OPEN
@@ -464,7 +464,7 @@
 static void
 ctc_tty_shutdown(ctc_tty_info * info)
 {
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	if (!(info->flags & CTC_ASYNC_INITIALIZED))
 		return;
 #ifdef CTC_DEBUG_MODEM_OPEN
@@ -497,7 +497,7 @@
 	int total = 0;
 	ctc_tty_info *info = (ctc_tty_info *) tty->driver_data;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 5, __FUNCTION__);
 	if (ctc_tty_shuttingdown)
 		goto ex;
 	if (ctc_tty_paranoia_check(info, tty->name, "ctc_tty_write"))
@@ -575,7 +575,7 @@
 	ctc_tty_info *info;
 	unsigned long flags;
 
-	DBF_TEXT(trace, 2, __FUNCTION__);
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	if (!tty)
 		goto ex;
 	spin_lock_irqsave(&ctc_tty_lock, flags);
@@ -601,6 +601,7 @@
 {
 	ctc_tty_info *info = (ctc_tty_info *) tty->driver_data;
 
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	if (ctc_tty_shuttingdown)
 		return;
 	if (ctc_tty_paranoia_check(info, tty->name, "ctc_tty_flush_chars"))
@@ -623,6 +624,7 @@
 {
 	ctc_tty_info *info = (ctc_tty_info *) tty->driver_data;
 
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	if (ctc_tty_paranoia_check(info, tty->name, "ctc_tty_throttle"))
 		return;
 	info->mcr &= ~UART_MCR_RTS;
@@ -636,6 +638,7 @@
 {
 	ctc_tty_info *info = (ctc_tty_info *) tty->driver_data;
 
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	if (ctc_tty_paranoia_check(info, tty->name, "ctc_tty_unthrottle"))
 		return;
 	info->mcr |= UART_MCR_RTS;
@@ -667,6 +670,7 @@
 	uint result;
 	ulong flags;
 
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	spin_lock_irqsave(&ctc_tty_lock, flags);
 	status = info->lsr;
 	spin_unlock_irqrestore(&ctc_tty_lock, flags);
@@ -684,6 +688,7 @@
 	uint result;
 	ulong flags;
 
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	if (ctc_tty_paranoia_check(info, tty->name, "ctc_tty_ioctl"))
 		return -ENODEV;
 	if (tty->flags & (1 << TTY_IO_ERROR))
@@ -708,6 +713,7 @@
 {
 	ctc_tty_info *info = (ctc_tty_info *) tty->driver_data;
 
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	if (ctc_tty_paranoia_check(info, tty->name, "ctc_tty_ioctl"))
 		return -ENODEV;
 	if (tty->flags & (1 << TTY_IO_ERROR))
@@ -736,6 +742,7 @@
 	int error;
 	int retval;
 
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	if (ctc_tty_paranoia_check(info, tty->name, "ctc_tty_ioctl"))
 		return -ENODEV;
 	if (tty->flags & (1 << TTY_IO_ERROR))
@@ -803,6 +810,8 @@
 {
 	ctc_tty_info *info = (ctc_tty_info *) tty->driver_data;
 	unsigned int cflag = tty->termios->c_cflag;
+
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	ctc_tty_change_speed(info);
 
 	/* Handle transition to B0 */
@@ -840,6 +849,7 @@
 	unsigned long flags;
 	int retval;
 
+	DBF_TEXT(trace, 4, __FUNCTION__);
 	/*
 	 * If the device is in the middle of being closed, then block
 	 * until it's done, and then try again.
@@ -944,6 +954,7 @@
 	int retval,
 	 line;
 
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	line = tty->index;
 	if (line < 0 || line > CTC_TTY_MAX_DEVICES)
 		return -ENODEV;
@@ -990,7 +1001,7 @@
 	ctc_tty_info *info = (ctc_tty_info *) tty->driver_data;
 	ulong flags;
 	ulong timeout;
-
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	if (!info || ctc_tty_paranoia_check(info, tty->name, "ctc_tty_close"))
 		return;
 	spin_lock_irqsave(&ctc_tty_lock, flags);
@@ -1080,6 +1091,7 @@
 {
 	ctc_tty_info *info = (ctc_tty_info *)tty->driver_data;
 	unsigned long saveflags;
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	if (ctc_tty_paranoia_check(info, tty->name, "ctc_tty_hangup"))
 		return;
 	ctc_tty_shutdown(info);
@@ -1103,6 +1115,7 @@
 	unsigned long saveflags;
 	int again;
 
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	spin_lock_irqsave(&ctc_tty_lock, saveflags);
 	if ((!ctc_tty_shuttingdown) && info) {
 		again = ctc_tty_tint(info);
@@ -1140,6 +1153,7 @@
 	ctc_tty_info *info;
 	struct tty_driver *device;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	driver = kmalloc(sizeof(ctc_tty_driver), GFP_KERNEL);
 	if (driver == NULL) {
 		printk(KERN_WARNING "Out of memory in ctc_tty_modem_init\n");
@@ -1199,6 +1213,7 @@
 	char *err;
 	char *p;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	if ((!dev) || (!dev->name)) {
 		printk(KERN_WARNING
 		       "ctc_tty_register_netdev called "
@@ -1246,6 +1261,7 @@
 	unsigned long saveflags;
 	ctc_tty_info *info = NULL;
 
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	spin_lock_irqsave(&ctc_tty_lock, saveflags);
 	for (i = 0; i < CTC_TTY_MAX_DEVICES; i++)
 		if (driver->info[i].netdev == dev) {
@@ -1264,6 +1280,7 @@
 ctc_tty_cleanup(void) {
 	unsigned long saveflags;
 	
+	DBF_TEXT(trace, 2, __FUNCTION__);
 	spin_lock_irqsave(&ctc_tty_lock, saveflags);
 	ctc_tty_shuttingdown = 1;
 	spin_unlock_irqrestore(&ctc_tty_lock, saveflags);
diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-s390/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	Tue Jul 27 16:35:49 2004
+++ linux-2.6-s390/drivers/s390/net/iucv.c	Tue Jul 27 16:36:27 2004
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.38 2004/07/09 15:59:53 mschwide Exp $
+ * $Id: iucv.c,v 1.39 2004/07/12 06:54:14 braunu Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.38 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.39 $
  *
  */
 
@@ -354,7 +354,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.38 $";
+	char vbuf[] = "$Revision: 1.39 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -874,9 +874,6 @@
 		iucv_remove_handler(new_handler);
 		kfree(new_handler);
 		switch(rc) {
-		case -ENODEV:
-			err = "No CPU can be reserved";
-			break;
 		case 0x03:
 			err = "Directory error";
 			break;
diff -urN linux-2.6/drivers/s390/net/iucv.h linux-2.6-s390/drivers/s390/net/iucv.h
--- linux-2.6/drivers/s390/net/iucv.h	Wed Jun 16 07:20:26 2004
+++ linux-2.6-s390/drivers/s390/net/iucv.h	Tue Jul 27 16:36:27 2004
@@ -30,6 +30,94 @@
  */
 
 #include <linux/types.h>
+#include <asm/debug.h>
+
+/**
+ * Debug Facility stuff
+ */
+#define IUCV_DBF_SETUP_NAME "iucv_setup"
+#define IUCV_DBF_SETUP_LEN 32
+#define IUCV_DBF_SETUP_INDEX 1
+#define IUCV_DBF_SETUP_NR_AREAS 1
+#define IUCV_DBF_SETUP_LEVEL 3
+
+#define IUCV_DBF_DATA_NAME "iucv_data"
+#define IUCV_DBF_DATA_LEN 128
+#define IUCV_DBF_DATA_INDEX 1
+#define IUCV_DBF_DATA_NR_AREAS 1
+#define IUCV_DBF_DATA_LEVEL 2
+
+#define IUCV_DBF_TRACE_NAME "iucv_trace"
+#define IUCV_DBF_TRACE_LEN 16
+#define IUCV_DBF_TRACE_INDEX 2
+#define IUCV_DBF_TRACE_NR_AREAS 1
+#define IUCV_DBF_TRACE_LEVEL 3
+
+#define IUCV_DBF_TEXT(name,level,text) \
+	do { \
+		debug_text_event(iucv_dbf_##name,level,text); \
+	} while (0)
+
+#define IUCV_DBF_HEX(name,level,addr,len) \
+	do { \
+		debug_event(iucv_dbf_##name,level,(void*)(addr),len); \
+	} while (0)
+
+extern DEFINE_PER_CPU(char[256], iucv_dbf_txt_buf);
+
+#define IUCV_DBF_TEXT_(name,level,text...)				\
+	do {								\
+		char* iucv_dbf_txt_buf = get_cpu_var(iucv_dbf_txt_buf);	\
+		sprintf(iucv_dbf_txt_buf, text);		  	\
+		debug_text_event(iucv_dbf_##name,level,iucv_dbf_txt_buf); \
+		put_cpu_var(iucv_dbf_txt_buf);				\
+	} while (0)
+
+#define IUCV_DBF_SPRINTF(name,level,text...) \
+	do { \
+		debug_sprintf_event(iucv_dbf_trace, level, ##text ); \
+		debug_sprintf_event(iucv_dbf_trace, level, text ); \
+	} while (0)
+
+/**
+ * some more debug stuff
+ */
+#define IUCV_HEXDUMP16(importance,header,ptr) \
+PRINT_##importance(header "%02x %02x %02x %02x  %02x %02x %02x %02x  " \
+		   "%02x %02x %02x %02x  %02x %02x %02x %02x\n", \
+		   *(((char*)ptr)),*(((char*)ptr)+1),*(((char*)ptr)+2), \
+		   *(((char*)ptr)+3),*(((char*)ptr)+4),*(((char*)ptr)+5), \
+		   *(((char*)ptr)+6),*(((char*)ptr)+7),*(((char*)ptr)+8), \
+		   *(((char*)ptr)+9),*(((char*)ptr)+10),*(((char*)ptr)+11), \
+		   *(((char*)ptr)+12),*(((char*)ptr)+13), \
+		   *(((char*)ptr)+14),*(((char*)ptr)+15)); \
+PRINT_##importance(header "%02x %02x %02x %02x  %02x %02x %02x %02x  " \
+		   "%02x %02x %02x %02x  %02x %02x %02x %02x\n", \
+		   *(((char*)ptr)+16),*(((char*)ptr)+17), \
+		   *(((char*)ptr)+18),*(((char*)ptr)+19), \
+		   *(((char*)ptr)+20),*(((char*)ptr)+21), \
+		   *(((char*)ptr)+22),*(((char*)ptr)+23), \
+		   *(((char*)ptr)+24),*(((char*)ptr)+25), \
+		   *(((char*)ptr)+26),*(((char*)ptr)+27), \
+		   *(((char*)ptr)+28),*(((char*)ptr)+29), \
+		   *(((char*)ptr)+30),*(((char*)ptr)+31));
+
+static inline void
+iucv_hex_dump(unsigned char *buf, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (i && !(i % 16))
+			printk("\n");
+		printk("%02x ", *(buf + i));
+	}
+	printk("\n");
+}
+/**
+ * end of debug stuff
+ */
+
 #define uchar  unsigned char
 #define ushort unsigned short
 #define ulong  unsigned long
diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Tue Jul 27 16:35:49 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Tue Jul 27 16:36:27 2004
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.83 $	 $Date: 2004/06/30 12:48:14 $
+ *    $Revision: 1.84 $	 $Date: 2004/07/14 07:23:15 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -58,7 +58,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.83 $"
+#define VERSION_LCS_C  "$Revision: 1.84 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 static char debug_buffer[255];
@@ -1420,7 +1420,7 @@
 				   card->dev->name);
 			return 0;
 		}
-		schedule_timeout(3 * HZ);
+		msleep(30);
 	}
 	PRINT_ERR("Error in Reseting LCS card!\n");
 	return -EIO;
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Tue Jul 27 16:35:49 2004
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Tue Jul 27 16:36:27 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.57 2004/06/30 09:26:40 braunu Exp $
+ * $Id: netiucv.c,v 1.63 2004/07/27 13:36:05 mschwide Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.57 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.63 $
  *
  */
 
@@ -69,6 +69,13 @@
 MODULE_DESCRIPTION ("Linux for S/390 IUCV network driver");
 
 
+#define PRINTK_HEADER " iucv: "       /* for debugging */
+
+static struct device_driver netiucv_driver = {
+	.name = "netiucv",
+	.bus  = &iucv_bus,
+};
+
 /**
  * Per connection profiling data
  */
@@ -108,7 +115,7 @@
 /**
  * Linked list of all connection structs.
  */
-static struct iucv_connection *connections;
+static struct iucv_connection *iucv_connections;
 
 /**
  * Representation of event-data for the
@@ -172,7 +179,7 @@
  * match exactly as specified in order to give connection_pending()
  * control.
  */
-static __u8 mask[] = {
+static __u8 netiucv_mask[] = {
 	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
@@ -362,6 +369,58 @@
 
 
 /**
+ * Debug Facility Stuff
+ */
+static debug_info_t *iucv_dbf_setup = NULL;
+static debug_info_t *iucv_dbf_data = NULL;
+static debug_info_t *iucv_dbf_trace = NULL;
+
+DEFINE_PER_CPU(char[256], iucv_dbf_txt_buf);
+
+static void
+iucv_unregister_dbf_views(void)
+{
+	if (iucv_dbf_setup)
+		debug_unregister(iucv_dbf_setup);
+	if (iucv_dbf_data)
+		debug_unregister(iucv_dbf_data);
+	if (iucv_dbf_trace)
+		debug_unregister(iucv_dbf_trace);
+}
+static int
+iucv_register_dbf_views(void)
+{
+	iucv_dbf_setup = debug_register(IUCV_DBF_SETUP_NAME,
+					IUCV_DBF_SETUP_INDEX,
+					IUCV_DBF_SETUP_NR_AREAS,
+					IUCV_DBF_SETUP_LEN);
+	iucv_dbf_data = debug_register(IUCV_DBF_DATA_NAME,
+				       IUCV_DBF_DATA_INDEX,
+				       IUCV_DBF_DATA_NR_AREAS,
+				       IUCV_DBF_DATA_LEN);
+	iucv_dbf_trace = debug_register(IUCV_DBF_TRACE_NAME,
+					IUCV_DBF_TRACE_INDEX,
+					IUCV_DBF_TRACE_NR_AREAS,
+					IUCV_DBF_TRACE_LEN);
+
+	if ((iucv_dbf_setup == NULL) || (iucv_dbf_data == NULL) ||
+	    (iucv_dbf_trace == NULL)) {
+		iucv_unregister_dbf_views();
+		return -ENOMEM;
+	}
+	debug_register_view(iucv_dbf_setup, &debug_hex_ascii_view);
+	debug_set_level(iucv_dbf_setup, IUCV_DBF_SETUP_LEVEL);
+
+	debug_register_view(iucv_dbf_data, &debug_hex_ascii_view);
+	debug_set_level(iucv_dbf_data, IUCV_DBF_DATA_LEVEL);
+
+	debug_register_view(iucv_dbf_trace, &debug_hex_ascii_view);
+	debug_set_level(iucv_dbf_trace, IUCV_DBF_TRACE_LEVEL);
+
+	return 0;
+}
+
+/**
  * Callback-wrappers, called from lowlevel iucv layer.
  *****************************************************************************/
 
@@ -490,7 +549,7 @@
 		struct sk_buff *skb;
 		ll_header *header = (ll_header *)pskb->data;
 
-		if (header->next == 0)
+		if (!header->next)
 			break;
 
 		skb_pull(pskb, NETIUCV_HDRLEN);
@@ -498,19 +557,21 @@
 		offset += header->next;
 		header->next -= NETIUCV_HDRLEN;
 		if (skb_tailroom(pskb) < header->next) {
-			printk(KERN_WARNING
-			       "%s: Illegal next field in iucv header: "
+			PRINT_WARN("%s: Illegal next field in iucv header: "
 			       "%d > %d\n",
 			       dev->name, header->next, skb_tailroom(pskb));
+			IUCV_DBF_TEXT_(data, 2, "Illegal next field: %d > %d\n",
+				header->next, skb_tailroom(pskb));
 			return;
 		}
 		skb_put(pskb, header->next);
 		pskb->mac.raw = pskb->data;
 		skb = dev_alloc_skb(pskb->len);
 		if (!skb) {
-			printk(KERN_WARNING
-			       "%s Out of memory in netiucv_unpack_skb\n",
+			PRINT_WARN("%s Out of memory in netiucv_unpack_skb\n",
 			       dev->name);
+			IUCV_DBF_TEXT(data, 2,
+				"Out of memory in netiucv_unpack_skb\n");
 			privptr->stats.rx_dropped++;
 			return;
 		}
@@ -538,31 +599,37 @@
 	struct iucv_event *ev = (struct iucv_event *)arg;
 	struct iucv_connection *conn = ev->conn;
 	iucv_MessagePending *eib = (iucv_MessagePending *)ev->data;
-	struct netiucv_priv *privptr = (struct netiucv_priv *)conn->netdev->priv;
+	struct netiucv_priv *privptr =(struct netiucv_priv *)conn->netdev->priv;
 
 	__u32 msglen = eib->ln1msg2.ipbfln1f;
 	int rc;
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 
 	if (!conn->netdev) {
 		/* FRITZ: How to tell iucv LL to drop the msg? */
-		printk(KERN_WARNING
-		       "Received data for unlinked connection\n"); 
+		PRINT_WARN("Received data for unlinked connection\n");
+		IUCV_DBF_TEXT(data, 2,
+			"Received data for unlinked connection\n");
 		return;
 	}
 	if (msglen > conn->max_buffsize) {
 		/* FRITZ: How to tell iucv LL to drop the msg? */
 		privptr->stats.rx_dropped++;
+		PRINT_WARN("msglen %d > max_buffsize %d\n",
+			msglen, conn->max_buffsize);
+		IUCV_DBF_TEXT_(data, 2, "msglen %d > max_buffsize %d\n",
+			msglen, conn->max_buffsize);
 		return;
 	}
 	conn->rx_buff->data = conn->rx_buff->tail = conn->rx_buff->head;
 	conn->rx_buff->len = 0;
 	rc = iucv_receive(conn->pathid, eib->ipmsgid, eib->iptrgcls,
 			  conn->rx_buff->data, msglen, NULL, NULL, NULL);
-	if (rc != 0 || msglen < 5) {
+	if (rc || msglen < 5) {
 		privptr->stats.rx_errors++;
-		printk(KERN_INFO "iucv_receive returned %08x\n", rc);
+		PRINT_WARN("iucv_receive returned %08x\n", rc);
+		IUCV_DBF_TEXT_(data, 2, "rc %d from iucv_receive\n", rc);
 		return;
 	}
 	netiucv_unpack_skb(conn, conn->rx_buff);
@@ -584,7 +651,7 @@
 	unsigned long saveflags;
 	ll_header header;
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 
 	if (conn && conn->netdev && conn->netdev->priv)
 		privptr = (struct netiucv_priv *)conn->netdev->priv;
@@ -634,13 +701,13 @@
 		conn->prof.tx_pending++;
 		if (conn->prof.tx_pending > conn->prof.tx_max_pending)
 			conn->prof.tx_max_pending = conn->prof.tx_pending;
-		if (rc != 0) {
+		if (rc) {
 			conn->prof.tx_pending--;
 			fsm_newstate(fi, CONN_STATE_IDLE);
 			if (privptr)
 				privptr->stats.tx_errors += txpackets;
-			printk(KERN_INFO "iucv_send returned %08x\n",
-				rc);
+			PRINT_WARN("iucv_send returned %08x\n",	rc);
+			IUCV_DBF_TEXT_(data, 2, "rc %d from iucv_send\n", rc);
 		} else {
 			if (privptr) {
 				privptr->stats.tx_packets += txpackets;
@@ -665,14 +732,14 @@
 	__u16 msglimit;
 	__u8 udata[16];
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
 	rc = iucv_accept(eib->ippathid, NETIUCV_QUEUELEN_DEFAULT, udata, 0,
 			 conn->handle, conn, NULL, &msglimit);
-	if (rc != 0) {
-		printk(KERN_WARNING
-		       "%s: IUCV accept failed with error %d\n",
+	if (rc) {
+		PRINT_WARN("%s: IUCV accept failed with error %d\n",
 		       netdev->name, rc);
+		IUCV_DBF_TEXT_(setup, 2, "rc %d from iucv_accept", rc);
 		return;
 	}
 	fsm_newstate(fi, CONN_STATE_IDLE);
@@ -690,13 +757,16 @@
 	iucv_ConnectionPending *eib = (iucv_ConnectionPending *)ev->data;
 	__u8 udata[16];
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
 	iucv_sever(eib->ippathid, udata);
 	if (eib->ippathid != conn->pathid) {
-		printk(KERN_INFO
-			"%s: IR Connection Pending; pathid %d does not match original pathid %d\n",
+		PRINT_INFO("%s: IR Connection Pending; "
+			"pathid %d does not match original pathid %d\n",
 			netdev->name, eib->ippathid, conn->pathid);
+		IUCV_DBF_TEXT_(data, 2,
+			"connreject: IR pathid %d, conn. pathid %d\n",
+			eib->ippathid, conn->pathid);
 		iucv_sever(conn->pathid, udata);
 	}
 }
@@ -710,14 +780,17 @@
 	struct net_device *netdev = conn->netdev;
 	struct netiucv_priv *privptr = (struct netiucv_priv *)netdev->priv;
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
 	fsm_deltimer(&conn->timer);
 	fsm_newstate(fi, CONN_STATE_IDLE);
 	if (eib->ippathid != conn->pathid) {
-		printk(KERN_INFO
-			"%s: IR Connection Complete; pathid %d does not match original pathid %d\n",
+		PRINT_INFO("%s: IR Connection Complete; "
+			"pathid %d does not match original pathid %d\n",
 			netdev->name, eib->ippathid, conn->pathid);
+		IUCV_DBF_TEXT_(data, 2,
+			"connack: IR pathid %d, conn. pathid %d\n",
+			eib->ippathid, conn->pathid);
 		conn->pathid = eib->ippathid;
 	}
 	netdev->tx_queue_len = eib->ipmsglim;
@@ -730,7 +803,7 @@
 	struct iucv_connection *conn = (struct iucv_connection *)arg;
 	__u8 udata[16];
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
 	fsm_deltimer(&conn->timer);
 	iucv_sever(conn->pathid, udata);
@@ -746,12 +819,13 @@
 	struct netiucv_priv *privptr = (struct netiucv_priv *)netdev->priv;
 	__u8 udata[16];
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
 	fsm_deltimer(&conn->timer);
 	iucv_sever(conn->pathid, udata);
-	printk(KERN_INFO "%s: Remote dropped connection\n",
-	       netdev->name);
+	PRINT_INFO("%s: Remote dropped connection\n", netdev->name);
+	IUCV_DBF_TEXT(data, 2,
+		"conn_action_connsever: Remote dropped connection\n");
 	fsm_newstate(fi, CONN_STATE_STARTWAIT);
 	fsm_event(privptr->fsm, DEV_EVENT_CONDOWN, netdev);
 }
@@ -764,24 +838,28 @@
 	__u16 msglimit;
 	int rc;
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
-	if (conn->handle == 0) {
+	if (!conn->handle) {
+		IUCV_DBF_TEXT(trace, 5, "calling iucv_register_program\n");
 		conn->handle =
-			iucv_register_program(iucvMagic, conn->userid, mask,
+			iucv_register_program(iucvMagic, conn->userid,
+					      netiucv_mask,
 					      &netiucv_ops, conn);
 		fsm_newstate(fi, CONN_STATE_STARTWAIT);
-		if (conn->handle <= 0) {
+		if (!conn->handle) {
 			fsm_newstate(fi, CONN_STATE_REGERR);
-			conn->handle = 0;
+			conn->handle = NULL;
+			IUCV_DBF_TEXT(setup, 2,
+				"NULL from iucv_register_program\n");
 			return;
 		}
 
-		pr_debug("%s('%s'): registered successfully\n",
+		PRINT_DEBUG("%s('%s'): registered successfully\n",
 			 conn->netdev->name, conn->userid);
 	}
 
-	pr_debug("%s('%s'): connecting ...\n",
+	PRINT_DEBUG("%s('%s'): connecting ...\n",
 		 conn->netdev->name, conn->userid);
 
 	/* We must set the state before calling iucv_connect because the callback
@@ -790,8 +868,8 @@
 
 	fsm_newstate(fi, CONN_STATE_SETUPWAIT);
 	rc = iucv_connect(&(conn->pathid), NETIUCV_QUEUELEN_DEFAULT, iucvMagic,
-			  conn->userid, iucv_host, 0, NULL, &msglimit, conn->handle,
-			  conn);
+			  conn->userid, iucv_host, 0, NULL, &msglimit,
+			  conn->handle, conn);
 	switch (rc) {
 		case 0:
 			conn->netdev->tx_queue_len = msglimit;
@@ -799,47 +877,45 @@
 				CONN_EVENT_TIMER, conn);
 			return;
 		case 11:
-			printk(KERN_NOTICE
-			       "%s: User %s is currently not available.\n",
+			PRINT_INFO("%s: User %s is currently not available.\n",
 			       conn->netdev->name,
 			       netiucv_printname(conn->userid));
 			fsm_newstate(fi, CONN_STATE_STARTWAIT);
 			return;
 		case 12:
-			printk(KERN_NOTICE
-			       "%s: User %s is currently not ready.\n",
+			PRINT_INFO("%s: User %s is currently not ready.\n",
 			       conn->netdev->name,
 			       netiucv_printname(conn->userid));
 			fsm_newstate(fi, CONN_STATE_STARTWAIT);
 			return;
 		case 13:
-			printk(KERN_WARNING
-			       "%s: Too many IUCV connections.\n",
+			PRINT_WARN("%s: Too many IUCV connections.\n",
 			       conn->netdev->name);
 			fsm_newstate(fi, CONN_STATE_CONNERR);
 			break;
 		case 14:
-			printk(KERN_WARNING
+			PRINT_WARN(
 			       "%s: User %s has too many IUCV connections.\n",
 			       conn->netdev->name,
 			       netiucv_printname(conn->userid));
 			fsm_newstate(fi, CONN_STATE_CONNERR);
 			break;
 		case 15:
-			printk(KERN_WARNING
+			PRINT_WARN(
 			       "%s: No IUCV authorization in CP directory.\n",
 			       conn->netdev->name);
 			fsm_newstate(fi, CONN_STATE_CONNERR);
 			break;
 		default:
-			printk(KERN_WARNING
-			       "%s: iucv_connect returned error %d\n",
+			PRINT_WARN("%s: iucv_connect returned error %d\n",
 			       conn->netdev->name, rc);
 			fsm_newstate(fi, CONN_STATE_CONNERR);
 			break;
 	}
+	IUCV_DBF_TEXT_(setup, 5, "iucv_connect rc is %d\n", rc);
+	IUCV_DBF_TEXT(trace, 5, "calling iucv_unregister_program\n");
 	iucv_unregister_program(conn->handle);
-	conn->handle = 0;
+	conn->handle = NULL;
 }
 
 static void
@@ -861,14 +937,15 @@
 	struct net_device *netdev = conn->netdev;
 	struct netiucv_priv *privptr = (struct netiucv_priv *)netdev->priv;
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
 	fsm_deltimer(&conn->timer);
 	fsm_newstate(fi, CONN_STATE_STOPPED);
 	netiucv_purge_skb_queue(&conn->collect_queue);
 	if (conn->handle)
+		IUCV_DBF_TEXT(trace, 5, "calling iucv_unregister_program\n");
 		iucv_unregister_program(conn->handle);
-	conn->handle = 0;
+	conn->handle = NULL;
 	netiucv_purge_skb_queue(&conn->commit_queue);
 	fsm_event(privptr->fsm, DEV_EVENT_CONDOWN, netdev);
 }
@@ -880,9 +957,9 @@
 	struct iucv_connection *conn = ev->conn;
 	struct net_device *netdev = conn->netdev;
 
-	printk(KERN_WARNING
-	       "%s: Cannot connect without username\n",
+	PRINT_WARN("%s: Cannot connect without username\n",
 	       netdev->name);
+	IUCV_DBF_TEXT(data, 2, "conn_action_inval called\n");
 }
 
 static const fsm_node conn_fsm[] = {
@@ -938,7 +1015,7 @@
 	struct netiucv_priv *privptr = dev->priv;
 	struct iucv_event   ev;
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
 	ev.conn = privptr->conn;
 	fsm_newstate(fi, DEV_STATE_STARTWAIT);
@@ -959,7 +1036,7 @@
 	struct netiucv_priv *privptr = dev->priv;
 	struct iucv_event   ev;
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
 	ev.conn = privptr->conn;
 
@@ -981,19 +1058,22 @@
 	struct net_device   *dev = (struct net_device *)arg;
 	struct netiucv_priv *privptr = dev->priv;
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
 	switch (fsm_getstate(fi)) {
 		case DEV_STATE_STARTWAIT:
 			fsm_newstate(fi, DEV_STATE_RUNNING);
-			printk(KERN_INFO
-			       "%s: connected with remote side %s\n",
+			PRINT_INFO("%s: connected with remote side %s\n",
 			       dev->name, privptr->conn->userid);
+			IUCV_DBF_TEXT(setup, 3,
+				"connection is up and running\n");
 			break;
 		case DEV_STATE_STOPWAIT:
-			printk(KERN_INFO
-			       "%s: got connection UP event during shutdown!!\n",
+			PRINT_INFO(
+			       "%s: got connection UP event during shutdown!\n",
 			       dev->name);
+			IUCV_DBF_TEXT(data, 2,
+				"dev_action_connup: in DEV_STATE_STOPWAIT\n");
 			break;
 	}
 }
@@ -1009,7 +1089,7 @@
 static void
 dev_action_conndown(fsm_instance *fi, int event, void *arg)
 {
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
 	switch (fsm_getstate(fi)) {
 		case DEV_STATE_RUNNING:
@@ -1017,6 +1097,7 @@
 			break;
 		case DEV_STATE_STOPWAIT:
 			fsm_newstate(fi, DEV_STATE_STOPPED);
+			IUCV_DBF_TEXT(setup, 3, "connection is down\n");
 			break;
 	}
 }
@@ -1059,9 +1140,11 @@
 
 		spin_lock_irqsave(&conn->collect_lock, saveflags);
 		if (conn->collect_len + l >
-		    (conn->max_buffsize - NETIUCV_HDRLEN))
+		    (conn->max_buffsize - NETIUCV_HDRLEN)) {
 			rc = -EBUSY;
-		else {
+			IUCV_DBF_TEXT(data, 2,
+				"EBUSY from netiucv_transmit_skb\n");
+		} else {
 			atomic_inc(&skb->users);
 			skb_queue_tail(&conn->collect_queue, skb);
 			conn->collect_len += l;
@@ -1080,9 +1163,9 @@
 			nskb = alloc_skb(skb->len + NETIUCV_HDRLEN +
 					 NETIUCV_HDRLEN, GFP_ATOMIC | GFP_DMA);
 			if (!nskb) {
-				printk(KERN_WARNING
-				       "%s: Could not allocate tx_skb\n",
+				PRINT_WARN("%s: Could not allocate tx_skb\n",
 				       conn->netdev->name);
+				IUCV_DBF_TEXT(data, 2, "alloc_skb failed\n");
 				rc = -ENOMEM;
 				return rc;
 			} else {
@@ -1111,7 +1194,7 @@
 		conn->prof.tx_pending++;
 		if (conn->prof.tx_pending > conn->prof.tx_max_pending)
 			conn->prof.tx_max_pending = conn->prof.tx_pending;
-		if (rc != 0) {
+		if (rc) {
 			struct netiucv_priv *privptr;
 			fsm_newstate(conn->fsm, CONN_STATE_IDLE);
 			conn->prof.tx_pending--;
@@ -1128,8 +1211,8 @@
 				skb_pull(skb, NETIUCV_HDRLEN);
 				skb_trim(skb, skb->len - NETIUCV_HDRLEN);
 			}
-			printk(KERN_INFO "iucv_send returned %08x\n",
-				rc);
+			PRINT_WARN("iucv_send returned %08x\n",	rc);
+			IUCV_DBF_TEXT_(data, 2, "rc %d from iucv_send\n", rc);
 		} else {
 			if (copied)
 				dev_kfree_skb(skb);
@@ -1155,7 +1238,7 @@
  */
 static int
 netiucv_open(struct net_device *dev) {
-	fsm_event(((struct netiucv_priv *)dev->priv)->fsm, DEV_EVENT_START, dev);
+	fsm_event(((struct netiucv_priv *)dev->priv)->fsm, DEV_EVENT_START,dev);
 	return 0;
 }
 
@@ -1189,18 +1272,21 @@
 	int          rc = 0;
 	struct netiucv_priv *privptr = dev->priv;
 
+	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	/**
 	 * Some sanity checks ...
 	 */
 	if (skb == NULL) {
-		printk(KERN_WARNING "%s: NULL sk_buff passed\n", dev->name);
+		PRINT_WARN("%s: NULL sk_buff passed\n", dev->name);
+		IUCV_DBF_TEXT(data, 2, "netiucv_tx: skb is NULL\n");
 		privptr->stats.tx_dropped++;
 		return 0;
 	}
-	if (skb_headroom(skb) < (NETIUCV_HDRLEN)) {
-		printk(KERN_WARNING
-		       "%s: Got sk_buff with head room < %ld bytes\n",
+	if (skb_headroom(skb) < NETIUCV_HDRLEN) {
+		PRINT_WARN("%s: Got sk_buff with head room < %ld bytes\n",
 		       dev->name, NETIUCV_HDRLEN);
+		IUCV_DBF_TEXT(data, 2,
+			"netiucv_tx: skb_headroom < NETIUCV_HDRLEN\n");
 		dev_kfree_skb(skb);
 		privptr->stats.tx_dropped++;
 		return 0;
@@ -1219,11 +1305,12 @@
 		return 0;
 	}
 
-	if (netiucv_test_and_set_busy(dev))
+	if (netiucv_test_and_set_busy(dev)) {
+		IUCV_DBF_TEXT(data, 2, "EBUSY from netiucv_tx\n");
 		return -EBUSY;
-
+	}
 	dev->trans_start = jiffies;
-	if (netiucv_transmit_skb(privptr->conn, skb) != 0)
+	if (netiucv_transmit_skb(privptr->conn, skb))
 		rc = 1;
 	netiucv_clear_busy(dev);
 	return rc;
@@ -1239,6 +1326,7 @@
 static struct net_device_stats *
 netiucv_stats (struct net_device * dev)
 {
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return &((struct netiucv_priv *)dev->priv)->stats;
 }
 
@@ -1254,8 +1342,11 @@
 static int
 netiucv_change_mtu (struct net_device * dev, int new_mtu)
 {
-	if ((new_mtu < 576) || (new_mtu > NETIUCV_MTU_MAX))
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
+	if ((new_mtu < 576) || (new_mtu > NETIUCV_MTU_MAX)) {
+		IUCV_DBF_TEXT(setup, 2, "given MTU out of valid range\n");
 		return -EINVAL;
+	}
 	dev->mtu = new_mtu;
 	return 0;
 }
@@ -1269,6 +1360,7 @@
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%s\n", netiucv_printname(priv->conn->userid));
 }
 
@@ -1282,9 +1374,11 @@
 	char 	username[10];
 	int 	i;
 
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 	if (count>9) {
-		printk(KERN_WARNING
-			"netiucv: username too long (%d)!\n", (int)count);
+		PRINT_WARN("netiucv: username too long (%d)!\n", (int)count);
+		IUCV_DBF_TEXT_(setup, 2,
+			"%d is length of username\n", (int)count);
 		return -EINVAL;
 	}
 
@@ -1296,8 +1390,11 @@
 			/* trailing lf, grr */
 			break;
 		} else {
-			printk(KERN_WARNING
-				"netiucv: Invalid character in username!\n");
+			PRINT_WARN("netiucv: Invalid char %c in username!\n",
+				*p);
+			IUCV_DBF_TEXT_(setup, 2,
+				"username: invalid character %c\n",
+				*p);
 			return -EINVAL;
 		}
 	}
@@ -1305,14 +1402,14 @@
 		username[i++] = ' ';
 	username[9] = '\0';
 
-	if (memcmp(username, priv->conn->userid, 8) != 0) {
+	if (memcmp(username, priv->conn->userid, 8)) {
 		/* username changed */
 		if (ndev->flags & (IFF_UP | IFF_RUNNING)) {
-			printk(KERN_WARNING
+			PRINT_WARN(
 				"netiucv: device %s active, connected to %s\n",
 				dev->bus_id, priv->conn->userid);
-			printk(KERN_WARNING
-				"netiucv: user cannot be updated\n");
+			PRINT_WARN("netiucv: user cannot be updated\n");
+			IUCV_DBF_TEXT(setup, 2, "user_write: device active\n");
 			return -EBUSY;
 		}
 	}
@@ -1329,6 +1426,7 @@
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%d\n", priv->conn->max_buffsize);
 }
 
@@ -1340,28 +1438,42 @@
 	char         *e;
 	int          bs1;
 
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 	if (count >= 39)
 		return -EINVAL;
 
 	bs1 = simple_strtoul(buf, &e, 0);
 
 	if (e && (!isspace(*e))) {
-		printk(KERN_WARNING
-			"netiucv: Invalid character in buffer!\n");
+		PRINT_WARN("netiucv: Invalid character in buffer!\n");
+		IUCV_DBF_TEXT_(setup, 2, "buffer_write: invalid char %c\n", *e);
 		return -EINVAL;
 	}
 	if (bs1 > NETIUCV_BUFSIZE_MAX) {
-		printk(KERN_WARNING
-			"netiucv: Given buffer size %d too large.\n",
+		PRINT_WARN("netiucv: Given buffer size %d too large.\n",
+			bs1);
+		IUCV_DBF_TEXT_(setup, 2,
+			"buffer_write: buffer size %d too large\n",
 			bs1);
-
 		return -EINVAL;
 	}
 	if ((ndev->flags & IFF_RUNNING) &&
-	    (bs1 < (ndev->mtu + NETIUCV_HDRLEN + 2)))
+	    (bs1 < (ndev->mtu + NETIUCV_HDRLEN + 2))) {
+		PRINT_WARN("netiucv: Given buffer size %d too small.\n",
+			bs1);
+		IUCV_DBF_TEXT_(setup, 2,
+			"buffer_write: buffer size %d too small\n",
+			bs1);
 		return -EINVAL;
-	if (bs1 < (576 + NETIUCV_HDRLEN + NETIUCV_HDRLEN))
+	}
+	if (bs1 < (576 + NETIUCV_HDRLEN + NETIUCV_HDRLEN)) {
+		PRINT_WARN("netiucv: Given buffer size %d too small.\n",
+			bs1);
+		IUCV_DBF_TEXT_(setup, 2,
+			"buffer_write: buffer size %d too small\n",
+			bs1);
 		return -EINVAL;
+	}
 
 	priv->conn->max_buffsize = bs1;
 	if (!(ndev->flags & IFF_RUNNING))
@@ -1377,7 +1489,8 @@
 dev_fsm_show (struct device *dev, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
-	
+
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%s\n", fsm_getstate_str(priv->fsm));
 }
 
@@ -1387,7 +1500,8 @@
 conn_fsm_show (struct device *dev, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
-	
+
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%s\n", fsm_getstate_str(priv->conn->fsm));
 }
 
@@ -1397,7 +1511,8 @@
 maxmulti_show (struct device *dev, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
-	
+
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.maxmulti);
 }
 
@@ -1405,7 +1520,8 @@
 maxmulti_write (struct device *dev, const char *buf, size_t count)
 {
 	struct netiucv_priv *priv = dev->driver_data;
-	
+
+	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.maxmulti = 0;
 	return count;
 }
@@ -1416,7 +1532,8 @@
 maxcq_show (struct device *dev, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
-	
+
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.maxcqueue);
 }
 
@@ -1425,6 +1542,7 @@
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
+	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.maxcqueue = 0;
 	return count;
 }
@@ -1435,7 +1553,8 @@
 sdoio_show (struct device *dev, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
-	
+
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.doios_single);
 }
 
@@ -1444,6 +1563,7 @@
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
+	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.doios_single = 0;
 	return count;
 }
@@ -1454,7 +1574,8 @@
 mdoio_show (struct device *dev, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
-	
+
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.doios_multi);
 }
 
@@ -1463,6 +1584,7 @@
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	priv->conn->prof.doios_multi = 0;
 	return count;
 }
@@ -1473,7 +1595,8 @@
 txlen_show (struct device *dev, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
-	
+
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.txlen);
 }
 
@@ -1482,6 +1605,7 @@
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
+	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.txlen = 0;
 	return count;
 }
@@ -1492,7 +1616,8 @@
 txtime_show (struct device *dev, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
-	
+
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.tx_time);
 }
 
@@ -1501,6 +1626,7 @@
 {
 	struct netiucv_priv *priv = dev->driver_data;
 	
+	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.tx_time = 0;
 	return count;
 }
@@ -1512,6 +1638,7 @@
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.tx_pending);
 }
 
@@ -1520,6 +1647,7 @@
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
+	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.tx_pending = 0;
 	return count;
 }
@@ -1531,6 +1659,7 @@
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
+	IUCV_DBF_TEXT(trace, 5, __FUNCTION__);
 	return sprintf(buf, "%ld\n", priv->conn->prof.tx_max_pending);
 }
 
@@ -1539,6 +1668,7 @@
 {
 	struct netiucv_priv *priv = dev->driver_data;
 
+	IUCV_DBF_TEXT(trace, 4, __FUNCTION__);
 	priv->conn->prof.tx_max_pending = 0;
 	return count;
 }
@@ -1579,8 +1709,7 @@
 {
 	int ret;
 
-	pr_debug("%s() called\n", __FUNCTION__);
-
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 	ret = sysfs_create_group(&dev->kobj, &netiucv_attr_group);
 	if (ret)
 		return ret;
@@ -1593,7 +1722,7 @@
 static inline void
 netiucv_remove_files(struct device *dev)
 {
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 	sysfs_remove_group(&dev->kobj, &netiucv_stat_attr_group);
 	sysfs_remove_group(&dev->kobj, &netiucv_attr_group);
 }
@@ -1606,7 +1735,7 @@
 	int ret;
 
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
 	if (dev) {
 		memset(dev, 0, sizeof(struct device));
@@ -1621,6 +1750,7 @@
 		 * but legitime ...).
 		 */
 		dev->release = (void (*)(struct device *))kfree;
+		dev->driver = &netiucv_driver;
 	} else
 		return -ENOMEM;
 
@@ -1631,8 +1761,8 @@
 	ret = netiucv_add_files(dev);
 	if (ret)
 		goto out_unreg;
-	dev->driver_data = priv;
 	priv->dev = dev;
+	dev->driver_data = priv;
 	return 0;
 
 out_unreg:
@@ -1643,19 +1773,19 @@
 static void
 netiucv_unregister_device(struct device *dev)
 {
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 	netiucv_remove_files(dev);
 	device_unregister(dev);
 }
 
 /**
  * Allocate and initialize a new connection structure.
- * Add it to the list of connections;
+ * Add it to the list of netiucv connections;
  */
 static struct iucv_connection *
 netiucv_new_connection(struct net_device *dev, char *username)
 {
-	struct iucv_connection **clist = &connections;
+	struct iucv_connection **clist = &iucv_connections;
 	struct iucv_connection *conn =
 		(struct iucv_connection *)
 		kmalloc(sizeof(struct iucv_connection), GFP_KERNEL);
@@ -1706,23 +1836,22 @@
 
 /**
  * Release a connection structure and remove it from the
- * list of connections.
+ * list of netiucv connections.
  */
 static void
 netiucv_remove_connection(struct iucv_connection *conn)
 {
-	struct iucv_connection **clist = &connections;
-
-	pr_debug("%s() called\n", __FUNCTION__);
+	struct iucv_connection **clist = &iucv_connections;
 
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 	if (conn == NULL)
 		return;
 	while (*clist) {
 		if (*clist == conn) {
 			*clist = conn->next;
-			if (conn->handle != 0) {
+			if (conn->handle) {
 				iucv_unregister_program(conn->handle);
-				conn->handle = 0;
+				conn->handle = NULL;
 			}
 			fsm_deltimer(&conn->timer);
 			kfree_fsm(conn->fsm);
@@ -1742,7 +1871,7 @@
 {
 	struct netiucv_priv *privptr;
 
-	pr_debug("%s() called\n", __FUNCTION__);
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
 	if (!dev)
 		return;
@@ -1753,7 +1882,7 @@
 			netiucv_remove_connection(privptr->conn);
 		if (privptr->fsm)
 			kfree_fsm(privptr->fsm);
-		privptr->conn = 0; privptr->fsm = 0;
+		privptr->conn = NULL; privptr->fsm = NULL;
 		/* privptr gets freed by free_netdev() */
 	}
 	free_netdev(dev);
@@ -1795,12 +1924,16 @@
 			   netiucv_setup_netdevice);
 	if (!dev)
 		return NULL;
+	if (dev_alloc_name(dev, dev->name) < 0) {
+		free_netdev(dev);
+		return NULL;
+	}
 
-        privptr = (struct netiucv_priv *)dev->priv;
+	privptr = (struct netiucv_priv *)dev->priv;
 	privptr->fsm = init_fsm("netiucvdev", dev_state_names,
 				dev_event_names, NR_DEV_STATES, NR_DEV_EVENTS,
 				dev_fsm, DEV_FSM_LEN, GFP_KERNEL);
-	if (privptr->fsm == NULL) {
+	if (!privptr->fsm) {
 		free_netdev(dev);
 		return NULL;
 	}
@@ -1808,6 +1941,7 @@
 	if (!privptr->conn) {
 		kfree_fsm(privptr->fsm);
 		free_netdev(dev);
+		IUCV_DBF_TEXT(setup, 2, "NULL from netiucv_new_connection\n");
 		return NULL;
 	}
 	fsm_newstate(privptr->fsm, DEV_STATE_STOPPED);
@@ -1823,9 +1957,10 @@
 	int i, ret;
 	struct net_device *dev;
 
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 	if (count>9) {
-		printk(KERN_WARNING
-		       "netiucv: username too long (%d)!\n", (int)count);
+		PRINT_WARN("netiucv: username too long (%d)!\n", (int)count);
+		IUCV_DBF_TEXT(setup, 2, "conn_write: too long\n");
 		return -EINVAL;
 	}
 
@@ -1836,8 +1971,9 @@
 			/* trailing lf, grr */
 			break;
 		} else {
-			printk(KERN_WARNING
-			       "netiucv: Invalid character in username!\n");
+			PRINT_WARN("netiucv: Invalid character in username!\n");
+			IUCV_DBF_TEXT_(setup, 2,
+				"conn_write: invalid character %c\n", *p);
 			return -EINVAL;
 		}
 	}
@@ -1846,30 +1982,36 @@
 	username[9] = '\0';
 	dev = netiucv_init_netdevice(username);
 	if (!dev) {
-		printk(KERN_WARNING
+		PRINT_WARN(
 		       "netiucv: Could not allocate network device structure "
 		       "for user '%s'\n", netiucv_printname(username));
+		IUCV_DBF_TEXT(setup, 2, "NULL from netiucv_init_netdevice\n");
 		return -ENODEV;
 	}
-	
-	if ((ret = register_netdev(dev))) {
-		goto out_free_ndev;
-	}
 
 	if ((ret = netiucv_register_device(dev))) {
-		unregister_netdev(dev);
+		IUCV_DBF_TEXT_(setup, 2,
+			"ret %d from netiucv_register_device\n", ret);
 		goto out_free_ndev;
 	}
 
 	/* sysfs magic */
-	SET_NETDEV_DEV(dev, (struct device*)((struct netiucv_priv*)dev->priv)->dev);
-	printk(KERN_INFO "%s: '%s'\n", dev->name, netiucv_printname(username));
+	SET_NETDEV_DEV(dev,
+			(struct device*)((struct netiucv_priv*)dev->priv)->dev);
+
+	if ((ret = register_netdev(dev))) {
+		netiucv_unregister_device((struct device*)
+			((struct netiucv_priv*)dev->priv)->dev);
+		goto out_free_ndev;
+	}
+
+	PRINT_INFO("%s: '%s'\n", dev->name, netiucv_printname(username));
 	
 	return count;
 
 out_free_ndev:
-	printk(KERN_WARNING
-		       "netiucv: Could not register '%s'\n", dev->name);
+	PRINT_WARN("netiucv: Could not register '%s'\n", dev->name);
+	IUCV_DBF_TEXT(setup, 2, "conn_write: could not register\n");
 	netiucv_free_netdevice(dev);
 	return ret;
 }
@@ -1879,7 +2021,7 @@
 static ssize_t
 remove_write (struct device_driver *drv, const char *buf, size_t count)
 {
-	struct iucv_connection **clist = &connections;
+	struct iucv_connection **clist = &iucv_connections;
         struct net_device *ndev;
         struct netiucv_priv *priv;
         struct device *dev;
@@ -1887,7 +2029,7 @@
         char *p;
         int i;
 
-        pr_debug("%s() called\n", __FUNCTION__);
+        IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 
         if (count >= IFNAMSIZ)
                 count = IFNAMSIZ-1;
@@ -1912,34 +2054,29 @@
                         continue;
                 }
                 if (ndev->flags & (IFF_UP | IFF_RUNNING)) {
-                        printk(KERN_WARNING
+                        PRINT_WARN(
                                 "netiucv: net device %s active with peer %s\n",
                                 ndev->name, priv->conn->userid);
-                        printk(KERN_WARNING
-                                "netiucv: %s cannot be removed\n",
+                        PRINT_WARN("netiucv: %s cannot be removed\n",
                                 ndev->name);
+			IUCV_DBF_TEXT(data, 2, "remove_write: still active\n");
                         return -EBUSY;
                 }
                 unregister_netdev(ndev);
                 netiucv_unregister_device(dev);
                 return count;
         }
-        printk(KERN_WARNING
-                "netiucv: net device %s unknown\n", name);
+        PRINT_WARN("netiucv: net device %s unknown\n", name);
+	IUCV_DBF_TEXT(data, 2, "remove_write: unknown device\n");
         return -EINVAL;
 }
 
 DRIVER_ATTR(remove, 0200, NULL, remove_write);
 
-static struct device_driver netiucv_driver = {
-	.name = "netiucv",
-	.bus  = &iucv_bus,
-};
-
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.57 $";
+	char vbuf[] = "$Revision: 1.63 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -1948,14 +2085,15 @@
 			*p = '\0';
 	} else
 		version = " ??? ";
-	printk(KERN_INFO "NETIUCV driver Version%s initialized\n", version);
+	PRINT_INFO("NETIUCV driver Version%s initialized\n", version);
 }
 
 static void __exit
 netiucv_exit(void)
 {
-	while (connections) {
-		struct net_device *ndev = connections->netdev;
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
+	while (iucv_connections) {
+		struct net_device *ndev = iucv_connections->netdev;
 		struct netiucv_priv *priv = (struct netiucv_priv*)ndev->priv;
 		struct device *dev = priv->dev;
 
@@ -1966,8 +2104,9 @@
 	driver_remove_file(&netiucv_driver, &driver_attr_connection);
 	driver_remove_file(&netiucv_driver, &driver_attr_remove);
 	driver_unregister(&netiucv_driver);
+	iucv_unregister_dbf_views();
 
-	printk(KERN_INFO "NETIUCV driver unloaded\n");
+	PRINT_INFO("NETIUCV driver unloaded\n");
 	return;
 }
 
@@ -1976,20 +2115,31 @@
 {
 	int ret;
 	
+	ret = iucv_register_dbf_views();
+	if (ret) {
+		PRINT_WARN("netiucv_init failed, "
+			"iucv_register_dbf_views rc = %d\n", ret);
+		return ret;
+	}
+	IUCV_DBF_TEXT(trace, 3, __FUNCTION__);
 	ret = driver_register(&netiucv_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "NETIUCV: failed to register driver.\n");
+	if (ret) {
+		PRINT_ERR("NETIUCV: failed to register driver.\n");
+		IUCV_DBF_TEXT_(setup, 2, "ret %d from driver_register\n", ret);
+		iucv_unregister_dbf_views();
 		return ret;
 	}
 
 	/* Add entry for specifying connections. */
 	ret = driver_create_file(&netiucv_driver, &driver_attr_connection);
-	if (ret == 0) {
+	if (!ret) {
 		ret = driver_create_file(&netiucv_driver, &driver_attr_remove);
 		netiucv_banner();
 	} else {
-		printk(KERN_ERR "NETIUCV: failed to add driver attribute.\n");
+		PRINT_ERR("NETIUCV: failed to add driver attribute.\n");
+		IUCV_DBF_TEXT_(setup, 2, "ret %d from driver_create_file\n", ret);
 		driver_unregister(&netiucv_driver);
+		iucv_unregister_dbf_views();
 	}
 	return ret;
 }
diff -urN linux-2.6/drivers/s390/net/qeth_fs.h linux-2.6-s390/drivers/s390/net/qeth_fs.h
--- linux-2.6/drivers/s390/net/qeth_fs.h	Wed Jun 16 07:19:13 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_fs.h	Tue Jul 27 16:36:27 2004
@@ -12,7 +12,7 @@
 #ifndef __QETH_FS_H__
 #define __QETH_FS_H__
 
-#define VERSION_QETH_FS_H "$Revision: 1.8 $"
+#define VERSION_QETH_FS_H "$Revision: 1.9 $"
 
 extern const char *VERSION_QETH_PROC_C;
 extern const char *VERSION_QETH_SYS_C;
@@ -138,6 +138,8 @@
 				return "HSTR";
 			case QETH_LINK_TYPE_GBIT_ETH:
 				return "OSD_1000";
+			case QETH_LINK_TYPE_10GBIT_ETH:
+				return "OSD_10GIG";
 			case QETH_LINK_TYPE_LANE_ETH100:
 				return "OSD_FE_LANE";
 			case QETH_LINK_TYPE_LANE_TR:
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-s390/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	Tue Jul 27 16:35:49 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_main.c	Tue Jul 27 16:36:27 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.125 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.127 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.125 $	 $Date: 2004/06/29 17:28:24 $
+ *    $Revision: 1.127 $	 $Date: 2004/07/14 21:46:40 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,7 +78,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.125 $"
+#define VERSION_QETH_C "$Revision: 1.127 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -3853,7 +3853,8 @@
 	switch(regnum){
 	case MII_BMCR: /* Basic mode control register */
 		rc = BMCR_FULLDPLX;
-		if(card->info.link_type != QETH_LINK_TYPE_GBIT_ETH)
+		if ((card->info.link_type != QETH_LINK_TYPE_GBIT_ETH)&&
+		    (card->info.link_type != QETH_LINK_TYPE_10GBIT_ETH))
 			rc |= BMCR_SPEED100;
 		break;
 	case MII_BMSR: /* Basic mode status register */
diff -urN linux-2.6/drivers/s390/net/qeth_sys.c linux-2.6-s390/drivers/s390/net/qeth_sys.c
--- linux-2.6/drivers/s390/net/qeth_sys.c	Wed Jun 16 07:19:36 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_sys.c	Tue Jul 27 16:36:27 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.32 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.33 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.32 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.33 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -476,7 +476,7 @@
 	    (card->state != CARD_STATE_RECOVER))
 		return -EPERM;
 
-	i = simple_strtoul(buf, &tmp, 16);
+	i = simple_strtoul(buf, &tmp, 10);
 	if ((i < 0) || (i > MAX_ADD_HHLEN)) {
 		PRINT_WARN("add_hhlen out of range\n");
 		return -EINVAL;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	Tue Jul 27 16:35:49 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c	Tue Jul 27 16:36:27 2004
@@ -4788,6 +4788,7 @@
 
 	if (!atomic_test_mask(ZFCP_STATUS_ADAPTER_QDIOUP, &adapter->status)) {
 		write_unlock_irqrestore(&req_queue->queue_lock, *lock_flags);
+		ret = -EIO;
 		goto failed_sbals;
 	}
 
