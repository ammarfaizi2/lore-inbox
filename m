Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262069AbSJJGix>; Thu, 10 Oct 2002 02:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262079AbSJJGix>; Thu, 10 Oct 2002 02:38:53 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:28423 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262069AbSJJGiv>; Thu, 10 Oct 2002 02:38:51 -0400
Message-Id: <200210100639.g9A6djp01401@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: Looking for testers with these NICs
Date: Thu, 10 Oct 2002 09:33:12 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200210091637.g99Gbmp30784@Port.imtp.ilyichevsk.odessa.ua> <20021009200553.I29133@edinburgh.cisco.com>
In-Reply-To: <20021009200553.I29133@edinburgh.cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 October 2002 17:05, Derek Fawcus wrote:
> On Wed, Oct 09, 2002 at 07:31:17PM -0200, Denis Vlasenko wrote:
> > ni65.c
>
> I've got some of these knocking about,  but rather than use that
> driver, I have a (quite old) patch,  that allows the normal lance
> driver to be used.  The patch dates back from 1.3.x,  but I think I
> may have a more recent version around.

Well, if you want, give this a spin. Can you test it on
SMP or preempt kernel?

diff -u --recursive linux-2.5.40org/drivers/net/ni65.c linux-2.5.40/drivers/net/ni65.c
--- linux-2.5.40org/drivers/net/ni65.c	Thu Oct  3 12:08:00 2002
+++ linux-2.5.40/drivers/net/ni65.c	Wed Oct  9 10:35:18 2002
@@ -176,6 +176,9 @@
 #define writedatareg(val) { writereg(val,CSR0); }
 #endif

+/* Not to be confused with priv->lock */
+static spinlock_t irq_lock = SPIN_LOCK_UNLOCKED;
+
 static unsigned char ni_vendor[] = { 0x02,0x07,0x01 };

 static struct card {
@@ -409,7 +412,7 @@
 		p->features = 0x0;
 	}

-	if(test_bit(0,&cards[i].config)) {
+	if(test_bit(0,(unsigned long*)(&cards[i].config))) {
 		dev->irq = irqtab[(inw(ioaddr+L_CONFIG)>>2)&3];
 		dev->dma = dmatab[inw(ioaddr+L_CONFIG)&3];
 		printk("IRQ %d (from card), DMA %d (from card).\n",dev->irq,dev->dma);
@@ -420,7 +423,7 @@
 			int dma_channels = ((inb(DMA1_STAT_REG) >> 4) & 0x0f) | (inb(DMA2_STAT_REG) & 0xf0);
 			for(i=1;i<5;i++) {
 				int dma = dmatab[i];
-				if(test_bit(dma,&dma_channels) || request_dma(dma,"ni6510"))
+				if(test_bit(dma,(unsigned long*)&dma_channels) || request_dma(dma,"ni6510"))
 					continue;

 				flags=claim_dma_lock();
@@ -1118,8 +1121,7 @@
 							 (skb->len > T_BUF_SIZE) ? T_BUF_SIZE : skb->len);
 			dev_kfree_skb (skb);

-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&irq_lock, flags);

 			tmdp = p->tmdhead + p->tmdnum;
 			tmdp->u.buffer = (u32) isa_virt_to_bus(p->tmdbounce[p->tmdbouncenum]);
@@ -1128,8 +1130,7 @@
 #ifdef XMT_VIA_SKB
 		}
 		else {
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&irq_lock, flags);

 			tmdp = p->tmdhead + p->tmdnum;
 			tmdp->u.buffer = (u32) isa_virt_to_bus(skb->data);
@@ -1150,7 +1151,7 @@
 		p->lock = 0;
 		dev->trans_start = jiffies;

-		restore_flags(flags);
+		spin_unlock_irqrestore(&irq_lock, flags);
 	}
 
 	return 0;
