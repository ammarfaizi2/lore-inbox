Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbWHUFeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbWHUFeC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 01:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbWHUFeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 01:34:02 -0400
Received: from msr31.hinet.net ([168.95.4.131]:5555 "EHLO msr31.hinet.net")
	by vger.kernel.org with ESMTP id S932601AbWHUFeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 01:34:00 -0400
Message-ID: <008801c6c4e3$62faed30$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <akpm@osdl.org>
References: <1155841780.4532.21.camel@localhost.localdomain> <44E5A1E1.1060500@pobox.com>
Subject: Re: [PATCH 6/6] IP100A Solve host error problem when in low	performance embedded
Date: Mon, 21 Aug 2006 13:33:51 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff:

    I will follow those suggestions. Thanks.

Jesse
----- Original Message ----- 
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>;
<akpm@osdl.org>
Sent: Friday, August 18, 2006 7:17 PM
Subject: Re: [PATCH 6/6] IP100A Solve host error problem when in low
performance embedded


Jesse Huang wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
>
> Solve host error problem when in low performance embedded
>
> Change Logs:
>     Solve host error problem when in low performance embedded
>
> ---
>
>  drivers/net/sundance.c |   26 ++++++++++++++++++++++----
>  1 files changed, 22 insertions(+), 4 deletions(-)
>
> 78ff57ea887c19b7552342e990375f5e2bb10af9
> diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
> index c7c22f0..94ba6ca 100755
> --- a/drivers/net/sundance.c
> +++ b/drivers/net/sundance.c
> @@ -1075,7 +1075,7 @@ reset_tx (struct net_device *dev)
>  struct sk_buff *skb;
>  int i;
>  int irq = in_interrupt();
> -
> + tasklet_kill(&np->tx_tasklet);

NAK, it is a bug to call tasklet_kill() from inside an interrupt.


> @@ -1646,6 +1646,13 @@ static int netdev_close(struct net_devic
>  struct sk_buff *skb;
>  int i;
>
> + /* Wait and kill tasklet */
> + tasklet_kill(&np->rx_tasklet);
> + tasklet_kill(&np->tx_tasklet);
> +   np->cur_tx = np->dirty_tx = 0;

fix source code indent


> + np->cur_task = 0;
> + np->last_tx=0;

needs whitespace:  s/=/ = /


>  netif_stop_queue(dev);
>
>  if (netif_msg_ifdown(np)) {
> @@ -1666,9 +1673,19 @@ static int netdev_close(struct net_devic
>  /* Stop the chip's Tx and Rx processes. */
>  iowrite16(TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl1);
>
> - /* Wait and kill tasklet */
> - tasklet_kill(&np->rx_tasklet);
> - tasklet_kill(&np->tx_tasklet);
> +    for(i=2000;i> 0;i--) {
> + if((readl(ioaddr + DMACtrl)&0xC000) == 0)break;
> + mdelay(1);
> +    }

(1) fix indentation

(2) add whitespace to 'for' loop

(3) use ioread32(), not readl()

(4) are you certain that DMACtrl should be read as a 32-bit register?
In other code, you treat it as a 16-bit register.



> +    writew(GlobalReset | DMAReset | FIFOReset |NetworkReset, ioaddr
+ASICCtrl + 2);

(5) use iowrite16() not writew()


> +    for(i=2000;i >0;i--)
> +    {
> + if((readw(ioaddr + ASICCtrl +2)&ResetBusy) == 0)
> +     break;
> + mdelay(1);
> +    }

(6) fix indentation to match the rest of the driver

(7) use ioread16(), not readw()

(8) add whitespace to 'for' loop


>  #ifdef __i386__
>  if (netif_msg_hw(np)) {
> @@ -1706,6 +1723,7 @@ #endif /* __i386__ debugging only */
>  }
>  }
>  for (i = 0; i < TX_RING_SIZE; i++) {
> + np->tx_ring[i].next_desc=0;

(9) add whitespace to assignment:  s/=/ = /


>  skb = np->tx_skbuff[i];
>  if (skb) {
>  pci_unmap_single(np->pci_dev,


