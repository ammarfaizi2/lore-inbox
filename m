Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbUBTSYU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbUBTSYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:24:19 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:44219 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261269AbUBTSVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:21:54 -0500
In-Reply-To: <Pine.LNX.4.58.0402200714270.1107@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com> <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org> <1077256996.20789.1091.camel@gaston> <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org> <1077258504.20781.1121.camel@gaston> <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org> <1077259375.20787.1141.camel@gaston> <Pine.LNX.4.58.0402192257190.1107@ppc970.osdl.org> <20040219230407.063ef209.davem@redhat.com> <1077261041.20787.1181.camel@gaston> <20040219233214.56f5b0ce.davem@redhat.com> <Pine.LNX.4.58.0402200714270.1107@ppc970.osdl.org>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CBEF20EA-63D0-11D8-AE86-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: "David S. Miller" <davem@redhat.com>, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-usb-devel@lists.sourceforge.net
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [BK PATCH] USB update for 2.6.3
Date: Fri, 20 Feb 2004 12:15:43 -0600
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 20, 2004, at 9:15 AM, Linus Torvalds wrote:
>
> On Thu, 19 Feb 2004, David S. Miller wrote:
>> On Fri, 20 Feb 2004 18:10:41 +1100
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>
>>> Hrm... so if the USB device drivers are actually doing the dma 
>>> mapping
>>> themselves, it make sense for them to pass their own struct device, 
>>> no ?
>>
>> That's right, at least that was the idea.
>
> No. That would be _fundamentally_ wrong.
>
> There's no way a USB device can do DMA in the first place. It has no 
> DMA
> controller, and no way to read/write memory except through the USB 
> host.
>
> So it is the host - and only the host - that matters. Anything else is 
> a
> bug.

Sure. So dma-mapping.h does this:
	int dma_supported(struct device *dev, u64 mask) {
		return device->bus->dma_supported(dev, u64 mask);
	}

And USB, when it creates its bus_type, does this:
	int usb_dma_supported(struct device *dev, u64 mask) {
		usb_dev *usbdev = to_usb_device(dev);
		return usbdev->root_hub->controller->bus->dma_supported(controller, 
u64 mask)
	}
And of then PCI has:
	int pci_dma_supported(struct device *dev, u64 mask) {
		pci_dev *pcidev = to_pci_dev(dev, u64 mask);
		...
	}

Then a USB driver uses its own usb_device->dev and it all ends up back 
at the PCI bus.

For PCI devices of course, device->bus->dma_supported() *is* 
pci_dma_supported(), so there's no middleman (as USB is above).

-- 
Hollis Blanchard
IBM Linux Technology Center

