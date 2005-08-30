Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVH3EfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVH3EfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVH3EfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:35:15 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:39799 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932118AbVH3EfN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:35:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RXiqDu/PbbpwJ+UJEkPjLJ60g3QK8MK4URaAtbXwBeCHrclt2Ww3NuMiJqiTjPpiPJW/uCAeJGfZ1SlENxzrIaHlkhtr1rvHU5qR/5JSRoHWKjaVJJ2ZG6On3qVH5NiF9L4a3/2zXwcH4lPktXz6BTk6QdFzObV8VoQpARQfIbU=
Message-ID: <9e47339105082921356543098c@mail.gmail.com>
Date: Tue, 30 Aug 2005 00:35:11 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Ignore disabled ROM resources at setup
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, helgehaf@aitel.hist.no,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1125369485.11949.27.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508261859.j7QIxT0I016917@hera.kernel.org>
	 <1125369485.11949.27.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> While looking there, I also noticed pci_map_rom_copy() stuff and I'm
> surprised it was ever accepted in the tree. While I can understand that
> we might need to keep a cached copy of the ROM content (due to cards
> like matrox who can't enable both the ROM and the BARs among other
> issues), the whole idea of whacking a kernel virtual pointer in the
> struct resource->start of the ROM bar is just too disgusting for words
> and will probably cause "intersting" side effects in /proc, sysfs and
> others... Shouldn't we just have a pointer in pci_dev for the optional
> "ROM cache" instead ?

We should just delete the ROM copy stuff. It is there because the PCI
spec allows for the ROM address decoder to be reused and the PCI
people wanted it for completeness. It is legal to build a card that
uses the address decoder to get at the ROM, then when the ROM was run
it would set the same address decoder to decode other hardware on the
card. You need to copy the ROM since once the decoder is changed you
can't get to the ROM any more.

As far as I can tell no one has built recent hardware this way. But I
believe there are some old SCSI controllers that do this. I provided a
ROM API for disabling sysfs access, if we identify one of these cards
we should just add a call to it's driver to disable ROM access instead
of bothering with the copy. Currently the copy is not being used
anywhere in the kernel.

-- 
Jon Smirl
jonsmirl@gmail.com
