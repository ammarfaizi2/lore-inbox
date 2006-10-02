Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbWJBSNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbWJBSNH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWJBSNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:13:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:60784 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965223AbWJBSNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:13:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=AB93Ck+T7n6MMs6dLN+GdrtrnqQg1HfGHxVeWm2G+M8Yd1X3nK6iVusingMusQmNUKZMxUMvvtXuq0rcjZelBHpkYXKYDdmwtYNxw/GBlwxn/AEUQ3xLPMQebCqQhVxVo15oYbrHT/6huKgElISxnzTUJuPtFF5ammT4dhE+/8o=
Date: Mon, 2 Oct 2006 20:11:34 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: [RFC PATCH] move tg3 to pci_request_irq
Message-ID: <20061002201134.GE3003@slug>
References: <1159550143.13029.36.camel@localhost.localdomain> <20060929235054.GB2020@slug> <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org> <1159755141.2891.434.camel@laptopd505.fenrus.org> <20061002200048.GC3003@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002200048.GC3003@slug>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This proof-of-concept patch converts the tg3 driver to use the
pci_request_irq() function.

Regards,
Frederik


diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
index c25ba27..23660c6 100644
--- a/drivers/net/tg3.c
+++ b/drivers/net/tg3.c
@@ -6838,9 +6838,9 @@ restart_timer:
 
 static int tg3_request_irq(struct tg3 *tp)
 {
+	struct net_device *dev = tp->dev;
 	irqreturn_t (*fn)(int, void *, struct pt_regs *);
 	unsigned long flags;
-	struct net_device *dev = tp->dev;
 
 	if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
 		fn = tg3_msi;
@@ -6853,7 +6853,7 @@ static int tg3_request_irq(struct tg3 *t
 			fn = tg3_interrupt_tagged;
 		flags = IRQF_SHARED | IRQF_SAMPLE_RANDOM;
 	}
-	return (request_irq(tp->pdev->irq, fn, flags, dev->name, dev));
+	return pci_request_irq(tp->pdev, fn, flags, dev->name);
 }
 
 static int tg3_test_interrupt(struct tg3 *tp)
@@ -6866,10 +6866,10 @@ static int tg3_test_interrupt(struct tg3
 
 	tg3_disable_ints(tp);
 
-	free_irq(tp->pdev->irq, dev);
+	pci_free_irq(tp->pdev);
 
-	err = request_irq(tp->pdev->irq, tg3_test_isr,
-			  IRQF_SHARED | IRQF_SAMPLE_RANDOM, dev->name, dev);
+	err = pci_request_irq(tp->pdev, tg3_test_isr, 
+			      IRQF_SHARED | IRQF_SAMPLE_RANDOM, dev->name);
 	if (err)
 		return err;
 
@@ -6897,7 +6897,7 @@ static int tg3_test_interrupt(struct tg3
 
 	tg3_disable_ints(tp);
 
-	free_irq(tp->pdev->irq, dev);
+	pci_free_irq(tp->pdev);
 
 	err = tg3_request_irq(tp);
 
@@ -6915,7 +6915,6 @@ static int tg3_test_interrupt(struct tg3
  */
 static int tg3_test_msi(struct tg3 *tp)
 {
-	struct net_device *dev = tp->dev;
 	int err;
 	u16 pci_cmd;
 
@@ -6946,7 +6945,7 @@ static int tg3_test_msi(struct tg3 *tp)
 	       "the PCI maintainer and include system chipset information.\n",
 		       tp->dev->name);
 
-	free_irq(tp->pdev->irq, dev);
+	pci_free_irq(tp->pdev);
 	pci_disable_msi(tp->pdev);
 
 	tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
@@ -6966,7 +6965,7 @@ static int tg3_test_msi(struct tg3 *tp)
 	tg3_full_unlock(tp);
 
 	if (err)
-		free_irq(tp->pdev->irq, dev);
+		pci_free_irq(tp->pdev);
 
 	return err;
 }
@@ -7051,7 +7050,7 @@ static int tg3_open(struct net_device *d
 	tg3_full_unlock(tp);
 
 	if (err) {
-		free_irq(tp->pdev->irq, dev);
+		pci_free_irq(tp->pdev);
 		if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
 			pci_disable_msi(tp->pdev);
 			tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
@@ -7363,7 +7362,7 @@ #endif
 
 	tg3_full_unlock(tp);
 
-	free_irq(tp->pdev->irq, dev);
+	pci_free_irq(tp->pdev);
 	if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
 		pci_disable_msi(tp->pdev);
 		tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
