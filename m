Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbUKWRpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbUKWRpU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbUKWRoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:44:38 -0500
Received: from holomorphy.com ([207.189.100.168]:9638 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261397AbUKWRLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:11:03 -0500
Date: Tue, 23 Nov 2004 09:10:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       gerg@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compound page overhaul
Message-ID: <20041123171039.GK2714@holomorphy.com>
References: <20041122155434.758c6fff.akpm@osdl.org> <11948.1101130077@redhat.com> <29356.1101201515@redhat.com> <20041123081129.3e0121fd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123081129.3e0121fd.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>> It's nothing at all to do with MMU vs !MMU.

On Tue, Nov 23, 2004 at 08:11:29AM -0800, Andrew Morton wrote:
> In that case I just dunno what's going on now.
> I thought we were discussing the removal of this, from __free_pages_ok():
> #ifndef CONFIG_MMU
> 	if (order > 0)
> 		for (i = 1 ; i < (1 << order) ; ++i)
> 			__put_page(page + i);
> #endif
> by using compound page's refcounting logic instead.  But !MMU really wants
> to treat that higher-order page as an array of zero-order pages, and that
> requires the usual usage of the fields of page[1], page[2], etc.
> So what I'm saying is "compound pages are designed for treating a
> higher-order page as a higher-order page.  !MMU wants to treat a higher
> order page as an array of zero-order pages.  Hence give up and stick with
> the current code".
> What are you saying?

The way I interpreted this is something like:

The usual way this goes (as I've seen it elsewhere) is that some fields
are "base page properties", so each struct page in the subarray of
mem_map the higher-order page represents can have some different,
meaningful value for the field, and so on. Others are "superpage
properties", which refer to the head of the higher-order page.

The MMU-less code appears to assume the refcounts of the tail pages
will remain balanced, and elevates them to avoid the obvious disaster.
But this looks rather broken barring some rather unlikely invariants. I
presume the patch is backing that out so refcounting works properly, or
in the nomenclature above (for which there is a precedent) makes the
refcount a superpage property uniformly across MMU and MMU-less cases.

It's unclear (to me) how the current MMU-less code works properly, at
the very least. It would appear to leak memory since there is no
obvious guarantee the reference to the head page will be dropped when
needed, though things may have intended to free the various tail pages.

i.e. AFAICT things really need to acquire and release references on the
whole higher-order page as a unit for refcounting to actually work,
regardless of MMU or no.

It may also be helpful for Greg Ungerer to help review these patches,
as he appears to represent some of the other MMU-less concerns, and
may have more concrete notions of how things behave in the MMU-less
case than I myself do (hardware tends to resolve these issues, but
that's not always feasible; perhaps an MMU-less port of a "normal"
architecture would be enlightening to those otherwise unable to
directly observe MMU-less behavior). In particular, correcting what
misinterpretations in the above there may be.


-- wli
