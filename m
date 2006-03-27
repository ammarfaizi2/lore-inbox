Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWC0LTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWC0LTh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 06:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWC0LTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 06:19:37 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:17578 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750885AbWC0LTg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 06:19:36 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] deinline some larger functions from netdevice.h
Date: Mon, 27 Mar 2006 14:19:06 +0300
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qo8JE270ABC0Yyj"
Message-Id: <200603271419.06468.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_qo8JE270ABC0Yyj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On a allyesconfig'ured kernel:

Size  Uses Wasted Name and definition
===== ==== ====== ================================================
   95  162  12075 netif_wake_queue      include/linux/netdevice.h
  129   86   9265 dev_kfree_skb_any     include/linux/netdevice.h
  127   56   5885 netif_device_attach   include/linux/netdevice.h
   73   86   4505 dev_kfree_skb_irq     include/linux/netdevice.h
   46   60   1534 netif_device_detach   include/linux/netdevice.h
  119   16   1485 __netif_rx_schedule   include/linux/netdevice.h
  143    5    492 netif_rx_schedule     include/linux/netdevice.h
   81    7    366 netif_schedule        include/linux/netdevice.h

netif_wake_queue is big because __netif_schedule is a big inline:

static inline void __netif_schedule(struct net_device *dev)
{
        if (!test_and_set_bit(__LINK_STATE_SCHED, &dev->state)) {
                unsigned long flags;
                struct softnet_data *sd;

                local_irq_save(flags);
                sd = &__get_cpu_var(softnet_data);
                dev->next_sched = sd->output_queue;
                sd->output_queue = dev;
                raise_softirq_irqoff(NET_TX_SOFTIRQ);
                local_irq_restore(flags);
        }
}

static inline void netif_wake_queue(struct net_device *dev)
{
#ifdef CONFIG_NETPOLL_TRAP
        if (netpoll_trap())
                return;
#endif
        if (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state))
                __netif_schedule(dev);
}

By de-inlining __netif_schedule we are saving a lot of text
at each callsite of netif_wake_queue and netif_schedule.
__netif_rx_schedule is also big, and it makes more sense to keep
both of them out of line.

Patch also deinlines dev_kfree_skb_any. We can deinline dev_kfree_skb_irq
instead... oh well.

netif_device_attach/detach are not hot paths, we can deinline them too.

Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
--
vda

--Boundary-00=_qo8JE270ABC0Yyj
Content-Type: text/x-diff;
  charset="us-ascii";
  name="netdevice.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="netdevice.patch"

diff -urpN linux-2.6.16.org/include/linux/netdevice.h linux-2.6.16.deinline2/include/linux/netdevice.h
--- linux-2.6.16.org/include/linux/netdevice.h	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.deinline2/include/linux/netdevice.h	Mon Mar 27 13:46:15 2006
@@ -594,20 +594,7 @@ DECLARE_PER_CPU(struct softnet_data,soft
 
 #define HAVE_NETIF_QUEUE
 
-static inline void __netif_schedule(struct net_device *dev)
-{
-	if (!test_and_set_bit(__LINK_STATE_SCHED, &dev->state)) {
-		unsigned long flags;
-		struct softnet_data *sd;
-
-		local_irq_save(flags);
-		sd = &__get_cpu_var(softnet_data);
-		dev->next_sched = sd->output_queue;
-		sd->output_queue = dev;
-		raise_softirq_irqoff(NET_TX_SOFTIRQ);
-		local_irq_restore(flags);
-	}
-}
+extern void __netif_schedule(struct net_device *dev);
 
 static inline void netif_schedule(struct net_device *dev)
 {
@@ -671,13 +658,7 @@ static inline void dev_kfree_skb_irq(str
 /* Use this variant in places where it could be invoked
  * either from interrupt or non-interrupt context.
  */
-static inline void dev_kfree_skb_any(struct sk_buff *skb)
-{
-	if (in_irq() || irqs_disabled())
-		dev_kfree_skb_irq(skb);
-	else
-		dev_kfree_skb(skb);
-}
+extern void dev_kfree_skb_any(struct sk_buff *skb);
 
 #define HAVE_NETIF_RX 1
 extern int		netif_rx(struct sk_buff *skb);
@@ -735,22 +716,9 @@ static inline int netif_device_present(s
 	return test_bit(__LINK_STATE_PRESENT, &dev->state);
 }
 
-static inline void netif_device_detach(struct net_device *dev)
-{
-	if (test_and_clear_bit(__LINK_STATE_PRESENT, &dev->state) &&
-	    netif_running(dev)) {
-		netif_stop_queue(dev);
-	}
-}
+extern void netif_device_detach(struct net_device *dev);
 
-static inline void netif_device_attach(struct net_device *dev)
-{
-	if (!test_and_set_bit(__LINK_STATE_PRESENT, &dev->state) &&
-	    netif_running(dev)) {
-		netif_wake_queue(dev);
- 		__netdev_watchdog_up(dev);
-	}
-}
+extern void netif_device_attach(struct net_device *dev);
 
 /*
  * Network interface message level settings
@@ -818,20 +786,7 @@ static inline int netif_rx_schedule_prep
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
+extern void __netif_rx_schedule(struct net_device *dev);
 
 /* Try to reschedule poll. Called by irq handler. */
 
diff -urpN linux-2.6.16.org/net/core/dev.c linux-2.6.16.deinline2/net/core/dev.c
--- linux-2.6.16.org/net/core/dev.c	Mon Mar 20 07:53:29 2006
+++ linux-2.6.16.deinline2/net/core/dev.c	Mon Mar 27 13:47:00 2006
@@ -1073,6 +1073,70 @@ void dev_queue_xmit_nit(struct sk_buff *
 	rcu_read_unlock();
 }
 
+
+void __netif_schedule(struct net_device *dev)
+{
+	if (!test_and_set_bit(__LINK_STATE_SCHED, &dev->state)) {
+		unsigned long flags;
+		struct softnet_data *sd;
+
+		local_irq_save(flags);
+		sd = &__get_cpu_var(softnet_data);
+		dev->next_sched = sd->output_queue;
+		sd->output_queue = dev;
+		raise_softirq_irqoff(NET_TX_SOFTIRQ);
+		local_irq_restore(flags);
+	}
+}
+EXPORT_SYMBOL(__netif_schedule);
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
+EXPORT_SYMBOL(__netif_rx_schedule);
+
+void dev_kfree_skb_any(struct sk_buff *skb)
+{
+	if (in_irq() || irqs_disabled())
+		dev_kfree_skb_irq(skb);
+	else
+		dev_kfree_skb(skb);
+}
+EXPORT_SYMBOL(dev_kfree_skb_any);
+
+
+/* Hot-plugging. */
+void netif_device_detach(struct net_device *dev)
+{
+	if (test_and_clear_bit(__LINK_STATE_PRESENT, &dev->state) &&
+	    netif_running(dev)) {
+		netif_stop_queue(dev);
+	}
+}
+EXPORT_SYMBOL(netif_device_detach);
+
+void netif_device_attach(struct net_device *dev)
+{
+	if (!test_and_set_bit(__LINK_STATE_PRESENT, &dev->state) &&
+	    netif_running(dev)) {
+		netif_wake_queue(dev);
+ 		__netdev_watchdog_up(dev);
+	}
+}
+EXPORT_SYMBOL(netif_device_attach);
+
+
 /*
  * Invalidate hardware checksum when packet is to be mangled, and
  * complete checksum manually on outgoing path.

--Boundary-00=_qo8JE270ABC0Yyj--
