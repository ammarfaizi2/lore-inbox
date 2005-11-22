Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbVKVVOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVKVVOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVKVVN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:13:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63391 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965201AbVKVVKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:10:31 -0500
Date: Tue, 22 Nov 2005 13:06:30 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Krzysztof Halasa <khc@pm.waw.pl>
Subject: [patch 06/23] [PATCH] Generic HDLC WAN drivers - disable netif_carrier_off()
Message-ID: <20051122210630.GG28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="generic-hdlc-wan-drivers-disable-netif_carrier_off.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

As we are currently unable to fix the problem with carrier and protocol
state signaling in net core I've to disable netif_carrier_off() calls
used by WAN protocol drivers. The attached patch should make them
working again.

The remaining netif_carrier_*() calls in hdlc_fr.c are fine as they
don't touch the physical device.

Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/net/wan/hdlc_cisco.c   |    6 ++++++
 drivers/net/wan/hdlc_fr.c      |    4 ++++
 drivers/net/wan/hdlc_generic.c |    6 ++++++
 3 files changed, 16 insertions(+)

--- linux-2.6.14.2.orig/drivers/net/wan/hdlc_cisco.c
+++ linux-2.6.14.2/drivers/net/wan/hdlc_cisco.c
@@ -192,7 +192,9 @@ static int cisco_rx(struct sk_buff *skb)
 					       "uptime %ud%uh%um%us)\n",
 					       dev->name, days, hrs,
 					       min, sec);
+#if 0
 					netif_carrier_on(dev);
+#endif
 					hdlc->state.cisco.up = 1;
 				}
 			}
@@ -225,7 +227,9 @@ static void cisco_timer(unsigned long ar
 		       hdlc->state.cisco.settings.timeout * HZ)) {
 		hdlc->state.cisco.up = 0;
 		printk(KERN_INFO "%s: Link down\n", dev->name);
+#if 0
 		netif_carrier_off(dev);
+#endif
 	}
 
 	cisco_keepalive_send(dev, CISCO_KEEPALIVE_REQ,
@@ -261,8 +265,10 @@ static void cisco_stop(struct net_device
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	del_timer_sync(&hdlc->state.cisco.timer);
+#if 0
 	if (netif_carrier_ok(dev))
 		netif_carrier_off(dev);
+#endif
 	hdlc->state.cisco.up = 0;
 	hdlc->state.cisco.request_sent = 0;
 }
--- linux-2.6.14.2.orig/drivers/net/wan/hdlc_fr.c
+++ linux-2.6.14.2/drivers/net/wan/hdlc_fr.c
@@ -545,8 +545,10 @@ static void fr_set_link_state(int reliab
 
 	hdlc->state.fr.reliable = reliable;
 	if (reliable) {
+#if 0
 		if (!netif_carrier_ok(dev))
 			netif_carrier_on(dev);
+#endif
 
 		hdlc->state.fr.n391cnt = 0; /* Request full status */
 		hdlc->state.fr.dce_changed = 1;
@@ -560,8 +562,10 @@ static void fr_set_link_state(int reliab
 			}
 		}
 	} else {
+#if 0
 		if (netif_carrier_ok(dev))
 			netif_carrier_off(dev);
+#endif
 
 		while (pvc) {		/* Deactivate all PVCs */
 			pvc_carrier(0, pvc);
--- linux-2.6.14.2.orig/drivers/net/wan/hdlc_generic.c
+++ linux-2.6.14.2/drivers/net/wan/hdlc_generic.c
@@ -79,11 +79,13 @@ static void __hdlc_set_carrier_on(struct
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	if (hdlc->proto.start)
 		return hdlc->proto.start(dev);
+#if 0
 #ifdef DEBUG_LINK
 	if (netif_carrier_ok(dev))
 		printk(KERN_ERR "hdlc_set_carrier_on(): already on\n");
 #endif
 	netif_carrier_on(dev);
+#endif
 }
 
 
@@ -94,11 +96,13 @@ static void __hdlc_set_carrier_off(struc
 	if (hdlc->proto.stop)
 		return hdlc->proto.stop(dev);
 
+#if 0
 #ifdef DEBUG_LINK
 	if (!netif_carrier_ok(dev))
 		printk(KERN_ERR "hdlc_set_carrier_off(): already off\n");
 #endif
 	netif_carrier_off(dev);
+#endif
 }
 
 
@@ -294,8 +298,10 @@ int register_hdlc_device(struct net_devi
 	if (result != 0)
 		return -EIO;
 
+#if 0
 	if (netif_carrier_ok(dev))
 		netif_carrier_off(dev); /* no carrier until DCD goes up */
+#endif
 
 	return 0;
 }

--
