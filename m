Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWJBPS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWJBPS5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWJBPS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:18:57 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:47823 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S964775AbWJBPSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:18:55 -0400
Date: Mon, 2 Oct 2006 09:18:53 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: chas3@users.sourceforge.net, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, kkeil@suse.de, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de, mac@melware.de,
       markus.lidel@shadowconnect.com, samuel@sortiz.org,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       Greg KH <greg@kroah.com>, thomas@winischhofer.net, ak@suse.de
Subject: Re: [PATCH] Introduce BROKEN_ON_64BIT facility
Message-ID: <20061002151853.GK16272@parisc-linux.org>
References: <200610021352.k92DqRwa015220@cmf.nrl.navy.mil> <1159801956.8907.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159801956.8907.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 04:12:35PM +0100, Alan Cox wrote:
> @@ -1423,14 +1418,15 @@
>  		printk(KERN_ERR DEV_LABEL "can't allocate DLEs\n");
>  		goto err_out;
>  	}
> -	iadev->rx_dle_q.start = (struct dle*)dle_addr;  
> +	iadev->rx_dle_q.start = (struct dle *)dle_addr;
>  	iadev->rx_dle_q.read = iadev->rx_dle_q.start;  
>  	iadev->rx_dle_q.write = iadev->rx_dle_q.start;  
> -	iadev->rx_dle_q.end = (struct dle*)((u32)dle_addr+sizeof(struct dle)*DLE_ENTRIES);  
> +	iadev->rx_dle_q.end = (struct dle*)((unsigned long)dle_addr+sizeof(struct dle)*DLE_ENTRIES);
>  	/* the end of the dle q points to the entry after the last  
>  	DLE that can be used. */  

dle_addr is a bit strange.  How about:

+++ b/drivers/atm/iphase.c
@@ -1404,7 +1404,7 @@ static int rx_init(struct atm_dev *dev) 
        IADEV *iadev;  
        struct rx_buf_desc __iomem *buf_desc_ptr;  
        unsigned long rx_pkt_start = 0;  
-       void *dle_addr;  
+       struct dle *dle_addr;  
        struct abr_vc_table  *abr_vc_table; 
        u16 *vc_table;  
        u16 *reass_table;  
@@ -1423,10 +1423,10 @@ static int rx_init(struct atm_dev *dev) 
                printk(KERN_ERR DEV_LABEL "can't allocate DLEs\n");
                goto err_out;
        }
-       iadev->rx_dle_q.start = (struct dle*)dle_addr;  
+       iadev->rx_dle_q.start = dle_addr;  
        iadev->rx_dle_q.read = iadev->rx_dle_q.start;  
        iadev->rx_dle_q.write = iadev->rx_dle_q.start;  
-       iadev->rx_dle_q.end = (struct dle*)((u32)dle_addr+sizeof(struct dle)*DLE
_ENTRIES);  
+       iadev->rx_dle_q.end = dle_addr + DLE_ENTRIES;
        /* the end of the dle q points to the entry after the last  
        DLE that can be used. */  
   
@@ -1884,7 +1884,7 @@ static int tx_init(struct atm_dev *dev) 
        IADEV *iadev;  
        struct tx_buf_desc *buf_desc_ptr;
        unsigned int tx_pkt_start;  
-       void *dle_addr;  
+       struct dle *dle_addr;  
        int i;  
        u_short tcq_st_adr;  
        u_short *tcq_start;  
@@ -1908,10 +1908,10 @@ static int tx_init(struct atm_dev *dev) 
                printk(KERN_ERR DEV_LABEL "can't allocate DLEs\n");
                goto err_out;
        }
-       iadev->tx_dle_q.start = (struct dle*)dle_addr;  
+       iadev->tx_dle_q.start = dle_addr;  
        iadev->tx_dle_q.read = iadev->tx_dle_q.start;  
        iadev->tx_dle_q.write = iadev->tx_dle_q.start;  
-       iadev->tx_dle_q.end = (struct dle*)((u32)dle_addr+sizeof(struct dle)*DLE
_ENTRIES);  
+       iadev->tx_dle_q.end = dle_addr + DLE_ENTRIES;
 
        /* write the upper 20 bits of the start address to tx list address regis
ter */  
        writel(iadev->tx_dle_dma & 0xfffff000,

(whitespace damaged; more for comment than for application).

> -        if ((u32)skb->data & 3) {
> +        if ((unsigned long)skb->data & 3) {

I suppose it quietens a compiler warning.  Doesn't actually fix a bug
though.
