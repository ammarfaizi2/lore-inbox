Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVA1OP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVA1OP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVA1OP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:15:29 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:7119 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261400AbVA1OPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:15:09 -0500
Date: Fri, 28 Jan 2005 14:14:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Rik van Riel <riel@redhat.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <Pine.LNX.4.61.0501280801070.24304@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.61.0501281348110.6922@goblin.wat.veritas.com>
References: <20050127050927.GR10843@holomorphy.com> 
    <16888.46184.52179.812873@alkaid.it.uu.se> 
    <20050127125254.GZ10843@holomorphy.com> 
    <20050127142500.A775@flint.arm.linux.org.uk> 
    <20050127151211.GB10843@holomorphy.com> 
    <Pine.LNX.4.61.0501271420070.13927@chimarrao.boston.redhat.com> 
    <20050127204455.GM10843@holomorphy.com> 
    <Pine.LNX.4.61.0501271557300.13927@chimarrao.boston.redhat.com> 
    <20050127211319.GN10843@holomorphy.com> 
    <Pine.LNX.4.61.0501271626460.13927@chimarrao.boston.redhat.com> 
    <20050128053036.GO10843@holomorphy.com> 
    <Pine.LNX.4.61.0501280801070.24304@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005, Rik van Riel wrote:
> On Thu, 27 Jan 2005, William Lee Irwin III wrote:
> 
> > You seem to be on about something else, e.g. only forbidding the vma
> > allocator to return a vma starting at 0 when not specifically requested.
> > In that case vma->vm_start < mm->brk and similar are all fine.
> 
> Yes.

Prohibiting "addr < mm->brk" (unless FIXED) seems arbitrary policy to me,
and at variance with the comment "would break NULL pointer detection".
Why have you chosen to prohibit all that rather than just "!addr"?
(Other than to stoke up this controversy you expect ;)

But I have to admit that it's much less arbitrary policy than the
TASK_UNMAPPED_BASE used when going bottom up - I much prefer your
your mm->brk test to that.

I had imagined that top down (non-FIXED) would continue to make
more space available, the space below the text, just cutting off
at PAGE_SIZE.  There was a more serious lower limit on ARM under
discussion before, but ARM doesn't use top down so far as I can see.

Perhaps you're coming from experience of various buggy apps
that get into difficulties if mmaps are found below mm->brk?
I'm not sure that we should be cutting others' address space to
make life easier for those, they should be ADDR_COMPAT_LAYOUT.
Part (all?) of the point of topdown was to make more address
space available, wasn't it?

arch/ppc64/mm/hugetlbpage.c (odd place to find it) has its own
arch_get_unmapped_area_topdown, should be given a similar fix.

Hugh
