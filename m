Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWGMALf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWGMALf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 20:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWGMALf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 20:11:35 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:1549 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751404AbWGMALe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 20:11:34 -0400
To: Ralph Campbell <ralphc@pathscale.com>
Cc: Roland Dreier <rolandd@cisco.com>,
       openib-general <openib-general@openib.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Suggestions for how to remove bus_to_virt()
X-Message-Flag: Warning: May contain useful information
References: <1152746967.4572.263.camel@brick.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 12 Jul 2006 17:11:26 -0700
In-Reply-To: <1152746967.4572.263.camel@brick.pathscale.com> (Ralph Campbell's message of "Wed, 12 Jul 2006 16:29:27 -0700")
Message-ID: <adar70quzwx.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Jul 2006 00:11:28.0384 (UTC) FILETIME=[E2F21000:01C6A610]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > One solution is to change the IB device driver interface so that
 > kernel virtual addresses are passed to the IB device driver and
 > the device driver is responsible for calling dma_map_single(), etc.
 > I believe this will be unacceptable to the OpenFabrics community

Actually it's worse than unacceptable -- I don't see how this can work
at all.  The problem is that addresses are not just passed directly to
the local HCA; they also might be embedded in protocol messages that
are sent to a remote HCA and then used by the remote HCA to initiate
RDMA.

For example, the SRP driver uses ib_get_dma_mr() to get an R_Key,
which it then sends to the target along with a DMA address.  The
target uses that R_Key/address to RDMA data directly to or from the
host.  There's no good way for the low-level driver to handle the DMA
mapping, since the address is embedded in a protocol message that the
low-level driver knows nothing about.

 > Another solution is to change the IB device driver interface to add
 > a function which tells the caller what type of addresses the device
 > expects.  Kernel modules would then be required to pass either a
 > dma_map_xxx() address or a kernel virtual address based on the
 > driver's preference.
 > The current set of IB consumers either start with kmalloc/vmalloc
 > memory (such as the MAD layer) or a list of physical pages
 > (such as ISER and SRP). The current code could therefore be
 > fairly easily changed except for ISER/SRP when a struct page
 > doesn't have a direct kernel address (high pages) and would
 > need to call kmap()/kunmap() in that case.

I have a few problems with this: first, it's unfortunate that every
consumer needs two code paths to handle the two possibilities; second,
I don't see how it handles the case of SRP's use of the
ib_get_dma_mr() R_Key as above anyway; third, expecting consumers to
kmap pages for a long time across work request execution is a bad
idea.

Maybe the least bad solution would be to add rdma_XXX wrappers around
the dma mapping functions that RDMA consumers use; then most low-level
drivers could just pass them through to the DMA mapping API, while the
ipath driver could handle things itself.

The problem with that is that it ends up wrapping a huge API -- for
example, you need both dma_map_single and dma_map_sg at least, plus
someone might want to use dma_alloc_coherent memory, not to mention
the dma_pool stuff, etc.

A cleaner solution would be to make the dma_ API really use the device
it's passed anyway, and allow drivers to override the standard PCI
stuff nicely.  But that would be major surgery, I guess.

(BTW, vmalloc memory should not be used for DMA, since it's not
guaranteed to be DMA-able -- so anyone doing that is just wrong)

 - R.
