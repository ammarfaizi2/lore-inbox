Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVBNTwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVBNTwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 14:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVBNTwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 14:52:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32721 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261545AbVBNTvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 14:51:47 -0500
Message-ID: <4211013E.6@pobox.com>
Date: Mon, 14 Feb 2005 14:51:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: avoiding pci_disable_device()...
References: <4210021F.7060401@pobox.com> <20050214190619.GA9241@kroah.com>
In-Reply-To: <20050214190619.GA9241@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Feb 13, 2005 at 08:42:55PM -0500, Jeff Garzik wrote:
> 
>>Currently, in almost every PCI driver, if pci_request_regions() fails -- 
>>indicating another driver is using the hardware -- then 
>>pci_disable_device() is called on the error path, disabling a device 
>>that another driver is using
>>
>>To call this "rather rude" is an understatement :)
>>
>>Fortunately, the ugliness is mitigated in large part by the PCI layer 
>>helping to make sure that no two drivers bind to the same PCI device. 
>>Thus, in the vast majority of cases, pci_request_regions() -should- be 
>>guaranteed to succeed.
>>
>>However, there are oddball cases like mixed PCI/ISA devices (hello IDE) 
>>or cases where a driver refers a pci_dev other than the primary, where 
>>pci_request_regions() and request_regions() still matter.
> 
> 
> But this is a very small subset of pci devices, correct?

No.  You also need to consider situations such as out-of-tree drivers 
for the same hardware (might not use PCI API), and situations where you 
have peer devices discovered and used (PCI API doesn't have "hey, <this> 
device is associated with <current driver>, too" capability)


>>As a result, I have committed the attached patch to libata-2.6.  In many 
>>cases, it is a "semantic fix", addressing the case
>>
>>	* pci_request_regions() indicates hardware is in use
>>	* we rudely disable the in-use hardware
>>
>>that would not occur in practice.
>>
>>But better safe than sorry.  Code cuts cut-n-pasted all over the place.
>>
>>I'm hoping one or two things will happen now:
>>* janitors fix up the other PCI drivers along these lines
>>* improve the PCI API so that pci_request_regions() is axiomatic
> 
> 
> Do you have any suggestions for how to do this?

I'm glad you asked ;-)  As the author of pci_disable_device() and 
pci_request_regions(), I recognized their inadequacy almost immediately.

There are some fundamental flaws in the API that need correcting:

* pci_disable_device() should perform exactly the opposite of 
pci_enable_device(), no more, no less.   It should NOT unconditionally 
disable the device, but instead restore the hardware to the state it was 
in prior to pci_enable_device().

* pci_request_regions() should be axiomatic.  By that I mean, 
pci_enable_device() should
	(a) handle pci_request_regions() completely
	(b) fail if regions are not available

* pci_enable_device() may touch the hardware when it should not.  In an 
ideal world, pci_enable_device() would
	* assign resources to device, if necessary
	* request_resource()s [aka pci_request_regions()]
	* enable device by setting bits in PCI_COMMAND, etc.
but since the request-resource step is assumed to occur after 
pci_enable_device() returns to the driver, this is impossible.


The solution?  I am still thinking.  My gut feeling is that we want a 
slightly higher level PCI API for drivers.  Drivers pass in an 'info' 
structure to pci_up().  pci_up() enables the device, requests resources 
(not just irq), maps resources as necessary, enables irqs and/or MSI as 
necessary, and similar housekeeping.  pci_down() does the precise 
opposite. Essentially, pci_up() is a lib function that kills a ton of 
duplicate code from the vast majority of PCI drivers.


OTOH, Alan's suggestion seems sane and a lot more simple, but doesn't 
address the flaws in the API.

	Jeff


