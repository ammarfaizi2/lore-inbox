Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTJTXOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTJTXOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:14:37 -0400
Received: from [65.172.181.6] ([65.172.181.6]:28604 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262902AbTJTXOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:14:34 -0400
Date: Mon, 20 Oct 2003 16:14:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.0-test6, connntrack/sis900/net (?)  Badness in
 local_bh_enable at kernel/softirq.c:119
Message-Id: <20031020161437.6708e994.akpm@osdl.org>
In-Reply-To: <20031020222306.GB32167@finwe.eu.org>
References: <20031020222306.GB32167@finwe.eu.org>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek Kawa <jfk@zeus.polsl.gliwice.pl> wrote:
>
> I found it in logs (2.6.0-test6). It happened little while after 
> I had reloaded dhcpd configuration.
> 
> I'm not sure if it's related to NIC or ip-conntrack, but as both
> are mentioned... 
> 
> System information below.
> 
> eth0: Media Link Off
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Transmit timeout, status 00000004 00000000 
> Badness in local_bh_enable at kernel/softirq.c:119
> Call Trace:
>  [local_bh_enable+137/144] local_bh_enable+0x89/0x90
>  [_end+130859013/1069963240] ip_ct_find_proto+0x3d/0x60 [ip_conntrack]
>  [_end+130860013/1069963240] destroy_conntrack+0x15/0x110 [ip_conntrack]
>  [sock_wfree+73/80] sock_wfree+0x49/0x50
>  [__kfree_skb+143/272] __kfree_skb+0x8f/0x110
>  [_end+130608961/1069963240] sis900_tx_timeout+0x99/0x150 [sis900]
>  [dev_watchdog+0/208] dev_watchdog+0x0/0xd0
>  [dev_watchdog+191/208] dev_watchdog+0xbf/0xd0

This should fix it up.


diff -puN drivers/net/sis900.c~sis900-tx_timeout-fix drivers/net/sis900.c
--- 25/drivers/net/sis900.c~sis900-tx_timeout-fix	Mon Oct 20 16:10:04 2003
+++ 25-akpm/drivers/net/sis900.c	Mon Oct 20 16:10:11 2003
@@ -1438,7 +1438,7 @@ static void sis900_tx_timeout(struct net
 			pci_unmap_single(sis_priv->pci_dev, 
 				sis_priv->tx_ring[i].bufptr, skb->len,
 				PCI_DMA_TODEVICE);
-			dev_kfree_skb(skb);
+			dev_kfree_skb_irq(skb);
 			sis_priv->tx_skbuff[i] = 0;
 			sis_priv->tx_ring[i].cmdsts = 0;
 			sis_priv->tx_ring[i].bufptr = 0;

_

