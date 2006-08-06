Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWHFPrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWHFPrT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 11:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWHFPrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 11:47:19 -0400
Received: from host17-96.pool873.interbusiness.it ([87.3.96.17]:13992 "EHLO
	memento.home.lan") by vger.kernel.org with ESMTP id S1750787AbWHFPq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 11:46:56 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 3/3] uml: clean our set_ether_mac
Date: Sun, 06 Aug 2006 17:47:05 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20060806154705.536.49855.stgit@memento.home.lan>
In-Reply-To: <20060806154700.536.32978.stgit@memento.home.lan>
References: <20060806154700.536.32978.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Clean set_ether_mac usage. Maybe could also be removed, but surely it can't be a
global function taking a void* argument.

You may want to defer this patch to next kernel release.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/drivers/net_kern.c |   14 ++++++--------
 arch/um/include/net_user.h |    1 -
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index f5fba74..e26601a 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -31,6 +31,11 @@ #include "init.h"
 #include "irq_user.h"
 #include "irq_kern.h"
 
+static inline void set_ether_mac(struct net_device *dev, unsigned char *addr)
+{
+	memcpy(dev->dev_addr, addr, ETH_ALEN);
+}
+
 #define DRIVER_NAME "uml-netdev"
 
 static DEFINE_SPINLOCK(opened_lock);
@@ -234,7 +239,7 @@ static int uml_net_set_mac(struct net_de
 	struct sockaddr *hwaddr = addr;
 
 	spin_lock_irq(&lp->lock);
-	memcpy(dev->dev_addr, hwaddr->sa_data, ETH_ALEN);
+	set_ether_mac(dev, hwaddr->sa_data);
 	spin_unlock_irq(&lp->lock);
 
 	return(0);
@@ -788,13 +793,6 @@ void dev_ip_addr(void *d, unsigned char 
 	memcpy(bin_buf, &in->ifa_address, sizeof(in->ifa_address));
 }
 
-void set_ether_mac(void *d, unsigned char *addr)
-{
-	struct net_device *dev = d;
-
-	memcpy(dev->dev_addr, addr, ETH_ALEN);	
-}
-
 struct sk_buff *ether_adjust_skb(struct sk_buff *skb, int extra)
 {
 	if((skb != NULL) && (skb_tailroom(skb) < extra)){
diff --git a/arch/um/include/net_user.h b/arch/um/include/net_user.h
index 800c403..47ef7cb 100644
--- a/arch/um/include/net_user.h
+++ b/arch/um/include/net_user.h
@@ -26,7 +26,6 @@ struct net_user_info {
 
 extern void ether_user_init(void *data, void *dev);
 extern void dev_ip_addr(void *d, unsigned char *bin_buf);
-extern void set_ether_mac(void *d, unsigned char *addr);
 extern void iter_addresses(void *d, void (*cb)(unsigned char *, 
 					       unsigned char *, void *), 
 			   void *arg);
