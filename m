Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263917AbUDVKdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263917AbUDVKdS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 06:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263919AbUDVKdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 06:33:18 -0400
Received: from gprs214-27.eurotel.cz ([160.218.214.27]:33924 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263917AbUDVKdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 06:33:16 -0400
Date: Thu, 22 Apr 2004 12:33:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
Subject: Re: b44 needs to reclaim its interrupt after swsusp
Message-ID: <20040422103306.GD32521@elf.ucw.cz>
References: <20040421000208.GA3160@elf.ucw.cz> <40873BB5.2000506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40873BB5.2000506@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >@@ -1874,6 +1874,8 @@
> > 	b44_free_rings(bp);
> > 
> > 	spin_unlock_irq(&bp->lock);
> >+
> >+	free_irq(dev->irq, dev);
> > 	return 0;
> > }
> > 
> >@@ -1887,6 +1889,9 @@
> > 
> > 	pci_restore_state(pdev, bp->pci_cfg_state);
> > 
> >+	if (request_irq(dev->irq, b44_interrupt, SA_SHIRQ, dev->name, dev))
> >+		printk("b44: request_irq failed\n");
> >+
> 
> look ok, with minor nit:  use KERN_xxx prefix in printk

Fixed, here's updated patch, please apply,
								Pavel

--- tmp/linux/drivers/net/b44.c	2004-04-22 12:25:36.000000000 +0200
+++ linux/drivers/net/b44.c	2004-04-22 12:20:48.000000000 +0200
@@ -1252,7 +1252,7 @@
 }
 
 #if 0
-/*static*/ void b44_dump_state(struct b44 *bp)
+void b44_dump_state(struct b44 *bp)
 {
 	u32 val32, val32_2, val32_3, val32_4, val32_5;
 	u16 val16;
@@ -1875,6 +1875,8 @@
 	b44_free_rings(bp);
 
 	spin_unlock_irq(&bp->lock);
+
+	free_irq(dev->irq, dev);
 	return 0;
 }
 
@@ -1888,6 +1890,9 @@
 
 	pci_restore_state(pdev, bp->pci_cfg_state);
 
+	if (request_irq(dev->irq, b44_interrupt, SA_SHIRQ, dev->name, dev))
+		printk(KERN_ERR PFX "%s: request_irq failed\n", dev->name);
+
 	spin_lock_irq(&bp->lock);
 
 	b44_init_rings(bp);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
