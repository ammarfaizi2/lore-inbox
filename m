Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264914AbUFRBAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264914AbUFRBAP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 21:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUFRBAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 21:00:14 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:59816 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264898AbUFRBAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 21:00:02 -0400
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Proposal for new generic device API: dma_get_required_mask()
References: <1087481331.2210.27.camel@mulgrave>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 18 Jun 2004 02:46:46 +0200
In-Reply-To: <1087481331.2210.27.camel@mulgrave> (James Bottomley's message
 of "17 Jun 2004 09:08:51 -0500")
Message-ID: <m33c4tsnex.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@steeleye.com> writes:

> If the driver decides to use the mask, it would do another
> dma_set_mask() to confirm it (this gives the platform the opportunity if
> it so chooses to return a mask that doesn't quite cover memory, but
> would be more optimal...say for platforms that have all memory under 4GB
> bar one small chunk at 64GB or something).

What I think drivers such as AIC7xxx should do is:

#define OUR_COST_32 = 4
#define OUR_COST_39 = 8
#define OUR_COST_64 = 10

int cost32 = check_dma_mask(32 bits);
int cost39 = check_dma_mask(39 bits);
int cost64 = check_dma_mask(64 bits);

if (!cost32  && !cost39 && !cost64)
	printk(KERN_ERR "64 bits aren't enough for RAM addressing?\n")
else
	use_mode_with_minimal_cost(cost32 * OUR_COST_32,
				   cost39 * OUR_COST_39,
				   cost64 * OUR_COST_64);

This check_dma_mask() should be renamed + extended to cover different
RAM access types:
- coherent vs non-coherent memory
- preallocated/initialized memory (such as skb->data passed to
  hard_start_xmit()) vs uninitialized memory (such as returned by
  kmalloc()).

The "cost" is needed for cases where both the host and the device can
support many addressing modes, such as with AIC7xxx, > 4GB of RAM
and (costly) IO MMU or bounce buffers.


Currently, set_dma_mask(less than 32 bits) can return success but then
the mapping functions can return addresses which don't fit in the
requested number of bits. In fact set_dma_mask() has any meaning
only to *alloc functions. The statement "pci_set_consistent_dma_mask()
will always be able to set the same or a smaller mask as
pci_set_dma_mask()" doesn't make IMHO sense.


If we fix the API we should IMHO also remove set_dma_mask() and add
the number of address bits to the arguments of actual mapping
functions. It would make it possible to use different masks for
different tasks, I'm told there is hardware which can benefit from it.
Done correctly it wouldn't have any runtime overhead.

I would also change the "u64 mask" into plain number of bits.
It would be easier for people, cpp, gcc and CPU.
-- 
Krzysztof Halasa, B*FH
