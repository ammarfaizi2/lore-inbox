Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbVHKKyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVHKKyo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 06:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVHKKyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 06:54:43 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19627 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S964920AbVHKKym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 06:54:42 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [PATCH] deinline netif_carrier_on/off
Date: Thu, 11 Aug 2005 13:53:30 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_q4y+CYv7D+IAi21"
Message-Id: <200508111353.30359.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_q4y+CYv7D+IAi21
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

These functions are not called frequently, let's save some space.

# grep -r 'netif_carrier_o[nf]' linux-2.6.12 | wc -l
246

# size vmlinux.org vmlinux.carrier
text    data     bss     dec     hex filename
4339634 1054414  259296 5653344  564360 vmlinux.org
4337710 1054414  259296 5651420  563bdc vmlinux.carrier

And this ain't an allyesconfig kernel.

Attached to prevent mangling by MUA.
--
vda

--Boundary-00=_q4y+CYv7D+IAi21
Content-Type: text/x-diff;
  charset="koi8-r";
  name="carrier.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="carrier.patch"

# grep -r 'netif_carrier_o[nf]' linux-2.6.12 | wc -l
246

# size vmlinux.org vmlinux.carrier
text    data     bss     dec     hex filename
4339634 1054414  259296 5653344  564360 vmlinux.org
4337710 1054414  259296 5651420  563bdc vmlinux.carrier

And this ain't an allyesconfig kernel!

diff -urpN linux-2.6.12.org/include/linux/netdevice.h linux-2.6.12.carrier/include/linux/netdevice.h
--- linux-2.6.12.org/include/linux/netdevice.h	Sun Jun 19 16:10:56 2005
+++ linux-2.6.12.carrier/include/linux/netdevice.h	Wed Aug 10 21:13:28 2005
@@ -706,19 +706,9 @@ static inline int netif_carrier_ok(const
 
 extern void __netdev_watchdog_up(struct net_device *dev);
 
-static inline void netif_carrier_on(struct net_device *dev)
-{
-	if (test_and_clear_bit(__LINK_STATE_NOCARRIER, &dev->state))
-		linkwatch_fire_event(dev);
-	if (netif_running(dev))
-		__netdev_watchdog_up(dev);
-}
+extern void netif_carrier_on(struct net_device *dev);
 
-static inline void netif_carrier_off(struct net_device *dev)
-{
-	if (!test_and_set_bit(__LINK_STATE_NOCARRIER, &dev->state))
-		linkwatch_fire_event(dev);
-}
+extern void netif_carrier_off(struct net_device *dev);
 
 /* Hot-plugging. */
 static inline int netif_device_present(struct net_device *dev)
diff -urpN linux-2.6.12.org/net/sched/sch_generic.c linux-2.6.12.carrier/net/sched/sch_generic.c
--- linux-2.6.12.org/net/sched/sch_generic.c	Wed Aug 10 21:15:26 2005
+++ linux-2.6.12.carrier/net/sched/sch_generic.c	Wed Aug 10 22:23:33 2005
@@ -238,6 +238,20 @@ static void dev_watchdog_down(struct net
 	spin_unlock_bh(&dev->xmit_lock);
 }
 
+void netif_carrier_on(struct net_device *dev)
+{
+	if (test_and_clear_bit(__LINK_STATE_NOCARRIER, &dev->state))
+		linkwatch_fire_event(dev);
+	if (netif_running(dev))
+		__netdev_watchdog_up(dev);
+}
+
+void netif_carrier_off(struct net_device *dev)
+{
+	if (!test_and_set_bit(__LINK_STATE_NOCARRIER, &dev->state))
+		linkwatch_fire_event(dev);
+}
+
 /* "NOOP" scheduler: the best scheduler, recommended for all interfaces
    under all circumstances. It is difficult to invent anything faster or
    cheaper.
@@ -604,6 +618,8 @@ void dev_shutdown(struct net_device *dev
 }
 
 EXPORT_SYMBOL(__netdev_watchdog_up);
+EXPORT_SYMBOL(netif_carrier_on);
+EXPORT_SYMBOL(netif_carrier_off);
 EXPORT_SYMBOL(noop_qdisc);
 EXPORT_SYMBOL(noop_qdisc_ops);
 EXPORT_SYMBOL(qdisc_create_dflt);

--Boundary-00=_q4y+CYv7D+IAi21--

