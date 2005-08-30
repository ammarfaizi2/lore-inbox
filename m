Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVH3EmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVH3EmD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVH3EmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:42:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:30422 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932123AbVH3EmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:42:01 -0400
Subject: Re: Ignore disabled ROM resources at setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       helgehaf@aitel.hist.no
In-Reply-To: <20050829.212021.43291105.davem@davemloft.net>
References: <1125371996.11963.37.camel@gaston>
	 <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
	 <Pine.LNX.4.58.0508292056530.3243@g5.osdl.org>
	 <20050829.212021.43291105.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 14:37:08 +1000
Message-Id: <1125376628.11949.51.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 21:20 -0700, David S. Miller wrote:
> From: Linus Torvalds <torvalds@osdl.org>
> Date: Mon, 29 Aug 2005 21:09:24 -0700 (PDT)
> 
> > So 2.6.13 is being "safe". It allocates the space for the ROM in the
> > resource tables, but it neither enables it nor does it write the
> > (disabled) address out to the device, since both of those actions have
> > been shown to break on PC's. And sadly (or happily, depends on your
> > viewpoint), PC's have a _much_ wider range of hardware, so they are the
> > ones we have to work around.
> 
> Actually, I can tell you that it is a known fact that Qlogic ISP
> PCI cards will not respond to I/O and MEM space when you enable
> the ROM.  And this behavior exists in quite a few other PCI parts
> as well.

Yes, including Matrox cards.

> So I think the kernel, by not enabling the ROM, is doing the
> right thing here.

It is, the problem is that not only it doesn't enable it, but it also
doesn't write the resource to the BAR, which triggers a bug in
pci_map_rom which then enables the decoding but doesn't update the BAR
with the new address neither.

Note also the, imho totally broken, code in pci_map_rom_copy() which is
supposed to keep a cached copy of the ROM in memory specifically for
these cards to have an easier access afterward (or for sysfs rom file
access to work).

I think that code should have a pointer in pci_dev for the cache instead
of stuffing a kernel virtual address in the middle of the resouce tree.

Ben.


