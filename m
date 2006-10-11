Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030407AbWJKBSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030407AbWJKBSz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 21:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWJKBSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 21:18:55 -0400
Received: from ozlabs.org ([203.10.76.45]:52393 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030407AbWJKBSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 21:18:54 -0400
Date: Wed, 11 Oct 2006 11:18:16 +1000
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Hugh Dickins'" <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepage regression
Message-ID: <20061011011816.GA21235@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Hugh Dickins' <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0610101958270.21452@blonde.wat.veritas.com> <000301c6ecc4$a83af8a0$cb34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301c6ecc4$a83af8a0$cb34030a@amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 04:34:40PM -0700, Chen, Kenneth W wrote:
> Hugh Dickins wrote on Tuesday, October 10, 2006 12:18 PM
> > Yes, I'd expect your i_mmap_lock to solve the problem: and since
> > you're headed in that direction anyway, it makes most sense to use
> > that solution rather than get into defining arrays, or sacrificing
> > the lazy flush, or risking page_count races.
> > 
> > So please extract the __unmap_hugepage_range mods from your shared
> > pagetable patch, and use that to fix the bug.
> 
> 
> OK, here is a bug fix patch fixing earlier "bug fix" patch :-(
> 
> 
> [patch] hugetlb: fix linked list corruption in unmap_hugepage_range
> 
> commit fe1668ae5bf0145014c71797febd9ad5670d5d05 causes kernel to oops with
> libhugetlbfs test suite.  The problem is that hugetlb pages can be shared
> by multiple mappings. Multiple threads can fight over page->lru in the unmap
> path and bad things happen.  We now serialize __unmap_hugepage_range to void
> concurrent linked list manipulation.  Such serialization is also needed for
> shared page table page on hugetlb area. This patch will fixed the bug and
> also serve as a prepatch for shared page table.

Can I suggest that you put a big comment on the linked list
declaration itself saying that you're relying on serialization here.
Otherwise I'm worried someone will try to de-serialize it again, and
break it without realizing.  Given the number of people who failed to
spot the problem with the patch the first time around..

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
