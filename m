Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVCYScg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVCYScg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 13:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVCYScg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 13:32:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44554 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261732AbVCYScS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 13:32:18 -0500
Date: Fri, 25 Mar 2005 19:32:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kai.germaschewski@gmx.de, kkeil@suse.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/i4l/isdn_ppp.c: fix off by one errors
Message-ID: <20050325183215.GE3153@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes several off by one errors found by the Coverity checker
(ippp_table has ISDN_MAX_CHANNELS elements).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/i4l/isdn_ppp.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.12-rc1-mm1-full/drivers/isdn/i4l/isdn_ppp.c.old	2005-03-23 02:40:11.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/isdn/i4l/isdn_ppp.c	2005-03-23 02:46:02.000000000 +0100
@@ -981,13 +981,13 @@ void isdn_ppp_receive(isdn_net_dev * net
 	int proto;
 
 	if (net_dev->local->master)
 		BUG(); // we're called with the master device always
 
 	slot = lp->ppp_slot;
-	if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
+	if (slot < 0 || slot >= ISDN_MAX_CHANNELS) {
 		printk(KERN_ERR "isdn_ppp_receive: lp->ppp_slot(%d)\n",
 			lp->ppp_slot);
 		kfree_skb(skb);
 		return;
 	}
 	is = ippp_table[slot];
@@ -1036,13 +1036,13 @@ isdn_ppp_push_higher(isdn_net_dev * net_
 	struct net_device *dev = &net_dev->dev;
  	struct ippp_struct *is, *mis;
 	isdn_net_local *mlp = NULL;
 	int slot;
 
 	slot = lp->ppp_slot;
-	if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
+	if (slot < 0 || slot >= ISDN_MAX_CHANNELS) {
 		printk(KERN_ERR "isdn_ppp_push_higher: lp->ppp_slot(%d)\n",
 			lp->ppp_slot);
 		goto drop_packet;
 	}
 	is = ippp_table[slot];
  	
@@ -1231,13 +1231,13 @@ isdn_ppp_xmit(struct sk_buff *skb, struc
 	int slot, retval = 0;
 
 	mlp = (isdn_net_local *) (netdev->priv);
 	nd = mlp->netdev;       /* get master lp */
 
 	slot = mlp->ppp_slot;
-	if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
+	if (slot < 0 || slot >= ISDN_MAX_CHANNELS) {
 		printk(KERN_ERR "isdn_ppp_xmit: lp->ppp_slot(%d)\n",
 			mlp->ppp_slot);
 		kfree_skb(skb);
 		goto out;
 	}
 	ipts = ippp_table[slot];
@@ -1879,13 +1879,13 @@ void isdn_ppp_mp_reassembly( isdn_net_de
 {
 	ippp_bundle * mp = net_dev->pb;
 	int proto;
 	struct sk_buff * skb;
 	unsigned int tot_len;
 
-	if (lp->ppp_slot < 0 || lp->ppp_slot > ISDN_MAX_CHANNELS) {
+	if (lp->ppp_slot < 0 || lp->ppp_slot >= ISDN_MAX_CHANNELS) {
 		printk(KERN_ERR "%s: lp->ppp_slot(%d) out of range\n",
 			__FUNCTION__, lp->ppp_slot);
 		return;
 	}
 	if( MP_FLAGS(from) == (MP_BEGIN_FRAG | MP_END_FRAG) ) {
 		if( ippp_table[lp->ppp_slot]->debug & 0x40 )
@@ -2828,13 +2828,13 @@ static void isdn_ppp_send_ccp(isdn_net_d
 	struct ippp_struct *mis,*is;
 	int proto, slot = lp->ppp_slot;
 	unsigned char *data;
 
 	if(!skb || skb->len < 3)
 		return;
-	if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
+	if (slot < 0 || slot >= ISDN_MAX_CHANNELS) {
 		printk(KERN_ERR "%s: lp->ppp_slot(%d) out of range\n",
 			__FUNCTION__, slot);
 		return;
 	}	
 	is = ippp_table[slot];
 	/* Daemon may send with or without address and control field comp */

