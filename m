Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVDEKOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVDEKOy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVDEKLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 06:11:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8171 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261694AbVDEKHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 06:07:11 -0400
Date: Tue, 5 Apr 2005 12:06:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Norbert Preining <preining@logic.at>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Message-ID: <20050405100644.GA1345@elf.ucw.cz>
References: <20050331220822.GA22418@gamma.logic.tuwien.ac.at> <20050401113335.GA13160@elf.ucw.cz> <20050403224557.GB1015@gamma.logic.tuwien.ac.at> <20050403225929.GE13466@elf.ucw.cz> <20050404081600.GA2424@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050404081600.GA2424@gamma.logic.tuwien.ac.at>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 04-04-05 10:16:00, Norbert Preining wrote:
> Hi Pavel!
> 
> On Mon, 04 Apr 2005, Pavel Machek wrote:
> > I'd like to fix the problem, but first I need to know where the
> > problem is.  If it works with minimal config, I know that it is one of
> > drivers you deselected.
> 
> It's b44. It *was* working with b44 insmod-ed and up and running, but
> now as soon as b44-eth0 is ifup-ed while suspending, the resume freezes.
> If I do a ifdown eth0 before suspending, it works.

Does this one help?
								Pavel

--- clean/drivers/net/b44.c	2005-04-05 10:55:16.000000000 +0200
+++ linux/drivers/net/b44.c	2005-04-05 10:56:33.000000000 +0200
@@ -1927,6 +1927,8 @@
 	b44_free_rings(bp);
 
 	spin_unlock_irq(&bp->lock);
+
+	free_irq(dev->irq, dev);
 	return 0;
 }
 
@@ -1940,6 +1942,9 @@
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
