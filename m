Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWCFOf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWCFOf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 09:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWCFOf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 09:35:27 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:47878 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751334AbWCFOf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 09:35:27 -0500
Date: Mon, 6 Mar 2006 14:35:12 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: de2104x: interrupts before interrupt handler is registered
Message-ID: <20060306143512.GI23669@deprecation.cyrius.com>
References: <20060305180757.GA22121@deprecation.cyrius.com> <20060305185948.GA24765@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060305185948.GA24765@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Francois Romieu <romieu@fr.zoreil.com> [2006-03-05 19:59]:
> > I have a system on which I can reproduce this bug 100%.  While I have
> > no idea how to fix the issue, I can provide debugging information and
> > test a fix.

> (not compile-tested)

Thanks a lot for your quick response, Francois.  I can confirm that
this patch fixes the problem for me.

> -err_out_hw:
> -	spin_lock_irqsave(&de->lock, flags);
> -	de_stop_hw(de);
> -	spin_unlock_irqrestore(&de->lock, flags);

flags is no longer used now, so we get a compilation warning.  Updated
patch below.  Francois, can you please submit it with a proper
changelog entry and your Signed-off-by.


From: Francois Romieu <romieu@fr.zoreil.com>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

--- a/drivers/net/tulip/de2104x.c
+++ b/drivers/net/tulip/de2104x.c
@@ -1362,7 +1362,6 @@ static int de_open (struct net_device *d
 {
 	struct de_private *de = dev->priv;
 	int rc;
-	unsigned long flags;
 
 	if (netif_msg_ifup(de))
 		printk(KERN_DEBUG "%s: enabling interface\n", dev->name);
@@ -1376,18 +1375,20 @@ static int de_open (struct net_device *d
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
@@ -1395,11 +1396,8 @@ static int de_open (struct net_device *d
 
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

-- 
Martin Michlmayr
http://www.cyrius.com/
