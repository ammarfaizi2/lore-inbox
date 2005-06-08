Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVFHMYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVFHMYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 08:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVFHMYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 08:24:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53659 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262193AbVFHMXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 08:23:54 -0400
Date: Wed, 8 Jun 2005 14:23:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Adam Belay <abelay@novell.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, greg@kroah.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>
Subject: Re: [PATCH] fix tulip suspend/resume
Message-ID: <20050608122320.GC1898@elf.ucw.cz>
References: <20050606224645.GA23989@pingi3.kke.suse.de> <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org> <20050607025054.GC3289@neo.rr.com> <20050607105552.GA27496@pingi3.kke.suse.de> <20050607205800.GB8300@neo.rr.com> <1118190373.6850.85.camel@gaston> <1118196980.3245.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118196980.3245.68.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > > pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
> > > {
> > > 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
> > > 		return PCI_D0;
> > > 
> > > 	switch (state) {
> > > 	case 0: return PCI_D0;
> > > 	case 3: return PCI_D3hot;
> > > 	default:
> > > 		printk("They asked me for state %d\n", state);
> > > 		BUG();
> > > 	}
> > > 	return PCI_D0;
> > > }
> > 
> > Gack ! I need to remember to fix that one before I change PMSG_FREEZE
> > definition to be different than PMSG_SUSPEND upstream.
> > 
> > Pavel, do you know that there are other ways to deal with errors than
> > just BUG()'ing all over the place ? :)
> > 
> > Ben.
> 
> I think we should also use the pm_message_t defines.  We will need to
> add PMSG_FREEZE eventually.  I decided to default to the current state
> rather than panic.  Does this patch look ok?

No.

> --- a/drivers/pci/pci.c	2005-05-27 22:06:02.000000000 -0400
> +++ b/drivers/pci/pci.c	2005-06-07 22:10:02.066151280 -0400
> @@ -320,13 +320,15 @@
>  		return PCI_D0;
>  
>  	switch (state) {
> -	case 0: return PCI_D0;
> -	case 3: return PCI_D3hot;
> +	case PMSG_ON:
> +		return PCI_D0;
> +	case PMSG_SUSPEND:
> +		return PCI_D3hot;

Please don't do this; it will not compile when I turn on type checking
on pm_message_t. I have this:

/**
 * pci_choose_state - Choose the power state of a PCI device
 * @dev: PCI device to be suspended
 * @state: target sleep state for the whole system. This is the value
 *      that is passed to suspend() function.
 *
 * Returns PCI power state suitable for given device and given system
 * message.
 */

pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
{
        switch (state.event) {
        case PM_EVENT_ON:
                return PCI_D0;
        case PM_EVENT_FREEZE:
        case PM_EVENT_SUSPEND:
                return PCI_D3hot;
        default:
                printk("They asked me for state %d\n", state.event);
                BUG();
        }
        return PCI_D0;
}

>  	default:
> -		printk("They asked me for state %d\n", state);
> -		BUG();
> +		printk(KERN_ERR "PCI: invalid PM message state - %d\n", state);
>  	}
> -	return PCI_D0;
> +
> +	return dev->current_state;
>  }

You passed invalid argument; I see no reason why you should paper over
it and risk continuing. This happens during system suspend; it is
quite possible that user will not see your printk when machine powers
off just after that; and remember that it will not be in syslog after
resume.

								Pavel
