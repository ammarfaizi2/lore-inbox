Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266750AbUFRTDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266750AbUFRTDR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266754AbUFRS6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:58:20 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:7019 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266487AbUFRS4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:56:08 -0400
Date: Fri, 18 Jun 2004 19:55:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: anon-vma mprotect merging-extend fix
In-Reply-To: <20040618015903.GA2797@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0406181953260.26377-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Andrea Arcangeli wrote:
> yesterday I got a crash bugreport where this BUG_ON bombed with wine.
>.... 
> The problem is that I was not propagating the anon_vma correctly in the
> extend case of mprotect-merging.

Thanks a lot for this alert, Andrea, much appreciated.

Although the 2.6.7 code looks rather different here (vma_merge now does
all mprotect's merging too), and there's a couple of reasons it's harder
to see the problem with mainline (because fork's copy_page_range uses the
quick page_dup_rmap inline, skipping the BUG_ONs in page_add_anon_rmap;
and because anon_vma_prepare is likely to correct the situation by taking
anon_vma from neighbouring vma later), I missed exactly the same point
and we do indeed need a patch for it.

> This adds another robustness BUG_ON to be sure we switch the PG_anon
> bitflag only in unmapped pages, and secondly it makes sure not to merge
> anything if vm_private_data is set on the "other" vma (the one not
> checked internally in is_mergeable_vma). I considered adding another
> parameter to is_mergeable_vma, but I think the above is fine too, such
> construct can be copied as easily without forgetting about the "other"
> vma private_data.

I hope you've not found somewhere the vm_private_data change is actually
needed - because when using that field for the non-linear swapout cursor,
the test in is_mergeable_vma prevented non-linear merges, it seemed a
superfluous test to me, and so I simply removed it.  I say superfluous
because those few vmas which set vm_private_data are already prevented
from merging by VM_SPECIAL flags tests.

> I didn't have much time to look at the status of mainline in the last
> week, I assume Hugh will take care of merging this fix in a way that
> will apply cleanly to mainline.

That's fine, yes, I've now done the patch, will post it separately now.

Thanks again,
Hugh

