Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263069AbVCXHHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbVCXHHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 02:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263072AbVCXHGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 02:06:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:40935 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263069AbVCXHE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 02:04:28 -0500
Date: Wed, 23 Mar 2005 22:39:33 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kylene Hall <kjhall@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add TPM hardware enablement driver
Message-ID: <20050324063933.GC10355@kroah.com>
References: <1110415321526@kroah.com> <422FC42B.7@pobox.com> <Pine.LNX.4.61.0503161811020.5212@jo.austin.ibm.com> <4240CE30.2060105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4240CE30.2060105@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 09:02:24PM -0500, Jeff Garzik wrote:
> Kylene Hall wrote:
> >>what is the purpose of this pci_dev_get/put?  attempting to prevent 
> >>hotplug or
> >>something?
> >
> >
> >Seems that since there is a refernce to the device in the chip structure 
> >and I am making the file private data pointer point to that chip structure 
> >this is another reference that must be accounted for. If you remove it 
> >with it open and attempt read or write bad things will happen.  This isn't 
> >really hotpluggable either as the TPM is on the motherboard.
> 
> My point was that there will always be a reference -anyway-, AFAICS. 
> There is a pci_dev reference assigned to the pci_driver when the PCI 
> driver is loaded, and all uses by the TPM generic code of this pointer 
> are -inside- the pci_driver's pci_dev object lifetime.

Think of the following situation:
	- driver is bound to device.
	- userspace opens char dev node.
	- device is removed from the system (using fakephp I can do this
	  to _any_ pci device, even if it is on the motherboard.)
	- userspace writes to char dev node
	- driver attempts to access pci device structure that is no
	  longer present in memory.

Because of this open needs to get a reference to the pci device to
prevent oopses, or the driver needs to be aware of "device is now gone"
in some other manner.

thanks,

greg k-h
