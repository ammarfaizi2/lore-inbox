Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbUAFEFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 23:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266068AbUAFEFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 23:05:41 -0500
Received: from colin2.muc.de ([193.149.48.15]:52232 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265756AbUAFEEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 23:04:52 -0500
Date: 6 Jan 2004 05:05:46 +0100
Date: Tue, 6 Jan 2004 05:05:46 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, David Hinds <dhinds@sonic.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040106040546.GA77287@colin2.muc.de>
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0401051937510.2653@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401051937510.2653@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 07:40:11PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 6 Jan 2004, Andi Kleen wrote:
> > 
> > IMHO the only reliable way to get physical bus space for mappings
> > is to allocate some memory and map the mapping over that.
> 
> You literally can't do that: the RAM addresses are decoded by the 
> northbridge before they ever hit the PCI bus, so it's impossible to "map 
> over" RAM in general. 

Are you sure? I have a doc from AMD somewhere on the memory ordering
on K8 and it gives this order: (highest to lowest) 

AGP aperture, TSEG, ASEG, IORR, Fixed MTRR, TOP_MEM

Note that TOP_MEM comes last, IORR comes earlier.  It would require
setting an IORR though, which would be admittedly a bit nasty
(there are not that many of them). As long as it is only a single
area it should be possible though, we already have some code to change
IORRs in the AGP driver.   That would be admittedly AMD specific,
but I suspect Intel has a similar mechanism.

I have successfully mapped the AGP aperture
over RAM and also seen it shadowing PCI mappings. I admit I haven't tried
it with PCI mappings.  

But can you suggest a reliable way to find a memory hole in e820?
I haven't one figured out and AFAIK there isn't even any guarantee 
by the BIOS that there is any. e.g. Opteron BIOS tend to use all
the precious space < 4GB up for existing mappings and I would expect
other i386 BIOS to behave the same.

-Andi
