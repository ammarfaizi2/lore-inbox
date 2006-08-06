Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWHFPqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWHFPqz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 11:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWHFPqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 11:46:55 -0400
Received: from host17-96.pool873.interbusiness.it ([87.3.96.17]:12456 "EHLO
	memento.home.lan") by vger.kernel.org with ESMTP id S1750780AbWHFPqy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 11:46:54 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/3] uml: fix proc-vs-interrupt context spinlock deadlock
Date: Sun, 06 Aug 2006 17:47:03 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20060806154703.536.80128.stgit@memento.home.lan>
In-Reply-To: <20060806154700.536.32978.stgit@memento.home.lan>
References: <20060806154700.536.32978.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This spinlock can be taken on interrupt too, so spin_lock_irq[save] must be used.

However, Documentation/networking/netdevices.txt explains we are called with
rtnl_lock() held - so we don't need to care about other concurrent opens.
Verified also in LDD3 and by direct checking. Also verified that the network
layer (through a state machine) guarantees us that nobody will close the
interface while it's being used. Please correct me if I'm wrong.

Also, we must check we don't sleep with irqs disabled!!! But anyway, this is not
news - we already can't sleep while holding a spinlock. Who says this is
guaranted really by the present code?

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/net_kern.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 6af229c..f5fba74 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -109,8 +109,6 @@ static int uml_net_open(struct net_devic
 	struct uml_net_private *lp = dev->priv;
 	int err;
 
-	spin_lock(&lp->lock);
-
 	if(lp->fd >= 0){
 		err = -ENXIO;
 		goto out;
@@ -144,8 +142,6 @@ static int uml_net_open(struct net_devic
 	 */
 	while((err = uml_net_rx(dev)) > 0) ;
 
-	spin_unlock(&lp->lock);
-
 	spin_lock(&opened_lock);
 	list_add(&lp->list, &opened);
 	spin_unlock(&opened_lock);
@@ -155,7 +151,6 @@ out_close:
 	if(lp->close != NULL) (*lp->close)(lp->fd, &lp->user);
 	lp->fd = -1;
 out:
-	spin_unlock(&lp->lock);
 	return err;
 }
 
@@ -164,15 +159,12 @@ static int uml_net_close(struct net_devi
 	struct uml_net_private *lp = dev->priv;
 	
 	netif_stop_queue(dev);
-	spin_lock(&lp->lock);
 
 	free_irq(dev->irq, dev);
 	if(lp->close != NULL)
 		(*lp->close)(lp->fd, &lp->user);
 	lp->fd = -1;
 
-	spin_unlock(&lp->lock);
-
 	spin_lock(&opened_lock);
 	list_del(&lp->list);
 	spin_unlock(&opened_lock);
@@ -241,9 +233,9 @@ static int uml_net_set_mac(struct net_de
 	struct uml_net_private *lp = dev->priv;
 	struct sockaddr *hwaddr = addr;
 
-	spin_lock(&lp->lock);
+	spin_lock_irq(&lp->lock);
 	memcpy(dev->dev_addr, hwaddr->sa_data, ETH_ALEN);
-	spin_unlock(&lp->lock);
+	spin_unlock_irq(&lp->lock);
 
 	return(0);
 }
@@ -253,7 +245,7 @@ static int uml_net_change_mtu(struct net
 	struct uml_net_private *lp = dev->priv;
 	int err = 0;
 
-	spin_lock(&lp->lock);
+	spin_lock_irq(&lp->lock);
 
 	new_mtu = (*lp->set_mtu)(new_mtu, &lp->user);
 	if(new_mtu < 0){
@@ -264,7 +256,7 @@ static int uml_net_change_mtu(struct net
 	dev->mtu = new_mtu;
 
  out:
-	spin_unlock(&lp->lock);
+	spin_unlock_irq(&lp->lock);
 	return err;
 }
 
