Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVC2WDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVC2WDg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVC2WDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:03:36 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:21784 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261512AbVC2WDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:03:14 -0500
Date: Tue, 29 Mar 2005 23:03:02 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
In-Reply-To: <20050324122637.GK895@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0503292233080.18131@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> 
    <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com> 
    <20050324122637.GK895@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005, Andi Kleen wrote:
> On Wed, Mar 23, 2005 at 05:11:34PM +0000, Hugh Dickins wrote:
> 
> Sorry for late answer.

Ditto!  Sorry, I've been away a few days.

> Nice approach....

Thanks.

> It will not work as well
> on large sparse mappings as the bit vectors, but that may be tolerable.

Exactly.  It's simply what what we should be doing first, making use of
the infrastructure we already have.  If that proves inadequate, add on top.

> > What of x86_64's 32bit vdso page __map_syscall32 maps outside any vma?
> 
> Everything. It could be easily changed though, but I was too lazy for 
> it so far. Do you think it is needed for your patch?

I do.  I'll resend you an earlier mail I wrote about it, I think x86_64
is liable to leak pagetables or conversely rip pagetables out from under
the vsyscall page - in the 32-bit emulation case, with my patches, if
that vsyscall page has been mapped.  That it'll be fine or unnoticed
most of the time, but really not right.

I'll also resend you Ben's mail on the subject, what he does on ppc64.

Ah, you do SetPageReserved on that page.  That's good, rmap would have
a problem with it, since it doesn't belong to a file, yet is shared
between all tasks, so is quite unlike an anonymous page.  I suggest
you make the vma VM_RESERVED too, but that doesn't really matter yet.

Hugh
