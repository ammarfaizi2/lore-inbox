Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264844AbTIDULv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264845AbTIDULv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:11:51 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:62348 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264844AbTIDULt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:11:49 -0400
Date: Thu, 4 Sep 2003 21:11:33 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch
Message-ID: <20030904201133.GC31590@mail.jlokier.co.uk>
References: <20030904175939.GD30394@mail.jlokier.co.uk> <Pine.LNX.4.44.0309041924070.4300-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309041924070.4300-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> > I don't see why you can't clear the flag: the call to ->populate will
> > change every page and pte_file to correspond with the linear page
> > offsets, which is all that !VM_NONLINEAR indicates.
> 
> You're assuming that one call to sys_remap_file_pages precisely populates
> a whole vma: no, it's quite likely it'll just do a single page of the vma.

What are you talking about?  The condition for clearing VM_NONLINEAR
is an explicit check to see if the range to be populated covers the
whole vma.

> > The important things are that the futex is queued prior to checking
> > curval, the requested page won't change (it's protected by mmap_sem),
> > and any parallel waker changes the word prior to waking us.
> 
> Ah, that may well be so, it's beyond me,
> just so long as Rusty is happy with it.

If that condition isn't enough, then async futexes are in trouble,
because the curval check equivalent is done in userspace for async
futexes...

> (I don't think you mean "the requested page won't change" - the
> down_read on mmap_sem does not prevent it from being swapped out
> before the get_user, but nor does it prevent a replacement page
> being faulted back in by get_user, and we no longer have any
> dependence on those being the same physical page.)

I mean it prevents the futex key corresponding to the userspace word
from changing before we read the word.  For all reasonable uses this
doesn't matter anyway.

-- Jamie
