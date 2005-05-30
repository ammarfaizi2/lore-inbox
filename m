Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVE3Txi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVE3Txi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVE3Txi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:53:38 -0400
Received: from opersys.com ([64.40.108.71]:24590 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261724AbVE3Tuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:50:54 -0400
Message-ID: <429B70F2.20602@opersys.com>
Date: Mon, 30 May 2005 16:00:50 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, kus Kusche Klaus <kus@keba.com>,
       James Bruce <bruce@andrew.cmu.edu>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505302125520.31148-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10505302125520.31148-100000@da410.phys.au.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's for the fun of history, a diff between the 8390.c in 2.2.16 and the
one in rt-net 0.9.0:

0a1,12
> /*
>     rtnet/module/driver/8390.c
>     driver for 8390-based network interfaces
>
>     rtnet - real-time networking subsystem
>     Copyright (C) 1999,2000 Zentropic Computing, LLC
>
>     This file is a modified version of a source file located in the
>     standard Linux source tree.  Information about how to find the
>     original version of this file is located in rtnet/original_files.
> */
>
49a62,63
> #define EXPORT_SYMTAB
>
71a86,137
> #if defined(CONFIG_RTNET) || defined(CONFIG_RTNET_MODULE)
> #include <rtnet/rtnet.h>
> #define RT_DRIVER
> static int ei_rt_start_xmit(struct sk_buff *skb, struct rt_device *rtdev);
> #define RT_dev_alloc_skb(a)     ((!ei_local->rt)?dev_alloc_skb(a):dev_alloc_rtskb(a))
> #define RT_mark_bh(a)           do{if(!ei_local->rt)mark_bh(a);}while(0)
> #define RT_dev_kfree_skb(a)     do{if(!ei_local->rt){dev_kfree_skb(a);}else{dev_kfree_rtskb(a);}}while(0)
> #define RT_netif_rx(a)          ((!ei_local->rt)?netif_rx(a):rtnetif_rx(a))
> #define RT_printk(format,args...)	rt_printk(format,##args)
> #define RT_enable_irq(a)	do{if(!ei_local->rt)enable_irq(a);else rt_enable_irq(a);}while(0)
> #define RT_disable_irq_nosync(a) do{if(!ei_local->rt)disable_irq_nosync(a);else rt_disable_irq(a);}while(0)
> #define RT_spin_lock(a)			\
> 	do{if(!ei_local->rt){		\
> 		spin_lock(a);		\
> 	}else{				\
> 		rt_spin_lock(a);	\
> 	}}while(0)
> #define RT_spin_unlock(a)		\
> 	do{if(!ei_local->rt){		\
> 		spin_unlock(a);		\
> 	}else{				\
> 		rt_spin_unlock(a);	\
> 	}}while(0)
> #define RT_spin_lock_irqsave(a,b)	\
> 	do{if(!ei_local->rt){		\
> 		spin_lock_irqsave(a,b);	\
> 	}else{				\
> 		(b)=rt_spin_lock_irqsave(a);	\
> 	}}while(0)
> #define RT_spin_unlock_irqrestore(a,b)	\
> 	do{if(!ei_local->rt){		\
> 		spin_unlock_irqrestore(a,b);	\
> 	}else{				\
> 		rt_spin_unlock_irqrestore(b,a);	\
> 	}}while(0)
> #define RT_spin_lock_init(a)		spin_lock_init(a)
> #else
> #define DIFE(a,b)		(a)
> #define RT_dev_alloc_skb        dev_alloc_skb
> #define RT_mark_bh(a)           mark_bh(a)
> #define RT_dev_kfree_skb(a)     dev_kfree_skb(a)
> #define RT_netif_rx(a)          netif_rx(a)
> #define RT_printk               printk
> #define RT_enable_irq(a)	enable_irq(a)
> #define RT_disable_irq_nosync(a) disable_irq_nosync(a)
> #define RT_spin_lock(a)			spin_lock(a)
> #define RT_spin_unlock(a)		spin_unlock(a)
> #define RT_spin_lock_irqsave(a,b)	spin_lock_irqsave(a,b)
> #define RT_spin_unlock_irqrestore(a,b)	spin_unlock_irqrestore(a,b)
> #define RT_spin_lock_init(a)		spin_lock_init(a)
> #endif
>
157c223
< 		printk(KERN_EMERG "%s: ei_open passed a non-existent device!\n", dev->name);
---
> 		RT_printk(KERN_EMERG "%s: ei_open passed a non-existent device!\n", dev->name);
166c232
<       	spin_lock_irqsave(&ei_local->page_lock, flags);
---
>       	RT_spin_lock_irqsave(&ei_local->page_lock, flags);
171c237
<       	spin_unlock_irqrestore(&ei_local->page_lock, flags);
---
>       	RT_spin_unlock_irqrestore(&ei_local->page_lock, flags);
186c252
<       	spin_lock_irqsave(&ei_local->page_lock, flags);
---
>       	RT_spin_lock_irqsave(&ei_local->page_lock, flags);
188c254
<       	spin_unlock_irqrestore(&ei_local->page_lock, flags);
---
>       	RT_spin_unlock_irqrestore(&ei_local->page_lock, flags);
192a259,267
> #ifdef RT_DRIVER
> static int ei_start_xmit(struct sk_buff *skb, struct device *dev);
>
> static int ei_rt_start_xmit(struct sk_buff *skb, struct rt_device *rtdev)
> {
> 	return ei_start_xmit(skb,rtdev->dev);
> }
> #endif
>
218c293
< 		spin_lock_irqsave(&ei_local->page_lock, flags);
---
> 		RT_spin_lock_irqsave(&ei_local->page_lock, flags);
222c297
< 			spin_unlock_irqrestore(&ei_local->page_lock, flags);
---
> 			RT_spin_unlock_irqrestore(&ei_local->page_lock, flags);
230,231c305,306
< 			spin_unlock_irqrestore(&ei_local->page_lock, flags);
< 			printk(KERN_WARNING "%s: xmit on stopped card\n", dev->name);
---
> 			RT_spin_unlock_irqrestore(&ei_local->page_lock, flags);
> 			RT_printk(KERN_WARNING "%s: xmit on stopped card\n", dev->name);
241c316
< 		printk(KERN_DEBUG "%s: Tx timed out, %s TSR=%#2x, ISR=%#2x, t=%d.\n",
---
> 		RT_printk(KERN_DEBUG "%s: Tx timed out, %s TSR=%#2x, ISR=%#2x, t=%d.\n",
256c331
< 		spin_unlock_irqrestore(&ei_local->page_lock, flags);
---
> 		RT_spin_unlock_irqrestore(&ei_local->page_lock, flags);
260,261c335,336
< 		disable_irq_nosync(dev->irq);
< 		spin_lock(&ei_local->page_lock);
---
> 		RT_disable_irq_nosync(dev->irq);
> 		RT_spin_lock(&ei_local->page_lock);
263a339
> /* XXX not realtime! */
267,268c343,344
< 		spin_unlock(&ei_local->page_lock);
< 		enable_irq(dev->irq);
---
> 		RT_spin_unlock(&ei_local->page_lock);
> 		RT_enable_irq(dev->irq);
279c355
< 	spin_lock_irqsave(&ei_local->page_lock, flags);
---
> 	RT_spin_lock_irqsave(&ei_local->page_lock, flags);
281c357
< 	spin_unlock_irqrestore(&ei_local->page_lock, flags);
---
> 	RT_spin_unlock_irqrestore(&ei_local->page_lock, flags);
288c364
< 	disable_irq_nosync(dev->irq);
---
> 	RT_disable_irq_nosync(dev->irq);
290c366
< 	spin_lock(&ei_local->page_lock);
---
> 	RT_spin_lock(&ei_local->page_lock);
294c370
< 		printk(KERN_WARNING "%s: Tx request while isr active.\n",dev->name);
---
> 		RT_printk(KERN_WARNING "%s: Tx request while isr active.\n",dev->name);
296,297c372,373
< 		spin_unlock(&ei_local->page_lock);
< 		enable_irq(dev->irq);
---
> 		RT_spin_unlock(&ei_local->page_lock);
> 		RT_enable_irq(dev->irq);
299c375
< 		dev_kfree_skb(skb);
---
> 		RT_dev_kfree_skb(skb);
321c397
< 			printk(KERN_DEBUG "%s: idle transmitter tx2=%d, lasttx=%d, txing=%d.\n",
---
> 			RT_printk(KERN_DEBUG "%s: idle transmitter tx2=%d, lasttx=%d, txing=%d.\n",
329c405
< 			printk(KERN_DEBUG "%s: idle transmitter, tx1=%d, lasttx=%d, txing=%d.\n",
---
> 			RT_printk(KERN_DEBUG "%s: idle transmitter, tx1=%d, lasttx=%d, txing=%d.\n",
335c411
< 			printk(KERN_DEBUG "%s: No Tx buffers free! irq=%ld tx1=%d tx2=%d last=%d\n",
---
> 			RT_printk(KERN_DEBUG "%s: No Tx buffers free! irq=%ld tx1=%d tx2=%d last=%d\n",
340,341c416,417
< 		spin_unlock(&ei_local->page_lock);
< 		enable_irq(dev->irq);
---
> 		RT_spin_unlock(&ei_local->page_lock);
> 		RT_enable_irq(dev->irq);
393,394c469,470
< 	spin_unlock(&ei_local->page_lock);
< 	enable_irq(dev->irq);
---
> 	RT_spin_unlock(&ei_local->page_lock);
> 	RT_enable_irq(dev->irq);
396c472
< 	dev_kfree_skb (skb);
---
> 	RT_dev_kfree_skb (skb);
414c490
< 		printk ("net_interrupt(): irq %d for unknown device.\n", irq);
---
> 		RT_printk ("net_interrupt(): irq %d for unknown device.\n", irq);
425c501
< 	spin_lock(&ei_local->page_lock);
---
> 	RT_spin_lock(&ei_local->page_lock);
431c507
< 		printk(ei_local->irqlock
---
> 		RT_printk(ei_local->irqlock
437c513
< 		spin_unlock(&ei_local->page_lock);
---
> 		RT_spin_unlock(&ei_local->page_lock);
447c523
< 		printk(KERN_DEBUG "%s: interrupt(isr=%#2.2x).\n", dev->name,
---
> 		RT_printk(KERN_DEBUG "%s: interrupt(isr=%#2.2x).\n", dev->name,
456c532
< 			printk(KERN_WARNING "%s: interrupt from stopped card\n", dev->name);
---
> 			RT_printk(KERN_WARNING "%s: interrupt from stopped card\n", dev->name);
495c571
< 			printk(KERN_WARNING "%s: Too much work at interrupt, status %#2.2x\n",
---
> 			RT_printk(KERN_WARNING "%s: Too much work at interrupt, status %#2.2x\n",
499c575
< 			printk(KERN_WARNING "%s: unknown interrupt %#2x\n", dev->name, interrupts);
---
> 			RT_printk(KERN_WARNING "%s: unknown interrupt %#2x\n", dev->name, interrupts);
504c580
< 	spin_unlock(&ei_local->page_lock);
---
> 	RT_spin_unlock(&ei_local->page_lock);
527c603
< 	printk(KERN_DEBUG "%s: transmitter error (%#2x): ", dev->name, txsr);
---
> 	RT_printk(KERN_DEBUG "%s: transmitter error (%#2x): ", dev->name, txsr);
529c605
< 		printk("excess-collisions ");
---
> 		RT_printk("excess-collisions ");
531c607
< 		printk("non-deferral ");
---
> 		RT_printk("non-deferral ");
533c609
< 		printk("lost-carrier ");
---
> 		RT_printk("lost-carrier ");
535c611
< 		printk("FIFO-underrun ");
---
> 		RT_printk("FIFO-underrun ");
537,538c613,614
< 		printk("lost-heartbeat ");
< 	printk("\n");
---
> 		RT_printk("lost-heartbeat ");
> 	RT_printk("\n");
576c652
< 			printk(KERN_ERR "%s: bogus last_tx_buffer %d, tx1=%d.\n",
---
> 			RT_printk(KERN_ERR "%s: bogus last_tx_buffer %d, tx1=%d.\n",
593c669
< 			printk("%s: bogus last_tx_buffer %d, tx2=%d.\n",
---
> 			RT_printk("%s: bogus last_tx_buffer %d, tx2=%d.\n",
608c684
< 	else printk(KERN_WARNING "%s: unexpected TX-done interrupt, lasttx=%d.\n",
---
> 	else RT_printk(KERN_WARNING "%s: unexpected TX-done interrupt, lasttx=%d.\n",
641c717
< 	mark_bh (NET_BH);
---
> 	RT_mark_bh (NET_BH);
674c750
< 			printk(KERN_ERR "%s: mismatched read page pointers %2x vs %2x.\n",
---
> 			RT_printk(KERN_ERR "%s: mismatched read page pointers %2x vs %2x.\n",
704c780
< 				printk(KERN_DEBUG "%s: bogus packet size: %d, status=%#2x nxpg=%#2x.\n",
---
> 				RT_printk(KERN_DEBUG "%s: bogus packet size: %d, status=%#2x nxpg=%#2x.\n",
714c790
< 			skb = dev_alloc_skb(pkt_len+2);
---
> 			skb = RT_dev_alloc_skb(pkt_len+2);
718c794
< 					printk(KERN_DEBUG "%s: Couldn't allocate a sk_buff of size %d.\n",
---
> 					RT_printk(KERN_DEBUG "%s: Couldn't allocate a sk_buff of size %d.\n",
730c806
< 				netif_rx(skb);
---
> 				RT_netif_rx(skb);
740c816
< 				printk(KERN_DEBUG "%s: bogus packet: status=%#2x nxpg=%#2x size=%d\n",
---
> 				RT_printk(KERN_DEBUG "%s: bogus packet: status=%#2x nxpg=%#2x size=%d\n",
752c828
< 			printk("%s: next frame inconsistency, %#2x\n", dev->name,
---
> 			RT_printk("%s: next frame inconsistency, %#2x\n", dev->name,
790c866
< 		printk(KERN_DEBUG "%s: Receiver overrun.\n", dev->name);
---
> 		RT_printk(KERN_DEBUG "%s: Receiver overrun.\n", dev->name);
855c931
< 	spin_lock_irqsave(&ei_local->page_lock,flags);
---
> 	RT_spin_lock_irqsave(&ei_local->page_lock,flags);
860c936
< 	spin_unlock_irqrestore(&ei_local->page_lock, flags);
---
> 	RT_spin_unlock_irqrestore(&ei_local->page_lock, flags);
901c977
< 			printk(KERN_INFO "%s: invalid multicast address length given.\n", dev->name);
---
> 			RT_printk(KERN_INFO "%s: invalid multicast address length given.\n", dev->name);
980c1056
< 	spin_lock_irqsave(&ei_local->page_lock, flags);
---
> 	RT_spin_lock_irqsave(&ei_local->page_lock, flags);
982c1058
< 	spin_unlock_irqrestore(&ei_local->page_lock, flags);
---
> 	RT_spin_unlock_irqrestore(&ei_local->page_lock, flags);
1004c1080
< 		spin_lock_init(&ei_local->page_lock);
---
> 		RT_spin_lock_init(&ei_local->page_lock);
1010a1087,1097
> #ifdef RT_DRIVER
> 	{
> 		struct ei_device *ei_priv = (struct ei_device *)dev->priv;
>
> 		if(ei_priv->rtdev == NULL)
> 			ei_priv->rtdev = rt_dev_alloc(dev);
>
> 		ei_priv->rtdev->xmit = ei_rt_start_xmit;
> 	}
> #endif
>
1061c1148
< 			printk(KERN_ERR "Hw. address read/write mismap %d\n",i);
---
> 			RT_printk(KERN_ERR "Hw. address read/write mismap %d\n",i);
1098c1185
< 		printk(KERN_WARNING "%s: trigger_send() called with the transmitter busy.\n",
---
> 		RT_printk(KERN_WARNING "%s: trigger_send() called with the transmitter busy.\n",

Of course this is ancient, but I just thought I'd illustrate my point.

Again, I suggest you drop the single vs. double application/driver, you
get the same results and limitations regardless of the RT method you
adopt.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
