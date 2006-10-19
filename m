Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946453AbWJSU15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946453AbWJSU15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 16:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946459AbWJSU1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 16:27:21 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:29852 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1946453AbWJSU0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 16:26:49 -0400
Message-id: <1422020236643313128@wsc.cz>
Subject: [PATCH 3/7] Char: isicom, remove isa code
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Thu, 19 Oct 2006 22:26:57 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, remove isa code

ISA is not supported by this driver, remove parts, that take care of this.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit a11b72a2838aa7dfee930168faeebf25a23c70d4
tree 8c453c2b57552458aacdb9d745537f4e1bc704bf
parent e6fff2d2ab2153655ef957b6dc1e02baa9921b47
author Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:26:58 +0200
committer Jiri Slaby <jirislaby@gmail.com> Thu, 19 Oct 2006 19:26:58 +0200

 drivers/char/isicom.c |   91 +++++++++++--------------------------------------
 1 files changed, 21 insertions(+), 70 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index 66fb11f..8cd6cc2 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -193,7 +193,6 @@ struct	isi_board {
 	unsigned short		shift_count;
 	struct isi_port		* ports;
 	signed char		count;
-	unsigned char		isa;
 	spinlock_t		card_lock; /* Card wide lock 11/5/00 -sameer */
 	unsigned long		flags;
 };
@@ -562,14 +561,12 @@ static irqreturn_t isicom_interrupt(int 
 	base = card->base;
 	spin_lock(&card->card_lock);
 
-	if (card->isa == NO) {
-		/*
-		 * disable any interrupts from the PCI card and lower the
-		 * interrupt line
-		 */
-		outw(0x8000, base+0x04);
-		ClearInterrupt(base);
-	}
+	/*
+	 * disable any interrupts from the PCI card and lower the
+	 * interrupt line
+	 */
+	outw(0x8000, base+0x04);
+	ClearInterrupt(base);
 
 	inw(base);		/* get the dummy word out */
 	header = inw(base);
@@ -579,19 +576,13 @@ static irqreturn_t isicom_interrupt(int 
 	if (channel + 1 > card->port_count) {
 		printk(KERN_WARNING "ISICOM: isicom_interrupt(0x%lx): "
 			"%d(channel) > port_count.\n", base, channel+1);
-		if (card->isa)
-			ClearInterrupt(base);
-		else
-			outw(0x0000, base+0x04); /* enable interrupts */
+		outw(0x0000, base+0x04); /* enable interrupts */
 		spin_unlock(&card->card_lock);
 		return IRQ_HANDLED;
 	}
 	port = card->ports + channel;
 	if (!(port->flags & ASYNC_INITIALIZED)) {
-		if (card->isa)
-			ClearInterrupt(base);
-		else
-			outw(0x0000, base+0x04); /* enable interrupts */
+		outw(0x0000, base+0x04); /* enable interrupts */
 		return IRQ_HANDLED;
 	}
 
@@ -604,10 +595,7 @@ static irqreturn_t isicom_interrupt(int 
 		}
 		if (byte_count & 0x01)
 			inw(base);
-		if (card->isa == YES)
-			ClearInterrupt(base);
-		else
-			outw(0x0000, base+0x04); /* enable interrupts */
+		outw(0x0000, base+0x04); /* enable interrupts */
 		spin_unlock(&card->card_lock);
 		return IRQ_HANDLED;
 	}
@@ -708,10 +696,7 @@ static irqreturn_t isicom_interrupt(int 
 		}
 		tty_flip_buffer_push(tty);
 	}
-	if (card->isa == YES)
-		ClearInterrupt(base);
-	else
-		outw(0x0000, base+0x04); /* enable interrupts */
+	outw(0x0000, base+0x04); /* enable interrupts */
 
 	return IRQ_HANDLED;
 }
@@ -1560,36 +1545,23 @@ static int __devinit reset_card(struct p
 
 	*signature = inw(base + 0x4) & 0xff;
 
-	if (board->isa == YES) {
-		if (!(inw(base + 0xe) & 0x1) || (inw(base + 0x2))) {
-			dev_dbg(&pdev->dev, "base+0x2=0x%lx, base+0xe=0x%lx\n",
-				inw(base + 0x2), inw(base + 0xe));
-			dev_err(&pdev->dev, "ISILoad:ISA Card%d reset failure "
-				"(Possible bad I/O Port Address 0x%lx).\n",
-				card + 1, base);
-			retval = -EIO;
-			goto end;
-		}
-	} else {
-		portcount = inw(base + 0x2);
-		if (!(inw(base + 0xe) & 0x1) || ((portcount != 0) &&
-				(portcount != 4) && (portcount != 8))) {
-			dev_dbg(&pdev->dev, "base+0x2=0x%lx, base+0xe=0x%lx\n",
-				inw(base + 0x2), inw(base + 0xe));
-			dev_err(&pdev->dev, "ISILoad:PCI Card%d reset failure "
-				"(Possible bad I/O Port Address 0x%lx).\n",
-				card + 1, base);
-			retval = -EIO;
-			goto end;
-		}
+	portcount = inw(base + 0x2);
+	if (!(inw(base + 0xe) & 0x1) || ((portcount != 0) &&
+			(portcount != 4) && (portcount != 8))) {
+		dev_dbg(&pdev->dev, "base+0x2=0x%lx, base+0xe=0x%lx\n",
+			inw(base + 0x2), inw(base + 0xe));
+		dev_err(&pdev->dev, "ISILoad:PCI Card%d reset failure "
+			"(Possible bad I/O Port Address 0x%lx).\n",
+			card + 1, base);
+		retval = -EIO;
+		goto end;
 	}
 
 	switch (*signature) {
 	case 0xa5:
 	case 0xbb:
 	case 0xdd:
-		board->port_count = (board->isa == NO && portcount == 4) ? 4 :
-			8;
+		board->port_count = (portcount == 4) ? 4 : 8;
 		board->shift_count = 12;
 		break;
 	case 0xcc:
@@ -1783,8 +1755,6 @@ end:
 /*
  *	Insmod can set static symbols so keep these static
  */
-static int io[4];
-static int irq[4];
 static int card;
 
 static int __devinit isicom_probe(struct pci_dev *pdev,
@@ -1812,7 +1782,6 @@ static int __devinit isicom_probe(struct
 
 	board->base = ioaddr;
 	board->irq = pciirq;
-	board->isa = NO;
 	card++;
 
 	pci_set_drvdata(pdev, board);
@@ -1887,20 +1856,6 @@ static int __init isicom_init(void)
  		}
 		isi_card[idx].base = 0;
 		isi_card[idx].irq = 0;
-
-		if (!io[idx])
-			continue;
-
-		if (irq[idx] == 2 || irq[idx] == 3 || irq[idx] == 4	||
-				irq[idx] == 5	|| irq[idx] == 7	||
-				irq[idx] == 10	|| irq[idx] == 11	||
-				irq[idx] == 12	|| irq[idx] == 15) {
-			printk(KERN_ERR "ISICOM: ISA not supported yet.\n");
-			retval = -EINVAL;
-			goto error;
-		} else
-			printk(KERN_ERR "ISICOM: Irq %d unsupported. "
-				"Disabling Card%d...\n", irq[idx], idx + 1);
 	}
 
 	/* tty driver structure initialization */
@@ -1970,7 +1925,3 @@ module_exit(isicom_exit);
 MODULE_AUTHOR("MultiTech");
 MODULE_DESCRIPTION("Driver for the ISI series of cards by MultiTech");
 MODULE_LICENSE("GPL");
-module_param_array(io, int, NULL, 0);
-MODULE_PARM_DESC(io, "I/O ports for the cards");
-module_param_array(irq, int, NULL, 0);
-MODULE_PARM_DESC(irq, "Interrupts for the cards");
