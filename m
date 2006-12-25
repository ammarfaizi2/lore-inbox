Return-Path: <linux-kernel-owner+w=401wt.eu-S1754242AbWLYEBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242AbWLYEBq (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 23:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754240AbWLYEBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 23:01:46 -0500
Received: from iabervon.org ([66.92.72.58]:1496 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221AbWLYEBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 23:01:45 -0500
Date: Sun, 24 Dec 2006 23:01:43 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Petr Vandrovec <petr@vandrovec.name>
cc: jeff@garzik.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Unbreak MSI on ATI devices
In-Reply-To: <20061221075540.GA21152@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.64.0612242116090.20138@iabervon.org>
References: <20061221075540.GA21152@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006, Petr Vandrovec wrote:

> So my question is - what is real reason for disabling INTX when in MSI mode?
> According to PCI spec it should not be needed.

The PCI spec is at least not clear enough on the matter to keep nVidia 
from thinking that it's the OS's responsibility to make legacy interrupts 
not happen, by disabling INTX.

> None of devices in the box assert INTX while in MSI even if INTX is enabled.

I've got a forcedeth-driven ethernet card that does, and people have 
reported that nVidia "Intel HDA" sound does as well.

> So I'd like to see first patch below accepted.  If there are some 
> devices which require INTX disabling, then apparently decision whether 
> to disable it or no has to be moved to device drivers, or some 
> blacklist/whitelist must be created...

PCI Express (IIRC) had the pci_intx() calls already, so it's probably 
actually required by the spec (or at least common implementations) there. 

I'd guess that it's more common for hardware to be unhappy with intx 
enabled than to be unhappy with intx disabled, since the hardware is 
supposed to not send legacy interrupts.

> I'm not sure about second one - I have it in my tree for months, but I run 
> that kernel only on hardware mentioned above, so it is probably too dangerous 
> until pci_enable_msi() gets answer whether MSI works or no always right.

I think it'd be better to add an module parameter, like in the later 
drivers in your patch. Figuring out how to get MSI working whenever it's 
available isn't going to move forward unless there's an easy way to test 
it, especially since (according to rumor) Windows doesn't use it at all.

> /proc/interrupts after patch.  Before patch *hci_hcd:usb* were at zero, 
> IRQ21 was stuck with IRQ count at 10000, and HCD complained about 
> "Unlink after no-IRQ?".

Maybe the intx disable is just totally broken for your device? It 
certainly shouldn't cause the delivery of *more* legacy interrupts, and if 
it does with MSI enabled, I'd be surprised if it didn't without MSI. My 
guess is that that device should get a quirk to just leave the INTx 
disable bit alone (such that pci_intx doesn't do anything, regardless of 
context).

> diff -uprdN linux/sound/pci/atiixp.c linux/sound/pci/atiixp.c
> --- linux/sound/pci/atiixp.c	2006-12-16 13:35:47.000000000 -0800
> +++ linux/sound/pci/atiixp.c	2006-12-16 13:57:09.000000000 -0800
> @@ -1442,6 +1446,11 @@ static int snd_atiixp_suspend(struct pci
>  	snd_atiixp_aclink_down(chip);
>  	snd_atiixp_chip_stop(chip);
>  
> +	if (chip->have_msi) {
> +		pci_disable_msi(pci);
> +	} else {
> +		pci_intx(pci, 0);
> +	}

This doesn't look right, at least for !chip->have_msi. Or is disabling 
intx desirable here for non-MSI? I'd guess that devices that freak out if 
you fiddle with intx are likely to be old, and therefore likely to not 
support MSI.

> @@ -1532,6 +1546,11 @@ static int snd_atiixp_free(struct atiixp
>  	if (chip->remap_addr)
>  		iounmap(chip->remap_addr);
>  	pci_release_regions(chip->pci);
> +	if (chip->have_msi) {
> +		pci_disable_msi(chip->pci);
> +	} else {
> +		pci_intx(chip->pci, 0);
> +	}

My playing with forcedeth trying to get my system working suggests that 
the expected intx state for a device with no driver is "not disabled". I 
think the else clause here would cause the device to not work if you used 
this driver, unloaded the module, and loaded a version without the patch 
(or kexeced an older kernel, or soft-rebooted into some operating system 
without MSI support).

	-Daniel
*This .sig left intentionally blank*
