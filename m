Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbTEGTXC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbTEGTVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:21:44 -0400
Received: from relax.cmf.nrl.navy.mil ([134.207.10.227]:1408 "EHLO
	relax.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264213AbTEGTTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:19:51 -0400
Date: Wed, 7 May 2003 15:32:23 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
Message-Id: <200305071932.h47JWNa00940@relax.cmf.nrl.navy.mil>
To: davem@redhat.com
Subject: [PATCH][ATM] remove iovcnt from atm_skb
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


skb's has (and has had for a while) scatter/gather support
making the scatter gather in atm redundant.  the current iovcnt
schme really isnt being used anyway typically.   the atm
layer will need a little more work in the future to take
advantage of the skb scatter/gather support.  this patch
removes the iovcnt dependencies and gets the check for
non linear skbs right.


--- linux-2.5.68/include/linux/atmdev.h.003	Wed May  7 12:08:51 2003
+++ linux-2.5.68/include/linux/atmdev.h	Wed May  7 12:14:16 2003
@@ -385,7 +385,6 @@
 
 struct atm_skb_data {
 	struct atm_vcc	*vcc;		/* ATM VCC */
-	int		iovcnt;		/* 0 for "normal" operation */
 	unsigned long	atm_options;	/* ATM layer options */
 };
 
--- linux-2.5.68/net/atm/common.c.003	Wed May  7 12:17:39 2003
+++ linux-2.5.68/net/atm/common.c	Wed May  7 12:18:23 2003
@@ -391,27 +391,6 @@
 		    (unsigned long) buff,eff_len);
 	DPRINTK("RcvM %d -= %d\n",atomic_read(&vcc->sk->rmem_alloc),skb->truesize);
 	atm_return(vcc,skb->truesize);
-	if (ATM_SKB(skb)->iovcnt) { /* @@@ hack */
-		/* iovcnt set, use scatter-gather for receive */
-		int el, cnt;
-		struct iovec *iov = (struct iovec *)skb->data;
-		unsigned char *p = (unsigned char *)buff;
-
-		el = eff_len;
-		error = 0;
-		for (cnt = 0; (cnt < ATM_SKB(skb)->iovcnt) && el; cnt++) {
-/*printk("s-g???: %p -> %p (%d)\n",iov->iov_base,p,iov->iov_len);*/
-			error = copy_to_user(p,iov->iov_base,
-			    (iov->iov_len > el) ? el : iov->iov_len) ?
-			    -EFAULT : 0;
-			if (error) break;
-			p += iov->iov_len;
-			el -= (iov->iov_len > el)?el:iov->iov_len;
-			iov++;
-		}
-		kfree_skb(skb);
-		return error ? error : eff_len;
-	}
 	error = copy_to_user(buff,skb->data,eff_len) ? -EFAULT : 0;
 	kfree_skb(skb);
 	return error ? error : eff_len;
@@ -470,7 +449,6 @@
 	remove_wait_queue(&vcc->sleep,&wait);
 	if (error) return error;
 	skb->dev = NULL; /* for paths shared with net_device interfaces */
-	ATM_SKB(skb)->iovcnt = 0;
 	ATM_SKB(skb)->atm_options = vcc->atm_options;
 	if (copy_from_user(skb_put(skb,size),buff,size)) {
 		kfree_skb(skb);
--- linux-2.5.68/net/atm/clip.c.003	Wed May  7 12:18:45 2003
+++ linux-2.5.68/net/atm/clip.c	Wed May  7 12:19:13 2003
@@ -433,7 +433,6 @@
 		((u16 *) here)[3] = skb->protocol;
 	}
 	atomic_add(skb->truesize,&vcc->sk->wmem_alloc);
-	ATM_SKB(skb)->iovcnt = 0;
 	ATM_SKB(skb)->atm_options = vcc->atm_options;
 	entry->vccs->last_use = jiffies;
 	DPRINTK("atm_skb(%p)->vcc(%p)->dev(%p)\n",skb,vcc,vcc->dev);
--- linux-2.5.68/net/atm/lec.c.004	Wed May  7 12:19:24 2003
+++ linux-2.5.68/net/atm/lec.c	Wed May  7 12:19:56 2003
@@ -204,7 +204,6 @@
 	if (atm_may_send(vcc, skb->len)) {
 		atomic_add(skb->truesize, &vcc->sk->wmem_alloc);
 	        ATM_SKB(skb)->vcc = vcc;
-	        ATM_SKB(skb)->iovcnt = 0;
 	        ATM_SKB(skb)->atm_options = vcc->atm_options;
 		priv->stats.tx_packets++;
 		priv->stats.tx_bytes += skb->len;
--- linux-2.5.68/net/atm/mpc.c.003	Wed May  7 12:20:09 2003
+++ linux-2.5.68/net/atm/mpc.c	Wed May  7 12:20:30 2003
@@ -521,7 +521,6 @@
 	}
 
 	atomic_add(skb->truesize, &entry->shortcut->sk->wmem_alloc);
-	ATM_SKB(skb)->iovcnt = 0; /* just to be safe ... */
 	ATM_SKB(skb)->atm_options = entry->shortcut->atm_options;
 	entry->shortcut->send(entry->shortcut, skb);
 	entry->packets_fwded++;
--- linux-2.5.68/net/atm/pppoatm.c.000	Wed May  7 12:20:42 2003
+++ linux-2.5.68/net/atm/pppoatm.c	Wed May  7 12:20:48 2003
@@ -232,7 +232,6 @@
 		return 1;
 	}
 	atomic_add(skb->truesize, &ATM_SKB(skb)->vcc->sk->wmem_alloc);
-	ATM_SKB(skb)->iovcnt = 0;
 	ATM_SKB(skb)->atm_options = ATM_SKB(skb)->vcc->atm_options;
 	DPRINTK("(unit %d): atm_skb(%p)->vcc(%p)->dev(%p)\n",
 	    pvcc->chan.unit, skb, ATM_SKB(skb)->vcc,
--- linux-2.5.68/drivers/atm/idt77252.c.001	Wed May  7 12:22:25 2003
+++ linux-2.5.68/drivers/atm/idt77252.c	Wed May  7 12:27:00 2003
@@ -1988,7 +1988,7 @@
 		return -EINVAL;
 	}
 
-	if (ATM_SKB(skb)->iovcnt != 0) {
+	if (skb_shinfo(skb)->nr_frags != 0) {
 		printk("%s: No scatter-gather yet.\n", card->name);
 		atomic_inc(&vcc->stats->tx_err);
 		dev_kfree_skb(skb);
@@ -2026,7 +2026,6 @@
 		return -ENOMEM;
 	}
 	atomic_add(skb->truesize, &vcc->sk->wmem_alloc);
-	ATM_SKB(skb)->iovcnt = 0;
 
 	memcpy(skb_put(skb, 52), cell, 52);
 
--- linux-2.5.68/drivers/atm/zatm.c.000	Wed May  7 12:27:35 2003
+++ linux-2.5.68/drivers/atm/zatm.c	Wed May  7 12:29:27 2003
@@ -827,10 +827,10 @@
 	vcc = ATM_SKB(skb)->vcc;
 	zatm_dev = ZATM_DEV(vcc->dev);
 	zatm_vcc = ZATM_VCC(vcc);
-	EVENT("iovcnt=%d\n",ATM_SKB(skb)->iovcnt,0);
+	EVENT("iovcnt=%d\n",skb_shinfo(skb)->nr_frags,0);
 	save_flags(flags);
 	cli();
-	if (!ATM_SKB(skb)->iovcnt) {
+	if (!skb_shinfo(skb)->nr_frags) {
 		if (zatm_vcc->txing == RING_ENTRIES-1) {
 			restore_flags(flags);
 			return RING_BUSY;
--- linux-2.5.68/drivers/atm/eni.c.000	Wed May  7 12:31:08 2003
+++ linux-2.5.68/drivers/atm/eni.c	Wed May  7 13:37:55 2003
@@ -1100,9 +1100,9 @@
 	dma_rd = eni_in(MID_DMA_RD_TX);
 	dma_size = 3; /* JK for descriptor and final fill, plus final size
 			 mis-alignment fix */
-DPRINTK("iovcnt = %d\n",ATM_SKB(skb)->iovcnt);
-	if (!ATM_SKB(skb)->iovcnt) dma_size += 5;
-	else dma_size += 5*ATM_SKB(skb)->iovcnt;
+DPRINTK("iovcnt = %d\n",skb_shinfo(skb)->nr_frags);
+	if (!skb_shinfo(skb)->nr_frags) dma_size += 5;
+	else dma_size += 5*(skb_shinfo(skb)->nr_frags+1);
 	if (dma_size > TX_DMA_BUF) {
 		printk(KERN_CRIT DEV_LABEL "(itf %d): needs %d DMA entries "
 		    "(got only %d)\n",vcc->dev->number,dma_size,TX_DMA_BUF);
@@ -1123,15 +1123,20 @@
 	     MID_DMA_COUNT_SHIFT) | (tx->index << MID_DMA_CHAN_SHIFT) |
 	     MID_DT_JK;
 	j++;
-	if (!ATM_SKB(skb)->iovcnt)
+	if (!skb_shinfo(skb)->nr_frags)
 		if (aal5) put_dma(tx->index,eni_dev->dma,&j,paddr,skb->len);
 		else put_dma(tx->index,eni_dev->dma,&j,paddr+4,skb->len-4);
 	else {
 DPRINTK("doing direct send\n"); /* @@@ well, this doesn't work anyway */
-		for (i = 0; i < ATM_SKB(skb)->iovcnt; i++)
-			put_dma(tx->index,eni_dev->dma,&j,(unsigned long)
-			    ((struct iovec *) skb->data)[i].iov_base,
-			    ((struct iovec *) skb->data)[i].iov_len);
+		for (i = -1; i < skb_shinfo(skb)->nr_frags; i++)
+			if (i == -1)
+				put_dma(tx->index,eni_dev->dma,&j,(unsigned long)
+				    skb->data,
+				    skb->len - skb->data_len);
+			else
+				put_dma(tx->index,eni_dev->dma,&j,(unsigned long)
+				    skb_shinfo(skb)->frags[i].page + skb_shinfo(skb)->frags[i].page_offset,
+				    skb_shinfo(skb)->frags[i].size);
 	}
 	if (skb->len & 3)
 		put_dma(tx->index,eni_dev->dma,&j,zeroes,4-(skb->len & 3));
--- linux-2.5.68/drivers/atm/nicstar.c.001	Wed May  7 12:44:32 2003
+++ linux-2.5.68/drivers/atm/nicstar.c	Wed May  7 13:08:10 2003
@@ -1605,9 +1605,9 @@
 	        card->index);
          iovb = vc->rx_iov;
          recycle_iovec_rx_bufs(card, (struct iovec *) iovb->data,
-	                       ATM_SKB(iovb)->iovcnt);
-         ATM_SKB(iovb)->iovcnt = 0;
-         ATM_SKB(iovb)->vcc = NULL;
+	                       NS_SKB(iovb)->iovcnt);
+         NS_SKB(iovb)->iovcnt = 0;
+         NS_SKB(iovb)->vcc = NULL;
          ns_grab_int_lock(card, flags);
          recycle_iov_buf(card, iovb);
          spin_unlock_irqrestore(&card->int_lock, flags);
@@ -1805,7 +1805,7 @@
       return -EINVAL;
    }
    
-   if (ATM_SKB(skb)->iovcnt != 0)
+   if (skb_shinfo(skb)->nr_frags != 0)
    {
       printk("nicstar%d: No scatter-gather yet.\n", card->index);
       atomic_inc(&vcc->stats->tx_err);
@@ -2230,30 +2230,30 @@
 	    }
 	 }
       vc->rx_iov = iovb;
-      ATM_SKB(iovb)->iovcnt = 0;
+      NS_SKB(iovb)->iovcnt = 0;
       iovb->len = 0;
       iovb->tail = iovb->data = iovb->head;
-      ATM_SKB(iovb)->vcc = vcc;
+      NS_SKB(iovb)->vcc = vcc;
       /* IMPORTANT: a pointer to the sk_buff containing the small or large
                     buffer is stored as iovec base, NOT a pointer to the 
 	            small or large buffer itself. */
    }
-   else if (ATM_SKB(iovb)->iovcnt >= NS_MAX_IOVECS)
+   else if (NS_SKB(iovb)->iovcnt >= NS_MAX_IOVECS)
    {
       printk("nicstar%d: received too big AAL5 SDU.\n", card->index);
       atomic_inc(&vcc->stats->rx_err);
       recycle_iovec_rx_bufs(card, (struct iovec *) iovb->data, NS_MAX_IOVECS);
-      ATM_SKB(iovb)->iovcnt = 0;
+      NS_SKB(iovb)->iovcnt = 0;
       iovb->len = 0;
       iovb->tail = iovb->data = iovb->head;
-      ATM_SKB(iovb)->vcc = vcc;
+      NS_SKB(iovb)->vcc = vcc;
    }
-   iov = &((struct iovec *) iovb->data)[ATM_SKB(iovb)->iovcnt++];
+   iov = &((struct iovec *) iovb->data)[NS_SKB(iovb)->iovcnt++];
    iov->iov_base = (void *) skb;
    iov->iov_len = ns_rsqe_cellcount(rsqe) * 48;
    iovb->len += iov->iov_len;
 
-   if (ATM_SKB(iovb)->iovcnt == 1)
+   if (NS_SKB(iovb)->iovcnt == 1)
    {
       if (skb->list != &card->sbpool.queue)
       {
@@ -2267,7 +2267,7 @@
          return;
       }
    }
-   else /* ATM_SKB(iovb)->iovcnt >= 2 */
+   else /* NS_SKB(iovb)->iovcnt >= 2 */
    {
       if (skb->list != &card->lbpool.queue)
       {
@@ -2276,7 +2276,7 @@
          which_list(card, skb);
          atomic_inc(&vcc->stats->rx_err);
          recycle_iovec_rx_bufs(card, (struct iovec *) iovb->data,
-	                       ATM_SKB(iovb)->iovcnt);
+	                       NS_SKB(iovb)->iovcnt);
          vc->rx_iov = NULL;
          recycle_iov_buf(card, iovb);
 	 return;
@@ -2300,7 +2300,7 @@
             printk(".\n");
          atomic_inc(&vcc->stats->rx_err);
          recycle_iovec_rx_bufs(card, (struct iovec *) iovb->data,
-	   ATM_SKB(iovb)->iovcnt);
+	   NS_SKB(iovb)->iovcnt);
 	 vc->rx_iov = NULL;
          recycle_iov_buf(card, iovb);
 	 return;
@@ -2308,7 +2308,7 @@
 
       /* By this point we (hopefully) have a complete SDU without errors. */
 
-      if (ATM_SKB(iovb)->iovcnt == 1)	/* Just a small buffer */
+      if (NS_SKB(iovb)->iovcnt == 1)	/* Just a small buffer */
       {
          /* skb points to a small buffer */
          if (!atm_charge(vcc, skb->truesize))
@@ -2330,7 +2330,7 @@
             atomic_inc(&vcc->stats->rx);
          }
       }
-      else if (ATM_SKB(iovb)->iovcnt == 2)	/* One small plus one large buffer */
+      else if (NS_SKB(iovb)->iovcnt == 2)	/* One small plus one large buffer */
       {
          struct sk_buff *sb;
 
@@ -2407,7 +2407,7 @@
                printk("nicstar%d: Out of huge buffers.\n", card->index);
                atomic_inc(&vcc->stats->rx_drop);
                recycle_iovec_rx_bufs(card, (struct iovec *) iovb->data,
-	                             ATM_SKB(iovb)->iovcnt);
+	                             NS_SKB(iovb)->iovcnt);
                vc->rx_iov = NULL;
                recycle_iov_buf(card, iovb);
                return;
@@ -2445,7 +2445,7 @@
 
          if (!atm_charge(vcc, hb->truesize))
 	 {
-            recycle_iovec_rx_bufs(card, iov, ATM_SKB(iovb)->iovcnt);
+            recycle_iovec_rx_bufs(card, iov, NS_SKB(iovb)->iovcnt);
             if (card->hbpool.count < card->hbnr.max)
             {
                skb_queue_tail(&card->hbpool.queue, hb);
@@ -2468,7 +2468,7 @@
                         0, 0);
 
             /* Copy all large buffers to the huge buffer and free them */
-            for (j = 1; j < ATM_SKB(iovb)->iovcnt; j++)
+            for (j = 1; j < NS_SKB(iovb)->iovcnt; j++)
             {
                lb = (struct sk_buff *) iov->iov_base;
                tocopy = MIN(remaining, iov->iov_len);
--- linux-2.5.68/drivers/atm/nicstar.h.001	Wed May  7 12:45:05 2003
+++ linux-2.5.68/drivers/atm/nicstar.h	Wed May  7 12:46:44 2003
@@ -750,6 +750,15 @@
 } vc_map;
 
 
+struct ns_skb_data
+{
+	struct atm_vcc *vcc;
+	int iovcnt;
+};
+
+#define NS_SKB(skb) (((struct ns_skb_data *) (skb)->cb))
+
+
 typedef struct ns_dev
 {
    int index;				/* Card ID to the device driver */
--- linux-2.5.68/drivers/atm/iphase.c.001	Wed May  7 12:48:44 2003
+++ linux-2.5.68/drivers/atm/iphase.c	Wed May  7 12:48:52 2003
@@ -1167,7 +1167,6 @@
 	skb_put(skb,len);  
         // pwang_test
         ATM_SKB(skb)->vcc = vcc;
-        ATM_SKB(skb)->iovcnt = 0;
         ATM_DESC(skb) = desc;        
 	skb_queue_tail(&iadev->rx_dma_q, skb);  
 
--- linux-2.5.68/drivers/atm/horizon.c.000	Wed May  7 12:50:28 2003
+++ linux-2.5.68/drivers/atm/horizon.c	Wed May  7 13:35:20 2003
@@ -1764,17 +1764,20 @@
   
   {
     unsigned int tx_len = skb->len;
-    unsigned int tx_iovcnt = ATM_SKB(skb)->iovcnt;
+    unsigned int tx_iovcnt = skb_shinfo(skb)->nr_frags;
     // remember this so we can free it later
     dev->tx_skb = skb;
     
     if (tx_iovcnt) {
       // scatter gather transfer
       dev->tx_regions = tx_iovcnt;
-      dev->tx_iovec = (struct iovec *) skb->data;
+      dev->tx_iovec = 0;		/* @@@ needs rewritten */
       dev->tx_bytes = 0;
       PRINTD (DBG_TX|DBG_BUS, "TX start scatter-gather transfer (iovec %p, len %d)",
 	      skb->data, tx_len);
+      tx_release (dev);
+      hrz_kfree_skb (skb);
+      return -EIO;
     } else {
       // simple transfer
       dev->tx_regions = 0;
