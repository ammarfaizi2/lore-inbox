Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVILKm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVILKm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 06:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVILKm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 06:42:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:15265 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750721AbVILKm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 06:42:27 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [1/3] Add 4GB DMA32 zone
Date: Mon, 12 Sep 2005 12:42:20 +0200
User-Agent: KMail/1.8
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43246267.mailL4R11PXCB@suse.de> <1126520900.30449.48.camel@localhost.localdomain>
In-Reply-To: <1126520900.30449.48.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121242.20910.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 12:28, Alan Cox wrote:
> > One argument was still if the zone should be 4GB or 2GB. The main
> > motivation for 2GB would be an unnamed not so unpopular hardware
> > raid controller (mostly found in older machines from a particular four
> > letter company) who has a strange 2GB restriction in firmware. But
>
> Adaptec AACRAID is one offender

Yes, that one was considered. Believe me we went over all
the broken hardware cases quite a lot before comming up with this patch. 

I refuse to add unnecessary limits to everybody else just because of that 
single broken firmware. 4GB limit is really common and the oddballs like 
these have to use the same workarounds (custom bounce buffer in low GFP_DMA 
memory) they always did on machines with enough memory.

Also the aacraid is not really an big issue on x86-64, because
afaik nobody shipped EM64T or AMD64 machines with these beasts.
(most aacraid is older Xeons without 64bit capability). There
are a few users who bought plugin cards later, but near all of these
ran into other problems because they didn't have enough memory
(I cannot in fact remember a report of someone running especially
into this problem)  And the cards seem to be essentially dead in the market 
now. So it's really more a theoretical problem than a practical one.
[Proof of it: the current sources don't seem to handle it, so
it cannot be that bad ;-]

And the probability of someone using a b44 in a machine with >2GB
of memory is small at best. Usually they are in really lowend
boxes where you couldn't even plug in more memory than that.
That is why I essentially ignored the b44. AFAIK the driver
has a GFP_DMA bounce workaround anyways, so it would work
anyways.

Yes I know some soundcards have similar limits, but for all
these we still have GFP_DMA and they always have been quite happy
with that.

Basically this a solution to make a lot of common hardware happy
and the oddballs and really broken cases are not worse than
they have been before.

> > that one works ok with swiotlb/IOMMU anyways, so it doesn't really
>
> Old aacraid actually cannot use IOMMU. It isn't alone in that
> limitation. Most hardware that has a 30/31bit limit can't go via the
> IOMMU because IOMMU space appears on the bus above 2GB so is itself
> invisible to the hardware.

Yes, true. Use GFP_DMA then.

Actually swiotlb would work in theory because it tends to be pretty
low, but that is not enabled on all machines and the code doesn't
attempt to handle it (and I don't plan to do it)

Hopefully the patch can go into 2.6.13.

-Andi

