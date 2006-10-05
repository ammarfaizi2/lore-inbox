Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWJEXII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWJEXII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWJEXII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:08:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932418AbWJEXIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:08:04 -0400
Date: Thu, 5 Oct 2006 16:07:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Jeff Garzik <jeff@garzik.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
In-Reply-To: <200610060052.46538.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0610051600440.3952@g5.osdl.org>
References: <200610051910.25418.ak@suse.de> <452564B9.4010209@garzik.org>
 <Pine.LNX.4.64.0610051536590.3952@g5.osdl.org> <200610060052.46538.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Oct 2006, Andi Kleen wrote:
> 
> > In other words, right now we have
> > 
> > 	int pci_read_config_byte(struct pci_dev *dev, int where, u8 *val)
> > 
> > and maybe we will simply have to add a totally new function like
> > 
> > 	int pci_read_mmio_config_byte(struct pci_dev *dev, int where, u8 *val)
> > 
> > for drivers that literally _require_ the mmio accesses for one reason or 
> > another.
> 
> That's easy to decide: if (where >= 256) mmconfig is required. 
> 
> I'm just afraid it probably won't help if the MCFG is totally broken and
> points to some other devices (like on the Intel boards). Then these drivers will 
> just hang and all of Alan's warning  messages won't help with that.

Sure. I'd actually prefer a separate interface partly for that reason, and 
partly also because I think the whole "pci_read_config_xxx()" interface 
has always been horrible.

If we had the

	void __iomem *cfg = mmiocfg_remap(dev);

interface, we could (fairly easily) blacklist known-bad motherboards if we 
needed to, and also, it would allow drivers to check whether mmiocfg is 
available. It's possible that some drivers might want it if it exists, but 
it wouldn't necessarily be somethign that they _require_, so they could 
gracefully handle the case of getting a NULL config space handle back.

For example, for some devices, maybe they'd lose some error handling 
capability, but they'd still be able to work otherwise.

We _can_ do the same thing with checking the error return value from 
"pci_read_config_xxxx()", and use the "use different access method if the 
index is >= 256", but I have to say, that just makes my gag reflex 
trigger. Having the same function just silently do two different things 
depending on the offset just sounds like a recipe for disaster.

I dunno. I'm not likely to care _that_ deeply about this all, but I do 
think that machines that hang on device discovery is just about the worst 
possible thing, so I'd much rather have ten machines that can't use their 
very rare devices without some explicit kernel command line than have even 
_one_ machine that just hangs because MMIOCFG is buggered.

(And we should probably have the "pci=mmiocfg" kernel command line entry 
that forces MMIOCFG regardless of any e820 issues, even for normal 
accesses).

			Linus
