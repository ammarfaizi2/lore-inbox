Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263242AbUCNBTi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 20:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbUCNBTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 20:19:37 -0500
Received: from holomorphy.com ([207.189.100.168]:51979 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263242AbUCNBTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 20:19:33 -0500
Date: Sat, 13 Mar 2004 17:19:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
Message-ID: <20040314011920.GG655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Rajesh Venkatasubramanian <vrajesh@umich.edu>,
	linux-kernel@vger.kernel.org
References: <20040314010108.GF655@holomorphy.com> <Pine.LNX.4.44.0403132005410.15971-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403132005410.15971-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2004, William Lee Irwin III wrote:
>> find_vma() is often necessary to determine whether the page is mlock()'d.

On Sat, Mar 13, 2004 at 08:07:52PM -0500, Rik van Riel wrote:
> Alternatively, the mlock()d pages shouldn't appear on the LRU
> at all, reusing one of the variables inside page->lru as a
> counter to keep track of exactly how many times this page is
> mlock()d.

That would be the rare case where it's not necessary. =)

On Sat, 13 Mar 2004, William Lee Irwin III wrote:
>> In schemes where mm's that may not map the page appear in searches,
>> it may also be necessary to determine if there's even a vma covering the
>> area at all or otherwise a normal vma, since pagetables outside normal
>> vmas may very well not be understood by the core (e.g. hugetlb).

On Sat, Mar 13, 2004 at 08:07:52PM -0500, Rik van Riel wrote:
> If the page is a normal page on the LRU, I suspect we don't
> need to find the VMA, with the exception of mlock()d pages...
> Good thing Christoph was already looking at the mlock()d page
> counter idea.

That's not quite where the issue happens. Suppose you have a COW
sharing group (called variously struct anonmm, struct anon, and so on
by various codebases) where a page you're trying to unmap occurs at
some virtual address in several of them, but others may have hugetlb
vmas where that page is otherwise expected. On i386 and potentially
others, the core may not understand present pmd's that are not mere
pointers to ptes and other machine-dependent hugetlb constructs, so
there is trouble. Searching the COW sharing group isn't how everything
works, but in those cases where additionally you can find mm's that
don't map the page at that virtual address and may have different vmas
cover it, this can arise.


-- wli
