Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVFGCyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVFGCyh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVFGCyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:54:37 -0400
Received: from cpe-24-93-172-51.neo.res.rr.com ([24.93.172.51]:9602 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261487AbVFGCyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:54:23 -0400
Date: Mon, 6 Jun 2005 22:50:55 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Karsten Keil <kkeil@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix tulip suspend/resume
Message-ID: <20050607025054.GC3289@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050606224645.GA23989@pingi3.kke.suse.de> <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 05:04:07PM -0700, Linus Torvalds wrote:
> 
> Jeff, 
>  this looks ok, but I'll leave the decision to you. Things like this often 
> break.
> 
> Andrew, maybe at least a few days in -mm to see if there's some outcry?
> 
> 		Linus

This patch is an improvement, but there may still be some issues.
Specifically, it looks to me like the the interrupt handler remains
registered.  This could cause some problems when another device is sharing
the interrupt because the tulip driver must read from a hardware register
to determine if it triggered the interrupt. When the hardware has been
physically powered off, things might not go well.

I can't comment on the netdev class aspect of this routine, but following
a similar strategy to its original author, a fix might look like this:

--- a/drivers/net/tulip/tulip_core.c	2005-05-27 22:06:00.000000000 -0400
+++ b/drivers/net/tulip/tulip_core.c	2005-06-06 22:14:25.850846400 -0400
@@ -1759,7 +1759,12 @@
 	if (dev && netif_running (dev) && netif_device_present (dev)) {
 		netif_device_detach (dev);
 		tulip_down (dev);
-		/* pci_power_off(pdev, -1); */
+
+		pci_save_state(pdev);
+
+		free_irq(dev->irq, dev);
+		pci_disable_device(pdev);
+		pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	}
 	return 0;
 }
@@ -1768,12 +1773,19 @@
 static int tulip_resume(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
+	int retval;
 
 	if (dev && netif_running (dev) && !netif_device_present (dev)) {
-#if 1
-		pci_enable_device (pdev);
-#endif
-		/* pci_power_on(pdev); */
+		pci_set_power_state(pdev, PCI_D0);
+		pci_restore_state(pdev);
+
+		pci_enable_device(pdev);
+
+		if ((retval = request_irq(dev->irq, &tulip_interrupt, SA_SHIRQ, dev->name, dev))) {
+			printk (KERN_ERR "tulip: request_irq failed in resume\n");
+			return retval;
+		}
+		
 		tulip_up (dev);
 		netif_device_attach (dev);
 	}

I don't have this hardware, so any testing would be appreciated.

Thanks,
Adam


P.S.: I noticed this function in the tulip driver:

static void tulip_set_power_state (struct tulip_private *tp,
				   int sleep, int snooze)
{
	if (tp->flags & HAS_ACPI) {
		u32 tmp, newtmp;
		pci_read_config_dword (tp->pdev, CFDD, &tmp);
		newtmp = tmp & ~(CFDD_Sleep | CFDD_Snooze);
		if (sleep)
			newtmp |= CFDD_Sleep;
		else if (snooze)
			newtmp |= CFDD_Snooze;
		if (tmp != newtmp)
			pci_write_config_dword (tp->pdev, CFDD, newtmp);
	}

}

Currently we aren't using CFDD_Sleep.  Should we call this in suspend?  It
could be important if the hardware doesn't support PCI PM.  I don't really
have any specifications or information about the hardware, so I'm at a loss
here.
