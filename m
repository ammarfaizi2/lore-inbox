Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTF0ANt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 20:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTF0ANs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 20:13:48 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:47760 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S263077AbTF0AMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 20:12:22 -0400
Message-Id: <200306270026.h5R0QLsG012984@ginger.cmf.nrl.navy.mil>
To: davem@redhat.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4] more atm updates backported from 2.5
Reply-To: chas3@users.sourceforge.net
Date: Thu, 26 Jun 2003 20:24:12 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[atm]: ixmicro puts esi in different location

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1006  -> 1.1007 
#	drivers/atm/nicstar.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/25	chas@relax.cmf.nrl.navy.mil	1.1007
# ixmicro puts esi in different location
# --------------------------------------------
#
diff -Nru a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
--- a/drivers/atm/nicstar.c	Thu Jun 26 07:09:21 2003
+++ b/drivers/atm/nicstar.c	Thu Jun 26 07:09:21 2003
@@ -941,9 +941,14 @@
       return error;
    }
       
-   if (ns_parse_mac(mac[i], card->atmdev->esi))
+   if (ns_parse_mac(mac[i], card->atmdev->esi)) {
       nicstar_read_eprom(card->membase, NICSTAR_EPROM_MAC_ADDR_OFFSET,
                          card->atmdev->esi, 6);
+      if (memcmp(card->atmdev->esi, "\x00\x00\x00\x00\x00\x00", 6) == 0) {
+         nicstar_read_eprom(card->membase, NICSTAR_EPROM_MAC_ADDR_OFFSET_ALT,
+                         card->atmdev->esi, 6);
+      }
+   }
 
    printk("nicstar%d: MAC address %02X:%02X:%02X:%02X:%02X:%02X\n", i,
           card->atmdev->esi[0], card->atmdev->esi[1], card->atmdev->esi[2],



[atm]: remove iovcnt member in struct atm_skb

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1007  -> 1.1008 
#	drivers/atm/horizon.c	1.3     -> 1.4    
#	       net/atm/lec.c	1.11    -> 1.12   
#	   net/atm/pppoatm.c	1.4     -> 1.5    
#	drivers/atm/nicstar.c	1.11    -> 1.12   
#	   drivers/atm/eni.c	1.6     -> 1.7    
#	  drivers/atm/zatm.c	1.5     -> 1.6    
#	       net/atm/mpc.c	1.4     -> 1.5    
#	include/linux/atmdev.h	1.6     -> 1.7    
#	drivers/atm/nicstar.h	1.3     -> 1.4    
#	      net/atm/clip.c	1.4     -> 1.5    
#	 net/sched/sch_atm.c	1.4     -> 1.5    
#	drivers/atm/idt77252.c	1.5     -> 1.6    
#	drivers/atm/iphase.c	1.15    -> 1.16   
#	    net/atm/br2684.c	1.2     -> 1.3    
#	    net/atm/common.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/25	chas@relax.cmf.nrl.navy.mil	1.1008
# remove iovcnt member in struct atm_skb
# --------------------------------------------
#
diff -Nru a/drivers/atm/eni.c b/drivers/atm/eni.c
--- a/drivers/atm/eni.c	Thu Jun 26 07:09:58 2003
+++ b/drivers/atm/eni.c	Thu Jun 26 07:09:58 2003
@@ -1101,9 +1101,9 @@
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
@@ -1124,15 +1124,20 @@
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
diff -Nru a/drivers/atm/horizon.c b/drivers/atm/horizon.c
--- a/drivers/atm/horizon.c	Thu Jun 26 07:09:58 2003
+++ b/drivers/atm/horizon.c	Thu Jun 26 07:09:58 2003
@@ -1765,17 +1765,20 @@
   
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
diff -Nru a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
--- a/drivers/atm/idt77252.c	Thu Jun 26 07:09:58 2003
+++ b/drivers/atm/idt77252.c	Thu Jun 26 07:09:58 2003
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
 	atomic_add(skb->truesize + ATM_PDU_OVHD, &vcc->sk->wmem_alloc);
-	ATM_SKB(skb)->iovcnt = 0;
 
 	memcpy(skb_put(skb, 52), cell, 52);
 
diff -Nru a/drivers/atm/iphase.c b/drivers/atm/iphase.c
--- a/drivers/atm/iphase.c	Thu Jun 26 07:09:58 2003
+++ b/drivers/atm/iphase.c	Thu Jun 26 07:09:58 2003
@@ -1186,7 +1186,6 @@
 	skb_put(skb,len);  
         // pwang_test
         ATM_SKB(skb)->vcc = vcc;
-        ATM_SKB(skb)->iovcnt = 0;
         ATM_DESC(skb) = desc;        
 	skb_queue_tail(&iadev->rx_dma_q, skb);  
 
diff -Nru a/drivers/atm/nicstar.c b/drivers/atm/nicstar.c
--- a/drivers/atm/nicstar.c	Thu Jun 26 07:09:58 2003
+++ b/drivers/atm/nicstar.c	Thu Jun 26 07:09:58 2003
@@ -1664,9 +1664,9 @@
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
@@ -1864,7 +1864,7 @@
       return -EINVAL;
    }
    
-   if (ATM_SKB(skb)->iovcnt != 0)
+   if (skb_shinfo(skb)->nr_frags != 0)
    {
       printk("nicstar%d: No scatter-gather yet.\n", card->index);
       atomic_inc(&vcc->stats->tx_err);
@@ -2289,30 +2289,30 @@
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
@@ -2326,7 +2326,7 @@
          return;
       }
    }
-   else /* ATM_SKB(iovb)->iovcnt >= 2 */
+   else /* NS_SKB(iovb)->iovcnt >= 2 */
    {
       if (skb->list != &card->lbpool.queue)
       {
@@ -2335,7 +2335,7 @@
          which_list(card, skb);
          atomic_inc(&vcc->stats->rx_err);
          recycle_iovec_rx_bufs(card, (struct iovec *) iovb->data,
-	                       ATM_SKB(iovb)->iovcnt);
+	                       NS_SKB(iovb)->iovcnt);
          vc->rx_iov = NULL;
          recycle_iov_buf(card, iovb);
 	 return;
@@ -2359,7 +2359,7 @@
             printk(".\n");
          atomic_inc(&vcc->stats->rx_err);
          recycle_iovec_rx_bufs(card, (struct iovec *) iovb->data,
-	   ATM_SKB(iovb)->iovcnt);
+	   NS_SKB(iovb)->iovcnt);
 	 vc->rx_iov = NULL;
          recycle_iov_buf(card, iovb);
 	 return;
@@ -2367,7 +2367,7 @@
 
       /* By this point we (hopefully) have a complete SDU without errors. */
 
-      if (ATM_SKB(iovb)->iovcnt == 1)	/* Just a small buffer */
+      if (NS_SKB(iovb)->iovcnt == 1)	/* Just a small buffer */
       {
          /* skb points to a small buffer */
          if (!atm_charge(vcc, skb->truesize))
@@ -2389,7 +2389,7 @@
             atomic_inc(&vcc->stats->rx);
          }
       }
-      else if (ATM_SKB(iovb)->iovcnt == 2)	/* One small plus one large buffer */
+      else if (NS_SKB(iovb)->iovcnt == 2)	/* One small plus one large buffer */
       {
          struct sk_buff *sb;
 
@@ -2466,7 +2466,7 @@
                printk("nicstar%d: Out of huge buffers.\n", card->index);
                atomic_inc(&vcc->stats->rx_drop);
                recycle_iovec_rx_bufs(card, (struct iovec *) iovb->data,
-	                             ATM_SKB(iovb)->iovcnt);
+	                             NS_SKB(iovb)->iovcnt);
                vc->rx_iov = NULL;
                recycle_iov_buf(card, iovb);
                return;
@@ -2504,7 +2504,7 @@
 
          if (!atm_charge(vcc, hb->truesize))
 	 {
-            recycle_iovec_rx_bufs(card, iov, ATM_SKB(iovb)->iovcnt);
+            recycle_iovec_rx_bufs(card, iov, NS_SKB(iovb)->iovcnt);
             if (card->hbpool.count < card->hbnr.max)
             {
                skb_queue_tail(&card->hbpool.queue, hb);
@@ -2527,7 +2527,7 @@
                         0, 0);
 
             /* Copy all large buffers to the huge buffer and free them */
-            for (j = 1; j < ATM_SKB(iovb)->iovcnt; j++)
+            for (j = 1; j < NS_SKB(iovb)->iovcnt; j++)
             {
                lb = (struct sk_buff *) iov->iov_base;
                tocopy = MIN(remaining, iov->iov_len);
diff -Nru a/drivers/atm/nicstar.h b/drivers/atm/nicstar.h
--- a/drivers/atm/nicstar.h	Thu Jun 26 07:09:58 2003
+++ b/drivers/atm/nicstar.h	Thu Jun 26 07:09:58 2003
@@ -96,6 +96,7 @@
 /* ESI stuff ******************************************************************/
 
 #define NICSTAR_EPROM_MAC_ADDR_OFFSET 0x6C
+#define NICSTAR_EPROM_MAC_ADDR_OFFSET_ALT 0xF6
 
 
 /* #defines *******************************************************************/
@@ -747,6 +748,15 @@
                				   SCD. 0x00000000 for UBR/VBR/ABR */
    int tbd_count;
 } vc_map;
+
+
+struct ns_skb_data
+{
+	struct atm_vcc *vcc;
+	int iovcnt;
+};
+
+#define NS_SKB(skb) (((struct ns_skb_data *) (skb)->cb))
 
 
 typedef struct ns_dev
diff -Nru a/drivers/atm/zatm.c b/drivers/atm/zatm.c
--- a/drivers/atm/zatm.c	Thu Jun 26 07:09:58 2003
+++ b/drivers/atm/zatm.c	Thu Jun 26 07:09:58 2003
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
diff -Nru a/include/linux/atmdev.h b/include/linux/atmdev.h
--- a/include/linux/atmdev.h	Thu Jun 26 07:09:58 2003
+++ b/include/linux/atmdev.h	Thu Jun 26 07:09:58 2003
@@ -404,7 +404,6 @@
 
 struct atm_skb_data {
 	struct atm_vcc	*vcc;		/* ATM VCC */
-	int		iovcnt;		/* 0 for "normal" operation */
 	unsigned long	atm_options;	/* ATM layer options */
 };
 
diff -Nru a/net/atm/br2684.c b/net/atm/br2684.c
--- a/net/atm/br2684.c	Thu Jun 26 07:09:58 2003
+++ b/net/atm/br2684.c	Thu Jun 26 07:09:58 2003
@@ -189,7 +189,6 @@
 		return 0;
 		}
 	atomic_add(skb->truesize, &atmvcc->sk->wmem_alloc);
-	ATM_SKB(skb)->iovcnt = 0;
 	ATM_SKB(skb)->atm_options = atmvcc->atm_options;
 	brdev->stats.tx_packets++;
 	brdev->stats.tx_bytes += skb->len;
diff -Nru a/net/atm/clip.c b/net/atm/clip.c
--- a/net/atm/clip.c	Thu Jun 26 07:09:58 2003
+++ b/net/atm/clip.c	Thu Jun 26 07:09:58 2003
@@ -427,7 +427,6 @@
 		((u16 *) here)[3] = skb->protocol;
 	}
 	atomic_add(skb->truesize,&vcc->sk->wmem_alloc);
-	ATM_SKB(skb)->iovcnt = 0;
 	ATM_SKB(skb)->atm_options = vcc->atm_options;
 	entry->vccs->last_use = jiffies;
 	DPRINTK("atm_skb(%p)->vcc(%p)->dev(%p)\n",skb,vcc,vcc->dev);
diff -Nru a/net/atm/common.c b/net/atm/common.c
--- a/net/atm/common.c	Thu Jun 26 07:09:58 2003
+++ b/net/atm/common.c	Thu Jun 26 07:09:58 2003
@@ -397,28 +397,6 @@
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
-		if (!vcc->dev->ops->free_rx_skb) kfree_skb(skb);
-		else vcc->dev->ops->free_rx_skb(vcc, skb);
-		return error ? error : eff_len;
-	}
 	error = copy_to_user(buff,skb->data,eff_len) ? -EFAULT : 0;
 	if (!vcc->dev->ops->free_rx_skb) kfree_skb(skb);
 	else vcc->dev->ops->free_rx_skb(vcc, skb);
@@ -478,7 +456,6 @@
 	remove_wait_queue(&vcc->sleep,&wait);
 	if (error) return error;
 	skb->dev = NULL; /* for paths shared with net_device interfaces */
-	ATM_SKB(skb)->iovcnt = 0;
 	ATM_SKB(skb)->atm_options = vcc->atm_options;
 	if (copy_from_user(skb_put(skb,size),buff,size)) {
 		kfree_skb(skb);
diff -Nru a/net/atm/lec.c b/net/atm/lec.c
--- a/net/atm/lec.c	Thu Jun 26 07:09:58 2003
+++ b/net/atm/lec.c	Thu Jun 26 07:09:58 2003
@@ -341,7 +341,6 @@
                         lec_h->h_dest[0], lec_h->h_dest[1], lec_h->h_dest[2],
                         lec_h->h_dest[3], lec_h->h_dest[4], lec_h->h_dest[5]);
                 ATM_SKB(skb2)->vcc = send_vcc;
-                ATM_SKB(skb2)->iovcnt = 0;
                 ATM_SKB(skb2)->atm_options = send_vcc->atm_options;
                 DPRINTK("%s:sending to vpi:%d vci:%d\n", dev->name,
                         send_vcc->vpi, send_vcc->vci);       
@@ -357,7 +356,6 @@
         }
 
         ATM_SKB(skb)->vcc = send_vcc;
-        ATM_SKB(skb)->iovcnt = 0;
         ATM_SKB(skb)->atm_options = send_vcc->atm_options;
         if (atm_may_send(send_vcc, skb->len)) {
                 atomic_add(skb->truesize, &send_vcc->sk->wmem_alloc);
diff -Nru a/net/atm/mpc.c b/net/atm/mpc.c
--- a/net/atm/mpc.c	Thu Jun 26 07:09:58 2003
+++ b/net/atm/mpc.c	Thu Jun 26 07:09:58 2003
@@ -521,7 +521,6 @@
 	}
 
 	atomic_add(skb->truesize, &entry->shortcut->sk->wmem_alloc);
-	ATM_SKB(skb)->iovcnt = 0; /* just to be safe ... */
 	ATM_SKB(skb)->atm_options = entry->shortcut->atm_options;
 	entry->shortcut->send(entry->shortcut, skb);
 	entry->packets_fwded++;
diff -Nru a/net/atm/pppoatm.c b/net/atm/pppoatm.c
--- a/net/atm/pppoatm.c	Thu Jun 26 07:09:58 2003
+++ b/net/atm/pppoatm.c	Thu Jun 26 07:09:58 2003
@@ -232,7 +232,6 @@
 		return 1;
 	}
 	atomic_add(skb->truesize, &ATM_SKB(skb)->vcc->sk->wmem_alloc);
-	ATM_SKB(skb)->iovcnt = 0;
 	ATM_SKB(skb)->atm_options = ATM_SKB(skb)->vcc->atm_options;
 	DPRINTK("(unit %d): atm_skb(%p)->vcc(%p)->dev(%p)\n",
 	    pvcc->chan.unit, skb, ATM_SKB(skb)->vcc,
diff -Nru a/net/sched/sch_atm.c b/net/sched/sch_atm.c
--- a/net/sched/sch_atm.c	Thu Jun 26 07:09:58 2003
+++ b/net/sched/sch_atm.c	Thu Jun 26 07:09:58 2003
@@ -512,7 +512,6 @@
 			memcpy(skb_push(skb,flow->hdr_len),flow->hdr,
 			    flow->hdr_len);
 			atomic_add(skb->truesize,&flow->vcc->sk->wmem_alloc);
-			ATM_SKB(skb)->iovcnt = 0;
 			/* atm.atm_options are already set by atm_tc_enqueue */
 			(void) flow->vcc->send(flow->vcc,skb);
 		}





[atm]: lock neighbor entry during update in clip.c


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1008  -> 1.1009 
#	      net/atm/clip.c	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/25	chas@relax.cmf.nrl.navy.mil	1.1009
# lock neighbor entry during update in clip.c
# --------------------------------------------
#
diff -Nru a/net/atm/clip.c b/net/atm/clip.c
--- a/net/atm/clip.c	Thu Jun 26 07:10:22 2003
+++ b/net/atm/clip.c	Thu Jun 26 07:10:22 2003
@@ -127,6 +127,8 @@
 			struct atmarp_entry *entry = NEIGH2ENTRY(n);
 			struct clip_vcc *clip_vcc;
 
+			write_lock(&n->lock);
+
 			for (clip_vcc = entry->vccs; clip_vcc;
 			    clip_vcc = clip_vcc->next)
 				if (clip_vcc->idle_timeout &&
@@ -141,6 +143,7 @@
 			if (entry->vccs ||
 			    time_before(jiffies, entry->expires)) {
 				np = &n->next;
+				write_unlock(&n->lock);
 				continue;
 			}
 			if (atomic_read(&n->refcnt) > 1) {
@@ -152,11 +155,13 @@
 				     NULL) 
 					dev_kfree_skb(skb);
 				np = &n->next;
+				write_unlock(&n->lock);
 				continue;
 			}
 			*np = n->next;
 			DPRINTK("expired neigh %p\n",n);
 			n->dead = 1;
+			write_unlock(&n->lock);
 			neigh_release(n);
 		}
 	}





[atm]: make sub skb->cb is clear before upcall to network

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1009  -> 1.1010 
#	       net/atm/lec.c	1.12    -> 1.13   
#	       net/atm/mpc.c	1.5     -> 1.6    
#	      net/atm/clip.c	1.6     -> 1.7    
#	    net/atm/br2684.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/26	chas@relax.cmf.nrl.navy.mil	1.1010
# mpc.c, lec.c, clip.c, br2684.c:
#   make sure skb->cb is clear before upcall to network
# --------------------------------------------
#
diff -Nru a/net/atm/br2684.c b/net/atm/br2684.c
--- a/net/atm/br2684.c	Thu Jun 26 20:08:14 2003
+++ b/net/atm/br2684.c	Thu Jun 26 20:08:14 2003
@@ -481,6 +481,7 @@
 	}
 	brdev->stats.rx_packets++;
 	brdev->stats.rx_bytes += skb->len;
+	memset(ATM_SKB(skb), 0, sizeof(struct atm_skb_data));
 	netif_rx(skb);
 }
 
diff -Nru a/net/atm/clip.c b/net/atm/clip.c
--- a/net/atm/clip.c	Thu Jun 26 20:08:14 2003
+++ b/net/atm/clip.c	Thu Jun 26 20:08:14 2003
@@ -223,6 +223,7 @@
 	clip_vcc->last_use = jiffies;
 	PRIV(skb->dev)->stats.rx_packets++;
 	PRIV(skb->dev)->stats.rx_bytes += skb->len;
+	memset(ATM_SKB(skb), 0, sizeof(struct atm_skb_data));
 	netif_rx(skb);
 }
 
diff -Nru a/net/atm/lec.c b/net/atm/lec.c
--- a/net/atm/lec.c	Thu Jun 26 20:08:14 2003
+++ b/net/atm/lec.c	Thu Jun 26 20:08:14 2003
@@ -724,6 +724,7 @@
                 skb->protocol = eth_type_trans(skb, dev);
                 priv->stats.rx_packets++;
                 priv->stats.rx_bytes += skb->len;
+                memset(ATM_SKB(skb), 0, sizeof(struct atm_skb_data));
                 netif_rx(skb);
         }
 }
diff -Nru a/net/atm/mpc.c b/net/atm/mpc.c
--- a/net/atm/mpc.c	Thu Jun 26 20:08:14 2003
+++ b/net/atm/mpc.c	Thu Jun 26 20:08:14 2003
@@ -729,6 +729,7 @@
 	eg->packets_rcvd++;
 	mpc->eg_ops->put(eg);
 
+	memset(ATM_SKB(new_skb), 0, sizeof(struct atm_skb_data));
 	netif_rx(new_skb);
 
 	return;





[atm]: eliminate ATM_PDU_OVHD, ops->free_rx_skb and ops->alloc_tx

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1010  -> 1.1011 
#	       net/atm/lec.c	1.13    -> 1.14   
#	 drivers/atm/lanai.c	1.2     -> 1.3    
#	       net/atm/mpc.c	1.6     -> 1.7    
#	include/linux/atmdev.h	1.7     -> 1.8    
#	       net/atm/raw.c	1.2     -> 1.3    
#	drivers/atm/idt77252.c	1.6     -> 1.7    
#	 net/atm/signaling.c	1.3     -> 1.4    
#	    net/atm/common.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/26	chas@relax.cmf.nrl.navy.mil	1.1011
# atmdev.h, lanai.c, idt77252.c, signaling.c, raw.c, mpc.c, lec.c, common.c:
#   eliminate ATM_PDU_OVHD, ops->free_rx_skb and ops->alloc_tx
# --------------------------------------------
#
diff -Nru a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
--- a/drivers/atm/idt77252.c	Thu Jun 26 20:08:40 2003
+++ b/drivers/atm/idt77252.c	Thu Jun 26 20:08:40 2003
@@ -2025,7 +2025,7 @@
 		atomic_inc(&vcc->stats->tx_err);
 		return -ENOMEM;
 	}
-	atomic_add(skb->truesize + ATM_PDU_OVHD, &vcc->sk->wmem_alloc);
+	atomic_add(skb->truesize, &vcc->sk->wmem_alloc);
 
 	memcpy(skb_put(skb, 52), cell, 52);
 
diff -Nru a/drivers/atm/lanai.c b/drivers/atm/lanai.c
--- a/drivers/atm/lanai.c	Thu Jun 26 20:08:40 2003
+++ b/drivers/atm/lanai.c	Thu Jun 26 20:08:40 2003
@@ -2842,7 +2842,6 @@
 	phy_get:	NULL,
 	feedback:	NULL,
 	change_qos:	lanai_change_qos,
-	free_rx_skb:	NULL,
 	proc_read:	lanai_proc_read
 };
 
diff -Nru a/include/linux/atmdev.h b/include/linux/atmdev.h
--- a/include/linux/atmdev.h	Thu Jun 26 20:08:40 2003
+++ b/include/linux/atmdev.h	Thu Jun 26 20:08:40 2003
@@ -30,9 +30,6 @@
 #define ATM_DS3_PCR	(8000*12)
 			/* DS3: 12 cells in a 125 usec time slot */
 
-#define ATM_PDU_OVHD	0	/* number of bytes to charge against buffer
-				   quota per PDU */
-
 #define ATM_SD(s)	((s)->sk->protinfo.af_atm)
 
 
@@ -292,10 +289,6 @@
 	struct atm_sap	sap;		/* SAP */
 	void (*push)(struct atm_vcc *vcc,struct sk_buff *skb);
 	void (*pop)(struct atm_vcc *vcc,struct sk_buff *skb); /* optional */
-	struct sk_buff *(*alloc_tx)(struct atm_vcc *vcc,unsigned int size);
-					/* TX allocation routine - can be */
-					/* modified by protocol or by driver.*/
-					/* NOTE: this interface will change */
 	int (*push_oam)(struct atm_vcc *vcc,void *cell);
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
 	void		*dev_data;	/* per-device data */
@@ -388,8 +381,6 @@
 	void (*feedback)(struct atm_vcc *vcc,struct sk_buff *skb,
 	    unsigned long start,unsigned long dest,int len);
 	int (*change_qos)(struct atm_vcc *vcc,struct atm_qos *qos,int flags);
-	void (*free_rx_skb)(struct atm_vcc *vcc, struct sk_buff *skb);
-		/* @@@ temporary hack */
 	int (*proc_read)(struct atm_dev *dev,loff_t *pos,char *page);
 	struct module *owner;
 };
@@ -430,19 +421,19 @@
 
 static __inline__ void atm_force_charge(struct atm_vcc *vcc,int truesize)
 {
-	atomic_add(truesize+ATM_PDU_OVHD,&vcc->sk->rmem_alloc);
+	atomic_add(truesize, &vcc->sk->rmem_alloc);
 }
 
 
 static __inline__ void atm_return(struct atm_vcc *vcc,int truesize)
 {
-	atomic_sub(truesize+ATM_PDU_OVHD,&vcc->sk->rmem_alloc);
+	atomic_sub(truesize, &vcc->sk->rmem_alloc);
 }
 
 
 static __inline__ int atm_may_send(struct atm_vcc *vcc,unsigned int size)
 {
-	return size+atomic_read(&vcc->sk->wmem_alloc)+ATM_PDU_OVHD < vcc->sk->sndbuf;
+	return (size + atomic_read(&vcc->sk->wmem_alloc)) < vcc->sk->sndbuf;
 }
 
 
diff -Nru a/net/atm/common.c b/net/atm/common.c
--- a/net/atm/common.c	Thu Jun 26 20:08:40 2003
+++ b/net/atm/common.c	Thu Jun 26 20:08:40 2003
@@ -99,7 +99,7 @@
 	}
 	while (!(skb = alloc_skb(size,GFP_KERNEL))) schedule();
 	DPRINTK("AlTx %d += %d\n",atomic_read(&vcc->sk->wmem_alloc),skb->truesize);
-	atomic_add(skb->truesize+ATM_PDU_OVHD,&vcc->sk->wmem_alloc);
+	atomic_add(skb->truesize, &vcc->sk->wmem_alloc);
 	return skb;
 }
 
@@ -115,7 +115,6 @@
 	vcc = sk->protinfo.af_atm;
 	memset(&vcc->flags,0,sizeof(vcc->flags));
 	vcc->dev = NULL;
-	vcc->alloc_tx = alloc_tx;
 	vcc->callback = NULL;
 	memset(&vcc->local,0,sizeof(struct sockaddr_atmsvc));
 	memset(&vcc->remote,0,sizeof(struct sockaddr_atmsvc));
@@ -147,9 +146,7 @@
 		if (vcc->push) vcc->push(vcc,NULL); /* atmarpd has no push */
 		while ((skb = skb_dequeue(&vcc->sk->receive_queue))) {
 			atm_return(vcc,skb->truesize);
-			if (vcc->dev->ops->free_rx_skb)
-				vcc->dev->ops->free_rx_skb(vcc,skb);
-			else kfree_skb(skb);
+			kfree_skb(skb);
 		}
 		spin_lock (&atm_dev_lock);	
 		fops_put (vcc->dev->ops);
@@ -398,8 +395,7 @@
 	DPRINTK("RcvM %d -= %d\n",atomic_read(&vcc->sk->rmem_alloc),skb->truesize);
 	atm_return(vcc,skb->truesize);
 	error = copy_to_user(buff,skb->data,eff_len) ? -EFAULT : 0;
-	if (!vcc->dev->ops->free_rx_skb) kfree_skb(skb);
-	else vcc->dev->ops->free_rx_skb(vcc, skb);
+	kfree_skb(skb);
 	return error ? error : eff_len;
 }
 
@@ -431,7 +427,7 @@
 	add_wait_queue(&vcc->sleep,&wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 	error = 0;
-	while (!(skb = vcc->alloc_tx(vcc,eff))) {
+	while (!(skb = alloc_tx(vcc,eff))) {
 		if (m->msg_flags & MSG_DONTWAIT) {
 			error = -EAGAIN;
 			break;
@@ -482,8 +478,7 @@
 		mask |= POLLHUP;
 	if (sock->state != SS_CONNECTING) {
 		if (vcc->qos.txtp.traffic_class != ATM_NONE &&
-		    vcc->qos.txtp.max_sdu+atomic_read(&vcc->sk->wmem_alloc)+
-		    ATM_PDU_OVHD <= vcc->sk->sndbuf)
+		    vcc->qos.txtp.max_sdu+atomic_read(&vcc->sk->wmem_alloc) <= vcc->sk->sndbuf)
 			mask |= POLLOUT | POLLWRNORM;
 	}
 	else if (vcc->reply != WAITING) {
@@ -550,7 +545,7 @@
 				goto done;
 			}
 			ret_val =  put_user(vcc->sk->sndbuf-
-			    atomic_read(&vcc->sk->wmem_alloc)-ATM_PDU_OVHD,
+			    atomic_read(&vcc->sk->wmem_alloc),
 			    (int *) arg) ? -EFAULT : 0;
 			goto done;
 		case SIOCINQ:
diff -Nru a/net/atm/lec.c b/net/atm/lec.c
--- a/net/atm/lec.c	Thu Jun 26 20:08:40 2003
+++ b/net/atm/lec.c	Thu Jun 26 20:08:40 2003
@@ -402,7 +402,7 @@
         int i;
         char *tmp; /* FIXME */
 
-	atomic_sub(skb->truesize+ATM_PDU_OVHD, &vcc->sk->wmem_alloc);
+	atomic_sub(skb->truesize, &vcc->sk->wmem_alloc);
         mesg = (struct atmlec_msg *)skb->data;
         tmp = skb->data;
         tmp += sizeof(struct atmlec_msg);
diff -Nru a/net/atm/mpc.c b/net/atm/mpc.c
--- a/net/atm/mpc.c	Thu Jun 26 20:08:40 2003
+++ b/net/atm/mpc.c	Thu Jun 26 20:08:40 2003
@@ -869,7 +869,7 @@
 	
 	struct mpoa_client *mpc = find_mpc_by_vcc(vcc);
 	struct k_message *mesg = (struct k_message*)skb->data;
-	atomic_sub(skb->truesize+ATM_PDU_OVHD, &vcc->sk->wmem_alloc);
+	atomic_sub(skb->truesize, &vcc->sk->wmem_alloc);
 	
 	if (mpc == NULL) {
 		printk("mpoa: msg_from_mpoad: no mpc found\n");
diff -Nru a/net/atm/raw.c b/net/atm/raw.c
--- a/net/atm/raw.c	Thu Jun 26 20:08:40 2003
+++ b/net/atm/raw.c	Thu Jun 26 20:08:40 2003
@@ -37,7 +37,7 @@
 static void atm_pop_raw(struct atm_vcc *vcc,struct sk_buff *skb)
 {
 	DPRINTK("APopR (%d) %d -= %d\n",vcc->vci,vcc->sk->wmem_alloc,skb->truesize);
-	atomic_sub(skb->truesize+ATM_PDU_OVHD,&vcc->sk->wmem_alloc);
+	atomic_sub(skb->truesize, &vcc->sk->wmem_alloc);
 	dev_kfree_skb_any(skb);
 	wake_up(&vcc->sleep);
 }
diff -Nru a/net/atm/signaling.c b/net/atm/signaling.c
--- a/net/atm/signaling.c	Thu Jun 26 20:08:40 2003
+++ b/net/atm/signaling.c	Thu Jun 26 20:08:40 2003
@@ -98,7 +98,7 @@
 	struct atm_vcc *session_vcc;
 
 	msg = (struct atmsvc_msg *) skb->data;
-	atomic_sub(skb->truesize+ATM_PDU_OVHD,&vcc->sk->wmem_alloc);
+	atomic_sub(skb->truesize, &vcc->sk->wmem_alloc);
 	DPRINTK("sigd_send %d (0x%lx)\n",(int) msg->type,
 	  (unsigned long) msg->vcc);
 	vcc = *(struct atm_vcc **) &msg->vcc;





[atm]: make clip buildable as a module

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1011  -> 1.1012 
#	    net/atm/Makefile	1.4     -> 1.5    
#	       net/Config.in	1.10    -> 1.11   
#	      net/atm/proc.c	1.5     -> 1.6    
#	       net/atm/pvc.c	1.2     -> 1.3    
#	  net/atm/ipcommon.c	1.1     -> 1.2    
#	       net/netsyms.c	1.35    -> 1.36   
#	      net/atm/clip.c	1.7     -> 1.8    
#	include/net/atmclip.h	1.1     -> 1.2    
#	      net/ipv4/arp.c	1.10    -> 1.11   
#	    net/atm/common.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/26	chas@relax.cmf.nrl.navy.mil	1.1012
# make clip buildable as a module
# --------------------------------------------
#
diff -Nru a/include/net/atmclip.h b/include/net/atmclip.h
--- a/include/net/atmclip.h	Thu Jun 26 20:09:05 2003
+++ b/include/net/atmclip.h	Thu Jun 26 20:09:05 2003
@@ -55,13 +55,22 @@
 };
 
 
-extern struct atm_vcc *atmarpd; /* ugly */
-extern struct neigh_table clip_tbl;
+#ifdef __KERNEL__
+struct atm_clip_ops {
+	int (*clip_create)(int number);
+	int (*clip_mkip)(struct atm_vcc *vcc,int timeout);
+	int (*clip_setentry)(struct atm_vcc *vcc,u32 ip);
+	int (*clip_encap)(struct atm_vcc *vcc,int mode);
+	void (*clip_push)(struct atm_vcc *vcc,struct sk_buff *skb);
+	int (*atm_init_atmarp)(struct atm_vcc *vcc);
+	struct module *owner;
+};
 
-int clip_create(int number);
-int clip_mkip(struct atm_vcc *vcc,int timeout);
-int clip_setentry(struct atm_vcc *vcc,u32 ip);
-int clip_encap(struct atm_vcc *vcc,int mode);
-void atm_clip_init(void);
+void atm_clip_ops_set(struct atm_clip_ops *);
+int try_atm_clip_ops(void);
+
+extern struct neigh_table *clip_tbl_hook;
+extern struct atm_clip_ops *atm_clip_ops;
+#endif
 
 #endif
diff -Nru a/net/Config.in b/net/Config.in
--- a/net/Config.in	Thu Jun 26 20:09:05 2003
+++ b/net/Config.in	Thu Jun 26 20:09:05 2003
@@ -34,8 +34,8 @@
    bool 'Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)' CONFIG_ATM
    if [ "$CONFIG_ATM" = "y" ]; then
       if [ "$CONFIG_INET" = "y" ]; then
-	 bool '  Classical IP over ATM' CONFIG_ATM_CLIP
-	 if [ "$CONFIG_ATM_CLIP" = "y" ]; then
+	 tristate '  Classical IP over ATM' CONFIG_ATM_CLIP
+	 if [ "$CONFIG_ATM_CLIP" != "n" ]; then
 	    bool '    Do NOT send ICMP if no neighbour' CONFIG_ATM_CLIP_NO_ICMP
 	 fi
       fi
diff -Nru a/net/atm/Makefile b/net/atm/Makefile
--- a/net/atm/Makefile	Thu Jun 26 20:09:05 2003
+++ b/net/atm/Makefile	Thu Jun 26 20:09:05 2003
@@ -16,10 +16,10 @@
 
 obj-$(CONFIG_ATM) := addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o
 
-ifeq ($(CONFIG_ATM_CLIP),y)
-obj-y += clip.o
-NEED_IPCOM = ipcommon.o
+ifneq ($(CONFIG_ATM_CLIP),n)
+  NEED_IPCOM = ipcommon.o
 endif
+obj-$(CONFIG_ATM_CLIP) += clip.o
 
 ifeq ($(CONFIG_ATM_BR2684),y)
   NEED_IPCOM = ipcommon.o
diff -Nru a/net/atm/clip.c b/net/atm/clip.c
--- a/net/atm/clip.c	Thu Jun 26 20:09:05 2003
+++ b/net/atm/clip.c	Thu Jun 26 20:09:05 2003
@@ -7,6 +7,8 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/kernel.h> /* for UINT_MAX */
+#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/wait.h>
@@ -45,6 +47,7 @@
 
 struct net_device *clip_devs = NULL;
 struct atm_vcc *atmarpd = NULL;
+static struct neigh_table clip_tbl;
 static struct timer_list idle_timer;
 static int start_timer = 1;
 
@@ -187,7 +190,7 @@
 }
 
 
-void clip_push(struct atm_vcc *vcc,struct sk_buff *skb)
+static void clip_push(struct atm_vcc *vcc,struct sk_buff *skb)
 {
 	struct clip_vcc *clip_vcc = CLIP_VCC(vcc);
 
@@ -325,7 +328,7 @@
 }
 
 
-struct neigh_table clip_tbl = {
+static struct neigh_table clip_tbl = {
 	NULL,			/* next */
 	AF_INET,		/* family */
 	sizeof(struct neighbour)+sizeof(struct atmarp_entry), /* entry_size */
@@ -371,7 +374,7 @@
  */
 
 
-int clip_encap(struct atm_vcc *vcc,int mode)
+static int clip_encap(struct atm_vcc *vcc,int mode)
 {
 	CLIP_VCC(vcc)->encap = mode;
 	return 0;
@@ -468,7 +471,7 @@
 }
 
 
-int clip_mkip(struct atm_vcc *vcc,int timeout)
+static int clip_mkip(struct atm_vcc *vcc,int timeout)
 {
 	struct clip_vcc *clip_vcc;
 	struct sk_buff_head copy;
@@ -508,7 +511,7 @@
 }
 
 
-int clip_setentry(struct atm_vcc *vcc,u32 ip)
+static int clip_setentry(struct atm_vcc *vcc,u32 ip)
 {
 	struct neighbour *neigh;
 	struct atmarp_entry *entry;
@@ -580,7 +583,7 @@
 }
 
 
-int clip_create(int number)
+static int clip_create(int number)
 {
 	struct net_device *dev;
 	struct clip_priv *clip_priv;
@@ -700,28 +703,23 @@
 		    "pending\n");
 	skb_queue_purge(&vcc->sk->receive_queue);
 	DPRINTK("(done)\n");
+	MOD_DEC_USE_COUNT;
 }
 
 
 static struct atmdev_ops atmarpd_dev_ops = {
-	close:	atmarpd_close,
+	.close = atmarpd_close,
 };
 
 
 static struct atm_dev atmarpd_dev = {
-	&atmarpd_dev_ops,
-	NULL,		/* no PHY */
-	"arpd",		/* type */
-	999,		/* dummy device number */
-	NULL,NULL,	/* pretend not to have any VCCs */
-	NULL,NULL,	/* no data */
-	{ 0 },		/* no flags */
-	NULL,		/* no local address */
-	{ 0 }		/* no ESI, no statistics */
+	.ops =			&atmarpd_dev_ops,
+	.type =			"arpd",
+	.number =		999,
 };
 
 
-int atm_init_atmarp(struct atm_vcc *vcc)
+static int atm_init_atmarp(struct atm_vcc *vcc)
 {
 	struct net_device *dev;
 
@@ -748,13 +746,61 @@
 	for (dev = clip_devs; dev; dev = PRIV(dev)->next)
 		if (dev->flags & IFF_UP)
 			(void) to_atmarpd(act_up,PRIV(dev)->number,0);
+	MOD_INC_USE_COUNT;
 	return 0;
 }
 
+static struct atm_clip_ops __atm_clip_ops = {
+	.clip_create =		clip_create,
+	.clip_mkip =		clip_mkip,
+	.clip_setentry =	clip_setentry,
+	.clip_encap =		clip_encap,
+	.clip_push =		clip_push,
+	.atm_init_atmarp =	atm_init_atmarp,
+	.owner =		THIS_MODULE
+};
 
-void atm_clip_init(void)
+static int __init atm_clip_init(void)
 {
+	/* we should use neigh_table_init() */
 	clip_tbl.lock = RW_LOCK_UNLOCKED;
 	clip_tbl.kmem_cachep = kmem_cache_create(clip_tbl.id,
 	    clip_tbl.entry_size, 0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+
+	/* so neigh_ifdown() doesn't complain */
+	clip_tbl.proxy_timer.data = 0;
+	clip_tbl.proxy_timer.function = 0;
+	init_timer(&clip_tbl.proxy_timer);
+	skb_queue_head_init(&clip_tbl.proxy_queue);
+
+	clip_tbl_hook = &clip_tbl;
+	atm_clip_ops_set(&__atm_clip_ops);
+
+	return 0;
+}
+
+static void __exit atm_clip_exit(void)
+{
+	struct net_device *dev, *next;
+
+	atm_clip_ops_set(NULL);
+
+	neigh_ifdown(&clip_tbl, NULL);
+	dev = clip_devs;
+	while (dev) {
+		next = PRIV(dev)->next;
+		unregister_netdev(dev);
+		kfree(dev);
+		dev = next;
+	}
+	if (start_timer == 0) del_timer(&idle_timer);
+
+	kmem_cache_destroy(clip_tbl.kmem_cachep);
+
+	clip_tbl_hook = NULL;
 }
+
+module_init(atm_clip_init);
+module_exit(atm_clip_exit);
+
+MODULE_LICENSE("GPL");
diff -Nru a/net/atm/common.c b/net/atm/common.c
--- a/net/atm/common.c	Thu Jun 26 20:09:05 2003
+++ b/net/atm/common.c	Thu Jun 26 20:09:05 2003
@@ -58,6 +58,36 @@
 #endif
 #endif
 
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+#include <net/atmclip.h>
+struct atm_clip_ops *atm_clip_ops;
+static DECLARE_MUTEX(atm_clip_ops_mutex);
+
+void atm_clip_ops_set(struct atm_clip_ops *hook)
+{
+	down(&atm_clip_ops_mutex);
+	atm_clip_ops = hook;
+	up(&atm_clip_ops_mutex);
+}
+
+int try_atm_clip_ops(void)
+{
+	down(&atm_clip_ops_mutex);
+	if (atm_clip_ops && try_inc_mod_count(atm_clip_ops->owner)) {
+		up(&atm_clip_ops_mutex);
+		return 1;
+	}
+	up(&atm_clip_ops_mutex);
+	return 0;
+}
+
+#ifdef CONFIG_ATM_CLIP_MODULE
+EXPORT_SYMBOL(atm_clip_ops);
+EXPORT_SYMBOL(atm_clip_ops_mutex);
+EXPORT_SYMBOL(atm_clip_ops_set);
+#endif
+#endif
+
 #if defined(CONFIG_PPPOATM) || defined(CONFIG_PPPOATM_MODULE)
 int (*pppoatm_ioctl_hook)(struct atm_vcc *, unsigned int, unsigned long);
 EXPORT_SYMBOL(pppoatm_ioctl_hook);
@@ -626,39 +656,68 @@
 			if (!error) sock->state = SS_CONNECTED;
 			ret_val = error;
 			goto done;
-#ifdef CONFIG_ATM_CLIP
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 		case SIOCMKCLIP:
-			if (!capable(CAP_NET_ADMIN))
+			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
-			else 
-				ret_val = clip_create(arg);
+				goto done;
+			}
+			if (try_atm_clip_ops()) {
+				ret_val = atm_clip_ops->clip_create(arg);
+				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+			} else
+				ret_val = -ENOSYS;
 			goto done;
 		case ATMARPD_CTRL:
 			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
 				goto done;
 			}
-			error = atm_init_atmarp(vcc);
-			if (!error) sock->state = SS_CONNECTED;
-			ret_val = error;
+#if defined(CONFIG_ATM_CLIP_MODULE)
+			if (!atm_clip_ops)
+				request_module("clip");
+#endif
+			if (try_atm_clip_ops()) {
+				error = atm_clip_ops->atm_init_atmarp(vcc);
+				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+				if (!error)
+					sock->state = SS_CONNECTED;
+				ret_val = error;
+			} else
+				ret_val = -ENOSYS;
 			goto done;
 		case ATMARP_MKIP:
-			if (!capable(CAP_NET_ADMIN)) 
+			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
-			else 
-				ret_val = clip_mkip(vcc,arg);
+				goto done;
+			}
+			if (try_atm_clip_ops()) {
+				ret_val = atm_clip_ops->clip_mkip(vcc, arg);
+				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+			} else
+				ret_val = -ENOSYS;
 			goto done;
 		case ATMARP_SETENTRY:
-			if (!capable(CAP_NET_ADMIN)) 
+			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
-			else
-				ret_val = clip_setentry(vcc,arg);
+				goto done;
+			}
+			if (try_atm_clip_ops()) {
+				ret_val = atm_clip_ops->clip_setentry(vcc, arg);
+				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+			} else
+				ret_val = -ENOSYS;
 			goto done;
 		case ATMARP_ENCAP:
-			if (!capable(CAP_NET_ADMIN)) 
+			if (!capable(CAP_NET_ADMIN)) {
 				ret_val = -EPERM;
-			else
-				ret_val = clip_encap(vcc,arg);
+				goto done;
+			}
+			if (try_atm_clip_ops()) {
+				ret_val = atm_clip_ops->clip_encap(vcc, arg);
+				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
+			} else
+				ret_val = -ENOSYS;
 			goto done;
 #endif
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
diff -Nru a/net/atm/ipcommon.c b/net/atm/ipcommon.c
--- a/net/atm/ipcommon.c	Thu Jun 26 20:09:05 2003
+++ b/net/atm/ipcommon.c	Thu Jun 26 20:09:05 2003
@@ -67,4 +67,5 @@
 }
 
 
+EXPORT_SYMBOL(llc_oui);
 EXPORT_SYMBOL(skb_migrate);
diff -Nru a/net/atm/proc.c b/net/atm/proc.c
--- a/net/atm/proc.c	Thu Jun 26 20:09:05 2003
+++ b/net/atm/proc.c	Thu Jun 26 20:09:05 2003
@@ -39,10 +39,9 @@
 #include "common.h" /* atm_proc_init prototype */
 #include "signaling.h" /* to get sigd - ugly too */
 
-#ifdef CONFIG_ATM_CLIP
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 #include <net/atmclip.h>
 #include "ipcommon.h"
-extern void clip_push(struct atm_vcc *vcc,struct sk_buff *skb);
 #endif
 
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
@@ -89,7 +88,7 @@
 }
 
 
-#ifdef CONFIG_ATM_CLIP
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 
 
 static int svc_addr(char *buf,struct sockaddr_atmsvc *addr)
@@ -178,16 +177,21 @@
 	    aal_name[vcc->qos.aal],vcc->qos.rxtp.min_pcr,
 	    class_name[vcc->qos.rxtp.traffic_class],vcc->qos.txtp.min_pcr,
 	    class_name[vcc->qos.txtp.traffic_class]);
-#ifdef CONFIG_ATM_CLIP
-	if (vcc->push == clip_push) {
-		struct clip_vcc *clip_vcc = CLIP_VCC(vcc);
-		struct net_device *dev;
-
-		dev = clip_vcc->entry ? clip_vcc->entry->neigh->dev : NULL;
-		off += sprintf(buf+off,"CLIP, Itf:%s, Encap:",
-		    dev ? dev->name : "none?");
-		if (clip_vcc->encap) off += sprintf(buf+off,"LLC/SNAP");
-		else off += sprintf(buf+off,"None");
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+	if (try_atm_clip_ops()) {
+		if (vcc->push == atm_clip_ops->clip_push) {
+			struct clip_vcc *clip_vcc = CLIP_VCC(vcc);
+			struct net_device *dev;
+
+			dev = clip_vcc->entry ? clip_vcc->entry->neigh->dev : NULL;
+			off += sprintf(buf+off,"CLIP, Itf:%s, Encap:",
+			    dev ? dev->name : "none?");
+			if (clip_vcc->encap)
+				off += sprintf(buf+off,"LLC/SNAP");
+			else
+				off += sprintf(buf+off,"None");
+		}
+		__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 	}
 #endif
 	strcpy(buf+off,"\n");
@@ -407,7 +411,7 @@
 	return 0;
 }
 
-#ifdef CONFIG_ATM_CLIP
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 static int atm_arp_info(loff_t pos,char *buf)
 {
 	struct neighbour *n;
@@ -417,28 +421,33 @@
 		return sprintf(buf,"IPitf TypeEncp Idle IP address      "
 		    "ATM address\n");
 	}
+	if (!try_atm_clip_ops())
+		return 0;
 	count = pos;
-	read_lock_bh(&clip_tbl.lock);
+	read_lock_bh(&clip_tbl_hook->lock);
 	for (i = 0; i <= NEIGH_HASHMASK; i++)
-		for (n = clip_tbl.hash_buckets[i]; n; n = n->next) {
+		for (n = clip_tbl_hook->hash_buckets[i]; n; n = n->next) {
 			struct atmarp_entry *entry = NEIGH2ENTRY(n);
 			struct clip_vcc *vcc;
 
 			if (!entry->vccs) {
 				if (--count) continue;
 				atmarp_info(n->dev,entry,NULL,buf);
-				read_unlock_bh(&clip_tbl.lock);
+				read_unlock_bh(&clip_tbl_hook->lock);
+				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 				return strlen(buf);
 			}
 			for (vcc = entry->vccs; vcc;
 			    vcc = vcc->next) {
 				if (--count) continue;
 				atmarp_info(n->dev,entry,vcc,buf);
-				read_unlock_bh(&clip_tbl.lock);
+				read_unlock_bh(&clip_tbl_hook->lock);
+				__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 				return strlen(buf);
 			}
 		}
-	read_unlock_bh(&clip_tbl.lock);
+	read_unlock_bh(&clip_tbl_hook->lock);
+	__MOD_DEC_USE_COUNT(atm_clip_ops->owner);
 	return 0;
 }
 #endif
@@ -612,7 +621,7 @@
 	CREATE_ENTRY(pvc);
 	CREATE_ENTRY(svc);
 	CREATE_ENTRY(vc);
-#ifdef CONFIG_ATM_CLIP
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 	CREATE_ENTRY(arp);
 #endif
 #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
diff -Nru a/net/atm/pvc.c b/net/atm/pvc.c
--- a/net/atm/pvc.c	Thu Jun 26 20:09:05 2003
+++ b/net/atm/pvc.c	Thu Jun 26 20:09:05 2003
@@ -8,16 +8,12 @@
 				   struct proto_ops */
 #include <linux/atm.h>		/* ATM stuff */
 #include <linux/atmdev.h>	/* ATM devices */
-#include <linux/atmclip.h>	/* Classical IP over ATM */
 #include <linux/errno.h>	/* error codes */
 #include <linux/kernel.h>	/* printk */
 #include <linux/init.h>
 #include <linux/skbuff.h>
 #include <linux/bitops.h>
 #include <net/sock.h>		/* for sock_no_* */
-#ifdef CONFIG_ATM_CLIP
-#include <net/atmclip.h>
-#endif
 
 #include "resources.h"		/* devs and vccs */
 #include "common.h"		/* common for PVCs and SVCs */
@@ -133,9 +129,6 @@
 		printk(KERN_ERR "ATMPVC: can't register (%d)",error);
 		return error;
 	}
-#ifdef CONFIG_ATM_CLIP
-	atm_clip_init();
-#endif
 #ifdef CONFIG_PROC_FS
 	error = atm_proc_init();
 	if (error) printk("atm_proc_init fails with %d\n",error);
diff -Nru a/net/ipv4/arp.c b/net/ipv4/arp.c
--- a/net/ipv4/arp.c	Thu Jun 26 20:09:05 2003
+++ b/net/ipv4/arp.c	Thu Jun 26 20:09:05 2003
@@ -105,8 +105,9 @@
 #include <net/netrom.h>
 #endif
 #endif
-#ifdef CONFIG_ATM_CLIP
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
 #include <net/atmclip.h>
+struct neigh_table *clip_tbl_hook;
 #endif
 
 #include <asm/system.h>
@@ -438,8 +439,8 @@
 		if (dev->flags&(IFF_LOOPBACK|IFF_POINTOPOINT))
 			nexthop = 0;
 		n = __neigh_lookup_errno(
-#ifdef CONFIG_ATM_CLIP
-		    dev->type == ARPHRD_ATM ? &clip_tbl :
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+		    dev->type == ARPHRD_ATM ? clip_tbl_hook :
 #endif
 		    &arp_tbl, &nexthop, dev);
 		if (IS_ERR(n))
diff -Nru a/net/netsyms.c b/net/netsyms.c
--- a/net/netsyms.c	Thu Jun 26 20:09:05 2003
+++ b/net/netsyms.c	Thu Jun 26 20:09:05 2003
@@ -45,6 +45,9 @@
 #include <linux/ip.h>
 #include <net/protocol.h>
 #include <net/arp.h>
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+#include <net/atmclip.h>
+#endif
 #include <net/ip.h>
 #include <net/udp.h>
 #include <net/tcp.h>
@@ -461,6 +464,9 @@
 EXPORT_SYMBOL(ip_rcv);
 EXPORT_SYMBOL(arp_rcv);
 EXPORT_SYMBOL(arp_tbl);
+#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
+EXPORT_SYMBOL(clip_tbl_hook);
+#endif
 EXPORT_SYMBOL(arp_find);
 
 #endif  /* CONFIG_INET */
