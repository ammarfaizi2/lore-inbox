Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVC3PIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVC3PIS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 10:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVC3PIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 10:08:18 -0500
Received: from ns2.suse.de ([195.135.220.15]:31929 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262012AbVC3PIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 10:08:16 -0500
Date: Wed, 30 Mar 2005 17:08:13 +0200
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       akpm@osdl.org, davem@davemloft.net, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] freepgt: free_pgtables use vma list
Message-ID: <20050330150813.GF28472@wotan.suse.de>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <Pine.LNX.4.61.0503231710310.15274@goblin.wat.veritas.com> <20050324122637.GK895@wotan.suse.de> <Pine.LNX.4.61.0503292233080.18131@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503292233080.18131@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 11:03:02PM +0100, Hugh Dickins wrote:
> 
> > Nice approach....
> 
> Thanks.
> 
> > It will not work as well
> > on large sparse mappings as the bit vectors, but that may be tolerable.
> 
> Exactly.  It's simply what what we should be doing first, making use of
> the infrastructure we already have.  If that proves inadequate, add on top.

Ok. I will defer the bitvector patch now. 

I had it mostly working with hacks, but than I ran into
a nasty include ordering problem that scared me off so far.

> I do.  I'll resend you an earlier mail I wrote about it, I think x86_64
> is liable to leak pagetables or conversely rip pagetables out from under
> the vsyscall page - in the 32-bit emulation case, with my patches, if
> that vsyscall page has been mapped.  That it'll be fine or unnoticed
> most of the time, but really not right.
> 
> I'll also resend you Ben's mail on the subject, what he does on ppc64.

Thanks.
> 
> Ah, you do SetPageReserved on that page.  That's good, rmap would have
> a problem with it, since it doesn't belong to a file, yet is shared
> between all tasks, so is quite unlike an anonymous page.  I suggest
> you make the vma VM_RESERVED too, but that doesn't really matter yet.

Ok. I will change it to a VMA.

Only bad thing is that this has to be done at program startup.
At fault time we cannot upgrade the read lock on mmap sem to a write
lock that is needed to insert the VMA :/ But I guess that is ok
because with modern glibc basically all programs will use vsyscsall.

-Andi
