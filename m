Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTJLVQu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 17:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbTJLVQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 17:16:50 -0400
Received: from holomorphy.com ([66.224.33.161]:32643 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262868AbTJLVQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 17:16:49 -0400
Date: Sun, 12 Oct 2003 14:19:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC] invalidate_mmap_range() misses remap_file_pages()-affected targets
Message-ID: <20031012211956.GD16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20031012084842.GB765@holomorphy.com> <Pine.LNX.4.44.0310121626260.31963-100000@cluless.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310121626260.31963-100000@cluless.boston.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Oct 2003, William Lee Irwin III wrote:
>> invalidate_mmap_range(), and hence vmtruncate(), can miss its targets
>> due to remap_file_pages()

On Sun, Oct 12, 2003 at 04:28:09PM -0400, Rik van Riel wrote:
> Please don't.   Remap_file_pages() not 100% working the way
> a normal mmap() works should be a case of "doctor, it hurts".
> Making the VM more complex just to support the (allegedly
> low overhead) hack of remap_file_pages() doesn't seem like
> a worthwhile tradeoff to me.
> In fact, I wouldn't mind if remap_file_pages() was simplified ;)

I'm far less concerned about userspace shooting itself in the foot
than I am the kernel.

At some point a decision was made to at least try to prevent orphaned
pages arising from vmtruncate() vs. ->nopage(), with some userspace
semantic motive I'm not concerned about, and to mitigate or possibly
eliminate the need to handle the orphaned pages in-kernel, which is my
concern. This tries to finish getting rid of Morton pages.

The only complexity to be concerned about here is algorithmic; a hotly
contended lock is taken in the VM_NONLINEAR setting, and the pagetable
scan to find pages at vm_pgoff-unaligned ptes is an exhaustive search.
The algorithm itself is a trivial derivative of zap_page_range() that
just checks page->index before unmapping pages and is no cause for
concern with respect to complexity of implementation.

I appreciate the desire for simplicity in general, but walking
pagetables when needed isn't complex, especially with such a large
cut and paste component. The proper interpretation of this is as an
attempt to complete the simplification of eliminating Morton pages.


-- wli

(Prior to the attempt that was merged, there was a tradeoff between
best effort search for the ptes and just deliberately letting Morton
pages happen. Since it was merged, it's become a core kernel semantic
question: i.e. is the vmtruncate() atomicity solely for the benefit of
"naive userspace", or is it a new kernel invariant? I tend to favor
consistency, but it's ultimately arbitrary, hence [RFC].)
