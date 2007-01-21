Return-Path: <linux-kernel-owner+w=401wt.eu-S1751296AbXAUJ4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbXAUJ4i (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 04:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbXAUJ4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 04:56:38 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:63616 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbXAUJ4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 04:56:37 -0500
X-AuditID: d80ac21c-a0478bb00000330a-88-45b338d43a84 
Date: Sun, 21 Jan 2007 09:56:48 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Franck Bui-Huu <fbuihuu@gmail.com>
cc: Nadia Derbey <Nadia.Derbey@bull.net>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: unable to mmap /dev/kmem
In-Reply-To: <61ec3ea90701200919kd6593bdl8dcd47824ed03f49@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701210914340.28234@blonde.wat.veritas.com>
References: <45AFA490.5000508@bull.net>  <Pine.LNX.4.64.0701181743340.25435@blonde.wat.veritas.com>
  <61ec3ea90701190331y459ad373n21a610157df03282@mail.gmail.com> 
 <Pine.LNX.4.64.0701191634070.6398@blonde.wat.veritas.com>
 <61ec3ea90701200919kd6593bdl8dcd47824ed03f49@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Jan 2007 09:56:36.0483 (UTC) FILETIME=[7050D530:01C73D42]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2007, Franck Bui-Huu wrote:
> On 1/19/07, Hugh Dickins <hugh@veritas.com> wrote:
> 
> That said, it's really confusing to pass a virtual address as an
> offset because:
> 
>    (a) mmap() has always worked with offset not addresses;

mmap maps some offset down a backing object to some virtual address
in userspace, for some length.  When the backing object is itself
memory, what would you use for the offset down that backing object?
For physical memory (/dev/mem), physical address; for virtual
memory (/dev/kmem), virtual address.

>    (b) the kernel will treat this virtual address as an offset
>        until kmem driver convert it back to a virtual
>        address. And it seems that during this convertion the
>        lowest bits of the virtual address will be lost...

mmap always demands PAGE_SIZE alignment of offset and address.
Or is it not those lowest (12 on i386) bits you're referring to
as lost?  If you're expecting mmap to map kernel memory at the
same addresses as kernel memory... well, that's already done
without mmap!  but not much help towards getting a userspace
mapping of kernel memory.

> Maybe read/write behaviours should be changed to use the offset as an
> offset and not as a virtual address.

They do already use the offset as an offset; so I imagine you're
suggesting they be changed to work with "offset of virtual address
from PAGE_OFFSET" instead of simple virtual address, to match the
change you made to mmap_kmem in 2.6.19.

Adding further to the confusion and incompatibility between releases,
in a (slightly) more widely used interface than the mmap, for no gain?
No, I don't think so.

> > Have I got it right, that actually the problem you thought you were
> > fixing does not even exist?
> 
> yes, see above.

Thanks for the confirmation.

> > I don't think your PFN_DOWN or virt_to_phys were improvements:
> > though mem.c happens to live in drivers/char/, imagine it under mm/.
> 
> I don't get your point here. Do you mean that virt_to_phys() is only
> meant for drivers ? If so, I would have said that virt_to_phys() is
> prefered once boot memory init is finished...

My point was merely that I'd much rather ask Linus (when he's back)
for a straight revert of your patch, than mess around with including
your change from __pa to virt_to_phys: that even if we prefer general
drivers to say virt_to_phys than __pa, drivers/char/mem.c is a special
case intimately bound up with mm and can be granted its present exemption.

Hugh
