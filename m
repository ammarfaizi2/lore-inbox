Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWJBOua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWJBOua (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 10:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWJBOua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 10:50:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33002 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932501AbWJBOu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 10:50:29 -0400
Subject: Re: [PATCH] Introduce BROKEN_ON_64BIT facility
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: chas3@users.sourceforge.net
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de, mac@melware.de,
       markus.lidel@shadowconnect.com, samuel@sortiz.org,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       Greg KH <greg@kroah.com>, thomas@winischhofer.net, ak@suse.de
In-Reply-To: <200610021352.k92DqRwa015220@cmf.nrl.navy.mil>
References: <200610021352.k92DqRwa015220@cmf.nrl.navy.mil>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 16:12:35 +0100
Message-Id: <1159801956.8907.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-02 am 09:52 -0400, ysgrifennodd chas williams -
CONTRACTOR:
> some of the drivers in atm are already marked with !64BIT and some
> need to be marked.  this might be more complete for drivers/atm/Kconfig:

This should fix Iphase for one. Some of the others look a lot harder
however

Signed-off-by: Alan Cox <alan@redhat.com>

Binary files linux.vanilla-2.6.18-mm2/drivers/atm/fore200e_mkfirm and linux-2.6.18-mm2/drivers/atm/fore200e_mkfirm differ
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/atm/iphase.c linux-2.6.18-mm2/drivers/atm/iphase.c
--- linux.vanilla-2.6.18-mm2/drivers/atm/iphase.c	2006-09-20 04:42:06.000000000 +0100
+++ linux-2.6.18-mm2/drivers/atm/iphase.c	2006-10-02 15:28:51.678220488 +0100
@@ -93,10 +93,6 @@
 
 MODULE_LICENSE("GPL");
 
-#if BITS_PER_LONG != 32
-#  error FIXME: this driver only works on 32-bit platforms
-#endif
-
 /**************************** IA_LIB **********************************/
 
 static void ia_init_rtn_q (IARTN_Q *que) 
@@ -1408,7 +1404,6 @@
 	struct abr_vc_table  *abr_vc_table; 
 	u16 *vc_table;  
 	u16 *reass_table;  
-        u16 *ptr16;
 	int i,j, vcsize_sel;  
 	u_short freeq_st_adr;  
 	u_short *freeq_start;  
@@ -1423,14 +1418,15 @@
 		printk(KERN_ERR DEV_LABEL "can't allocate DLEs\n");
 		goto err_out;
 	}
-	iadev->rx_dle_q.start = (struct dle*)dle_addr;  
+	iadev->rx_dle_q.start = (struct dle *)dle_addr;
 	iadev->rx_dle_q.read = iadev->rx_dle_q.start;  
 	iadev->rx_dle_q.write = iadev->rx_dle_q.start;  
-	iadev->rx_dle_q.end = (struct dle*)((u32)dle_addr+sizeof(struct dle)*DLE_ENTRIES);  
+	iadev->rx_dle_q.end = (struct dle*)((unsigned long)dle_addr+sizeof(struct dle)*DLE_ENTRIES);
 	/* the end of the dle q points to the entry after the last  
 	DLE that can be used. */  
   
 	/* write the upper 20 bits of the start address to rx list address register */  
+	/* We know this is 32bit bus addressed so the following is safe */
 	writel(iadev->rx_dle_dma & 0xfffff000,
 	       iadev->dma + IPHASE5575_RX_LIST_ADDR);  
 	IF_INIT(printk("Tx Dle list addr: 0x%08x value: 0x%0x\n", 
@@ -1584,11 +1580,12 @@
 	   Set Packet Aging Interval count register to overflow in about 4 us
  	*/  
         writew(0xF6F8, iadev->reass_reg+PKT_TM_CNT );
-        ptr16 = (u16*)j;
-        i = ((u32)ptr16 >> 6) & 0xff;
-	ptr16  += j - 1;
-	i |=(((u32)ptr16 << 2) & 0xff00);
+        
+        i = (j >> 6) & 0xFF;
+        j += 2 * (j - 1);
+        i |= ((j << 2) & 0xFF00);
         writew(i, iadev->reass_reg+TMOUT_RANGE);
+
         /* initiate the desc_tble */
         for(i=0; i<iadev->num_tx_desc;i++)
             iadev->desc_tbl[i].timestamp = 0;
@@ -1911,7 +1908,7 @@
 	iadev->tx_dle_q.start = (struct dle*)dle_addr;  
 	iadev->tx_dle_q.read = iadev->tx_dle_q.start;  
 	iadev->tx_dle_q.write = iadev->tx_dle_q.start;  
-	iadev->tx_dle_q.end = (struct dle*)((u32)dle_addr+sizeof(struct dle)*DLE_ENTRIES);  
+	iadev->tx_dle_q.end = (struct dle*)((unsigned long)dle_addr+sizeof(struct dle)*DLE_ENTRIES);  
 
 	/* write the upper 20 bits of the start address to tx list address register */  
 	writel(iadev->tx_dle_dma & 0xfffff000,
@@ -2913,7 +2910,7 @@
                  dev_kfree_skb_any(skb);
           return 0;
         }
-        if ((u32)skb->data & 3) {
+        if ((unsigned long)skb->data & 3) {
            printk("Misaligned SKB\n");
            if (vcc->pop)
                  vcc->pop(vcc, skb);

