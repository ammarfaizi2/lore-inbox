Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265801AbUAFFEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 00:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265855AbUAFFEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 00:04:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:20193 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265801AbUAFFEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 00:04:46 -0500
Date: Mon, 5 Jan 2004 21:04:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@colin2.muc.de>
cc: Andi Kleen <ak@muc.de>, David Hinds <dhinds@sonic.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
In-Reply-To: <20040106040546.GA77287@colin2.muc.de>
Message-ID: <Pine.LNX.4.58.0401052100380.2653@home.osdl.org>
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org>
 <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Jan 2004, Andi Kleen wrote:
> > 
> > You literally can't do that: the RAM addresses are decoded by the 
> > northbridge before they ever hit the PCI bus, so it's impossible to "map 
> > over" RAM in general. 
> 
> Are you sure? I have a doc from AMD somewhere on the memory ordering
> on K8 and it gives this order: (highest to lowest) 
> 
> AGP aperture, TSEG, ASEG, IORR, Fixed MTRR, TOP_MEM

Those are all in the CPU or northbridge (well, on the opteron, the 
northbridge is integrated so it all boils down to the CPU).

So yes, I'm sure. You have to have northbridge-specific code to punch a 
"hole" in the RAM decoder, and some of them are "bios-locked", ie they 
have registers that become read-only after the first time they are written 
(or after a special lock-bit has been written). 

So in some cases you can't do it at all.

> I have successfully mapped the AGP aperture
> over RAM and also seen it shadowing PCI mappings. I admit I haven't tried
> it with PCI mappings.  

The AGP aperture is generally done in the northbridge, so it all depends 
on what the decode priority is for the northbridge chip. That's 
implementation-dependent.

> But can you suggest a reliable way to find a memory hole in e820?
> I haven't one figured out and AFAIK there isn't even any guarantee 
> by the BIOS that there is any. e.g. Opteron BIOS tend to use all
> the precious space < 4GB up for existing mappings and I would expect
> other i386 BIOS to behave the same.

If you ahve a proper e820 map, then it should work correctly, with 
anything that is RAM being marked as such (or being marked as "reserved").

The problems happen when you do _not_ have a proper e820 map, either due 
to bootloader bugs or BIOS problems, or because the user overrode the 
values with a "mem=xxxx" thing.

		Linus
