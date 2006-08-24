Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965335AbWHXB4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965335AbWHXB4M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 21:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965334AbWHXB4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 21:56:12 -0400
Received: from msr1.hinet.net ([168.95.4.101]:4040 "EHLO msr1.hinet.net")
	by vger.kernel.org with ESMTP id S965322AbWHXB4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 21:56:11 -0400
Message-ID: <028f01c6c720$722f6f30$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <akpm@osdl.org>,
       <jgarzik@pobox.com>
References: <1156271492.4662.6.camel@localhost.localdomain> <20060822090542.6469977a.rdunlap@xenotime.net>
Subject: Re: [PATCH 4/4] IP100A: Solve host error problem in low performance embedded system when continune down and up.
Date: Thu, 24 Aug 2006 09:55:59 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy:

Sorry for the file path. I will regenerate with path
a/drivers/net/sundance.c
and re-submit again.

Thanks for your help!

Best Regards,
Jesse Huang

----- Original Message ----- 
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <linux-kernel@vger.kernel.org>; <netdev@vger.kernel.org>;
<akpm@osdl.org>; <jgarzik@pobox.com>
Sent: Wednesday, August 23, 2006 12:05 AM
Subject: Re: [PATCH 4/4] IP100A: Solve host error problem in low performance
embedded system when continune down and up.


On Tue, 22 Aug 2006 14:31:32 -0400 Jesse Huang wrote:

> From: Jesse Huang <jesse@icplus.com.tw>
>
> Change Logs:
>    - Solve host error problem in low performance embedded
>      system when continune down and up.
>
> Signed-off-by: Jesse Huang <jesse@icplus.com.tw>
>
> ---
>
>  sundance.c |   30 +++++++++++++++++++++++++-----
>  1 files changed, 25 insertions(+), 5 deletions(-)

Full path/file names above and below, please.

> a88c635933a981dd4fca87e5b8ca9426c5c98013
> diff --git a/sundance.c b/sundance.c
> index 424aebd..de55e0f 100755
> --- a/sundance.c
> +++ b/sundance.c
> @@ -1647,6 +1647,14 @@ static int netdev_close(struct net_devic
>  struct sk_buff *skb;
>  int i;
>
> + /* Wait and kill tasklet */
> + tasklet_kill(&np->rx_tasklet);
> + tasklet_kill(&np->tx_tasklet);
> +   np->cur_tx = 0;
> +   np->dirty_tx = 0;

Use same indentation/whitespace as surrounding code.
(tabs, not spaces)

> + np->cur_task = 0;
> + np->last_tx = 0;
> +
>  netif_stop_queue(dev);
>
>  if (netif_msg_ifdown(np)) {
> @@ -1667,9 +1675,20 @@ static int netdev_close(struct net_devic
>  /* Stop the chip's Tx and Rx processes. */
>  iowrite16(TxDisable | RxDisable | StatsDisable, ioaddr + MACCtrl1);
>
> - /* Wait and kill tasklet */
> - tasklet_kill(&np->rx_tasklet);
> - tasklet_kill(&np->tx_tasklet);
> +    for (i = 2000; i > 0; i--) {
> + if ((ioread32(ioaddr + DMACtrl) &0xC000) == 0)
> +     break;
> + mdelay(1);
> +    }
> +
> +    iowrite16(GlobalReset | DMAReset | FIFOReset |NetworkReset, ioaddr
+ASICCtrl + 2);
> +
> +    for (i = 2000; i > 0; i--)
> +    {
> + if ((ioread16(ioaddr + ASICCtrl +2) &ResetBusy) == 0)
> +     break;
> + mdelay(1);
> +    }

Same comment about indentation/whitespace.

---
~Randy


