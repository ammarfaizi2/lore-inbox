Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbUALXbi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbUALXbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:31:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:52451 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263836AbUALXbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:31:35 -0500
Date: Mon, 12 Jan 2004 15:04:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel Alder IOAPIC fix
In-Reply-To: <1073948641.4178.76.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
References: <1073876117.2549.65.camel@mulgrave>  <Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
 <1073948641.4178.76.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Jan 2004, James Bottomley wrote:
> 
> So BAR0 is actually the location of the second I/O APIC's mapped address
> range (which we've already covered with a fixmap from the MP TABLE). 
> I've no idea what the other four BARs all with addresses at 0xfffffc00
> are doing.
> 
> The only way to prevent the current code (in arch/i386/pci/i386.c) from
> reassigning this range seems to be to set the resource start to zero.

Ok. What I think we should do is to have a special quirk for chips like 
this that just _force_ the BAR values into the resource allocation table, 
and ignore things like the existing BIOS-marked allocations - because 
obviously the BIOS-marked ones are going to overlap.

This is where that "insert_resource()" thing comes in. Something like this 
might just work as a quirk:

	adler_quirk(struct pci_dev *dev)
	{
		int i;

		for (i = 0; i < 6; i++) {
			if (!pci_resource_start(dev, i))
				continue;
			if (!pci_resource_len(dev, i))
				continue;
			insert_resource(&iomem_resource, dev->resource + i);
		}
	}

and then make sure that the PCI layer doesn't try to re-allocate the 
resource some other way (I forget - maybe it already notices when the 
resource has already been inserted into the resource tree - otherwise you 
might need to add the code that says "if this resource is already 
inserted, don't try to reallocate it").

		Linus
