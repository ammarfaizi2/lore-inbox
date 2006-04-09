Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWDIUrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWDIUrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 16:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWDIUrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 16:47:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:8852 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750734AbWDIUrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 16:47:09 -0400
X-Authenticated: #704063
Subject: [Patch] Static overruns in drivers/isdn/i4l/isdn_ppp.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: paulus@samba.org
Content-Type: text/plain
Date: Sun, 09 Apr 2006 22:47:03 +0200
Message-Id: <1144615624.23502.4.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

coverity found some static overruns in isdn_ppp.c (bug id #519)
At several places slot is compared <0 and > ISDN_MAX_CHANNELS
and then used to index ippp_table[ISDN_MAX_CHANNELS]
A value of slot = ISDN_MAX_CHANNELS would run over the end
of the array.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc1/drivers/isdn/i4l/isdn_ppp.c.orig	2006-04-09 22:37:42.000000000 +0200
+++ linux-2.6.17-rc1/drivers/isdn/i4l/isdn_ppp.c	2006-04-09 22:42:34.000000000 +0200
@@ -109,7 +109,7 @@ isdn_ppp_free(isdn_net_local * lp)
 {
 	struct ippp_struct *is;
 
-	if (lp->ppp_slot < 0 || lp->ppp_slot > ISDN_MAX_CHANNELS) {
+	if (lp->ppp_slot < 0 || lp->ppp_slot >= ISDN_MAX_CHANNELS) {
 		printk(KERN_ERR "%s: ppp_slot(%d) out of range\n",
 			__FUNCTION__, lp->ppp_slot);
 		return 0;
@@ -126,7 +126,7 @@ isdn_ppp_free(isdn_net_local * lp)
 	lp->netdev->pb->ref_ct--;
 	spin_unlock(&lp->netdev->pb->lock);
 #endif /* CONFIG_ISDN_MPP */
-	if (lp->ppp_slot < 0 || lp->ppp_slot > ISDN_MAX_CHANNELS) {
+	if (lp->ppp_slot < 0 || lp->ppp_slot >= ISDN_MAX_CHANNELS) {
 		printk(KERN_ERR "%s: ppp_slot(%d) now invalid\n",
 			__FUNCTION__, lp->ppp_slot);
 		return 0;
@@ -279,7 +279,7 @@ isdn_ppp_open(int min, struct file *file
 	int slot;
 	struct ippp_struct *is;
 
-	if (min < 0 || min > ISDN_MAX_CHANNELS)
+	if (min < 0 || min >= ISDN_MAX_CHANNELS)
 		return -ENODEV;
 
 	slot = isdn_ppp_get_slot();
@@ -1042,7 +1042,7 @@ isdn_ppp_push_higher(isdn_net_dev * net_
  	if (lp->master) { // FIXME?
 		mlp = (isdn_net_local *) lp->master->priv;
  		slot = mlp->ppp_slot;
- 		if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
+ 		if (slot < 0 || slot >= ISDN_MAX_CHANNELS) {
  			printk(KERN_ERR "isdn_ppp_push_higher: master->ppp_slot(%d)\n",
  				lp->ppp_slot);
 			goto drop_packet;
@@ -1264,7 +1264,7 @@ isdn_ppp_xmit(struct sk_buff *skb, struc
 	/* we have our lp locked from now on */
 
 	slot = lp->ppp_slot;
-	if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
+	if (slot < 0 || slot >= ISDN_MAX_CHANNELS) {
 		printk(KERN_ERR "isdn_ppp_xmit: lp->ppp_slot(%d)\n",
 			lp->ppp_slot);
 		kfree_skb(skb);
@@ -1603,7 +1603,7 @@ static void isdn_ppp_mp_receive(isdn_net
     	mp = net_dev->pb;
         stats = &mp->stats;
 	slot = lp->ppp_slot;
-	if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
+	if (slot < 0 || slot >= ISDN_MAX_CHANNELS) {
 		printk(KERN_ERR "%s: lp->ppp_slot(%d)\n",
 			__FUNCTION__, lp->ppp_slot);
 		stats->frame_drops++;
@@ -1640,7 +1640,7 @@ static void isdn_ppp_mp_receive(isdn_net
 	is->last_link_seqno = minseq = newseq;
 	for (lpq = net_dev->queue;;) {
 		slot = lpq->ppp_slot;
-		if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
+		if (slot < 0 || slot >= ISDN_MAX_CHANNELS) {
 			printk(KERN_ERR "%s: lpq->ppp_slot(%d)\n",
 				__FUNCTION__, lpq->ppp_slot);
 		} else {
@@ -2648,7 +2648,7 @@ static void isdn_ppp_receive_ccp(isdn_ne
 
 	printk(KERN_DEBUG "Received CCP frame from peer slot(%d)\n",
 		lp->ppp_slot);
-	if (lp->ppp_slot < 0 || lp->ppp_slot > ISDN_MAX_CHANNELS) {
+	if (lp->ppp_slot < 0 || lp->ppp_slot >= ISDN_MAX_CHANNELS) {
 		printk(KERN_ERR "%s: lp->ppp_slot(%d) out of range\n",
 			__FUNCTION__, lp->ppp_slot);
 		return;
@@ -2658,7 +2658,7 @@ static void isdn_ppp_receive_ccp(isdn_ne
 
 	if(lp->master) {
 		int slot = ((isdn_net_local *) (lp->master->priv))->ppp_slot;
-		if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
+		if (slot < 0 || slot >= ISDN_MAX_CHANNELS) {
 			printk(KERN_ERR "%s: slot(%d) out of range\n",
 				__FUNCTION__, slot);
 			return;
@@ -2845,7 +2845,7 @@ static void isdn_ppp_send_ccp(isdn_net_d
 
 	if (lp->master) {
 		slot = ((isdn_net_local *) (lp->master->priv))->ppp_slot;
-		if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
+		if (slot < 0 || slot >= ISDN_MAX_CHANNELS) {
 			printk(KERN_ERR "%s: slot(%d) out of range\n",
 				__FUNCTION__, slot);
 			return;


