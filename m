Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283219AbRK3Q5s>; Fri, 30 Nov 2001 11:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283272AbRK3Q5j>; Fri, 30 Nov 2001 11:57:39 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:27630 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S283219AbRK3Q50>;
	Fri, 30 Nov 2001 11:57:26 -0500
Date: Fri, 30 Nov 2001 09:57:17 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: kumon@flab.fujitsu.co.jp
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [PATCH] 8139too.c
Message-ID: <20011130095717.F15936@lynx.no>
Mail-Followup-To: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>
In-Reply-To: <200111301123.UAA23808@asami.proc.flab.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200111301123.UAA23808@asami.proc.flab.fujitsu.co.jp>; from kumon@flab.fujitsu.co.jp on Fri, Nov 30, 2001 at 08:23:36PM +0900
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2001  20:23 +0900, kumon@flab.fujitsu.co.jp wrote:
> In 8139too.c, skb is used after it is freed.
> Look at the argument of RTL_W32_F() in the following patch.
> 
> 8 % diff -u -10 8139too.c  /tmp/8139too.c 
> --- 8139too.c	Sun Nov 25 10:46:36 2001
> +++ /tmp/8139too.c	Fri Nov 30 19:50:48 2001
      ^^^^^^^^^^^^^^
Please try to keep patches relative to the linux/ directory, so they can
be applied via "patch -p1" as most other kernel patches are.  Also note
that you should CC the driver maintainer if you want to get the patch
into the kernel (in this case Jeff Garzik <jgarzik@mandrakesoft.com>).

> +	dev_kfree_skb(skb);
>  
>  	DPRINTK ("%s: Queued Tx packet at %p size %u to slot %d.\n",
>  		 dev->name, skb->data, skb->len, entry);
                            ^^^^^^^^^^^^^^^^^^^
Your patch still does not fix the problems.  Since we only use "skb->len"
(except for the debug case, where we also use the skb->data pointer),
rather just copy skb->len into a local variable and free skb early, so
it can be used again, rather than holding it over a spin lock.

I don't know if anyone really cares about the skb->data pointer in the
DPRINTK.  If so, we could move it up before we free the skb, but I
thought it incorrect to do so, because it is not queued at that time,
and I didn't want to add a temp variable that only appears in a debug.

Cheers, Andreas
--- linux/drivers/net/8139too.c.orig	Sun Nov 25 10:46:36 2001
+++ linux/drivers/net/8139too.c	Fri Nov 30 19:50:48 2001
@@ -1635,35 +1635,36 @@
 	struct rtl8139_private *tp = dev->priv;
 	void *ioaddr = tp->mmio_addr;
 	unsigned int entry;
+	unsigned int len = skb->len;
 
 	/* Calculate the next Tx descriptor entry. */
 	entry = tp->cur_tx % NUM_TX_DESC;
 
-	if (likely(skb->len < TX_BUF_SIZE)) {
+	if (likely(len < TX_BUF_SIZE)) {
 		skb_copy_and_csum_dev(skb, tp->tx_buf[entry]);
 		dev_kfree_skb(skb);
 	} else {
 		dev_kfree_skb(skb);
 		tp->stats.tx_dropped++;
 		return 0;
-  	}
+	}
 
 	/* Note: the chip doesn't have auto-pad! */
 	spin_lock_irq(&tp->lock);
 	RTL_W32_F (TxStatus0 + (entry * sizeof (u32)),
-		   tp->tx_flag | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
+		   tp->tx_flag | max(len, (unsigned int)ETH_ZLEN));
 
 	dev->trans_start = jiffies;
 
 	tp->cur_tx++;
 	wmb();
 
 	if ((tp->cur_tx - NUM_TX_DESC) == tp->dirty_tx)
 		netif_stop_queue (dev);
 	spin_unlock_irq(&tp->lock);
 
-	DPRINTK ("%s: Queued Tx packet at %p size %u to slot %d.\n",
-		 dev->name, skb->data, skb->len, entry);
+	DPRINTK ("%s: Queued Tx packet size %u to slot %d.\n",
+		 dev->name, len, entry);
 
 	return 0;
 }

--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

