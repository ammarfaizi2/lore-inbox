Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270592AbUJUAYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270592AbUJUAYx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270439AbUJUAWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:22:30 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:13729
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S270592AbUJUAVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:21:03 -0400
Date: Wed, 20 Oct 2004 17:15:08 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: rlrevell@joe-job.com, herbert@gondor.apana.org.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-kernel@gondor.apana.org.au,
       maxk@qualcomm.com, irda-users@lists.sourceforge.net, netdev@oss.sgi.com,
       alain@parkautomat.net
Subject: Re: [PATCH] Make netif_rx_ni preempt-safe
Message-Id: <20041020171508.0e947d08.davem@davemloft.net>
In-Reply-To: <200410202332.33583.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1098230132.23628.28.camel@krustophenia.net>
	<200410202256.56636.vda@port.imtp.ilyichevsk.odessa.ua>
	<1098303951.2268.8.camel@krustophenia.net>
	<200410202332.33583.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004 23:32:33 +0300
Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:

> On Wednesday 20 October 2004 23:25, Lee Revell wrote:
> > > > --- include/linux/netdevice.h~	2004-10-20 15:51:00.000000000 -0400
> > > > +++ include/linux/netdevice.h	2004-10-20 15:51:54.000000000 -0400
> > > > @@ -694,11 +694,14 @@
> > > >  /* Post buffer to the network code from _non interrupt_ context.
> > > >   * see net/core/dev.c for netif_rx description.
> > > >   */
> > > > -static inline int netif_rx_ni(struct sk_buff *skb)
> > > > +static int netif_rx_ni(struct sk_buff *skb)
> > > 
> > > non-inline functions must not live in .h files
> > 
> > Where do you suggest we put it?
> 
> Somewhere near this place:
> 
> http://lxr.linux.no/source/net/core/dev.c?v=2.6.8.1#L1555

I've done this as follows, thanks.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/20 16:57:53-07:00 davem@nuts.davemloft.net 
#   [NET]: Uninline netif_rx_ni().
#   
#   It expands to a lot of code when SMP or PREEMPT is
#   enabled.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/core/dev.c
#   2004/10/20 16:57:03-07:00 davem@nuts.davemloft.net +14 -0
#   [NET]: Uninline netif_rx_ni().
# 
# include/linux/netdevice.h
#   2004/10/20 16:57:03-07:00 davem@nuts.davemloft.net +1 -15
#   [NET]: Uninline netif_rx_ni().
# 
diff -Nru a/include/linux/netdevice.h b/include/linux/netdevice.h
--- a/include/linux/netdevice.h	2004-10-20 16:58:28 -07:00
+++ b/include/linux/netdevice.h	2004-10-20 16:58:28 -07:00
@@ -677,6 +677,7 @@
 
 #define HAVE_NETIF_RX 1
 extern int		netif_rx(struct sk_buff *skb);
+extern int		netif_rx_ni(struct sk_buff *skb);
 #define HAVE_NETIF_RECEIVE_SKB 1
 extern int		netif_receive_skb(struct sk_buff *skb);
 extern int		dev_ioctl(unsigned int cmd, void __user *);
@@ -690,21 +691,6 @@
 extern void		dev_init(void);
 
 extern int		netdev_nit;
-
-/* Post buffer to the network code from _non interrupt_ context.
- * see net/core/dev.c for netif_rx description.
- */
-static inline int netif_rx_ni(struct sk_buff *skb)
-{
-       int err = netif_rx(skb);
-
-       preempt_disable();
-       if (softirq_pending(smp_processor_id()))
-               do_softirq();
-       preempt_enable();
-
-       return err;
-}
 
 /* Called by rtnetlink.c:rtnl_unlock() */
 extern void netdev_run_todo(void);
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	2004-10-20 16:58:28 -07:00
+++ b/net/core/dev.c	2004-10-20 16:58:28 -07:00
@@ -1587,6 +1587,20 @@
 	return NET_RX_DROP;
 }
 
+int netif_rx_ni(struct sk_buff *skb)
+{
+       int err = netif_rx(skb);
+
+       preempt_disable();
+       if (softirq_pending(smp_processor_id()))
+               do_softirq();
+       preempt_enable();
+
+       return err;
+}
+
+EXPORT_SYMBOL(netif_rx_ni);
+
 static __inline__ void skb_bond(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
