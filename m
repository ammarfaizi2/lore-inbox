Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289003AbSAIUG0>; Wed, 9 Jan 2002 15:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289001AbSAIUDe>; Wed, 9 Jan 2002 15:03:34 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:15603 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S288990AbSAIUCG>;
	Wed, 9 Jan 2002 15:02:06 -0500
Date: Wed, 9 Jan 2002 12:02:02 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [PATCH] : ir247_irlan_dynalloc-2.diff
Message-ID: <20020109120202.B12039@bougret.hpl.hp.com>
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

ir247_irlan_dynalloc-2.diff :
---------------------------
	o [CRITICA] Don't pass the same skb to two different state machines
        <Following patch from Martin Diehl, modified by me>
	o [CRITICA] Don't flag netdev as NETIF_F_DYNALLOC, because not kmalloc

diff -u -p -r linux/net/irda/irlan-d8/irlan_common.c linux/net/irda/irlan/irlan_common.c
--- linux/net/irda/irlan-d8/irlan_common.c	Sun Sep 30 12:26:09 2001
+++ linux/net/irda/irlan/irlan_common.c	Wed Jan  9 11:08:41 2002
@@ -317,8 +317,15 @@ void irlan_connect_indication(void *inst
 
 	del_timer(&self->watchdog_timer);
 
-	irlan_do_provider_event(self, IRLAN_DATA_CONNECT_INDICATION, skb);
-	irlan_do_client_event(self, IRLAN_DATA_CONNECT_INDICATION, skb);
+	/* If you want to pass the skb to *both* state machines, you will
+	 * need to skb_clone() it, so that you don't free it twice.
+	 * As the state machines don't need it, git rid of it here...
+	 * Jean II */
+	if (skb)
+		dev_kfree_skb(skb);
+
+	irlan_do_provider_event(self, IRLAN_DATA_CONNECT_INDICATION, NULL);
+	irlan_do_client_event(self, IRLAN_DATA_CONNECT_INDICATION, NULL);
 
 	if (self->provider.access_type == ACCESS_PEER) {
 		/* 
@@ -421,6 +428,13 @@ void irlan_disconnect_indication(void *i
 		break;
 	}
 	
+	/* If you want to pass the skb to *both* state machines, you will
+	 * need to skb_clone() it, so that you don't free it twice.
+	 * As the state machines don't need it, git rid of it here...
+	 * Jean II */
+	if (userdata)
+		dev_kfree_skb(userdata);
+
 	irlan_do_client_event(self, IRLAN_LMP_DISCONNECT, NULL);
 	irlan_do_provider_event(self, IRLAN_LMP_DISCONNECT, NULL);
 	
diff -u -p -r linux/net/irda/irlan-d8/irlan_eth.c linux/net/irda/irlan/irlan_eth.c
--- linux/net/irda/irlan-d8/irlan_eth.c	Wed Jan  9 11:00:53 2002
+++ linux/net/irda/irlan/irlan_eth.c	Tue Jan  8 18:33:45 2002
@@ -61,7 +61,16 @@ int irlan_eth_init(struct net_device *de
 	dev->hard_start_xmit    = irlan_eth_xmit; 
 	dev->get_stats	        = irlan_eth_get_stats;
 	dev->set_multicast_list = irlan_eth_set_multicast_list;
-	dev->features          |= NETIF_F_DYNALLOC;
+
+	/* NETIF_F_DYNALLOC feature was set by irlan_eth_init() and would
+	 * cause the unregister_netdev() to do asynch completion _and_
+	 * kfree self->dev afterwards. Which is really bad because the
+	 * netdevice was not allocated separately but is embedded in
+	 * our control block and therefore gets freed with *self.
+	 * The only reason why this would have been enabled is to hide
+	 * some netdev refcount issues. If unregister_netdev() blocks
+	 * forever, tell us about it... */
+	//dev->features          |= NETIF_F_DYNALLOC;
 
 	ether_setup(dev);
 	
