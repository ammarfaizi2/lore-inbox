Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbTLFBCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 20:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTLFBCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 20:02:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22199 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264896AbTLFBCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 20:02:08 -0500
Date: Fri, 5 Dec 2003 16:59:00 -0800
From: "David S. Miller" <davem@redhat.com>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, linux-kernel@vger.kernel.org,
       tsbogend@alpha.franken.de, jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: [BUG 2.6.0-test11] pcnet32 oops
Message-Id: <20031205165900.2920ea6a.davem@redhat.com>
In-Reply-To: <20031205234510.GA2319@bougret.hpl.hp.com>
References: <20031205234510.GA2319@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Dec 2003 15:45:10 -0800
Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:

> Badness in local_bh_enable at kernel/softirq.c:121
> Call Trace:
>  [<c011ff91>] local_bh_enable+0x35/0x58
>  [<c022d19a>] ip_ct_find_proto+0xd2/0xd8
>  [<c022d923>] destroy_conntrack+0x13/0x19c
>  [<c01e68c8>] __kfree_skb+0xc8/0xfc
>  [<d085b160>] pcnet32_purge_tx_ring+0x94/0xc4 [pcnet32]
>  [<d085b300>] pcnet32_restart+0x14/0x6c [pcnet32]
>  [<d085c089>] pcnet32_set_multicast_list+0x7d/0x90 [pcnet32]

This is the classic case of doing disabling/enabling of software
interrupts with hardware interrupts disabled, which is a bug.

In this case pcnet32_set_multicast_list() is disabling hardware
interrupts, and the packet freeing of pcnet32_purge_tx_ring()
is what leads to the software interrupt disable/enable.

However, I'm inclined to believe that we should change dev_kfree_skb_any()
to fix this class of problems, by making it check for hardware interrupts
being disabled as well as being in an interrupt.

But we might not want to do it like this, just reenabling the hardware
interrupts at the top level won't cause the software interrupt to fire
to actually execute the SKB freeing work.... Need to think about this
some more.

===== include/linux/netdevice.h 1.66 vs edited =====
--- 1.66/include/linux/netdevice.h	Sat Nov  1 14:11:04 2003
+++ edited/include/linux/netdevice.h	Fri Dec  5 16:53:01 2003
@@ -634,7 +634,7 @@
  */
 static inline void dev_kfree_skb_any(struct sk_buff *skb)
 {
-	if (in_irq())
+	if (in_irq() || irqs_disabled())
 		dev_kfree_skb_irq(skb);
 	else
 		dev_kfree_skb(skb);
