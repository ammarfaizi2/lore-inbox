Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVCHKad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVCHKad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVCHKad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:30:33 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31701 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261963AbVCHK3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:29:14 -0500
Date: Tue, 8 Mar 2005 10:46:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Fix suspend/resume problems with b44
Message-ID: <20050308094655.GA16775@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should fix problems people have with b44 during
suspend/resume. Please apply,
								Pavel

--- clean/drivers/net/b44.c	2004-12-25 13:35:00.000000000 +0100
+++ linux/drivers/net/b44.c	2005-01-19 11:59:12.000000000 +0100
@@ -1921,6 +1921,8 @@
 	b44_free_rings(bp);
 
 	spin_unlock_irq(&bp->lock);
+
+	free_irq(dev->irq, dev);
 	return 0;
 }
 
@@ -1934,6 +1936,9 @@
 	if (!netif_running(dev))
 		return 0;
 
+	if (request_irq(dev->irq, b44_interrupt, SA_SHIRQ, dev->name, dev))
+		printk(KERN_ERR PFX "%s: request_irq failed\n", dev->name);
+
 	spin_lock_irq(&bp->lock);
 
 	b44_init_rings(bp);

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
