Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVCXVFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVCXVFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVCXVFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:05:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18922 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261354AbVCXVEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:04:41 -0500
Message-ID: <42432B59.70003@pobox.com>
Date: Thu, 24 Mar 2005 16:04:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Kylene Hall <kjhall@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add TPM hardware enablement driver
References: <1110415321526@kroah.com> <422FC42B.7@pobox.com> <Pine.LNX.4.61.0503161811020.5212@jo.austin.ibm.com> <4240CE30.2060105@pobox.com> <20050324063933.GC10355@kroah.com>
In-Reply-To: <20050324063933.GC10355@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Mar 22, 2005 at 09:02:24PM -0500, Jeff Garzik wrote:
> 
>>Kylene Hall wrote:
>>
>>>>what is the purpose of this pci_dev_get/put?  attempting to prevent 
>>>>hotplug or
>>>>something?
>>>
>>>
>>>Seems that since there is a refernce to the device in the chip structure 
>>>and I am making the file private data pointer point to that chip structure 
>>>this is another reference that must be accounted for. If you remove it 
>>>with it open and attempt read or write bad things will happen.  This isn't 
>>>really hotpluggable either as the TPM is on the motherboard.
>>
>>My point was that there will always be a reference -anyway-, AFAICS. 
>>There is a pci_dev reference assigned to the pci_driver when the PCI 
>>driver is loaded, and all uses by the TPM generic code of this pointer 
>>are -inside- the pci_driver's pci_dev object lifetime.
> 
> 
> Think of the following situation:
> 	- driver is bound to device.
> 	- userspace opens char dev node.
> 	- device is removed from the system (using fakephp I can do this
> 	  to _any_ pci device, even if it is on the motherboard.)
> 	- userspace writes to char dev node
> 	- driver attempts to access pci device structure that is no
> 	  longer present in memory.
> 
> Because of this open needs to get a reference to the pci device to
> prevent oopses, or the driver needs to be aware of "device is now gone"
> in some other manner.

Thanks for explaining; agreed.

However, there appear to still be massive bugs in this area:

Consider the behavior of the chrdev if a PCI device has been unplugged. 
  It's still actively messing with the non-existent hardware, and never 
checks for dead h/w AFAICS.

	Jeff


