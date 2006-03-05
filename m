Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWCETEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWCETEN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 14:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCETEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 14:04:13 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:45506 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750725AbWCETEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 14:04:12 -0500
Date: Sun, 5 Mar 2006 19:59:48 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060305185948.GA24765@electric-eye.fr.zoreil.com>
References: <20060305180757.GA22121@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060305180757.GA22121@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Michlmayr <tbm@cyrius.com> :
[...]
> I have a system on which I can reproduce this bug 100%.  While I have
> no idea how to fix the issue, I can provide debugging information and
> test a fix.  However, I'm (temporarily) leaving the country in three
> weeks and won't have access to this PC for several months, so it would
> be great if someone could look into this soon.  Jeff?

(not compile-tested)

diff --git a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
index d7fb3ff..d16a5a0 100644
--- a/drivers/net/tulip/de2104x.c
+++ b/drivers/net/tulip/de2104x.c
@@ -1376,18 +1376,20 @@ static int de_open (struct net_device *d
 		return rc;
 	}
 
-	rc = de_init_hw(de);
-	if (rc) {
-		printk(KERN_ERR "%s: h/w init failure, err=%d\n",
-		       dev->name, rc);
-		goto err_out_free;
-	}
+	dw32(IntrMask, 0);
 
 	rc = request_irq(dev->irq, de_interrupt, SA_SHIRQ, dev->name, dev);
 	if (rc) {
 		printk(KERN_ERR "%s: IRQ %d request failure, err=%d\n",
 		       dev->name, dev->irq, rc);
-		goto err_out_hw;
+		goto err_out_free;
+	}
+
+	rc = de_init_hw(de);
+	if (rc) {
+		printk(KERN_ERR "%s: h/w init failure, err=%d\n",
+		       dev->name, rc);
+		goto err_out_free_irq;
 	}
 
 	netif_start_queue(dev);
@@ -1395,11 +1397,8 @@ static int de_open (struct net_device *d
 
 	return 0;
 
-err_out_hw:
-	spin_lock_irqsave(&de->lock, flags);
-	de_stop_hw(de);
-	spin_unlock_irqrestore(&de->lock, flags);
-
+err_out_free_irq:
+	free_irq(dev->irq, dev);
 err_out_free:
 	de_free_rings(de);
 	return rc;
