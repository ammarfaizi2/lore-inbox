Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263512AbTJLTfe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 15:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263515AbTJLTfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 15:35:34 -0400
Received: from holomorphy.com ([66.224.33.161]:9603 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263512AbTJLTfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 15:35:33 -0400
Date: Sun, 12 Oct 2003 12:38:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] invalidate_mmap_range() misses remap_file_pages()-affected targets
Message-ID: <20031012193841.GA16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20031012084842.GB765@holomorphy.com> <20031012045332.4a8ac459.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031012045332.4a8ac459.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 04:53:32AM -0700, Andrew Morton wrote:
> I was going to just not bother about this wart.  After all, we get to write
> the standard on remap_file_pages(), and we can say "the
> truncate-causes-SIGBUS thing doesn't work".  After all, it is not very
> useful.
> But I wonder if this effect could be used maliciously.  Say, user A has
> read-only access to user B's file, and uses that access to set up a
> nonlinear mapping thereby causing user B's truncate to not behave
> correctly.  But this example is OK, isn't it?  User A will just receive an
> anonymous page for his troubles.
> Can you think of any stability or security scenario which says that we
> _should_ implement the conventional truncate behaviour?

At some point we burned a bit of effort to ensure we wiped all the ptes
and all the faulting looped until we finished when we vmtruncate();
not handling is a loophole in that, and if anything assumes it won't
find vmtruncate()'s orphans in-kernel, it will break. Apart from that
it's not so large an issue. I'm not so much attached to coddling
userspace (remap_file_pages() users should not be naive) as to shoring
up invalidate_mmap_range() with its intent (unmapping file offset ranges
instead of virtualspace ranges). Someone else might scream later.

Also, tlb_remove_tlb_entry()'s ordering with ptep_get_and_clear() seems
to be handled on ppc* by not having ptep_get_and_clear() fully clear the
pte, which is disturbing, but a sign ppc* maintainers already handle it.


-- wli
