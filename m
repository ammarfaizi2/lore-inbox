Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263525AbTH2VZg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 17:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTH2VZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 17:25:36 -0400
Received: from femail21.im.home.ne.jp ([203.165.11.236]:44440 "EHLO
	femail21.im.home.ne.jp") by vger.kernel.org with ESMTP
	id S263525AbTH2VZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 17:25:11 -0400
Message-ID: <3F4FC4CF.7080208@jcom.home.ne.jp>
Date: Sat, 30 Aug 2003 06:25:35 +0900
From: Yusuf Wilajati Purna <purna@jcom.home.ne.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
CC: purna@sm.sony.co.jp
Subject: [PATCH] fix skb binding time in some network drivers due to skb_padto
 conversion
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that skb_padto security fixes in 2.4 and 2.5 trying
to fix "CAN-2003-0001:Multiple ethernet NID device drivers
do not pad frames with null bytes", do not put the skb_padto
blocks in proper places in the  3c527, eth16i, fmv18x, seeq8005,
yellowfin device drivers.   

In case a driver calls skb_padto(), it is possible
that the space available in the original skb buffer tailroom is less
than the space to pad. In this case, in short, the skb_padto()
will create a new skb buffer, copy data from the original
skb buffer to a new skb buffer, free the original buffer,
and finally return the new buffer.

If this happens to the aforementioned device drivers, they come to
point to wrong data. And, for 3c527 and yellowfin, the drivers can
unexpectedly double free the original skb buffers since they still
point to the original skb buffers. The attached patch against
2.4.23pre1 fixes these issues.

If the patch looks okay, please consider including it in
2.4 and 2.5/6.

Regards,

purna@sm.sony.co.jp


--------------------------------------------------------------------
diff -uNr linux-2.4/drivers/net/3c527.c linux-2.4b/drivers/net/3c527.c
--- linux-2.4/drivers/net/3c527.c       Fri Aug 29 04:00:19 2003
+++ linux-2.4b/drivers/net/3c527.c      Sat Aug 30 00:44:47 2003
@@ -1083,15 +1083,16 @@
        /* NP is the buffer we will be loading */
        np=lp->tx_ring[lp->tx_ring_head].p; 
 
-       /* We will need this to flush the buffer out */
-       lp->tx_ring[lp->tx_ring_head].skb=skb;
-          
        if(skb->len < ETH_ZLEN)
        {
                skb = skb_padto(skb, ETH_ZLEN);
                if(skb == NULL)
                        goto out;
        }
+
+       /* We will need this to flush the buffer out */
+       lp->tx_ring[lp->tx_ring_head].skb=skb;
+
        np->length = (skb->len < ETH_ZLEN) ? ETH_ZLEN : skb->len; 
                        
        np->data        = virt_to_bus(skb->data);
diff -uNr linux-2.4/drivers/net/eth16i.c linux-2.4b/drivers/net/eth16i.c
--- linux-2.4/drivers/net/eth16i.c      Tue Feb  4 04:00:34 2003
+++ linux-2.4b/drivers/net/eth16i.c     Sat Aug 30 00:10:33 2003
@@ -1057,7 +1057,7 @@
        int ioaddr = dev->base_addr;
        int status = 0;
        ushort length = skb->len;
-       unsigned char *buf = skb->data;
+       unsigned char *buf;
        unsigned long flags;
 
        if(length < ETH_ZLEN)
@@ -1067,6 +1067,7 @@
                        return 0;
                length = ETH_ZLEN;
        }
+       buf = skb->data;
 
        netif_stop_queue(dev);
                
diff -uNr linux-2.4/drivers/net/fmv18x.c linux-2.4b/drivers/net/fmv18x.c
--- linux-2.4/drivers/net/fmv18x.c      Tue Feb  4 04:00:34 2003
+++ linux-2.4b/drivers/net/fmv18x.c     Sat Aug 30 00:12:06 2003
@@ -370,7 +370,7 @@
        struct net_local *lp = dev->priv;
        int ioaddr = dev->base_addr;
        short length = skb->len;
-       unsigned char *buf = skb->data;
+       unsigned char *buf;
        unsigned long flags;
 
        /* Block a transmit from overlapping.  */
@@ -389,6 +389,7 @@
                        return 0;
                length = ETH_ZLEN;
        }
+       buf = skb->data;
        
        if (net_debug > 4)
                printk("%s: Transmitting a packet of length %lu.\n", dev->name,
diff -uNr linux-2.4/drivers/net/seeq8005.c linux-2.4b/drivers/net/seeq8005.c
--- linux-2.4/drivers/net/seeq8005.c    Tue Feb  4 04:00:34 2003
+++ linux-2.4b/drivers/net/seeq8005.c   Sat Aug 30 00:13:27 2003
@@ -379,7 +379,7 @@
 {
        struct net_local *lp = (struct net_local *)dev->priv;
        short length = skb->len;
-       unsigned char *buf = skb->data;
+       unsigned char *buf;
 
        if(length < ETH_ZLEN)
        {
@@ -388,6 +388,8 @@
                        return 0;
                length = ETH_ZLEN;
        }
+       buf = skb->data;
+
        /* Block a timer-based transmit from overlapping */
        netif_stop_queue(dev);
        
diff -uNr linux-2.4/drivers/net/yellowfin.c linux-2.4b/drivers/net/yellowfin.c
--- linux-2.4/drivers/net/yellowfin.c   Tue Feb  4 04:00:34 2003
+++ linux-2.4b/drivers/net/yellowfin.c  Sat Aug 30 00:26:57 2003
@@ -867,8 +867,6 @@
        /* Calculate the next Tx descriptor entry. */
        entry = yp->cur_tx % TX_RING_SIZE;
 
-       yp->tx_skbuff[entry] = skb;
-
        if (gx_fix) {   /* Note: only works for paddable protocols e.g.  IP. */
                int cacheline_end = ((unsigned long)skb->data + skb->len) % 32;
                /* Fix GX chipset errata. */
@@ -885,6 +883,8 @@
                        return 0;
                }
        }
+       yp->tx_skbuff[entry] = skb;
+
 #ifdef NO_TXSTATS
        yp->tx_ring[entry].addr = cpu_to_le32(pci_map_single(yp->pci_dev, 
                skb->data, len, PCI_DMA_TODEVICE));





