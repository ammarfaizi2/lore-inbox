Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263323AbTDRXQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 19:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbTDRXQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 19:16:28 -0400
Received: from [12.47.58.203] ([12.47.58.203]:60300 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263323AbTDRXQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 19:16:25 -0400
Date: Fri, 18 Apr 2003 16:26:59 -0700
From: Andrew Morton <akpm@digeo.com>
To: cb-lkml@fish.zetnet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.67-mm4] Badness in local_bh_enable at kernel/softirq.c:105
Message-Id: <20030418162659.6e029b31.akpm@digeo.com>
In-Reply-To: <20030418225835.GA687@fish.zetnet.co.uk>
References: <20030418225835.GA687@fish.zetnet.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Apr 2003 23:28:18.0465 (UTC) FILETIME=[31610910:01C30602]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cb-lkml@fish.zetnet.co.uk wrote:
>
> 
> Seems to be triggered by network traffic on 3c574 PCMCIA ethernet card.
> Several different traces appear.
> 
> Config: Sony Vaio. Celeron 333, 128MB, 3c574 PCMCIA ethernet.
> 
> These are a few of the traces.
> 
> Badness in local_bh_enable at kernel/softirq.c:105
> Call Trace:
>  [<c0120dcd>] local_bh_enable+0x8d/0x90
>  [<c022bd10>] udp_sendmsg+0x1b0/0x880
>  [<c01195d5>] scheduler_tick+0x3a5/0x3b0
>  [<c022c9be>] udp_recvmsg+0x24e/0x2d0
>  [<c02349ad>] inet_sendmsg+0x4d/0x60
>  [<c01f319e>] sock_sendmsg+0x9e/0xd0
>  [<c0109bb8>] common_interrupt+0x18/0x20
>  [<c020822f>] __ip_route_output_key+0x2f/0xf0

Thanks, this should fix it up.

 25-akpm/drivers/net/pcmcia/3c574_cs.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/net/pcmcia/3c574_cs.c~3c574-irq-fix drivers/net/pcmcia/3c574_cs.c
--- 25/drivers/net/pcmcia/3c574_cs.c~3c574-irq-fix	Fri Apr 18 16:24:21 2003
+++ 25-akpm/drivers/net/pcmcia/3c574_cs.c	Fri Apr 18 16:25:11 2003
@@ -940,11 +940,9 @@ static int el3_start_xmit(struct sk_buff
 		outw(SetTxThreshold + (1536>>2), ioaddr + EL3_CMD);
 	}
 
-	dev_kfree_skb (skb);
 	pop_tx_status(dev);
-
-	spin_unlock(&lp->window_lock);
-	
+	spin_unlock_irqrestore(&lp->window_lock, flags);
+	dev_kfree_skb(skb);
 	return 0;
 }
 

_


