Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265173AbUAFBl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUAFBl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:41:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:53715 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265173AbUAFBl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:41:56 -0500
Date: Mon, 5 Jan 2004 17:41:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Hinds <dhinds@sonic.net>
cc: linux-kernel@vger.kernel.org, Amit <mehrotraamit@yahoo.co.in>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
In-Reply-To: <Pine.LNX.4.58.0401051707390.2170@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0401051731440.2170@home.osdl.org>
References: <20040105120707.A18107@sonic.net> <Pine.LNX.4.58.0401051630190.2170@home.osdl.org>
 <20040105164423.A30738@sonic.net> <Pine.LNX.4.58.0401051707390.2170@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004, Linus Torvalds wrote:
> 
> Hmm.. I suspect that it might be ok to check "max_pfn" for being less than 
> 4GB, and use that if so. Add something like
> 
> 	if (max_pfn < 0x100000)
> 		if (pci_mem_start < (max_pfn << PAGE_SHIFT))
> 			pci_mem_start  = max_pfn << PAGE_SHIFT;

Actually, that would suck.

I think the proper fix would be to make the "mem=" stuff do the right 
thing to the iomem_resource handling, and add the "round up" code there 
too (and mark it as being reserved). 

Basically, it shouldn't be impossible to get a "reasonably good" map from 
"mem=xxxx" that would work more of the time. It wouldn't necessarily be 
perfect, but it would be better than what we have now.

You can always use much more complicated "exactmap" stuff to really 
generate a full e820 map, but I suspect nobody has ever done that in real 
life. Something like

	mem=exactmap mem=0x9f000@0 mem=0xfe00000@0x100000 mem=0x100000$0xff00000

can be used to give you 255MB of RAM with the last 1MB marked as being 
"reserved". 

Or it _should_ work that way. I've never used it myself ;)

Anyway, we could change what the "simple" form of "mem=xxx" means to 
something that is more likely to have success. Anybody willing to look at 
this?

		Linus
