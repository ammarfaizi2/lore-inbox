Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268899AbUJUKqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268899AbUJUKqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUJUKnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:43:49 -0400
Received: from gprs214-246.eurotel.cz ([160.218.214.246]:10624 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S270481AbUJUKmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:42:54 -0400
Date: Thu, 21 Oct 2004 12:42:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rl@hellgate.ch, jgarzik@pobox.com,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@zip.com.au>
Subject: Fix suspend/resume support in via-rhine2
Message-ID: <20041021104239.GA2201@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

If I want via-rhine to work after resume, I need this patch. It stops
interrupts during suspend and reinitializes them after that. Please
apply,

								Pavel

--- clean/drivers/net/via-rhine.c	2004-10-01 00:30:16.000000000 +0200
+++ linux/drivers/net/via-rhine.c	2004-10-21 12:32:56.000000000 +0200
@@ -1957,6 +1957,7 @@
 	rhine_shutdown(&pdev->dev);
 	spin_unlock_irqrestore(&rp->lock, flags);
 
+	free_irq(dev->irq, dev);
 	return 0;
 }
 
@@ -1970,6 +1971,9 @@
 	if (!netif_running(dev))
 		return 0;
 
+        if (request_irq(dev->irq, rhine_interrupt, SA_SHIRQ, dev->name, dev))
+		printk(KERN_ERR "via-rhine %s: request_irq failed\n", dev->name);
+
 	ret = pci_set_power_state(pdev, 0);
 	if (debug > 1)
 		printk(KERN_INFO "%s: Entering power state D0 %s (%d).\n",


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
