Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbUDSPB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbUDSPBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:01:55 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:46731 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264493AbUDSPBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:01:42 -0400
Date: Mon, 19 Apr 2004 16:01:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jamie Lokier <jamie@shareable.org>
cc: Ingo Molnar <mingo@redhat.com>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Non-linear mappings and truncate/madvise(MADV_DONTNEED)
In-Reply-To: <20040419133240.GA14482@mail.shareable.org>
Message-ID: <Pine.LNX.4.44.0404191548030.24243-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004, Jamie Lokier wrote:
> A couple of thoughts on non-linear mappings.  Vanilla 2.6.5.
> 
> I'm reading madvise_dontneed() and thinking about that zap_page_range()
> call.  It'll wipe non-linear file offset ptes, won't it?

Yes, at present.

> MADV_DONTNEED is actually a reasonable thing to do with a non-linear
> mapping, when you no longer need some of the pages.  You could argue
> that losing the offsets is acceptable in this case, but I think it's a
> poor argument.  The offsets should be preserved while zapping the ptes.

Yes.  And I think it also implies that the ->populate functions
are wrong to fail beyond EOF, should just set up file ptes there.

> Then there's vmtruncate() and invalidate_mmap_range() which calls
> zap_page_range().  When you call truncate(), the non-linear offsets
> appear to be lost (I'm reading the code, not testing it) for the part
> of each VMA corresponding to where the linear mapping would have been.
> 
> That means (a) a peculiar part of the mapping is lost, and (b) some of
> the truncated pages will stay mapped, if they're in a part of a VMA
> which didn't get wiped by the linear calculation.
> 
> Do any of the latest objrmap patches fix these problems?  Have I
> misdiagnosed these problems?

rmap 6 nonlinear truncation (which never appeared on LKML, though
sent twice) fixed most of this, and went into 2.6.6-rc1-bk4 last
night: please check it out.

But I just converted madvise_dontneed by rote, adding a NULL arg to
zap_page_range, missing your point that it should respect nonlinearity.

And I made the zap_details structure private to mm/memory.c since I
hadn't noticed anything outside needing it: I'll fix that up later
and post a patch.

I'm haven't and don't intend to change the behaviour of ->populate,
without agreement from others - Ingo? Jamie?

Hugh

