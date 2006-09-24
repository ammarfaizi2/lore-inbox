Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752093AbWIXHTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbWIXHTg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 03:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbWIXHTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 03:19:36 -0400
Received: from ns2.suse.de ([195.135.220.15]:40588 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752093AbWIXHTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 03:19:35 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: More thoughts on getting rid of ZONE_DMA
Date: Sun, 24 Sep 2006 09:19:28 +0200
User-Agent: KMail/1.9.1
Cc: Martin Bligh <mbligh@mbligh.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com> <200609230134.45355.ak@suse.de> <Pine.LNX.4.64.0609231907360.16435@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609231907360.16435@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609240919.29154.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 September 2006 04:13, Christoph Lameter wrote:
> On Sat, 23 Sep 2006, Andi Kleen wrote:
> > The problem is that if someone has a workload with lots of pinned pages
> > (e.g. lots of mlock) then the first 16MB might fill up completely and
> > there is no chance at all to free it because it's pinned
>
> Note that mlock'ed pages are movable. mlock only specifies that pages
> must stay in memory. It does not say that they cannot be moved. So
> page migration could help there.

There are still other cases where it is not the case. e.g. long term 
pinned IO. Or kernel workloads that allocate unfreeable objects.
Not doing any reservation would just seem risky and fragile to me.

Also I'm not sure we want to have the quite large page migration code in small
i386 kernels.

I think what would be a good short term idea would be to remove ZONE_DMA
from the normal zone lists. Possible even allocate its metadata somewhere 
else to give the cache advantages you were looking for.

Then make its size configurable and only
allow allocating from it using some variant of your range allocator
via dma_alloc_*(). Actually in this case it might be better to write
a new specialized small allocator that is more optimized for the "range" task
than buddy. Buta brute force version of buddy would
likely work too, at least short term.

Then if that works swiotlb could be converted over to use it too. Once
there is such a allocator there is really no reason it still needs a separate
pool. Ok it is effectively GFP_ATOMIC so perhaps the thresholds for keeping
free memory for atomic purposes would need to be a little more aggressive
on the DMA pool.

In terms of memory consumption it should be similar as now because
the current VM usually keeps ZONE_DMA free too. But with a configurable
size it might make more people happy (both those for which
16MB is too much and for those where 16MB is too little). Although
to be honest the 16MB default seems to work for most people anyways,
so it's not really a very urgently needed change.

But this would require getting rid of all GFP_DMA users first
and converting them over the dma_alloc_*. Unfortunately
there are still quite a few left.

$ grep -r GFP_DMA drivers/* | wc -l
148

Anyone volunteering for auditing and fixing them?

Most drivers are probably relatively easy (except that testing 
them might be difficult), but there are cases where it is used 
in the block layer for generic allocations and finding everyone who 
relies on that might be nasty.

Most of the culprits are likely CONFIG_ISA so they don't matter
for x86-64, but i386 unfortunately still needs to support that .

I suppose it would be also a good opportunity to get rid of some
really old broken drivers. e.g. supporting ISA doesn't need to mean
still keeping drivers that haven't compiled for years.

-Andi

