Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbTJEQBY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 12:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbTJEQBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 12:01:24 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:12299 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263142AbTJEQBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 12:01:22 -0400
Date: Sun, 5 Oct 2003 17:36:22 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Mikko Korhonen <mjkorhon@aeropc5.hut.fi>
cc: Jean Tourrilhes <jt@hpl.hp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: irda weirdness
In-Reply-To: <3F8008E1.1080200@aeropc5.hut.fi>
Message-ID: <Pine.LNX.4.44.0310051646400.1388-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Oct 2003, Mikko Korhonen wrote:

> I'm getting
> Debug: sleeping function called from invalid context at 
> include/asm/uaccess.h:498

copy_from_user called from context where sleeping is not allowed. No idea 
where this is comming from - it's not in your calltrace.

> and Badness in local_bh_enable at kernel/softirq.c:119

local_bh_enable called with irqs_disabled.

Your calltrace suggests it's called from sirdev_hard_xmit, i.e. the final 
spin_unlock_bh - definitedly a bad idea because netdev->hard_start_xmit
is already called with bh disabled. However, I'm not sure is this is the 
whole story because I fail to see who might call us with interrupts off.

Could you try the patch below?

Martin

------------------------

--- linux-2.6.0-test6-bk5/drivers/net/irda/sir_dev.c	Sat Oct  4 11:45:44 2003
+++ v2.6.0-test6-bk5-md/drivers/net/irda/sir_dev.c	Sun Oct  5 17:20:13 2003
@@ -306,8 +306,8 @@ static int sirdev_hard_xmit(struct sk_bu
 		IRDA_DEBUG(3, "%s(), write not completed\n", __FUNCTION__);
 	}
 
-	/* serialize with write completion */
-	spin_lock_bh(&dev->tx_lock);
+	/* serialize with write completion - bh's already disabled */
+	spin_lock(&dev->tx_lock);
 
         /* Copy skb to tx_buff while wrapping, stuffing and making CRC */
 	dev->tx_buff.len = async_wrap_skb(skb, dev->tx_buff.data, dev->tx_buff.truesize); 
@@ -337,7 +337,7 @@ static int sirdev_hard_xmit(struct sk_bu
 		dev->stats.tx_dropped++;		      
 		netif_wake_queue(ndev);
 	}
-	spin_unlock_bh(&dev->tx_lock);
+	spin_unlock(&dev->tx_lock);
 
 	return 0;
 }

