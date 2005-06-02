Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVFBClJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVFBClJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 22:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVFBClJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 22:41:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:25494 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261572AbVFBClB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 22:41:01 -0400
Message-ID: <429E71CB.3010609@sgi.com>
Date: Wed, 01 Jun 2005 22:41:15 -0400
From: Prarit Bhargava <prarit@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: scottm@somanetworks.com
CC: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] PCI Hotplug: more CPCI updates
References: <11176025242587@kroah.com>
In-Reply-To: <11176025242587@kroah.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> [PATCH] PCI Hotplug: more CPCI updates

> - Switch to pci_get_slot instead of deprecated pci_find_slot.
> - A bunch of CodingStyle fixes.

> -			}
> +		dev = pci_get_slot(slot->bus, PCI_DEVFN(slot->number, 0));
> +		if (dev) {
> +			if (update_adapter_status(slot->hotplug_slot, 1))
> +				warn("failure to update adapter file");
> +			if (update_latch_status(slot->hotplug_slot, 1))
> +				warn("failure to update latch file");
> +			slot->dev = dev;
>  		}
>  	}

I don't claim to know the code as well as Scott or Greg does, but I don't see a 
pci_put_dev for the slot->dev to clean up the usage count?

> @@ -311,10 +277,10 @@ int cpci_configure_slot(struct slot* slo
>  		 */
>  		n = pci_scan_slot(slot->bus, slot->devfn);
>  		dbg("%s: pci_scan_slot returned %d", __FUNCTION__, n);
> -		if(n > 0)
> +		if (n > 0)
>  			pci_bus_add_devices(slot->bus);
> -		slot->dev = pci_find_slot(slot->bus->number, slot->devfn);
> -		if(slot->dev == NULL) {
> +		slot->dev = pci_get_slot(slot->bus, slot->devfn);
> +		if (slot->dev == NULL) {
>  			err("Could not find PCI device for slot %02x", slot->number);
>  			return 1;
>  		}

Same here -- I don't see a pci_put_dev for the slot->dev.

> @@ -341,15 +305,15 @@ int cpci_unconfigure_slot(struct slot* s
>  	struct pci_dev *dev;
>  
>  	dbg("%s - enter", __FUNCTION__);
> -	if(!slot->dev) {
> +	if (!slot->dev) {
>  		err("No device for slot %02x\n", slot->number);
>  		return -ENODEV;
>  	}
>  
>  	for (i = 0; i < 8; i++) {
> -		dev = pci_find_slot(slot->bus->number,
> +		dev = pci_get_slot(slot->bus,
>  				    PCI_DEVFN(PCI_SLOT(slot->devfn), i));
> -		if(dev) {
> +		if (dev) {
>  			pci_remove_bus_device(dev);
>  			slot->dev = NULL;
>  		}

And again here...

P.
