Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVBQTfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVBQTfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVBQTco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:32:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26544 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262347AbVBQTWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:22:54 -0500
Message-ID: <4214EEF6.4030309@pobox.com>
Date: Thu, 17 Feb 2005 14:22:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Christophe Lucas <c.lucas@ifrance.com>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [KJ] [PATCH] drivers/char/watchdog/* : pci_request_regions
References: <20050214150111.GH20620@rhum.iomeda.fr> <20050214151244.GF29917@parcelfarce.linux.theplanet.co.uk> <4214E728.3030501@pobox.com> <20050217190408.GW29917@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050217190408.GW29917@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Thu, Feb 17, 2005 at 01:49:12PM -0500, Jeff Garzik wrote:
> 
>>Matthew Wilcox wrote:
>>
>>>On Mon, Feb 14, 2005 at 04:01:11PM +0100, Christophe Lucas wrote:
>>>
>>>
>>>>If PCI request regions fails, then someone else is using the
>>>>hardware we wish to use. For that one case, calling
>>>>pci_disable_device() is rather rude.
>>>>See : http://www.ussg.iu.edu/hypermail/linux/kernel/0502.1/1061.html
>>>
>>>
>>>Actually, that isn't necessarily true.  If the request_regions call fails,
>>>that can mean there's a resource conflict.  If so, leaving the device
>>>enabled is the worst possible thing to do as we'll now have two devices
>>>trying to respond to the same io accesses.
>>
>>Incorrect.  If request_region() fails, drivers are coded to _not_ touch 
>>the hardware.  That's the entire purpose of the whole charade: to avoid 
>>having two devices responding to the same io accesses.
>>
>>If your driver is talking to the hardware after request_region() fails, 
>>it is BROKEN plain and simple.
> 
> 
> I don't think you understood my point.  Assume we really do have two
> devices in the system with clashing resource settings.  Yes, I really
> have seen this happen; it's rare.
> 
> While the PCI device is disabled, there is no problem.  But then we call
> pci_enable_device(), so now the device is enabled to respond to IO and
> memory resources in its BARs.
> 
> At the point we discover this, we need to disable the PCI device again
> -- exactly the opposite behaviour from your case where we need to leave
> the PCI device enabled when we have resource conflicts.

> I think the only way to fix this is have pci_enable_device claim the
> resources for the BARs before enabling the PCI device to respond to the
> resources; that way we leave the enable bits the way they currently are.
> No, this doesn't cure the world's ills, but it does obey "First, do
> no harm".  One way it'll fail is if the other driver loads after the PCI
> driver that claims this resource.

Ok, I agree with this, it echoes what I said in another message in this 
thread ;-)  namely,

* the fact that pci_enable_device() does not claim the resources is a 
problem.  pci_request_regions() should not be a separate step.

* the fact that pci_disable_device() does not perform the _exact_ 
opposite of the operations that pci_enable_device() performed is a 
problem.  pci_disable_device() should not just unconditionally stop the 
decoder bits, then exit.

	Jeff


