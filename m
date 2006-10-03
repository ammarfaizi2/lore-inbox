Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030614AbWJCWWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030614AbWJCWWo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030616AbWJCWWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:22:44 -0400
Received: from hu-out-0506.google.com ([72.14.214.237]:6167 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030614AbWJCWWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:22:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=XVnFSvIpHGlBFjxL5sHf5MoLEsrQLOB1XIolGoFWtJWbMb+ZxMEaGTitNPMbmvSbTWLOzC4xv3+icMGTAIQHQc5WzYZX0k3DdpdwWheq6EywE25l1P9LJIbfOqltVJumnVhvHmDK659QGktauqHuyNfnGUfNwBUea2rxeBiyMqs=
Date: Tue, 3 Oct 2006 22:22:23 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: linux-kernel@vger.kernel.org
Cc: arjan@infradead.org, matthew@wil.cx, alan@lxorguk.ukuu.org.uk,
       jeff@garzik.org, akpm@osdl.org, rdunlap@xenotime.net, gregkh@suse.de
Subject: [RFC PATCH] move tg3 to pci_request_irq
Message-ID: <20061003222223.GH2785@slug>
References: <20061003220732.GE2785@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003220732.GE2785@slug>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This proof-of-concept patch converts the tg3 driver to use the
pci_request_irq() function.

Please note that I'm not submitting the driver changes, they're there
only for illustration purposes. I'll CC the appropriate maintainers
when/if an API is agreed upon.

Regards,
Frederik 

diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
index c25ba27..23660c6 100644
Index: 2.6.18-mm3/drivers/net/tg3.c
===================================================================
--- 2.6.18-mm3.orig/drivers/net/tg3.c
+++ 2.6.18-mm3/drivers/net/tg3.c
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
@@ -7363,7 +7362,7 @@ static int tg3_close(struct net_device *
 
 	tg3_full_unlock(tp);
 
-	free_irq(tp->pdev->irq, dev);
+	pci_free_irq(tp->pdev);
 	if (tp->tg3_flags2 & TG3_FLG2_USING_MSI) {
 		pci_disable_msi(tp->pdev);
 		tp->tg3_flags2 &= ~TG3_FLG2_USING_MSI;
