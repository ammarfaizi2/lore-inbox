Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264642AbUDVTbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264642AbUDVTbB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264624AbUDVTbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:31:01 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:13061 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264642AbUDVTaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:30:21 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "David S. Miller" <davem@redhat.com>
Subject: [PATCH 2.6] Take care of large inlines in include/linux/netdevice.h
Date: Thu, 22 Apr 2004 22:30:04 +0300
User-Agent: KMail/1.5.4
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_80BiA88DF6mZt9z"
Message-Id: <200404222230.04406.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_80BiA88DF6mZt9z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Size =A0Uses Wasted Name and definition
=3D=3D=3D=3D=3D =3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   97  141  10780 netif_wake_queue      include/linux/netdevice.h
  127   59   6206 dev_kfree_skb_any     include/linux/netdevice.h
   73   83   4346 dev_kfree_skb_irq     include/linux/netdevice.h
  131   39   4218 netif_device_attach   include/linux/netdevice.h
   46   41   1040 netif_device_detach   include/linux/netdevice.h
   44   31    720 netif_carrier_on      include/linux/netdevice.h
   83    7    378 netif_schedule        include/linux/netdevice.h
  112    7    552 __netif_rx_schedule   include/linux/netdevice.h
  136    4    348 netif_rx_schedule     include/linux/netdevice.h
   67    3     94 __netif_rx_complete   include/linux/netdevice.h
   72    7    312 netif_rx_complete     include/linux/netdevice.h

Patch deinlines netif_wake_queue, dev_kfree_skb_irq
and __netif_rx_schedule. This in turn reduces size of
netif_device_attach, dev_kfree_skb_any and netif_rx_schedule,
which left inlined.

Compile tested. With my usual .config:

# size vmlinux.pre2 vmlinux
   text    data     bss     dec     hex filename
4449399 1113642  235488 5798529  587a81 vmlinux.pre2
4438267 1113704  235488 5787459  584f43 vmlinux

Please apply.
=2D-
vda

--Boundary-00=_80BiA88DF6mZt9z
Content-Type: text/x-diff;
  charset="us-ascii";
  name="netdevice.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="netdevice.patch"

diff -urN linux-2.6.5.orig/include/linux/netdevice.h linux-2.6.5.netdevice/include/linux/netdevice.h
--- linux-2.6.5.orig/include/linux/netdevice.h	Sun Apr  4 06:38:18 2004
+++ linux-2.6.5.netdevice/include/linux/netdevice.h	Thu Apr 22 22:17:25 2004
@@ -605,15 +605,7 @@
 	clear_bit(__LINK_STATE_XOFF, &dev->state);
 }
 
-static inline void netif_wake_queue(struct net_device *dev)
-{
-#ifdef CONFIG_NETPOLL_TRAP
-	if (netpoll_trap())
-		return;
-#endif
-	if (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state))
-		__netif_schedule(dev);
-}
+void netif_wake_queue(struct net_device *dev);
 
 static inline void netif_stop_queue(struct net_device *dev)
 {
@@ -638,20 +630,7 @@
 /* Use this variant when it is known for sure that it
  * is executing from interrupt context.
  */
-static inline void dev_kfree_skb_irq(struct sk_buff *skb)
-{
-	if (atomic_dec_and_test(&skb->users)) {
-		struct softnet_data *sd;
-		unsigned long flags;
-
-		local_irq_save(flags);
-		sd = &__get_cpu_var(softnet_data);
-		skb->next = sd->completion_queue;
-		sd->completion_queue = skb;
-		raise_softirq_irqoff(NET_TX_SOFTIRQ);
-		local_irq_restore(flags);
-	}
-}
+void dev_kfree_skb_irq(struct sk_buff *skb);
 
 /* Use this variant in places where it could be invoked
  * either from interrupt or non-interrupt context.
@@ -814,20 +793,7 @@
  * already been called and returned 1.
  */
 
-static inline void __netif_rx_schedule(struct net_device *dev)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	dev_hold(dev);
-	list_add_tail(&dev->poll_list, &__get_cpu_var(softnet_data).poll_list);
-	if (dev->quota < 0)
-		dev->quota += dev->weight;
-	else
-		dev->quota = dev->weight;
-	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
-	local_irq_restore(flags);
-}
+void __netif_rx_schedule(struct net_device *dev);
 
 /* Try to reschedule poll. Called by irq handler. */
 
diff -urN linux-2.6.5.orig/net/core/dev.c linux-2.6.5.netdevice/net/core/dev.c
--- linux-2.6.5.orig/net/core/dev.c	Sun Apr  4 06:37:07 2004
+++ linux-2.6.5.netdevice/net/core/dev.c	Thu Apr 22 22:17:22 2004
@@ -3176,6 +3176,46 @@
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+void netif_wake_queue(struct net_device *dev)
+{
+#ifdef CONFIG_NETPOLL_TRAP
+	if (netpoll_trap())
+		return;
+#endif
+	if (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state))
+		__netif_schedule(dev);
+}
+
+void dev_kfree_skb_irq(struct sk_buff *skb)
+{
+	if (atomic_dec_and_test(&skb->users)) {
+		struct softnet_data *sd;
+		unsigned long flags;
+
+		local_irq_save(flags);
+		sd = &__get_cpu_var(softnet_data);
+		skb->next = sd->completion_queue;
+		sd->completion_queue = skb;
+		raise_softirq_irqoff(NET_TX_SOFTIRQ);
+		local_irq_restore(flags);
+	}
+}
+
+void __netif_rx_schedule(struct net_device *dev)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	dev_hold(dev);
+	list_add_tail(&dev->poll_list, &__get_cpu_var(softnet_data).poll_list);
+	if (dev->quota < 0)
+		dev->quota += dev->weight;
+	else
+		dev->quota = dev->weight;
+	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+	local_irq_restore(flags);
+}
+
 
 /*
  *	Initialize the DEV module. At boot time this walks the device list and
@@ -3285,6 +3325,9 @@
 EXPORT_SYMBOL(synchronize_net);
 EXPORT_SYMBOL(unregister_netdevice);
 EXPORT_SYMBOL(unregister_netdevice_notifier);
+EXPORT_SYMBOL(netif_wake_queue);
+EXPORT_SYMBOL(dev_kfree_skb_irq);
+EXPORT_SYMBOL(__netif_rx_schedule);
 
 #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
 EXPORT_SYMBOL(br_handle_frame_hook);

--Boundary-00=_80BiA88DF6mZt9z--

