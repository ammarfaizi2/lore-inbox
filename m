Return-Path: <linux-kernel-owner+w=401wt.eu-S1751711AbXAUWH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbXAUWH3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 17:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbXAUWH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 17:07:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:13276 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbXAUWH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 17:07:27 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=qmF672qNVUdbSAcPTUeTtNnll+Ckzt4QmeLmQ107V7Vk9nDxQA9vZ1+kPkZ+FZ0Fe9lXJeHDPVwf9TjOOnBg4ir3plHfcK93/gu611lzEkutkC209HOJnviWGbGfDh4uWZ/OSDLxqUNa65kohMPJoDLULz4f8wX6uYH7KrWt4P0=
Date: Sun, 21 Jan 2007 22:04:57 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Andrei Popa <andrei.popa@i-neo.ro>, linux-kernel@vger.kernel.org,
       nigel@suspend2.net, NetDev <netdev@vger.kernel.org>
Subject: Re: [BUG] e100: eth0 appers many times in /proc/interrupts after resume
Message-ID: <20070121220457.GC8958@slug>
References: <1167599458.2662.8.camel@nigel.suspend2.net> <1167605481.12328.0.camel@localhost> <1167607994.2662.39.camel@nigel.suspend2.net> <1167644970.7142.6.camel@localhost> <1168317278.6948.9.camel@nigel.suspend2.net> <1168448689.7430.1.camel@localhost> <1168463852.3205.1.camel@nigel.suspend2.net> <1169407062.1932.4.camel@localhost> <20070121212209.GB8958@slug> <45B3DEF7.8020505@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B3DEF7.8020505@intel.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2007 at 01:45:27PM -0800, Auke Kok wrote:
> Frederik Deweerdt wrote:
> >On Sun, Jan 21, 2007 at 09:17:41PM +0200, Andrei Popa wrote:
> >>It's the 10th resume and in /proc/interrupts eth0 appers 10 times.
> >The e100_resume() function should be calling netif_device_detach and
> >free_irq. Could you try the following (compile tested) patch?
> 
> I just fixed suspend/shutdown for e100 in 2.6.19, not sure why the problem still shows up. Since it's a driver/net issue, you 
> should CC netdev on it tho, otherwise it might go unnoticed.
Thanks for adding the CC
> 
> I'll open up the can-o-worms on this issue and see what's up with it.
> 
> I'm not so sure that this patch is OK, and I wonder why it stopped working, because I spent quite some time fixing it only a 
> few months ago. Did swsup change again? sigh...

I may well be wrong (It appears that most of the time I am :)), but the
unbalanced netif_device_attach (in resume) looks suspicious.  resume()
also calls request_irq, so calling free_irq on suspend seemed logical.

Regards,
Frederik

> 
> Auke
> 
> >Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>
> >diff --git a/drivers/net/e100.c b/drivers/net/e100.c
> >index 2fe0445..0c376e4 100644
> >--- a/drivers/net/e100.c
> >+++ b/drivers/net/e100.c
> >@@ -2671,6 +2671,7 @@ static int e100_suspend(struct pci_dev *pdev, pm_message_t state)
> > 	del_timer_sync(&nic->watchdog);
> > 	netif_carrier_off(nic->netdev);
> > +	netif_device_detach(netdev);
> > 	pci_save_state(pdev);
> >  	if ((nic->flags & wol_magic) | e100_asf(nic)) {
> >@@ -2682,6 +2683,7 @@ static int e100_suspend(struct pci_dev *pdev, pm_message_t state)
> > 	}
> >  	pci_disable_device(pdev);
> >+	free_irq(pdev->irq, netdev);
> > 	pci_set_power_state(pdev, PCI_D3hot);
> >  	return 0;
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
