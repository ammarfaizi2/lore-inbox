Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753418AbWKHSLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753418AbWKHSLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbWKHSLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:11:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45989 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753418AbWKHSLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:11:50 -0500
Date: Wed, 8 Nov 2006 10:08:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>, Jeff Chua <jeff.chua.linux@gmail.com>
cc: Matthew Wilcox <matthew@wil.cx>, Andi Kleen <ak@suse.de>,
       Aaron Durbin <adurbin@google.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [discuss] Re: 2.6.19-rc4: known unfixed regressions (v3)
In-Reply-To: <Pine.LNX.4.64.0611080932320.3667@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0611080951040.3667@g5.osdl.org>
References: <Pine.LNX.4.64.0611080056480.12828@silvia.corp.fedex.com>
 <20061107171143.GU27140@parisc-linux.org> <200611080839.46670.ak@suse.de>
 <20061108122237.GF27140@parisc-linux.org> <Pine.LNX.4.64.0611080803280.3667@g5.osdl.org>
 <20061108172650.GC4729@stusta.de> <Pine.LNX.4.64.0611080932320.3667@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Nov 2006, Linus Torvalds wrote:
>
> And pci_mmcfg_init() will refuse to even use MMCONFIG unless either the 
> direct probe failed _or_ the MMCONFIG area is marked entirely reserved 
> in the e820 tables. Exactly because MMCONFIG generally doesn't _work_.

Ahh. I see the bug now.

When we check whether MMCONFIG is ok, we do this:

	if (type == 1 && !e820_all_mapped(pci_mmcfg_config[0].base_address,
			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
                        E820_RESERVED)) {

ie we check whether there is room for MMCONFIG_APER_MIN reserved things.

We then _reserve_ a totally different region in 
pci_mmcfg_insert_resources(), because we use a totally different range.

What a piece of crap. 

Andi, I'm getting really upset about this kind of thing. You've been very 
much not careful about MMCFG in general, and are allowing total crap to go 
into the kernel, without any thought. Just "testing" something isn't good 
enough, it needs to be thought out.

I'm going to revert that totally bogus commit that added that broken 
"pci_mmcfg_insert_resources()" function. It could be done right, but doing 
it right would require that the function 

 - be called _before_ deciding to use MMCFG 
 - return an error number if it couldn't allocate the things
 - check that the region was reserved

and then if some reservation failed, we shouldn't use MMCONFIG in the 
first place. 

We really should stop using MMCONFIG entirely, until we have a 
per-southbridge true knowledge of what the real decoding is. The BIOS 
tables for this are simply too damn unreliable.

		Linus
