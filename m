Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbUBTTop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUBTTlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:41:31 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:36240 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261385AbUBTTWG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:22:06 -0500
In-Reply-To: <Pine.LNX.4.58.0402201030060.2533@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com> <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org> <1077256996.20789.1091.camel@gaston> <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org> <1077258504.20781.1121.camel@gaston> <Pine.LNX.4.58.0402192243170.14296@ppc970.osdl.org> <1077259375.20787.1141.camel@gaston> <Pine.LNX.4.58.0402192257190.1107@ppc970.osdl.org> <20040219230407.063ef209.davem@redhat.com> <1077261041.20787.1181.camel@gaston> <20040219233214.56f5b0ce.davem@redhat.com> <Pine.LNX.4.58.0402200714270.1107@ppc970.osdl.org> <CBEF20EA-63D0-11D8-AE86-000A95A0560C@us.ibm.com> <Pine.LNX.4.58.0402201030060.2533@ppc970.osdl.org>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CB199764-63D9-11D8-AE86-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: "David S. Miller" <davem@redhat.com>, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-usb-devel@lists.sourceforge.net
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [BK PATCH] USB update for 2.6.3
Date: Fri, 20 Feb 2004 13:20:07 -0600
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 20, 2004, at 12:39 PM, Linus Torvalds wrote:
> (That actual bug is totally irrelevant, though. The _fundamnetal_ bug 
> is
> in your way of thinking. For one thing, if you have a function called
> "usb_dma_xxx()", then it takes a _USB_ device, not a generic device.
> Because the function clearly doesn't even WORK with a generic device, 
> it
> only works with a "struct usb_dev". So don't "lie" about things like 
> that
> in your interfaces and confuse the issue).

Well, I was picturing all those *_dma_supported() functions as being 
plugged into (new) fields in struct bus_type:
	struct bus_type {
		...
		int (*dma_supported)(struct device *dev, u64 mask);
	}

If your *_dma_supported functions only take usb_dev, pci_dev, etc, then 
you end up with code like asm-generic/dma-mapping.h:
	int dma_supported(struct device *dev, u64 mask)
	{
#ifdef CONFIG_PCI
		if (dev->bus == pci_bus_type)
			return pci_dma_supported(to_pci_dev(dev), mask);
#endif
#ifdef CONFIG_ISA
		if (dev->bus == isa_bus_type)
			return isa_dma_supported(to_isa_dev(dev), mask);
#endif
#ifdef CONFIG_BRANDNEWSUPERBUS
		if (dev->bus == brandnewsuper_bus_type)
			return brandnewsuper_dma_supported(to_brandnewsuper_dev(dev), mask);
#endif
		... list every possible bus type here ...
	}

That just seems silly to me, when you can dispatch through a 
bus_type->dma_supported() function pointer.

-- 
Hollis Blanchard
IBM Linux Technology Center

