Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVFHCUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVFHCUT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 22:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVFHCUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 22:20:18 -0400
Received: from peabody.ximian.com ([130.57.169.10]:46260 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262070AbVFHCUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 22:20:08 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Adam Belay <abelay@novell.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, greg@kroah.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>
In-Reply-To: <1118190373.6850.85.camel@gaston>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
	 <20050607025054.GC3289@neo.rr.com>
	 <20050607105552.GA27496@pingi3.kke.suse.de>
	 <20050607205800.GB8300@neo.rr.com>  <1118190373.6850.85.camel@gaston>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 22:16:19 -0400
Message-Id: <1118196980.3245.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 10:26 +1000, Benjamin Herrenschmidt wrote:
> > pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
> > {
> > 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> > 		return PCI_D0;
> > 
> > 	switch (state) {
> > 	case 0: return PCI_D0;
> > 	case 3: return PCI_D3hot;
> > 	default:
> > 		printk("They asked me for state %d\n", state);
> > 		BUG();
> > 	}
> > 	return PCI_D0;
> > }
> 
> Gack ! I need to remember to fix that one before I change PMSG_FREEZE
> definition to be different than PMSG_SUSPEND upstream.
> 
> Pavel, do you know that there are other ways to deal with errors than
> just BUG()'ing all over the place ? :)
> 
> Ben.

I think we should also use the pm_message_t defines.  We will need to
add PMSG_FREEZE eventually.  I decided to default to the current state
rather than panic.  Does this patch look ok?

Thanks,
Adam

--- a/drivers/pci/pci.c	2005-05-27 22:06:02.000000000 -0400
+++ b/drivers/pci/pci.c	2005-06-07 22:10:02.066151280 -0400
@@ -320,13 +320,15 @@
 		return PCI_D0;
 
 	switch (state) {
-	case 0: return PCI_D0;
-	case 3: return PCI_D3hot;
+	case PMSG_ON:
+		return PCI_D0;
+	case PMSG_SUSPEND:
+		return PCI_D3hot;
 	default:
-		printk("They asked me for state %d\n", state);
-		BUG();
+		printk(KERN_ERR "PCI: invalid PM message state - %d\n", state);
 	}
-	return PCI_D0;
+
+	return dev->current_state;
 }
 
 EXPORT_SYMBOL(pci_choose_state);


