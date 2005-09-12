Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVILLwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVILLwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 07:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVILLwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 07:52:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:43959 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750765AbVILLwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 07:52:10 -0400
From: Andi Kleen <ak@suse.de>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Subject: Re: [1/3] Add 4GB DMA32 zone
Date: Mon, 12 Sep 2005 13:51:59 +0200
User-Agent: KMail/1.8
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01919BC3@otce2k03.adaptec.com>
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F01919BC3@otce2k03.adaptec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121352.00530.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mark for the corrections.

On Monday 12 September 2005 13:44, Salyzyn, Mark wrote:
> Andi Kleen writes:
> >> Adaptec AACRAID is one offender
> >
> > 4GB limit is really common and the oddballs like
> >these have to use the same workarounds (custom bounce buffer in low
>
> GFP_DMA
>
> >memory) they always did on machines with enough memory.
>
> The 2GB limit is to deal with allocation of hardware command frames
> (FIB) and thus only during initialization,
> all the adapters deliver DMA 
> to the full address range at 'run time' and the driver does open the
> limit up at that point. The reason for this strangeness is the inability
> of the Firmware to work around the Intel ATU when doing memcpy, where
> the DMA engine had no such limits.

Ok that makes a lot of sense.  You should probably be really using 
pci_alloc_consistent() instead of GFP_DMA directly here, but other than
that it should just work.

(pci_alloc_consistent has some hacks to first try the higher zones
and only use the lower zones if the allocation didn't succeed here -
on a 2GB machine you have a 50% chance that a normal allocation 
ends up below 1GB -  which make this all a bit more reliable) 

That probably explains the lack of reports about this issue
which I mistakenly assumed was because of the cards getting scarce.

Anyways, it shows the aacraid doesn't need GFP_DMA32 at all, which
is good.

I hope there are no other concerns about the patch and Linus 
could just merge it now? 

-Andi

