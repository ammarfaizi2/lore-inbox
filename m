Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbTHYLKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 07:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTHYLKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 07:10:44 -0400
Received: from [203.145.184.221] ([203.145.184.221]:62725 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S261698AbTHYLKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 07:10:39 -0400
Subject: Re: [PATCH 2.6.0-test4][NET] ni5010.c: remove cli/sti
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
In-Reply-To: <3F48E870.2070205@colorfullife.com>
References: <3F48E870.2070205@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 25 Aug 2003 17:01:29 +0530
Message-Id: <1061811091.1080.3.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2003-08-24 at 22:01, Manfred Spraul wrote:
> Vinay wrote:
> 
> >drivers/net/ni5010.c:
> >This patch replaces cli/sti with spinlocks. Compiles fine though
> >untested.
> >  
> >
> I don't have the hardware either, but the patch seems to be wrong:
> The cli() call was in hardware_send_packet(). I assume that this 
> function should be synchronized against concurrent interrupts - both 
> functions access the hardware. Due to the dev_xmit_lock, the networking 
> core already guarantees that hardware_send_packet is never reentered. 
> cli() provided protection against concurrent interrupts on other cpus, 
> spin_lock_irqsave() doesn't.
> 
> Could you add a spin_lock()/spin_unlock() into ni5010_interrupt?

Thanks for the suggestions. I have updated the patch accordingly. Hope
the locking is sufficient.

Thanks
vinay

--- linux-2.6.0-test4/drivers/net/ni5010.c	2003-07-15 17:22:18.000000000 +0530
+++ linux-2.6.0-test4-nvk/drivers/net/ni5010.c	2003-08-25 16:56:02.000000000 +0530
@@ -96,6 +96,7 @@
 	struct net_device_stats stats;
 	int o_pkt_size;
 	int i_pkt_size;
+	spinlock_t lock;
 };
 
 /* Index to functions, as function prototypes. */
@@ -280,11 +281,16 @@
 	/* DMA is not supported (yet?), so no use detecting it */
 
 	if (dev->priv == NULL) {
+		struct ni5010_local* lp;
+
 		dev->priv = kmalloc(sizeof(struct ni5010_local), GFP_KERNEL|GFP_DMA);
 		if (dev->priv == NULL) {
 			printk(KERN_WARNING "%s: Failed to allocate private memory\n", dev->name);
 			return -ENOMEM;
 		}
+
+		lp = (struct ni5010_local*)dev->priv;
+		spin_lock_init(&lp->lock);
 	}
 
 	PRINTK2((KERN_DEBUG "%s: I/O #10 passed!\n", dev->name));
@@ -463,6 +469,7 @@
 	ioaddr = dev->base_addr;
 	lp = (struct ni5010_local *)dev->priv;
 	
+	spin_lock(&lp->lock);
 	status = inb(IE_ISTAT); 
 	PRINTK3((KERN_DEBUG "%s: IE_ISTAT = %#02x\n", dev->name, status));
 		
@@ -479,6 +486,7 @@
 
 	if (!xmit_was_error) 
 		reset_receiver(dev); 
+	spin_unlock(&lp->lock);
 	return IRQ_HANDLED;
 }
 
@@ -693,8 +701,7 @@
         buf_offs = NI5010_BUFSIZE - length - pad;
         lp->o_pkt_size = length + pad;
 
-	save_flags(flags);	
-	cli();
+	spin_lock_irqsave(&lp->lock, flags);
 
 	outb(0, EDLC_RMASK);	/* Mask all receive interrupts */
 	outb(0, IE_MMODE);	/* Put Xmit buffer on system bus */
@@ -712,7 +719,7 @@
 	outb(MM_EN_XMT | MM_MUX, IE_MMODE); /* Begin transmission */
 	outb(XM_ALL, EDLC_XMASK); /* Cause interrupt after completion or fail */
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lp->lock, flags);
 
 	netif_wake_queue(dev);
 	

