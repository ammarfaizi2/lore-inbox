Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVBVWKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVBVWKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 17:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVBVWKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 17:10:39 -0500
Received: from mail.shareable.org ([81.29.64.88]:21672 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261297AbVBVWJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 17:09:17 -0500
Date: Tue, 22 Feb 2005 22:09:00 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Olof Johansson <olof@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050222220900.GJ22555@mail.shareable.org>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> <20050222211938.GB7079@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222211938.GB7079@austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson wrote:
> > That won't work because the vma lock must be help between key
> > calculation and get_user() - otherwise futex is not reliable.  It
> > would work if the futex key calculation was inside the loop.
> 
> Sure, but that's still true: It's just that the get_user() is done twice
> instead. The semaphore is never released between the key calculation and
> the "real" get_user().

Ah, I didn't look at where the loop is used and didn't think there'd
be _two_ get_user() calls in the fast case.  Not my instinct.

> > A much simpler solution (and sorry for not offering it earlier,
> > because Andrew Morton pointed out this bug long ago, but I was busy), is:
> 
> Either way works for me. Andrew/Linus, got a preference? I'll either
> post my refresh based on Andrews comments, or code up Jamie's
> suggestion.

Yours has a couple of problems.

   1. It'll make futex waits somewhat slower.  One of the nicer features
      of 2.6 futexes is that we got rid of the explicit page table lookup.

   2. It's broken because a page can be paged out by another thread
      after you've forced it in and before the get_user().  We only
      take mmap_sem, not the page table lock.

-- Jamie
