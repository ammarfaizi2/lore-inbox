Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUDAQ6c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbUDAQ5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:57:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60112 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262961AbUDAQ5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:57:30 -0500
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040401161949.GC25502@mail.shareable.org>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com>
	 <Pine.LNX.4.58.0403311433240.1116@ppc970.osdl.org>
	 <1080776487.1991.113.camel@sisko.scot.redhat.com>
	 <Pine.LNX.4.58.0403311550040.1116@ppc970.osdl.org>
	 <1080834032.2626.94.camel@sisko.scot.redhat.com>
	 <20040401161949.GC25502@mail.shareable.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1080838642.2626.139.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Apr 2004 17:57:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-04-01 at 17:19, Jamie Lokier wrote:
> Stephen C. Tweedie wrote:
> > Yes, but we _used_ to have that choice --- call msync() with flags == 0,
> > and you'd get the deferred kupdated writeback;
> 
> Is that not equivalent to MS_INVALIDATE?  It seems to be equivalent in
> 2.6.4.

It is in all the kernels I've looked at, but that's mainly because we
seem to ignore MS_INVALIDATE.

> Some documentation I'm looking at says MS_INVALIDATE updates the
> mapped page to contain the current contents of the file.  2.6.4 seems
> to do the reverse: update the file to contain the current content of
> the mapped page.  "man msync" agrees with the the latter.  (I can't
> look at SUS right now).

SUSv3 says

        When MS_INVALIDATE is specified, msync() shall invalidate all
        cached copies of mapped data that are inconsistent with the
        permanent storage locations such that subsequent references
        shall obtain data that was consistent with the permanent storage
        locations sometime between the call to msync() and the first
        subsequent memory reference to the data.
        
which seems to imply that dirty ptes should simply be cleared, rather
than propagated to the page dirty bits.

That's easy enough --- we already propagate the flags down to
filemap_sync_pte, where the page and pte dirty bits are modified.  Does
anyone know any reason why we don't do MS_INVALIDATE there already?

--Stephen


